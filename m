Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE25F770C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJGKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJGKsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:48:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E6F473C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpWyLosSbLDE9MI/5mb/Msng68JRjRem0dC9k8WvX3b5miMRdf0rbwiUVA9RKbP/FABB0QSExUb5H25AFlWVUdF1W54baXM3wmrmLRzjiShX8f4YtF6g2KNp2OYZpAYPZEKyt4DNSbtVC6nual3/6R+8kWnkFjYL5pEV1tArxPsZMk6XKwlUW3mjMI9zGfGF4dHa3wgkz9NDZuoDUloJKHQLNwEPWTQPFX6ArQgxpxgDICQVx6JHJHYUaEgtKdJj+R6yzq6AsXxWV1igFAo984UOc5wpBo1pIJHLV7Dld77tHxeiCNU41DA//4RgxgOBqwOqv18LuYOHhilsaggKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18prcxBJREUaGwRmTI+XBWEaWZutDkiUUm/t36qn5T8=;
 b=YJjjHIw1J8Y5yF2EESKevN0tuEcabJr6EcJHO9oF0Gj8yMfRPndAzKrGf4pT1mX2l+r4yFfZN0lhAMqebaNsvjBRmnR66u/BksyWhvcyoedLnuRKRD4t036aQyCaJfkuvu3b9gzzwVSOiA3HSgrV2SrmAi/E0xsBwySo2sMSxiLPJSMqjvpg0EeT9lZtJb6ABbLfvwary2gr2Tg3acfF/skQhesmvu9mZf/RmcuVgeGpMbEhLtt9AS6kTNQtHnmO/eVmuFROCUiu84UqXKzD+NIe1VRutKCSwkvo00I9YuVqUOoELKVBMeBLqKSxAvJEn5KLCj0TU8Jmk5T/dZ7jLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18prcxBJREUaGwRmTI+XBWEaWZutDkiUUm/t36qn5T8=;
 b=tAId3B0k1llGT6XPFPS1QSFfSvIULJI1QXZ7luKrwvz4fQ8eCcp6csoFZm0zZi2nP9vwx5+/UjEJ5ZsPlzRvnVWuGJc97gG8onDcQABxBWkuyJ9nt2o/xBZQy5qpRdTOd3HUjilUz76aLSwkD/QdYWGAA8LA9AU7baTkNysoYD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by DB9PR08MB8457.eurprd08.prod.outlook.com (2603:10a6:10:3d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 7 Oct
 2022 10:48:29 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 10:48:29 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 2/2] mtd: spinand: winbond: add Winbond W25N02KV flash support
