Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE05D72E17C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbjFML0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbjFMLZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:25:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316B10F2;
        Tue, 13 Jun 2023 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrdcDAOLCdrGNAC4OHztQKCHcqQfBpMCs0fm3aM3G9MvQDl7IY+5W1JAfxvWHPS8rkYE2NK11Cur5mIEkpsWyO6D5ZvRxeWZMSYQG9Ux0Us89b/I17Uj8NnT0PLzHnmojPz7gkDOS+NajUTp3wTu20pbXZhTiHRWUFtbURwl9coOeInN+89vbXLpqNafZSAiE2ejqZASdlcVezU1XVafrCxZhD1eKMsY3O0nQWz08kHk4x+mYuaXgyVLFO2EnhXgD9Slzy7ESm2lGF41GEbTZzTYDkiyin6dGgy9L1uiIUkeeoo3GhWyF48TbFBdfU6ZB9sfHnCTUeGU+yDX2W5aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3OBtGY/5chd6gxnhXKVzWiME3BSs4Qa259qqbn6U0M=;
 b=djq6K10NVtIfL7DX2QlfvY12xxHbL50frFKu3E9ZzVrOfY6OqKkmHQNV/uW1GammBLfozW2qXIKfjtynB2RQADv7QEoxQOR+o5l06zNEdn3YQ7IxIJYeug6iIErcCKkXxY7e0RDoyXZMxpUMl0pLA2vKYRLZTmx/Tskia9zcV0z4w26GH24Y1IzJrgTVEf5J0kJ746CeTeTfeYzOxZTa6Kj3UWVwc2T8QrOeciwZmwJiOAbnIh6ONFozUJqUEsCXr/83fThnlI9135I0GYQWt1kH04kiV8jSn8lszIbyOetIRvTc1ckVtACFbscHwjhdErV7f+PquyNI0hv4kLpzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3OBtGY/5chd6gxnhXKVzWiME3BSs4Qa259qqbn6U0M=;
 b=hEx3HWtSteYa1sbtkpgJHU0ziuHZWakbSm4wvH9QWPZUeHw3VjHNowCnrozfLmGp67ET2jQ8nTuoCoSsmZXkdKsXZ6zyVuLWICiXGXWbiPSdwLgSiwBB/Cb3eh+H1Ob+npyvZ/aHwxWGDowgc4R6Lkk1aA0t4VdDbenLBJpeA+xW1XftNuvjVWUXuqNDbOCc+WbxB9IeM+bXI6bbq+N5IOs2xzZNRthRglVvLS08rBKJSe433BDOIyr+abyAxugtCQqrQJ8OFnPrGF8QKRE5S5USqn8KOqSEVusJcMIOTFVN8D5DmuutFrc/d5QeOd+DGBOLgxkn/GWaVQE1Ejss5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:25:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:25:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 03/11] thermal/drivers/amlogic: remove redundant msg in amlogic_thermal_probe()
