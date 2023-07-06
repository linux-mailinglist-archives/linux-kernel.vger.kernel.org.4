Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28DE74963F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGFHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGFHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B5198E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU0+XgeHPqa+JveMS6JiD4RHb7EAnUoj+lNOodTQ3DafuqJbQ+mE/JX3bdSfIAtU2oK7Ou+V9BKm32PMBzWkRpY/C4tVBbaPid/SKmopGqcyRe6a/N9X+8lRHO6t/lwBhy1SiBZqAACbwuYuI/ILY/sv1GK4zOpJtm+8Htf9Ov+8auIJNGvOabY679eJrtITUkSDnPOAMhXs9YR/Uetygkf8IQ4T3JC99YDP0szXffdbJfLhyqnXSLrOlx6rcVGs80UbIDDp2Eoh7QTQ2OnaMQMJwbMMv+V78rjLSESOt+45xL0FvO634Z20V/t1aHo4juOpcUgzbG3IBMQOfxJWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIP0jntlJBxZLjjiDG4Vh5+ZcxT8dYzLc5ijhEXeeTA=;
 b=CFsLcavuT+VHYvX4B/5QoNLACHcKAN6G6T6l4Wud1eEVOxE3Z4Q0Np5Zdf9CdsMelB+eeE6cXmEdYBWpKAHZDXIzDCdJUHOER2PVBRaQRYHwCzXdoPLaKjcUBw1EJ7vaVo6vpOiFavzM7QDxfzWD3iq5wY2OD6r12h4+sh76GR/1WXltW/2g/EckKAPyrVWAASHP8hiKKqi3dM7Ik+cA4ElwPWvrRLcfZ3W4wMFCg8XsuJwSr656jrSBx45bwGOphy3VI3tyY7vfzvgIbSZ9jrX/8vGDA1L2XSqYkhkBnubylMsz6tQpVUyXSL9znVk399457NYrJX/0QQpQ9uvZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIP0jntlJBxZLjjiDG4Vh5+ZcxT8dYzLc5ijhEXeeTA=;
 b=hEtXWzZ9Vmya/Q9fuM2oNugdJu7tvbfHeuJ4JYfgKpWbWqQBFMIzZdBlodTLZCDFinYStccya2KQrqAVXsN0I1jBmwQRC0XuroL66sJLgzx61c+SdNXwd5KpTOi64wVA593tGAyT5KOzp+yiejnbPby6v4mPzctuWfrp5kM/n9QA3B9hiq7yliGSasYsYdc9g3QfZPihhSBlY7DcvhKwMRh6jTZuaN8pSGK+jPzhJQMwmYI9CUl2krREdRlOj6USB+fr/BjkOLqHG6bP+m5VuQNmzhHlQqg5NKC5U2o0xTa+UFZOoTX8YmxWrFpkPHTrF3iSVPRTFN7DoyoKHm8Ojg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:20:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:20:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] bus: omap-ocp2scp: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:38 +0800
