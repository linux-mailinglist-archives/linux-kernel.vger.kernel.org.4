Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8E6FD93D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEJI1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjEJI07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:26:59 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00A35A2;
        Wed, 10 May 2023 01:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZz3ecHWM1XaU8q2AWV7C1cWBDDNy6str8Td9VoCNYghF+L/3YmL5IVpociixssgIvhqTwqB1lPGGP1KQNaQcMs60roAjkGEm/U6cBtY1gRIOxtKr52o9yBwJFHoSOiAu5YBEpl7qp3AC70lfDN2hprWvIkAXWaT0rNOo9l7SrBSp04cn2yzHazUQ6n8oI7fKHbpv8AyfHQEMUCwigm4pTeJW5dAcVOX30CMAlUCcvaEl8TftI9KwWZ/MY5xpeBcVt6aS+e/QzSWX/57FJQzSTbi0OAgGc8cQG4zJ2yTp+FlzeexCxs+uHvfrWdYzViFdcYwsh5VD21Oeo/BKmV02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ALnKPRXOF30OWHnod+mf9fJaBZqUOGGbhBARNR+9+c=;
 b=PXE3mcISAiVZfvMNp+JFUqheGJ58/SrcO3K32hxkzKIoJmdMNP6HnWlFIe23DHAzAtEuwD38c5A44kgL5yX/ig8mg+kuBW3kDSMzTihpUhts1cAQ3pEiOKSbq9Cd3Gu9T8u+Y1J9ec/kmlSZTWajE6/5mXhRnqrWa6vEpR6EAa32tRa4IPOZ0ZEY47m1sHqjKPMqVpU3J164EgDybaDASZMneyZiv8mmscPhSyKDhg2/3eKbJl95NQu4lOvdhOKsJjgnPrK8yFzJonekCUjjCfMf43YVRuajukJugGFSk2N67lpaNhisvH46YVgEAJCzfDd8IcCuyKgKCFsDvc+/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ALnKPRXOF30OWHnod+mf9fJaBZqUOGGbhBARNR+9+c=;
 b=JmZw0nPAN8xJvI/DXvQrLg2dJ+upO+2sQKxpEMTXh5EjGQAmcccttqcADmBJwmEu6XfXban0Dsqck/0OcPremg1jql0t5AhqZglLwk7txiRXqbdfSXa8AfW0Yx2wXc44A/W2H5V2Rxa/1FqzzO7ktKQuEUJaaKlYUc4/D+gDrRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9557.eurprd04.prod.outlook.com (2603:10a6:20b:481::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 08:26:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:26:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] arm64: dts: imx93: add nodes and minor update
