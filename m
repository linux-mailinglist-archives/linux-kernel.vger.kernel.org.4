Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148F6DF903
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDLOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:52:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4173ABC;
        Wed, 12 Apr 2023 07:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eakU5xEXVc1bHQ/P+JUI0tYlmRQouDI7gKymKuPkR9dmiIEQkuAu2XJ3tO3wBk5o8hx2GdQLuHXFbYQ/vSagN0B+sg6kR7mmNNA862pHhDfwRUUy4rEQYE6R667hzh8oeI7MCWYKftVW5XqJtVgXg/qwg5a4URcJaE/xluGTpQyR1YDvxEPTkohhXU1lXw7hVLrdtqR30nsQSBoYqzksF50sBaskF5byG1BweAK+zT9WFL1bwBzl41Z4r1GWiEaKyMYRjsmV3AWGy/UsZTrvi0vAQfwHdOeDzrXvgxB+xrrKKwDWGh6ZISWpaiPM+5BIxAjpTBcVBW33yT2qjC3o3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcS4QnOhJdhWJiEAPuIKp14mG9ozzvArzlegDnAye08=;
 b=c6HbMSao3jloNX0AOo5Gl9UQKNCIF3ytM6Mhs6bzudoUogQecDIP0XRlcEp2Dat/wX9oekbmHuopcTPjbAWqYW8KYaH7pyr1ISCt+5jd2gssT/EfTYs8ysGm6HmTYH/EaRxcCy4ra8SDB4v3613WPr/kkXgzIwgOI/YmOQtYHirhgmGu0mmGDurRqt64Ak6+drjJ8afeuT5umUhYo+D1junij8HaqZnAyuhPdIUojtUIRRVSjVOBRDfVYDZuwqUffB9KECO9iIfIRH2OzPawMvEsS+lpVVHGHsfXuU53nEskwrawdazSvW1cS28AOYSS9J+jcmw4rzxNQh3Lge3eGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcS4QnOhJdhWJiEAPuIKp14mG9ozzvArzlegDnAye08=;
 b=eFmjN4+eko1yEoYeHYZKdBwcGcSCh84nucVsIHcZqLSwZ3uvT3nWDsPtb5CQItx3xz2/SBdiDEludvJQilld0c/0F/8dZFD8Gcl4iVtKyqUV3SorHq8LNoX1+K1rKWei6iZ+hNwlfVuksEeDDWDaWksOgbMFD5w2/iKFyhMfUME=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by CO1PR02MB8585.namprd02.prod.outlook.com (2603:10b6:303:15c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 14:52:13 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::fc) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28 via Frontend
 Transport; Wed, 12 Apr 2023 14:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 12 Apr 2023 14:52:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 12 Apr 2023 07:52:11 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 12 Apr 2023 07:52:11 -0700
Envelope-to: git@amd.com,
 manikanta.guntupalli@amd.com,
 michal.simek@amd.com,
 srinivas.goud@amd.com,
 brgl@bgdev.pl,
 manion05gk@gmail.com,
 linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.2] (port=34378 helo=xhdvnc102.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manikanta.guntupalli@xilinx.com>)
        id 1pmbpS-0003Bm-PI; Wed, 12 Apr 2023 07:52:11 -0700
Received: by xhdvnc102.xilinx.com (Postfix, from userid 90444)
        id F186010456D; Wed, 12 Apr 2023 20:22:09 +0530 (IST)
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <michal.simek@xilinx.com>, <michal.simek@amd.com>, <git@amd.com>,
        <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@xilinx.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <srinivas.goud@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH] gpio: zynq: fix zynqmp_gpio not an immutable chip warning
