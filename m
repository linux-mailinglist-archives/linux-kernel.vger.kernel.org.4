Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A47442E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3Trn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3Trh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:47:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8693AAF;
        Fri, 30 Jun 2023 12:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUpm6u5H8kXmzK1Kb9cJmWGzU2lRzyAXf6/ndCjVVltynVJjt2P9KS3yi8frW+zZdVgVR7oLW8iErzq/1YWsMqdU56ST54YThgiNYERCugkrN/wOWk2lQGJpmFqWqoQQWwfNsDhxxb0wGcYNGEA9WK10i+gNDj3uReeH5T3gyGCqhh203GgRst9Zakk6HvvOR7nEDVEPUswIA41RfGC79//RC6XJWn3FIn4Me+HIpqORhzqm10yrMP1r1Ck/Y9Px5r0l5/7bvUDa83BJwVfD9fzTboPF01jYlMJath8iz3uBhq6+3G1n7lq6Jk04deCbctJvQ06LJH1wkNme/d4N3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IELXkTAaMRKhRE43Nb9IlArLSIKnc2nqBxCm99DDMDY=;
 b=lghrzLud382S1D9bO2A4zIOw910uChKsFzV5Yr367dzCmfdvZPhQI7PaIZZ7a81tGQGD8ugrgcKCcnG35NaZYpq/rqKkuPSoPTcFnjP893BUaj4j12Du+IDJyhwYmaPzVFLaJYvONF90HdPOdARjtnPUsy2eeOZibxzFq1tIWnb8QNV3digqlkeuq2KdQr3+e2xUbr9OO9csZiZxtv9H9LJLni2c+iRP2Z6NjUiYXBfiVlWl/Cwk7yCsUyXAugsQMnI2K8zTe4R6f6sCDKBP77ahIeCW8UAjYyIT92d3VuRVR19ParHXCK2R8GAacvPDLRr/6hcQqNzfIIyiwdYbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IELXkTAaMRKhRE43Nb9IlArLSIKnc2nqBxCm99DDMDY=;
 b=rzbVd2ht7HN+XOGxk8wPytYeUKsh8gyWT4CkT9XJOX2aIgIrcWxFzFnN5dwFmsY58Xeizyp0KmTK7pra5/MPAcNvpZIfFD8GXyH2Ryx78gX84wb6P6SSetx5XW+rgH8asC2i0ry90c/YagW8eyZ616J/X3N1Os0UuEyre1/CysY=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Fri, 30 Jun 2023 19:47:34 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c5:cafe::4c) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.9 via Frontend
 Transport; Fri, 30 Jun 2023 19:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Fri, 30 Jun 2023 19:47:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 14:47:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <npliashechnikov@gmail.com>, <nmschulte@gmail.com>,
        <friedrich.vock@gmx.de>, <dridri85@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] pinctrl: amd: Unify debounce handling into amd_pinconf_set()
Date:   Fri, 30 Jun 2023 14:47:15 -0500
Message-ID: <20230630194716.6497-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630194716.6497-1-mario.limonciello@amd.com>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecaac92-af35-4f83-6bba-08db79a2d99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hPAHz/At72LtpnUWVEzAKvhi14o9g/t416nkH0j0J69co4ROLOGyyLdTbnhj3NHZs8mMtvr62C6Z4tOpOi3xkTYijCUyIJirIHYdtBkYRoIA+d+V63mboKWU/K+YDGGEDbpmGBLj3T8pXlItZzOpwYDuG2Aif/+RjbWWsTmbMFGW3nj/7LBWCRFZYh+Grqf5Dubc4tWQ8tXz+iL/eM3JEPm4GiXavrr8vmQq65MfrO6BwOrGEPFA4iKrjNT4wTHPmCJTAUhMv2I1MdhlGU7uYLC0NhNXYKx8DTOsdbWhQRAzPKSSzvMgSs/3YwWMiljjn0L90gk12aOhlRWRrxkWacRoM7wt5TzhQ4HV35aYyfkopAVO2ViV1x+Lrd8SPsoa8tgM1lHfFv4+9WUI098FmdiMtDIIgk5jB/tJe+D2fIwN3zO01CrVGGPYJ6llyTwR/9fHm8YtCx0wCxh4dxfcSzXXLcKslNiYHBfvfRc1mCsClCE4kemwWWyYiOYgEXkJEq5OMcJUxeUQrhfD3ZTq+ckA1XFdLgk05Eeb8TiU3prr16yzXPi+vRGzn7zNYXtTVqyQPQfFNlymiWowQDmTH+MvFGPcuHR5uiSo+zbpqDxUG+pQ8SriUS296/+b5kb9F6DCVArU6Ip7hFsm1hpTh3dYkBEj4NoWThu11hPnXnnGWlBfvIJdy5wBsvV+twtxVXdQyElQW9GQV65sn21Tc8SqIyObL6N4xrPeTM7RpA/FyLOEEOGvH3iMiihcmglyHqVAAnuK+I2ZJsrQ9p/uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(16526019)(40460700003)(186003)(26005)(1076003)(82310400005)(86362001)(81166007)(82740400003)(356005)(336012)(36756003)(2616005)(36860700001)(426003)(83380400001)(47076005)(40480700001)(44832011)(6666004)(5660300002)(7696005)(70586007)(70206006)(4326008)(54906003)(110136005)(316002)(41300700001)(478600001)(8936002)(8676002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:47:34.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecaac92-af35-4f83-6bba-08db79a2d99b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debounce handling is done in two different entry points in the driver.
Unify this to make sure that it's always handled the same.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 38 +++++++++++++++--------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index cd46a5200f9b4..a22e02e2f5d35 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -115,16 +115,12 @@ static void amd_gpio_set_value(struct gpio_chip *gc, unsigned offset, int value)
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 }
 
-static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
-		unsigned debounce)
+static int amd_gpio_set_debounce(struct amd_gpio *gpio_dev, unsigned offset,
+				 unsigned debounce)
 {
 	u32 time;
 	u32 pin_reg;
 	int ret = 0;
-	unsigned long flags;
-	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
-
-	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
 	/* Use special handling for Pin0 debounce */
 	if (offset == 0) {
@@ -183,23 +179,10 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 		pin_reg &= ~(DB_CNTRl_MASK << DB_CNTRL_OFF);
 	}
 	writel(pin_reg, gpio_dev->base + offset * 4);
-	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -794,9 +777,8 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			pin_reg &= ~DB_TMR_OUT_MASK;
-			pin_reg |= arg & DB_TMR_OUT_MASK;
-			break;
+			ret = amd_gpio_set_debounce(gpio_dev, pin, arg);
+			goto out;
 
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
@@ -823,6 +805,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		writel(pin_reg, gpio_dev->base + pin*4);
 	}
+out:
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
@@ -864,6 +847,17 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
+		return -ENOTSUPP;
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
-- 
2.34.1

