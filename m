Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6131873C3FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjFWWVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjFWWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:20:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9B4270A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:20:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b543f7e53aso8862415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687558846; x=1690150846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSNCaOQLase6R78rglYt4Rjd26nSgMIZzTltF0nRgNc=;
        b=LtPhohUcJlv52xMIVRCXAw8B7ne2l6il1uC9q65UIsvfKhdD+DnCmBqlyRJ7IjCx06
         lXXBEHo7vIuBXEDbWmEIUUPUkMhEarommF1dNcFAnTJSl+7r9U9RQmW9NxB3fL79aVf5
         zlDLpUNch5Yo47NMDGXMKT21peJBH6tcJnj36E7VwxJHkaeJ3bEIJiRT4mf04z58jZao
         Ofb2oDPuahkTvwln68mT6vUJ791BrJ+E+aZUbkeMNgDEA9z/vBjE1a0RHqQqwPQKmBgB
         XXUq2qeBHRqew7g5lhHx3UQwF+Uqe7eOCfLp619JdlpEAU4rg93u1+O3pl/9+SKrODtF
         whjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558846; x=1690150846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSNCaOQLase6R78rglYt4Rjd26nSgMIZzTltF0nRgNc=;
        b=aXm4WPfmWSB64dQdbBvpJh8hJpQ2cKMRGBo6Vg/CcmRG1b6QqdlQn+Xhjlth8f0tvJ
         ydX89taF8N4azYRk983YwkWxxkrGOhCcB5vLEfZ2NGJ7hKWg0uBLah/MknQyxgICqzSi
         3uJMikS/CMyPzS/Y1kMYpkPpaXyugBQTynQT2H7SkDJ1W7Ab7DKRWkzr1M9ZJf6iNSr5
         opgOuR6a69TCaReiVOuy3ymjnCNgMP7FRzpVKIzKtN8SBgbJcQmfzPfANS49+XAx+qKz
         H2Pkqjg+MGNmUltbba0dc9vj1doFVjAEfifCj6ShnfPW/WPDYUudOCDKwyJOfEotERS5
         CHkg==
X-Gm-Message-State: AC+VfDxw9QodGW/w/LQvmlg899RMMxJx5gCKX4rHdAv8lFWcXmLgi3kc
        w1yBYHSUCr8nvt67SQBla3Wlfw==
X-Google-Smtp-Source: ACHHUZ4EVHfJqU1ilq3/qiO6Tc2JAY6CRZISTiee+Hg9pywoB1Cb8B91JQTqGo3XNM9XY6iZaCII+A==
X-Received: by 2002:a17:903:1cb:b0:1b6:8120:3fb0 with SMTP id e11-20020a17090301cb00b001b681203fb0mr487586plh.5.1687558845792;
        Fri, 23 Jun 2023 15:20:45 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id ju20-20020a170903429400b001a80ad9c599sm35535plb.294.2023.06.23.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:20:45 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Simon Hosie <shosie@rivosinc.com>, Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] RISC-V: alternative: Remove feature_probe_func
Date:   Fri, 23 Jun 2023 15:20:16 -0700
Message-Id: <20230623222016.3742145-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623222016.3742145-1-evan@rivosinc.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
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

Now that we're testing unaligned memory copy and making that
determination generically, there are no more users of the vendor
feature_probe_func(). While I think it's probably going to need to come
back, there are no users right now, so let's remove it until it's
needed.

Signed-off-by: Evan Green <evan@rivosinc.com>

---

 arch/riscv/errata/thead/errata.c     |  8 --------
 arch/riscv/include/asm/alternative.h |  5 -----
 arch/riscv/kernel/alternative.c      | 19 -------------------
 arch/riscv/kernel/smpboot.c          |  1 -
 4 files changed, 33 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index c259dc925ec1..bf42857c977f 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -117,11 +117,3 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		local_flush_icache_all();
 }
-
-void thead_feature_probe_func(unsigned int cpu,
-			      unsigned long archid,
-			      unsigned long impid)
-{
-	if ((archid == 0) && (impid == 0))
-		per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
-}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 6a41537826a7..58ccd2f8cab7 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -30,7 +30,6 @@
 #define ALT_OLD_PTR(a)			__ALT_PTR(a, old_offset)
 #define ALT_ALT_PTR(a)			__ALT_PTR(a, alt_offset)
 
-void probe_vendor_features(unsigned int cpu);
 void __init apply_boot_alternatives(void);
 void __init apply_early_boot_alternatives(void);
 void apply_module_alternatives(void *start, size_t length);
@@ -53,15 +52,11 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			     unsigned long archid, unsigned long impid,
 			     unsigned int stage);
 
-void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
-			      unsigned long impid);
-
 void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
 				 unsigned int stage);
 
 #else /* CONFIG_RISCV_ALTERNATIVE */
 
-static inline void probe_vendor_features(unsigned int cpu) { }
 static inline void apply_boot_alternatives(void) { }
 static inline void apply_early_boot_alternatives(void) { }
 static inline void apply_module_alternatives(void *start, size_t length) { }
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 6b75788c18e6..85056153fa23 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -27,8 +27,6 @@ struct cpu_manufacturer_info_t {
 	void (*patch_func)(struct alt_entry *begin, struct alt_entry *end,
 				  unsigned long archid, unsigned long impid,
 				  unsigned int stage);
-	void (*feature_probe_func)(unsigned int cpu, unsigned long archid,
-				   unsigned long impid);
 };
 
 static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info)
@@ -43,7 +41,6 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
 	cpu_mfr_info->imp_id = sbi_get_mimpid();
 #endif
 
-	cpu_mfr_info->feature_probe_func = NULL;
 	switch (cpu_mfr_info->vendor_id) {
 #ifdef CONFIG_ERRATA_SIFIVE
 	case SIFIVE_VENDOR_ID:
@@ -53,7 +50,6 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
 #ifdef CONFIG_ERRATA_THEAD
 	case THEAD_VENDOR_ID:
 		cpu_mfr_info->patch_func = thead_errata_patch_func;
-		cpu_mfr_info->feature_probe_func = thead_feature_probe_func;
 		break;
 #endif
 	default:
@@ -143,20 +139,6 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 	}
 }
 
-/* Called on each CPU as it starts */
-void probe_vendor_features(unsigned int cpu)
-{
-	struct cpu_manufacturer_info_t cpu_mfr_info;
-
-	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
-	if (!cpu_mfr_info.feature_probe_func)
-		return;
-
-	cpu_mfr_info.feature_probe_func(cpu,
-					cpu_mfr_info.arch_id,
-					cpu_mfr_info.imp_id);
-}
-
 /*
  * This is called very early in the boot process (directly after we run
  * a feature detect on the boot CPU). No need to worry about other CPUs
@@ -211,7 +193,6 @@ void __init apply_boot_alternatives(void)
 	/* If called on non-boot cpu things could go wrong */
 	WARN_ON(smp_processor_id() != 0);
 
-	probe_vendor_features(0);
 	_apply_alternatives((struct alt_entry *)__alt_start,
 			    (struct alt_entry *)__alt_end,
 			    RISCV_ALTERNATIVES_BOOT);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index e34a71b4786b..054f2d4474d0 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -246,7 +246,6 @@ asmlinkage __visible void smp_callin(void)
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 	check_misaligned_access(curr_cpuid);
-	probe_vendor_features(curr_cpuid);
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
-- 
2.34.1

