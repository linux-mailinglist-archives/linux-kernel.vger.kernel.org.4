Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B07507E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGLMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjGLMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:14:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434BD19A6;
        Wed, 12 Jul 2023 05:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAB5XOLeh9TDxB0usroQQMemOtWQt3Jt9vgPfoxpMb8eYgPqW7C7kgz7Wya/O0Ugqb+nbMlq3GULTJ12mtL5x4x0ayIfRlXa+DD891w9cl2udlaZkfIylqSO2CwcZcgyoM8le/TG6aGx5z7DlKGwpBsNT+uOkz3QzxxPqR/H8oMKlC4TAXtGYbXVKLd1zwjDphXma3/mksbbVmemU5hCsKo7W4mzoqCCwNb9HS2L6O5xvg0+AmpLH0CRQaxrUEjPu/fWw/eNWFxMarhHcmHFNW89/sEuHJVrwSweJllufLMoxJV8Cha9B1Kctwni6sVDmNN8oekxGHtj0BZLGrywpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeL0Qexxw6ojyZCrgjl1e/l4TON6jlduREtJC7RhjaI=;
 b=W6qSkFXxHfsMoCaSkwX2YBuKmpDjy/eBD01RdfVo51RmRzbKONqrtN18iq0mPPKmG3/LPiJi8LvcQMhpVOgHCE+9WRBxTIMrxDrvb/ZjL0IA29XoTDzl03zWNJmiZDymsrluLTstXINz9M0YngPwKF+w+Cu3u14WFuVXVCNTpz4SevsQ1zIeHW2fxHmzs58XPCHwDFflKOsJwss6fEt6fPZE+D2TPDAtQSXRzWgBNh3ze699vIf4FXXKvhTTPtkh7iAU8csCSGKLtXWsHOKYsz21QJ4py8ZSXzMOcpogxEgO2mp4v4dD2320LB3wHGpRuAYgROd980pjQBxdqhoF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeL0Qexxw6ojyZCrgjl1e/l4TON6jlduREtJC7RhjaI=;
 b=WNA28PrhSzyefJAv/nNSiJL7FA1KAs12Vu7mGp1mIh8XOSITfmQwZp84Bn/3xC6kwp0L4iD10wGUzxEsmCma5LANXZ7EqiJf0wJKyH5NT6ye2jwhgRHX6+vqArUqyolYy34SB+z1ytQkmT7F5GcjKW1XCR+VqFNBkax7vEetRIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:13:46 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:13:46 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 7/7] MAINTAINERS: Added maintainer details