Date:   Tue, 13 Jun 2023 19:24:36 +0800
Message-Id: <20230613112444.48042-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613112444.48042-1-frank.li@vivo.com>
References: <20230613112444.48042-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bf582a-9c9b-4399-8727-08db6c00ecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypsKW7WFVmH86WfolZK9ywLL0ipmzD8Zc/zJNAQyIo4SPsQiaKCdVzXzYUVDAZ0bpEbDk85osq1PZzfwSIWx6wqdOOqDIwYweaCb6y0BkvzxpLLKe6V41irf/TRJd4sR4wrj/3/hcLYrLiYJDC+UXe974tIQN7R0+ceyjpumbnMqoy6JXeFhnuWQMPwfUB0gkGi+5M34yG6x3JlWy14YHs/3dNm5C7c9fx7KX3xe2HaF+QTl0njc5nj7bg/zI57WwOBCS9ZRL76qkudj5AImyedSvtduZalfn5KLC7ALHrN9YdYsR7Ia5GcpO7yVRqZjTRPReHvKf0z1fTpe4YARygLNZVeeSajNoe4zZ6KVPvVR2sc4HIICZvdDcoM372gymrQqw2WFfjDraQo8qExBvneh7ACZ6P3Pz5kfojqk+G4jY5G4lPk+q/N2Q1kqS9zFTlvAiRushC72N3G3hR0+VnNGizIrDhSzqKAt9lsHsqPvVbBz9sFKswY6op4YeMqDMdytvnTmBVS+Z42fUMu38pCw1e/9aXYjFzRu/AEkHZnvvwsH0y5J9FP6bur+1VjzprvsrpjUg97+ZWK47rLhfzBYzraeIuUnIYEccs9qNceI5FJCqOKOxuvPTIdfy4b7f6q5xP7zcYJa9T9GqJ1U2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(86362001)(54906003)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(4744005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekO4vKYrOBfE9C5+gBLB0iIo0QvEBAa0MrDh1kxdEh9nvooREWm2bQ/68WPK?=
 =?us-ascii?Q?EtRSuQlLM+YcFnIuuG3/RwypL0S5cUshvHOQeRnkUAu26ApXv5QqfKHudWQz?=
 =?us-ascii?Q?UDjkOjZSv3qQrFh5BcqEaTs9dlJxxvbeVAYDBuwceksplGEm7T81emNX02QD?=
 =?us-ascii?Q?KXkiKPID9WzBSK33UEyPPxiSVa/g3HAO1ITe32BiZUDO8mZCq0DNNLn25U5T?=
 =?us-ascii?Q?7SxwPpxLyi14GSjRaO7rWTNqwtYwhd8Tm6a7k5PXtpm+t5+cNy8bHTwCP0um?=
 =?us-ascii?Q?b883cPB8KaRQ7MO/xLSIu81/2gcz7RJoPunNlOKH0ZVN/8ipixZh3yJ75rd+?=
 =?us-ascii?Q?AnFnutoOBY7LKWbi8fpHB3WytJBJcZD7tBixzifSYD5pHw/pnRt9WezZoumB?=
 =?us-ascii?Q?+iTuCKgEWU6lyKNlpMlQhlXbrn+lDuy3AOzEvkunQm4LDnYS/vMVBXNyiDwE?=
 =?us-ascii?Q?q5KRMBStfQvtTgFve7XjPixeVl1bUrQpBKTNwI6COPWsh/Zfjm4KhE8pAIQs?=
 =?us-ascii?Q?pE2/3yirnL8nqYNlv9x9K5xjWsJSx4FARPOjD05sfiFEIrlyjCWsZWxpSAzw?=
 =?us-ascii?Q?YAbZPF2NnE5AIoXuGThjX4ha4Upzil1vK5FLO6ewYYX9puXENGVT6ngegrmp?=
 =?us-ascii?Q?7STCaGxAT7tjwjk+s0DzzW+nKBuHXNpTdL6dciRQmVOdTtcs7TB9WnWXwu6V?=
 =?us-ascii?Q?QYlwU6tggV5Fc4kUOSpi8XeIA+76o4eMU1jZvVyMIFTonQWhZjUcMyK084NX?=
 =?us-ascii?Q?X3jMzHkFflPuIPa73ROfec8onpGgb/gCsy2aSaYrNZ7IolPcmocdgwwJaJoB?=
 =?us-ascii?Q?bs60GsksFaFyNWUlRXY2xxlAhFImOyt6UiGcc/juePejYFZFNQ52bXdDphjk?=
 =?us-ascii?Q?0z5Rd0GGw9q/xZg7Z0CMJUwQbjoDnBOSIJfMfzD6ZqbzV2V8rdbNcLElYZ42?=
 =?us-ascii?Q?kSAR6nLp4JMNqIzwcukmlmZcTNXZ7DoYRWEUGviLJIFFW4hoPJQjBsk9sZpe?=
 =?us-ascii?Q?prN+DUs6kGLrRgmPY1WGX9q4GgzE1kUlT+bwYZxLRzK7rE0l9XL0J+G6c55i?=
 =?us-ascii?Q?/0dTHvrDzyyOVnpMCZG9xtDbiCEB8VyWPcMtClld1HtNKfHkUwoH742pTr7Q?=
 =?us-ascii?Q?QUAoVi+5wD91qwHvXaH9eVT8epSr50zsOgJfRFHzP1owrq+kubFLMUhOrVae?=
 =?us-ascii?Q?NLI5O9Wtmee7rzao9tG2ZWuWYVafZrYyM93FYdZn7ZPWJ3r5xY6R/U2gDXOR?=
 =?us-ascii?Q?uN+I7UtY110uHP/qktCTZx7q8aHRENyeyC96BlsNflPE51TNTRy0oFwxsg41?=
 =?us-ascii?Q?lGcsez0uqHVB0ygN3fbXjNT0opG1A5j/pVlDK37msanEqJ+BP4RI1jiY3tE5?=
 =?us-ascii?Q?UzKi3wxheoU4ZLFCDzFHknfCarN2LU85FqRDeZHwLTz+1qw34HTShuiHSeH9?=
 =?us-ascii?Q?kfhl7cnlrMAl8yZZ1v3GjLs4cLqqTMqSZGhJUI1LiyWh8ALhobypk+GLERQS?=
 =?us-ascii?Q?exg9zPeWBJoscXVxrxVeAbkatcVOVROZHJGO+l4BC0wM4FhGc9lPlLF5nUSX?=
 =?us-ascii?Q?9LG+qBAKFENgQy8dqgwzHf+MbBJNZeJqsbLh/F9s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bf582a-9c9b-4399-8727-08db6c00ecfb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:25:43.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 565GL94oE5gY84BS4jEKlmHx97jDxfRT16aUOhinK9+S83cdPIlrQRjebgncYAJFTzpXPZhcRLvHKj9gmUGcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/thermal/amlogic_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 3abc2dcef408..756b218880a7 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -282,8 +282,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd))
-		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
 	ret = amlogic_thermal_initialize(pdata);
 	if (ret)
-- 
2.39.0

