Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885F744816
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGAImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:42:38 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6DBC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:42:37 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-636801fada1so4539766d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688200956; x=1690792956;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eTNrz5ACYjMP9OAyUfdDxCBLxVlkDsMq1oye85J66xY=;
        b=ykesdcdqaD4p0Lcv+KooU0HYKO/TsW+W4i9gLVWxAhZrh21gOP9jj6MyaGoIFJZXEs
         6G4xOskQN5+aFDmHATjXNprX5bHQRomNbhKcQbFcit+uosO+GdYyVNCLGM2YK2pa+fLa
         nmzCUai/fwIAowhHPcB7TCrcbF3q+ZFWxJN0j52sSG9SJIolfmfwNC6loybnIjbfthL4
         3904QV3rX9tIbeDDqrcrGek8WCxKefJh9CFfAv0tcfD/rcOkKSPP+FRZT7nvNbbfkekc
         joSPlFeneSubDVielnaV6Ng8Swmi0w3KmWdYf1tv2JED0h7Tq3Co/x4fDpaVHMGKkcFX
         hTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200956; x=1690792956;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTNrz5ACYjMP9OAyUfdDxCBLxVlkDsMq1oye85J66xY=;
        b=XU2vH4XQHfl+CLOh6myOo70EkJYMYzEBdrGHE8q/Oc+fFAAJBcACyslheqEO/pXY0C
         M41hjFmeNpT9Idfuu+qdNOleLYTUU4N0j58wPoSWuJ2XSkfIqiOZz8bOnLMr0rSDy4vl
         j/WxuulcHmii4UcHhB7lA9/NvfUfB0W2yVqlSkps+LiOncMZvU2NJLYOSYfdNcY/qJFq
         jT0lSNh+BSpfTygu8De2ZjIZDJLhWASTjT2dYq0+J+Q232+eyN8okVrw1UakNLghJdP7
         fllVR/dv+6LTKB2ZNK5Y+EDmio9sqhRJwN/onU+/iiBxbploeJLp9r2KrtwVbkXK6c0b
         b3TA==
X-Gm-Message-State: AC+VfDy4Tq3XGZueEWCjWv5tHWORGhh24SLiZ4NCVHFkWzpXw8E+Vg89
        cCSVyNlpHyQpKb6DHpu0hawNaGt9684cXAofQ+oM2XNv8YqdtG0o/l8erg==
X-Google-Smtp-Source: ACHHUZ5E0W83JB0J67GJelG5zsOD/xkzXPV5B0xGfyuldpHNJpcBggOQ2+qcpMP16Dl6ovCcOm4a9i+xuRODKYd7wVk=
X-Received: by 2002:a05:620a:2a0a:b0:765:8808:54a2 with SMTP id
 o10-20020a05620a2a0a00b00765880854a2mr6099992qkp.42.1688200955868; Sat, 01
 Jul 2023 01:42:35 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 1 Jul 2023 14:12:24 +0530
Message-ID: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
Subject: qemu-arm64: Unexpected kernel BRK exception at EL1 - WARNING: CPU: 3
 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running selftest clone3 test cases on qemu-arm64 the following
