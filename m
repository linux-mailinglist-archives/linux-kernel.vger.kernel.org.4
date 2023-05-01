Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF96F3A73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjEAWb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjEAWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:31:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6535AE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:31:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab01bf474aso7910055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682980274; x=1685572274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXm/tgLzEaGj3Rix4J06OEcQf8M6HZHHr5wrveDhLac=;
        b=uNXCtmG/W7IV7s7yocLEoqJ5vT3qk98iE/mn+Dk93JGanuKtaW0aod4T8YX31U4wNq
         +Myrxt7knt7un883vWifP6rREGDFsgvqpffOIjB/AOEVOPmy5Zo13mNnjVAb9PyQATnU
         nzrHAgLUZbzvqP+IdBy01oX9POttMlVo29Y27VpAosE8THHu/zh0OXJSPHHcjkBh68wV
         T0i8P5TIj9lp3DUW4aOVVXU0IrAh6fL4/u8QHej/jS4MOkpDNlRnIv4Xglc8pnFNt78e
         WNgJMtI7hFoLN7lYwSVGquexypVwcC09VWVwRL38ZV+zuQNsGzBRDoDyZX6MjR3alnwy
         aYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980274; x=1685572274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXm/tgLzEaGj3Rix4J06OEcQf8M6HZHHr5wrveDhLac=;
        b=YW0K6sjw6sRWC+cWXHJHSafJ9X3dIcFW996RG/xneMkVJ/hS/MdzHTRfOrDrxFPAqs
         gFcgAY/NXjP5eX6TFPvaJiYHtxtiGKenhyVY56l+G+QHKDbBeBPCTqYlSyK0/Gam1v/U
         sE+Pfov2/37NxPMebtHiJ5aoT/okNMEYlQuvQFgvK9VtOBpTT/70C2ClFRUuRO3ohy9A
         +roJ0dy/uEkXi0ihub3mY2tes1wBtHEQ3pqlsqKLNi9htoCYDW3CWoGh64bhCmFgs8LG
         JCg/zkPfVVJkf6WaknfnHoQa0tPSX5p0Nt77PavLgPZKylXm/GWVfLO16LldTUdK/HpD
         CcxA==
X-Gm-Message-State: AC+VfDyz41hKctY+s7j5FolqHVXSwHsjS/eEUvMZ9kwpZApuYoye2x5o
        mcSztqDFMnxBdT/uqbIzqIMZog==
X-Google-Smtp-Source: ACHHUZ6GKYuz2C56X0924d80f0Z5C9wNPfa99LOemIVyrLAlyLrwed+fO0GCuZjxamVBvL7g4ws92w==
X-Received: by 2002:a17:902:7085:b0:19c:f476:4793 with SMTP id z5-20020a170902708500b0019cf4764793mr14157336plk.51.1682980274025;
        Mon, 01 May 2023 15:31:14 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:fbcf:c418:4edd:c5dd])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b001aad714400asm4563977plg.229.2023.05.01.15.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:31:13 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: compat_syscall_table: Fixup compile warning
Date:   Mon,  1 May 2023 15:33:54 -0700
Message-Id: <20230501223353.2833899-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

../arch/riscv/kernel/compat_syscall_table.c:12:41: warning: initialized
field overwritten [-Woverride-init]
   12 | #define __SYSCALL(nr, call)      [nr] = (call),
      |                                         ^
../include/uapi/asm-generic/unistd.h:567:1: note: in expansion of macro
'__SYSCALL'
  567 | __SYSCALL(__NR_semget, sys_semget)

Fixes: 59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
This fix was in the v9 of "riscv: Add GENERIC_ENTRY support and related
features" [1] but was dropped in v10 [2] with the prospect that it would
be submitted separately. That seems to have not happened so I am
submitting it now. I want to silence the riscv warnings when using W=1.
With this patch applied to riscv/for-next, I no longer see any warnings
for riscv.

[1] https://lore.kernel.org/linux-riscv/20221130034059.826599-4-guoren@kernel.org/
[2] https://lore.kernel.org/lkml/20230222033021.983168-1-guoren@kernel.org/

 arch/riscv/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 0fee73a20c87..c2ff6440767c 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -9,6 +9,7 @@ CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
-- 
2.34.1

