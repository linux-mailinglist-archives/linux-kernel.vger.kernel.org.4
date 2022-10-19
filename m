Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF65603B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJSIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJSIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:22:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70093.outbound.protection.outlook.com [40.107.7.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DD7CB62;
        Wed, 19 Oct 2022 01:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvWuXyIPcmo0Mz82MnAiV/FaUoFWgSyC1dGXA5pU54r7B6GIjBS2nd5GiddoO0L5Mpd66RKCgAFUB3FT/vLewjrBWsCZ0SR4Q34LQiUaN5Vh1WFRo1Y7khatwGuMUkJUVXW4ChnAJux3YsdFA0tuejQcXb/EBwfFiab4JcdTqYaeSf7qYvV8ZdryMj0fGOcQZiXvqxilpttiAOiZd4pSou9C/GLFK2hHdMcIwV8F6uBWSycJ3myFpQ3p6ORCe/enCMguE8Z6Y6zlPqJZIXwjvLdAWr2RJ9UUVsuG85F5ixGKCfpWvpuK2Tt2Ffit3jur5pBEORZRrkR1VptOQ1zATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHsa9LuE7ltRU/sC4TdT4iLVg+ZxssgMeY349/Gh/m8=;
 b=WCUpZXJRggO+f4w1ENOKJ6wrk8pli2M0U8dT2k3p+xrquasLfSBMlc75/bifA8fUUSP9EOmYxO5cE1iCZgr2OkDBBYjhCndIRTsNnJpeXsIL6ujbs2IsAKnpPD0Hv1ZjRuQmA85Hp0ckHxPKnt9/tfxLqBRughkUusS4aWp9QOQQA4kM7Fqvhib+33p3cISTAfMUP/Gb/Fu2L2HE3kQ4smYi9d8V4AU1igYyP3ODtBLIof5GRKZteM9yr8YZySCIUqkEI4hTPekKK9HtXFfiZpHqvJAJW4JJLKxQ1ZUkY422BQaZ7Zkbfa4PqBzBl9gYjcAjGYOoSPKuvFi1Kdq40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHsa9LuE7ltRU/sC4TdT4iLVg+ZxssgMeY349/Gh/m8=;
 b=us5yPeqGcc4x9c729a++QCOJma51p9jhs7mUaAd1WX0K3wpm3sMlsn1OiGO0fHMbyej+ywuJlCAtDdg2/ShysQQ3m94WtQMcC/RAP6KRkOlfAIF4v74gf1eEux7MhqpOiCC2SzQp73615Y5am0QGGFewyFiMw0hLZZsmkKAouzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1930.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 08:21:51 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 08:21:51 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Liang Yang <liang.yang@amlogic.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aviram Dali <aviramd@marvell.com>
Subject: [PATCH 3/3] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Wed, 19 Oct 2022 11:20:40 +0300
Message-Id: <20221019082046.30160-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221019082046.30160-1-vadym.kochan@plvision.eu>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB1930:EE_
X-MS-Office365-Filtering-Correlation-Id: bf85b25f-4de7-42a4-0b37-08dab1aaf967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXtkD2AlqJIrm6EtQE9c/x/joT6YrzUvEQLc1MemUakrRop224kasJwkeUVbqcWT4+4HfaxZZX56t70MgFbLXH6XCFPTQu8QU/6EopJgc1aLcsOMv9hzb79T6WPKbxYEmdtd8U9zZ2ilDR1lmbnrZD3YDcwDlR+N6rOwmsdq9alhWxddSNdhgk4iFzmpKCb1vB1dyjDS8gc4dYN0UsXo6X1CfnEV83sm/853fcVH6N3qORfRLWGDOwi5T6yzmWSyW9KOOqoTBTiAgTNDx1Ki2qwOb5PFiLLMnMLAQ+0x7TR7U1BcH4Db0bMLRK5qsXCHL9J4q4ofqj2e7pf/KTBkwpWQ/sGpjP9EfNtiSv6uGOs/QD5lLJwawv9uwbtkyl3ad0yImRKN3fIr9cKnp9mzn6Phj13sWeQm5aT+jfU4N9SGuVhaUgVuhOCeyVZ7AZuga9+t1A45Aar7p0lqwWsele04WGQANzYUVXYTw05DcWq+ux3FwNZ6cby0E72zuFLik/0CTAYk5Ik/QzVYH2e3iTu36Qu+B3+Xm6lhqlHLfktTYUhgyyOgDtRLHA9rT5X0xBoiLaUHHqZjMtaMpfoME7FQvWpdyZjQBxZWKppwuKEgpjz+Vf+6ZTv2EkloQewRPtcgpvpROGOef6Y4tNrhZIdtYb3UliPUnRAFGp7weCNo70mfDufYtzyTY2Wsckm22kypSYAgxfK5Os4v1te674HvPQYTyXcdNV7DKfv2lYU+ThWoHlna+k0mMEvjPOfp08bEd9nG/uB4eSsV07nwQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39840400004)(34036004)(451199015)(186003)(2616005)(26005)(6512007)(6506007)(1076003)(52116002)(83380400001)(7416002)(2906002)(6666004)(5660300002)(30864003)(44832011)(41320700001)(19627235002)(41300700001)(110136005)(6486002)(316002)(508600001)(8936002)(66556008)(54906003)(4326008)(66476007)(66946007)(8676002)(36756003)(86362001)(921005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2YqFty/dm70TFmOLcLYgN54Sw/GiYgbj94mgH5+WKhcWqESk2FIKV/fgCQxD?=
 =?us-ascii?Q?Z0qktoMk4QigCqg8hyK8gfTQvw6ZqYp+bkDt4Szk16NQya86gzaNvVeyO25w?=
 =?us-ascii?Q?VDrxcBXiM5Hm248QE0pBZdvn4MZainB01/OEDwjpBCbByYmNwssQr1/WgGGb?=
 =?us-ascii?Q?gl3sOLZqRLKjiIGWvVoXxO+pvFdqqy7lrQ2yhTN0rNqgDUSY9XgmgDrw2ghp?=
 =?us-ascii?Q?XYDoS2rDbUODiqDvenKCwfZpKsZPgG5O8LxUK06QvPoUdAygPcJB0Zqw00zh?=
 =?us-ascii?Q?zP/ZGUyJZYsW52+M2IOeuTWuR2+jpZohWDjPFuA7MTd52gSfIyNwU985MffS?=
 =?us-ascii?Q?gpcijOSBdS2nZ6klUSqHrwo8CJSu2sD/2UqGKdJ+EaBtNSPdCniPR+ywIVZr?=
 =?us-ascii?Q?KXFnMPgGUqjt4xpjJ3c9j2lKLMYHR4wt0/2JLe36qxvsKNoDLlVcWI5M/CGS?=
 =?us-ascii?Q?6vqHLW0By9PCTiWkuHwyK+wUVMiI7+pSv7gFY1BT8KFZSpowcrrCfJjA+Jo3?=
 =?us-ascii?Q?SOCUVv+AKCxAy3dmM5EGt51r95G7YPRbnC6tlp0jNsKA+WPq0TkvtzHypXNc?=
 =?us-ascii?Q?ixXyuHVjuXIkvF/DrZTYexU0d0b97WhrF2y3sxwgV5EyDL+/4BZnMOM2QS7L?=
 =?us-ascii?Q?UThRfSvGaBsTyGd56z4c1eeXazgmjA6e1KB6lEJ/XeA+PnH4bXPH1dcyXo+D?=
 =?us-ascii?Q?SNIHe+0dTUJf5vJ9BQ7FIdXKg+cSA4xivbl29cdXPKDsnXLH+zPA6HzLThoe?=
 =?us-ascii?Q?aqYqk9A2PAeU7BQlrufkNlFf9FkDwzjShNGCY6Hr3BSF0mt4xbv5y6xVMK9j?=
 =?us-ascii?Q?b4ISs6nXJLOPxsoSJOHdqg6nzIXDlpDR3s51Z/yvxh9rhd/1pYjFo3/yQQsR?=
 =?us-ascii?Q?y+4UBfSp1cdmFKEMC6iGZZ157UuIdolW/Klhm0zibtmNtKyE74zQMoSGWjkI?=
 =?us-ascii?Q?JOB05fSNgvuulLGsrH72n92Wum19n7adeEKBc6xYONiBegxGMMYkk2hgloNm?=
 =?us-ascii?Q?/L7lsycZJWiuWRDRO7chgRvxmZ9RGt2jq82GkVCQGcgVISUw7PI/R5M5YmmS?=
 =?us-ascii?Q?IGpRKwiA3Hz54qEJ25ZhxF2IvLDQd9KXXKVuzF1MAbpw5Wt5gEKY/NBPOohN?=
 =?us-ascii?Q?kN2yxvnGcRK/DHPc54ILmrvZiiA+Owe7GAD3WRKfR55Du4KhlIfAuzDVCU1G?=
 =?us-ascii?Q?0h4uJ/efJMekim5rZEN0/M3X96zEtzdyV9hJwQYC0EJA+99aDYl6kWYUddg1?=
 =?us-ascii?Q?nn1GgoTlHMaec8Z4FGGpDzoKY0vTxTnkDcPLEYTwpU2wMhDA6drlIMBc6oGD?=
 =?us-ascii?Q?4d56SSBmtepVkElYnTT6Pd+pxS2A0zJUbHHo+YA5KXEekNNfKxaPLLU3fx0C?=
 =?us-ascii?Q?xvnt9poJtP8scmd8eseHxvh4wGZ6MBLvi141BJ/lqCXpFSKAZw5HKw47ta8r?=
 =?us-ascii?Q?+Q5pa8DPkwysZhGpFKmQ84tk+Hl1eyzAE4HLCvxNx43d1tWyzIFQ9mKhOISV?=
 =?us-ascii?Q?doth9PR9MlKztjS/PI9o3KF0eNZ0n5ugW07Dm69gO7NAjlVZji51OuRS9nUD?=
 =?us-ascii?Q?nOZpntkKo4IJr1PIzx1zSygvkjLJ0P/9dOxs3O6n9BSSLailI8UNj70SNO5M?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf85b25f-4de7-42a4-0b37-08dab1aaf967
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 08:21:51.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWioPlmoSUHnG+nySQyo1w6jtpYnhzPu5A0uIlBkBEQDBsNGWyMYReWu83eaXi2Cl2w5bm1mmegOCl9YYcEWCYHOIDBPg0DNMSaCUvpZXDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aviram Dali <aviramd@marvell.com>

The following changes were made to add AC5 support:

   1) Modify Marvell nand NFC timing set for mode 0

   2) fix validation in AC5 Nand driver for ONFI timings values modes 1 and 3

   3) remove unnecessary nand timing-mode in device tree of ac5.dtsi

   4) add nand missing AC5X layouts , add option to use ndtr predefined values

   5) Zero steps and total fields of ecc in ecc controller initialization so
      nand_scan_tail() will calculate these two fields, otherwise
      NAND initialization will fail with kernel 5.15 and above.

