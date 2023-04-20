Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E516E9CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjDTTtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjDTTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:49:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B65259
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:49:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b6d0b9430so1088936a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682020179; x=1684612179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UtIV1rNad+J3zNsKedH1zIW6ZGZZJZBqOnwneD7uhk=;
        b=USPH5vqFJff9A1Oux9rh+4fIhd2akT+l2CVCPVya7BR8ATdGcYQJ30iedgbwQwhrwM
         Dy2n0hD2K/9hF7IuePSh2ZNH8q0uCzE+cKoLXpwzOxYP8J7cCQD1fL7wPuO3GsOVzWKF
         ysapgyhSVbgAUWR3VO7GI7WPEzEP8nAUDZkUrkqcQzYClSWkN9wXCDiNZzHqxiApod1U
         dI8OuOXA0qMeIhWG3W+gAK060cJorOhGUaxwVAWjV6DjiioAu0ml9L3ODLgR7cGZNEiV
         Ffd5G7V5LrhPq3UVBiMh7OmutIZAL9SIL6wyEH39YUlY4MobnrJzPdf77Da7rfv4o8E/
         6n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020179; x=1684612179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UtIV1rNad+J3zNsKedH1zIW6ZGZZJZBqOnwneD7uhk=;
        b=F80JmJmbMRNczC7zqI2sLc/mrVM3b3tpTo40LiRK2XqHx2F/GOUL5EZgQ0OV35iQnE
         gBLHKFqiSrpqmsaC2ZD+tS3OwP3KPGj5oG3p8/yexEkQLCksRkN3tgxG7E8myBeyBGZP
         4FBkIvarjY5HFHaYV1CAy5FcsqjefmvYNFuw1u2X+CTDgw1q4agvD059d3Muf4tISdaM
         zwEJNBD/ZaU1CSVpQ6OWehcih9/mgAU9a3snvfJvyhmy9a38advAeFWiXq0kt9F94CH7
         LA9DllyrJ+BDP2B2nabsvEraZlTW6AUf/DywRTENb0rA94HvmCuuzfy3uMn6T2AM0/3y
         GGBg==
X-Gm-Message-State: AAQBX9cY8GIvRjPLUhqiFBzPkrUr5X67hyKPZrbv+l/IugWq3lP3zopU
        4viy+Y2w2lUDc4lcWacbWTozZg0xJO3SS3A0kws=
X-Google-Smtp-Source: AKy350b0kirUfjsxMugPMVjEp8DXcYkAaH0bwjlPrCUmR6CEf9zui9W0nRlSZFo0ZIo5fFxgbUJ8dg==
X-Received: by 2002:a17:90a:6486:b0:247:abb6:1528 with SMTP id h6-20020a17090a648600b00247abb61528mr2653185pjj.2.1682020179089;
        Thu, 20 Apr 2023 12:49:39 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn14-20020a170903050e00b0019d1f42b00csm1514395plb.17.2023.04.20.12.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:49:38 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: hwprobe: Remove __init on probe_vendor_features()
Date:   Thu, 20 Apr 2023 12:49:34 -0700
Message-Id: <20230420194934.1871356-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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

probe_vendor_features() is now called from smp_callin(), which is not
__init code and runs during cpu hotplug events. Remove the
__init_or_module decoration from it and the functions it calls to avoid
walking into outer space.

Fixes: 62a31d6e38bd ("RISC-V: hwprobe: Support probing of misaligned access performance")

Signed-off-by: Evan Green <evan@rivosinc.com>
---

 arch/riscv/errata/thead/errata.c     | 6 +++---
 arch/riscv/include/asm/alternative.h | 2 +-
 arch/riscv/kernel/alternative.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 1036b8f933ec..a86c4facc2a6 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -118,9 +118,9 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
 		local_flush_icache_all();
 }
 
-void __init_or_module thead_feature_probe_func(unsigned int cpu,
-					       unsigned long archid,
-					       unsigned long impid)
+void thead_feature_probe_func(unsigned int cpu,
+			      unsigned long archid,
+			      unsigned long impid)
 {
 	if ((archid == 0) && (impid == 0))
 		per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index a8f5cf6694a1..6a41537826a7 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -30,7 +30,7 @@
 #define ALT_OLD_PTR(a)			__ALT_PTR(a, old_offset)
 #define ALT_ALT_PTR(a)			__ALT_PTR(a, alt_offset)
 
-void __init probe_vendor_features(unsigned int cpu);
+void probe_vendor_features(unsigned int cpu);
 void __init apply_boot_alternatives(void);
 void __init apply_early_boot_alternatives(void);
 void apply_module_alternatives(void *start, size_t length);
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index fc65c9293ac5..6b75788c18e6 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -31,7 +31,7 @@ struct cpu_manufacturer_info_t {
 				   unsigned long impid);
 };
 
-static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info)
+static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info)
 {
 #ifdef CONFIG_RISCV_M_MODE
 	cpu_mfr_info->vendor_id = csr_read(CSR_MVENDORID);
@@ -144,7 +144,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 }
 
 /* Called on each CPU as it starts */
-void __init_or_module probe_vendor_features(unsigned int cpu)
+void probe_vendor_features(unsigned int cpu)
 {
 	struct cpu_manufacturer_info_t cpu_mfr_info;
 
-- 
2.25.1

