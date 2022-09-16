Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7095BA50C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIPDHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIPDHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:07:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738F272E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:06:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so24280530pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FiKTe8Q+mkTmykXyhObB1oFwfgvUMBsktlVZrzooRCs=;
        b=R9C8eSFRs6joqTEO2h/L1RdY1JKj0nMTZECQsHTHnH64wBgqPmGGb4Dp33SRbI4Hv0
         OptYZh62jSWuzrh/GoQCvnPj+4IswqwFBUp0ZbocUm/NInGbMPX93uFv0iOHQgh07IPi
         6cmgqUDiiBUV0ZaznQ2xnWsC3H/SNBfQQkJljJeAOp8IdDWyTC1VtTCuecgdI59firWO
         Z66CqesK4qwtUtAVgO6fYqaGJ3pPl4jcu1sq65RmpbrDsO0mHtbn2sV0j6xn36Re9KMV
         GPfJQUBhbwglvcqOstujo0Ebnfq5J6y+p099HChg+UzwRv2PYqUNgxsVchgeP2PfMYIe
         pjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FiKTe8Q+mkTmykXyhObB1oFwfgvUMBsktlVZrzooRCs=;
        b=4OuTFCIyLeFoMNAclIuSkRKJvov/6U+No8iPmHAzzqiE6fETnle8OR3LWrPUSgX+A2
         oTj3jhCEymRfkNz2OAkLD0iPT8LXT8mGFur/1saXaLNUO4AfaAG0jiSLDo34vMB+5qis
         LdUd85Y47gAILCZFVnsh8I+ytaDH/NtMX5mfTGnio5vNvdWePsqPq4BtE38Ke/+v4T3Y
         yi4UKBoShMmuMJhRgy8tt0CEz45vKb2OrF3tM1e8IxijlWGIsECTfCzdyS/FpOFWQZ+f
         idIF0TH3ka+ZcYu3WnwxMrOv+KMEDEvjjlXfVz4bumTL/HeygwBTPXpKcDN0M4ltDnZL
         09mQ==
X-Gm-Message-State: ACrzQf0pU2WAx0/VcNVK4xGInSH85PDwYXnNi9HUosMF4AyHqULLAXXu
        oCsDh7IIk17zc6yRxtjNXZW7QA==
X-Google-Smtp-Source: AMsMyM5Rvlb83UyNtOwLareUqsGwv3iM1I/eh9HRlOh/vlLu/kt3jxbJPpZgXvukl2uiUtkJXmYltw==
X-Received: by 2002:a17:90b:38cb:b0:203:100:bb53 with SMTP id nn11-20020a17090b38cb00b002030100bb53mr3164068pjb.107.1663297562360;
        Thu, 15 Sep 2022 20:06:02 -0700 (PDT)
Received: from vineet-framework.ba.rivosinc.com (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id l16-20020a17090a071000b00200b2894648sm330518pjl.52.2022.09.15.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 20:06:02 -0700 (PDT)
From:   Vineet Gupta <vineetg@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Muellner <cmuellner@ventanamicro.com>,
        linu@rivosinc.com, Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH] riscv: ztso: disallow elf binaries needing TSO
Date:   Thu, 15 Sep 2022 20:05:52 -0700
Message-Id: <20220916030552.1396820-1-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.34.1
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
 arch/riscv/include/asm/elf.h      | 11 ++++++++++-
 arch/riscv/include/uapi/asm/elf.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f53c40026c7a..37a47352f633 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -26,10 +26,19 @@
 
 #define ELF_DATA	ELFDATA2LSB
 
+/*
+ * Make sure the extensions are compatible.
+ *
+ * In the final incarnation this will get the features as provided by DT and
+ * make sure kernel build is compatible.
+ * For now disallow TSO built binaries.
+ */
+#define rv_ext_ok(x)	(!((x)->e_flags & EF_RISCV_TSO))
+
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+#define elf_check_arch(x) ((x)->e_machine == EM_RISCV && rv_ext_ok())
 
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

