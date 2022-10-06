Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E35F5FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJFDdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:33:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA3132D8A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb+srROlQXeMuWKvFBFXDjxDbsVHVY75uznQe2MkabEvHIVEGXVbIKWB0XU4OaJXr0uQ8znCCxu6Vml3Y9sspzafQqo8mOTa0HvfuogE1a1/bKWaqArNMHHfd9MV/naQPT4bmFqKTjWRUqHqLI7yOErI/XAKhCf1glEKmdFzVVZid799s/aQjtkX+6sSBzbDCekVyQ9/pHoo5lUimAOsvCJDDJEWMqed6TrrKA0b5mM+NP820fuzvH93bb1yZC+0jJM89Ec/1cho1lnETSM2FuBhK4D2ky+Y3p4Nw+amcLO0lwKFSHFVVnJqmiJkfaCFejp/EaOBBMo3R5G08FqKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPymUdVftnwO5/OoZP+Yrg7xoB4nvJ7Sbzl3GpXndv0=;
 b=mRA25xBqZMKp1UMd+GT4VbC49kkMBqrifj6por8LE35qcICcHWz6ylZ3v6ys162Kxp1rNxdKPJpSOUDL3NQmfko31POHZd1inD1AEpzqKUcNnXAWTBXlAc5EOoexerAmhb6K/ygFWoe+efsa6XL4lZC0ZwdW5PLLDLDPb7MUTYYiNqlC3y1GvLL3U1aYttbzq+EpDilLHRZ6ra1L7BP5tb5lo1zu9kCgV8sLt3VLWpYZiiLpc90Gb2JSqawBsEUjJZmMrvADtiO+i1B/qeoaIJTEo0BwTx8SACWY50jXCbmXPEz+zmRyJ5ZChoeDMUarf5RDd7SmTouuDXE6BE2g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPymUdVftnwO5/OoZP+Yrg7xoB4nvJ7Sbzl3GpXndv0=;
 b=UY8ejV7vYht37L5nqVWzjLM6tkzfGnwh8CDXM8kUFmlT2RJmhbNFUBCkpZBeXTfyN/XLNAmdO0Fq2RAqTni0m1K8E1GHzUqdvp5LNHGPCnk9K1n4Ob48+erXMOzBsY55zbgxe9hfWUm4UOqa5U5d91R2LsNdcToDKZ1noF9EOdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by AM9PR08MB6740.eurprd08.prod.outlook.com (2603:10a6:20b:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26; Thu, 6 Oct
 2022 03:33:04 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 03:33:04 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] spi-nand: add Winbond W25N02KV flash support, fix Winbond flashes identifications
