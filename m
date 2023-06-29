Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A8A74222F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjF2IbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjF2IaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:30:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9691FE7;
        Thu, 29 Jun 2023 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688027399; x=1719563399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yGCLTHTWBR9QgFp49drRvDK9QX9Ej+dLrWhdW/gWbA=;
  b=HdRXstiauOVZ1CUU/qqDeLkEziVSE5CsUt/Amek2Eo4VFBtOjKTZcuc3
   W/RmEzuh7F7oOfpJDcFN1A8fGhtgKUGWY8/NDpQMnHwWrZlyH9oykzK06
   1oWCOlFB+O9U3s+0GXNbwlU31S3sG/a3A333qA9TNI43mF/38XJBDCeEN
   O7UO0Bqjgplpa1ejcuHw5Yf7+VPebZxjz2uW/3LgStyP3Iwt8pLWf7kzD
   2cdFoRqlFtccSN/h6OV0pL0L0PigXFZaUeytQgMspKRoPkJhN7Q5gSdY0
   ehYBI97t440zB596NUj8eIs7E1chkZmiYKpteQ0DUCzSXH1hp7ZathdGm
   g==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="218155941"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 01:29:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 01:29:53 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 01:29:50 -0700
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
Subject: [PATCH v2 02/10] RISC-V: drop a needless check in print_isa_ext()
Date:   Thu, 29 Jun 2023 09:28:48 +0100
Message-ID: <20230629-tightly-filtrate-a0b8656035b6@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6yGCLTHTWBR9QgFp49drRvDK9QX9Ej+dLrWhdW/gWbA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClzHQ7O/5jZKX5wYerZcy4XN1QdYwg7sGWDftNq5dLY9NAA EZn4jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkzmxGhgOJoZGnTaWeGas0vN1o9v SYa3bTDhtfo/SrnC1zfaYmczP8lY9LiLpzerPj2fzdbFM01+z9fsvW0VOhOWRGysxDUt69nAA=
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

isa_ext_arr cannot be empty, as some of the extensions within it are
always built into the kernel. When this code was first added, back in
commit a9b202606c69 ("RISC-V: Improve /proc/cpuinfo output for ISA
extensions"), the array was empty and needed a dummy item & thus there
could be no extensions present. When the first multi-letter ones did
get added, it was Sscofpmf - which didn't have a Kconfig symbol to
disable it.

Remove this check, as it has been redundant since Sscofpmf was added.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Reword commit message to explain why this can be dropped
---
 arch/riscv/kernel/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 2fb5e8e1df52..ddd7634e4c1d 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -233,10 +233,6 @@ static void print_isa_ext(struct seq_file *f)
 
 	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
 
-	/* No extension support available */
-	if (arr_sz <= 0)
-		return;
-
 	for (i = 0; i <= arr_sz; i++) {
 		edata = &isa_ext_arr[i];
 		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
-- 
2.40.1

