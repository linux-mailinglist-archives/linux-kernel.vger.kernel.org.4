Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525F7473BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGDOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGDOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:11:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AD10E9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:11:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55b741fd0c5so321374a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479891; x=1691071891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj3KtNcskxGwBQpyjif+BbQZv3sqa1IZuxdbRGC5RTE=;
        b=JshnIAR8bl71rt3AS3UvaRseV7AvmKEBxHoNNg0/9Qhh8a1yTEPcGhFhTWqHfZeDXO
         zz5qgL/izraxd+lACmXYz5/XoieedX/a96bKFLIFs+C9JCUM+kgTJy45aunBrt8pI7wp
         s2BOdmMUUuGkOrDbLfk8RLtcHx6lF3lCNtAp600HpbSgFjPv+cyrTalGob0f6f5gBzut
         qlBTrFkFe3yTSMx8qWX2NoLmGuh7C0/5BcgvzluimZLJDauzVr1FdM725FboXPc4Q15I
         GLG4o+IDY/QgjFlIxKEesbCulbASs1+ri51nrsgg622pfAUSMMSHkrlr31t5c+jywUVM
         NmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479891; x=1691071891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pj3KtNcskxGwBQpyjif+BbQZv3sqa1IZuxdbRGC5RTE=;
        b=KQ6cm0gSd7suE07OX/EFnGP1LNbp9+N+AdKD1blR3OmaSBMm8YY67bwpD44QaTTCvU
         +iXbqhVEeZdaMHa1TGWQwNQ0LwagfzxPk1GZb/c/TGDiiv5FlHGQ5rPk03DsCuD31720
         HgTeuzlyQ4p7Do6UnmoaJX4tDi1xNhuxXBJi7+yFoeB1tmO3LLmS1NqlEtpyrR2EWb5N
         BfBOFqgrGiJpx7ru4QMUwmxkd8HJtoO67DTAk6/9oR3XmKfGzlHAERFpip41c4bLPZLc
         Z6ak8C1SLG6X9zQK/nF9x3JDdVB3rQv1M2XkKAANYTavpVDM2fCwLcL1DUIdgdeu9np/
         ZHjg==
X-Gm-Message-State: ABy/qLaaphwVuzOYC7Fw6Rp81wr5CCSLHkWjhMSnjw8rDjaU5At26BqF
        3nqHcb2noNCpOxjysnpdNlMLvQ==
X-Google-Smtp-Source: APBJJlGJqqxOUkEZ0m69EgVitdcB3J4XS5rhZM+9Vu61VUJmXRK/Z/pitJwsMMHB6apqNoot6wAbCA==
X-Received: by 2002:a17:902:e5c5:b0:1b8:17e8:5472 with SMTP id u5-20020a170902e5c500b001b817e85472mr13650058plf.1.1688479891435;
        Tue, 04 Jul 2023 07:11:31 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:11:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 PATCH 6/9] riscv: add support for SBI misalignment trap delegation
Date:   Tue,  4 Jul 2023 16:09:21 +0200
Message-Id: <20230704140924.315594-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704140924.315594-1-cleger@rivosinc.com>
References: <20230704140924.315594-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for misalignment trap delegation by setting it with
SBI_EXT_FW_FEATURE SBI extension. This extension allows to control SBI
behavior by requesting to set them to specific value. In order to
implement prctl(PR_SET_UNALIGN, PR_UNALIGN_SIGBUS) behavior properly, we
need to let the kernel handle the misalignment error by itself.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 11 +++++++++++
 arch/riscv/kernel/sbi.c      | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5b4a1bf5f439..c1b74c7d0d56 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -30,6 +30,7 @@ enum sbi_ext_id {
 	SBI_EXT_HSM = 0x48534D,
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
+	SBI_EXT_FW_FEATURE = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -236,6 +237,16 @@ enum sbi_pmu_ctr_type {
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
 
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FW_FEATURE_SET		0x0
+#define SBI_EXT_FW_FEATURE_GET		0x1
+
+enum sbi_fw_features_t {
+	SBI_FW_FEATURE_MISALIGNED_DELEG	= 0,
+
+	SBI_FW_FEATURE_MAX,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index c672c8ba9a2a..3be48791455a 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -494,6 +494,16 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
 }
 EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
 
+static int sbi_fw_feature_set(enum sbi_fw_features_t feature, bool set)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_FW_FEATURE, SBI_EXT_FW_FEATURE_SET, feature,
+			set, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
 static void sbi_srst_reset(unsigned long type, unsigned long reason)
 {
 	sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
@@ -624,6 +634,17 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
+		/*
+		 * TODO: this will likely need to be updated when SBI extension
+		 * is ratified
+		 */
+		if ((sbi_spec_version >= sbi_mk_version(1, 0)) &&
+		    (sbi_probe_extension(SBI_EXT_FW_FEATURE) > 0)) {
+			pr_info("SBI FW_FEATURE extension detected\n");
+			/* Request misaligned handling delegation */
+			sbi_fw_feature_set(SBI_FW_FEATURE_MISALIGNED_DELEG,
+					   true);
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.40.1