Date:   Wed, 10 May 2023 16:31:48 +0800
Message-Id: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1a607e-2b3e-4329-eec3-08db51304f4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBb3XUAZBgozZqqrez1oxcfSrTLpnWSp8kbMf3V87EityuYH8IdvnG0MrA4oHRzyET3kk5HJudmkVfEnVh155tRNwthY6NgLNSpQ2gGFqLHS/F9Ig9cl5dEv6xfOpMCqpNlAmgD7ik5jZRfBwjO5U+uzt8rbA1eg5zJG91A7tpuq2S1k5RRvQWmbNrKh34w426y8UTCqT25WCt3xpFUcT6TC4p8aZRnQS+6J/pyTXF8u07FVyjZfB+vIK5WmvdOpZQoyH2sbLUHDNj+/Mdymove47INJ0o0fJRSc+3iKxkuD+yp+NbekSQAKGOAhijGQLZhg89llBwanPwD+xCDw27tnJD89DSav8yGCk1QuZGmfv9jd3FwwtAzzCDrgCAI5DrxNy+C+B0BpaUnEhLc8uE9gb7NVU/KYM2QijiJ2zOVsVUiVZtN+i1rHxBPBXCsBOxfpwPXbEUQVy5IIBJtX6VMUTqUhai60iuwH4Dxvt4WX2YP/+IDFd24e30e5yDXzcwOpa5Wrsg96ca2AFVnc74wYmNuRM6RaCPpHHQ9S5ytfzt78NyiqTIYKtZFx/iEwmT4tNpyhab34IXAg48nwOmraPI5OF7i3dASnmHsjAPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(6512007)(38350700002)(26005)(6506007)(1076003)(38100700002)(86362001)(66946007)(66556008)(4744005)(2906002)(478600001)(4326008)(316002)(8676002)(66476007)(41300700001)(5660300002)(8936002)(83380400001)(2616005)(966005)(6486002)(52116002)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eXhdDnIELpT+iVw6tG/aJGow+u+URGLp9QyBVfYOouhSuqr0SmR/dvPV3GxK?=
 =?us-ascii?Q?gJmjkvSLdZU4NNzHstotp9A+4DORiLWCxt+V3rWCtnx2rla3m/eh4XeWWQrm?=
 =?us-ascii?Q?RC5rUw/gM7ChJg97KgeGWDborRCJPomqBXi6fB5XdQXfi5mF/XppYMGJAFBn?=
 =?us-ascii?Q?rojHu8JRD9vU01vK0c38DGUSIZI3HlmviKSbiWS4Tfs+M8G+L8/EE4tZ/cs9?=
 =?us-ascii?Q?OzMj+OVKvyyt3awxa0lJqANtRE6+TAq7LGDR1wXg9aEGF7M0Ft8xgiXwp/ZR?=
 =?us-ascii?Q?Q7msiadTmYrKPkPOrIPP6xo6Muk2/f1GvkIRlZsGXbOq6kJbXboS/1C6LDq5?=
 =?us-ascii?Q?oPOy3hB0R8zQrwjPXnoHSbkQe4u+GJGbxjlDlfS5lGbfrUyr1a7Y3QiPFqp+?=
 =?us-ascii?Q?up2DOQqMhPXuCZrTXubDffaP4zpswzLKU6xV0WdQa3F8MJPku+DfZ4WL3klQ?=
 =?us-ascii?Q?oB8mlIuZJnkEBYYKzuxOn5xqkN7ot4zOMx9GI0xXOUvWIyUT8ZrgmQCDruJI?=
 =?us-ascii?Q?ZypKWauicZuzjv4LsuecV42pDqite68jPJMShDcihGCkX4/98fLHyIkmKrpR?=
 =?us-ascii?Q?TSVJxILCNxrGmWzNoRxTsmruFSgGZVzVgtxj4nTzLVUTNf55H7Sqz7OJyQjK?=
 =?us-ascii?Q?BglhgzcDahyU2Cjxrq8qk0SR4jPmp0uZI48BY2LOT5Pa1GqQ+ZLKo+5qBI5z?=
 =?us-ascii?Q?w/6Lqgp9Fw25mmd3eGkBgj3ypJigzyoAcxJgrwohJhBubZ0q2sGVb31ILssD?=
 =?us-ascii?Q?S8bVlekrpCfHgOt7ZzA7EdViWl6jVIM3jMGzEVSkaPpzVx8PkgAb8mas3sdm?=
 =?us-ascii?Q?Z9PZoF0cB/a86vxciaoaZsNZp3O3EOQ14Vz6hdU0TZCF1yK/xWaWLDoWGSVg?=
 =?us-ascii?Q?CBTE95zd2QVK/RFvwRMC1bwl8amveuyPa9xAPAfYNunspgh2IlUE3qAuh3LK?=
 =?us-ascii?Q?Ht6p/Wycu85Y7HPe3hdPDkjbE9O7nZDhXsLzMy7B03q56n4srISdPFW4ygxz?=
 =?us-ascii?Q?q+j9Fvuze7WyKUkoHkYaYJd1PLl3LemDOdyRDVRWVXvD6WHPDwObdcjAt+wm?=
 =?us-ascii?Q?atVnhg2EfTWG2L1LOl7+E8gv26gEUlLYrjGgfjdJz10HYkZxKqIne/ZYE7eq?=
 =?us-ascii?Q?p1qZQ5lX7CfuuxeZAq0tDfgTlPQZO2VWGb1nWhptdnxO+oLdKOr+JYtpFirk?=
 =?us-ascii?Q?mSRkS4Vy4DUD4GK0YpeSSBiG4UzGhytWaevHwpDRl/MN1fB8GJZT+G3L4g3x?=
 =?us-ascii?Q?MhMNyOU2L7fIOcNwt++ZsstkfZr7CucYikBErObfM/AfX6we3INB1ZMrC1Rr?=
 =?us-ascii?Q?QbohUUwsFKEcnFL9HuKickQSUfi0b7KyUke26ayeolLYrG4CXg+TaKRd+Jfn?=
 =?us-ascii?Q?x2Tj0HBzbn0Kx46pLjKk3NMZh49cK73Q/B1EqbKy20TQHm4LbCk2865xOpkB?=
 =?us-ascii?Q?gABDIi5FjgDD84sOAK1v8Lfmyh2LIRTL6O2lxfaRHoa7ewNY3+jMGnBQoU3F?=
 =?us-ascii?Q?0v7msG01AoJ+ejtZaaKbwLDdNBGTpebiQG1mFPYpI9TlVGaErmZ5tK/fCAXN?=
 =?us-ascii?Q?6oC+c1ngRJgSjXBGuJoOGwbaf61bG7dQyGEKPczT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1a607e-2b3e-4329-eec3-08db51304f4e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:26:53.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPjjbt3KZP5CHjuTF5EC3CParlGf1ZAOUzJR/bqnKho0UHeWX8v2L6XAmAAGanAcKp+ut3hyqIy2XTrqPl82ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add watchdog/ocotp/cpuidle for i.MX93
Reorder nodes
Enable WDOG3 for i.MX93-11x11-EVK

The OCOTP yaml has got reviewed by DT maitainers:
https://lore.kernel.org/all/01be24b3-aaf2-e27b-d00e-f8649a497463@linaro.org/

Peng Fan (5):
  arm64: dts: imx93: add watchdog node
  arm64: dts: imx93: add ocotp node
  arm64: dts: imx93: reorder device nodes
  arm64: dts: imx93: add cpuidle node
  arm64: dts: imx93-11x11-evk: enable wdog3

 .../boot/dts/freescale/imx93-11x11-evk.dts    |   4 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 128 ++++++++++++++----
 2 files changed, 102 insertions(+), 30 deletions(-)

-- 
2.37.1