Signed-off-by: Aviram Dali <aviramd@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/mtd/nand/raw/Kconfig        |   2 +-
 drivers/mtd/nand/raw/marvell_nand.c | 277 ++++++++++++++++++++++++----
 2 files changed, 246 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 4cd40af362de..b7bb62f27e02 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -160,7 +160,7 @@ config MTD_NAND_MARVELL
 	  including:
 	  - PXA3xx processors (NFCv1)
 	  - 32-bit Armada platforms (XP, 37x, 38x, 39x) (NFCv2)
-	  - 64-bit Aramda platforms (7k, 8k) (NFCv2)
+	  - 64-bit Aramda platforms (7k, 8k, ac5) (NFCv2)
 
 config MTD_NAND_SLC_LPC32XX
 	tristate "NXP LPC32xx SLC NAND controller"
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index b9d1e96e3334..940a89115782 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -226,6 +226,20 @@
 #define XTYPE_COMMAND_DISPATCH	6
 #define XTYPE_MASK		7
 
+/* use tRP_min, tWC_min and tWP_min to distinct across timings modes */
+#define IS_TIMINGS_EQUAL(t1, t2) \
+		((t1->tRP_min == t2->tRP_min &&\
+		t1->tWC_min == t2->tWC_min &&\
+		t1->tWP_min == t2->tWP_min) ? true : false)
+
+/*  ndtr0,1 set , each set has few modes level */
+typedef enum marvell_nfc_timing_mode_set {
+	MARVELL_NFC_NDTR_SET_0,		/* tested with ac5 */
+
+	MARVELL_NFC_NDTR_NUM_OF_SET,
+	MARVELL_NFC_NDTR_SET_NON = MARVELL_NFC_NDTR_NUM_OF_SET
+} marvell_nfc_timing_mode_set_t;
+
 /**
  * struct marvell_hw_ecc_layout - layout of Marvell ECC
  *
@@ -283,14 +297,21 @@ struct marvell_hw_ecc_layout {
 
 /* Layouts explained in AN-379_Marvell_SoC_NFC_ECC */
 static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
