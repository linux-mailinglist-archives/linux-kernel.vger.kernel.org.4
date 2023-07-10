Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D674CA06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGJCqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGJCqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9037124;
        Sun,  9 Jul 2023 19:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaR2ASUS9hSfR9anNr/3WlBw9JXiS6PLrwYVRDR1kRBynVvqCz9YYmcUIVDy/0JdRV8VjmpIMy9qOjcokVXEbIK7hdBEaJ+0oLqD8OVpHsrf6v7LvWtWg5LmdTV2xeyvFjLtVcUrcEqTzt/GhkMBCDLubBYe68cRZPYQLVeXyL12qyDUvIBYTI6fuOeb0lDdb1GKe2CF5Kx86+7AkYotjlvrhuW4aq/+h1VuvlWIJlCXKA/2TPK+NV2KR8Bq6Yo7hZ39nx+F/TEPrtIO7EhyyyNG6bR2XvSMiXNrdf4qrvXe5UCJL8CfHZJ6roLDuQrBHYHuifpwfLZKaLJwGAxesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15bhvgMdd/Y8mpgBdNCem6FSML9afoi1g2TTH4v+ZDM=;
 b=Dleg8k3WpV7BdXisiJNOziT8BfgrkAhbFiWwfCecx0aFNRecTtuMAyd1NX9jdjNz18D5htOEivJ07YgaIvWQ2DVWcUg3mnYANygwSh6pAXeCBISCed5riox6x5Ox99wEkRuUuDM5gzGpNHkfsP5Rbq+JNbth0I0rilmRXFC3hsK7o2gi2G0EMaicnfju0BBHOhry3wbYHQrGOoRG7uI5JlwJXbYw1VkL45HXtuVZg47O+9n9jyFIWY7Ytw50IRZg5NLJDxwySmEIt57wT+7HQPZiePrOrOTPtpAAe7rdk3tNk0PKIId902bZiNicfr2LCyyj7PPMYeNO1xXTOe7IFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15bhvgMdd/Y8mpgBdNCem6FSML9afoi1g2TTH4v+ZDM=;
 b=kZgLdy/B77Qa8sZMosmdW3oWyiqtVxTgvDjJ21yUd/UqJMNB+UF3W9rSMVeSypxDM4X53MlcD7WesPUccRRGEYtfJ77iH96TzuGk3vpIHpbnQlDWBQAJrW2cV8O1kScKRVN5RSMlDAAVOcWoDE0amRylZ505B+hS0P7ifNsTa+JJkhxmD/dtyabUJECUFZQa8pUns9r1vSLDEUhSVmH76Ck6H/AGlqLEwyyHGDdsEpNIgX6Jh2lH6zpA0HwaczVKPA2kq/SE18FYC79AUiULId2ucq3Q0NanUv5ZykY/MEDPirhuUWwa6g/TPQofg/A9qRI6wrAZGbUxJxlrZgEhrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] ata: sata_rcar: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:46 +0800