Date:   Wed, 12 Jul 2023 17:42:19 +0530
Message-Id: <20230712121219.2654234-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcf32e9-07e4-4633-73fe-08db82d17149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcpkrAwDg5z9rBgPy8m1NQy4iUDG3X0OT1hjWryJaOyPP1Hu6att/DrvKx4u5SsTpp8igbJj4OJZYrzkD4OTFGcjW+k4/CjKFyOUenq5ToQOOQcXx/qPZ3jAwuyaMevo86oo3kY/++HMOChumEUc/bANJIgKrnVzacPeoABxXBkTlRi/Vc6xRJKXtU2mFgqbEPvHVLjiTGgltcOanFjRNn0R2Of118BqcutcDatfb4gxRo2LqeKPGVdD0uWYNraSbt8V1p2GlLJsMlY2UNtxDCkAIXwDNGd8r++YbIcZIBhj8ywt94SCEI7gto+oObo3UuTZr9XO14j3d1YX2tkSRxOF3rM+KLHP6GqrJ8gTcbmuT+JzBNIoqrUEGsddbscJkRDQzygz6bKxvJEkR+45Vf1pvQMEGoVfC9n9KEGjv62zzEfA1JkVaDdtQ5jWBZ+4R6W65Ys/CzYYzaj4sFB3vRsPJIYyKtHYMf+YaD4OYWPZgQ5VEVwU9+KMFyKz6SJFTe00E2hdXNxrCFugXD5R0Sbs1uJw5y6hah0WLO3bzBjk+Ji+J6bHCRTvNCIi1X9OU3D8ypZ50MNKmwLDW/Ob9JpugMQTz8FpnflNwxo9Pyhcu2K7cCXrLKNGovRS34rkABbW5gugralTp/KzzAxgGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(7416002)(44832011)(6636002)(4326008)(66556008)(66476007)(66946007)(41300700001)(316002)(4744005)(2906002)(478600001)(8676002)(8936002)(5660300002)(6666004)(6486002)(52116002)(6512007)(6506007)(1076003)(26005)(186003)(36756003)(83380400001)(38100700002)(921005)(38350700002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMrcmNcW7evrOGJjBzCEVb1bqmWThjAZYx7iju5jiHKbqGvtVeZRLdSrOYod?=
 =?us-ascii?Q?eToy4Uvu1BVmk7lxOOPQvwKji0qCcNp4Y2Nj9JuI7XnQ4JL6lybePQaj4IY0?=
 =?us-ascii?Q?BdrCP0WOJLginn6fMqOUXQYCtwZekAU8RhxrM2uzntsWhBqiaHXpsaD8A2/T?=
 =?us-ascii?Q?+otcRa5QITJfsOY/EF2h5IpLthEWo7E5O1/9OtOzqqnbW5zs530rqCjCKpmL?=
 =?us-ascii?Q?R4Dz4cvC/RozMVzvVevUzNVCsSX5LWaDnFDNyCE06UrgPxLOB62bX9HPV5yP?=
 =?us-ascii?Q?6dtg9OqQ9PQihSSRDB5LrCA3n2MuD7wz7Fo/8pcq0L+odSrYPT7nr/smRbCf?=
 =?us-ascii?Q?GhTexXeKN6fNbXdoja8l04tX/bqKWTfMJcdFvPnLxgJG7CyJN9IUTcBFfdm2?=
 =?us-ascii?Q?O1zRSqTVucGOL9qlbGO3csNr9wGNZna5fiHodYyo1NdaSanJ9DA4pyTJRsa2?=
 =?us-ascii?Q?4yhNMhTutcdFG5D8m4+WtE33b5dcLtJb9NVKyYtkoft+F3meXdnrWfk2UvLD?=
 =?us-ascii?Q?2AJUzJnc7RSui5N6Xw3fjoNc014o8NT3e+CyxA00ckP5lYUddt43UUUX4FJg?=
 =?us-ascii?Q?VWq0S3S6RJhR9R2y3oZ7SbBasq9D8BZNXAQBKjYhd26c4mVogAIaEp7Y0a/8?=
 =?us-ascii?Q?+CvdogLn14r+El9Vz9kID4yk9iA5j5pHB4S0tz1MeOOjOtT5esbj2Bzi1cX3?=
 =?us-ascii?Q?hfxUYPsYpoVrxfHrVl9PB1Y6FvN36xQ/KR5LsjiqK+MwQtYPdXHGWdJW7baM?=
 =?us-ascii?Q?yxKJX3Qa49Q1bhTSzSPXIPH6+NBqTcO8aK2v6rEOpY5BZfVp1oxdpkZue1C+?=
 =?us-ascii?Q?P8FKULeDTNPHFQBrY7kLjB0k7+byLYyLZpcQ2l0ZC8AC4edbaNI2pLAugVFh?=
 =?us-ascii?Q?qBfwuSr8lKCB7gPXaeR9gcYhJ9Pcid5acc2shqaBnD+BhI7/M9CLszm9GLuc?=
 =?us-ascii?Q?bGmzMIvGVabqb8phMpoaEp0CcMSARXM3ckveKM0EH+HpvZB7GdXBzrpznXxj?=
 =?us-ascii?Q?64098VbP4GKEwrvynE5xRz5wb0plYvSCNMN+yU0yeyEgVJ9KI7QG5hdtASCy?=
 =?us-ascii?Q?TerIPCD9JNwzxzoSjJvdvgRu7EqsZ+s26FHrRpB5em8JzrFwYkHurbniXe79?=
 =?us-ascii?Q?Jlk7bZAN7jBFYC9Kveh1tVcKbJJdHar1xkCk2cs1i07MOaZiTWT00wuPa9an?=
 =?us-ascii?Q?386UnGsmXuKIKaSw/CR8fbCVuzJuRkGKxSmYwh/oQjTNAm4rWWImR0ZmSos7?=
 =?us-ascii?Q?tfx6Tv9UApHcw9JyobMGsmRRF2BrGcMRwWLuBN3ok7P+Fa2MplDAjVfI9WGn?=
 =?us-ascii?Q?nLxzBvUx94/netfp0n/NCP3z/Qeqh5WyUgHGfZAY6rFVnLfFfCBVcP9ytWsE?=
 =?us-ascii?Q?Odx37WN/cSTarBPw7KPv59E2UyjVd4wtjFBjMl6XMkWmvQxhrFAvFK6rKwBu?=
 =?us-ascii?Q?WT7M34WL6PzOZNMBDSZyJ95UCg0auT7gIOZovwn+mztJFi7QRHun5zB2lj9R?=
 =?us-ascii?Q?KVtWi1/0Jr8bKO3le1Q4Kj/Tti7OHeyiclBQq5Ucif3YJ6RYDT3PhbyzM+Nn?=
 =?us-ascii?Q?CWyiPJkg4C11pLW5544PzpXRxQq3slEX+IJxFBJ1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcf32e9-07e4-4633-73fe-08db82d17149
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:13:46.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y14QCrkYTqUkkpnkxMuMhDghF4o+LCu3mAcH6qgpUOJSF1F9dg4FboCsLFyEaEz8Z9DTFlqaf4ZgE3k7NseiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for se-fw driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..654c1628417d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13620,6 +13620,16 @@ F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
 
+NXP EDGELOCK(SECURE) ENCLAVE FIRMWARE DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
+F:	drivers/firmware/imx/ele*.*
+F:	drivers/firmware/imx/se*.*
+F:	include/linux/firmware/imx/ele*.*
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.34.1

