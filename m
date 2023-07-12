Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568EF74FF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGLGcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGLGcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:32:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68B2736;
        Tue, 11 Jul 2023 23:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2hyUWuwoT30FVxUOSMCfvYqCCIOmHB0Di1dRBXpC7W/jq2aQwi6kH7/TO7kP6GOK6z80vNPzLFf0PP8FfM5/1FU5IybKFfaewhDHZDZ+t/dY7xwRYL0tsNFdW874FgL7HieZlMsg9j3GGKxaeYmlrLELkcGqB67v+7ykLVR2Rn2XGg+QePW4Bn6CGQt7rtPfFBfsf3i5VNZo77rSTNG/gpPUY011Nt6AV9/Z6jFO/xITiqfKGQhOsg5tg25RZIHCVeNLchk3uaj8FTJQeP0ifMvt4grfYR26YRJvaIi8lqREYA+ZgUBqUIVH7TDvJCNNu71fG48TcSxucN4gki4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms9emQaF7GKuxScgT02zxDwxqIVIqWXVhbmRq1X7480=;
 b=MzSmyg6DMn7j5tHsLjq9C7P8YJA0ieUATJUFhZ+7joHvT9zKNApEZdJsSJRpEB2t1lKuoAZ1D43xZ76kgmIn0eiuXJrbm+ad/V2YDXn7HjuAQU4MO2UyKnszGtdxy00FVYF4AUlvTwXD/PQhTeBXsATnFJLezLQ18r7IzVrxKnlUX3YsNk1nsx8iiTTXnl+Kqk8/6onQVAnfkqUZMLgVFdxtBAVQCjD3+EgShVwTq/4BdZaNyTn+ultzdhoPcLUuonOIDHoMqFvbf91/WMTbpbdd/RuIioNTIezZBdYQGJdaibEHIaOCShi2ErG+jY3vOtiSOG4+jWK9yoGNrJMv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms9emQaF7GKuxScgT02zxDwxqIVIqWXVhbmRq1X7480=;
 b=A5vmeZoJCksxEA5DDALP5VfKm5kSdS8XAg8SHSNJicWaE1mVUejLAFX7mwLBgNKujho8z7kn3TUU1i0eJLMR7PgTsqyHY7u764ue5P6ln1y6hUysxkFWFsPZdZkaoe+LKyEBsIso0PtjiAXJj7Q5Ub3Ef9Z89pGNyyHqAfPM7q3745WGwTKRavZU3wxllu0zrm/+W+jtYUj5fA9ZvUZgd2A09m+K3MSqxcJjrdIlBkO0J73pOVTdLm67wK8G0flZxFqvhwDMEG9Ts2U5WfikMZvWGPpMaysTixKfwezrpfVvXG8WNZKR651+KghjzgcQy6j63dId/COe8xPAzeIwgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] serial: imx: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:52 +0800
