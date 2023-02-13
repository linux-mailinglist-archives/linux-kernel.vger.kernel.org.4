Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75768693D90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBMEyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBMEyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CA3469B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bx22so10759435pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbXUylyxKACc1XsVanFRl3U39rfU1yL9GfB2/5jAyl8=;
        b=qbWZJ8BsHCNFWj0dg8uujRetqC6jzLF98Qdv/TY62Y644xrA0UjPgnfpO72jXiPyG2
         qA0e0Qb0k4kUsZptcYNMqeekJ/ZNdE/ea06joo5oBBO3u8UyiQQzx8gt7XiQozyObdBT
         5S1fOKKeN6iFkPWI2/K55e5jV4CcFHx5d7+ztaIAS8Z/Xi2kVLIGMcO4+Og2jvtq4jPz
         RAzoR5jMvKxs+ewm1EgSWtxGFnJPdFTNlkKbcbfqa4+0ug61NJ9vJ3Wxhy+/QMypQuHt
         qlafd9m4kLvgvu8Ky98yI56IFExsd6VsJfAjUwdMf7xFelnAdTSwalMV6EmXiGgX4z4w
         oECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbXUylyxKACc1XsVanFRl3U39rfU1yL9GfB2/5jAyl8=;
        b=xcbpS/HdJJ9hVstfpsILTyKWk9/qodJ5arQgBcUYBlqD1AcYKyIhNJKW+Ooj1LM1Yp
         WvBO1wwyoXv4WWYOACvNpzW4FIGaqy51RxLXUMxs0NPTlspbmbwKozKzmKVFRhjhqajT
         RA08EHl97PVmzWQ7NzOWB4RMCaCuwAgWURD8eczqJIEQuKwkMpsYO/hmtclEZ5Sbt/Tc
         pn6IFoeaHekzc/A1QTDl7yxQJ3L46vmRtUWfGldtBacdqRn/o4H6v1pU1fri2zDV0re0
         jlmVGyatd7ayUlNXAxahYP/7dS2tBkaXsE8WrcACJJ4o2PJlSNgWVjQOtI+BGOjj0jQK
         RRdQ==
X-Gm-Message-State: AO0yUKXYMxZiJM6mhrRg/XCCDGaEtHFqaez4ASkdX0X1R/Xe2eRCPCgn
        LEis8wH7wvL8oSz0H35INtGwfZcE3sbs5d+N
X-Google-Smtp-Source: AK7set/lnkp4iEiPCYd0MC6ThFVrqXatwksChXVC+p44Jl/pjrdhLlhohkg3HazCQvlzxn0/m8o7Lg==
X-Received: by 2002:a17:903:11c3:b0:195:e2cc:6f35 with SMTP id q3-20020a17090311c300b00195e2cc6f35mr24707652plh.59.1676264046112;
        Sun, 12 Feb 2023 20:54:06 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:05 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 03/20] riscv: zisslpcfi extension csr and bit definitions
Date:   Sun, 12 Feb 2023 20:53:32 -0800
Message-Id: <20230213045351.3945824-4-debug@rivosinc.com>
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

zisslpcfi extension extends xstatus CSR to hold enabling bits for
shadow stack, forward cfi (landing pad instruction enforcement on
indirect call/jmp) and recording current landing pad state of cpu.

zisslpcfi adds two new CSRs
- CSR_LPLR: Strict forward control flow can be implemented by compiler
  by doing label match on target with label generated on call-site. This
  CSR can be programmed with label (preserving current abi). New instrs
  are provided to place label values in this CSR.
- CSR_SSP: Return control flow is protected via shadow stack. CSR_SSP
  contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 0e571f6483d9..243031d1d305 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,23 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zisslpcfi status bits */
+#define SR_UFCFIEN	_AC(0x00800000, UL)
+#define SR_UBCFIEN	_AC(0x01000000, UL)
+#define SR_SPELP	_AC(0x02000000, UL)
+#define SR_MPELP	_AC(0x04000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
+#ifdef CONFIG_RISCV_M_MODE
+#define CFISTATUS_MASK	(SR_UFCFIEN | SR_UBCFIEN | SR_MPELP | SR_SPELP)
+#else
+#define CFISTATUS_MASK	(SR_ELP | SR_UFCFIEN | SR_UBCFIEN)
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -168,6 +185,14 @@
 #define ENVCFG_CBIE_INV			_AC(0x3, UL)
 #define ENVCFG_FIOM			_AC(0x1, UL)
 
+/*
+ * zisslpcfi user mode csrs
+ * CSR_LPLR is a label register which holds compiler generated label that must be checked on target.
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_LPLR                0x006
+#define CSR_SSP                 0x020
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
-- 
2.25.1

