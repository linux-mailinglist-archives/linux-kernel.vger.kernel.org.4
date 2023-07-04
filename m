Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77D27471B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGDMsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjGDMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:48:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A53AB;
        Tue,  4 Jul 2023 05:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtWRC9+SnmORc+G8CS3jQRKJLf50BWHG7Mgo1NPFn3xVdRZ7JgK1s8WJsHvlggyxwpHnRCFhjcrKeRhJkiqS5TufsMH5PjBWiab2bWlgtOrEEtQhf4n+Diiz1pQg+1XQP8eJEzXC31Mdb13WVaTz2/NSh1hsuYhKyzRUchbQelK719A+AEBUz9rkjzUxdo/C1R27oEdn/RJ1O7I+bJEcEJ+/V7TBCapOm6E5bXRp8pXE2uCpp1HW9F1RclTL6gRNyFjpvChoiT/CbNoBhy3UKucJg+kfdBKZFgZaoL+uzi1cPP9SZDp2YhBisBpUW1+15uICBFHBjo2SgXUrKxA3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhYUFsBoO/2LlZNkqFI3if/TqrnID+Q+PMGbGMqG/zI=;
 b=BEHvzc0eqTVDHN3Ozfk6VCRCAlpWdShuhQq/qotwnqz2yZIYO/5sdsS9lsnLCvhlNQkp0dMz7+GCYXTITRbRsDSdEUhPKxWXmyO93pQEtazVtUHcW2xgtRZCDp5h4fSXm8aGOn9aNlc2IIqAKlFyvWBmFCndN+4cFO1buWqU/6JskP6DmDoEqUL+xuAfYJ7166FDbzF54uY6eWqW3TJvaWvUOiySQBf5JemHI7/wgI3sJeXjM89Ip9vkBnuyKH4w65Xr0BI+po9M7EFP3vVgi7q5hnx2BnRgOfvQkNFltuuDYGLfaBG/6XG4sDpE399RfRn4ymh/T7fENrOBkLMfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhYUFsBoO/2LlZNkqFI3if/TqrnID+Q+PMGbGMqG/zI=;
 b=Xw1PArfx4dtkfbXEpfxar7iO0nChSgj0R7pWmOzC7gYK8AIL9gYgmxVyCu0h0csjpv8NdZVrnWNm+euWGexRYQwfLOvWUqAS76hX9le/VvFfXCl26rA8TT92nzAd98H7Ec+QOrYsgyGCxc315lAQ2G2ml9kY95HMRlQp3beXfqicVXDDfjP5DrKaLoghEmXYoF0xtPYoJNppty//kxdtnJW8eJRd9WtEAAoXhFOCP3Ye/uXK+LIr9BqteQqfAY42t2oQTUs49tq4WGRu7rmjX34SvQHbnxGP79KZOrtRloa9IjNGjieMBQ0CB9Qw8qgx0c2guIYzNNU0zsR3tyCMmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5679.apcprd06.prod.outlook.com (2603:1096:820:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:47:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:47:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pinctrl: ti: Convert to devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:47:42 +0800