Message-Id: <20230712062853.11007-14-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fa0193-dcf8-4bc8-0421-08db82a15ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkyKt5ZJTgbCIm46xwAcjeMLBl6CnxR5D30gqzJ+vfEfRN/mEAH7OtMs5tyTEiph2MNs9WUUKy1dkHawYFdpgDV2XgguKCIrKJhZXpb3LnjMCY/Cvt0XELjk8NxkBEnih+JxfIQkVs5NrI7cUX9wT6VD9bBASwJNTWcMfT38daIEl1fndXCysoqH8Zaf+hhZbdXVIBMmQirG8iU7STiiIuIJerUwpO12E0vVzGuJFJFU9SNCt7jiUR9lcANxeEmjAJg7vuN4beyKRKnr2vk1lxDV3dK35Rn38LBum6/wuEP/WRnXhoLy1tRMO7CTx5vykC84dRZ2SYGz1QS0DUMjHJfIRGfd0564IFRrv76OYSUeoeHo2v9ZhFyvlRYR+ayZPrrbc1N83WZnng2gVYQ8e6jwY9bjO+sMGS+kmwyN7+Q03i/Q9iQJIlFkev3TjLRAaliQkVHzmcN7sjfAWYVxdeba2f6GCONDp42noWHORRu+hOu7d4mzoYJ5u8XWfZemxU5A0rT2cJtaHBeNEDv4bDvD4v9XxS2Jjo4bwuAqELBT2mIznp8s0ONx8gIAowT7XeRh+xxk4kSwfngoULtXK29bb0Ulw14Tp/FsqJsHGhQ8C5G4Kx1EAw6JRULW3M1N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(7416002)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SxVptWZIftY1Xff5PKI01JGU24jbp2r8XYS2137sCWsYIwV/cOot5WUoAkps?=
 =?us-ascii?Q?cfKL+DvvE1Aw/+fma8Ytk+qp/G5aI+04KzQrSgB/2qSrl+lSxCUruonk5La9?=
 =?us-ascii?Q?4lgseGGEvNAB+Tvctuff5uh9q/ZL9OcLOID/AulWnf/B8/on+Y3iBBYj3vyH?=
 =?us-ascii?Q?ura7NOns64xU99BdQTTrQ+6HD5w7LDYq5cld97/zb4D6Dg24ggQ8hrBRDH36?=
 =?us-ascii?Q?vrzcUda7qA6bYPatDsIkp56+cqB//8ZqOxyn8gqR80ak7vpjppCbcmDvTb+O?=
 =?us-ascii?Q?F3KEsL9FHUFloxVTU3k9c62IwGGF7KfBTTDowvGbPhTUW3u05zAZk4FMpTg2?=
 =?us-ascii?Q?OpgENc5OrQ2W7f7Ff2djNMflqzVW3+jjm0Om3vwTrdzQ7eNwVIrCtSf6HS8T?=
 =?us-ascii?Q?HZ9CGfHnPt7XxhRFROPQQcF+KuAkGPhagFQ1BAvg7aIH0BfEGkoWJ+y3z/ki?=
 =?us-ascii?Q?7w+lPFSyt2kcbturZFoAOnOJ1z4lxq5xybPPsE1tV7Jn/oP+NS0fxTDtg6WK?=
 =?us-ascii?Q?tjBFIL1iEaBZ0k4rv9NsBXHCtC/Yhifsi6Aa3aLKLlLxKgNOZ6nuaqvfIz4C?=
 =?us-ascii?Q?XOWbgiug57xhl/Xdqs99Gnpkp65cmcsoyZ5USenC0onUbisAZg5TJ+zX+/hx?=
 =?us-ascii?Q?Dyzl2NwVgL+wi3CQH5gqzeNHO/L/xD2tx+MWvuI+hndQSN8L/dypJ8VwsXMG?=
 =?us-ascii?Q?BdB3+nEs7A/Dp9ZJ+13Zi8bVEXu3lp33cesV2Ho9QhjgOa9+jcN7dTZoq6Cp?=
 =?us-ascii?Q?f6Ci6T5Z1swdyORKVli8V4R3MS/rf4tBJi0yDbn7xBy/emrGxvFEvpWvT2Tb?=
 =?us-ascii?Q?78nEk/DVXeqj0pTkTG0j9UzwIXJS/LckIvHknlSiCMeMDibe6/dPv4Dic/pJ?=
 =?us-ascii?Q?6j2EG7gDGU/mCUggJLJ1VvXJvqNFchKLfhf5/NenYJ1U2Ttv624/i2YCn7Z3?=
 =?us-ascii?Q?JwGjtPpVlesY/GL0ZFyQxK0JUFk/RhpbuMoG5OLtzurfYCfWrdA2aTqpuIjm?=
 =?us-ascii?Q?JZWTYNXTnRaS0RwQNv9d/47mfmmW7kQ6hdwIzRXVhdSt0WiZRvfzKbW4muh5?=
 =?us-ascii?Q?p3XWiunzlFol/mRYSB/5Z9NMKkqBioB3rIjS9QwyrNGVb5hAGtce0l95fw1/?=
 =?us-ascii?Q?ZwxymJX0BKN2lvTiJTThY3Q2UtFNE8ajHQlxjFG9Lr7uSm8D4EKoLxcw/A19?=
 =?us-ascii?Q?AsoOeBbK2Gl9Dr8V67w+ipXgPgCjMPMMPgCvFwOzcf7rze42DuITd5wiTMCr?=
 =?us-ascii?Q?D8J3fDLAEuFa1W1lyQOU8GhHXWVQ5q+HnH5Vs6iPkms83UYb2aVrW6Gc3eEq?=
 =?us-ascii?Q?PlCpmnce9vJ6Sed7VFgFsg6UbxIPMdLYuakIqd7b1/i3rzl79BPJd3Dk/ylQ?=
 =?us-ascii?Q?P7AesGZpU2dj/hNkeraxeW2mwfpdIAAaAe9ifGWddIGrxeaDLeq+j6njQnda?=
 =?us-ascii?Q?zJAu0cxcLrc0C8o2n4oysoMORSeTx3NBDb15uBFiNDuZqDGWs2pwBtrHybLk?=
 =?us-ascii?Q?+WiuzNyEjEsr+CRejhJogp77+AuXK4kuu5Q985YGBQMxkvHlTEzb0/g+4O23?=
 =?us-ascii?Q?Nyhhegw3N+lPLmkf5P84pnvrZe/q2NUPCTl4ZcYt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fa0193-dcf8-4bc8-0421-08db82a15ca3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:36.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTl/a0QEJa1G+ZFWNZOKuLaUm6OhYSovTMfGqut2rHOhG1kqMi1QJwaH1CjFfMnzfBzXhfKiUV4bBZ7lKIntmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7341d060f85c..4256bc41cf1b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2276,8 +2276,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

