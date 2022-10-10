Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFB5F9D13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiJJKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiJJKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:51:24 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2026BCC6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhHWVtiSKvYB3dWtupI7ixS4NM+B3ZJb+fAU/Ga3RnthniUSPH6HGVZHvJVMSYybtdhV+JcGMW4fbjVXkbxDcAJ2WmxbUpM9Ln1YJsuAKpQL/fqDJRGZvPY/jFn6vOVCtLpqg6sceZDOzevYJCQOLkNwvrjVYySNGHhOAsYSI+JSGYz6XLQjhKjiOeJsBkbV0vZNZfNWLlfnxHrWMZXahTtZaoXSF8F0/XBBkIo00zOF4VxJwkuYKtHjsG4WBFoTtwpDaDxsdKDL+/ZsKbywToTxPmDI5eK7hk9IaM5pwgdwhRb4+VofzcrRKvYhoVmAb7cyd+kMdzWnE3ODX//ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYE9jRY79i9EpnzYY1n6TqsOUiJc7ajYeoBJtZ+FJe4=;
 b=Vqw39e5S+1K/LJC/svG5DoWgPZilRQRCfSl5fwVxLACQ62Mj7X7xvJsuyVwxeedQQbR1E0DgLJPdSKxLSWsr9Mepmopsg7B7Hpawpe4tnPsSAqrb0WOuy4KutlOM1wJRdbasNZgp7eeWUEKD6kBO7wVbyXo+Q9Cd7qiD6i3WvXscLnq06xQt595bauVt83AI3ZvuakD79S2KTx6//VmUKJ0Eb5WuBjYZLpyGHW1xpWexDIDvGhGglEpYyIlqUjw/QCmgNvINCjNUAUkfAwqvg7hOxZS9a2IeHmifj5wcLDZZLnUQKGWJjzz+mcp1/SQb+RBoVeJatOvuVP8iCG27EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYE9jRY79i9EpnzYY1n6TqsOUiJc7ajYeoBJtZ+FJe4=;
 b=XZHrjxGJUuHQp5V2HYhTkLc+Vf2DjhKuXsHQ+mkg01OKfGdSz38KdQ6bwQDtgAf2InAl1RaA3fWNOaCQbR/ZmzCfrVqeJR7qH+GlFDsGgP0+WfxPZoVglp3XmmEMTm/U+a4nHiPx5NMTjAMJsiRPiDIvYZObLkktl/qf/P9SF74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by DBAPR08MB5751.eurprd08.prod.outlook.com (2603:10a6:10:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:51:20 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 10:51:20 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v3 2/2] mtd: spinand: winbond: add Winbond W25N02KV flash support
