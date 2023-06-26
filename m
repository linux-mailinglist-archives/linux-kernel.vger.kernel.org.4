Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34F73D6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjFZEyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFZEyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:54:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE50EB;
        Sun, 25 Jun 2023 21:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP0i3XKn87H9yaH3wEkSwukjDDwLdTsEfkajQXblo62YCjXelPJYbwlJYWjlucLD5hdppullgduMtBbr1TNVBiRh9X4D5eTcHEcbT7E/cuTw9YznpezIqI9x07C9iSdg9R7VZu9ZrTztBKzwqEzxaK6vxq90pTUnhAlmA5QdqeL6j0JE3Hv4y0uWy8B/hJRGYSN3mC6M7m5QhBlbvq/bN/dep1LEcuESvzeAHq5KRsxVSNg5uZkI0BoPf8s/eQSyyWO2rxhD+U2JrmOpeVqhJmAqflF2FS6p3OziIx7lQjA3oDqEaNIh0dnEWhdktfaBGLVeUtnKIbzQwn/PI6sHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHEKk/3AN/ExQnd+B/csmC5AcYJ7VVlDJMcKgR21rs0=;
 b=WgD9mn/lFVfcxU86Hf6eFaz70vntY7HSOd09N7LjcF03tVFtenOd74aKYAZmcAAxIAh6LcycHdgvcp/v5pNMfJXjZy5fDATiWjmEq1Y8/1ckkNH5PtK9jW6t7BNLEO5GCdBXDnbfc1BRia6EcZkTnBiBXQyzQETyS+3RrDNNTHgTn4zC5OmvZOwQEQCjXE/xE7taTnOLHtYrtJrESQQ6rqrAW64KYv4hgxkn4tbWlhKuA3w/Dpr8XXv+EkE77NpuZiUlF26e4RrsR1M1XKmf9hn9ohK2+b9GG5gdOGKB9dnIEPDu4nm6JpR3ml8NiMgepgS89+QXmOAUMOqORbY4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHEKk/3AN/ExQnd+B/csmC5AcYJ7VVlDJMcKgR21rs0=;
 b=LaGR+xo8mkSFqK8kyseSxW46kJzjcHertO+msfVbgBKtUWXW+LleoOyxD39RWlQDPjteHVg5cAlzX6C2/WXH3B6hUpJjz+aevb/EHNevnSLgYBsbj7F4gYRScnr3VcnH6vSwlgsvC7HxTnObfgbz8eL9QO2hF7yB2+a3tYArSiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 04:54:12 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 04:54:12 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 0/3] correct the lpuart compatible for imx8dxl and imx93
