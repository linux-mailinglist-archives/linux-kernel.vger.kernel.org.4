Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96737471AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGDMsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGDMsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:48:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EB6B1;
        Tue,  4 Jul 2023 05:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqqBORPtkn/bkFKqXW3DqCd+t2m+u71Te4ysm4ayYiOfZVVvz3UkrBEcdqQQYb1cB1D24Y2I44EO0j7od7YNY0c6IwIGx2xoRCjGjxkRJ2p2bwdIf3NZSqmg4ySwFe5SNpxuXv99eM42r/k304FFaxGuKcZE9BeXGnIH5qlGXLN7+3eHDMy/lleMTlfwGC7HrUyuA2U/Pspk1Td4s2ArtfZTYtVcUyqXcGkIcf6jwu9JZnH93XL8hbuo/5NKeIHtwyEZS38HQKNVvEcbsnIx7NwHzrItiwIdkMqFG11e7B7DYbE+vHMb6rTU8w6Nr7TUjzuW1c1qxxCqxnudDMAlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkleEjFxvlKJ1geHJ6emVpUGfYaJB6Ei+AHJ3cjNRCo=;
 b=ELQDn7Y0jjep20GJfTYqPenUFKiWIgnbeCLz73zkalSEeFSJIAjqgxFTzGm71Ag3hwK1vLb3o/jS2K1O+fbWzy3CEb+r+jMu/a6kbqo8YxtvYP0S2jaockQlhkqwnrofEZlMOFpy6K0egIsupJBQOXSkQUmEvWWaHOiqNw8qg/PebaJcZe4ZxP8HLNjE5Ksczah3wpioc2lSA9c01r31F1LNaQDAbbOPulyR4ihv71wxnFRiZYdW1hfgAltf0ykMB8fUC0aQ7boC1RP+TH96LGNcFq7gysiRQKQdwALvCDkNxP80ppIioUbb1b80fhmKGku/DZzscyGOo+WK9jki+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkleEjFxvlKJ1geHJ6emVpUGfYaJB6Ei+AHJ3cjNRCo=;
 b=d8yhpTKAharxCbmOk2krfClek0eXdcszjtYkkPQeaPpfDSwuqwNY1MoBOe/pENiI5JnGLS0UJExJUBr/JQ8tK5GLsVAV6QVfUS5BpckDXcgWxbhs2F4yUmtVQtgxfJsVN9CKNEI/NpijLlzELC2wPoU4RA0mJQRIDAIiySFqgu0pAA/uEl39gx5aMlpD/uQczqbIGGH83wa8a9Ri2OpdCng1R3WnVWbCRDqG+KONZX4wmb755dq1E6B7xrTSs677SJvDDIpB0DU3xAPfFHcrT+JOJuJDpq99lqfWZh0/f+FjHJpXUJghrs9fWcjxoGYaQogXbZF/hAiEaplhUH4KrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5679.apcprd06.prod.outlook.com (2603:1096:820:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:47:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:47:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pinctrl: berlin: as370: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:47:39 +0800
Message-Id: <20230704124742.9596-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: adf15599-e367-436a-b33d-08db7c8ce1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qq79U3j58DtOwkjAC5Wg2AN3/dLD+zJjn/mvsGcJHiXvKHBqbhcqddIEla3sj1YS0TQt0H+RCJCoXkqOAw6+s1K8nKx/KN8T1EA00r1H2rH80P41V0RUDQ2/KLEcAbw5lu06lpQxh5+0WE8DwrNfXcdGMTJGektCsiFMXO0vqdM8aqep7hjp+nOsr/4ge3sSK/2UtR3IK9bmOAxGLYmyL3ZPeB5ZAlFKyjONYSWu7g8zpUeskIWUhnURCNy6i4G8npASsMUMJHVNYjzI+SgiTMhOBFKkyXh57TEqeuvLmcWRszX7rZdXCZ8/21SnnuDfuQHZuT7qJ/IH24A1Kv7unPWrMQcPmPvWeexumKK7M3Ag80UHvHVOm7bvn3x2eIVe6tJl41/I6r0TVD0HB2A6/MmncJIz/npbrm/bsWpR0clyYZLGY2DR+a2ZbLnFlc34r00840ADyNcXx6XINimUJ1HNgWvBHGSQw9A2UqZcShsUcQhvsaqY/ECPBGodEMiTUid3vp9HBsI2pV/pJmVeOmWpEK+dxGOHRSQJUbUGZix5LW7C2Vl5mHP01ZbAD4Pdb2xVar3J2sQ1dGqWwdpl0th9EK9HqUNY+12cnhAa7Ufot62Guem2GqTOj97KJ8o9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(1076003)(6506007)(66556008)(66476007)(6916009)(4326008)(66946007)(38100700002)(478600001)(41300700001)(38350700002)(316002)(2616005)(83380400001)(186003)(26005)(6512007)(52116002)(2906002)(8936002)(5660300002)(4744005)(6486002)(86362001)(36756003)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+aGWESsTJ0H0FoZBjSnv6BSwm8qEaaHxf3xkDeO7fXAbFAK3BH6LPglW+jL?=
 =?us-ascii?Q?KN0adwM/JfI9znvivZg22Rjk9VcqQ1elG4apYsZzHQrv65GaHDdwoED4ls3S?=
 =?us-ascii?Q?cvioWGwxpkLP0RoQ5sUWKnzCVJRTi9BtbJ+Lu6wal1uiYrbxOejYU8bbY7Ik?=
 =?us-ascii?Q?o4Iv3d0tinLV5j86j/JJFI8+0xZrR7SfXX280S1P54pQJS7sKesBPBVF/B4B?=
 =?us-ascii?Q?SfHhkyP6Uc12q/5l7S8IFz0Lca941KwXRxIV7HZ759qCIjzXuIcjynv7lO+B?=
 =?us-ascii?Q?EgdEDebOuRkFqlMtyPLUI2KR8Bmau5JE+HwuUx1v89yvGjDbZ4jAm95k0c04?=
 =?us-ascii?Q?vT+XH7REZAYjBvLahlOaGBbIEghTMjxksFlzMizdNy8SljF0pQgLDi1+U0iM?=
 =?us-ascii?Q?LyzIZAyRGxOvcnCdts5N3pmRa76I07bW/LvOLqXJolXcOy6Ha/3vuIfcGJoh?=
 =?us-ascii?Q?wT57DD7qXBkTlh37bkOnJrx5rIi0N9PqywqDzEdlvrpy2lPU3FDGYPVoC7r/?=
 =?us-ascii?Q?5A0cD/9jk3v9ib9h1JSdYafW6D6aU59xVndX9gNCLfaKpn8gfT8oQeJ84uKi?=
 =?us-ascii?Q?Z4GoFMYQyCUQE5xep84htQlqsdFfcjGkNC30na6QG5LbeOT5I3Pde7pcV5oi?=
 =?us-ascii?Q?wAiX1Seoq6mg35M1eZ8s+TnP6b6mKGd9QogwG+t4BHIevrMUQqvlnT8rRqFr?=
 =?us-ascii?Q?AlvegiCMHh1zzpnkao5+awKHiumpI00tvGSUGGszJF+R4RFMvdspWwFQj4/u?=
 =?us-ascii?Q?GCG32mmPXD7ALkbBJoyW27fVVAtgdnmkbqkE7tG7yq0oHMmwoW3p7F1KqUY/?=
 =?us-ascii?Q?i2xmbyM5OSt5zt+95AAvbhLbBaS0d0bgXvcvCjhgQNLtzHHQRd69MNf2mnll?=
 =?us-ascii?Q?DaHnHErJPUa/70qa5rygmmb0qLwbwdC94Esg7FK+18qzOEYunvI2fDyJO3hv?=
 =?us-ascii?Q?Di/N8EDSXeO6OjistIbimbTjxN/8MtPK2KJ3P+P4kF6OOFQkkSZoaaA+VpFr?=
 =?us-ascii?Q?z+3bTTdimEM2LgKwxjGTABU3ImRuRg1HBGIP+pPT6ZpLYNwaDO6eB1ECic1Z?=
 =?us-ascii?Q?khp7Or3ejndxkyKg6IvlAQ+u0+zuvRzOGFNKp5V5nTyYuBEh7oZJmR9Lwyd2?=
 =?us-ascii?Q?uqO5AVcSd0efT/W+aIIVIi7tYIJ33kJPNq+DreG/KPL5mQUtMc52JC/OIEnx?=
 =?us-ascii?Q?SeYQCV3I6weHUERCX/o9T3krhWtfubgtu+l1rCizZiub36kgsxC77WZfhd48?=
 =?us-ascii?Q?JU9fAEfa3ZC6QNNtcRevchV+p1+FC+SObUW+dsYT7ZgyjBLXhjLqDRQroNXF?=
 =?us-ascii?Q?BLpPPLot3oiAoRV0Ed9DiZp16IZZwXxNlSxT/AjCbphRqBwfn3PpovttHSeW?=
 =?us-ascii?Q?axWSnbPPshveLWqvtilpHBl16Ezza89YwBntrgZc2jo6Q3+WzrXO8WDFhlUm?=
 =?us-ascii?Q?TQJEtWaGxd1B085dVa6+S7wb+FQchDsmWDEoRY4r9hYBN86jXD2G2uBGoh9z?=
 =?us-ascii?Q?Q2RWTkJWjVYYQkUYsttE2s8uv1vb8gpXRHtfgQvADD1rTxBMdN1xIOIiDxvJ?=
 =?us-ascii?Q?dtAr6/NjAsHiUat96FZdt5AiDuf4//NOAV+Z2FFg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf15599-e367-436a-b33d-08db7c8ce1d2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:47:53.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYGsL17YdfN265vucSfNGSKeOc5ooiS/fNHui4JOE6OChBhS1Ubkqvh+cieAT56w4oJoiRHv4ceVtffaiOHwvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5679
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/pinctrl/berlin/pinctrl-as370.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/berlin/pinctrl-as370.c
index 9dfdc275ee33..b631c14813a7 100644
--- a/drivers/pinctrl/berlin/pinctrl-as370.c
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -341,8 +341,7 @@ static int as370_pinctrl_probe(struct platform_device *pdev)
 	if (!rmconfig)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

