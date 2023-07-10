Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA774CA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGJCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGJCs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:48:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D45E43;
        Sun,  9 Jul 2023 19:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0/V2kb6/oKXmMIlkeWGv9EtzSCJiU6YzVJAF2hj4drahyd1tslaBb2NBvuzTqzyJscR2gxjGwl6/YBTddBAoUk98anuLORuhXCBzZwCwzIG3sckenKtGm3H+XR6XogJuPDu8nznZcRwoUrYjkgUkxyvahZKqL5G+BoU/SAWAQRXVga0aYLgL3Q6sne6d7HSK3ROpe5ZNDX7Qh65NFuGFNxswPVDLbjh+3bPBtK/nk9+Lg9S3QvAF46fPX3auZzaQ6OyRBtVOXKxCaMQJceaDkRJRWKdfK/CR4t8o9+xbqU68xILZiDyRpvqqHjnct11Ltyph9m2Sf9m1JBYH8Mdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtVYOYMZOlBwAc8uttTTZ1VtrI2xEPdSeZsb4KYuxuQ=;
 b=GBybeHgnCMDh94y7FrFTUMxuCbN796LgXgzSEh11EsGp+qEfDuBAK6ECYjawQXxnvNv/STD/LmbVVpuUsU8R0idB0PeZ8sStYQQFA1uPkF39RNXArZjcwX9xRy/h5RqLJBUEJuWxnlP+78E2r3j3i9Ai6yVobfzRR184BBo12hrR2EOjirB1jFrtRe0/apE5XhE9QlSqZekxKJoxBas84z+IfMfJWigbBRhBfmf6f9pZmzPpxsto69wa66Yh50w/axUQMDrKRznyHpDOW/oyWVsnr9jKAnE2T0Jr69u8P5E1KGgmxZRhBkTOCQK/ViLejO6LIWamg9CT3Y0i42KzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtVYOYMZOlBwAc8uttTTZ1VtrI2xEPdSeZsb4KYuxuQ=;
 b=bPZv3nGmarO6gornwGINLVYPtw54hDH4XD5gMaw41+sZg7Y0cXutkI6mfil7/ADIAxXIlDcsy5Mv0M9ChUdn7SA7OqtGopvKsy/I/5/g7TUaM9m7780KK0qK+p6KF2ZJiUlptBCsggebAg0e2CeD4wpijNkmcbAg+L2pGkKvdov5MnZCsVAk/P7xxnyIrAMlBtoRDFEnwYCU/ph9gtuxprWo3kyzicFlICjJDTF6/vYT4/wrC7JkxhAMNkxUWoRWlylc8PhSnblRpV7dC7pBH5aOj/BuZH85dmRBqb/EFgHwJPrPFwiG1c981ZjN/d88vjlthekz+bWBmOdT2zHe8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4273.apcprd06.prod.outlook.com (2603:1096:820:64::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] ata: pata_imx: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:50 +0800