Date:   Mon, 26 Jun 2023 12:48:45 +0800
Message-Id: <20230626044848.4417-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdb8f77-79d0-484a-0921-08db7601628b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBWpts0QIBBzz76tPQnBOVIMY26OP/bYWHjKTDUchrNCnRGpkDdNWCS2wuOY6gz8p2SRpNt8aR+joX3A7Nn4QhPXMursBLYDDGISgsztZRbYJRReeDoRkFAXqrstWGno2+bc/mmGMIJfbe7Und/yJCGrwwuIoITqBLvCUlGVcUiBygLIzm/FZd6EuZzdK+1P0lCH+LCVLF8zfMN7tSTZjzUgYN6VPWvNmtFJgP5RrKFa+aoIveDbcdt2T234MT9dKoa0h4swyKr2vE7q0HHh3h1k7thHS4mOG5s6acv1cLeRkEk7ZPIDthhdLgjNEVr4UGciNqWdGEimSGelXZzMqR5KJ9ArPRccKYNF7695AY3ODp+viFcLyBV/rXU0ejbGBCKvNBpY2b+QszSay+WEgbPhTR199yNAhn81pSYkT/Y1L3bfXn+eyTsYUyRWtSuqkcPaO8K2UL9L0VqE9dB4wc36ZbJDfqttKK2TbOI7bAjwcF8/W9WIvq4ydc3C9DuuZzgWLSeOoqfajLd6TrzT6TO6YNyy2D9GVGbTBEZ/tcMBc2D0CZKhYpmqz2/TLeglpJrC6y3uhlggbtKppRp6wwThbvFv6I72bJmnCcxStCDtwO2+phtHUyKLB33yAGkECI0JvPc1uU6CTOR/MDNkqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(186003)(26005)(2906002)(4744005)(52116002)(6666004)(7416002)(8676002)(36756003)(316002)(478600001)(6486002)(86362001)(4326008)(2616005)(38350700002)(1076003)(38100700002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(83380400001)(66946007)(66476007)(6512007)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtPN70w7na+L4OsqPBi4xLGmDDj9MIVjprW3Brp6TXSM0/6onqUyPjvmX863?=
 =?us-ascii?Q?Xujq6Dmfk4fvMXfXj4HqWbE8yX5ySLtnV1p1MDxkqTDfcYVW6w+DoBrwlr6f?=
 =?us-ascii?Q?LgUioZ3hgttmpL9GcaMXQ2v5ckvXN2+P8t0Fwcg9Bo8bYo8HCB7yfmiuJeF5?=
 =?us-ascii?Q?JrLY0qCbehOB21knPzQLtZ2wNr+h3+Zgf6pbMmq0gxkJTyd2MBcfo4w4AhVE?=
 =?us-ascii?Q?3BUIdM3dI/VjeNekyBYX8eOWaD3GKmVmk36e6pnxCNbSeGiURNUtFQX+cOPR?=
 =?us-ascii?Q?WYSFJaAEi+He5NcybKmoIjRf8ort+pb2GN2EZsEoVZIv33XxMB9sfg+wiE2a?=
 =?us-ascii?Q?xLZ0f1QWDDN00pfqurKmE8nMWa4m/6/tsGwGL8JaghM9y84O7IymdHf4dirr?=
 =?us-ascii?Q?o9HoJaDUCAKicJ2nvMmsxaaFnrhS/UXRJdDNKw+bQfsJ+QE3bKiJu7CwnEUC?=
 =?us-ascii?Q?esQeBGcqSIYekif1XwfLqq/ozlM8MAiYLLn7iamoaeyutJ5GVaDIcJX9fIIi?=
 =?us-ascii?Q?s1Qv5xMeF/CQvs2d4e20f1m2x8W11xa0xr/S6F8cUjo9z67Y7Wuht3O8RZAB?=
 =?us-ascii?Q?KZnEu274yhckU4R9aGRl50dH/aSmlIuk24GB6UezjuAM272/0EErobmr9ncj?=
 =?us-ascii?Q?2IYtyMTcgZXrzIivhesWolG1M3UuccAiZF05OR27mb58dKUgzG+nLWI2N+nP?=
 =?us-ascii?Q?bjvUlgmyVjP9yQcQxxWipvQ9Z80vOeLdqgN4bcgUNYzDgvh8hF3Usj4ATBER?=
 =?us-ascii?Q?OAP5FBRx9K1/S0IeFX7jwn0lXG6EjNEyew9cqyDOXUsp+KAVw5QBmGxF6SId?=
 =?us-ascii?Q?rLejRC9LJDnz8EueKfJr74jQ6c7Wt5QTF3D8blwpMoPQxhaYu65d3hw8Rggq?=
 =?us-ascii?Q?OqLqnpYd7OIjcIzH3I6veNxCbJ9Fmcj6znrT66+7vOkO3LfS4/ZbJSQB465j?=
 =?us-ascii?Q?TBIvbtfyJ+iTSgH2zO142Ew3uCs6LUDhjaa/gfI0uyuC49Cvz+xmzd5vfwWZ?=
 =?us-ascii?Q?1OIXfqq1yP+Gfgl2BNCqL7/ipk+UlvXtMGZLupJ3bcVPU5MQukg0FgvW42+Q?=
 =?us-ascii?Q?Db2AW4s613bIG3KmcjnVDPHPY8xVmzOSTDqNbYl9ax2GCBkLbG1gXKh21fuD?=
 =?us-ascii?Q?SCryTaENTcewjyhP6FWCYHIKqb6ZRd7d/FJXA8StUZB9EA0q8CUIC0JLJDcS?=
 =?us-ascii?Q?Bd9DuRdgqPh2OWuSYb33i+8Fa85V/T6EOgJcPm3deWSdWvj9AWw3F6eT1Hrf?=
 =?us-ascii?Q?FAa1iAP0W34OnNcRmIOMZ8iKtebx1Qwa/UHhPsUW29hIU6nbOe5c5zIx/7mu?=
 =?us-ascii?Q?td1i59ZZPFCSLx9g23vnsptP96yA4v2/PkItM4wz0cKz3fYtENMkoTXUcMuQ?=
 =?us-ascii?Q?EyHK//AVyiBMjZXUTDg1pPBNUAA+JmrxW0tpUlcCcAlvI94VCqEQCBn3J/Ff?=
 =?us-ascii?Q?canDIGA+pCTykQnGr03I7XEw1TdW771yQT/sfa1LMn6/bmUfDMPvIfkbto9X?=
 =?us-ascii?Q?QYztse5VawAfdlCronUcZWWFE1DGPAM9iJ1/shvVZc0gvKqSNqmK3dRx2Djm?=
 =?us-ascii?Q?Wcs8Rl0DsWXaazN70FvWjjmxL5nhso5wxrGlVzDX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdb8f77-79d0-484a-0921-08db7601628b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 04:54:12.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al7kFp0oeflbcNPVQaJx9HssZDYhd+mc5Dlw+8z7PakoFiviCm2/MNx0bCgvIMizHw8HsE5vtp5lrm/DrLgELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set corrects the lpuart compatible for imx8dxl and imx93 platforms,
also add the imx8ulp compatible string in fsl-lpuart dt-binding doc. 

---
Changes in V2
1. drop the imx8ulp dts changes in last version patch set
2. add both "fsl,imx8ulp-lpuart" and "fsl,imx7ulp-lpuart" for imx93
3. correct the dt-bindings for imx93 lpuart compatible
---

Sherry Sun (3):
  arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for
    imx8dxl
  arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
  dt-bindings: serial: fsl-lpuart: add imx8ulp compatible string

 .../devicetree/bindings/serial/fsl-lpuart.yaml   |  9 ++++++---
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi      |  8 ++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi         | 16 ++++++++--------
 3 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.17.1

