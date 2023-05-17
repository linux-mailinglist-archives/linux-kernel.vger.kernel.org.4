Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51627706DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEQQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ECA1725;
        Wed, 17 May 2023 09:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEom7AzYLMavqaDmfj3CJZjQE5qKkgpOqLvazepiOUXRJSYsBgEKvHRDAvcJv8jWX3muBAnH4UMEOf/4S7sY+BvzkDDR+/Qndik3Xhnc7DsK2QuXKtQioJtuXU5/mQYQ6bPPSQLA3HZkAxi6CJM+86mwUpN7C00CQ8Rb7D77OPECQ2CKNhSbFMu+UcvQDaWZTUuJX4uwZ54xZ7y7wi27rV3fX6lnX846m1Zd55yONJeTv2gKX/IWIh5ouME/WScJseBx0x32k85nY7QAJ8HLFjWv92c9ui03aHOVpDQdwaujn/RcMDQx9Ty2V5/G1RCb2LYW827GC3xMGtFCQcR1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWXMhnO2IZwYzit5IYcLyjkmqox75MHq1vno0sgcIqk=;
 b=KbHbp3R1QXGj+1Y6z+ZhmeNZ4AcSNjpsuZCUslIVph6/VJmh+8QBLJeZPEaPyRRahvlsm7+8+1kQJO27BjPnYldCi6tqaKyAErDZynU8fKSaa5Jq9mo4vjLCswZlBZORoLig40FfUKIsd2zGSyhSgbUPTCC9aJKN9SWs60eqZjTI7RyxPXtbisbr9RWF8wZN4ufq5bCkpAmE5qkxfO2Uol3AsG8LMcwyaQsrAZ6+4xGgeuKoLJ89SgY7bBN6Wkj7ly0cfgpx57jDRYupWurixrmHOPc/q90JzDHB3BJ4I4qPn71H685IV78p3GnDaL2bowxK8Ainwv8rRIdVJBPCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWXMhnO2IZwYzit5IYcLyjkmqox75MHq1vno0sgcIqk=;
 b=bX6lJ+lYLqa+rkaonL1QDj87c9AZ0Z6iLm+b90/S6mscsQ7TenSK3hklIBjJA3s8MNAkuMFrMTOpYKEfY745U/sF8iBFU7V7pqL7HF2dDqqp4O6o1+5U8DhMCFNXUjrqV0zwwDLvMyVCzaPhSCiik7RWCuRPQcTQZ2Tw8G0VRHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 0/6] phy: cadence: salvo: some fixes and workarounds