Message-Id: <20230704124742.9596-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704124742.9596-1-frank.li@vivo.com>
References: <20230704124742.9596-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: b79b5435-0c94-4ad3-5b76-08db7c8ce574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuOSOuIjp09/6GTbYlWP+ET9i1arIVDH2EJAkCaHuGojFumfeihiaPoLV7fRpyc6BeqSMNGpMzK7JdjZVGMj9Jf+Q7U2xfU5QxFxRcdK8gk8c8K8eO3D9lxdIgWh2wuCEWRJfjxe4Xj4A3K293Ok0S9b0AZN59BPrZyJHsDIB/PvN3qszP7yjjET/fq2I4OIMjeUam7vYF9OtvRg9GfWonK02zh1enainkgiuKxf9Ygco/F54XOcxl6HMt96Y1LkAfiBfXidAFXnkSfqXAFCDqks5r9p2TSV2sMqkACMkodGIRnl3djNNXqEAgiIGXK12oV2HF5xjktpip6sKWlQGXlQEx9LKm7CY+Thpzwv4FFn1ralc74wTmMuCdCmSHRdW3nUqyyBwY05czsr3u7JRjzAzUIRfU5ah5/84oCf0RrqoAXft5AUdkDzZb66FeDOTTjDI3ZV24jlacSuvDDwloVGdOmgLKWTpi6RcIDEn8kHcVy9PGDa7m40qHM20Wu1knJP0Lq7QSe1ujauiiGUvGHqmj4b3GJTx7uYaGoLcr/ptGkBSLJSir3RRD1xxpj2eEy9JvifsiVQ1YD0z91lbGp3MekVqwp2ohVwRFNdJQe6IYIBDbYfD4HQdSi0lBgw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(1076003)(6506007)(66556008)(66476007)(6916009)(4326008)(66946007)(38100700002)(478600001)(41300700001)(38350700002)(316002)(2616005)(83380400001)(186003)(26005)(6512007)(52116002)(2906002)(8936002)(5660300002)(6486002)(86362001)(36756003)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mi3fjxQy6ANYwuhuyjTBCn4ajZcj0MEyCOsxqkgS+5Eeo0a4dW94wuNmFvuz?=
 =?us-ascii?Q?or3ezFXVELtcus2BQcn+LH5mje2HrYcCB8cDHExJEoUeLaLj4DzbQccnij5O?=
 =?us-ascii?Q?LXVIrCMPfePaDOzEKlPGLOJ9ulGIt46PDcPtIh6TgWG7AmPv53XVeKwvNB8e?=
 =?us-ascii?Q?C+wHbgghqNiksgmvBkfLYaQTjmJn1uN8VlgK3/av7x+bzIt6j6HGAbMq0mbI?=
 =?us-ascii?Q?+oEJe3Q3Lt96bqhFuzoGdjIgZ2ESwiwDecpKMaZeBlQH10Ybz2iZ3xyEkamn?=
 =?us-ascii?Q?YcBxPApyHnGLZfnqBxyIIIwkF56pL8IrVFzwHJbo2EFMWfej3jpjetXb7oUq?=
 =?us-ascii?Q?LOgQTCbTD+dQAD5n6O915mQQ7Nx9C/L1OgR0/G8WXGWBiVUYXrOCP2QfVKLK?=
 =?us-ascii?Q?Hi8+yNNz/15+n2WgfIdfMInw+Gf9bZKIEjblZBoKqCc+yRJHHbDkSnzOTDjK?=
 =?us-ascii?Q?IEN2uKhrtHnfq5ob7fEhBRQrWq9kjZ2zTH5Dn1MlaMvV+JFqibY8uoyySln9?=
 =?us-ascii?Q?o0SjRt6nAPIu33B4OQFCe+XcSpo+NFqUi+NYnPW3aG8Y7L2mz4BxFbMrTaBp?=
 =?us-ascii?Q?KSqmfOUKekkYSJUcTSK2tncGw6O9KlX5HR/RgbGeiQCBOI4Dqzcb9zpul5Zi?=
 =?us-ascii?Q?QRBs21PTsGy7eZo/b+DS6hSCjh2oUFYju4HOpYg3qcDRZ2X0DKygro/84Sgr?=
 =?us-ascii?Q?i++POp3w+2DRmIiMnDOM19TshLdzTQ15Gy9fTwgKw8TxSlEnEmoHsgmvMsR3?=
 =?us-ascii?Q?ydoei+XD74QrxdbmYVmB2hJX8KmvX+Nn51b0+M55lxyuVCWMcSYskhuAM1lp?=
 =?us-ascii?Q?ojNoKDMrq/+sWWsEm58P9tAjGeUDVl9sf3mlPxudKHD1I7EBcF6XSGX6i96z?=
 =?us-ascii?Q?rXRNugrFh8bdIjkZkI21T9DYuFHRHEpeB3/JeM3OLUe2M193ikcA3tkL/bNJ?=
 =?us-ascii?Q?L2TYxF2ybd8JJsMa2hFYMN3aaljXZ+7RLNU9Kx3y6rdIYmB2SfWPYhBoV4IR?=
 =?us-ascii?Q?7hm35ccihyJopQIagUs6MCtJRbwW0zpweh1th3w/uMflqNgdyNUR4T/beqTq?=
 =?us-ascii?Q?2d6vy+YKnHMjm6uZAvLyduLa7t+Kwk1Ws/ALy6l7DSn7reOKETefIEa4wLQw?=
 =?us-ascii?Q?qrsF/urhNLWLZKWCtpvTb8V3Qo9dVHmVzrQpPuAOG/ZVYXVmBVA+oFTT6ZzX?=
 =?us-ascii?Q?INbEzLuuA3ZlI0/0w+5SV0fINCQGNDXbH7Seq2t1olMyBUiXERIqrcNuppAJ?=
 =?us-ascii?Q?mg2wD1EEZ3mQp6YvL2utOUCdSrUvO0EwXGKOuYGVrTyCQ399tiNa0pehHINP?=
 =?us-ascii?Q?DrxHPIuQUnOwIJXsIVSRVKdfGjpvUUTOcrNNS+m1zFHNbMD/Mg0q8+DHyfVh?=
 =?us-ascii?Q?VRbr17y5ycTcR9P8WiVV46uboQ9AnJm9Fh+du77xJjpxUE9jJNEwh0AVShOV?=
 =?us-ascii?Q?wAKm/HW6MNndxb3XsWpKHY+9cter58SeHE/NxF0E5anVB5vDoFXQUom6LTBB?=
 =?us-ascii?Q?Pl2c8nhyiMTMadsCmfXgjKl3tr0nybLpsY2n56bAFRMOtWx9ujmJmHXWUy5N?=
 =?us-ascii?Q?j6A+dMbVnDjfBSHKP9gcF/z5nFozo8Qn9V6EpY0M?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b5435-0c94-4ad3-5b76-08db7c8ce574
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:47:59.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWKw6HRMIuylBZl9mHdz1sysIxfeZscbHLajJXMgioolPwco3M58Bj5hVKnsFIpY9AApxMNmuDyMo8+hn8xfUA==
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
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 53abddaebce1..c1477f657839 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -849,19 +849,12 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 	iod->reg_data = match->data;
 
 	/* So far We can assume there is only 1 bank of registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "Missing MEM resource\n");
-		ret = -ENODEV;
-		goto exit_out;
-	}
-
-	iod->phys_base = res->start;
-	iod->reg_base = devm_ioremap_resource(dev, res);
+	iod->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(iod->reg_base)) {
 		ret = PTR_ERR(iod->reg_base);
 		goto exit_out;
 	}
+	iod->phys_base = res->start;
 
 	iod->regmap = devm_regmap_init_mmio(dev, iod->reg_base,
 					    iod->reg_data->regmap_config);
-- 
2.39.0

