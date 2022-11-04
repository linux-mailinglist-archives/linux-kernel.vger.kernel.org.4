Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686961955A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKDL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiKDL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:29:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58672AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667561384; x=1699097384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eXo4mbINpwUv/8iK65/Pz2/8S04AvDk9WaxQmyn2/YU=;
  b=SOJpDBX1H/hjs8wvnndbibHPyYQLKGh8aUH1X5RD0gmKsAAiVhBXjddx
   /35YfdcNlVJmad6J6BaPrMhmOJFrKiVgmkd2cTcDAjDOA9rKPiLmjFSt6
   xT0+ReO6LZONR9tO8oU6k9nW1J4Jc1trEYrqtgYVBgAo0OlCm9Wvp0WLc
   tpPOkDzZhMvgRZvY/jkWszOFO9Ro2okWw1yE69SWp6JOp0ayTpERQAyUt
   A0yOJc4+AiOfdshdIvgt+NeKiqZ5GWOu3xMb/jw+XRdk4dZqafLH0lZM7
   XHlXQlkpMGkfQjsRkRIDNJqiphDLO2zJWtZS4hEwH66rXieuMWo+ZxG+q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336646879"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="336646879"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 04:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="724322182"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="724322182"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2022 04:29:42 -0700
Date:   Fri, 4 Nov 2022 19:35:28 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_object.c
Message-ID: <Y2T5AFZ0IUFf0wsY@liuzhao-OptiPlex-7080>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
 <20221017093726.2070674-2-zhao1.liu@linux.intel.com>
 <2541717.Lt9SDvczpP@suse>
 <Y2Pxi9FsdeULhHKI@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Pxi9FsdeULhHKI@iweiny-desk3>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:51:23AM -0700, Ira Weiny wrote:
> Date: Thu, 3 Nov 2022 09:51:23 -0700
> From: Ira Weiny <ira.weiny@intel.com>
> Subject: Re: [PATCH 1/9] drm/i915: Use kmap_local_page() in
>  gem/i915_gem_object.c
> 
> On Sat, Oct 29, 2022 at 01:17:03PM +0200, Fabio M. De Francesco wrote:
> > On luned? 17 ottobre 2022 11:37:17 CEST Zhao Liu wrote:
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > The use of kmap_atomic() is being deprecated in favor of
> > > kmap_local_page()[1].
> > > 
> > > The main difference between atomic and local mappings is that local
> > > mappings doesn't disable page faults or preemption.
> > 
> > You are right about about page faults which are never disabled by 
> > kmap_local_page(). However kmap_atomic might not disable preemption. It 
> > depends on CONFIG_PREEMPT_RT.
> > 
> > Please refer to how kmap_atomic_prot() works (this function is called by 
> > kmap_atomic() when kernels have HIGHMEM enabled).
> > 
> > > 
> > > There're 2 reasons why i915_gem_object_read_from_page_kmap() doesn't
> > > need to disable pagefaults and preemption for mapping:
> > > 
> > > 1. The flush operation is safe for CPU hotplug when preemption is not
> > > disabled. 
> > 
> > I'm confused here. Why are you talking about CPU hotplug?
> 
> I agree with Fabio here.  I'm not making the connection between cpu hotplug and
> this code path.

Sorry, my misunderstanding. Will delete this wrong explanation.

Thanks,
Zhao