Date:   Mon, 10 Oct 2022 13:51:10 +0300
Message-Id: <20221010105110.446674-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
References: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|DBAPR08MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 84171422-3073-44b8-b358-08daaaad5d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcwBoCTOi0TN5y8G8v6CeCDMp5q+f2bEfG8b+VzwwqkPrl0mSh+kgADViVoqniZeW+fue5HcC6P2FIujEMpAX4ImCNkoLsO/scyTsDsceqniknrG6BVuc9ZnnsIH2JAHGdzOUdP363KnU9XqTw10G8C0v5hAwdX8cZmUUJANZUD4mSwMzn0PML4gNm7UvzrSwxzMPPSKHTnJz3NA3MDQY1/W85cW3Y0hTJTLtnqWh1qdC01UtHWnVsMfGLSNja+rCmYDmt5DD4fh/ITN6F4FcSdKehYvUVKF5rduMI7tX2S78dFzkMH6DHqCFRrY988VELgTHtdzoVDyrgmKMqtIbdkvNvWhm7RprDfnV7qbga3jhkduEZj606f78iIq+B8hdHOQ7CqAAVIY2WlRtGdJpIjXD9+sc5bJqnZ8MkvPqhgzA6p7lxwpfxLYwMH2rf1Pg4n88kkk5RnLfy6ksSmC852uGeFv09fpVe37vNJi3XNOqm1EJdzJaB9JNxwJYNlUPskX4aqIG88pmz9WX6s04ttNE+7ITDOin7C+Cy/3hL0XwIhiB+WPCrQLRg0cZr1hhkdPhhLEDBzbsZ15ZXiuSbLjmp75Z9OzZ/uepz2muehYsTwCUuzr3LSJCQ3hLAAdIMtQ7xj0GWK/u9sEAWg23VBlSIu6eEVYWIIUluX8rDbHVa9xIKKAUKvFPDOMK54DtiowQsov24jTsndWEYmt/TXfG51T8iBH5JxQlWGnS/J8OU7pfRoPmjRQjiznaNBL19TwgcUIrpPG7NfkF1twQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39830400003)(376002)(451199015)(52116002)(6506007)(86362001)(66946007)(66556008)(316002)(4326008)(54906003)(8676002)(38100700002)(38350700002)(478600001)(36756003)(1076003)(186003)(66476007)(6666004)(8936002)(6512007)(9686003)(6486002)(83380400001)(26005)(41300700001)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C7Rc11B++8IEyAlf8Yg6Bz0clsGU0oNVqp1DcB/hd4BtbifUneSGbhYxbqIX?=
 =?us-ascii?Q?Ad6Mo/Gvw04UFfiG8l1ShtPwrZiSvsfslaxVaIUP0cllxh7+zrvea8ryIerz?=
 =?us-ascii?Q?KDT9IvjUI27IZrIAoYAmm8aKN1CEroMqatC67CeQy59Hebtck4Yg1GfXivJN?=
 =?us-ascii?Q?KQsg0PMlnx+1piygTWFAI/o3dk2PjHyzmSxqyWFcAd758qrU7//A+FnjZokq?=
 =?us-ascii?Q?YWZ7SuH+TPUmTjeSCo1nRBDxVYQnlHi+6CauVX6wnpNDdAmTW1tfr385ap9w?=
 =?us-ascii?Q?vx9d/AJMgQJfV3pMevXiCJHukVcKdkFvhz3rM62GMwB+ldjAFsi6FVNrrasD?=
 =?us-ascii?Q?NpE+2y2H+Szo67VZ/VQe0a7vm7TPzqiBZhO5ygxPfXw27umLsjlBPZx0am7W?=
 =?us-ascii?Q?41zciLfaqCGPXzLdx4GipBJGDUY2Fkd/ZdScwmzXr+Yqx1im0msMHNKWUnns?=
 =?us-ascii?Q?tjXizsrkvlFVjzXbHk4hiyfh8KgGYPDHxyd0dewTvK4o+2uTDyo4wPLXoUct?=
 =?us-ascii?Q?Pafh/w8DjlIqtPB0xIQ45MJ1aV0+iwtbRercT0SQUB0Oibjkhn1DwhZP6fXo?=
 =?us-ascii?Q?9P3Jh85Ew6RT/KmlH2sFUZCzP7mFJqu2c05gHP+A09OdVKiCLZElJiaTletx?=
 =?us-ascii?Q?+bQRDZuC5QydXVt43T2oQLAtgeOmz/ija+4+57WxnZnSLGdOELyOwsU+nR9N?=
 =?us-ascii?Q?pIcHxcJ9r/WDKn+PbsyZIFZSg+4BnFtVrIofeiOXVozMcPpYQnxkvACLXttp?=
 =?us-ascii?Q?1+VaYd7jcPoEwprNvRvHxevwOmcll/XGpfIMLtDGGaejNTpKygnEUMv9p9rX?=
 =?us-ascii?Q?7T1HinIJoLrwIoBtOlNH55SD/k/F64KWXcTPQefnGuMbbIX53bQbMUopp3Zq?=
 =?us-ascii?Q?aPCBKvzHjBHlGD+FSpMDEhe+O035E5n4ShN23v0cNBAPZMW90IrHqwk7Ib2F?=
 =?us-ascii?Q?ZWU3MUx/DN08pyTId1u3X6sKDez8E6G0F+ULZ8eQ3M1y1HCHH/61U1iEqrf2?=
 =?us-ascii?Q?AXZ4u3VLI3zimwrwR+6qhZd0JNz1Q9VMj/N344rUgoC3NKKzV22xjI0EiPbR?=
 =?us-ascii?Q?GOv02frxFSs9UBYN544Rhn5xmdYkARpUb+JWiwvVIgHq2FAjAeFAj3CDm7ge?=
 =?us-ascii?Q?FrIpdTvDxYrMCy88XUXrw8h1qRYnGHlu3w5khs+XjM4esWndaTTMz/Gwx7gM?=
 =?us-ascii?Q?iSENGvVNlcP0Zmx7EP139WCupfpi7YoVx++h6aX2YGPA6tALelg6nWaZZrik?=
 =?us-ascii?Q?Qh9uGohYlFNh5Cg5UsM8UMgRiHGYVhmWqWVtL0ikAK5lHKOf/QsGoXmukrl2?=
 =?us-ascii?Q?f2RLMBFn/LP+lAwRi68OxXD98dFrMqPIRMvIK223MJbFc/nnhoSDuVhJSJx2?=
 =?us-ascii?Q?FOf1RApk4DF0v7XLcIP/I/dgbMqpUwQ2lZ5uEFvDcDh6c4fEIfb80nyDG/0m?=
 =?us-ascii?Q?ef0xTo9lGhMUazUVWtFCCAUuHVMrcBpvFAgwN9oxs2u5UpYAdo/9c6qt5WW6?=
 =?us-ascii?Q?roNTCxThyYoLMCko+TKYpoqlTEFFVUBysQKro97HTiHQnO6VCzGxBxochJjb?=
 =?us-ascii?Q?JpUSeDr9ySO2dxNpqAsh3THxP98Pf9Xv44dpGIYD4vJRtHQZQI3L2CNMBvpP?=
 =?us-ascii?Q?Ct1ZGbAaPm4RhnYDZthV+kw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 84171422-3073-44b8-b358-08daaaad5d49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:51:20.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2V2epmoMEIEbgQEVIHJyAIqSerAZDjQROa0HRjAaVegD/lWdJLK5tv6qj++kmJOYE6at/6wUVRfkD/NUYTmQouYpNz4qqMwheiUKOKlgn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Add support of Winbond W25N02KV flash

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/winbond.c | 75 ++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index ed368a55d68f..3ad58cd284d8 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -74,6 +74,72 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
+static int w25n02kv_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = 64 + (16 * section);
+	region->length = 13;
+
+	return 0;
+}
+
+static int w25n02kv_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 2;
+	region->length = 14;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
+	.ecc = w25n02kv_ooblayout_ecc,
+	.free = w25n02kv_ooblayout_free,
+};
+
+static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	u8 mbf = 0;
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * Let's try to retrieve the real maximum number of bitflips
+		 * in order to avoid forcing the wear-leveling layer to move
+		 * data around if it's not necessary.
+		 */
+		if (spi_mem_exec_op(spinand->spimem, &op))
+			return nanddev_get_ecc_conf(nand)->strength;
+
+		mbf >>= 4;
+
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
+
+		return mbf;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static const struct spinand_info winbond_spinand_table[] = {
 	SPINAND_INFO("W25M02GV",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
@@ -94,6 +160,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W25N02KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
-- 
2.35.1

