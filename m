Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92C5F7701
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJGKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJGKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:41:13 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50051.outbound.protection.outlook.com [40.107.5.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF557D57FD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP+fbPZ+lFSyUbvk9M2T3TKgIYWR7yeUzVodM6Sih2LkpbQppQTJ3HrWcSrNZ8Er1xySNc6A8t0ay0EFmkja/NajBbW4fcMQrM0Wm/J5fQwztaU92XS2Ii5TDRoySTpGtpJJw3vO1ybozYLEcf4zS41eRYSLjj1ll7+JemQoJPvqOUPqSH076nsJ9Tr53YEA2elsnnt0ilCJz1Tp9p3u7s4lHir3EbYouod8s7una+UJoQxjcgOuHCkqcG6dC3ADo2xum47Pq3yhn2Y3JqWcFrZkLJHr7k0sf6fUF7i3xw3Yd2x/6Tk0BMKRoO5vuF0E4ksg8iY1r8RNpRJ3SH3lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18prcxBJREUaGwRmTI+XBWEaWZutDkiUUm/t36qn5T8=;
 b=OCPH/Im7JhHr8+Wp3lngJLwZXuW4uKoxIA4SIWeGc4zo+pq/5/Tf4TT9fgEiujF0Iy8mMcQsmURQYN5tVgum/Xer0oblYhrvU7iEr931fJ99QEk/TK7GUIzIeK5TVuwehNqCNSnTjR00hmiYcdfAmX1WWuwd8AS2mdmADPukfuxKPEnHAZCNBgsOIw/XSEq9so8V2mIKKWf6Iahgm7ViWl/fV3YW/eDMgpDzDN7fKn865FnrwNSFd1J9ErI+8KwJ56diH+5hj8YJGoQ57d6v1fib32yMHpszGFciiZTxmwZvG5XIRK1fQmmHsAX0UPXBitVYIfdKYXoE4Hj7kYH/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18prcxBJREUaGwRmTI+XBWEaWZutDkiUUm/t36qn5T8=;
 b=ubIfFaWWcyCZiVxKK1ysalBd6sxH9sP8biawURnAzrM6UEDTEb5fJ9SLbB27iN7Oix4CkOd08mme0lVGW9X0qL7YKqfQft1bnJtxRTjqSzMsYpqTPWShuEreBEB2zr5P8pkQGPOaCZnsOH4usfFTBIamDBk36ikP4bx+wIW2wYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by AS2PR08MB9595.eurprd08.prod.outlook.com (2603:10a6:20b:609::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 7 Oct
 2022 10:41:08 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 10:41:08 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] mtd: spinand: winbond: add Winbond W25N02KV flash support
Date:   Fri,  7 Oct 2022 13:40:58 +0300
Message-Id: <20221007104058.198039-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221007104058.198039-1-mikhail.kshevetskiy@iopsys.eu>
References: <20221007104058.198039-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::31) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|AS2PR08MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: ff249ced-a53e-40b1-4a9c-08daa8507118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPe/wsF2MkfNbd6E0iRjPF6B482pWcvfSII7zmDkbWasbGqzSfQ01yiAw2aDdByQdiz2c/XXkO98DEJw5sLCpU4LiBtwyhx0IksgfMnYOEl+IdO+lG0EtBXu67yK1wHKR6VWPjiCOAMiQEsCDoNY+xNX4ve03rsao29uMWhYRIRowS6Pdx+au2Xt8HHRSNMH7Hn4S3Yqgowp2kQfi4erbSF3QPtNPiPVSr48Qc5shkiT0dT/mceOVkVsS3ExBxjrhlp6BAde9ct9V8AUrUMGc0siwE1uef/JJQFI5spHIQpXc/8MnAY6WwyQOVIkM2geA8WCXyJTIfJP/+AyQuhZaGJNDdPQDSpPSAZ4hpmfxqR8xgwaHJ4soZKJWwNToSoSmXjUxETqZcJvjrRy34Sm35gNQDxNhkDMpLoszGMGJv1D+AkgWeipx6+JFIfnrxkxJj1TAmBeUDNVFNV+px/dPAr6fHfHuoidzJdi1VNCxUtykUWgS1266CoGM63J/MQ8r/7PuFi4Q0RsPsimnKHQMSSSWOkwodCniOvPm79Rw1Aicy9xdQ06uvxikA2DL/VSheXACu43MJ2x3OmKuHRlp+KuYrFC2Ro1E/Lw2GwvmEPkgx/Guko2pvsPAVzH/MI/1SEtOZ+9OeZBMWMFnoUEe0hc7yl42CHZGi7feJoJzrg1B26Xxos5eQxczM7ORTfOSF8WyNHJiy6gy0kauVEm+vfNiZrIPBKTdiYhshNsTM20JnjG+r+PILaPVzgHiwwXixzWKemFH857lfQlwx38Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39840400004)(136003)(451199015)(2906002)(41300700001)(4326008)(66556008)(66476007)(8676002)(478600001)(52116002)(2616005)(186003)(6486002)(1076003)(6506007)(38100700002)(316002)(86362001)(6666004)(26005)(5660300002)(38350700002)(54906003)(66946007)(8936002)(9686003)(6512007)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zow99v1ydeQmexGxrd8RoEwQRMrW+Vl9DeT/3AQ0E15WZFg2uxTQW2jjzP2f?=
 =?us-ascii?Q?PrGnXPJtONmlbTCc5IinHSn8LgvrA4l9vNeCoe+KgNRr9jS8TMWIRSC+Xhrs?=
 =?us-ascii?Q?z3bOEQQw3wG224NgIg4WTFHCl+FFMn8rG2FIC1xZmfdyip9A8jxI3N5ONJ9i?=
 =?us-ascii?Q?PJvGpu9LeOoUmXBilQLgKkCBe/Da/nKMvWRUcfBkEu3KpCrwtyoxbQlWAT6m?=
 =?us-ascii?Q?VOupbzo02HjIR7hiXWGLECpkj4AosVUiGUvPfT05eR/9sdIN4LzL3XLwtYLc?=
 =?us-ascii?Q?66pD3Q+7W7jXNNDIbxDGFaH5U1Jh/Mq93AG1QPvOZKhF3E+NVW7/Cs7AHTfP?=
 =?us-ascii?Q?qPDOFMqgPAOtfgSFezIU0RB56O9Z+r5rDF67iNbJNVGuDrtmaqM5HFxH+9yX?=
 =?us-ascii?Q?1EhJxfSmr0RjhL2aEv9EcJAEDM1Ny3MZ48Bn0dQvygQlpJ11cnSt4YjhODeq?=
 =?us-ascii?Q?pWFo7TaD98RGaMObit+PVOXvOW4NpWMLz6bOS1Lh3HbWFWE28PNQBAYpJri6?=
 =?us-ascii?Q?ITbKC+jPTmuu8LUvRu4CdpLD1XmhiMPxiMOMgH9+kpLt/V590C+rO++wi4RS?=
 =?us-ascii?Q?qitMeQMUr0VcvpPPWJk0zeU4DZHZ89gBydp8DQCm3VmM1HUdm7v+27n/5JbJ?=
 =?us-ascii?Q?WpbDl2FQYV4GzAr3E7l8bnQ+9Zui0SEBdtq9znTB0eTQwlNwzN0w4MrM6CrB?=
 =?us-ascii?Q?c8ayjZeUlf7hr/Bv6Xqyu1mWRUQ/ns3MXFO0h1dK6DZPdG46fUV2bqZr0Ze0?=
 =?us-ascii?Q?clT9Rx3eo+ORQ2u+jsu4i9plps35uNBneUQO+ap+asaRmbAUUvLh6ynT2BAr?=
 =?us-ascii?Q?Kt/juiZtvYRfnQ4WDeq4eoCIFPWDHMxB/dw0rFYp8/V+y5fmPHh1CFOH2Lgc?=
 =?us-ascii?Q?T+Va+Ac5eWkmaTLL+tRoaqh/nNI8Add+7ucCEDOEJv9CqjclLj1TGHh5MCr4?=
 =?us-ascii?Q?YEbwm0RHXYJkPAQqd7FdnPLO3Z1xfnNv9Sl8Xc7ymo+hKkZLJTDnaf+WtUvH?=
 =?us-ascii?Q?CUHxUIHFY2nGbAO4y0HoFP9aFRlYOkEHNzaifp8F5I9usBrNhIwyrGxr5D0T?=
 =?us-ascii?Q?HzUtjens7ejTrM2g34ElByUZC3idIqLPb/a+VKzy9Hd5MqzpkxdDr85jrfBm?=
 =?us-ascii?Q?d9Xc1PiZVH+DYU5jJi6tq5Ogv2XIY19GjqkU3rKS9hIWdzu0Rqm3UIFXUWeh?=
 =?us-ascii?Q?mKUaeKpKv+27A//GkLTiE2HmZkOXjcAXImu9oqcHGTYGexKpX4bh1I0Fxs5H?=
 =?us-ascii?Q?QU15p1dUS0Wh2pcc9ZTHbysfNBFjSk+SzpNuaRqxsNGnCvQrxXTy2xLalYSf?=
 =?us-ascii?Q?KlnjPGaS0Wx86cRSt58VOor6SeyjYsvPKE518MSSmZsI28fiKEq9IolZQ5ul?=
 =?us-ascii?Q?c9tl4L3Tnm+P5OEgvDl2zQO6RX24QOKlmJrJc6RrX/pMfKArlXbI5FoyW/Ze?=
 =?us-ascii?Q?sQYlVLxJ5i94iQiZXPOyZnYS/DMXrubqng0DMPSbY6F8K12WC7iD4CTKFKTC?=
 =?us-ascii?Q?F6UNJRt8T7xtHHCtboioM8XlI4872UZRkk0XU4p/vlwbL4AkeICzq5j75OcJ?=
 =?us-ascii?Q?03EUz+2aIR+ZikzbAmp2TApmfp947b71/8A39nfTbLqwm2gHKUGYKcwYGUhR?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff249ced-a53e-40b1-4a9c-08daa8507118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:41:07.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtKQqH7whzTl+HSZxpDIaAzNyOltxymeS5QLrP9SIVnut1sSIJ60MNxqmiJRlhy+NBrL1NGK93Q8psVdeij5MMmY+OPgsn0xSOSZL8eWOxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9595
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

