Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078173DD68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFZLYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFZLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:24:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0AFD;
        Mon, 26 Jun 2023 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687778687; x=1719314687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hbsx9lDG0ObqAYBCH/anLudkyMjn7A+iSFPOx7MPsBM=;
  b=W4srQOuk8xXvEbRDrJOuRMuYPhg/cD6qFcVJYpdiGzY5/Ti0DoRuvUX7
   18Ln+f/MFLuNilLCUBX6i632DLVSR2A+yLS0oVUpobQfmn0f3EfthAB0z
   KvaHLufRcYmkeBZ5uZHINY21wZwp9rrFrAV8Ilv/1MNitf0VNHUSZCrjA
   cJZxxl/PBSGovCjSzg93rIY1KnLMGDOxcOgqej4l5iceMli797VvRyemO
   1Xp/NmxO1d0dZgJEjQQPhT4vfWBPKfW38KxUQ3muCbX2ozYm1zFvXWwfn
   mMnqrramPsEVrwCGgPq93uo+u+6Vk9+B4ABIbkwXuyP8qzP+HM/eMEC9/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="363790146"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="363790146"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 04:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046477310"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="1046477310"
Received: from csteeb-mobl2.ger.corp.intel.com (HELO intel.com) ([10.251.217.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 04:24:41 -0700
Date:   Mon, 26 Jun 2023 13:24:38 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     intel-xe@lists.freedesktop.org,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-15?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2 3/4] drm/ttm: Don't leak a resource on eviction error
Message-ID: <ZJl1dvx311ixwQ3I@ashyti-mobl2.lan>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
 <20230626091450.14757-4-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626091450.14757-4-thomas.hellstrom@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Jun 26, 2023 at 11:14:49AM +0200, Thomas Hellström wrote:
> On eviction errors other than -EMULTIHOP we were leaking a resource.
> Fix.
> 
> v2:
> - Avoid yet another goto (Andi Shyti)
> 
> Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> #v1

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
