Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD02B6818C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjA3SXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbjA3SXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:23:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03084523F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:22:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4004107pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7KlC1E/qchNA2FeI/jtSOoGuHWoLpY70PQmwt3/hBY=;
        b=UAEtEYB4sxc8KHHENJmXhvAQAx2IpZSpMetPcln5se48nk/nwrzG6OCr8vrvlOUK4R
         Q+wYu1Ei9STWCCcjnVi0yf8DJySBsWU4urpY0FXpxBrXWGscireaG+r2UxmjnzPvg2IL
         LxJ0jAlYtFZ2uAx70DH9AUiRgf4N/2VZIKisxxdLNHogJxvEDSHwnESsH5fIRX9kLuQH
         BSxZoAcbStJwMc5BV5sYkpWhZJcbX2j9cI28SyWWheLy+onRcrtMd6fX6MzSNd7mf+3V
         X4QmOiVfdgskQjJPOvOk4K9vQRx+ifGBs1R8C9y9NTsQKp25glwE7MQEAxzFO3dGX8kC
         Qw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7KlC1E/qchNA2FeI/jtSOoGuHWoLpY70PQmwt3/hBY=;
        b=PiaEv76/wwDiE66xZwPCv0SXX7Re2rcIBziksA7GFd6ZR5bPQx7W2Ftqv0nDeFlD6d
         Nbztmr9wYr9GrTmmC7XD6N4XEM4I54pqKEfiKn8d9C2yUB7Pnwlnk5SWwNwaZ736Kql9
         zaE74k4e1wZuxgfCJNas1W8VzmupdONeYKWpg/iG9SXwczDwV3jAmjO7/OqhjKttPl/Y
         IK50vV4hUj2EK0ABwNdZH9oxXG5OuDVk/7YQ873ueNKY6J1D+ygl0SRRjEreBMx5VDi8
         UXGJZCPzLCaFkA2W/OuZQyGcMz+k3FuzvqzHi1IcQv8wQe+3SDEEM8EcWyMt3Uqzo4uZ
         zOwg==
X-Gm-Message-State: AO0yUKWZzdN1+F2cE7dldkRhobwhb8upc9FnE9V7gq+tQBBi7bKncPyL
        KySKHxEFaRqFebn77qmehIILvw==
X-Google-Smtp-Source: AK7set9BFSU/mcgDE8X3OMCmuvOsHIDDbHvxpRXfPUvGLXJNQQEIIvYdvRJRPOqM+/blvkVNGf+CvA==
X-Received: by 2002:a05:6a20:441f:b0:ae:47a6:e6d9 with SMTP id ce31-20020a056a20441f00b000ae47a6e6d9mr13097359pzb.6.1675102958616;
        Mon, 30 Jan 2023 10:22:38 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:22:38 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH 01/24] riscv: move sbi_init() earlier before jump_label_init()
Date:   Mon, 30 Jan 2023 23:52:02 +0530
Message-Id: <20230130182225.2471414-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

We call jump_label_init() in setup_arch() is to use static key
mechanism earlier, but riscv jump label relies on the sbi functions,
If we enable static key before sbi_init(), the code path looks like:
  static_branch_enable()
    ..
      arch_jump_label_transform()
        patch_text_nosync()
          flush_icache_range()
            flush_icache_all()
              sbi_remote_fence_i() for CONFIG_RISCV_SBI case
                __sbi_rfence()

Since sbi isn't initialized, so NULL deference! Here is a typical
panic log:

[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc7+ #79
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : 0x0
[    0.000000]  ra : sbi_remote_fence_i+0x1e/0x26
[    0.000000] epc : 0000000000000000 ra : ffffffff80005826 sp : ffffffff80c03d50
[    0.000000]  gp : ffffffff80ca6178 tp : ffffffff80c0ad80 t0 : 6200000000000000
[    0.000000]  t1 : 0000000000000000 t2 : 62203a6b746e6972 s0 : ffffffff80c03d60
[    0.000000]  s1 : ffffffff80001af6 a0 : 0000000000000000 a1 : 0000000000000000
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[    0.000000]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000080200
[    0.000000]  s2 : ffffffff808b3e48 s3 : ffffffff808bf698 s4 : ffffffff80cb2818
[    0.000000]  s5 : 0000000000000001 s6 : ffffffff80c9c345 s7 : ffffffff80895aa0
[    0.000000]  s8 : 0000000000000001 s9 : 000000000000007f s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : ffffffff80824d08 t4 : 0000000000000022
[    0.000000]  t5 : 000000000000003d t6 : 0000000000000000
[    0.000000] status: 0000000000000100 badaddr: 0000000000000000 cause: 000000000000000c
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fix this issue by moving sbi_init() earlier before jump_label_init()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 86acd690d529..4335f08ffaf2 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -270,6 +270,7 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 
 	early_ioremap_setup();
+	sbi_init();
 	jump_label_init();
 	parse_early_param();
 
@@ -287,7 +288,6 @@ void __init setup_arch(char **cmdline_p)
 	misc_mem_init();
 
 	init_resources();
-	sbi_init();
 
 #ifdef CONFIG_KASAN
 	kasan_init();
-- 
2.38.0