kernel crash reported on Linux mainline kernel 6.4.0.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: clone3: clone3
[  146.382736] Unexpected kernel BRK exception at EL1
[  146.383378] Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
[  146.383916] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
[  146.385453] CPU: 3 PID: 1254 Comm: clone3 Not tainted 6.4.0 #1
[  146.385908] Hardware name: linux,dummy-virt (DT)
[  146.386341] pstate: 41400005 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  146.386677] pc : alloc_pid+0x3b4/0x3c8
[  146.387385] lr : alloc_pid+0x140/0x3c8
[  146.387621] sp : ffff800082cbb990
[  146.387782] x29: ffff800082cbb990 x28: 0000000020000000 x27: 0000000000000001
[  146.388180] x26: ffffbcdcf3d830c8 x25: ffff0000c75b2008 x24: ffffbcdcf3d56140
[  146.388502] x23: ffffbcdcf3d83000 x22: 0000000000000000 x21: ffff0000cb3400b0
[  146.388818] x20: ffff0000c75b2008 x19: 0000000000000001 x18: 000000000000003f
[  146.389128] x17: ffffbcdcf0fa2428 x16: 00000000fc20cdb0 x15: 00000000000001b3
[  146.389470] x14: 0000ffffc540a818 x13: 0000000060001000 x12: 0000ffffb2203b28
[  146.389943] x11: 0000000000000000 x10: 3d2db2829e5a2bda x9 : ffffbcdcf0cd74f0
[  146.390460] x8 : ffff800082cbb8a8 x7 : 0000000000000000 x6 : 0000000000000220
[  146.390805] x5 : 0000000000000001 x4 : ffffbcdcf3d5f000 x3 : ffffbcdcf3d5f2e8
[  146.391145] x2 : 0000000000000000 x1 : ffff0000c7795680 x0 : 0000000100000000
[  146.391558] Call trace:
[  146.391747]  alloc_pid+0x3b4/0x3c8
[  146.391993]  copy_process+0xd20/0x1590
[  146.392149]  kernel_clone+0x94/0x3f8
[  146.392354]  __do_sys_clone3+0xc4/0x128
[  146.392525]  __arm64_sys_clone3+0x24/0x40
[  146.392685]  invoke_syscall+0x8c/0x120
[  146.392845]  el0_svc_common.constprop.0+0xf4/0x120
[  146.393112]  do_el0_svc+0x44/0xb8
[  146.393257]  el0_svc+0x30/0x98
[  146.393512]  el0t_64_sync_handler+0x13c/0x158
[  146.393734]  el0t_64_sync+0x190/0x198
[  146.394018] Code: 17ffff74 52800041 9419763f 17ffff7e (d4207d00)
[  146.394624] ---[ end trace 0000000000000000 ]---
[  146.394933] note: clone3[1254] exited with irqs disabled
[  146.395705] note: clone3[1254] exited with preempt_count 1
[  146.405910] audit: type=1701 audit(1688127394.108:6):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=1252 comm=\"timeout\"
exe=\"/usr/bin/timeout.coreutils\" sig=11 res=1
[  146.412961] ------------[ cut here ]------------
[  146.413297] WARNING: CPU: 3 PID: 0 at kernel/context_tracking.c:128
ct_kernel_exit.constprop.0+0x108/0x120
[  146.414038] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
[  146.414894] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
   6.4.0 #1
[  146.415256] Hardware name: linux,dummy-virt (DT)
[  146.415435] pstate: 214000c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  146.415769] pc : ct_kernel_exit.constprop.0+0x108/0x120
[  146.416102] lr : ct_idle_enter+0x10/0x20
[  146.416331] sp : ffff8000800f3dc0
[  146.416486] x29: ffff8000800f3dc0 x28: 0000000000000000 x27: 0000000000000000
[  146.416820] x26: 0000000000000000 x25: ffff0000c08567c0 x24: 0000000000000000
[  146.417097] x23: 0000000000000000 x22: ffffbcdcf3d5eba0 x21: ffffbcdcf32c9b78
[  146.417613] x20: ffffbcdcf3d5eac0 x19: ffff0000ff5d0c60 x18: ffffbcdcf28c3280
[  146.418096] x17: ffffbcdcf0cc4ffc x16: ffffbcdcf0cb1d2c x15: ffffbcdcf0cb1408
[  146.418617] x14: ffffbcdcf0cd8328 x13: ffffbcdcf0c11d50 x12: ffffbcdcf22ebb24
[  146.419030] x11: ffffbcdcf22eb6d0 x10: 7b590e7dd23c6872 x9 : ffffbcdcf0da1730
[  146.419445] x8 : ffff8000800f3d28 x7 : 0000000000000000 x6 : 0000000000000001
[  146.419898] x5 : 4000000000000002 x4 : ffff43240c309000 x3 : ffff8000800f3dc0
[  146.420282] x2 : ffffbcdcf32c7c60 x1 : 4000000000000000 x0 : ffffbcdcf32c7c60
[  146.420730] Call trace:
[  146.420937]  ct_kernel_exit.constprop.0+0x108/0x120
[  146.421290]  ct_idle_enter+0x10/0x20
[  146.421634]  default_idle_call+0x44/0x168
[  146.421956]  do_idle+0x244/0x2b8
[  146.422188]  cpu_startup_entry+0x30/0x40
[  146.422401]  secondary_start_kernel+0x138/0x160
[  146.422605]  __secondary_switched+0xb8/0xc0
[  146.422876] ---[ end trace 0000000000000000 ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999853/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999906/suite/log-parser-test/tests/

--
Linaro LKFT
https://lkft.linaro.org
