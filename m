Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6170874A9AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGGEHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGGEGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:06:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D951FDF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUxfnAojZioz1txl06B2F/wewG44QJMIuWeR5rHX7PiVyPTDqUckD3TpMV9IECMakpZf2wAPTy3pNJ2EdMNdyLD7OUtz3+c0aP0EIY3Z3r6ryFH4YtxpsIAv0qZ1VBnR0Wo0cXQraxpLFK2T98qN7aJNqEAHWZcnPXkt6vGJ4gHGacazkJ0zMmyEjjHtGlLMfwr0N4Vy/paYU+CYw1fDyao0zSzhfucocgMPrhjG+ihiWcc0UyLq5pIbp3OKawbLgZb+ExnjBbTjPySfSPSuCqL8pCRmGgQaqyNo5M2vOWs2P37kriD4z6amEi/9QJ9iAc1075zpFt+UGt4rBTPhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7IAxqoK3HZOSDxI+ilqyxmzxnz3zNr5yZI4DBv3+5Y=;
 b=QpI2p5p6+L4FnsOy/aQ8JUmnn9tr9AomMRDKQ4vb1zA6MD1GXhuqQFTkiYmMzJzZLunJ/id/+J9bkBq1hCerFMoF00kBaohxZR+8Tc0BVitNf9+/6BkLmIB8jhBj3U7K/3DjxVbHUfgAf57mryaLNnVcLJwMHP/lxIyHuw7q4lIm3xawxQfct7N2cNlgm0t4fqMZrAyX/eZX38OVC3tTHL2Uc/rnjK8D1bYrFVURKTSn9QDpfc4+lfiWTI/hL8CDigt66pgloXpcpr6FF5ArIR7uwWjy1byfV07DFxHLGwfhJ3sKFTyJ/yNwYFX6UrwHLlGGlKcVs3kEbGFfO8urRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7IAxqoK3HZOSDxI+ilqyxmzxnz3zNr5yZI4DBv3+5Y=;
 b=UHG9NW9e0k3+l2G7j8VLweOTpB3tu8GcsuOR4aZyueVEXIguQrajLKtLnCAvb5RpBW+RVGhC7izf3hkPvfSMml/bB8Erj/TCCOcVman2VGbTvBE4GUg2MpoW7BvBbZLtBE8QusNsc6/t0LUddNAM+OMoVCVrwbpnrzGFm8kuukh9IIgnWSfj2NcDR1PPrxRYEa1X9EoRh9jXc8wlc3h8siWj3Me8sw6NyqtVJG+X3DtIr3Gi0QgiohOfwC+XDbfY1UzaASaSEiNnNbZ6SQSXP5kKcZuoIwjRcAfmcSH11B+aeQ7Kxito5bK5k7lKbNcQj+srrQ9mIB2Qpxd2cRtsXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] mtd: rawnand: stm32_fmc2: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:10 +0800
