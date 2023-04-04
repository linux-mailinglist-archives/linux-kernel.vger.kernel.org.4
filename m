Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDC6D6E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbjDDVB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjDDVBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:01:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1E4EE8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680642048; x=1712178048;
  h=date:from:to:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=2s1fu+EVzo4bbWI21FcjGuFcNl6YCxpOek/OVyKSbA0=;
  b=MuUphH6KJ7JJigIj7c21X4rUzjw9chv6hppvmQ97oa+Yj2FR4TwfJo+g
   sLxnk9eUajxfDRybBMXMr0xUyQkH372WEysqfdC8KGBhcTalk6nLV/ARx
   po+TPFlSLZNPWYXTkRNDo887uwYSR7UBRiXxraLfEtGb6anp2o86OlaDN
   KfUylErwMRADXh6nyhi6BRfnT7x6m+81f1HORuGWwYZvRxPNLHVOF80V/
   HxBzx/bKIG5kAmrJDTajlRrNQ89xgAf4Z5SJA16KMhvuATkS/SmEsdc/C
   rgiaLcDScvkjn/AkUCfqqnyWAKNV4vqxGeNfG9RPsrmcmKpxVsa4iYn0C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344881074"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="344881074"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 14:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751038181"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="751038181"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga008.fm.intel.com with SMTP; 04 Apr 2023 14:00:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 05 Apr 2023 00:00:23 +0300
Date:   Wed, 5 Apr 2023 00:00:23 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vblank: Simplify drm_dev_has_vblank()
Message-ID: <ZCyP55f2CFQqtP0a@intel.com>
References: <20230403160735.1211468-1-robdclark@gmail.com>
 <ZCyMiERvNHTP45o8@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCyMiERvNHTP45o8@phenom.ffwll.local>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:46:00PM +0200, Daniel Vetter wrote:
> On Mon, Apr 03, 2023 at 09:07:35AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > What does vblank have to do with num_crtcs?  Well, this was technically
> > correct, but you'd have to go look at where num_crtcs is initialized to
> > understand why.  Lets just replace it with the simpler and more obvious
> > check.
> 
> If you want to fix this, then I think the right fix is to rename num_crtcs
> to be something like num_vblank_crtcs. It's a historical accident back
> when vblanks without kms was a thing.
> 
> Plan B is someone gets really busy and fixes up the entire vblank mess and
> moves it into drm_crtc struct. Now that the dri1 drivers are gone we could
> indeed do that.

And easy first step could to simply wrap all the naked
&dev->vblank[drm_crtc_index()] things into a function
call with some cocci/etc. That way most of the vblank
code doesn't need to care where that thing actually lives.

-- 
Ville Syrjälä
Intel
