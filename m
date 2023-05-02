Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AE6F44D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjEBNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjEBNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:14:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645E55AE;
        Tue,  2 May 2023 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683033239; x=1714569239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UKS6eb6mm7wnEJz0YAhtu/APb6Zrywv1tOaxnDfoKl8=;
  b=YCe01avSvMO1vEYvkeOqKZm6X50q9Gn2NQW1W2qu6XI+bY5BVoiNyYhy
   qa7oIfoM3dRt2lPQ9ZHqw7q2GC36HW3eZH8W2qZ8nApHjIL/1cSmNcERF
   AEu9fdgP0zUagPscI1IvHzusuxzpCV2b814xkcv45xdH/SGoB0lIkdZFi
   A36RMUfhqYYg0kWLfhWdMxax2XZr2taC0uyNMQ7vLIdngR+6oInE7/E8w
   mLrDcJ0vXRgNQpF2PGUUO4AhTEmBCeLPro/EAEoQYoQRy4a9rBjQQXc98
   uYpKnqDS8/SbOBw1+abOawKEmYhf9AnZo9NyqKurUUCDJH2h2rDjshd7a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="347210487"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="347210487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 06:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="690278833"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="690278833"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by orsmga007.jf.intel.com with SMTP; 02 May 2023 06:13:56 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 02 May 2023 16:13:55 +0300
Date:   Tue, 2 May 2023 16:13:55 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kurt Garloff <kurt@garloff.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: 6.1.23: 0fc6fea41c71 breaks GPD Pocket 3 modeset
Message-ID: <ZFEMkypQy1I4vprK@intel.com>
References: <4115dc28-45b6-cad1-1e38-39e5a0484a8a@garloff.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4115dc28-45b6-cad1-1e38-39e5a0484a8a@garloff.de>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 09:55:45PM +0200, Kurt Garloff wrote:
> Hi Ville,
> 
> While
> 0fc6fea41c71 drm/i915: Disable DC states for all commits
> (cherry picked from commit 41b4c7fe72b6105a4b49395eea9aa40cef94288d)
> does look correct to me, it does break modesetting on the GPD Pocket 3,
> a i7-1195G7 laptop. I run the kernel with
> fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up \
> mem_sleep_default=s2idle
> No special i915 parameters.
> Hardware is described here:
> https://wiki.archlinux.org/title/GPD_Pocket_3
> 
> I disected this patch which was merged (backported) for 6.1.23.
> I currently run 6.1.26 with it reverted.
> 
> Without reverting it, when fbcon is switched to show the splash
> screen (GPD logo with Ubuntu added in on working kernels), the
> screen remains black (backlight on, but nothing displayed) and
> nothing happens any more.

Please file a bug at
https://gitlab.freedesktop.org/drm/intel/issues/new

Boot both kernels (revert vs. no revert), passing
'drm.debug=0xe log_buf_len=4M' to the kernel cmdline,
and attach the resulting dmesg from each to the bug.

Also would be good if you try to reproduce on the
latest drm-tip (git://anongit.freedesktop.org/drm-tip drm-tip)
as well.

-- 
Ville Syrjälä
Intel