Message-Id: <20230710024550.59544-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
References: <20230710024550.59544-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8b5729-cf29-4954-50cd-08db80efd4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/KbrVbYDuPETymlW4K2piUgF2JfPKICoiLA/aSo1/FftSGneurfN1nvqJKNnp1nBJIeWDSgCjuYvY79ALtOC50IKrHUNdr4pvkxuUGjnZgIdIONjW2o5+brGSM9HLDTbaHu/y2J7QINJVSZmGPmAUXR70kBiloCLhyl9TG8NekzycANmNjFKt4zSQynQ1TaO3dMbwjZ8+xfMggwV2SrnUxtig0LRqhwA7bkT39D1ClqeQXUW+9KbRSMN0Qor/f+xmkb+uJ2JR1tlbs+u9aZyRs29rD8ya5LQxD3+OiZbFZBUQN/OyHVfUpwcZsvIX23WyLfPb7SEO3FF092bwS9XZW5FX3uSciMZ23Plm733e+rzmRqLEWsF+5eKcQYPmKPdooqlmYoP7rscqvZZ6fn+KkjpjSNN6LIViU1JT8JFuoJFnWugI05hyFBna7fUGBRBzsDG13SMvZ1V2vA5N6GHBf+0cYkM9pdi55QgEeVXYu+XIX4TIUyqmQvUyUQeRvfg4i6PZTxsefwqInYWFWj3WilEWSzGezmizg1za7N+geaamxelLfbcDfIgaB9inxEZvbNcH/F3oseL6x94Tnn7x3n+W9z1hMu8HrziWAdTdFGtug0rGZvggJgqDvOMGn8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZSqmpGdpQM/IjyokyKqKt9MVU52jC8ybKkJWIWBswb9pIl4wm+xrvsV2J6+?=
 =?us-ascii?Q?fP87xpimXOXu0wRD8FKbSJGEDOJcXLy3B3GXgDOeXT03lFPuxHivwqp703hv?=
 =?us-ascii?Q?EvtQIcUH8/k8WzDKa9yaXF9ltB/a5E8pDWMBNCXbA9AST0f3VeFhzE5nJ8C6?=
 =?us-ascii?Q?KxVEw23bhzt+Yw+Vg70VlCaaYtmSJiUxCKWYGFMMLlvcflYy0E3uinyYaHSc?=
 =?us-ascii?Q?tF98qa9ZJTJpa4MpYaLkEmkXmgFMt+F1o3DfQr7FbWCU2TslsLttdCYrppq1?=
 =?us-ascii?Q?ClAaHwORLfmw4bNuoivzJydnX/yH4u8dhR6Pq6vq6MVi225vSV+BGmc5FK46?=
 =?us-ascii?Q?jEH+pPBk8iwPUkKVsYYzx/jTTGR9Zq/Xm/B2VBBMa05zHwUKgVPBNrEYIEmE?=
 =?us-ascii?Q?HrZkz5fcDUzrE1mIp6U2db9+9kiIpUBXuLAZFdxhPTOGjDTpMhT31OArbqRT?=
 =?us-ascii?Q?pur7e0y0JmpX1kFngrK1JklSuV6P3tG2yFldba60e0vNnWbxYYrIf1zO0Yt/?=
 =?us-ascii?Q?2jHLiQtz+XKLk5FJrvNJRfR4ZO8ZeCTl+8wWWIe78xtXIkaeDqZpEeCQinPJ?=
 =?us-ascii?Q?F5m+n+hbxzC3OSRl9K3ocvi3wrE5Z4lcIq39IUWB44jBCo3fVp+HCXlpIDiJ?=
 =?us-ascii?Q?I1sI/JiBHhTy8w/56twO5+h3oOSE2NOgLzTABVtiIkM0mmxgwejTFpvM872I?=
 =?us-ascii?Q?JQlVNkAR+iB9Kg+Z6Iyp9FN1k02pj1JTn3SmMvhBRwzVVhaOWm95YecPYkw6?=
 =?us-ascii?Q?KncOywhuWbgUQlDCKfZbVUVsKkFrwDfq2SSfaond3m8XznJrZ08+l71R/XOI?=
 =?us-ascii?Q?ahMt26jExM8pfMgmxCiYB69YiEN+K0IUkbCoX1BrMQiDHl3LPNQqWEZWZNz5?=
 =?us-ascii?Q?3ywoIpzqsTam1ZkfbnJwGJyRoD7XEv42Ck96w9AMKvJZpjNs06fBU+w3neIW?=
 =?us-ascii?Q?Hupl5cwcSK1fIPgCg8Lq+Gfu+yKARMKoOwfaFYMfVKGeZR5HId2fuKDMvOrt?=
 =?us-ascii?Q?6MHfc6/mSLtJDNgC/J2VNYOYk2T6hP8XFJvNWVAS5CBnUZjhpPDaPlt5Bq35?=
 =?us-ascii?Q?ivhuIlB+A90PrM+wupOMs/0S7JdcMtIK37TktdoAZsahILkhRHiop81yqaWU?=
 =?us-ascii?Q?s1wYgRlI78OdqBqFsClAu6vm1riyD9vLxNm1q/UwVE5Pw6xCoQO1+bTs8h6E?=
 =?us-ascii?Q?D/4hmHbZ7KOpio7hMqeZxlP4UExpqQVtVaapQd75ywIY/9MQe0k2HAO6beMc?=
 =?us-ascii?Q?RcmR1erLzXP3OnKelFWcfTG+tgXUD930b8/qm3jbQFo8d8+MxO/flInXK6AH?=
 =?us-ascii?Q?UiElEmHNU6JkBovHXsbx7WUXR7ena4yDKlKD5XpEFoXa9fiNyqzcgWxrQTI/?=
 =?us-ascii?Q?eUanqp4dFhbOAMwm/3Omi5yChxASpV2IxiBkLL3r/ZiXi77Cv5W7adfEFjVH?=
 =?us-ascii?Q?Iyo8yIkqlCoOC4uERBrv17o3vAWAY5fgNiB8OGZT4rNLhgeXzZb76jeP2Yro?=
 =?us-ascii?Q?O8wdh40eChk6UMhn4xSvDXZ/fBDSNrriSwRwQTKrj+g2gJltT7PgysMrU8/w?=
 =?us-ascii?Q?uivjYnYixQOAHySMclmM/DZjE48gGWTUX8wNmQpZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8b5729-cf29-4954-50cd-08db80efd4ed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:16.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6U/oMAb3s/fpw5Nvbmw3FiRmiS5OHjgrmACxvRm4djDi2SM7M1PE8vsQjWG4VJ5VDZW5+TKxX53YlysvkL2tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/sata_rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 43c55ac89daa..63f8337c2a98 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -861,7 +861,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
-	struct resource *mem;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -887,8 +886,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto err_pm_put;
-- 
2.39.0

