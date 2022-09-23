Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77ED5E8238
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIWS7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiIWS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:59:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C611E96F;
        Fri, 23 Sep 2022 11:59:17 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 450561EC0646;
        Fri, 23 Sep 2022 20:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663959552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=IZpilCzfxYJ0hgwOaOZevuUWtRNMelez5POgnRty6do=;
        b=IIecOkJ1wrEUGjX8VCB6WKR0vcrQDVTQOw8vI3ruc9mYi9SJDvyS1rcRO+XIYkwCcN2D1V
        BPT0Tn8T36fyEJOOZs1sTAaBbcT0yFgKPnqSvZ8wF/jkThJgCxWZ/wqHdyD10Uei35N1vN
        TI3BeITEy4bka61TYlMkPeOwj4zrA0g=
Date:   Fri, 23 Sep 2022 20:59:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: INFO: task systemd-udevd:94 blocked for more than 120 seconds.
Message-ID: <Yy4B+9yH8oT0F8nQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm seeing the below on linux-next-20220923 and thermal_zone is in the
stacktrace so I thought I should Cc relevant folks in case you have an
idea...

[  155.065997] radeon 0000:00:01.0: [drm] fb0: radeondrmfb frame buffer device
[  155.152551] [drm] Initialized radeon 2.50.0 20080528 for 0000:00:01.0 on minor 0
[  242.946675] INFO: task systemd-udevd:94 blocked for more than 120 seconds.
[  242.946820]       Not tainted 6.0.0-rc6-next-20220923 #1
[  242.946902] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.946995] task:systemd-udevd   state:D stack:13344 pid:94    ppid:88     flags:0x00004004
[  242.947118] Call Trace:
[  242.947166]  <TASK>
[  242.947216]  __schedule+0x2af/0x830
[  242.947297]  schedule+0x5d/0xc0
[  242.947360]  schedule_preempt_disabled+0x14/0x30
[  242.947442]  __mutex_lock.constprop.0+0x2d0/0x7b0
[  242.947524]  thermal_zone_device_update.part.0+0xf8/0x2f0
[  242.947607]  ? acpi_system_write_wakeup_device+0x170/0x170
[  242.947700]  thermal_zone_device_set_mode+0x75/0xb0
[  242.947781]  acpi_thermal_add+0x3c2/0x400 [thermal]
[  242.947881]  acpi_device_probe+0x56/0x110
[  242.947953]  really_probe+0xc7/0x280
[  242.948022]  ? pm_runtime_barrier+0x61/0xb0
[  242.948098]  __driver_probe_device+0x71/0xd0
[  242.948175]  driver_probe_device+0x2d/0x100
[  242.948245]  __driver_attach+0xa6/0x1a0
[  242.950659]  ? __device_attach_driver+0x110/0x110
[  242.953030]  bus_for_each_dev+0x69/0xa0
[  242.955433]  bus_add_driver+0x1b0/0x200
[  242.957806]  ? _raw_spin_unlock+0x12/0x40
[  242.959211]  driver_register+0x89/0xe0
[  242.960589]  ? 0xffffffffa0006000
[  242.961957]  acpi_thermal_init+0x5c/0x1000 [thermal]
[  242.963375]  do_one_initcall+0x4d/0x210
[  242.964756]  ? kmalloc_trace+0x38/0xc0
[  242.966130]  do_init_module+0x4a/0x1e0
[  242.967503]  __do_sys_finit_module+0xa7/0x100
[  242.968858]  do_syscall_64+0x42/0x90
[  242.970202]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  242.971561] RIP: 0033:0x7fd31c8189b9
[  242.972910] RSP: 002b:00007ffd203a81b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  242.974318] RAX: ffffffffffffffda RBX: 00005571cdddfb30 RCX: 00007fd31c8189b9
[  242.975720] RDX: 0000000000000000 RSI: 00007fd31c9a3e2d RDI: 0000000000000005
[  242.977089] RBP: 0000000000020000 R08: 0000000000000000 R09: 00005571cddc6f50
[  242.978449] R10: 0000000000000005 R11: 0000000000000246 R12: 00007fd31c9a3e2d
[  242.979792] R13: 0000000000000000 R14: 00005571cddd8170 R15: 00005571cdddfb30
[  242.981143]  </TASK>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
