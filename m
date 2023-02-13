Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A3693D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBMEyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBMEyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA6469B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id be8so12299079plb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygm9hLpLL1KwyacXGpOOuca3iQf7LxxYrIQu5XdYYTM=;
        b=JmbKf5O4FW7VprGWzT6pTOJ6+XRdEoQ4K+BKlOUVtq85X7g+qzslXWNCPg42IUCWhU
         rw4+oyC8n0SztanJDULrL0G4HIT5Q6o7vob1J4OfyTnIEsl1YFKX11cOkOdy9uFegNwa
         x6igQ0OwD2KhxVFTGm59+14EXLtfxvRRr1Av1QGSCWfRbEuBt4TxWInNIgMZ226q7q9/
         mmo1iJFG+ymYF8U6azYAqrHjWkWmn7/1v4j2+bnP97Jt2+z8SgCRNd94EPiNAI6ixCai
         zyDUdTGbuUYxA+xybA1iB80amQlKMk9SNsoRQEq8gcwMLoxLIaePp1DQ1hHVL5zeZHc4
         wX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygm9hLpLL1KwyacXGpOOuca3iQf7LxxYrIQu5XdYYTM=;
        b=gD7tEh756MnLguKSFiZSY0ax8TKYvQOpTaS3eNjl8HT3eIHV/Aa1nfg+prEWe7GgsA
         efMpzjg/Y4J96WUnRG/4uGfgTy3tqXqMyUbtLJegjOPIOEJhvdpA6KgnT43JwKXZpdxf
         Uhg98pFJFb6GZI46s2HXV+LGOVSpvlWyo2y7Ey+5Zqa4UvO1ai3UQ8IgBbbG2Zuyhyzk
         vKOE0tfyTLkDAIfJCNj+Ug3Soi/HRmC2dIZwtWVGLE5fv6dtL6L75lVQ6UF+r75HtCGi
         hn1zCBoVbSwPAgNECAWNaTcqnKbMf24FCfzCAEadPq8jFPQKCpl+uIqEBtRdGbkt4iKi
         42pQ==
X-Gm-Message-State: AO0yUKU50W3D6ATrs/dndKxZFy5L9NUGA5xr3p6ujOGjrIuO+vx+qB2h
        CJnmlPj/jgV7v8sfpmF/DY10dwMTz6KkFZou
X-Google-Smtp-Source: AK7set9LivmAL6nscPb/Ur0Knw2PHztkbYBAr8wiViog/IxQpf/a9GLEV3lzuzHcUxnGms82gaueBw==
X-Received: by 2002:a17:903:4091:b0:19a:73f7:675f with SMTP id z17-20020a170903409100b0019a73f7675fmr7653937plc.60.1676264044842;
        Sun, 12 Feb 2023 20:54:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:04 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 02/20] riscv: zisslpcfi enumeration
Date:   Sun, 12 Feb 2023 20:53:31 -0800
Message-Id: <20230213045351.3945824-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
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

This patch adds support for detecting zisslpcfi. zisslpcfi stands for
unprivleged integer spec extension to support shadow stack and landing
pad instruction for indirect branch.

This patch looks for "zisslpcfi" in device tree and accordinlgy lights up
bit in cpu feature bitmap. Furthermore this patch adds detection utility
functions to return whether shadow stack or landing pads are supported by
cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h     |  6 +++++-
 arch/riscv/include/asm/processor.h | 12 ++++++++++++
 arch/riscv/kernel/cpu.c            |  1 +
 arch/riscv/kernel/cpufeature.c     |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 86328e3acb02..245fb7ffddd2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -59,7 +59,8 @@ enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_ZIHINTPAUSE,
 	RISCV_ISA_EXT_SSTC,
 	RISCV_ISA_EXT_SVINVAL,
-	RISCV_ISA_EXT_ID_MAX
+	RISCV_ISA_EXT_ZCFI,
+	RISCV_ISA_EXT_ID_MAX,
 };
 static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
 
@@ -72,6 +73,7 @@ enum riscv_isa_ext_key {
 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
 	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_SVINVAL,
+	RISCV_ISA_EXT_KEY_ZCFI,
 	RISCV_ISA_EXT_KEY_MAX,
 };
 
@@ -95,6 +97,8 @@ static __always_inline int riscv_isa_ext2key(int num)
 		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	case RISCV_ISA_EXT_SVINVAL:
 		return RISCV_ISA_EXT_KEY_SVINVAL;
+	case RISCV_ISA_EXT_ZCFI:
+		return RISCV_ISA_EXT_KEY_ZCFI;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..bdebce2cc323 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -80,6 +80,18 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+#ifdef CONFIG_USER_SHADOW_STACK
+static inline bool arch_supports_shadow_stack(void)
+{
+	return __riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZCFI);
+}
+#endif
+#ifdef CONFIG_USER_INDIRECT_BR_LP
+static inline bool arch_supports_indirect_br_lp_instr(void)
+{
+	return __riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZCFI);
+}
+#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1b9a5a66e55a..fe2bb908d805 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -168,6 +168,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
+	__RISCV_ISA_EXT_DATA(zisslpcfi, RISCV_ISA_EXT_ZCFI),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 93e45560af30..b44e258a7502 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -228,6 +228,7 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
 				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
+				SET_ISA_EXT_MAP("zisslpcfi", RISCV_ISA_EXT_ZCFI);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.25.1

