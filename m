Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7E674961A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjGFHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGFHN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:13:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC58DA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLnifU2sykmqn4mxX7dt0gOQzSfk2ddNkyPHB5tw3jq0pwe6qLcHMA1GKp48hMduzzyhTkNzuIpTsZJemTgiwozJ2g31Yt+hfz8yIomkq6XLkjYJUUjI/dpnyLm3BbjcQT/vHuf4UrelF+9hHGQh5sYoku3YrVTU48Q5UPEZ/ptISL87QgvUG+EmqW5m2tdm2yLclVZOQMIsq7HiGZ7+rYBxCFO+dORBaZZTGu0bgJ62SJ/O3qg8LFgHPu3I4TGN3AgnXIBlmsqIF3iWdREL3Y+CYCYb31sMgy3Ed4Az+KKoqsiTX5y0uPoHHVkmwQ2wgjOpRHaySQPQlU7DeU47yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpH/A+pMSvFwqC8zTUhORJh+p6mJYDWQhhj2dalE2IU=;
 b=TyxLHPm/2peUIWSyMLSBjRk1P2lBom8QyhNWy35fUI2i9CKbJo3MMLdmH7BucbzKZTJWEBFbZRyqYK1ppmZn8Z10bP3+snsCw+9xLiGtDXy7hgrd3f4O6b62gh/2pwu024RCJEOMVmyHjyAEZXNdRdjomG1TBrntTJU32ztAhBfNFe6qMfsBEmUaMKHtuuS6Cq5TLcEvFsSpAcCr762S8hzjI0tk+HLTNiG3BQ4vrlwBkK/I/M3I/CcfYqkTKnLcuuyWxWUoMd/9dEwwmTGcfufqYg7RAmJ8nHRBpJBTlZI0noMZrmUOAJmapt2h1T/NE9cy9GpilyCt8pT2rIQ8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpH/A+pMSvFwqC8zTUhORJh+p6mJYDWQhhj2dalE2IU=;
 b=CrbfX8k38SdKzhtV1Irid465n/S8RYGJ9za4fklnW6iDbQJjCyDCVH3u6mU1Ikl1LyhhPHuQSJqtqIVCas+XbMuEJzufrYj6x+3Ow/0pTQXTWQZC7ktenWWe+WM4ZoIjSd/J+Z4J49u4/lGXdM8tEvF+OqFVRFFcI40fqTQ51hGp4Xbz7uCMpZOAZypPzpTYTnaUHDvchcnLABMx1H6V7gKlR2DIxyvYpLgISWB4UfUpjR0AuL3u/SOFXOdKFzHVau4AXzxmY8vVyuJNGTbhxTj4SP31ZNfMz4Rhz7azCT0U7p4UQLlS9NRoMRrtejFBtJqaTLnu3kXiH0DGJOkJsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB6021.apcprd06.prod.outlook.com (2603:1096:400:336::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 07:13:20 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 07:13:20 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Lu Hongfei <luhongfei@vivo.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] drivers: bus: Fix resource leaks in for_each_available_child_of_node loop
