Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0E74CA04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGJCq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJCqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADE120;
        Sun,  9 Jul 2023 19:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGqe5v3Lk6v9Jh0QUjnSIKWFJ0mp0FnpRkUdexBzKdE2ArqOX2kvrwr7b1V73DlP+O0IhtdPQ+lECjqBcw3eKHvIA6w8m+u7QYn5J8csvn3AmlJgnNSI2BqJ0wDkYwrLjoNIikv/mooOPo/64uhTYYBDfFjOZffsB6CJrmIlNrD73MMLgQTluL7NiPeThisew6FmotS+9TbWvpNr7iu1KiP28zhDx+dicfhcizQ3WVL+ggKEkjwdbAwuO0SE4eUSzH1GH1GCN/EXmbK07Pjike7jbvFaynzkpwB0tobOGbhSiYpdJuHTPQ7FuabUcd1PhNSRLpmiWSmKlIfT0Hw+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d99Xn2/i8bO6A6vUpPGXgMa4nJLxLYipdrMR9moSkwQ=;
 b=j0r05v8L919xBufCiJh4qx1fEmm/Yx6WnvFWW4uSQs4D5DWltGKWeA9vqvGI1xIBpV0dkAtYVGDf+iucdTI2FrUM4zCHCwbJHzwPpdZnmniU34JGhoRLrqWlOI9aMQ2SYv3gjkylXMGX8gjI6gu3kP8ZipAXh0Z5av8XWoUGrc3J1KKvn/3FSpIIlfZKK30N7m09wpFezhi4OKK5EThZnEKiyGgwEU4ax0oTqZfJGlm6BG2z+UFN+Kmpv1xOumHgnM30a90yHeaEjHCZqMWl7DG3fW1P3F3OgBuyQLpiJpxHn2V5xXpDpdf0k+8EhIV7CzweM6BH2OnS7vnoYjA+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d99Xn2/i8bO6A6vUpPGXgMa4nJLxLYipdrMR9moSkwQ=;
 b=bDwFH8iSt5SbrA+X5ZGeddTzu/iCtWSmS9cOiFucppYbs/sTe51qiBVdQQrXA5vzfsUQRtgeG+jdA5E7+jTnSGkhc4X+CbtW2lo67v6YxTKRs0wxwl51oqwOhZx64DR0byNAyq3B9TnFV17YhO8GNmtgCtwP0j/HZbpS2yQatZlF04VndMJDIaHHpgQkY8pPhpi6J49cAi03a2tuDuK5GqNzrAIAnAHySjZNm9gFX4cJBFjm898+xeANFYDF+c5eJPBOOlgLiszKuBATBRqqgg0O5pyFsSjPqHdW7oTApFDpGG7SKW7eZnl2Ae8CyyR7YoB40rIWOwIeEWhn5i38GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] ata: sata_rcar: drop useless initializer