Date:   Thu,  6 Oct 2022 06:32:56 +0300
Message-Id: <20221006033256.111664-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0073.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::12) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|AM9PR08MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: d44a923d-53cc-4bfe-2398-08daa74b7a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP7Ur/j0ZNiBHUU3NRQEeq1eG67hvTqKpgy5MjFZlzWGOOZUgaGYpI4iTczjZE5j5EftBvgLqKNQkLnKRvomECi+Wkx4veMhkYCDchmLgUeufmm1uEz0VcDl/Hl7HlkLIsixfmE49qrcrztvPmMwOYugE7gw3LtRa3Q555DnaVabiwaBVdT5juWF7e46hu4Z5W1wviJ21K+tCMZBNDtSlUAZsmPA2WafVAWrZWLEQxNzvKrB4Oaly2B4mi1kVzd587TDPYH89Mv3azEJnQhYk5LTZ8p6wFukjoWjh1LfCoKhihhoxCXdeQUmhCEiw4qinYACscxZZvpkRbGnS0rS3P/nHP2c9sxF4X+RCtfeGqKswJ4no0U6WZ+Vxmpb/2J2LUvkMVobabj9I7SjCzWtciF9CCdOTNdU9qG3viqfyNt9LfFnq3a2Muqsk9cAxLyssmlgO4aeNAT6B20x8ZsPjx4yAkJGBljXplZSSs9o2cpQjrqvn0ItWQo9dr7Aa1c6QEdCwzDZpMtv5opasLZqColsisOVtvpbIjfyCYgiSPhv1COL1H5Rwtmk7BbjM9j6IPXZWGxTtLyxF+SJmzCAZ0uSDfZFpExNMrgse3Xh7wMh5lYXpp2eliMIdXpUnZENUqRg3SQEFt/nfMxjshyfoRdVl/eu5+KNgeGLM3wup0DC7znOpD/VUqy2Bs0CJ0V9SVKVnSN/ru4UDK1L9F/uC3LE1SsJa26arLuY2mYpu40hcpZU9j6Qfv81FFHSeTYjp40xXqj2/rT3dgVFJkv+8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(451199015)(36756003)(6666004)(6486002)(478600001)(8676002)(6506007)(26005)(4326008)(83380400001)(2616005)(54906003)(2906002)(52116002)(1076003)(316002)(186003)(9686003)(66556008)(6512007)(41300700001)(38350700002)(66476007)(66946007)(86362001)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPtqC3LwR094z+iGS4MlARCSh87jtAgxhU+pml1VqyHTIIxEWHV+x1i6zezU?=
 =?us-ascii?Q?fbZxJcfwX/M53sDWf5/r6wwjn48IEJFKt/ZcS27qvJc2SWaAWh5lz4lGQy6y?=
 =?us-ascii?Q?yyEzx4LO9klxhSAkbYinQEbQeULA1caGXDrkcjcaCyQ3cgzNUM30CGtuNYzy?=
 =?us-ascii?Q?mtgT9jtCbG9ZVGlJDtQoPtmr5E+iKeHCJDo0l+BzxKxZaSMSBD5GQDSQOha0?=
 =?us-ascii?Q?R9DmeqAoil90cOwzZcDvD2DwIvG+q/UzxWys1QaRIgj+Qw0bJTyBkxjA03Ih?=
 =?us-ascii?Q?wKtYEM7/P0mTAwSqOtv0442xqVj1O09BfcT0mKyzPWnAeOaaLOfxCFztA7zq?=
 =?us-ascii?Q?gCV5PUSUc/+e16FmsOGnGxaSMG0qD+zo0Q4/f6vXoQhL7ZsrD1ue0g3Q1CWD?=
 =?us-ascii?Q?EOYqwldjWp0FSDV/VP9JUCGBM4U8CA0LvFlSYgK23R2U0F3Zi8pt/Ddad/sb?=
 =?us-ascii?Q?N9t68FNI2ayoVGvEAjMtIZQTTxSEDqbWi7cXgqDAw8Q+OypF3qIE7CbKO8GY?=
 =?us-ascii?Q?sLuGn4hhRKHhj8lUH5bq6MDsEOUFrFK2plYe+jEumUfaz0ZphVn1aO9uh6U4?=
 =?us-ascii?Q?dUBMJz1jATJxfOo0LbljsD1tNihLyVClTBZuRWjJ81KfsskoKrqKpK046qez?=
 =?us-ascii?Q?UAut1XvN2AIU5Ns94p40CyRwRvAZE57FPeUFgcUOReYPapLwcsGtr5B/9V28?=
 =?us-ascii?Q?Q4vbMfTyXcANbh1Ng/+MQpVTbsZwl8uZ//s+39G7umf1BQH1yRVEAp/u83sk?=
 =?us-ascii?Q?uYdhv84480waE0odGBclIl+qzUSEJP9bge2kcV3q2EsYnzAd4MG3UYzxhzUN?=
 =?us-ascii?Q?0s604Awl5hewFslrz/e3dyBpjxTbIYHBYVgG43tjc6a5F/zJtE09v7hlBOYo?=
 =?us-ascii?Q?bvo4IUjbZx83Az+wW4dBGvlFpu9XOynlapc67GSdb8QvDFdJqya4ks9FXlMe?=
 =?us-ascii?Q?Q8MOaumwYLbWZ7X9oBHizXc3iWdjxdh+KsU2boBl5DATqxQLnAJIb3s9gaf0?=
 =?us-ascii?Q?jtmMVjsSBw2Qdo1sRNdrO6oXs+ipBGocq2ZmkrCETlDlwaLUdPMXB4FVNdGe?=
 =?us-ascii?Q?jvv8+9o+Z9UJefB7453TtQrSurHn9J535dNHZiV1GOiWDck9RO5fAcz8YZ3u?=
 =?us-ascii?Q?AD70duVjEwmTPVSgOYEXCcMymObUIkru0pV/mAORtiSr3Hb8mO8mJM6EfUvk?=
 =?us-ascii?Q?/QYrinE46dsqU1jlB/omn9mZ24JwzbnGgvGGsF6i7VHIS+Tm7YJqz1fsFdjo?=
 =?us-ascii?Q?igM/Udp2MkmyEatU8JcNsbWOVdcFK2uO4NX2VyQ8SsBoStTTrkNVYNJfJxQu?=
 =?us-ascii?Q?p+j8zfHcLvd3k1931AKF8N92tC2712ovRr4xqZpi9UhMWFN5ZTWaeYY89xRQ?=
 =?us-ascii?Q?RFEM8hsdmO8pIwbZ5oEHBnb59+PVPhcqPStybQXj6N0nYwF4YfwKfcZiOS7j?=
 =?us-ascii?Q?UcjPxQKZxVsVJtJ4Z0xYbR2lGrHEIsw2Ie9DrcZ1PGC9BmtsFHTwF1q1biS3?=
 =?us-ascii?Q?+jmYllAchOKKDjU7ACzF1IzPFsNiMJsCJ2gpcq9rq9ATPhXWkdFdp7Wj7VLz?=
 =?us-ascii?Q?tyUyDNg4KOtYnVHA/dF1KlsFoJPgAxTaxNJfHughmE+rDz3AlzFHUEX6OdQp?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a923d-53cc-4bfe-2398-08daa74b7a07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:33:03.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2y0pFA0L53Ca3f4i0HIWImmR2RK0a02ubtGw+zxaJfxI0dnw3+m4uj1LQlr2aj0hptn4kyB+OSLFhO/7nEz0AyQftkTa9g8aZlXeUv8ELk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6740
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

Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
but current driver uses only first 2 bytes of it for devices
idenfification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
is identified as W25N01GV (id_bytes: EF, AA, 21).

Fix this and add W25N02KV flash support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/winbond.c | 79 +++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 76684428354e..3ad58cd284d8 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -74,9 +74,75 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
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
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -86,7 +152,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
 	SPINAND_INFO("W25N01GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
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

