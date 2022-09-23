Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAED5E8273
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiIWTTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:19:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29812C689;
        Fri, 23 Sep 2022 12:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F98EB822EB;
        Fri, 23 Sep 2022 19:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C1FC433D7;
        Fri, 23 Sep 2022 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663960738;
        bh=MBr78PReUPhag3t0o4RjOZ0IVlZpLUcKGmyL+Fo/C0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap5YmXxaFDCAgOciKd3qSyzQzwX6llIngsUD7v6jtbE13qNFHWSUZR9gxpvz4qKQe
         b8nOevxsjIY/+Gpxrl8Ou1rJoUy+sPngzkawZXRK1cee0dsfp5jvoHPHY/5RiwP4Ki
         fLxr/ExV3EWA4rDvVlFBHdMaPcsbk61kGCDAmugUutKUfAT3nRTaxwyAsTOmyoq9dE
         2YPHUCScS/kOYfaD9Zm+HInOtlEU8ukXJJRnEUwp6kT/j9O8XOD0k2v/3cEygngQMv
         ODAgyNi6G3fxIui4F42r1b3vGINsuLC9+Xo2MoAPwxRsXRO9o6abLvln7Q0vigdt9u
         3+25lZ1lHkgVQ==
Date:   Fri, 23 Sep 2022 12:18:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: INFO: task systemd-udevd:94 blocked for more than 120 seconds.
Message-ID: <Yy4GoMMwiBaq3oJf@dev-arch.thelio-3990X>
References: <Yy4B+9yH8oT0F8nQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy4B+9yH8oT0F8nQ@zn.tnic>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:59:07PM +0200, Borislav Petkov wrote:
> Hi folks,
> 
> I'm seeing the below on linux-next-20220923 and thermal_zone is in the
> stacktrace so I thought I should Cc relevant folks in case you have an
> idea...
> 
> [  155.065997] radeon 0000:00:01.0: [drm] fb0: radeondrmfb frame buffer device
> [  155.152551] [drm] Initialized radeon 2.50.0 20080528 for 0000:00:01.0 on minor 0
> [  242.946675] INFO: task systemd-udevd:94 blocked for more than 120 seconds.
> [  242.946820]       Not tainted 6.0.0-rc6-next-20220923 #1
> [  242.946902] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.946995] task:systemd-udevd   state:D stack:13344 pid:94    ppid:88     flags:0x00004004
> [  242.947118] Call Trace:
> [  242.947166]  <TASK>
> [  242.947216]  __schedule+0x2af/0x830
> [  242.947297]  schedule+0x5d/0xc0
> [  242.947360]  schedule_preempt_disabled+0x14/0x30
> [  242.947442]  __mutex_lock.constprop.0+0x2d0/0x7b0
> [  242.947524]  thermal_zone_device_update.part.0+0xf8/0x2f0
> [  242.947607]  ? acpi_system_write_wakeup_device+0x170/0x170
> [  242.947700]  thermal_zone_device_set_mode+0x75/0xb0
> [  242.947781]  acpi_thermal_add+0x3c2/0x400 [thermal]
> [  242.947881]  acpi_device_probe+0x56/0x110
> [  242.947953]  really_probe+0xc7/0x280
> [  242.948022]  ? pm_runtime_barrier+0x61/0xb0
> [  242.948098]  __driver_probe_device+0x71/0xd0
> [  242.948175]  driver_probe_device+0x2d/0x100
> [  242.948245]  __driver_attach+0xa6/0x1a0
> [  242.950659]  ? __device_attach_driver+0x110/0x110
> [  242.953030]  bus_for_each_dev+0x69/0xa0
> [  242.955433]  bus_add_driver+0x1b0/0x200
> [  242.957806]  ? _raw_spin_unlock+0x12/0x40
> [  242.959211]  driver_register+0x89/0xe0
> [  242.960589]  ? 0xffffffffa0006000
> [  242.961957]  acpi_thermal_init+0x5c/0x1000 [thermal]
> [  242.963375]  do_one_initcall+0x4d/0x210
> [  242.964756]  ? kmalloc_trace+0x38/0xc0
> [  242.966130]  do_init_module+0x4a/0x1e0
> [  242.967503]  __do_sys_finit_module+0xa7/0x100
> [  242.968858]  do_syscall_64+0x42/0x90
> [  242.970202]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  242.971561] RIP: 0033:0x7fd31c8189b9
> [  242.972910] RSP: 002b:00007ffd203a81b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  242.974318] RAX: ffffffffffffffda RBX: 00005571cdddfb30 RCX: 00007fd31c8189b9
> [  242.975720] RDX: 0000000000000000 RSI: 00007fd31c9a3e2d RDI: 0000000000000005
> [  242.977089] RBP: 0000000000020000 R08: 0000000000000000 R09: 00005571cddc6f50
> [  242.978449] R10: 0000000000000005 R11: 0000000000000246 R12: 00007fd31c9a3e2d
> [  242.979792] R13: 0000000000000000 R14: 00005571cddd8170 R15: 00005571cdddfb30
> [  242.981143]  </TASK>

I have not seen a stacktrace like this on my machines (although I
suspect that is because I don't have CONFIG_DETECT_HUNG_TASK enabled in
my configs) but my Honeycomb LX2 hangs while booting after commit
78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip()
function") according to my bisect, which certainly seems like it could
be related to the trace you are seeing.

Cheers,
Nathan