Message-Id: <20230706072042.31296-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 65312635-2b36-4fc8-6f5b-08db7df18aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej5PheE6lsFSf6guBxbQjuiagkYQ4xKR+y+H6Al8LlT+btKpoJaw8eLwxUnC5V0e1IhedN+0vbVhTLbG62Iy0NpngCRTf9yGOTKC6Sc4wKniYMIeCSt1wJSTexwVj6vYJAznRMGZZr/eyPbDWlfEgAmIuSmtJwV6hPV1yz4vAPv8jNBHMBxOQKTPil1Hade8ab5eXQaIDPqUdfRw/MGSsfVX31nxhoFAiELazyhafxttWbYYZa0Em/WIHfT4B3c779b02l4Lcwhw/62WYZ0kCV+V5gNzepDjlmKdjsG592udvRGphfBWsnVG+0hopLwheHx0fr8wKuL8kj+eLFaztpF8Hzo47owVNsYOAqYsk7DsJ2obw+eBu1aUNfikKpr1ihtrGvryrgXOV4aE76I5MRJIDz6ajfWjORwQoTH4KwO+A2lPOUG6otHji6UxKhbIQYOcRS5gCWHHbf2lak/b9kFcd4Rv1a/AIt2Ogau8Q28/r0IA2Kvb0D74Yob2umarpvY3gT5/FokcCXnr7iZF57N3NQoouN5LjI/A4r+Dbuzg1pid5eGo9KGC0zzOJf9DZZ4h9rkiLZn02e9xckoslzQefcSIpjW4vSI1x3kfy7mB0zg5yqXmd6mXN6OTlNSXV671ikeSFvddM9by5dX6Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(109986019)(451199021)(38100700002)(478600001)(66476007)(66946007)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(4744005)(86362001)(5660300002)(2906002)(36756003)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9JgrAOi4x0VzNWDmC0VT1YHhgYpwWFjxB+BedNofyj1ICYfcUB6Kr9PfvDy?=
 =?us-ascii?Q?IK01nAdmliIBoKPXCVcLxC0hFMFzdhho1G1WeiIygDLqPU2+7gdU/krPxlzt?=
 =?us-ascii?Q?CsiK2YMWcSHU8cj3JSmaLIUUYwnkhA2t2V0eUbZuiL6dnhaLWq9IUOncIwXQ?=
 =?us-ascii?Q?gm9OLnM1t2NPzxGZDe4rj8BwZ5R/yVsCLDirvRx8T0udF7c+1C3nDFa8m286?=
 =?us-ascii?Q?NpD6fbUm2sTzwmcd4EOYEi6bTh7ZDryb1cbGPJ4XbuyoyqCWUCgzj/dgRj5f?=
 =?us-ascii?Q?xwghwXHCzoSXYcqk4f66r6u31dqV8Fvi0MZG784pw9iTYAL86XVu9dYWpArD?=
 =?us-ascii?Q?L9Ex8SRpRIJ84YZm1sgeOkKZIabtZ/rq6OroQEJv3urDU6JW/LNJZqCsRtuk?=
 =?us-ascii?Q?3tU6GDfmbkuZAP7tMmqF+dYlp6TH8JQjP7z1MmYfr0JVjTbO03jP+Y2l7lsD?=
 =?us-ascii?Q?+e55Mi4pCFv3zL1GnbGwWJ4Gci7yfrdmX2Et2ZSFAs/7mmbT/i/mvWJoJn1J?=
 =?us-ascii?Q?g1DC1BwEnR8NNXJuO5MLcZhA6l/FEr+i+wRMHlVIQxtxlcx9ScrQjUau09zi?=
 =?us-ascii?Q?zGB1/XRrHVUO9m4qHNyOzrhHqTk++aPZEgR8xQBjWnCrPJS8r3NAEcHDJrSM?=
 =?us-ascii?Q?+3MJDAU2w6Kb2YAFDb//jSbkHhp8PBVlsBHzEbiv/dqyZHG3udN/maonjH47?=
 =?us-ascii?Q?oDH/x86ec64C3F0ieVFkktZeDr09emI5jnw1xcOpXGbOrmfJfwxKTlmDPP/H?=
 =?us-ascii?Q?B5DhfJVGGGG1ibkiz2/X7Lnbpv89IZeu0jx0141iXGrrlF/D7wz/2c0oMPgW?=
 =?us-ascii?Q?cy0afAMCZ+vwIvt9VgbOFr3VDL8mrAeuEaRB5oxyuHFg/uK/2Gghh+Iy0guG?=
 =?us-ascii?Q?mG+hXhKao/zGozE7JqQ0c5Nf+RVQgW4ZWOFxeEundxfa3aPcPdTnFgGmeYKX?=
 =?us-ascii?Q?9sZDPcUXWvinSfen33scr1dWb+qjc+13bIAOdcEKRkAaZcxABP2v8qCKQNA3?=
 =?us-ascii?Q?XNq6WsHsd7dF/zjQYOc1W4kU27dKA9HfAdDPxbQOT44o3gXEnzeBNLoKORE5?=
 =?us-ascii?Q?sHPV5rm46jB7DTh+kWRYKALEMYDCbpS9QPt8w1Zqq0UILNw20f5sMVasqy8D?=
 =?us-ascii?Q?1h/7WKR1Sk7YOjL8Z9y8TLA9ynypn2OvRpc8j97GmVDFwXHcQtTEh6thtGEI?=
 =?us-ascii?Q?Bvjxd6R2Woig3FU1JkrHmtPiXu0q2M7rhQ0781PUHdEC/98tsWdLFkHUIP06?=
 =?us-ascii?Q?jyVoA5QGnL8SFiiSTSOe86ZOhATkTBE9+gCKz1yk8C1UCzHM7mbo2aqIX5Kb?=
 =?us-ascii?Q?l2jhiG2119P69h8pgxznmJSA4nXDS6RQZgdnO+2ZuCHLCjEzZdevESosPfhg?=
 =?us-ascii?Q?VcrkpfPTMVFD3DURjTj+GrLe8fjOf1C3AA1BZvahROOmiliNE/SHrJv8ZjKE?=
 =?us-ascii?Q?5DCBDavJWDsJfODpiNn/CLjtSUj3s4C8O6a8cqWcNMk1rZq0aQoCkU1gPkvc?=
 =?us-ascii?Q?dvkBcDFrz84CUljdvsMxh+ioWHlBP+b2NAhNDOmXnM9a9nS8CJoodALNKp7g?=
 =?us-ascii?Q?tRkCMw2vVzYH+zCoBdg1PdPToYkLmAogSi/NyLQ/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65312635-2b36-4fc8-6f5b-08db7df18aaf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:20:57.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNMJ5BmqAe1KqEUA/O4tN1z391YHEMgduTFnOcMnIc538QkCJgz3b3rpJPXpgtSrhvl8moCZ+fDrA/EjC+61Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/bus/omap-ocp2scp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e02d0656242b..75dd8f4d4f50 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -31,7 +31,6 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	int ret;
 	u32 reg;
 	void __iomem *regs;
-	struct resource *res;
 	struct device_node *np = pdev->dev.of_node;
 
 	if (np) {
@@ -58,8 +57,7 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	 * of SYNC2 parameter in OCP2SCP. Suggested reset value is 0x6 or more.
 	 */
 	if (!of_device_is_compatible(np, "ti,am437x-ocp2scp")) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		regs = devm_ioremap_resource(&pdev->dev, res);
+		regs = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(regs)) {
 			ret = PTR_ERR(regs);
 			goto err1;
-- 
2.39.0

