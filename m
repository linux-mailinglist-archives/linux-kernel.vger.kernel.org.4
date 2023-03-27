Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E486CB02C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjC0U56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0U54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:57:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FA83;
        Mon, 27 Mar 2023 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679950675; x=1711486675;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version:
   in-reply-to;
  bh=JvMjkqlYjyn1Sy3gcj9zhxlhSqvZYPWbGY9kN9VOl/w=;
  b=ghBNBfiosNRkw2Q4ntqrv3uD5BQR2QehUNYPy7jb4DnbeYnWqsYpkQ6X
   9tJEadJemmcEvmviOeYo+wln4j45TBT+btIs44ax8XDDljufEwesji+CO
   02HPW8WzEqI1mXB0CCyfkTOsKIQnHY60zaPzeER+wV38M7f3jEoyJ9DX4
   r2qGPYJUMnAt3sqPLxTy2WVc6Z8L3I6sA7dMumL47S7Yudld/HmV9y8+q
   TD2HklbEKqd7LrvptVukbEQN/EzW1EcXPpVkB7DH2WBkW6peZ/37OndgS
   iOL4Mk7PdtPIVaglq9iamGyFeA1SRElFzntJIFaMms97OYASwRfQkgadh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320789119"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320789119"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 13:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="677105645"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="677105645"
Received: from ideak-desk.fi.intel.com ([10.237.72.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 13:57:52 -0700
Date:   Mon, 27 Mar 2023 23:57:48 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v1 3/4] thermal: core: Introduce
 thermal_cooling_device_update()
Message-ID: <ZCIDTLFt27Ei7+V6@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10247847.nUPlyArG6x@kreacher>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this leads to the stacktrace below triggered by
lockdep_assert_held(&cdev->lock) in cooling_device_stats_setup(), and

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 566df4522b885..132175b14814f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -918,7 +918,9 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (ret)
 		goto out_cdev_type;
 
+	mutex_lock(&cdev->lock);
 	thermal_cooling_device_setup_sysfs(cdev);
+	mutex_unlock(&cdev->lock);
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	if (ret)

fixed it up for me, but not sure if it's the correct fix.

--Imre

[    4.662358] ------------[ cut here ]------------
[    4.662361] WARNING: CPU: 3 PID: 1 at drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xb4/0xc0
[    4.662370] Modules linked in:
[    4.662375] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G          I        6.3.0-rc4-imre+ #771
[    4.662379] Hardware name: Intel Corporation Shark Bay Client platform/Flathead Creek Crb, BIOS HSWLPTU1.86C.0109.R03.1301282055 01/28/2013
[    4.662382] RIP: 0010:cooling_device_stats_setup+0xb4/0xc0
[    4.662387] Code: 89 1d 58 52 36 01 5b 41 5c 41 5d 5d c3 cc cc cc cc 48 8d bf 18 05 00 00 be ff ff ff ff e8 f4 d2 3e 00 85 c0 0f 85 6f ff ff ff <0f> 0b e9 68 ff ff ff 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
[    4.662390] RSP: 0000:ffff9f48c0057b30 EFLAGS: 00010246
[    4.662395] RAX: 0000000000000000 RBX: ffff8fc381ca9800 RCX: 0000000000000000
[    4.662398] RDX: 0000000000000000 RSI: ffffffff94ad1d28 RDI: ffffffff94b58cc6
[    4.662401] RBP: ffff9f48c0057b48 R08: 0000000000000004 R09: 0000000000000000
[    4.662404] R10: ffff8fc381c77cd0 R11: 0000000000000000 R12: 0000000000000002
[    4.662406] R13: ffff8fc381ca9800 R14: ffff8fc381b0a000 R15: 0000000000000000
[    4.662409] FS:  0000000000000000(0000) GS:ffff8fc6b5580000(0000) knlGS:0000000000000000
[    4.662412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.662415] CR2: 0000000000000000 CR3: 0000000283856001 CR4: 00000000001706e0
[    4.662418] Call Trace:
[    4.662421]  <TASK>
[    4.662427]  thermal_cooling_device_setup_sysfs+0x12/0x30
[    4.662433]  __thermal_cooling_device_register+0x195/0x410
[    4.662442]  thermal_cooling_device_register+0x19/0x20
[    4.662446]  acpi_fan_probe+0xd7/0x5a0
[    4.662458]  ? acpi_match_device_ids+0x12/0x20
[    4.662464]  ? acpi_dev_pm_attach+0x41/0x110
[    4.662473]  platform_probe+0x48/0xc0
[    4.662481]  really_probe+0x1be/0x420
[    4.662487]  __driver_probe_device+0x8c/0x190
[    4.662493]  driver_probe_device+0x24/0x90
[    4.662498]  __driver_attach+0xf7/0x200
[    4.662503]  ? __pfx___driver_attach+0x10/0x10
[    4.662507]  bus_for_each_dev+0x80/0xd0
[    4.662516]  driver_attach+0x1e/0x30
[    4.662522]  bus_add_driver+0x11f/0x230
[    4.662530]  driver_register+0x5e/0x120
[    4.662534]  ? __pfx_acpi_fan_driver_init+0x10/0x10
[    4.662540]  __platform_driver_register+0x1e/0x30
[    4.662545]  acpi_fan_driver_init+0x17/0x20
[    4.662549]  do_one_initcall+0x61/0x280
[    4.662559]  ? debug_smp_processor_id+0x17/0x20
[    4.662568]  kernel_init_freeable+0x411/0x640
[    4.662582]  ? __pfx_kernel_init+0x10/0x10
[    4.662589]  kernel_init+0x1b/0x1f0
[    4.662594]  ? __pfx_kernel_init+0x10/0x10
[    4.662599]  ret_from_fork+0x2c/0x50
[    4.662615]  </TASK>
[    4.662618] irq event stamp: 506869
[    4.662620] hardirqs last  enabled at (506875): [<ffffffff9338e2d8>] __up_console_sem+0x68/0x80
[    4.662625] hardirqs last disabled at (506880): [<ffffffff9338e2bd>] __up_console_sem+0x4d/0x80
[    4.662628] softirqs last  enabled at (504698): [<ffffffff932de49f>] __irq_exit_rcu+0xbf/0x140
[    4.662633] softirqs last disabled at (504689): [<ffffffff932de49f>] __irq_exit_rcu+0xbf/0x140
[    4.662636] ---[ end trace 0000000000000000 ]---
[    4.662779] ------------[ cut here ]------------
