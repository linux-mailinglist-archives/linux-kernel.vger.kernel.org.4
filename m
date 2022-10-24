Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA660BEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJXXfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJXXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:35:35 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2117.outbound.protection.outlook.com [40.107.103.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACDA52FEF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNcdxiFOIt0Povaoaak7zyxcELlXfhCw9/LpZFCMzWVkTAPNJQmk0h5UGrr9iiXtMPPmzqWN4dIcFwzopPx7j9of16gLs/Du6dnsBqd2YSrG/JsczJvFGh6odUJEJNAsNDT6fIVv7o7vtAFUfTaypVP/UGzK1HQLFEZQ4Hdi7RuTMI+XIx6LcooPhhmowusAn63XX66A+NVboMsj+AZfYcq1BQMNfyOwMl4cIE65Z0rbOWsWsKHCaBj2rBCnSVEjaAyq0tUsXX8A2SGPkbUJu36kiCzBW65Dapi3sUDkh58ky1ojIcGRBE4CSgWogrULhEL72vkqmVzKvc32i/b6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM6TaTFx7ZXn9Les15qFXMYvL7lBgoT6avopwy0UsQM=;
 b=SNaE0ykWU8F053MvYZ/Tn3fejU+If318QHhk9A3s5J6rhYRrAnj1R07M9t0BFbDvB+Z3S652qrNV3abHEnPNafB278k6DHz+fu/WrbfgDMfz+pteCUXHUzF7W2RdeYPAmakN2EKOyCTdMUAdGsbeCEFMU6USqS3Z45MZttcl5yNUudOFJ4CDX/K8nIyRvLj7SjomcxYKKtDcghBe7yebmMpP5rl9piRcbMeVDZ4lwMsgdn+SuJwIKS6q662UT5pYg5VQQHX2YlP6AhERoY+AXXiCXmdDBr7ZVTt7fLYW6+O2dODz97d9NimnhGCOBXpSOWg6rEWa8gj8e7gOdPRwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM6TaTFx7ZXn9Les15qFXMYvL7lBgoT6avopwy0UsQM=;
 b=B9+9BMwKOFXCgCIuDwyoUl4I3U6fiMdJ7SuPyxIHqOO5wK4OONV6yl+SkgelCmRBwUWWRGC94U3Rrr0euY+WhnpKYi1/g3dVm59g4GJl4HFlHZj2SCU7tLBOQdlnfpYihRmTTqaPhXNlK5OFIPTQgM3XfEclPActkZZ9KLRN0cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB8P190MB0652.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:123::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 21:55:46 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 21:55:45 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aviram Dali <aviramd@marvell.com>
Subject: [PATCH] mtd: rawnand: marvell: add missing layouts
Date:   Tue, 25 Oct 2022 00:55:31 +0300
Message-Id: <20221024215531.32033-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DB8P190MB0652:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ae1d81-112a-413f-01d7-08dab60a80f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8yL//YlI3r9jKrnOFvhNTBcpAxbb58AWgCbkCh7Xv2wzY7/97oiI167HmsYWW0HWDRHn7XdDL64cGWwo4q842yy5sMqgbGVok6akU9zVAawKfWPTp5prazES0E7nH8LSmmnGtenkMwzmnm40gtRaMeDZZ2UvJbXrYA4+G7Sg1fwetAwie16qTqwJ9HHfoQ/3n+jHrLMlvLlmLyM3BbgwcC1kDThUsABChg2cHJBuaxQkkzXfszMLiEBHd9MuvUC4WqBlwMtYgDXl+jD15O7De5JLcByfnBtaGHDiQy9eOBAwpJcLmTN/hIVUQK4zp3SSAi5QminoLCEoH/cSondF56GfsXTETM9XX9MJyVdLjNfzEVje9kjj+rALnDxKeyUf6/6CIjY3UYDJ0cHDsWHs7VUmvMUVN8Lu6LRcFYU4OX0TnN56T2myu9GtMOFLtktlD6pDiwbCmnFFSbP0xI6DroYsE+8ZDHQowmNDXb3h+/iUCvaiXG/Du//oY4CRuiaZyOwdrK1h+1kfvKsfP9fYD7r4zmV6QSyuF8dh88PkO+l6oNGq9yvGJfzgIttZ31wwCxTNUzWOU+QV/oSgprKppQ/NHUB2C5tXb/h/+VrX135edtMwvt2MgAcSjvmcWd/Y3iqSE7P8WTxwkbjae1pnppXFWQmqzq0fGVwnaPbY8PRZVkI+OCHqQzb14OW7HOFoJYDtGDAvIWv9VaaolcpXj2aOPNQp3CpOC7Kyhs6BWwUFoe7VrRIQEOEUAUI93to
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(366004)(396003)(39840400004)(136003)(346002)(376002)(451199015)(36756003)(2906002)(44832011)(316002)(19627235002)(41300700001)(4326008)(66946007)(66556008)(66476007)(8676002)(5660300002)(508600001)(8936002)(54906003)(6486002)(110136005)(83380400001)(38100700002)(38350700002)(6666004)(52116002)(6506007)(86362001)(26005)(6512007)(186003)(1076003)(2616005)(41320700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2AEvoIzT98NNVySl9sT0zWOp0qYBeJK957YWU9oKhKUMSF54y13C8+HuS76?=
 =?us-ascii?Q?1JiPuDrf/I2xUajXmoE62vyf7lQ/iuEu/2PconRYIqwREJT0nQehBCJIdZwt?=
 =?us-ascii?Q?ROJW8TIrhyJcFrNTc/2w4qYgBcCsVS3w9N5EC8cTkup+nx52uf7u6cDS9zfm?=
 =?us-ascii?Q?AogIUTsstd7EDa6IGeZihsi7Lvi1U74QyNZJox2QxnBgIvG5GCCc3L+GayJW?=
 =?us-ascii?Q?ki5XkEfWZXabmlakw9GExeTpuy+ETiYK887ncfcvs4Ni2aa0fEcJcfPly8/f?=
 =?us-ascii?Q?FfEVH2HNfdun4wbUV1tQpzLzXE9qspAnun9Pwb2JuPMC/3Q8I7o2P+ICoCU9?=
 =?us-ascii?Q?TrjE6q3HbOIvMZpyfW6gVePPuZ0zwHfZ6kqzdv6bzRnGcwOxhYcjM6GmSKEN?=
 =?us-ascii?Q?l8KeRGybUQoEjYc5BfxjHh9bYgA7WhKzs4mhet8QY2YfcBPw5hduH4Vh/ZEg?=
 =?us-ascii?Q?Wsdazm07Pd1Czuyy6zCME8EfGCZap7DxY44STNOSkLpoGoct68vxrdFvTCeP?=
 =?us-ascii?Q?m4TEYZa1HJzJ7W6mc9BcfwS73axEmJEY5Ecl2KILu0T+3InYVbX89Zj4YZGG?=
 =?us-ascii?Q?Rb80uQc6cZdBdvTm9hxel8huKirwjZvLjMC+PlVpHsUajZxPVK4F66VVWFi2?=
 =?us-ascii?Q?87cbbG/ubibKnuHkmPQVW7B+PUYAvSY5E4QchQt7SN88HCitsAOkiHAzP9xm?=
 =?us-ascii?Q?huznm+bFUfhWc9FQ+5174nUFoCbgupEfokyTPHatOVKwdWtGGLZx2Rb7ofmH?=
 =?us-ascii?Q?4ItB6XJguZB+dCSTgOZGn10rw3K0iByBdFwgMoBYy37thbh36Hpv14wMcni6?=
 =?us-ascii?Q?H3mGW6fYoQJi0md6/Lbz2qePsbqZqtiaZnJHSWsmCjD8Fb+4RxIhdydrDRGu?=
 =?us-ascii?Q?0b8DL0FAOqOc5Cnk0C8qwjfXdo3KiXGdr2qmMV2D8t3hnKYJZWFiSKNzpffx?=
 =?us-ascii?Q?pwrj9MLuNpkXTgX+FBDmqgd70mpiCD2SJx4vuWgC8xIV1bwiWs+lI7IS4u9s?=
 =?us-ascii?Q?DEuORlQNxkai6XEp5LnHzeMm2XhHBA42nGbzKktGGs+bA4VCPYunEE/DJUUD?=
 =?us-ascii?Q?Tlz5e9fl5fbCJl8V9xCgbI11e95xaWbSE8JJtxWmS3TK6q3gB1RK/uFxboey?=
 =?us-ascii?Q?meNakwX5JJP2mn1woUllvD/sg9JWLAggqlHnM3hQWZ4IESB/tnQ0pTeFvo8f?=
 =?us-ascii?Q?NVS2fTiPPFCHphkUqeahrbWGEgYlxfb3BM+OyW8W8f71gv/tF2G5BpBS/4b1?=
 =?us-ascii?Q?MRKB1qUeJ8njv6wsuCIkC1UrnvuazrjBZC6e6Ti77yOcjq1j+1o+4246GEFY?=
 =?us-ascii?Q?B2Q6K/V973h6GPfdOdmMt6f1+fZQp9UUUp69lCtUvYl2+Qii9/TNRm2doRVP?=
 =?us-ascii?Q?cg3EXLLwW6L5tAOOouJXQ56fQRuHKQxyZjd/6B8oTdtr4f2WNp3BOUvkOmNY?=
 =?us-ascii?Q?qOf51hL/grRD10VxzonBmahFD8MBp4Vi6qx1pUISZpHkIbWPshwey7YnuXcH?=
 =?us-ascii?Q?S0fwJxgOszqxI8kIlqJpfAtLqHLWvcaPY8lKSVXu5FwnVukiFvfnVt6jqjxl?=
 =?us-ascii?Q?2194Z5HubTqCRuOVwYxv225xKBs0bgiSMOpajNyqmFqfP7fiOJ0RxbJcmTEK?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ae1d81-112a-413f-01d7-08dab60a80f6
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:55:45.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfLSd/bz1DTr91OU6ekkyWuFtwGbiVLN8ixwF4E2bEFripKNhuaxjQuaGtge9KqsyHqL8j6dlLGM/NDDI8rI0KbNFMlDgzMCiV8ZGPVqBHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0652
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

A missing layouts were added to the driver to support NAND flashes
with ECC layouts of 12 or 16 with page sized of 2048, 4096 or 8192.

Usually theses are rare layouts, but in Marvell AC5 driver, the ECC
level is set according to the spare area, so we may use these layouts
more frequently.

Signed-off-by: Aviram Dali <aviramd@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/mtd/nand/raw/marvell_nand.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index b9d1e96e3334..7944787f7b9f 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -283,14 +283,21 @@ struct marvell_hw_ecc_layout {
 
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
-- 
2.17.1

