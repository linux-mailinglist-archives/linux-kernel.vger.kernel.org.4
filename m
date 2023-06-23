Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E073B212
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFWHsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjFWHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:48:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA621BE2;
        Fri, 23 Jun 2023 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687506519; x=1719042519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iX6DkmUl4cz2IjtF1PHE1fVSnIeq15AXAzNyDDfvQOQ=;
  b=VdmjDVMZOhL4Lm1fbLmRaI1RYGNq4dp5MFBfrkLUBeDfCGnRIfPsgvVs
   w4fW8uEzDjaQVHzcaiwMapglYwY2+WglHLiJQQ8iwtQESW/HFbbm1vQ+A
   yZ60xHb2vIDUWoQQ9Nxmhbz23BijkOfSBis5NMUpvsl71WxGYtxm5FPAO
   0hyJpw5+/0LuPmKthvlJJXNgI5RSywbIDlD6uGa64raORG5b6XhiVECda
   yAmwcLollNhnfyUSLUqtoXm4wS3thuegk4wqzcKdmENt30dLHFhhpado1
   EHUcUTRFz6p+sLr0Ul8VbU34FcWUsdXSKef2FfarQbunWFtxS18+Vq+YI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="341046743"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="341046743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 00:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692588026"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="692588026"
Received: from wtedesch-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.215.233])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 00:48:35 -0700
Date:   Fri, 23 Jun 2023 09:48:31 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-xe@lists.freedesktop.org,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian =?iso-8859-15?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH 3/4] drm/ttm: Don't leak a resource on
 eviction error
Message-ID: <ZJVOTzorVVTvvF2z@ashyti-mobl2.lan>
References: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
 <20230622101412.78426-4-thomas.hellstrom@linux.intel.com>
 <ZJRSyp7fT6VXpow7@ashyti-mobl2.lan>
 <3a089ebb-7389-3d3e-beb0-13a8d64eb04d@linux.intel.com>
 <196a7f74-66ac-1eae-4795-a42691f4793e@amd.com>
 <ef5d91b8-c68b-5edc-d611-6a4dbf55c945@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef5d91b8-c68b-5edc-d611-6a4dbf55c945@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian and Thomas,

> > > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > index 615d30c4262d..89530f2a027f 100644
> > > > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > @@ -462,14 +462,14 @@ static int ttm_bo_evict(struct
> > > > > ttm_buffer_object *bo,
> > > > >       ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
> > > > >       if (ret == -EMULTIHOP) {
> > > > >           ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
> > > > > -        if (ret) {
> > > > > -            if (ret != -ERESTARTSYS && ret != -EINTR)
> > > > > -                pr_err("Buffer eviction failed\n");
> > > > > -            ttm_resource_free(bo, &evict_mem);
> > > > > -            goto out;
> > > > > -        }
> > > > > -        /* try and move to final place now. */
> > > > > -        goto bounce;
> > > > > +        if (!ret)
> > > > > +            /* try and move to final place now. */
> > > > > +            goto bounce;
> > > > As we are at this, can't we replace this with a while()? Goto's
> > > > used instead of a while loop are a fist in the eye...
> > > 
> > > I'm completely OK with that. this patch already did away with one of
> > > them. Let's hear Christian's opinion first, though.
> > 
> > I'm not a fan of that goto either, but could we somehow avoid the
> > while(1) ? E.g. something like do { } while (!ret) after handling the
> > multihop?
> 
> I think the construct that makes it most obvious what's happening, although
> it needs two tests for -EMULTIHOP is something like
> 
> do {
> ....
>    if (ret != -EMULTIHOP)
>       break;
>    ....
> } while (ret ==-EMULTIHOP);

even better :)

Thank you!
Andi
