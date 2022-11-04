Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29DF619579
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiKDLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKDLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:38:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FCA3B0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667561902; x=1699097902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2dwZ0lBOQZ6+sQ6EOjFpDqnqPMYYcofhOiJqlrECN2A=;
  b=e9BSeafAQUaJ3f/9uGJigkd2OltKJLAKmCtHKVmBoJhHJwQLJi1GJeWm
   Xpss7our9Hkq9wsIyzqjMJpjqiytDzN2nC0C3ApHK5HaKLA5OhbJYbJbi
   2505jzzXRIGsSSfcYoIV7iWkTP6rDEykMQUdl4xX/xD8duPyHNVifXQ7S
   x8yR5QogMY+YEjCnCzisYiemPww17E6h3QOwcpaoZ751sYaUNvRXnbLN7
   fIo9PY8g1FtDpRcjMQbmkkmx51IFNjNuUW+W27XdzJo4oaXm3guDLqpsh
   WyYpt3e1XM/+RtzKoa+qwe2ta+EQihansTesOzRroA+TuYSWCi0p1fYLM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308659433"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="308659433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 04:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666341173"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="666341173"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2022 04:38:20 -0700
Date:   Fri, 4 Nov 2022 19:44:05 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_object.c
Message-ID: <Y2T7BePekbf06JEo@liuzhao-OptiPlex-7080>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
 <2541717.Lt9SDvczpP@suse>
 <Y2Pxi9FsdeULhHKI@iweiny-desk3>
 <12087538.O9o76ZdvQC@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12087538.O9o76ZdvQC@suse>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:22:04PM +0100, Fabio M. De Francesco wrote:
> Date: Thu, 03 Nov 2022 20:22:04 +0100
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Subject: Re: [PATCH 1/9] drm/i915: Use kmap_local_page() in
>  gem/i915_gem_object.c
> 
> On gioved? 3 novembre 2022 17:51:23 CET Ira Weiny wrote:
> > On Sat, Oct 29, 2022 at 01:17:03PM +0200, Fabio M. De Francesco wrote:
> > > On luned? 17 ottobre 2022 11:37:17 CEST Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > The use of kmap_atomic() is being deprecated in favor of
> > > > kmap_local_page()[1].
> > > > 
> > > > The main difference between atomic and local mappings is that local
> > > > mappings doesn't disable page faults or preemption.
> > > 
> > > You are right about about page faults which are never disabled by
> > > kmap_local_page(). However kmap_atomic might not disable preemption. It
> > > depends on CONFIG_PREEMPT_RT.
> > > 
> > > Please refer to how kmap_atomic_prot() works (this function is called by
> > > kmap_atomic() when kernels have HIGHMEM enabled).
> > > 
> > > > There're 2 reasons why i915_gem_object_read_from_page_kmap() doesn't
> > > > need to disable pagefaults and preemption for mapping:
> > > > 
> > > > 1. The flush operation is safe for CPU hotplug when preemption is not
> > > > disabled.
> > > 
> > > I'm confused here. Why are you talking about CPU hotplug?
> > 
> > I agree with Fabio here.  I'm not making the connection between cpu hotplug 
> and
> > this code path.
> > 
> > Ira
> 
> @Zhao,
> 
> I'd like to add that I was about to put my reviewed-by tag. The other things I 
> objected are minor nits. Please just clarify this connection.

Thanks Fabio for your comments! Sorry I missed the mails that day. This connection
is my misunderstanding. Other thoughts please refer to my reply to your first email
in this thread.

Thanks,
Zhao

