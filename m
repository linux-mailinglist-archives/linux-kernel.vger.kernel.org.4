Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28574222E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjF2IbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjF2IaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:30:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D5D132;
        Thu, 29 Jun 2023 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688027411; x=1719563411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r0ERhmqbd2oRPwjcE5btDtDW/JjDE/JzZQK8UiDqJyo=;
  b=ledMLAo8TwYyWqkFfwWaLfpSDiGwyBeUZb6xwWTHuEsnPKg0TAPAoDOB
   O9q8ms86rVV2SfXJR0+87zb+eW6slkh2qCPRfLNoGlFWsRnK5yejMV7B3
   bKI6X44kd3gMx61tFPyb+KOJet2Y7VsaIrabYL1KR6wTYYOeMZGkD9AR9
   NcJTuVldAXaROh8VGPsCPqbnJg5ZgtigmROK1YEwH6qwAm3vLRh/yff6Z
   VUI4bQUxIvUp8s3wQJdiaBsADQ0Tcji1uS3VYOveFHUvYLBgeBJMYV7rO
   1b6wiYGg7WxRKwcbzLlxXrg18NpN8zB7B9bUt76DvxKLy1wEwK/gWaXLM
   g==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="159104698"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 01:30:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 01:30:03 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 01:30:01 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Evan Green" <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] RISC-V: add single letter extensions to riscv_isa_ext
Date:   Thu, 29 Jun 2023 09:28:52 +0100
Message-ID: <20230629-uprising-harbor-439b85492132@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3714; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=r0ERhmqbd2oRPwjcE5btDtDW/JjDE/JzZQK8UiDqJyo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClzHQ7xqHjnlcbxGS1mNHGsavkiMGXzdyGv342hJZpPbLwO +TZ2lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCJH/jP8j799dseFzfKbHPo4S24uXy Q71XbZyxy/xGq7rQ8rD/6f/5zhv0fF1gXfb5bt7bQIi3fIeDDnwq+AZx2WM/nr1yyMerk5iRkA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that riscv_fill_hwcap() can use riscv_isa_ext to probe for single
letter extensions, add them to it.
As a result, what gets spat out in /proc/cpuinfo will become borked, as
single letter extensions will be printed as part of the base extensions
and while printing from riscv_isa_arr. Take the opportunity to unify the
printing of the isa string, using the new member of riscv_isa_ext_data
in the process.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Drop the multi_letter member, in exchange for calling strnlen() in two
  places.
---
 arch/riscv/kernel/cpu.c        | 37 ++++++++++------------------------
 arch/riscv/kernel/cpufeature.c | 13 ++++++++++++
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index c89abf8ef6de..d0dfd88221df 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -160,41 +160,26 @@ arch_initcall(riscv_cpuinfo_init);
 
 #ifdef CONFIG_PROC_FS
 
-static void print_isa_ext(struct seq_file *f)
-{
-	for (int i = 0; i < riscv_isa_ext_count; i++) {
-		const struct riscv_isa_ext_data *edata = &riscv_isa_ext[i];
-		if (!__riscv_isa_extension_available(NULL, edata->id))
-			continue;
-
-		seq_printf(f, "_%s", edata->name);
-	}
-}
-
-/*
- * These are the only valid base (single letter) ISA extensions as per the spec.
- * It also specifies the canonical order in which it appears in the spec.
- * Some of the extension may just be a place holder for now (B, K, P, J).
- * This should be updated once corresponding extensions are ratified.
- */
-static const char base_riscv_exts[13] = "imafdqcbkjpvh";
-
 static void print_isa(struct seq_file *f)
 {
-	int i;
-
 	seq_puts(f, "isa\t\t: ");
+
 	if (IS_ENABLED(CONFIG_32BIT))
 		seq_write(f, "rv32", 4);
 	else
 		seq_write(f, "rv64", 4);
 
-	for (i = 0; i < sizeof(base_riscv_exts); i++) {
-		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
-			/* Print only enabled the base ISA extensions */
-			seq_write(f, &base_riscv_exts[i], 1);
+	for (int i = 0; i < riscv_isa_ext_count; i++) {
+		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
+			continue;
+
+		/* Only multi-letter extensions are split by underscores */
+		if (strnlen(riscv_isa_ext[i].name, 2) != 1)
+			seq_puts(f, "_");
+
+		seq_printf(f, "%s", riscv_isa_ext[i].name);
 	}
-	print_isa_ext(f);
+
 	seq_puts(f, "\n");
 }
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 6d8cd45af723..bf7e8e8852f0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -144,6 +144,19 @@ static bool riscv_isa_extension_check(int id)
  * New entries to this struct should follow the ordering rules described above.
  */
 const struct riscv_isa_ext_data riscv_isa_ext[] = {
+	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
+	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
+	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a),
+	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
+	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
+	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
+	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
+	__RISCV_ISA_EXT_DATA(b, RISCV_ISA_EXT_b),
+	__RISCV_ISA_EXT_DATA(k, RISCV_ISA_EXT_k),
+	__RISCV_ISA_EXT_DATA(j, RISCV_ISA_EXT_j),
+	__RISCV_ISA_EXT_DATA(p, RISCV_ISA_EXT_p),
+	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
+	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
-- 
2.40.1

