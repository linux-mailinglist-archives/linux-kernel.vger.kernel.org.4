Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288E6D3E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjDCIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjDCIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:07:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBE144BE;
        Mon,  3 Apr 2023 01:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKC9fBKL0cZLA9nFvYokPvZ+zTIvQx6amnF0uL3BhmPtdd0MX9RM9c5PmSwVxB84d9FKrg9z0Zaw89gkveryakpYTuAFAV/e4YPxoM4pwcmDMcmURPMl1jd931oXTmJgpFtmXDwA1dOuvHOm36492p3A4vPozBVbM1Is9s5Epo6xmhbdB8CBO3DTAm+Ac1QO3lg3+p520ITXlRrerNBT9yp1qN6imfDFYWH6MJRipmBXFRaGVCnDD/OUpYWZI8aM9XaXjqGrl9+rEdh7SohRi9gUnkN8lUIBHBWOkRj2BxXgoBNkaCyMFsgYVqk/xtnFDnn/QdV48ljWx1+u0DT8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1gO7eDkCeeNLgQypz3QyHe8k0Mu44vCcK4UGegb+O8=;
 b=nrcrv3GB/16dUygqJsQvtBT01NkcUMTVp33YA8bwNj9A1e2WY+C3OrwSW+JcBbl3kuflNF6FrsXRaRJN5pFXckjIuX69yrQsoNRoBH4YjnmykpbVMrbSRGpHwEmbjqLuh1GvNrxVcVnWNvTcd9Y3BNwWgw/BeUsep4n1TTCRxCALL/RfHSFDTCuInlo2M8fs3vTuWMFomoSHvG+vsu9up7ZiAkJyyLfpP5gnGQ+Knjr/ox5m0Vt+YDHPsBq83JmidRIZicaxuQSH/h6WqwVC+T9prGx/Vno/qnhckr6SG+n66zbgv4DNBXCUtU9elG4DhSWYbXPjSrTihy3XWmbf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1gO7eDkCeeNLgQypz3QyHe8k0Mu44vCcK4UGegb+O8=;
 b=jXs7lG7BRqzjHAgZTuVMzA1MsUwnELN+rO2qWJ/Q65oSJxOq6C6rP8XQ+5PjHk2YKuwhQVoXWeeqIGt3/O5MJZkyISe2/aVaa+oqI3HIQlc1xRT9BX0xiyXmFf0ZrNxmHYbSAKpiTSplS6w8I7YVb2ycCchtiLl95/qoI9kc8yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:07:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:07:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] dt-binding: clock: imx8mp: Add LDB clock entry