Date:   Fri,  7 Oct 2022 13:48:20 +0300
Message-Id: <20221007104820.198938-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221007104820.198938-1-mikhail.kshevetskiy@iopsys.eu>
References: <20221007104820.198938-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::34) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|DB9PR08MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: e261c601-813c-4559-e47c-08daa851789c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwYtwUhqaFN4ZDGvXZLFQ/8r4j5vetWaapQ4+L1to0U+jmy2Pk/yENlYH3bAd0SH4wy9WY2IuXDhaiO44Sye0ua6EoCDCgrddfr1ZV5upPRBq1OKAyJAuYQk/pyHXGy+gDrccl92igdHGp0jqT8vbHLQMAhrWz0N9lQ8Hvp/igmQM/PMPzp+csMDSDpu13T5DFkFAsRtBJwmryqCL6OsNm1IPUahkD/2ZgWjoWyACNW41A/sIXcW2NaDe2Ft0cZblu6x70TaVes6sei3ciZWR/tvdW/dUgbXKNdI+6YOrkC93x80GF5kQhvsULPggXgk+3hVNUL1IQ7vhkbS4tVUXqignpzQYN7lcEGmRVPGpWNlbnfkT0Q5u4WsoNMUO7TF5ow+P6SmdW17zUUUzSZ/800kMxnmANbe7n36IHZUzfZiEqPazWV9FTUKQ91TP0UlIXYSgOMnpgJBqpa4DTtxaLx4OzazSijxbYCm/N7d5Wc3GuEOEMAw4S0Oujjfn2M8+6xdm3kEsYW8T+pYaJ9R5i0ZkRN5nOmCPZEW6JU8TVW0WhbPYk2GCwAP9BvAQlrr+zptQX0bXN5CqUUmrj5vMO/8H3n/O6FWcllQMq+WXVam7DcajCn4a0dyy5e+THUrPaJ/eG2RLCaEtAn8w1p6aNkpj6QWgGEgSQMpra7WPXGyz2urpa8Vsf2daV3WZibUZrOlCvmXUgx3buBHdEJ/QkOpD/3KaMcZ18zyMHtu1WHK5T9v5f++DB941OeZ00gEStsT0HXicUY6U6nkakJYQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(451199015)(8676002)(38350700002)(66946007)(36756003)(66556008)(66476007)(186003)(38100700002)(1076003)(41300700001)(6666004)(2616005)(86362001)(4326008)(52116002)(83380400001)(2906002)(5660300002)(6506007)(26005)(8936002)(6512007)(9686003)(6486002)(316002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QK+srXjLDoBlqA6CZiSWWwfVnY70UhN7Ig15SyzkW4HXBkk7fbTHibLttDiJ?=
 =?us-ascii?Q?i377IqooWateEEHeVdaT8xFLBkce/5d8Y+J7tiMQZq19gJsucEydZFkgL0+k?=
 =?us-ascii?Q?FytelkzLmScvD8jDrzvQN6cxJGCUfUzWxVsFQBH7H+ke1sNx2Z91VGL1aGRB?=
 =?us-ascii?Q?RClfrk4mj/uKsDj85dSTaBQ7Qx1DOEs4+aqLn1tV6NFwMjg39qPck/61jNMX?=
 =?us-ascii?Q?Eg2y3TNKPXp7l7NrTZhre4WFGon2eJ5Ces9tmW20PVRvnKpPnVPBP/Ktn3MA?=
 =?us-ascii?Q?HK+9qEqS/hIDhIS353XluR4PWd5L2YjwZ8DTRc6Qp60K+4PgN7W4fFmpZIYo?=
 =?us-ascii?Q?t7ifSucgOZshquDvOfFN4bH0Jukzz724/GjmcEgg0FBKvu9hJe4ZxNMm/Njk?=
 =?us-ascii?Q?ZBOTqKE8J2o6TM0GZefwuqQ1Kex9zqPzIonHTSiy7sTk1PKV368xzbLW/CvS?=
 =?us-ascii?Q?aq/usMHCycoKqFQe4CptBbzHn7T0WW6Fyh5i3hDPTbTdC8hdrPGg8KI+CIUl?=
 =?us-ascii?Q?y6BOyoaMbKQqfJLC5eEbZwtwXya56Xyjjh1A5CM6yXUy8OPE7kHus5B5ulH8?=
 =?us-ascii?Q?srPfFDoPAlQrnOQUG6C/t2oMNbCmOU/DG9F04uTBm+eq7uGS89tkt37z5El1?=
 =?us-ascii?Q?hBpKF5PBJuuOf89112O5ORCGedOF44vgVn62HsUbCGL7Nxm/K/K3/4JFG+a3?=
 =?us-ascii?Q?JqptMb1fkIsLOapZ+ARcaUI1QJjXljBwaOtu5S7QmRoWYM1CBEk08uiPs54W?=
 =?us-ascii?Q?p138gILC1Juvw4Y0wLqtpWlNw6Bc+f6Yorpon3UkgCH8LA0P+y02ZMFun0If?=
 =?us-ascii?Q?zoONx3UHDgwzf1pxx7ch9dUnpG/zj0jf22nre/zX0+Om+0WaEE83AKbyQcHv?=
 =?us-ascii?Q?FsQznHyYtanrkju7jbf+EtP9fz/K4B26qlqdqiUyRRjAreOJLPTYGevDyanY?=
 =?us-ascii?Q?UF0dgtmJT+VT0qCKOrOAyHFJ01iukjx9MHG9AAyvMJa+KqeeYeNou27KELSG?=
 =?us-ascii?Q?wJL/GEIp/P9FOprmL+NgX2FpTIlmllpT+PR3obN/zoAdgAjQovzmtuieL/UA?=
 =?us-ascii?Q?XiZkto3MU5+0KQRSTzzjN8L9mfMKfk/J6eIH/dadWS13X4Bvre0kvbhs7QlU?=
 =?us-ascii?Q?PypDvOHlBCf9Y4OJ82ImOPPX7LIwHwVvbb9pDnfyNFjqT/nu0LRPe2P6rtMf?=
 =?us-ascii?Q?Re9JA4ETkdET0Sd3PdGd/icM/wJ4GYQWgoTxzCTyWkncSEFmlvIrd+ORWTVp?=
 =?us-ascii?Q?VjJxAVgWnK/kDiYylsbaLJyMRFhonyJDs73Yf2v2r+HcggBz/sPe5M4tuVQW?=
 =?us-ascii?Q?AUCjTBuJPWfiXd7UjvGxVrpq+XV84zgu6T/ZLw5qMoSwzl75KsO/zbpg7/47?=
 =?us-ascii?Q?ZirMRriMitjghB3tjV1roOlTEeI6ZCtHSWAGoMXMBn5NzqmX0RB3lcYu0ah2?=
 =?us-ascii?Q?fUo6gGfW1/gYFaT5dRNL1eWoHXmSpX0J75pK6nPoHvbcHGdzzd6XcwB5hg5n?=
 =?us-ascii?Q?kQCUlCdlyCMmlO48AKzWFiMKetUSfbrVzqlUCeCgZtsWe3s4ATJKCaI87yBw?=
 =?us-ascii?Q?GcRsRWlnFayT1xFvGqCrSFOPbH766RTwfObfSuEawSn4JBEyxkR+o3ldJf3U?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e261c601-813c-4559-e47c-08daa851789c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:48:29.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENvCUa0RkpqimXQmHYiKMc6xn9obsCaChMCVoqG5pc/h9y7XjWRq34OEI72x4pInOFpeHy4M3XgJXAmv5Z+wneNad3sD37cisGCqPcbeBuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8457
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

