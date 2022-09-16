Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3935BA5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIPEXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIPEXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:23:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFB6E883
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:23:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so19241299pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gvdjpHS/YRkH0vho3frtzgK80BilJG2+eEXjf2bW/zQ=;
        b=JcV1gWeBnsQpr8IFqM1+cNtK3uJZja8fNUZDQ9YI32sLk50HAJeJHl8CtuLS0PXkF1
         bt8oDuJ+JN1bl77ccVAq5lwZQNC7l++U2iAztTCBPnoSxu1cTU+6Dr9hs2glfYM4yf09
         8kmNhFJRFeOsax8NwX9CBfSKXbeMXz2OHU3cGE3e9PbAsbQTZ0v8JoOO+0yHnQXU5OtV
         GDf+DQDJjUGr4ucmj+WbBhKV8+M03WKpLvZR68yhxLFN6GhWtkPbT5jhahFYTtdPE2SX
         BYRR6rco9AMkf69xO+CGlY/878xxKJA3DNg3hv8A+uZwjXcyp64zU/wnKB7rLAqunwgu
         cBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gvdjpHS/YRkH0vho3frtzgK80BilJG2+eEXjf2bW/zQ=;
        b=2/WgK6QdNelYfLBQQqTmfd4aYGe7WxZcEBIaoCFWt2TH1Vilz3ciYg0QR+355yOUGr
         ymU9r5ilDslhv0U8LsuLRP4YLzd1Dh+yUsgtWxK7KLiDoXZKHiCK/580J9qZuxFCjVNU
         mM1PLjmFX7sGNsLrBzCthgImSCeVw5IG72UIqSgfh5ZPCHW11Q9rKOzK/HtMYy/HXnU5
         20D773vfTIs2NqInGLQEmXNQihK2bg5kTQZUDLlbIpc3OR1D5apyTH1fzWg8QEK9bp39
         eFnksgSUNKJbEZhwiQtADHO/wqzjUIHdW72y2QZ8UMuNSIv5pL4SK9s0x/Etjc6MA9ii
         S7zg==
X-Gm-Message-State: ACrzQf1FirVSYT9Vvn669NmTU2kam//W3Yi1QOR8ILwq79riRg+WQMEO
        icpFKQ4RrwbxXh5PhkvL09/4ng==
X-Google-Smtp-Source: AMsMyM4cNNU9y7eTJK5lmnGYbYr9GG/UfHslV3Qdx3TRxlr05zTuKGANPDIp17c/0MkdgUZJJIB8Jw==
X-Received: by 2002:a65:56ca:0:b0:439:169f:f027 with SMTP id w10-20020a6556ca000000b00439169ff027mr2792866pgs.580.1663302214959;
        Thu, 15 Sep 2022 21:23:34 -0700 (PDT)
Received: from vineet-framework.ba.rivosinc.com (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id x4-20020a623104000000b0053e6eae9668sm13257286pfx.2.2022.09.15.21.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 21:23:34 -0700 (PDT)
From:   Vineet Gupta <vineetg@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Muellner <cmuellner@ventanamicro.com>,
        linux@rivosinc.com, Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Date:   Thu, 15 Sep 2022 21:23:31 -0700
Message-Id: <20220916042331.1398823-1-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916030552.1396820-1-vineetg@rivosinc.com>
References: <20220916030552.1396820-1-vineetg@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now the software stack needs work to support ztso. Until that work
is finished, disallow binaries needing TSO.

This patch is needed to help ztso ratification and prolifiration of tso
bits in tooling.

Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
Changes since v1
  - Build error (and boot tested on qemu)
  - Improved the comments a bit
---
 arch/riscv/include/asm/elf.h      | 11 ++++++++++-
 arch/riscv/include/uapi/asm/elf.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f53c40026c7a..b6b4542b3039 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -26,10 +26,19 @@
 
 #define ELF_DATA	ELFDATA2LSB
 
+/*
+ * Make sure the elf being loaded is compatible with extensions.
+ *
+ * In the final incarnation this will get the extension list from DT and
+ * make sure elf can run on given hardware+kernel.
+ * For now disallow TSO built binaries.
+ */
+#define rv_ext_ok(x)	(!((x)->e_flags & EF_RISCV_TSO))
+
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+#define elf_check_arch(x) ((x)->e_machine == EM_RISCV && rv_ext_ok(x))
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..fa9e4c52c7ac 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -32,6 +32,8 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_RISCV_R_TYPE(r_info)	ELF32_R_TYPE(r_info)
 #endif
 
+#define EF_RISCV_TSO		(1 << 3)
+
 /*
  * RISC-V relocation types
  */
-- 
2.34.1