-	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
-	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
-	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
-	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT(512,   512,  1,  1,  1,  512,  8,  8,  0,   0,  0),
+	MARVELL_LAYOUT(2048,   512,  1,  1,  1, 2048, 40, 24,  0,   0,  0),
+	MARVELL_LAYOUT(2048,   512,  4,  1,  1, 2048, 32, 30,  0,   0,  0),
+	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30,  1024, 32, 30),
+	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30,  1024, 64, 30),
+	MARVELL_LAYOUT(2048,   512,  12, 3,  2, 704,   0, 30,  640, 0,  30),
+	MARVELL_LAYOUT(2048,   512,  16, 5,  4, 512,   0, 30,  0,   32, 30),
+	MARVELL_LAYOUT(4096,   512,  4,  2,  2, 2048, 32, 30,  0,   0,  0),
+	MARVELL_LAYOUT(4096,   512,  8,  5,  4, 1024,  0, 30,  0,   64, 30),
+	MARVELL_LAYOUT(4096,   512,  12, 6,  5, 704,   0, 30,  576, 32, 30),
+	MARVELL_LAYOUT(4096,   512,  16, 9,  8, 512,   0, 30,  0,   32, 30),
+	MARVELL_LAYOUT(8192,   512,  4,  4,  4, 2048,  0, 30,  0,   0,  0),
+	MARVELL_LAYOUT(8192,   512,  8,  9,  8, 1024,  0, 30,  0,  160, 30),
+	MARVELL_LAYOUT(8192,   512,  12, 12, 11, 704,  0, 30,  448, 64, 30),
+	MARVELL_LAYOUT(8192,   512,  16, 17, 16, 512,  0, 30,  0,   32, 30),
 };
 
 /**
@@ -328,6 +349,7 @@ struct marvell_nand_chip_sel {
  * @selected_die:	Current active CS
  * @nsels:		Number of CS lines required by the NAND chip
  * @sels:		Array of CS lines descriptions
+ * @nand_timing_mode:	nand-timing-mode from dts
  */
 struct marvell_nand_chip {
 	struct nand_chip chip;
@@ -339,6 +361,7 @@ struct marvell_nand_chip {
 	int addr_cyc;
 	int selected_die;
 	unsigned int nsels;
+	int nand_timing_mode;
 	struct marvell_nand_chip_sel sels[];
 };
 
@@ -367,6 +390,10 @@ static inline struct marvell_nand_chip_sel *to_nand_sel(struct marvell_nand_chip
  *			BCH error detection and correction algorithm,
  *			NDCB3 register has been added
  * @use_dma:		Use dma for data transfers
+ * @is_marvell_timing_modes: use marvell predefined register values per mode
+ * @max_mode_number: supported mode by NFC (max mode that supported)
+ * @timing_mode_set: which set to use from predefined array of sets
+					 each set has few modes
  */
 struct marvell_nfc_caps {
 	unsigned int max_cs_nb;
@@ -375,6 +402,9 @@ struct marvell_nfc_caps {
 	bool legacy_of_bindings;
 	bool is_nfcv2;
 	bool use_dma;
+	bool is_marvell_timing_modes;
+	unsigned int max_mode_number;
+	marvell_nfc_timing_mode_set_t timing_mode_set;
 };
 
 /**
@@ -485,6 +515,118 @@ struct marvell_nfc_op {
 	const struct nand_op_instr *data_instr;
 };
 
+/* NFC ndtr0 */
+typedef union  marvell_nand_ndtr0 {
+	struct {
+		unsigned  int tRP                 :3;  /* 0-2   */
+		unsigned  int tRH                 :3;  /* 3-5   */
+		unsigned  int tRPE                :1;  /* 6     */
+		unsigned  int tRE_edge            :1;  /* 7     */
+		unsigned  int tWP                 :3;  /* 8-10  */
+		unsigned  int tWH                 :3;  /* 11-13 */
+		unsigned  int reserved            :2;  /* 14-15 */
+		unsigned  int tCS                 :3;  /* 16-18 */
+		unsigned  int tCH                 :3;  /* 19-21 */
+		unsigned  int Rd_Cnt_Del          :4;  /* 22-25 */
+		unsigned  int selCnrl             :1;  /* 26    */
+		unsigned  int tADL                :5;  /* 27-31 */
+	} fields;
+	unsigned  int  regValue;
+} marvell_nfc_ndtr0_t;
+
+/* NFC ndtr1 */
+typedef union  marvell_nand_ndtr1 {
+	struct {
+		unsigned  int tAR                 :4;  /* 0-3   */
+		unsigned  int tWHR                :4;  /* 4-7   */
+		unsigned  int tRHW                :2;  /* 8-9   */
+		unsigned  int reserved            :4;  /* 10-13 */
+		unsigned  int Prescale            :1;  /* 14    */
+		unsigned  int wait_mode           :1;  /* 15    */
+		unsigned  int tR                  :16; /* 16-31 */
+	} fields;
+	unsigned  int  regValue;
+} marvell_nfc_ndtr1_t;
+
+#define NUM_OF_TIMING_MODES	6
+
+/* arrays of NFC timings modes */
+typedef marvell_nfc_ndtr0_t marvell_nfc_ndtr0_arr[NUM_OF_TIMING_MODES];
+typedef marvell_nfc_ndtr1_t marvell_nfc_ndtr1_arr[NUM_OF_TIMING_MODES];
+
+#define MARVELL_NTDR0(trp, trh, trpe, tre_edge, twp, twh, resrv, tcs, tch, rd_cnt_del, selcnrl, tadl)	\
+		{\
+			.fields = {\
+				.tRP = trp,                 /* 0-2   */\
+				.tRH = trh,                 /* 3-5   */\
+				.tRPE = trpe,               /* 6     */\
+				.tRE_edge = tre_edge,       /* 7     */\
+				.tWP = twp,                 /* 8-10  */\
+				.tWH = twh,                 /* 11-13 */\
+				.reserved = resrv,          /* 14-15 */\
+				.tCS = tcs,                 /* 16-18 */\
+				.tCH = tch,                 /* 19-21 */\
+				.Rd_Cnt_Del = rd_cnt_del,   /* 22-25 */\
+				.selCnrl = selcnrl,         /* 26    */\
+				.tADL = tadl,               /* 27-31 */\
+			} \
+		}
+
+#define MARVELL_NTDR1(tar, twhr, trhw, resrv, prescale, waiting_mode, tr)	\
+		{\
+			.fields = {\
+				.tAR = tar,                 /* 0-3   */\
+				.tWHR = twhr,               /* 4-7   */\
+				.tRHW = trhw,               /* 8-9   */\
+				.reserved = resrv,          /* 10-13 */\
+				.Prescale = prescale,       /* 14    */\
+				.wait_mode = waiting_mode,  /* 15    */\
+				.tR = tr,                   /* 16-31 */\
+			} \
+		}
+
+/* ndtr0_modes and ndtr1_modes are arrays of modes with optimal values
+ * that were tested with Marvell NFC with correlation to ONFI timings mode
+ * each entry in the array presents different set of modes , for example ac5
+ * is entry 0.
+ */
+/* todo: add more modes ASAP */
+
+/* Layouts explained in AN-379_Marvell_SoC_NFC_ECC */
+marvell_nfc_ndtr0_arr ndtr0_modes[MARVELL_NFC_NDTR_NUM_OF_SET] = {
+
+	/* value tested with AC5 */
+	{
+		MARVELL_NTDR0(7, 7, 1, 1, 7, 7, 0, 7, 7, 12, 1, 31),
+		MARVELL_NTDR0(6, 3, 0, 0, 5, 4, 0, 7, 7, 1, 1, 15),
+		MARVELL_NTDR0(4, 3, 0, 0, 3, 3, 0, 7, 7, 2, 1, 15),
+		MARVELL_NTDR0(3, 2, 0, 0, 3, 2, 0, 1, 0, 2, 1, 15)
+	}
+};
+
+marvell_nfc_ndtr1_arr ndtr1_modes[MARVELL_NFC_NDTR_NUM_OF_SET] = {
+
+	/* value tested with AC5 */
+	{
+		MARVELL_NTDR1(15, 15, 3, 0, 0, 1, 50),
+		MARVELL_NTDR1(15, 15, 3, 0, 0, 1, 25),
+		MARVELL_NTDR1(15, 15, 3, 0, 0, 1, 25),
+		MARVELL_NTDR1(11, 11, 2, 0, 0, 1, 25)
+	}
+};
+
+/*
+ * get nand timing-mode from device tree
+ */
+static int get_nand_timing_mode(struct device_node *np)
+{
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(np, "nand-timing-mode", &val);
+	return ret ? ret : val;
+}
+
 /*
  * Internal helper to conditionnally apply a delay (from the above structure,
  * most of the time).
@@ -2257,9 +2399,21 @@ static int marvell_nand_hw_ecc_controller_init(struct mtd_info *mtd,
 	}
 
 	mtd_set_ooblayout(mtd, &marvell_nand_ooblayout_ops);
-	ecc->steps = l->nchunks;
 	ecc->size = l->data_bytes;
 
+	/* nand_scan_tail func perform  validity tests for ECC strength, and it
+	 * assumes that all chunks are with same size. in our case when ecc is 12
+	 * the chunk size is 704 but the last chunk is with different size so
+	 * we cheat it nand_scan_tail validity tests by set info->ecc_size value to
+	 * 512.
+	 */
+	if (ecc->strength == 12)
+		ecc->size = 512;
+
+	/* let nand_scan_tail() calculate these two fields */
+	ecc->steps = 0;
+	ecc->total = 0;
+
 	if (ecc->strength == 1) {
 		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
 		ecc->read_page_raw = marvell_nfc_hw_ecc_hmg_read_page_raw;
@@ -2360,9 +2514,11 @@ static int marvell_nfc_setup_interface(struct nand_chip *chip, int chipnr,
 	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
 	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
 	unsigned int period_ns = 1000000000 / clk_get_rate(nfc->core_clk) * 2;
-	const struct nand_sdr_timings *sdr;
+	const struct nand_sdr_timings *sdr, *timings;
 	struct marvell_nfc_timings nfc_tmg;
 	int read_delay;
+	marvell_nfc_timing_mode_set_t modes_set;
+	int mode = 0;
 
 	sdr = nand_get_sdr_timings(conf);
 	if (IS_ERR(sdr))
@@ -2421,32 +2577,71 @@ static int marvell_nfc_setup_interface(struct nand_chip *chip, int chipnr,
 			nfc_tmg.tR = 0;
 	}
 
-	if (chipnr < 0)
-		return 0;
 
-	marvell_nand->ndtr0 =
-		NDTR0_TRP(nfc_tmg.tRP) |
-		NDTR0_TRH(nfc_tmg.tRH) |
-		NDTR0_ETRP(nfc_tmg.tRP) |
-		NDTR0_TWP(nfc_tmg.tWP) |
-		NDTR0_TWH(nfc_tmg.tWH) |
-		NDTR0_TCS(nfc_tmg.tCS) |
-		NDTR0_TCH(nfc_tmg.tCH);
+	/* get the timing modes from predefined values according to its compatibility */
+	if (nfc->caps->is_marvell_timing_modes) {
+		/* get the mode set */
+		modes_set = nfc->caps->timing_mode_set;
+		if (modes_set >= MARVELL_NFC_NDTR_SET_NON) {
+			dev_warn(nfc->dev,
+				"Warning: not supported timing registers set,use set number 0 by default\n");
 
-	marvell_nand->ndtr1 =
-		NDTR1_TAR(nfc_tmg.tAR) |
-		NDTR1_TWHR(nfc_tmg.tWHR) |
-		NDTR1_TR(nfc_tmg.tR);
+			modes_set = MARVELL_NFC_NDTR_SET_0;
+		}
 
-	if (nfc->caps->is_nfcv2) {
-		marvell_nand->ndtr0 |=
-			NDTR0_RD_CNT_DEL(read_delay) |
-			NDTR0_SELCNTR |
-			NDTR0_TADL(nfc_tmg.tADL);
+		/* find the caller mode according to timings values */
+		/* if exit on error it means no more modes; not suppose to happen */
+		do {
+			timings = onfi_async_timing_mode_to_sdr_timings(mode);
+			if (IS_TIMINGS_EQUAL(timings, sdr))
+				break;
+			mode++;
+		} while (!IS_ERR(timings));
+
+		/* if mode is not supported by NFC, return false or if nand-timing-mode that
+		 * exists in device tree greater then caller mode also return false and wait
+		 * for caller to try with next mode (mode-1). we want the nand feature to be
+		 * configured with nand-timing-mode value.
+		 */
+		if (mode > nfc->caps->max_mode_number ||
+			 ((marvell_nand->nand_timing_mode) >= 0 &&
+			 (mode > marvell_nand->nand_timing_mode)))
+			return -EOPNOTSUPP;
+
+		/* just checking NFC capabilities no need to set the registers */
+		if (chipnr < 0)
+			return 0;
 
-		marvell_nand->ndtr1 |=
-			NDTR1_TRHW(nfc_tmg.tRHW) |
-			NDTR1_WAIT_MODE;
+		marvell_nand->ndtr0 = ndtr0_modes[modes_set][mode].regValue;
+		marvell_nand->ndtr1 = ndtr1_modes[modes_set][mode].regValue;
+	} else {
+		if (chipnr < 0)
+			return 0;
+
+		marvell_nand->ndtr0 =
+			NDTR0_TRP(nfc_tmg.tRP) |
+			NDTR0_TRH(nfc_tmg.tRH) |
+			NDTR0_ETRP(nfc_tmg.tRP) |
+			NDTR0_TWP(nfc_tmg.tWP) |
+			NDTR0_TWH(nfc_tmg.tWH) |
+			NDTR0_TCS(nfc_tmg.tCS) |
+			NDTR0_TCH(nfc_tmg.tCH);
+
+		marvell_nand->ndtr1 =
+			NDTR1_TAR(nfc_tmg.tAR) |
+			NDTR1_TWHR(nfc_tmg.tWHR) |
+			NDTR1_TR(nfc_tmg.tR);
+
+		if (nfc->caps->is_nfcv2) {
+			marvell_nand->ndtr0 |=
+				NDTR0_RD_CNT_DEL(read_delay) |
+				NDTR0_SELCNTR |
+				NDTR0_TADL(nfc_tmg.tADL);
+
+			marvell_nand->ndtr1 |=
+				NDTR1_TRHW(nfc_tmg.tRHW) |
+				NDTR1_WAIT_MODE;
+		}
 	}
 
 	return 0;
@@ -2568,6 +2763,7 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 	struct nand_chip *chip;
 	int nsels, ret, i;
 	u32 cs, rb;
+	struct device_node *dn;
 
 	/*
 	 * The legacy "num-cs" property indicates the number of CS on the only
@@ -2681,6 +2877,10 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 	if (of_property_read_bool(np, "marvell,nand-keep-config"))
 		chip->options |= NAND_KEEP_TIMINGS;
 
+	/* read the mode from device tree */
+	dn = nand_get_flash_node(chip);
+	marvell_nand->nand_timing_mode = get_nand_timing_mode(dn);
+
 	mtd = nand_to_mtd(chip);
 	mtd->dev.parent = dev;
 
@@ -3064,6 +3264,15 @@ static const struct marvell_nfc_caps marvell_armada_8k_nfc_caps = {
 	.is_nfcv2 = true,
 };
 
+static const struct marvell_nfc_caps marvell_ac5_caps = {
+	.max_cs_nb = 2,
+	.max_rb_nb = 1,
+	.is_nfcv2 = true,
+	.is_marvell_timing_modes = true,
+	.max_mode_number = 3,
+	.timing_mode_set = MARVELL_NFC_NDTR_SET_0,
+};
+
 static const struct marvell_nfc_caps marvell_armada370_nfc_caps = {
 	.max_cs_nb = 4,
 	.max_rb_nb = 2,
@@ -3112,6 +3321,10 @@ static const struct of_device_id marvell_nfc_of_ids[] = {
 		.compatible = "marvell,armada-8k-nand-controller",
 		.data = &marvell_armada_8k_nfc_caps,
 	},
+	{
+		.compatible = "marvell,ac5-nand-controller",
+		.data = &marvell_ac5_caps,
+	},
 	{
 		.compatible = "marvell,armada370-nand-controller",
 		.data = &marvell_armada370_nfc_caps,
-- 
2.17.1