Date:   Mon,  3 Apr 2023 16:12:44 +0800
Message-Id: <20230403081246.3194230-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
References: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ae5435-e5d3-4220-cfc6-08db341a833b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFTAfv00kMjwJkP4VU52G+GYWQHSSyNQ0APFXK7eWg9Tz5P50nwxca1o6HbJwTGJpSIhf9Z3t6VdwagJQX4+RtnFSeDCCWC1OlU2bAOUtuoF8Vuyfg1soaxNd25EWSZH1dZcW2Fo+3ec+x1Q+R8N/SQrFGCkfb0QwPQd0LYHDlHGCxKN6WOCBM39lVVh7WpBVBtmde4rV7ICtvrMvrJXTnHeJ0UYr7l1xxJrNOy92KLjNeiRVfXXRf1RU7JvUmA9QKlWX1PWQoZOCsvPQ9ACvJB97yP3aaCZjMx04xygnqi89NQKW28R1zyrEbeIO7ucTVW1UPiUTUuNVLpPFm78A1/voJGQEqeWJC7+ogxN0qdp6uqtBiRcTe349Qq3YJvnGfo9UjC5TO2q/BcfU/FFayWgOYkJLgdp73sAcWii/12zBY1cuXYbeRWv1o/imtwfuVQexnlJtEBsZjlkGp/S6m8keLjT4dXwi1pJccM5egHjFMymEL5S5hvQSZEljORYxA4YRJdYfRZzZ2B/G6JmSqn5rgwtFK54oFwRrlS5+HDtlF0hy8L6XvCZxWK/SbhTn4Z1+haRjx3JzTO84qPxl5x55NybqT7qfBchABmVehXiCpRrNv3I+4ZQiqBLluFakFzRNYUlc45OxMII0pTKlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(4744005)(316002)(8676002)(66476007)(66556008)(41300700001)(4326008)(66946007)(5660300002)(7416002)(38100700002)(8936002)(38350700002)(478600001)(86362001)(2906002)(6486002)(52116002)(6506007)(6512007)(26005)(6666004)(1076003)(186003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gW0l5ig0gY2fQDADSCfcgNE5+7ZI9B/FakDec0oboOvatO/afkFdSgPM0iBW?=
 =?us-ascii?Q?Ol91YmrrCIxjIKd1yIa79eaCJS0l9cXqIe5j03sIAx86KL4bAEqdAsVYqGpp?=
 =?us-ascii?Q?6z0lLb1MTT4xKApw+xwvdef2rssEdcbbYlN7BH6gxW7TMnNiL10gQCkcC238?=
 =?us-ascii?Q?xHtsKD6kMZU902Sj1FhQmd/4HrRByK0jIry+Lb0tomNp74l2qA6NKq57N5HU?=
 =?us-ascii?Q?REhenagBVsIPgc7vdsXyatSrlywoqRYHDfgy+JCXXXwgMOPWX4qwwmoVivw+?=
 =?us-ascii?Q?lU+viElWMBCbzYV5vc9FxdR0SkGGzeX0FB5JKHDfuVImXWSIHGaTOSpTL4u+?=
 =?us-ascii?Q?UagvCSwXvOth6H3flr1GcnTL9X7t3lja66qDJSElDR7c1WN99lQRjb0e9+KN?=
 =?us-ascii?Q?cWF2tK3M8OmAxc0JrtzjzDlpJx1zFUlF/xb4abivO+gpUMkIaca7GCfXegmP?=
 =?us-ascii?Q?DNj1TF7/iK9Z7cRJVXcGFl2TyozX7ZvVDdSGtEtwB8GByOfiN2sft9R/3/1z?=
 =?us-ascii?Q?bYBo4CsfPouBcKq99MFMXm4b0gMkSpqUagqgUSSXVFHv9jQon+OYY3OSNoxG?=
 =?us-ascii?Q?W0hbhcHMwpX8QWWC77Dd0X+8F4PNZTjZZ599z98AubwZsPcAVMCCJbaQHE2K?=
 =?us-ascii?Q?O5jzfrO4Xq+g7tE4Dkp9mB1vPlPBbx0vScushI8IZf6+bL8mEhYYZeHJY21x?=
 =?us-ascii?Q?fvvcco3P0UuVhSe4MtwAmtBj0/xRInTaK2eFvBtrkPmMl8a6PIvU45I4LEmX?=
 =?us-ascii?Q?dgSHIrU2jMdlt05LpGncHXAPz2WZKnV5G2BK4PziAJ0meC8Mz+z5qDBLkxef?=
 =?us-ascii?Q?lfdEzfmGd78w9HhqMH+KK+mA213O+PttP7423OYVpGPUQXcA0LcPgNTj8zHd?=
 =?us-ascii?Q?rSlZL+X6fTrndOnJGndyKXDr18VKX9Dt3QnRwW+EPurP5/GyFhoh75gC0tW7?=
 =?us-ascii?Q?/KkUp7kYuSxGcEQNKBZBkI4wKJa8Zzx8tKLo52eOdofAkuyzXtDqdrLD9TjL?=
 =?us-ascii?Q?DuvkmomtoCuaPLcjNzA+snbRJOw4TwheyKrXNKZsqYH9PsmawDLQ+Q5Execz?=
 =?us-ascii?Q?sX4DTIz1C0pcK5VJYWHkioWAaPbPGlAZ2CCFfPqg7B6XD9cP2Xkp81GuSFJ/?=
 =?us-ascii?Q?NbA3eYvSJOonTqVf2YIcFwMSvSTwwB+w3v4JT+ZfdPH5xSE+e3FlPBtQk+Lj?=
 =?us-ascii?Q?HHTzSf+GcoH6YRIxaqINoSv3Lea3wsJU4GwLYheN8JGpsxOrqhoyXf7WZ6aS?=
 =?us-ascii?Q?caiLDmdJnLHRy0OldcY1yxaqUYJvT7oCF60euCvDnpCmPDZntq7LumOSA29N?=
 =?us-ascii?Q?DQBuzcs+BJr+Fi0gOarKWwqAAbBrzR2ETIgWdnhyqPZygki1j65mSTtVq82u?=
 =?us-ascii?Q?RCDiRlpXNwysJYef41b3Lg4pDP9bLyxM2riLth03uNF/t6xJj2SE19Sq2++P?=
 =?us-ascii?Q?1kaUF4Bic1Ci1foxRkjpctSVrF65mbrh2AZoZOcqZKJZLtbm5ZZm++1T+KRa?=
 =?us-ascii?Q?pjKIMmZOUOd3JQ7uMwpd/2fIQiFydXi+4k9D/T9n13Il+1oist3+iJgGEZsb?=
 =?us-ascii?Q?6Ghab+fdNS7OzXbC3M8Yudt4Q2amC4c7hHFCnxVj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ae5435-e5d3-4220-cfc6-08db341a833b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:07:49.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1QsL6DOdG8Q9SGw28FozfnFg0ETNIpfCXiLpHiqMZSsT3jQzANyma22NPMT5R5OQ9HgIUTXQsOEBfsJTuSPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add LDB clock entry for i.MX8MP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 New

 include/dt-bindings/clock/imx8mp-clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index ede1f65a3147..3f28ce685f41 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -334,8 +334,8 @@
 #define IMX8MP_CLK_SAI6_ROOT			326
 #define IMX8MP_CLK_SAI7_ROOT			327
 #define IMX8MP_CLK_PDM_ROOT			328
-
-#define IMX8MP_CLK_END				329
+#define IMX8MP_CLK_MEDIA_LDB_ROOT		329
+#define IMX8MP_CLK_END				330
 
 #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
-- 
2.37.1

