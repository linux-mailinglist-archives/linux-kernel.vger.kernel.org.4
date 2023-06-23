Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882E773BBB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFWPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjFWPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:34:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2054.outbound.protection.outlook.com [40.92.75.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806EE2685;
        Fri, 23 Jun 2023 08:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMkU+00QuFkA6O00Z1pBulEBW4fFzZmYBnu8ej3VXtTvsZBTG71WH4/3AXRF20L/7rK7JvGMQidetVbDg7I8LipUcgVRyG2jGgziaKaWv/AOlQn/Y821esbFmha460AdKpCnTnhAjzaCK5cuZojKf8uzH7vCcO4LtD8Mi6J0vEogF7c2xjzh9uGSlRvsnbw/uEw0cbE87mxjQ+KmZBubyRckkdj67X27WitNUIciRnV0sSv9MW3hVmKgEtpJBWPPL6ZR3Z/zQ103d+gJIvPGAWSLX5m89mUcSLln7mwiVkGfPgodtzXGRirWk6STFjOpXfPQnkAcDZqHYgblYiVC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykEQ/VfQXM1yjfbUj/w4I3uHAwlVs0OdG4VE3j08iT0=;
 b=WsWsacGgDGlar8E7e3NZ5vETpDEjtv0cV+E6LrkAwDFz7ve2oBCdZTK16et/apM3zI3holngSqu7Atomr3uCWSBhblLi1rbrVgF1fjSqTd+OqLstYN5tE9rGMygXTJmPlBg0mjudcNHRifa9X1RSTUfU6cffihG/y5M7TGkARJ1ICyqvPsdTeRAgT5b+YJxDbePynNh3hl6wn5gRn62qf0hrJ0g8V2NVgacbXGFK2M0L7CwzA76WVsiNexcSTq9CJD16Fii8p1dAVm/vUpa+BKnWt9Dn1CUykPZUnkf4AwPNvevJA01Lza7eGfcVBXirh7jhm2DPrWrE2tJSaJu72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB4P250MB1032.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:3cc::7) by
 AM8P250MB0042.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:3d9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 23 Jun 2023 15:34:00 +0000
Received: from DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 ([fe80::1f3e:9e10:27b2:5ae4]) by DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 ([fe80::1f3e:9e10:27b2:5ae4%2]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 15:34:00 +0000
From:   Olivier Maignial <olivier.maignial@hotmail.fr>
Cc:     Olivier Maignial <olivier.maignial@hotmail.fr>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [v2, 1/2] mtd: spinand: toshiba: Fix ecc_get_status
Date:   Fri, 23 Jun 2023 17:33:36 +0200
Message-ID: <DB4P250MB1032553D05FBE36DEE0D311EFE23A@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [ZlZu7uX6XhMphMQK0xfQEX+v3hmWL+k2]
X-ClientProxiedBy: PR0P264CA0249.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::21)
 To DB4P250MB1032.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:3cc::7)