Message-Id: <20230707040622.78174-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db9a535-d13e-474c-8be4-08db7e9f939d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBWtA3jI6rnDxZb6lrR73kAJN6p6z7pmvbGDRFzFggeJJ8yxyC6WnYaFBVipIcD8Zu2RimIf9jp7UtiQxTyL2KzMycsXXL1B8CpwzioiV+x/kEftRa4n6zAx7tlAOI04TSigDfCkVeBP6TKKp0HX717FEuiq4lLzyJa0KBKlLuIOueGV5odWpdq/5acf8Wik6mYDS4M2qeA5wbP2EoLEh8KGfXBhvPnhyr/xlX++8Iy/36EnDtEsx+sfnnq2QE+Izqp8Lr/18ndcqo2dv6lsrTW36WG/Bap0SGfLbuzOmFZHEkC/TSvoxNHTJEpQaiv1ZPICSi6S/84Fig0VwDIFn2ecsz/YiA9pmZUrRUG3CqRaK9/hDI065jOcCgW9VNer6fBOvsxa/vcOoEkhI6MJVzDzuKANN2mLk6mHaOC0WlMmfDL7MNYtsLHOPoHMzGuF0b4nQtbg2GMHH4BhCNCeEwrVjDRS2kZcNM84kYRAZD2BeO9FMOxApD9Uog8sPbK0dvAdXZAh/u5PiZHK6hClqViKdBJHVyZDO6SqxQKWUar4l6521jLI+SC/i2UHZdp6JCijO82dQGfXdPVDtKY8PDzruD8HWsu5qQdx2XhM61GUE3h8I/Jxu9yNN4NufuCe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5SsLIPoBwpGZrkdm6R/6lBBzvhWPs5ZmWHuRWj6TNrtMrPNFt8YwI8lPXiBs?=
 =?us-ascii?Q?G3TzmV509o6/aqq1sBr8c1G24Zi/ECyo6yOKmVflejL/c9DQ4lE9oJjnGIeO?=
 =?us-ascii?Q?cjEumm/4MOfi8opeqoyZ2qrLs5eUxbnbnva0ZI1BvWFIKCCy5Ik2RcK3rHO/?=
 =?us-ascii?Q?FPkHW1x56+eEQIZoi6Zgamvoa3NDXhnRwXHqQEI5ccqk23cgDbCLGV6IYjIC?=
 =?us-ascii?Q?Qz8r6MH9nowZMT3HDD49dD+6YWxP08tRxK3zceVF45tdpWAtndLLJkOCGYcO?=
 =?us-ascii?Q?45wOP2DF2kg/WXwudph8DI9txdApCatSvJGwHRwVcZwOFVFTlS0jPDM2fZRR?=
 =?us-ascii?Q?n83kmN2NJvhXZ4B0xH2h9IpWoKxXVZcJFXhyzoKDwzCmKJOs77/TTZ8qTOX+?=
 =?us-ascii?Q?i8XM11JxgKHVO94LcOIJREkwLp6LVu8T7D2FpgTKja3r9VDLh63WGDgsahTc?=
 =?us-ascii?Q?eK8I48yN5QYvBWKIqZfJQxDGU49ItH5xu2I0NOuFThRNiNsS3Rd6nTC03uqt?=
 =?us-ascii?Q?7IU1oLbr61jiNViMved69VnI+qYZsuSKf+PtC+MXHvHSFoB8u0iywW7uxYiD?=
 =?us-ascii?Q?2g8colhs1pQqtryyziKLVLDBpFotpdc1lQe1m6jZFvbgF8BnmUgB0b5ezhRI?=
 =?us-ascii?Q?O9jSLP5UwqEG7YDHirISJip0b5q+h+b2O24P55niyiOa51sgfUYNWrhgW+cx?=
 =?us-ascii?Q?X0fhqx1pQhZWMcgm4bUx6GPVcjNjhR8LvnDA/nkdVCP3oGCWmu0aZDath8Ql?=
 =?us-ascii?Q?fL0ZMwsk2q6r+Rd3bGnLgqCrkxo8EkPT3Fh1uydo5sYf67FYVCdlbT/lJXBh?=
 =?us-ascii?Q?+FFrdhVcozKc8aV/e+PmQ/H5JyaHbJhY362P85fXIKyUqgUSSp1pYb58oi8k?=
 =?us-ascii?Q?n3TxhrB7UF4Aitjqz/3aMWvgU58dqnwD4GrT7ZT5xBzPFliRQedBlitwrWh9?=
 =?us-ascii?Q?5E+E/6GHUxUnpX6lnEbdtpWE+QX3piEp+dGpYA2SEfTNlTG/SMn9L5rqdmeR?=
 =?us-ascii?Q?4Tny1YjKtbIke7ww3aHghVJRAVme4FBgUP29tNZAeK+uqHbKIk97e8y5n56u?=
 =?us-ascii?Q?4c2Po5lt1H8h5zll+ZLWZCPaP94x1HQ4/8DXiYfisVzNiE6vvU+uaHxq7cms?=
 =?us-ascii?Q?CeM1JTV5d7QtvC+hTY6yFcGKrataq2Z3Hv3Mm7JEmbfFFqIhpfkU/QcAzqAx?=
 =?us-ascii?Q?UZs77Nec2sA4KlBmmB+ABZH+qA/f3rnoAKxeV4JPO9ecxHRNPpJn4H4sFC9u?=
 =?us-ascii?Q?DVIgUkznwQpYU4BACYLEA1H/C3H1UiURO0vVn0/PZySLmFNzFyMQRSXrM8JM?=
 =?us-ascii?Q?33abrWJSyfo3EzOmfBcv05Oy8ggc9ENABFkn6ulF3pR4uq5GZcKhiC5gurIi?=
 =?us-ascii?Q?C6fn1T/CHZTsDjT1fuT6MOST0BhUrA0hweinKGEpxeFgG8zg/Le/Mwewn8MJ?=
 =?us-ascii?Q?YeHKURKaRwt5HqFa5G1zFYVX7hEykMs18guEkAvZZ1X009q9C09zFrIITULg?=
 =?us-ascii?Q?Ge9nrt0JaMeSQSA83F/7yuD1U/E4/kL4g96vA1ZhIomzUPKJLwT7MrTpkjsW?=
 =?us-ascii?Q?a0CC4d5xsnW2kcdEjWy6X5omZIGPSNcw+dpf4G2T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db9a535-d13e-474c-8be4-08db7e9f939d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:44.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu6D3A2C2rYWjbfzee5HLOV+OdE2kuu6Y9yI6Yu2KU7DofOGFqAJRnCzMoy99jlGncwnVEt0gx4cLI4Zuo8Z4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 10c11cecac08..2f9e43f64dd7 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1922,8 +1922,8 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, mem_region);
-		nfc->data_base[chip_cs] = devm_ioremap_resource(dev, res);
+		nfc->data_base[chip_cs] = devm_platform_get_and_ioremap_resource(pdev,
+						mem_region, &res);
 		if (IS_ERR(nfc->data_base[chip_cs]))
 			return PTR_ERR(nfc->data_base[chip_cs]);
 
-- 
2.39.0

