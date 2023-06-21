Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65A7383EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjFUMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjFUMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:37:05 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A675122
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:37:03 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-78a3e1ed1deso1912744241.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687351022; x=1689943022;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8oVZWF8wCPGN0S1a9Q/xn0SWVk6HP6kgHLzae5e7Ws=;
        b=toY2H7hQGw2mj/nGsagbWBruXoGRDGkUgzlkkt8xagUi8nZYcVsfHSGXxZG4OiWxcw
         wm8s7CDC4D7icfN6Z+p9MMWQFVFAxFf2Ft20Dsm11I9DBZVP4G2for39pipsRH9/3bTo
         dm2f9Vjli5f3J9rDRlduVMIMNpKYxNMfYTtOuri3pj9qqaJyEQppGEEilyW9zEnzmJKs
         BEsUeD24cPbz2OYnzhbagFXAlRcTwMehMpls7gtIbJAF4gtk1Wl9Qf7Uiw1zhcFJvjTu
         jFk1F8mmvKBiv4xwbfkSTMhcIse0+qI2ja/mLJ6BLrezkX82o0qkLgWS/za+x86PMk8I
         rywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351022; x=1689943022;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8oVZWF8wCPGN0S1a9Q/xn0SWVk6HP6kgHLzae5e7Ws=;
        b=XyEk88BRdnsyKcbyIGW4tk0BNVug3eqLHINggwj5Ec8c3UxoU4XINEVlQgwj4GAmlW
         hH4ApfntsLrPVlTBiFIwWJeebGiV1RwtEFPgWH6m+1XhguPvj/o4KRzIOk3Y9JMDcN2V
         XFcx6313ddUDG5yuSjxxi1x6nZ2K07jWlA5iLTobM2YCTaFfy/zbRmGhDClXFyhMdAO3
         As3AKSJBNz+7+HyYUSR8B43ZO9sOqBVDTa5gHIfy0iSSoN5x9dt+lKt7aeSeCVk+5RRx
         o6aag2U9vCyO1BBl6EnvPhGA5VaCC6DinurBYHkWw/lj1541Cs3fm7S3Xx9uQDGw0wW8
         +54Q==
X-Gm-Message-State: AC+VfDzZyuCBCXY0lhI2rHXTNs0S146MOC5KPcZ9ao54Chh554c8XdYY
        36L39DR8MSXPIUkya5POqfatWvDpZQ1/mvEE2QKbfA==
X-Google-Smtp-Source: ACHHUZ5jH2LvLmDSP3KzT6lMMz5OYiVqcBaVA3vnfgB/VYjmBNBNAPag6clE3TO3Tn0qq+TcraZLThobLl7mGOisBJQ=
X-Received: by 2002:a67:e3a6:0:b0:439:5c28:8ec2 with SMTP id
 j6-20020a67e3a6000000b004395c288ec2mr5606098vsm.35.1687351022184; Wed, 21 Jun
 2023 05:37:02 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Jun 2023 18:06:51 +0530
Message-ID: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
Subject: next: Rpi4: Unexpected kernel BRK exception at EL1
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following boot warnings and crashes noticed on arm64 Rpi4 device running
Linux next-20230621 kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

boot log:

[   22.331748] Kernel text patching generated an invalid instruction
at 0xffff8000835d6580!
[   22.340579] Unexpected kernel BRK exception at EL1
[   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] PREEMPT SMP
.
[   22.353814] Modules linked in: hci_uart(+) brcmfmac(+) btqca
brcmutil btbcm vc4(+) cfg80211 bluetooth reset_raspberrypi
clk_raspberrypi crct10dif_ce raspberrypi_hwmon snd_soc_hdmi_codec cec
v3d bcm2711_thermal rfkill drm_display_helper drm_shmem_helper
pcie_brcmstb drm_dma_helper pwm_bcm2835 i2c_bcm2835 gpu_sched
drm_kms_helper fuse drm
[   22.376947] vc4-drm gpu: bound fe004000.txp (ops vc4_txp_ops [vc4])
[   22.384754] CPU: 3 PID: 159 Comm: systemd-udevd Not tainted
6.4.0-rc7-next-20230621 #1
[   22.384769] Hardware name: Raspberry Pi 4 Model B (DT)
[   22.384776] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   22.384789] pc : 0xffff8000835d6580
[   22.384798] lr : sk_filter_trim_cap+0x80/0x2a0
[   22.384825] sp : ffff800083cdb9d0
[   22.384831] x29: ffff800083cdb9d0 x28: 0000000000000000 x27: 0000000000000001
[   22.384853] x26: ffff000041ece000 x25: ffff0000423ac800 x24: ffff800083468e00
[   22.384872] x23: 0000000000000000 x22: ffff000044c41300 x21: 0000000000000001
[   22.384891] x20: ffff800083bed000 x19: ffff000044c41300 x18: 0000000000000000
[   22.384909] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000015798650
[   22.384928] x14: 414d003633373832 x13: 3332323d44455a49 x12: 4c414954494e495f
[   22.384946] x11: 4345535500343331 x10: 343d4d554e514553 x9 : ffff80008124f500
[   22.384965] x8 : ffff800083cdb7d8 x7 : 0000000000000000 x6 : 0000000000000001
[   22.384983] x5 : ffff800082def000 x4 : ffff800082def2e8 x3 : 0000000000000000
[   22.385001] x2 : ffff8000835d657c x1 : ffff800083bed048 x0 : ffff000044c41300
[   22.385020] Call trace:
[   22.385025]  0xffff8000835d6580
[   22.385033]  netlink_broadcast+0x1f0/0x4e8
[   22.385047]  netlink_sendmsg+0x318/0x420
[   22.385056]  ____sys_sendmsg+0x1cc/0x2c8
[   22.385075]  ___sys_sendmsg+0x88/0xf0
[   22.385084]  __sys_sendmsg+0x70/0xd8
[   22.385093]  __arm64_sys_sendmsg+0x2c/0x40
[   22.385102]  invoke_syscall+0x50/0x128
[   22.385120]  el0_svc_common.constprop.0+0xf4/0x120
[   22.385136]  do_el0_svc+0x44/0xb8
[   22.385152]  el0_svc+0x30/0x98
[   22.385163]  el0t_64_sync_handler+0x13c/0x158
[   22.385174]  el0t_64_sync+0x190/0x198
[   22.385190] Code: d4202000 d4202000 d4202000 910003c9 (d503201f)
[   22.385199] ---[ end trace 0000000000000000 ]---
[   22.385206] note: systemd-udevd[159] exited with irqs disabled
[   22.385378] note: systemd-udevd[159] exited with preempt_count 1
[   22.395083] uart-pl011 fe201000.serial: no DMA platform data
[   22.427073] vc4-drm gpu: bound fe206000.pixelvalve (ops vc4_crtc_ops [vc4])
[   22.434295] ------------[ cut here ]------------
[   22.474787] Bluetooth: HCI UART protocol Marvell registered
[   22.475105] Voluntary context switch within RCU read-side critical section!
[   22.475129] WARNING: CPU: 3 PID: 159 at
kernel/rcu/tree_plugin.h:320 rcu_note_context_switch+0x458/0x530
[   22.553049] vc4-drm gpu: bound fe207000.pixelvalve (ops vc4_crtc_ops [vc4])
[   22.555403] Modules linked in: hci_uart(+) brcmfmac(+) btqca
brcmutil btbcm vc4(+) cfg80211 bluetooth reset_raspberrypi
clk_raspberrypi crct10dif_ce
[   22.583877] vc4-drm gpu: bound fe20a000.pixelvalve (ops vc4_crtc_ops [vc4])
[   22.584920]  raspberrypi_hwmon snd_soc_hdmi_codec
[   22.614889] vc4-drm gpu: bound fe216000.pixelvalve (ops vc4_crtc_ops [vc4])
[   22.618972]  cec v3d bcm2711_thermal rfkill drm_display_helper
drm_shmem_helper pcie_brcmstb drm_dma_helper pwm_bcm2835 i2c_bcm2835
gpu_sched drm_kms_helper fuse drm
[   22.666409] CPU: 3 PID: 159 Comm: systemd-udevd Tainted: G      D
         6.4.0-rc7-next-20230621 #1
