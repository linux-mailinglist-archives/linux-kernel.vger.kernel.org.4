Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC185EC2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiI0M3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiI0M27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:28:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309CD12888D;
        Tue, 27 Sep 2022 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281642; x=1695817642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V4TS9Qc3Cqv4yBjI7kNikCjjWn3L2ESGLMtkevk0BkA=;
  b=W3xA2sj8rx/B/NOy7czvduDKD3/CIu5d444WQCaffua5e0kBeTYd/Cki
   4z5Ss01xJK1005VLHvhrqocpcIbL2DqKtD06opkie7VctdlJa3048PcB9
   5veXgReqIrjg5ZIGC7hvxiISACSNmXhKSiXoKgPZv30/X1upDVdO4SNhH
   lHcv6VPAnhQ7HFf3sF2gR2SrGGdoAVS/Kt+omj+dHZsk0B3L0o3TMR58m
   +H3Uj3rDR2gbKPkYNgKXDh43c6gzzBSP3isPWXS580NsMP3WPr3s/QbjB
   dq/NHMWbjS5pXoClESHYtXySdYAM1ijACtS+5qhB+3yCWYU0Bc8xHttzg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288453311"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="288453311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="654708104"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="654708104"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 05:27:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6493C7C; Tue, 27 Sep 2022 15:27:38 +0300 (EEST)
Date:   Tue, 27 Sep 2022 15:27:38 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] thunderbolt: Add wake on connect/disconnect on USB4
 ports
Message-ID: <YzLsOioaDVARFnR2@black.fi.intel.com>
References: <20220928115230.2031934-1-rajat.khandelwal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928115230.2031934-1-rajat.khandelwal@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 28, 2022 at 05:22:30PM +0530, Rajat Khandelwal wrote:
> Wake on connect/disconnect is only supported while runtime suspend
> for now, which is obviously necessary. Its also not inherently
> desired for the system to wakeup on thunderbolt hot events.
> However, we can still make user in control of waking up the system
> in the events of hot plug/unplug.
> This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
> attribute and only enables wakes on connect/disconnect to the
> respective port when 'wakeup' is set to 'enabled'. The attribute
> is set to 'disabled' by default.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> ---
> 
> Significant changes and reasons:
> 1. 'if (!port->cap_usb4)' is added under the loop in
> 'usb4_switch_check_wakes' function since the checks later are
> explicitly targeted to the USB4 port configuration capability.
> 'if (!tb_port_has_remote(port))' is removed because events now can
> be connection/disconnection along with USB4 events. Thus, a wake
> on connection can be triggered by user on the USB4 port (initially
> no remote).
> 2. Verified runtime wakeup. It works absolutely fine.
> 3. Wakeup count has to be increased in the 'wakeup_count' attribute
> under usb4_port/power, thus requiring another pm_wakeup_event.
> 
> Fixes in v4:

Have you sent this patch previously upstream? I don't think so. So the
version number should be v1 (or ignored) and this changelog is not
needed either.

Also in future it is good to have link here to the previous versions of
the patch. I think all this is explained in
https://docs.kernel.org/process/index.html.