Date:   Wed, 17 May 2023 12:16:40 -0400
Message-Id: <20230517161646.3418250-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: fe549842-0a9b-46ce-1511-08db56f228a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: es56MJuRrNqJeqsayqiifEaNyCAChQ3KuMga79VvCuCipENq8sAOel+IuigSwjTUxJsWHfFvoEAt9ADae0Fk5wMYGob6qidYpM+AA4lti+nEMi1hORLb4Md0YCZ0lXkhW1mNOkeq/dLJXn9aryKc471pr6laZ5o1qkiP66QnMJ37Z1wGKHzODwVuVXmKBeUzmxUx4zK5vfwHCgQxyb5nH2sknEegPubG1R7CjltoRX/01e9BN/wvN3szs/h9qRKLPIV+qgsb5fD7MWcQNt/xr+57DlPyEWr+R4dl0+0gqhllVYlBAWjY7RebOIiW7rJIziUQbCkiA4WpPE2Mzzo1E1yNyN/SnJchrg/ZcsDajRiYxIiW7XPKuISV2D41znUo//hS9dCKkpR0/iOo6TAFF5uzB6v3bZXXc3LuO5xsM60TYHmrL2TlEl+O9mDyjfHePX5wVU9aAE9PNGkamDV1ExffGodw00sbAB4QNCZ7k77ScG5HaOE0XuIqwTh3ClScVBJywt0czr+sEZQFE5F44ZquY6uFYmVqET3vDYGwnIXpLTADfRStJK1E5sEdBQGeyB4e0QQzFLjBbD5VkgkLwEbCCHbiT/s8qozGq9kCB9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(966005)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(83380400001)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDdSs5TsmyJcQsSlf8LSPVDhh0db1dhcWO1E/A+mOLm8DkeJmWM0YtlhuW93?=
 =?us-ascii?Q?VtGN4xZwNB+MN/USLafREpeD6jLChYXqCuvv7iupZcQUI24qFDu/GX6B3Qyi?=
 =?us-ascii?Q?0EOWcve3deJzOGPHjVWkDKtYiPraEVlzaUopULwNFVSdxvZCybyp6/JNk08Q?=
 =?us-ascii?Q?L7VWLvRaOjoDCJmgKU6qhXHNdaDNRlQ5FBDlE2TwkBwOvHd3WB5Vh5v2lkoz?=
 =?us-ascii?Q?OMGDdwU+tY9wD8CdwEUVirm7R8/6szIxSEHoF/ybClpkTgLZmml+67KvHQum?=
 =?us-ascii?Q?VQbZ9o5TELGobysDPF8SgKjyVutrLkEtagIvD0/KAYY+8gWjSIki0uBV9fcW?=
 =?us-ascii?Q?+WpFCA65NMtaQ9KOqCqKUbong3/6e4eIV9H7wDMfT+NnnoWvz2aFEEVx3hD9?=
 =?us-ascii?Q?Olg4fRCy/QyncAianEVYYhNtm2OWxWs91U8Ej77aFx+/xwj7MFbYLxJcjiZd?=
 =?us-ascii?Q?cYZLkEPGDTQJW0vrkc7V9KgcDNlcag5SwDwncjdnPo5/3n+8+/Btotok/jcj?=
 =?us-ascii?Q?O1ct7SN5uX7QSJyM84EMO5DkFSA+Vxkj8ikgawrx8Mmuho2VoFLtbA3jgu1/?=
 =?us-ascii?Q?IiAHFbYRmJUqJXJ6u9/d4uZQYvsKy4YGGHbCIVwX1XZUh2QWaPajWrgI2Rqj?=
 =?us-ascii?Q?IIIeMwbxPDhcLEFjEdod8otObtUKk7BJcHr2Tph/sQsnE5KGReJ4NAHW/UK9?=
 =?us-ascii?Q?OQeMQkVO6dtqm7IPzDSsEolDf9NiR4r0bUDW3Jn5odBxByLCCymPKc6y50vd?=
 =?us-ascii?Q?XuDzkxIJiAvz3KeSqarvbiMlogeduKUh2znuUEHVyimRyLGjG+3CV0MIbqMm?=
 =?us-ascii?Q?DtudSNXLiEHcTSzbP5NDa+V5ApCg9sODYpa1iLAmXwSDRaV9llSI++5nkrL7?=
 =?us-ascii?Q?gpy4dyQA5XBYGCpqvSIWVgLOJ83wKNxRY2W6zQ2vnqjou0B/rTjClkA/++s8?=
 =?us-ascii?Q?+YbAYUdcKfCKu8EsEPeHTVDfp26Nbb1Jehy6UTUTpOQvBJ9gsaQRvhEKkl7G?=
 =?us-ascii?Q?FkCbJ8yLvLsgWZg6AxRMCLGhaQxNWYXSgfQ8d5AX9Ev7B+KdxwyT1QH17V9e?=
 =?us-ascii?Q?4q4VbvzriHRnuwWrUDgAMKTH48W6fLXBws0MV30xIDEv443/Nk5lJN1VVJSA?=
 =?us-ascii?Q?Ukfih0nZM8bfwCNLQ4UO0CtnMlvBQiVI1ks7B4hSf4mveTQqX3vSl6nKQeyV?=
 =?us-ascii?Q?Re8I7yODTWZpjGOzcWl/BhvIzHd2vG2yR2BocMq6Ls2dZmdZIt3oP2/OvxM/?=
 =?us-ascii?Q?WkErIDR4alOty1EeY3hkbk8BfJR5ND0X3tXidlzkTDbIy1iPQGiihzdfKV0o?=
 =?us-ascii?Q?/pbLd4HJl9hlKDzkmhbfGnozw3pWjgvGDDMzT6+gn/2CWZABGUDZXEI+nPdN?=
 =?us-ascii?Q?NIaIg0c1zCQOEgEckCHFQPfG5K/A4beqGs5VwVRswLXTemI+F6m1kqQhuHQn?=
 =?us-ascii?Q?M2FaEMcEa+W9VUePji3wuaVyaVWlAC/EiNFz6aXd8Y2eCybn8P1VvUwFzT90?=
 =?us-ascii?Q?9bbFhCggn9Au+7E9/RBSeKRr+j5ZZAIxolgWoq87FPC0REZ2KOSSSpPl031W?=
 =?us-ascii?Q?dc3BrS8p+J/AGa/PmLQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe549842-0a9b-46ce-1511-08db56f228a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:07.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH48lCoMngJVm7ErTXAOl+Q4sKsgjfqEL6MWqMl3FYbAKT7DEwtmoaGVBD+1FifsJqPfY1ulWjlU88CT2akxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry I have not realized some patches were missed at upstream kernel.
Version number continue with previous
https://lore.kernel.org/imx/ZGOCT0Mdg3Jtar6c@matsya/T/#t

Peter's Fixes:
- Bist issue
- fix corrupt package from devices when start transferring less than 20us
- fix the FSM in controller seeing the disconnection at L1 use case.

Change from v4 to v5
- Add sign off at Patch 3
- Single line to set reg5
- correct .set_mode logic

Change from v3 to v4:
- Added missed dependent patches.

Change from v2 to v3:
- add cdns prefix
Change from v1 to v2
- remove empty change before #include 
- Remove dts change from patch
- fixed dt-binding-check warning


Frank Li (2):
  phy: cadence: salvo: Add cdns,usb2-disconnect-threshold-microvolt
    property
  dt-bindings: phy: cdns,salvo: add property
    cdns,usb2-disconnect-threshold-microvolt

Peter Chen (4):
  phy: cadence: salvo: add access for USB2PHY
  phy: cadence: salvo: decrease delay value to zero for txvalid
  phy: cadence: salvo: add bist fix
  phy: cadence: salvo: add .set_mode API

 .../bindings/phy/cdns,salvo-phy.yaml          |  6 ++
 drivers/phy/cadence/phy-cadence-salvo.c       | 95 +++++++++++++++++--
 2 files changed, 93 insertions(+), 8 deletions(-)

-- 
2.34.1

