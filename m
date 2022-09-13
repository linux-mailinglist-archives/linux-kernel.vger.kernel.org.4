Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514155B6967
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiIMIVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIMIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:21:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273BA5B043
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663057257; x=1694593257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YQ4XpgIYxwuDp/T9stIwbL+/CqELDrKtFwPudLSttnk=;
  b=Ei7iP1hda2nTbfP4jFennY4iRlH8BeZ7bE4i3zBMsjIrrEo5RWPaQ3V+
   KXH83W+JB6xbVGhMtr5dLNBwwFWgzwEyqXm1UQpgwvB0+x8pjV8KI8OOe
   5yRx7WPc86cVvaetb5XGmrX19faJ5RkCzo7FsH1uK6QdZOGsl0smyZAa5
   J2xNkMLGLYSRh5oJ5tQSyevpr4we1+ifkt6fgX9Cith4FbZV0fOextjSe
   nXZnH3ialyUQMDKDTdqV+6FQ+bNJXuxndvPXTyr9DofKN+0enQvWPYVwm
   mumfOupJTZrKArALTqxxtfXDygMncwamIRNYjwXhA9/mIFy6Gmjl8zMU/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285099932"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="285099932"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="649574775"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga001.jf.intel.com with SMTP; 13 Sep 2022 01:20:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 13 Sep 2022 11:20:51 +0300
Date:   Tue, 13 Sep 2022 11:20:51 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Davis <ben.davis@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: A divide error bug in framebuffer_check
Message-ID: <YyA9Y+Cs8ZCYHXAT@intel.com>
References: <CAFcO6XOSwwe+4H5cCEdgj6KD+QutNMZA89rWXYvbQCsREqFqtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFcO6XOSwwe+4H5cCEdgj6KD+QutNMZA89rWXYvbQCsREqFqtQ@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:49:40AM +0800, butt3rflyh4ck wrote:
> Hi, there is a divide error bug in framebuffer_check in
> drivers/gpu/drm/drm_framebuffer.c in the latest kernel.
> we can trigger it via drm_mode_addfb2 IOCTL.
> The call trace is drm_mode_addfb2 -> drm_internal_framebuffer_create
> ->  framebuffer_check.
> let us see code below:
> ```
<snip>
> { .format = DRM_FORMAT_Q410, .depth = 0,
>   .num_planes = 3, .char_per_block = { 2, 2, 2 },
>   .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
>   .vsub = 0, .is_yuv = true },
> { .format = DRM_FORMAT_Q401, .depth = 0,
>   .num_planes = 3, .char_per_block = { 2, 2, 2 },
>   .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
>   .vsub = 0, .is_yuv = true },
> ```
> we can see format.hsub and format.vsub all are NULL.

Yeah, those look borked.

Added in commit 94b292b27734 ("drm: drm_fourcc: add NV15, Q410, Q401 YUV formats")

Adding the relevant people to cc...

-- 
Ville Syrjälä
Intel
