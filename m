Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E5C748500
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjGENbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjGENax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D766198C;
        Wed,  5 Jul 2023 06:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDE5ufoOjyZjsz4eF4nqHI+6UgqssT+i94nUMM6vzfuZuyc9HQCHfnoIMIDSzORrgJkHsCdZZ3zIjTjy5dk0a4utc2Z/YbrbYflZlKYaqDC4GH2aA5+LiuMkBwbzaIzsxwPK4tEE91yX2FIDSxVViifYkfyuPF8hpTBgv4vglGN5mP8nyWdbDC4OGJ3YcfJ5FYex6O3YOIzJ2sJO+Bln/S7IyqYd9jx0yrLIcl08TNbU5bgdfn7dVmqvz28IpEviC+DQFdUzUAhkRdINAHzU+4vcD90dJ59FIzIqgWciiV/HgYnoOOv4wkUrsAEM8lBBflo0qqLukc0kAnZg4tao7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP47c21hf8Z6Kim/DkRZLCyrWk2KwUb1uFORUr+ivJA=;
 b=QkV2C+duE8t7nYrZXGHOdrsxozJ/Gro4kp5PnWIbFTaDK3m0HVCpY4kdNNijMVCaTdHh1VYyGEmTLTmWsl3dkiP+/WMaWhbc1y4DpoBpubUR0QCahWX/HJQn+KI0FNGHFy7GYYP59QoKKMXiMEgHxGUn1JZYR8tpXiEXWCTkWhv5VktVLkSmNHQ9XHxE1NBA7yensJHOya0NAWqE/vA3zTdy0ZyvKqPI/boPDo0L8+XPtUWsVmY75zYJkmCesCCqo+G6OI/Pv26dqQpGRFnMmsTtNlI+y+ZNlTfwOGtlEl8gBCKPRUvjI3+HB1/XJ9ltR8Da5nrrvlvViR5V+q0rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP47c21hf8Z6Kim/DkRZLCyrWk2KwUb1uFORUr+ivJA=;
 b=UPe5mUGKM0QA28plh3LexAF15zgx0Edkb5OURZXTdK9C8iisN6Td6spdoKX7mRGY5Dhm65+MeLkLXg8yOdnkqAUdM2TdqeUVB/xuWv+bIfH8F+QTUfJBMa7g9Xo7zHB1znYAI5zYz+WycxA8ji56c6pqBEpZDkVqJ8jDPO2vq2I=
Received: from BYAPR07CA0058.namprd07.prod.outlook.com (2603:10b6:a03:60::35)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:30:32 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::62) by BYAPR07CA0058.outlook.office365.com
 (2603:10b6:a03:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Wed, 5 Jul 2023 13:30:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 08:30:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <andriy.shevchenko@linux.intel.com>, <npliashechnikov@gmail.com>,
        <nmschulte@gmail.com>, <friedrich.vock@gmx.de>,
        <dridri85@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list" <linux-gpio@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/4] pinctrl: amd: Unify debounce handling into amd_pinconf_set()
Date:   Wed, 5 Jul 2023 08:30:05 -0500
Message-ID: <20230705133005.577-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705133005.577-1-mario.limonciello@amd.com>
References: <20230705133005.577-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 024fb443-1559-4b13-a7bd-08db7d5c01d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAleWZOwzqN6ioWxrgXQN8ch0gbKACEdC+gFCi0BF0MguJ0YUaePx/XUKBuIzQLKsXwffQCPGa6akh4W/SMLWdn7KQa0YhPFdy3k1R1GKmsOVbImvepokHcamfZR/jFdyQtGBLhOzSrMRoek+y+SZDi8dMVYqjz6m66KJ9JqkXiiN5NwjKk6srsdIMLYV9OaAqORh/bhyyaO3mGk7/blvimEAC+2fK3+QfJfYcUojRuL6IA0cSftityb+KJPzJKuWQ2WPadQd2Ab/266h0kE/CuPJQzn2kA3Lq3r+x4j9kOMVCvmCcX9PTY+1ACTOOEKpVJngI5EtdVpTMj6MYhVOyTz0hC3f+xPhegPdIBXjYzoKZ+Re5SdIyS9OSCZZE2u2nOckXbkxtwV0p/UmKPvai7zQiZNtQ8tnMtqu78HC0x28eA8zQUqgA2SqfRl/ux2cisiYbxa2yPeyvR7Sh8ZUgxT4J3jmVdkFM0H6zmtLK6SDMOB/fMGKu1GBl+Fnuc8McYXvNfsEqekcfDzZVbG1m7wRjLsqbMub0hFIP/vkmYvm9qKULiliPqML1plQhuuGxLf17u/FCgStcEn/I7wHA19VAEHQm8geIhQEtKVy5ijDr5bS+BukSsdZwy2/wV0ES/NXKXJUPIa7qIaZMsKMMAHlUYnVYyYUiDBhNoqFAgFboYFSNIXIznsFiWC/aBjfRuv1KHVlCASoUN87HVfq9JhKQUBB3ourDetTulFn6H/TtLiuGky58BZ2FomrcbrWmRH/eqol9dJiQCz13+Y5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82310400005)(44832011)(2906002)(5660300002)(40460700003)(40480700001)(47076005)(186003)(16526019)(426003)(336012)(36860700001)(83380400001)(1076003)(26005)(356005)(82740400003)(81166007)(7696005)(54906003)(110136005)(478600001)(70586007)(70206006)(316002)(4326008)(2616005)(6666004)(8936002)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:30:32.3747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024fb443-1559-4b13-a7bd-08db7d5c01d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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
v1->v2:
 * Move later in the series
 * Unsigned -> unsigned int
 * s/out/out_unlock/
---
 drivers/pinctrl/pinctrl-amd.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 44d3193a81f2a..b129d7c76b3e9 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -115,16 +115,12 @@ static void amd_gpio_set_value(struct gpio_chip *gc, unsigned offset, int value)
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 }
 
-static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
-		unsigned debounce)
+static int amd_gpio_set_debounce(struct amd_gpio *gpio_dev, unsigned int offset,
+				 unsigned int debounce)
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
@@ -183,7 +179,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 		pin_reg &= ~(DB_CNTRl_MASK << DB_CNTRL_OFF);
 	}
 	writel(pin_reg, gpio_dev->base + offset * 4);
-	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
 }
@@ -782,9 +777,8 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			pin_reg &= ~DB_TMR_OUT_MASK;
-			pin_reg |= arg & DB_TMR_OUT_MASK;
-			break;
+			ret = amd_gpio_set_debounce(gpio_dev, pin, arg);
+			goto out_unlock;
 
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
@@ -811,6 +805,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		writel(pin_reg, gpio_dev->base + pin*4);
 	}
+out_unlock:
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
@@ -857,12 +852,6 @@ static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
 {
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
-	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
-		u32 debounce = pinconf_to_config_argument(config);
-
-		return amd_gpio_set_debounce(gc, pin, debounce);
-	}
-
 	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
 }
 
-- 
2.34.1

