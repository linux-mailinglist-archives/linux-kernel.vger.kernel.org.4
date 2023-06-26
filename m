Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9173DD41
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFZLVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjFZLUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:20:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DB10F;
        Mon, 26 Jun 2023 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687778452; x=1719314452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W1hk6ucl8KNm2U0fXh/wXmuimq2rclUouXAdbjBH3TA=;
  b=teoQKccpY6WOzG56JwUxFZ4v/3VIav/QRUU50tghDE+nHddM0tsP5vqG
   ybdWT2tajp0qNrkKzHY8pYTIVM9nC3AP5GdXdjYye79wSMQbblirZTauO
   xYNaW6FYlXbe3jzqFYciyBWaO9GhQOHOnxNsHwubEBQskfAVW53msfmKy
   Oy5frttUcP/Gh1n4xgZLOEdZytgss6616ik5WYebhIxbSA3zBRZgjYo/i
   i0zBJ0r1sOjGFAcO7ZswUSEZLaCuhB5XsUHUXrJtxkiaXDaE8ihct2q30
   S2MMcVv0d/21RsSYb8YPk/FzkAeII8qYpFEpVPL4AsEBNdndkthRC9EF4
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="220501420"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 04:20:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 04:20:50 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 04:20:48 -0700
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
Subject: [PATCH v1 2/9] RISC-V: drop a needless check in print_isa_ext()
Date:   Mon, 26 Jun 2023 12:19:40 +0100
Message-ID: <20230626-skydiver-frown-659b982a43ad@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626-provable-angrily-81760e8c3cc6@wendy>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=W1hk6ucl8KNm2U0fXh/wXmuimq2rclUouXAdbjBH3TA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkzS3zbNKQ3J0nbH6lftSZ2Rnpt8ivbm0VXvk5y+luhUXH4 k/7njlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkzzdGhpmXL7yX/Km0bOKzqUo5Va ssct7t8czb1rt3rp6Jmsi55gcMf/gOCC7dLrsr2ElpSpft1TnRzJYmoTfWtsj/r/m2sk1IhwkA
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
always built into the kernel.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 742bb42e7e86..01f7e5c62997 100644
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