Date:   Mon, 10 Jul 2023 10:45:44 +0800
Message-Id: <20230710024550.59544-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa34d9df-7712-47e2-b219-08db80efd288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTkOOtiO+d4nIDkPnfSb7ufQAGVGX+DEobiRfrAq1OeehQ5NW/6hMa9PJnqvn7RCn7iN/N49wwaYrAsXGpsePVq9geNjXuhdGKu2THrF/6OCgEJMdb5enXAepCZ/2Tw8ieeWIdHIAj9MKvf5SqURJKy+ZP7G5QRMqucZdrmzH5Al0ZIk+xoTwhXzqxoJdBBWb8KBtF0VttoS1f2SMLMBzwmSM/tSPRkg2VK8o1BhCNXy0zjlUSeiWQwBL0oPOoKWC+RvWv1yQAW9WMme+r6ysi4Nmjr6cvMM7+rY4BLCG0ls12dOtaY91xJmJmujyCQCgNB73q0rKgxfVijidF/O6jA9in10LS5Zuicqga0dAKFKM/KxVUB708U9JIhGZItV0mCc7dHWj82dtES0UbSQeAsFyI+UBi1LLo0ME8tqGqAsOwQXHHBuMqAsy6EH3MYL4gp8nyUr1u83+FEYtKiN2PjCSl46T/3/ClYgey7S37uMDiytYCBBlShyeZZIZe0Dqjg8IjAoof1BptBVh3sZxSIDNVhnIjhaUmUkPxEfAcf1yIEOgrH3doQ8DzjmBJGrcsA1biCZs5ghTOKMJJX/izlDjPLXRtnUenIsocIDREF0QzrtJDWv/niHCnSfTMlq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c1RhjRjDOMMM6EvtZNM0WRzvFkcMrTqsQpvHmcsMw4rNV0wiSkKT5/Rti67v?=
 =?us-ascii?Q?2Oih/HjmlL+kN3OSE7baySJT091FlQYprWdt6b/Mv8nBnFgAXGZdfdCnadjN?=
 =?us-ascii?Q?iQSSMhj6SeoGbG5UDy7MmoLRFZ0BP2Z7QYX/NKOYcg3izgaNJTcidtdXqKl3?=
 =?us-ascii?Q?VKvtN1/GPcVLeFPHVLNQSZT1+E2Q7dbXsVx5npLO/9ntCH8AunWLCD42KjMa?=
 =?us-ascii?Q?fw8xysnbRFlpT6Fmi0jeZHC3E36Skz5Oz/GyBmYp5oLInraxCdU88LfRQmbt?=
 =?us-ascii?Q?rhXH8bUxY6iC6BHFdnqXejCEjuqdWlK98L/gFAK4qYbtNJ2MrrBzWOnsxkOz?=
 =?us-ascii?Q?9nZkY/SWrV4HiPYnOU72VGKrDdD7Qv/uQRVHtlshkUNQ/Syh8C2RsucUdOg3?=
 =?us-ascii?Q?CEJICNLVmMNU/zj0Whu0xc6E8QErFM6pciZOBYSJnonvzSI9xoJOUH3Yznjz?=
 =?us-ascii?Q?Pmdm0BknLZJHuzGE6qMa/u83DOUIhrRuZiPG696xNkMNb5RJsYsH2NrQvZmE?=
 =?us-ascii?Q?MggELsJGSbj1SmnY2LXyngffp2zT1vbsppQ5FvcBcKtRSOKMOmTjq2YDyyPe?=
 =?us-ascii?Q?FjA9FeIYfqV/AX6r1NoubMF7QhY1qiHQ8R0AXF4OWp2wMles98ih1kue9cjV?=
 =?us-ascii?Q?PtLGqTYlCB4kbSx2Mry/cQJ+QXk62k/FvOnsucqqf2hLdOHjpeX3SsxDGlMV?=
 =?us-ascii?Q?gpl/6qtsZZHaj6X1vs/xqrCj3cGWn8dg/RSh2bf6/XYzHpGEKQJLlbgRGTGO?=
 =?us-ascii?Q?2weCxDHQSTuH3AzM8pO+BA4E6F/mFCXXQR8hNzFHYbWquvGqWTvXev6QCFsY?=
 =?us-ascii?Q?qktBSY1fwLJ1IrGtZlSvuVlzdbg1rye+BOp3AJRfEHjBHCVcygkAFvwv4Rlq?=
 =?us-ascii?Q?K3HRcldVfQK2cs849d9VR7wmuTk7o41A7rAJL/P/St66g9AYMGKj0N6YhMBD?=
 =?us-ascii?Q?r68Ly6dPxnthb90HxZpQf7/yAA7JkcLGAsJhqLRCvyffcw1D7Rvw0zEhr0NW?=
 =?us-ascii?Q?jacX94k9rHki9rYXAHHNJVpqF3NAui3O9Dg3bxfMfOd+pMlOytdi4vOu1rws?=
 =?us-ascii?Q?HgQzEabVzmW9RExhNfIsIYdBapGgMKDkm6sBFlF4xLS9ATXch8op7V6SXBQG?=
 =?us-ascii?Q?wprz8a4v2W3Ba5TllWCa6r7MoH2/6egD39mwfPc1tcQdWsYKyZchOxq1rXXO?=
 =?us-ascii?Q?XfhEWp7Nf1Zy87j1sXviW0BQRC+uwk81XPlgpYXaU3CYpGgjhMmhA7NRGJKM?=
 =?us-ascii?Q?/MwpXv3JProXnxwDF8ciya/yboCaO5EVDhal7d3jlgxXzUsJiuKT1gztL5Xo?=
 =?us-ascii?Q?1+obzFhtaa4Ym+4vQzKJcEbsULogT2uJnPEKY5qjSj+PdJZVLii6LAkZWpdh?=
 =?us-ascii?Q?lvho3dGqERl8Dd2/+uOVs2CoH2mOEiKAKhj4mwyAMkD7CzSAIDZG/fPVC3Xf?=
 =?us-ascii?Q?xmQj5yu6PzYRNmyZgqxa4UFOx0V1mdL3cmqhqosJwAYO7Re/jhuLwHbyTE2W?=
 =?us-ascii?Q?McSwdu3GCX30cv4ZrS6KKJP8aZuxFKXPGCpoRFUpHkbv5JFaMv86aFbFP0Hu?=
 =?us-ascii?Q?04v+XAIx0ywyEYLmIat7sjMSJ4xEd6xMTcim1LfJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa34d9df-7712-47e2-b219-08db80efd288
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:12.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMBAa3DXzgedXPIvk5C52C5sIjDfZxY0fW/gHqrP/MLE6nwTp2usGKhodCwD4d2FI6hdvH109/WmEtauqy8Jnw==
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

There is no need to initialize the variable ret.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/sata_rcar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 34790f15c1b8..f299b41ab3e6 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -862,8 +862,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
 	struct resource *mem;
-	int irq;
-	int ret = 0;
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.39.0