[   22.666424] Hardware name: Raspberry Pi 4 Model B (DT)
[   22.666431] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   22.666443] pc : rcu_note_context_switch+0x458/0x530
[   22.666463] lr : rcu_note_context_switch+0x458/0x530
[   22.666478] sp : ffff800083cdb3a0
[   22.666483] x29: ffff800083cdb3a0 x28: ffff0000423acc08 x27: 0000000000000000
[   22.666506] x26: ffff00004205a080 x25: ffff80008146d7c8 x24: 0000000000000000
[   22.666525] x23: 0000000000000000 x22: ffff00004205a080 x21: ffff80008335dd18
[   22.666544] x20: ffff80008237d2c0 x19: ffff0000fb5f1140 x18: ffffffffffffffff
[   22.666562] x17: 3035663432313830 x16: 3030386666666620 x15: 3a20397820333535
[   22.666581] x14: 3431356534353564 x13: 216e6f6974636573 x12: 206c616369746972
[   22.666600] x11: 6320656469732d64 x10: 6165722055435220 x9 : ffff80008012b740
[   22.752425] x8 : 6863746977732074 x7 : 7865746e6f632079 x6 : 7261746e756c6f56
[   22.759681] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000027
[   22.766935] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00004205a080
[   22.774190] Call trace:
[   22.776668]  rcu_note_context_switch+0x458/0x530
[   22.781364]  __schedule+0xb8/0xd78
[   22.784824]  schedule+0x60/0x100
[   22.788105]  netlink_table_grab.part.0+0x8c/0xf8
[   22.792801]  netlink_release+0x5dc/0x6d8
[   22.796782]  __sock_release+0x4c/0xc8
[   22.800505]  sock_close+0x20/0x38
[   22.803872]  __fput+0xbc/0x280
[   22.806979]  ____fput+0x18/0x30
[   22.810172]  task_work_run+0x78/0xd8
[   22.813802]  do_exit+0x2f8/0x9a8
[   22.817085]  make_task_dead+0xa4/0x1a8
[   22.820896]  die+0x254/0x260
[   22.823819]  arm64_notify_die+0xbc/0xe0
[   22.827712]  do_debug_exception+0xe0/0x118
[   22.831876]  el1_dbg+0x70/0x90
[   22.834975]  el1h_64_sync_handler+0xc8/0xe8
[   22.839222]  el1h_64_sync+0x64/0x68
[   22.842761]  0xffff8000835d6580
[   22.845949]  netlink_broadcast+0x1f0/0x4e8
[   22.850105]  netlink_sendmsg+0x318/0x420
[   22.854084]  ____sys_sendmsg+0x1cc/0x2c8
[   22.858072]  ___sys_sendmsg+0x88/0xf0
[   22.861788]  __sys_sendmsg+0x70/0xd8
[   22.865414]  __arm64_sys_sendmsg+0x2c/0x40
[   22.869571]  invoke_syscall+0x50/0x128
[   22.873383]  el0_svc_common.constprop.0+0xf4/0x120
[   22.878251]  do_el0_svc+0x44/0xb8
[   22.881621]  el0_svc+0x30/0x98
[   22.884721]  el0t_64_sync_handler+0x13c/0x158
[   22.889144]  el0t_64_sync+0x190/0x198
[   22.892860] ---[ end trace 0000000000000000 ]---


Links:
 - https://lkft.validation.linaro.org/scheduler/job/6531518#L886
 - https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20230621/testrun/17697990/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20230621/testrun/17697990/suite/log-parser-test/test/check-kernel-warning/log

 metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
  git_describe: next-20230621
  kernel_version: 6.4.0-rc7
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVA7srTtdxlVq1QVEgrzc0AAKp/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVA7srTtdxlVq1QVEgrzc0AAKp/
  toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org