Date:   Thu,  6 Jul 2023 15:13:09 +0800
Message-Id: <20230706071310.38388-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::10) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d296a5-78e0-4927-11a4-08db7df07aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHVOKaJVwd6QRaSCzC6AtRgY60mlZFmFXTxVz90LfmJsK7ZoQHHTfxnFiw+k79IJ8DEmtPRboP930HIoOhIXiDZ2SUkGeOLI3jfuZesqkwG+rMH6qhwS8XlR8B/ioTOY4bgGa4wp52+iQdNyaT6Nz36kUWCWdPRLeM7v2Z+ASjRsN995QOKxcrk/8iE49+lQ6NAMWdCIeCw2UvsZpjnesL4OxFtG9nOoAMU0h3kaPPQ7bqLbJRkfa71PP6MmB4ddJAOIDrf0MKOIJkQygZcElgJL+HNSRIkadOM71PvZmeObj/SkNNspFmLdjGBywFk6NksuTjHFcMmjEbCe2gLAJP4tSELqhdFVtWiKlBwBRFP0r8BhaDKzWY+Xv5mt/Br991JceUKgHfX/+uCn1eNdZeqoBp8T0EMHHVtWhMBEC1vslq6OCXjpTTyRxf06blV+D0f3swIjQZJWk7g9AYLnE8oEuXRwyAalQqwnJ0rzWa2CeZLyLM2gaVmygLG+chdNwnQXDh9gPjYkbUAjmIPAjrUKRmFAoTMEnJTz22dix4PAWYCzmPW5xrLm9z/aoc/IFMDlo1AqsexY0U8bXrH1VN+YSn/eUtCVfM3Hy9kyJ9F646fXOSf47uVyl3/ZxTRr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(4744005)(2906002)(41300700001)(8936002)(5660300002)(8676002)(7416002)(36756003)(107886003)(186003)(2616005)(26005)(478600001)(6512007)(6506007)(1076003)(6666004)(52116002)(6486002)(86362001)(316002)(4326008)(66476007)(66946007)(66556008)(38350700002)(38100700002)(110136005)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfSBWQnEdoummb/F7Zankx2tmuR1yZwps3epoSx57omlzu1KFe2Y8DbRDQl0?=
 =?us-ascii?Q?kdz3hsxIBcvBGd6lf/+gG8e47RRqbqK58SJWR99tcelEjTGJuFF+4v/Y/FOQ?=
 =?us-ascii?Q?5wMAFpYFce+PNzVUtt4VsinE5c6z4Xms5bMQ3rSpnkAy/VSuRztzaOueBjgg?=
 =?us-ascii?Q?+zUaUcSah7ORPfz0f1wp5xzxJpicx41QqrWGhegHfx8Xed9QeEI7E1GtwhRp?=
 =?us-ascii?Q?Q2YLH4x1PIw9a2aSYWq3+CYomCh1f/Glzt1BojAOSklxW7LgYCzCLajj/dTh?=
 =?us-ascii?Q?T8ESmE35tAT3vh/1bEyj4FNqtU3LwcSI6gdpdd/gZYlZlzFtvmxtIE0/aTif?=
 =?us-ascii?Q?aBcEX2XBvcO9dUEojiiVwHPwzEt192AzrCyZd6VmzcwpGC0WquzyKKjpCOfN?=
 =?us-ascii?Q?ptsryOB957elt/tUsYQNWug8qq+fY3azOof6eMYglmSy0IQRimxzDQejzCD7?=
 =?us-ascii?Q?MjRihwgO9CE3EUpzgjVLrctAiTYzvImoZ9S74sTW8vpGCjcY4Eoxg8JzwQ95?=
 =?us-ascii?Q?9YO5LwXosAGM/cpu/HnESWErD0Xn8Gw+3/gZleqf+jFDzrqyTY0EeDp1vTRy?=
 =?us-ascii?Q?6EDQXSwo4XqtMQEXjU/i08gkb0mS+BBJeA9xyVHIA908UZpfCrYyfJ8mU/lb?=
 =?us-ascii?Q?brdJXIsP2XLdxpAnKierbOuVWj1DSpLEI3byFYq9SQr6USXTolxrLnmYX035?=
 =?us-ascii?Q?64TVsPRmWI2L00f87qr1pGJRH3EX0YVpoZjLeN42zjJPfjKM7aWaCxTgtCRg?=
 =?us-ascii?Q?JpwScH/PZMzQqd0GOLiSDzr02tHS78dKUze/QFRv4t58FFKSaj9Bq7w9I5/X?=
 =?us-ascii?Q?M3ar4nVuCrYTNCuUGXs6QNqjSOSodnos0a9uB71/K9dEIBAQlHg/1GlTQKcU?=
 =?us-ascii?Q?x+88zPZf5uA2LumqLGZmBABQCLTc5Tkvwj+93D6AJjhTNrkArfmvTJOUUi6g?=
 =?us-ascii?Q?FVjoqV0hspZUPjD/Tqt8cV0CnMO7VsX2tuwBA5lscsVsiFA9oJ4puoMM+snJ?=
 =?us-ascii?Q?qijTUJz8QA+7b5/4SNrlHTW7vdMmc82wyJ9tZ3kACXvpoEly2oTgkHLgntvZ?=
 =?us-ascii?Q?loWP9ZYUKE2eMNwR/1+8yAPX7VK18yDP2wDLqYDgpoO6Z3JWmWkKknmlDWls?=
 =?us-ascii?Q?PrXcKOSVCf5enw80zrvSHHmLGEHJoMkERt1s6tadcAZldUuPH2zSyInHCdxG?=
 =?us-ascii?Q?GpX1Bd/d7Y9XI9svjLMAIX3Gnpk24dnnX9rL4aqY/fnqOyUGpDBr0U55hoYm?=
 =?us-ascii?Q?AI9fwbduHqZLo0IlDvXFiw08t4LOv2N+D31NwGWaVkR5YVCSoBweynFGGTpr?=
 =?us-ascii?Q?1OmXnDEQUZiV4jNkPgIoI/Fk0+vP7LaltoiYqhLS6onoVnqHzQX8X2VnjpAi?=
 =?us-ascii?Q?xm/+oJFT5QlkXFgneEQZKD9+7z+THtGWDECxBGH3EE2Dh+/xIwvbM7XnbsFK?=
 =?us-ascii?Q?DNvavb+SEQn+x3NVZWCsj+VP5npEsoxS4lJY1AD2O2B9cLjmwGvoBEFKnET7?=
 =?us-ascii?Q?5U4aSkqMUzeI6aiAeaRT1Q98D6dMhPE1xdvCRCWcdaRqC+k5wCr4PrMZVSXj?=
 =?us-ascii?Q?HeQwRJ0f+eWt05hluZb3FgCYtOt8mhscBCA4oxzC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d296a5-78e0-4927-11a4-08db7df07aad
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:13:20.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPAnr5+6eG6ALIOFxOsHDfq1ko/SygH6JRSPaqcTo3BFcTnypoTALzZWTiPukzVpRUMt4pl5CXK8U13KJDA0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure child node references are decremented properly in
the error path.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/bus/imx-weim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 52a5d0447390..d05472f7c20f 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -251,6 +251,7 @@ static int weim_parse_dt(struct platform_device *pdev)
 		else
 			have_child = 1;
 	}
+	of_node_put(child);
 
 	if (have_child)
 		ret = of_platform_default_populate(pdev->dev.of_node,
-- 
2.39.0

