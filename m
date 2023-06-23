Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAED73C402
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFWWYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFWWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:24:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA71172D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:24:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54fb3c168fcso966413a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687559041; x=1690151041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T74NvB61j3v2x3seml7lOG7zGtTOHQZiKI9MSy1E1w=;
        b=2EFwKpEpn1GuiCAmqPCRobOJDLmPT0lTU5+mX/qqokC8SaZkni1sEd6wjT1x8qKcRY
         dNT0eYjJCgXS/Q/dR3chEQTYwi4xFRQJbu5blR4pzfE3h6HZPLkY4jlTRHuF3pyF7lWp
         4Zn3U4H7KcZy5oRilvTBMSFAHNsEwnk9XJAUccADwRq0dFw1AqHMlUoXkddAv025GINS
         8mY0ueJmqA5CxgM7M71zf6Oj6uKQj1WmH72AgwMqxEwrePfKsVOYBPJApmjFeatj6s4J
         YPAA6nyMGs2zJqY3GgSPTNUIce+PgAOwH839GsTPnttAOCmSHoxNSB/3q7IY70UxqN6/
         wCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687559041; x=1690151041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T74NvB61j3v2x3seml7lOG7zGtTOHQZiKI9MSy1E1w=;
        b=SHSByPasC8vHNuAlD2ugjbZqbah3hkn3+uBsSd3S5BWAiMKXun/geotAmjEA2XlMDb
         flWz9rI9GK6BG6vrNzz7XLfILamPq6rW6o6/M6y9qtifdD8h8XhwURVxHYdgeRfzfXJo
         5Jwb1YD+qODl2fv0G9ST62uqCMv9bfUV1WTe31OjYMuRMKy2eIv+KlwMXt9ksrnM7Iz6
         m5+8bhWOTJIfY8CXO1SCtaSrBSQgxgEEGuLMLMFPMtBmTaM5s7dhATN/zN/uN2/s/yXo
         FmZmpKRl2Rd7147tT3gViZYiPJKjmHuhkZPOEVqz5ry9jd+vv81FAxHUHwAY/x/W9hyr
         dvaQ==
X-Gm-Message-State: AC+VfDxdygjvm9LDNnMK1GzdFmWUog9RFXy8pPlaG7+kZLx0yxT/uAQC
        QzGC3gIoB4WWfVM9E65oNVU9Yg==
X-Google-Smtp-Source: ACHHUZ7h6vGDPAtA6v9YZudL2WUx8yi3iZ4W2PvpdY7L2JNMgMAhH95t/BMWZcJwI+1tYmX35sWHJQ==
X-Received: by 2002:a05:6a21:3293:b0:10a:ee1b:fdc4 with SMTP id yt19-20020a056a21329300b0010aee1bfdc4mr28198131pzb.47.1687559041720;
        Fri, 23 Jun 2023 15:24:01 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id m7-20020aa78a07000000b0063f1a1e3003sm19429pfa.166.2023.06.23.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:24:01 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Date:   Fri, 23 Jun 2023 15:23:53 -0700
Message-Id: <20230623222353.3742384-1-evan@rivosinc.com>
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

In /proc/cpuinfo, most of the information we show for each processor is
specific to that hart: marchid, mvendorid, mimpid, processor, hart,
compatible, and the mmu size. But the ISA string gets filtered through a
lowest common denominator mask, so that if one CPU is missing an ISA
extension, no CPUs will show it.

Now that we track the ISA extensions for each hart, let's report ISA
extension info accurately per-hart in /proc/cpuinfo.

Signed-off-by: Evan Green <evan@rivosinc.com>

---

 arch/riscv/kernel/cpu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..7bb386f94f01 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -226,7 +226,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
-static void print_isa_ext(struct seq_file *f)
+static void print_isa_ext(struct seq_file *f, unsigned long cpu)
 {
 	struct riscv_isa_ext_data *edata;
 	int i = 0, arr_sz;
@@ -239,7 +239,8 @@ static void print_isa_ext(struct seq_file *f)
 
 	for (i = 0; i <= arr_sz; i++) {
 		edata = &isa_ext_arr[i];
-		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
+		if (!__riscv_isa_extension_available(hart_isa[cpu].isa,
+						     edata->isa_ext_id))
 			continue;
 		seq_printf(f, "_%s", edata->uprop);
 	}
@@ -253,7 +254,7 @@ static void print_isa_ext(struct seq_file *f)
  */
 static const char base_riscv_exts[13] = "imafdqcbkjpvh";
 
-static void print_isa(struct seq_file *f, const char *isa)
+static void print_isa(struct seq_file *f, const char *isa, unsigned long cpu)
 {
 	int i;
 
@@ -261,11 +262,12 @@ static void print_isa(struct seq_file *f, const char *isa)
 	/* Print the rv[64/32] part */
 	seq_write(f, isa, 4);
 	for (i = 0; i < sizeof(base_riscv_exts); i++) {
-		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
+		if (__riscv_isa_extension_available(hart_isa[cpu].isa,
+						    base_riscv_exts[i] - 'a'))
 			/* Print only enabled the base ISA extensions */
 			seq_write(f, &base_riscv_exts[i], 1);
 	}
-	print_isa_ext(f);
+	print_isa_ext(f, cpu);
 	seq_puts(f, "\n");
 }
 
@@ -324,7 +326,7 @@ static int c_show(struct seq_file *m, void *v)
 	if (acpi_disabled) {
 		node = of_get_cpu_node(cpu_id, NULL);
 		if (!of_property_read_string(node, "riscv,isa", &isa))
-			print_isa(m, isa);
+			print_isa(m, isa, cpu_id);
 
 		print_mmu(m);
 		if (!of_property_read_string(node, "compatible", &compat) &&
@@ -334,7 +336,7 @@ static int c_show(struct seq_file *m, void *v)
 		of_node_put(node);
 	} else {
 		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
-			print_isa(m, isa);
+			print_isa(m, isa, cpu_id);
 
 		print_mmu(m);
 	}
-- 
2.34.1

