Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3622747051
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGDMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E830185
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhZKTzbAKC3d+TwjxPuaqypkLBfwtEjnn1FlvqagdosBVH4nXpn6g50gZE9jaqbZIEKZ7BY6PcNc1J1gB4j4jVWRbIZDalRsCGTd+SvDPNiUU/AX6ezbptceeuQCfMUHOADZ4Tc5RgKWRHPC422yZSGWezH+w7bEdldl1uJu3YbLNU5seRN/+uV9hoxKHCrrveY8naP05uK1GD3HcDGc1eSosV+Y66mztMOxxZy2QZ12LKm0TeCwFu8oJQWjfZa5WwQUDIMl/4ZvlN0iNDX390Th8l0W/tjSnoXe6yFTNtCZ51HTeb0xVN8XWGfmp0G+MX6TnzS+DP1LEVtqnX8Eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5Yebta6240tO0qEIRa9JUM8K5FM3tzmxoh0F7aQ1sg=;
 b=dXJ37YFfuTZrItAgjyfzzp5RCKqFDUJ0ZukbsC0AzINpg/TjLLRGaB1k9XGoQzD9KBN8K8oW0whLMKIHedHo5CqTXWUfhIewYqufieJFKbb34fWotSwVEyTN65SUJkfE9ZZKH+b4JhFVbsIojMMqGia0CntIwH6KNzIR3xZcjPW8RathElgo+QPU4jpRiT3sYGCVYP5Xo2gjfbvgTjXr7+LPSBknq/QGUvQNcQ2YaBc6HFaGGWOPPgMhOLGct+ToBdTwzJOX93aOVf0M//WERYtppyG1OT/GptYuknnEzqpK2EnFknMa7sCciDeoNoy05CIm2q+eUfBszKo3UsainA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5Yebta6240tO0qEIRa9JUM8K5FM3tzmxoh0F7aQ1sg=;
 b=IIUR6+6V4GnCFAn5QHeT7kffciX2DPTbK3RAYOrsCjjdlxbW8/YgRjgRbyU5qd/Os62ArnhOjWWu4N2GEE4A8fGELS0ZhL8rdHtdNS/15Hx59ra1jLX8Ub6Aj12VLVCJqWVi502c7zytLUNYggH6hwDd4ewHVz+FEMZCbsQkf9YDogU8O/uASp1n1Uv8wdLjk8+N9HmIULcKkhTYWK7T1Rne/NxdPsrNp2hlAN3gHLGP0l4K8iPDJGgQfkFjM/unTXimCN+1cDrVE4hR/kxEoALpFazdzZ9fSCBuurfYk3kuEFaID/BHS++sDg7sY+n8bBOZgxf+EW71+FxdqXkdTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB4999.apcprd06.prod.outlook.com (2603:1096:101:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] reset: meson-audio-arb: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:06 +0800
