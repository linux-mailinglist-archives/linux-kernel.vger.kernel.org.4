Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38F73CAD2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjFXMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjFXMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:21:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8922133
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso4414145e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609261; x=1690201261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFR35YNaQcGqljtTqigZb96yicyQhSfPK+W1MwtG1Qc=;
        b=fQ0Jj0/g8hraC+//ujaUdGnISdJuhZSqzlYtTNJFkbqaAQn94ZS1MRbEZ/6hlB+iZi
         +LrsgtrLieSflMBQqSa4DikDXR/EFQ3cOO5RmtXSIGDAGfRWturi1KhTux4m0ZmeAVGi
         YiS2wOrizlJJO9TwgSjc884uuBSQ5vSJsopmCYPSllwDhRKrQ+YT/vjRxFLdOXzB1K8R
         P1+1SIalQbR0Js89SZGXDMNcCR/sGBy1Q0DZiQ9FBNJnasfgUAj1UXcjYNE6KpwyUOs7
         y2+eoAsfUuoSbjIx1AsXyRBkwHAf4zuUab8EjVYOtvwFyZTlIgvGT1S+mG1yfWeCy1Gy
         kqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609261; x=1690201261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFR35YNaQcGqljtTqigZb96yicyQhSfPK+W1MwtG1Qc=;
        b=ktl9qy7h6pzV0Ezn7IDBcH4x2wrz5Cik5+q/Sfj3KtfaChZ4KmCXW3FrdZLxN1Iy+I
         ZmspLGaf8c7pa8AFREdaWQwLbmZOXU0kwwVVpnO5AjjMESKfZRA4I8oGDL00L3IdaFB3
         4KkLtttkZyBliHBSBYLv4eh3nVd4JxXLD6U1arwAyTb2h8vZhGmB4JUPcahuBbX6YxPW
         DMQ/E0fObcdNoYsNO0cIi2am/Gu79cZskL5jqts+Od8fdGX98wfxNDWc892+S5sI5AMR
         y1kQHy8Zb644VrRwr/jRIIzfv4eOJcxu6j7pbm1/9/7pFpPe20M1FqgVkJ3rIspRtVQj
         0Dkg==
X-Gm-Message-State: AC+VfDwmCa/6Ry42fUElU/dM+314Hu+Si4FJ1WyAfUAMln0m9HF2K5JQ
        +nkYtqcc1J6UkIbOkvtvIPju5w==
X-Google-Smtp-Source: ACHHUZ7Y/lLiiw2Du4ptFpQIG4DBcgnXX9ZY5s4tkti3QpKLzjg9BTlNfa3GoOtgo9F54jtJgwXTTg==
X-Received: by 2002:a1c:ed05:0:b0:3f5:927:2b35 with SMTP id l5-20020a1ced05000000b003f509272b35mr20797437wmh.1.1687609260981;
        Sat, 24 Jun 2023 05:21:00 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:21:00 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] riscv: add support for SBI misalignment trap delegation
Date:   Sat, 24 Jun 2023 14:20:47 +0200
Message-Id: <20230624122049.7886-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230624122049.7886-1-cleger@rivosinc.com>
References: <20230624122049.7886-1-cleger@rivosinc.com>
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
need to let the kernel handle the misalignment error by itself. This
commit adds the sbi_delegate_misaligned() function to check if the SBI
delegated us the misalignement handling. The value returned by this
function is initialize at init time from sbi_init().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 12 ++++++++++++
 arch/riscv/kernel/sbi.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5b4a1bf5f439..97c2b5d6abff 100644
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
@@ -269,6 +280,7 @@ int sbi_console_getchar(void);
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
+bool sbi_delegate_misaligned(void);
 void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
 void sbi_send_ipi(unsigned int cpu);
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index c672c8ba9a2a..18effd9e6ea9 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -22,6 +22,8 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
+static bool __sbi_misaligned_deleg __ro_after_init;
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
@@ -342,6 +344,11 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+bool sbi_delegate_misaligned(void)
+{
+	return __sbi_misaligned_deleg;
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
@@ -494,6 +501,16 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
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
@@ -624,6 +641,17 @@ void __init sbi_init(void)
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
+			if (!sbi_fw_feature_set(SBI_FW_FEATURE_MISALIGNED_DELEG,
+						true))
+				__sbi_misaligned_deleg = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.40.1

