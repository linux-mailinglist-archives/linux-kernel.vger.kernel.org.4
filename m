Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91905B4894
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIJT5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIJT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:57:20 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4808F46238;
        Sat, 10 Sep 2022 12:57:16 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 4523DDA3;
        Sat, 10 Sep 2022 23:00:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 4523DDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840057;
        bh=o1hDYZmn4yDFBMd5+ByoVGiq7qSKqoEynxMjgUEejjk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hl8P4qgVz5FgfqjOXQYVpWyvPAHMkwGtduSgVPoMy9TfSPLEg4lyApBTKwCI5qIKd
         LUVXu/wu5QIF98pa7MzROodgdcywiBRvDR4TyoudskfP4fIJJPv3PQh01M8VJvzNBo
         ohCKws/v0G8HxDh3OYW6qxH24HEhfJB4O4zfCOxw=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:06 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/15] EDAC/synopsys: Add data poisoning disable support
Date:   Sat, 10 Sep 2022 22:56:52 +0300
Message-ID: <20220910195659.11843-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though being a pure-debug feature currently the data poison can't be
disabled once it has been initialized and enabled. Irrespective to the way
the feature has been implemented it doesn't seem right since the system
may print false ECC errors in case if the poisoned address is accessed by
the kernel or by the user-space applications. It's possible since the
poisoned address isn't reserved in any kernel mm subsystems. Even though
that doesn't seem right either at least it's tolerable since the ECC data
poison is supposed to be utilized in the framework of the EDAC driver
debugging, but having the feature unswitchable can't be justified that
easy especially seeing it's not that hard to implement.

So in order to have the ECC data poison switchable we suggest to define
three possible values acceptable by the "inject_data_poison" DebugFS node:
1. "CE" - emit correctable error (as before).
2. "UE" - emit uncorrectable error (used to be any non-"CE" value).
3. Any other value - disable data poison feature.

Note we have to redefine the macros describing the data poison-related
fields of the ECC_CFG0 register in a way so they would be used to
separately switch the feature on/off and to select the type of the ECC
error. As a result the suggest solution turns into a proper ECC_CFG0 CSRs
fields setup based on the value written to the "inject_data_poison"
DebugFS node.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 8771d69f6c5a..1df5be2af1de 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -118,6 +118,10 @@
 #define ECC_CFG0_DIS_SCRUB		BIT(4)
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 
+/* ECC CFG1 register definitions */
+#define ECC_CFG1_POISON_BIT		BIT(1)
+#define ECC_CFG1_POISON_EN		BIT(0)
+
 /* ECC status register definitions */
 #define ECC_STAT_UE_MASK		GENMASK(23, 16)
 #define ECC_STAT_CE_MASK		GENMASK(15, 8)
@@ -157,10 +161,6 @@
 #define ECC_POISON1_BANK_MASK		GENMASK(26, 24)
 #define ECC_POISON1_ROW_MASK		GENMASK(17, 0)
 
-/* DDRC ECC CE & UE poison mask */
-#define ECC_CEPOISON_MASK		GENMASK(1, 0)
-#define ECC_UEPOISON_MASK		BIT(0)
-
 /* DDRC address mapping parameters */
 #define DDR_ADDRMAP_NREGS		12
 
@@ -1781,10 +1781,14 @@ static ssize_t snps_inject_data_poison_read(struct file *filep, char __user *ubu
 	int pos;
 
 	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
-	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
-		 "Correctable Error" : "UnCorrectable Error";
+	if (!(regval & ECC_CFG1_POISON_EN))
+		errstr = "Off";
+	else if (regval & ECC_CFG1_POISON_BIT)
+		errstr = "CE";
+	else
+		errstr = "UE";
 
-	pos = scnprintf(buf, sizeof(buf), "Data Poisoning: %s\n\r", errstr);
+	pos = scnprintf(buf, sizeof(buf), "%s\n", errstr);
 
 	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
 }
@@ -1795,6 +1799,7 @@ static ssize_t snps_inject_data_poison_write(struct file *filep, const char __us
 	struct mem_ctl_info *mci = filep->private_data;
 	struct snps_edac_priv *priv = mci->pvt_info;
 	char buf[SNPS_DBGFS_BUF_LEN];
+	u32 regval;
 	int rc;
 
 	rc = simple_write_to_buffer(buf, sizeof(buf), offp, ubuf, size);
@@ -1802,10 +1807,16 @@ static ssize_t snps_inject_data_poison_write(struct file *filep, const char __us
 		return rc;
 
 	writel(0, priv->baseaddr + DDR_SWCTL);
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
 	if (strncmp(buf, "CE", 2) == 0)
-		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+		regval |= ECC_CFG1_POISON_BIT | ECC_CFG1_POISON_EN;
+	else if (strncmp(buf, "UE", 2) == 0)
+		regval = (regval & ~ECC_CFG1_POISON_BIT) | ECC_CFG1_POISON_EN;
 	else
-		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+		regval &= ~ECC_CFG1_POISON_EN;
+	writel(regval, priv->baseaddr + ECC_CFG1_OFST);
+
 	writel(1, priv->baseaddr + DDR_SWCTL);
 
 	return size;
-- 
2.37.2

