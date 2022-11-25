Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBD638B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKYNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKYNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:37:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1127171
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:37:17 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 607943F202
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669383435;
        bh=8DnTlIACDbzEtLRf6uyG90k2lVADApi5Q0dzsALoGgs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=gybrPLUqAFnpSc7NoZM0A616yXIXzfLYLPUSk79gfOb8kTPlXiJoc2QUyn3Hx9oCn
         ewDrTwgKkWn3Djf+r2kojXpef6fP7xMZhosMbekVPS4aHwH8x3QsWEefLod+0IfbL6
         LjuVTqvn3ys64wMuYIaDmrrzm7IK91Xuz4oUW2iUBoXQIRbmLAno+/sQu+jQSUqBWw
         b9BEqxY0zJrLnPDfGGJC+b52/1KwdhL5OXog14EdFzd/1N27oQavwXNysdUie3jWsa
         vcEZf6mPIsQd3Wmsg9/cI6fwnaVWXdqIs8df35yGo8BgAKUWgn9k5zP9IZmuhvZqKs
         rmGp423BPDX5g==
Received: by mail-ej1-f71.google.com with SMTP id hr21-20020a1709073f9500b007b29ccd1228so2286881ejc.16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DnTlIACDbzEtLRf6uyG90k2lVADApi5Q0dzsALoGgs=;
        b=P+h/ej6H1zUFjXxLYg3W8mvw0QAgZt1TT1VdgmcC/dvTVLH8bhKOiP1xymdcF+UXqy
         t+ds7AE9ibuhj2BCWXA2/anyYLG/5FYQ4RH8UWr8v8SX4/uox46FIZuHDv4lEaaUhW9T
         97xHHLTKHd1LlAdYT5GVyPu8se8hRCz+0QQvOIPHGHVUq39SNj2ccqahYvJHnxhwQzxH
         YNOV41iNgVj7AhJ9/svW2mn+m3R+bBclsMN+uN2l6FmQ+Qe1UclTVqx8anHd8npXWWrd
         y1yKpuBZyYOT1JOGK47v+mTccU/j0MaolR8rlP1gMT+YXQGPt/bCuPcHUT4x759jvbNp
         powA==
X-Gm-Message-State: ANoB5pnY4pYVtYrKywtZzWfwkeJvbfhu1qLGP0QKVAXWjSEH3rgnp9st
        0lv7stTNbxwkGF+1d4TQx9KNeo8TJ6KP+X+lTWwJeea7dzQkQdw+tsRiMddq6N9mSBOx+lqVRWR
        GvhRP/w0Yptj7HMaCjJzowCgWbbUfP2WBBLHCeEma6Q==
X-Received: by 2002:a17:906:68a:b0:78d:3188:9116 with SMTP id u10-20020a170906068a00b0078d31889116mr32469850ejb.176.1669383435065;
        Fri, 25 Nov 2022 05:37:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wOtfkriCx9cw+Ix96Y2Ld90o3KlP7uuL0BqKMXT3ekDjiRZ+U2dVi0QMpXeaZVgJGkYfb0g==
X-Received: by 2002:a17:906:68a:b0:78d:3188:9116 with SMTP id u10-20020a170906068a00b0078d31889116mr32469823ejb.176.1669383434765;
        Fri, 25 Nov 2022 05:37:14 -0800 (PST)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it ([95.236.177.174])
        by smtp.gmail.com with ESMTPSA id va5-20020a170907d00500b0078d0981516esm1585372ejc.38.2022.11.25.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:37:14 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: increase boot command line size to 1K
Date:   Fri, 25 Nov 2022 14:37:13 +0100
Message-Id: <20221125133713.314796-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel parameters string is limited to 512 characters on riscv (using
the default from include/uapi/asm-generic/setup.h).

In some testing environments (e.g., qemu with long kernel parameters
string) we may exceed this limit, triggering errors like the following:

[    3.331893] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
[    3.332625] CPU: 2 PID: 1 Comm: sh Not tainted 6.1.0-rc6-kc #1
[    3.333233] Hardware name: riscv-virtio,qemu (DT)
[    3.333550] Call Trace:
[    3.333736] [<ffffffff800062b6>] dump_backtrace+0x1c/0x24
[    3.334053] [<ffffffff806e8f54>] show_stack+0x2c/0x38
[    3.334260] [<ffffffff806f2d06>] dump_stack_lvl+0x5a/0x7c
[    3.334483] [<ffffffff806f2d3c>] dump_stack+0x14/0x1c
[    3.334687] [<ffffffff806e92fa>] panic+0x116/0x2d0
[    3.334878] [<ffffffff8001b0aa>] do_exit+0x80a/0x810
[    3.335079] [<ffffffff8001b1d0>] do_group_exit+0x24/0x70
[    3.335287] [<ffffffff8001b234>] __wake_up_parent+0x0/0x20
[    3.335502] [<ffffffff80003cee>] ret_from_syscall+0x0/0x2
[    3.335857] SMP: stopping secondary CPUs
[    3.337561] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---

It seems reasonable enough to increase the default command line size to
1024, like arm, to prevent issues like the one reported above.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 arch/riscv/include/asm/setup.h      | 7 +++++++
 arch/riscv/include/uapi/asm/setup.h | 7 +++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/riscv/include/asm/setup.h
 create mode 100644 arch/riscv/include/uapi/asm/setup.h

diff --git a/arch/riscv/include/asm/setup.h b/arch/riscv/include/asm/setup.h
new file mode 100644
index 000000000000..f4fe549aab40
--- /dev/null
+++ b/arch/riscv/include/asm/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASMRISCV_SETUP_H
+#define __ASMRISCV_SETUP_H
+
+#include <uapi/asm/setup.h>
+
+#endif /* __ASMRISCV_SETUP_H */
diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
new file mode 100644
index 000000000000..5738f93ae437
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _UAPI__ASMRISCV_SETUP_H
+#define _UAPI__ASMRISCV_SETUP_H
+
+#define COMMAND_LINE_SIZE 1024
+
+#endif /* _UAPI__ASMRISCV_SETUP_H */
-- 
2.37.2