Date:   Wed, 12 Apr 2023 20:22:07 +0530
Message-ID: <1681311127-6891-1-git-send-email-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT032:EE_|CO1PR02MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 89461708-de3a-4c7f-9a85-08db3b658044
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bqm8o/P6uUkUgjxkrjETHdvJdsVFQiiV2/xIo+6zDah0KR1t8Ros3YHlHQQD97a5tlGntlmU7RxuHtFUJs31Zp8vTXqqDadS2mkq+nozFRNz7R+BgGScBmCsPBalsSCRFocTrizJvlXkkWBRDWZvvXzp9ys+/nCei8J9pMDJ5tqZ7btN+DGbf5uH5bWc0VLfr4I+OS8SZ77IL5s6CCi6kAhSgl5HKvdG6p7D+xrd4e6MYrPkvTC9xOdppbSjfhlbtOvt/U49JRsiPbbujeYdXDHz7Bmb9+GU0UzyA52SJqb4C+09J3z4T4lr8TPm/RY5gW94o84WrDC3Oogt6PdRO60xS6Uw1lmmQmD1SUqjUJVSeC3FmWlbtOI37t+rVd43/auR2dcxlR0luVREk9v1ia5YySd1DGUykNTufdBPPpULe1sEkfBRtWhT2NqFPVAknH0g+42i5eOKQpz4a2amCunC00eCVzcScufo/8T6wfXb2ENOYYSiCBECF1O1kMOM9FAsydyhs63i3zClbxeGldQkSOmdxH6sDx0C69rjfLXdUq7zXyqdtR5SkEYiPv33FoYt/iOBJJFh4cLu4mgQ4nn/gFlgCrqCXQalJFWSNk6yFjTwrcfamGPDtcdAl1ATmGve7kOF1FxghPlZA+V0KIpr7wwfsc9cNSdJosrqlNizwUJ5Idw7bs+y0SH/R8t4Se7ziq6rjTduZsSV8os3ZsfK2IS73gye9ZRaHLUyerWC7VlwsEhdnIptCOG5wLLcRNRj+aoUruezux5nGXbrO4YWrpjq2gj/LuLKXhDknEE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(47076005)(6266002)(83170400001)(186003)(26005)(82740400003)(44832011)(921005)(356005)(7636003)(2616005)(336012)(7416002)(8936002)(40460700003)(70586007)(70206006)(8676002)(4326008)(54906003)(36756003)(110136005)(42186006)(316002)(40480700001)(83380400001)(41300700001)(36860700001)(42882007)(5660300002)(82310400005)(478600001)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:52:13.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89461708-de3a-4c7f-9a85-08db3b658044
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8585
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the struct irq_chip const and flag it as IRQCHIP_IMMUTABLE to fix
"gpio gpiochip1: (zynqmp_gpio): not an immutable chip" warning.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 drivers/gpio/gpio-zynq.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 06c6401f02b8..6ce652673def 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -151,8 +151,8 @@ struct zynq_platform_data {
 	int bank_max[ZYNQMP_GPIO_MAX_BANK];
 };
 
-static struct irq_chip zynq_gpio_level_irqchip;
-static struct irq_chip zynq_gpio_edge_irqchip;
+static const struct irq_chip zynq_gpio_level_irqchip;
+static const struct irq_chip zynq_gpio_edge_irqchip;
 
 /**
  * zynq_gpio_is_zynq - test if HW is zynq or zynqmp
@@ -590,7 +590,7 @@ static void zynq_gpio_irq_relres(struct irq_data *d)
 }
 
 /* irq chip descriptor */
-static struct irq_chip zynq_gpio_level_irqchip = {
+static const struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
 	.irq_enable	= zynq_gpio_irq_enable,
 	.irq_eoi	= zynq_gpio_irq_ack,
@@ -601,10 +601,11 @@ static struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_request_resources = zynq_gpio_irq_reqres,
 	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static struct irq_chip zynq_gpio_edge_irqchip = {
+static const struct irq_chip zynq_gpio_edge_irqchip = {
 	.name		= DRIVER_NAME,
 	.irq_enable	= zynq_gpio_irq_enable,
 	.irq_ack	= zynq_gpio_irq_ack,
@@ -614,7 +615,8 @@ static struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_set_wake	= zynq_gpio_set_wake,
 	.irq_request_resources = zynq_gpio_irq_reqres,
 	.irq_release_resources = zynq_gpio_irq_relres,
-	.flags		= IRQCHIP_MASK_ON_SUSPEND,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
@@ -962,7 +964,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 
 	/* Set up the GPIO irqchip */
 	girq = &chip->irq;
-	girq->chip = &zynq_gpio_edge_irqchip;
+	gpio_irq_chip_set_chip(girq, &zynq_gpio_edge_irqchip);
 	girq->parent_handler = zynq_gpio_irqhandler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,
-- 
2.25.1