Message-Id: <20230710024550.59544-11-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 261b20b7-b3d0-418a-4106-08db80efda75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocohNbYAo5MbQFqyfleZ87D1CKsjqnF/WI9Ophh7yYsHoVE1l1pjE3oF3BWTU9RsO8ygf9fgDsmOEy4pqwEY6Hy1hbgUD9UpdJqnaxmhttujztwDAXZiFTbBAG+7NdxNhdHA0Go9tEOZmdGC2xkV6nhljwlbUkdbD50+pzvxel16ZmBbRCAfIPWES7p0Rayx3HSp3TVIajYI7xgUw7t89jOged/M9hhXpPTNvKRkWg90a+FSc4niUfICiqjOtjFw4MW+FlUB3x4WQPJtdMZFj5AnkeX81zss7ta5PSVVFWPhsyPcj9Khn4WczAM2BZTfFBBgawyffSe8TxPkhRTJsYsjcXFDJ9dYZdwnXtb91e0ewPzceAKtvjGuU5+WYaZmF3HaR7pf98cdh60VGr086fYKONn0KjMBaLXvfvbQPI7buhlEvoc7h6onN/CWt04oPxjsqo+H+MgAnmLZUTkdqJKy8tx1P4N1JrhrXMSVpCKFnAST9JGK/FcFhCcp47/OguJ314B17SgUQfdN5MpMheEN8jAQtodAp1tUGsgsHMyOajGimZBKfrIkq0F/72y1ZtjMw0GsjaYuu1MA7qtYu1MLKD1SmaDtMdzvdLxlBDd+BkoATs/2xpJ3IrpnoyOg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(7416002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+h5g9FnTa8wXczX+8LtawHBs7PfPauPBWMUYxwVs6sI6RtOggLPyr3stJdoc?=
 =?us-ascii?Q?zxXrDO3FcaLISxyETuBz0dTHO6UJNI//4Odna9ssIb1wCERi61xZxgoswnLh?=
 =?us-ascii?Q?eJETPC3c0UHBp/JpZsLtX3X00bXRFkra6RZurcsJ9Eph2iD4Snd5ZbU5XqQw?=
 =?us-ascii?Q?8tOdJQ02eZatoWIqqKNRKAPV8GjSvrGkYQrD92KdcgnwQOkard+tmWQB2AdW?=
 =?us-ascii?Q?qVzyhHc/mXC9RnuGuhvRxGRJ1FdDyatQyS0Tdcnso2+bqPs+flAiry9H7q2L?=
 =?us-ascii?Q?SUplUigxNLNGzA/5ywcxdHPu46s+VE1plr+SjtsTdPU411mK3PIrxAA6GbVu?=
 =?us-ascii?Q?hKiQKKO9+YsPr2AZOZLJj1b2gu3U+TvRNA7TxJ+AkA59EBgA4a4uus2DWRSE?=
 =?us-ascii?Q?u5SNSmZSGnVTpUOAttzQVJS7AKwkHlCLGDsvxz9FTP2h5ceyErmxwSyMRfRU?=
 =?us-ascii?Q?GJGbTtnQPls/zwgX0fjP9ALW4lySOooGnoWrV7jR93RrsG03Jqj8e0BOMfCZ?=
 =?us-ascii?Q?HibbhI93tWVXahyyi7gdBuFEQXHk0xgjV7jiO4kJUR1BTd86xCUh1NZwmria?=
 =?us-ascii?Q?1wpCY2xzNnQSpl1yu/ab3WlX1TeBVJjMo4PAD3FPZQduI1jme23KCI+crlKo?=
 =?us-ascii?Q?shgnuT/S7PUQO3gZ4FNKixL2PQmrBojD82x2RLQweVCelHHQ8MjVz+957/AH?=
 =?us-ascii?Q?Uup7rZ33j/xf7dyXMw+4EpR/dIcmd+x33zf39oIkBTBYQcT/DYmJxZjWTq2L?=
 =?us-ascii?Q?Zbvrcsx5lTrMf7LG5ZjPCS+EfFzoc+IJ8c9d5axFReitlzNcvHKZNj37+Mj7?=
 =?us-ascii?Q?Evj9x+jpzfE4BgfAwsYOvchEZd2nCQIlKgUNw9is/PIxjF+s5/uaTmxVqHOJ?=
 =?us-ascii?Q?OllRN/efyW2n7bBZdCAiqIIXfrJXKBZpsN6a5jq0Gb+VSYBnEQA+RTlxScry?=
 =?us-ascii?Q?hj/68+rpC6sfTvZPE/7AtiA09WfkfUfI8CgA6gRFfZYMvCNj4JyhiL2ntkcL?=
 =?us-ascii?Q?kldyJKfN2t0+PxHL0KJnW4jwXMAl/z1aLfGTWeB0MSQZumZo8D15/z43nTeW?=
 =?us-ascii?Q?WqJH2RkeaqYhCRL9ydwwV4cvcarVYt50w6mpbUHkE2mJCUoJBPz7BS8rvS5/?=
 =?us-ascii?Q?XMAinygpt3Ie4GYw8ACoFsccBfn1qfDUG7CXJI5Zqf4hLvyxCcFx9oNW74E3?=
 =?us-ascii?Q?nL7Wxuvj4c5/8HdYgKXePKVffncv4RDHkfYotPcGbGWgHN5kG2h9jbG0korl?=
 =?us-ascii?Q?xcRQ96pxMcQ+l7PoekGam5oP6SbbWOPEXxcCseeXGdTx538UUAd/7iJWYfar?=
 =?us-ascii?Q?6vlXE7kAt3XoY0a3H5SfUCd3JFjg+ny/u5bHwO+jCSR12qKUv1N+rhC3ruvs?=
 =?us-ascii?Q?lq12RQx4fNtuPRYGfUDNx+GWvdchnjJPkf89dz/9HtMBqd28Oi0cyVq7mZAm?=
 =?us-ascii?Q?vT77YLcgGpwCFnUnxty9aF4+HZWS1V8o4E2RjAmSkdWPGVtJnoFlDeZ9g149?=
 =?us-ascii?Q?INSvaEA5YSXk5a/8nOE3weWCFYhQ7huiiuv96egnL3WBC2gq4bEK4/Y0T2rm?=
 =?us-ascii?Q?qxPipTA3LLTqXvd6NgGhthpodSDsK+e9GXdLMiww?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261b20b7-b3d0-418a-4106-08db80efda75
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:25.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSDrO6/1CCpPRAiXcpWEQiaDUtxGQd86KJ+fLVVUCSD3Cc9Sl2DGkOyn5k3wBlKoL0FljBmyAhrVPuS+gzED8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 4013f28679a9..65d09ec94c12 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -164,8 +164,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
-	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->host_regs = devm_ioremap_resource(&pdev->dev, io_res);
+	priv->host_regs = devm_platform_get_and_ioremap_resource(pdev, 0, &io_res);
 	if (IS_ERR(priv->host_regs)) {
 		ret = PTR_ERR(priv->host_regs);
 		goto err;
-- 
2.39.0