Message-Id: <20230704120211.38122-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b4d7d2-4a4a-4aee-dbc0-08db7c8687fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6S45b7vWoyVB77mEWXrDBbBq12WgfGjYqouNKSMGYAVZL5lrNL08wbOGXCpLNZeiAcA5H08cRGSF+aVhWlRWhKKqOt4BEJZKWliStzP3a8NFGI0Rs8lm23Bx1i5SGL8Bp3qNDuVtH0T4Ar/mr32M+P+8E4ewB4JcYNSvYBrFsT40jfxRCcbgBzL8ONrNIG4aoGNHR8JcA+RqEFn+kmzkG6cgwZARdQnkdNbZpt4E1YWgBHQDTnlHoYmCzVOExki4z52iBPq0KSfKDJFfqbGNkHekJ7c7lfcOASNBPciXDO+BscktAw2fs2BokGNADCw/YeLDT7um8x3zITjcUJVXm4FgnUeqFS1H9Q1JmpBZlgShUhly/JzGP2ypbXBjdadabX/uUpwB5gZZV0rBzTIMB2euqyoxj4GDz9l/BANhlc/h74uGe0PEMgA69J4ZOV76p2GK5pOdUkLQpGfjfGSGjuDY826WlDmXZAu8kbvaveXI315HU7ysO7NH1RnjcwObnNkZlkxApGpt7mYMoGOjpcSDU4s1qJV0pwLm8SIKIcmG1DyvoQjOWMpqQJ1CEeQI64JMQgAs3orESDHhhkCMhmYjgiQMO9vGY2y5y9NiWt2c5UJJ5z/UCIZQafAY4S97
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(6666004)(38100700002)(52116002)(38350700002)(2906002)(6486002)(8936002)(110136005)(8676002)(36756003)(41300700001)(478600001)(5660300002)(66946007)(66476007)(1076003)(6512007)(186003)(26005)(86362001)(6506007)(66556008)(316002)(4326008)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2ygVbU10EOzlBEIA2Z7VAV84Df72gYAVOZ4Dd2ZI+bbwSEOVBDY5FP+nrs6?=
 =?us-ascii?Q?run7+/7ego/hQChwPmcgVClzw9RN/FMPzoGAbIzU084fNOMLu2DZAPmnHNJz?=
 =?us-ascii?Q?A6B52TUq39alLp8bTZ/XytB5QZNErX0jXL66mhV073qbOIgSBs8uIbxyehAI?=
 =?us-ascii?Q?3CqukSnX98XIKJ5u/ENUemo4wVlUeItHTZTJhJBI+ZxUKWF8cOVA8XSFymvQ?=
 =?us-ascii?Q?C2ZqzNBaVYGApvt1s5pLXIxClYqcM6TboovQo2p9m7s81FJFZXV0UNETA7Wa?=
 =?us-ascii?Q?k+WSnJXQsGDHa3gOyK+AJE11DjsZ010dqjIvT+YxNdOb4CufkH00CZcq3Mk0?=
 =?us-ascii?Q?w7mQjDVSB7INawUsYhe7ha2UK9cgmsCbA+O9nqvk1w54Xp1VKKw16HquuBOq?=
 =?us-ascii?Q?R3W8JMBkj1bpqMg8bpVSAP2CJst33QDIfcnnwHNXtyz82mVEHOwCS36RbFmS?=
 =?us-ascii?Q?8qmVwK8kvP+MUcXtBBU8bg9sSCZDWJizyqF8YN5rUl5+tCSkCsh/D9mIeETG?=
 =?us-ascii?Q?1ZS5HrF98gANIQpb5FU+COW6e3iTSMI9ntDBFw2IaBIbnEWK/vCmo85Nv2ko?=
 =?us-ascii?Q?dEqZXYGnZU19GMxgrIe8cNfBIYXdHNm3TOvsyPS/f6rLelA0OpYUzoetQ/Ml?=
 =?us-ascii?Q?wSb4JnLD/bMzxL6L+9efethM1D7eybL8MICEstZZ0wXbmKsPw9FGTsBfov0t?=
 =?us-ascii?Q?jQx6Od9/cy6bXpa1ZWD4zB78RsajVeEMR+P2ccpJYoRDFMBmdADsPDwspHnw?=
 =?us-ascii?Q?M4ANKO0uNPtbJfsFSizLkaXOIbo6owZSsEqc+3O1d4B8Dhw/nRicK/8uvyHJ?=
 =?us-ascii?Q?7gkpXp8rf0zRNOPwcCNx5BYfMxy/PmG6UFfNFbQ0h9GyHiZBBuX7agNnf4Te?=
 =?us-ascii?Q?kxKevMgNs9X28szh/mSCHtgkL6jlC2Vl73ivzglc5Is6T+N59DomW5Yz+BxU?=
 =?us-ascii?Q?H1rku0zupuax6UwvxLAGe0bOkCP3UTQK3LesAgtK4wnhdRErfOitY6f4PpTJ?=
 =?us-ascii?Q?Tu1U/CWEk6IJSnPG0ameHrtWbEPK5ocANWAW0dlW6fl1Eg+l/uPed2SxdKG2?=
 =?us-ascii?Q?cve0zpozDhaqBOetqLeTjuBe8SNaZDslMgvPn5dPBniEKVxcHu04W2LJ1YBY?=
 =?us-ascii?Q?AXJ7VSB+pjQUQ+95j7YZoXjwcRMVhzWW4S5W+jXzxx5ZOV6qhYx55aznSbDB?=
 =?us-ascii?Q?QA3OBhpoKqhUDnZ9WFeOK+4BvN0Yn+kUrWC0F62LBe3Vpk27zdc7f+rjX/xf?=
 =?us-ascii?Q?7dA29SWLp7UzVOhs2TJhkHEGJd1vVJl1OBQk9Z9LKuhA4MIaUuV061QiHH0X?=
 =?us-ascii?Q?gYX7+Nq5IaXKv135lVODbWg4+SIEcqOOEDFhxoW/ZMPV1VrPvtaeXu1FskfI?=
 =?us-ascii?Q?5FAGZbnFPzlRqHqOa4Arq6pqKhBkl1cJSnvpLu4ebjyvcmn3NXoKg0q5RA7k?=
 =?us-ascii?Q?PiMdg/Yzjx+feBsXE8i8wrgztcUE0ABYM4TDyq1Or/zfu+IqVYOvfXS5yYQy?=
 =?us-ascii?Q?xCUYLVy+V3ldmf0RFJf7JJa0PmEOReGCviK9en9AXRDRrz0GcdRGBafV1gkb?=
 =?us-ascii?Q?qiBqrIJ5hw1GoUXw88YolFCmLGeyfXK5ZHskLUWk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b4d7d2-4a4a-4aee-dbc0-08db7c8687fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:25.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJqnFfkwUotAWRQyjvZOTsB00gJWv2AenPN1owCJQAc00g3LcRwlCyoZ1ik+eVBKmysuBm8gkPeM77b09DWUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/reset/reset-meson-audio-arb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 6a3f6a6a3bbf..355e041214bd 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -138,7 +138,6 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct meson_audio_arb_match_data *data;
 	struct meson_audio_arb_data *arb;
-	struct resource *res;
 	int ret;
 
 	data = of_device_get_match_data(dev);
@@ -154,8 +153,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 	if (IS_ERR(arb->clk))
 		return dev_err_probe(dev, PTR_ERR(arb->clk), "failed to get clock\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	arb->regs = devm_ioremap_resource(dev, res);
+	arb->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(arb->regs))
 		return PTR_ERR(arb->regs);
 
-- 
2.39.0