X-Microsoft-Original-Message-ID: <20230623153337.3818369-1-olivier.maignial@hotmail.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4P250MB1032:EE_|AM8P250MB0042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7812bb74-50a9-431a-825d-08db73ff43da
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3qXcYLnbyrqKtqrVM43XjewP5Mt+qMANFrOaoioyzYvwNlPu4Ae4c8pBQeJkGK4uYJsHOoRrd4elmpXKlH8VjbkAhLCuJI+1JkCOl4gCq8X+tw96X0rJwVz30AZNO0ddnlILkMR3vLOmBWoOV/MDSQyX8EQ/1QunOnDNVNI2GeiGH2hcj/PBbzgwFp/p+jYMhpnjqaZMMxZ3HoXf6QRDu2CJYkxMj7SajcPd/05R0vp1R6qcKrMfO91Q2Ms3zT+4ozh9NraDjEUJ+JruGeOItyJlkU940/vnA5n+zKuj4QsVrgUVfyi9Ud9U4mth0O0YdAspArT8kGN4CwRPXnAMT9SQgmnF+XdlkL0ok9h95yv1n3URYjZVTYDfRFwyXKaqNOio26EEU8FzFz3WQ8u2o8jUrA8RNWjJyxWS3SXxeWqnigAkXEXAWvfwukSFL3e4+Siwxc4SG9ZfltjOBhRzkwZQ7cY4rw39BeFPO0cicuLv+EpM1yiExWirbO1DD+8Fz46xI1F8lBKKr2st9ldkn7viy0iyZv7OWUUBVaMvtjUmh55OHLvrtdqYSMHl4+QJkwSCYYGdi3Jx39SemxyJPA3IH7I9M1IBL1GvT8uf6wlZk68MOhUu8JwHwSmpqIU4hJ0+JZXT0fhP3oyAtdUvxZu/gGBPWGM/4UVwoPg04PKwjNAL2iTsECT7FAVU0gWiV9VSmdxjs0ZVNLHmdkp479RLtQ8KvwESJaPoeE/SlHu9JeDj3VpgFlIYW9yDe+RtFvn6yRfRdFP4faCAsE8Ppuj+LQCZ1cn5xG5AwXEfmsxXp3hRdW8rOIw
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgesvwcWzjQsrlX/3+iTwQkw+8W2y5HlmYEgo739s2sL9qLkqMagk25RfN4z5kHXha+7dcazAzocO/Se2mSVdjcg5VUjAolvSruRd3DZuWOLTeLV4LNGJZb2hreVK4YUVUex0Yy3TGETEqeH7IxrPNRHiBk60VeAWPWhjGUCojaWJzqzuRYINF+sPy5qnSqeVs8s4UZD535hqJT4AmRVKTJb1hCP/biAt14oCNuma9Nf5wbLTl+nrpqvDFmros5bvtaL/KcncRSnORZwiBtfw747f8cLWdYZLiYhzpbqUxRjpqRtwEqXHryml81jp2Qt7zCtXfU0UvUBgy7onftYmSjH1ygScQYX6aHqiB3BnSHxpbf3k8wZ9XHaKiQ2I1ytArzJVCqleftMpg6hRj2JCFkJUrMBeOml+WMcyhOul+3SWWO4VV6ayxGlcNLmQWzaI1lm69aknvQl0pV1CuE5K8QiouBFajIpJt1wABaVQUQm2yJYooPhTo2C6zLrKo9myfohMA74IXLAqS2NtKFQrmikGh7iSPDUS5NG5xPg3+dsPgbjnKp07RoZ9VTd8fpLAk0VPoCZwI+6c08UmHzHUjXvvJzvkwWsz3L9Wow/p2rp6HNBpgpwu+x0N+B854cUN4K0eGCVFU4fQhFrhz4qnQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6k6bBLEK+u+lZUAneU+qqqD/OEXUKbOp2XKBAi9AMAW/iIBf0/tM1wB+e/Ao?=
 =?us-ascii?Q?py/Kmjh90hIOdkn3OI3Qc82KbOooOG9JVzbyW8x/WNyHH1DhS4KMHqWq6krv?=
 =?us-ascii?Q?2SB1U/tFOuPCtSeOiV9G451q2Ub6Y0aScSP7EuCBqu8AqfUhKJVxnA6oXbua?=
 =?us-ascii?Q?vu9NtrFWfAbGIQ+yK7dC4PTeTYvOsjqbOTRRQ9HEb5u8c+354SHzKIg1Bv5Z?=
 =?us-ascii?Q?2YfIVMTFrqHPkDQGrx8SeOchTzNv8ZoayJBnMtHlG0yk9SooXAsUOQC5uqAj?=
 =?us-ascii?Q?Z3thrdU7Gv4IcZ+iuAofVPA6ISr+13i0QWnOLI8FVyJYLxiKKbBjiBwui7dh?=
 =?us-ascii?Q?TAzJrqkKwOUHZkLCvZqSrSQkctiKTfYiKIOHmwkXIIF8Xg5wbSeJQoqvYL5p?=
 =?us-ascii?Q?fCdacA1kiCbDD6arBzRlnuiKT7ZLhqMTkwvYEeuircuFa5AdQuyFfl9npmJG?=
 =?us-ascii?Q?bfO1prU7AB/f2ur+l5P7hA8np1p8Yrpw3URXIuEBFek06JRbmi8B3PSnXRgS?=
 =?us-ascii?Q?pT7yYji6qlRSwJQIztYeShE4KZhbuBr8Kx6TKQ/hp6628YydY+gPD6khd6Fu?=
 =?us-ascii?Q?P6pKaJeDW2YZ1PTda4xJwr4pg23d3VnnE7GLeN8HmgOwjrutvxBEukR2bX4W?=
 =?us-ascii?Q?YKlczay93TFg+GnRUu1kArIEf9akBcvVSos7re0JPCkoJxJbD/xu3+7i+bpn?=
 =?us-ascii?Q?FFOtiB3s+3E3Ri+FygW1KBZV/b9M5ZmgNDz1f8dAPsus9TOka/u3t6RUC9r6?=
 =?us-ascii?Q?0fCw5vgNA9cZv7Sjhl9t5h/RmF6wN9zmYmQcJrw+HHJBv+keEKk8zEZUwhEN?=
 =?us-ascii?Q?5O0M9neb1I3COzb7lzHAoCBXG69hfJcQ4nSvFaRQ4K6lhfcFIAuxsr+FsjAz?=
 =?us-ascii?Q?QXiifz3Tl17X1tkcVr/FUMRNvtvB+AgiLSR0+gKn38dz8PPobsQIWS5Hv4Un?=
 =?us-ascii?Q?4eiMlSmVA0R7Fq7uGqSP1XbAn3790ieG/L3r1kozLuayVSOK7NdZSLUsc9cW?=
 =?us-ascii?Q?vCOJeaJsMwKfZprMiKNHcCLUNm7sUcz+g5gkblXXNIR0DKaYz9nuW7qz1Z+d?=
 =?us-ascii?Q?bs6FhtvDt+v0KAoZEJD0YxEzrvurCFO/qVBLszFtp1H12ktj7orxGogC5jjZ?=
 =?us-ascii?Q?70wN3oQYZwfC4NmdmGSITKquymnvs9FlWD7vxbqTAM87PTF8NjiJl/ESvKlO?=
 =?us-ascii?Q?oK0FOQvsnLcWPprh3175JVEuGaSCHUX0Ruw6H3GGBMTxTlVjJEBGodEZZts?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7812bb74-50a9-431a-825d-08db73ff43da
X-MS-Exchange-CrossTenant-AuthSource: DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 15:34:00.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0042
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading ECC status is failing.

tx58cxgxsxraix_ecc_get_status() is using on-stack buffer
for SPINAND_GET_FEATURE_OP() output. It is not suitable
for DMA needs of spi-mem.

Fix this by using the spi-mem operations dedicated buffer
spinand->scratchbuf.

See
spinand->scratchbuf:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mtd/spinand.h?h=v6.3#n418
spi_mem_check_op():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-mem.c?h=v6.3#n199

Fixes: 10949af1681d ("mtd: spinand: Add initial support for Toshiba TC58CVG2S0H")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>
---
 drivers/mtd/nand/spi/toshiba.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 7380b1ebaccd..a80427c13121 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -73,7 +73,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -92,7 +92,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		if (spi_mem_exec_op(spinand->spimem, &op))
 			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
 		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
 			return nanddev_get_ecc_conf(nand)->strength;
-- 
2.34.1

