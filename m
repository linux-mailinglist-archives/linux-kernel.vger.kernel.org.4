Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4E65CAB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjADAYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjADAYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:33 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF5314025;
        Tue,  3 Jan 2023 16:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/1/vmz8bJiap4wrYVksjpsyy/XB1b+kkYZtmrqPD6d/8xyEYslt21m1MQOU2kFzz1Nq0mBknLiPzkJ/7CfSYo4hJ2tWmGb65lb1MZsMkULM6xrNy0EGm813iCQqt2mKJb6VjhwzG9ukkdKo44mAIdp2OzudNHLdsAQVYkZ4f/bNblNbUL4V5hFYx7lediq1wPNTrLZm5TWSauPfV3x6LZ7081anv+W0zueL/zR9yALgo0v1YdmaeAQ8DYUKDjkXmfIObJXJldso7kRN6lw+bUbxhoDMHqSE5+EOF1evkBLjm56TY47JSzr4saSMLRm8PieBmQhuDEOYGywLAKtl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puI4hqymhHA7MnClEURezeoo/bt+gGNTTqDpsDbM4fo=;
 b=jLj6TJ4EaS+DmJdPhDSxXIUMQR1GBBQpMhkyPQW84wqVBRtpDoZQlXdQ85HrlF8WQM/ALrL5U0jQhrJeq2yTXS7IiHNZXW+ANHm8AEHbPIKDVFg76EFqX3CMC8hfsEuNBhuuBxyoKgL5fjNtzFdQeHDDpD6JtmiGLv1PM0lYvXfGFT639qykWu5pudRd8chJzku/WYxxx49WmQoQV35A12ezeEskNB+S8V5AdXmj9OEXgoaCggapy9jv0LCBSzp7zVylk0oKkpwG1NtDCpeYQg8B/4xy0BwvdUMiPoVpjJMnnDfL5MIC0e/RrO8AgzbRqc6tZa397tqKgG1AsZsItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puI4hqymhHA7MnClEURezeoo/bt+gGNTTqDpsDbM4fo=;
 b=P9e2vosJRMMj+2fCADfnC8fv2fDVuOeNrhvKVbHo4EfMRtRFMXtVJyZYapr5gj2FTeSvF2byqqmj2ln8NhJnAhvW3PlcYtaRTUcuYgrSFdTCMu9EHt9CDn76B4EWlkkcMsdPdAQAgKOEfyuYNx+VY9Y1wpavwlhPTEWkjiSW5Hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/5] binding: imx8m: add IOMUXC GPR
Date:   Wed,  4 Jan 2023 08:25:40 +0800
Message-Id: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: cada71ac-b493-4c49-e292-08daedea0b17
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU8GyewPOKO0ZTrAfJdv2igaiVqgKSB9Rb5BB5BbHbWFUWsZLZwwKfX5WWCanneeTaWQJjnCVfL9GakxeJH8NPRa5xbTbgI0nC7bJInF2opVX3q0uf/Ra9fk+dPllhoUnG8H2eK1fyN5E8QJjv+Sclk74sR+lcSb8OS7cCQBJwsS8ownZPajPHmirvyKe06wAV9NIXCvl5GKgedtf+ShrLGEzOBwkpERFzes4PfapAm8aO0f/mVlnBTVmvBSkFNepJ5zLjaf/usxgCyKrzBZG+M8ASRu98XG7aoElfjlOzPmuPKsm7HjIhke4yOUYKjOsbWuRqmtHHadTGKFwraGRLGD6lu3oNF+ikOBApZCEtKSzBqEjZlNkqiCyXu2CxwYioLjNywaJb3REBZdj8IBwAIpJQo1Qr9/NBiMZhMu1uu+fXvDMBjgKBB30NgRtGu9dceR9QpQe/kubKzVAYb9/+xCq584rIUg6A01/MdLKEshipll5+j73yM/ngEjeG3i1ihhtp2zwfWQKd7yj5qLe/veMPuondu1ysXivgl3mBYMRNawdi1+48000pe+P1RIUo0fPUdGKi1CHbZGKVPFBhxZZvcRjAeoGNvRt/ojHlVUxqExIfBeJ55BHRdMS9qBHxwRvnFYlqUiO5JTDpPfuIUFazB8JUOOJH0l2PQMxxtOtsz2EwLuJgvxPTaZhUhgFC2ZVQphph/KTmPl+Wnt0beY6o3AFZM26R2cK0EbhjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(186003)(6512007)(83380400001)(1076003)(2616005)(86362001)(38100700002)(38350700002)(2906002)(316002)(4326008)(66946007)(41300700001)(4744005)(8936002)(5660300002)(8676002)(66476007)(6666004)(478600001)(66556008)(6486002)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJSgDiHxsr26a1OYVLhaiRHgba7X9JO9F16wEUi7nuKIC7SLVf63+9mQ0GZd?=
 =?us-ascii?Q?m3LxgywBkbkisjITqf7FHL626q/LkZHjeGOoOR/JgpVOggFRsf4e/H99rXdz?=
 =?us-ascii?Q?ZTGJT3r33FCVFc3cWO4O1k8AKiavLELSNUVecgqxV1z8bGvjU6KqVG5GdvXD?=
 =?us-ascii?Q?47k2v0Syku1QhKH4b7Hv5SKYJuHJFAoyzsi1iEuM1OEOOU04kl7Ya+LXRyu8?=
 =?us-ascii?Q?wrRtHfbA0CtndUQJ1P+LbaF6oCNe2Ki6STF9zB3pAQoogVI2SXz4E5P9VZjy?=
 =?us-ascii?Q?yPEqfK837ZknE/c3Xo3GOnotDUKM0uzXrow51L+5qr6G8LYuVSA1A+OQyrYX?=
 =?us-ascii?Q?NQSOmTrYZJYiQ7hsqzj/4SVotulSfNlctuAuwILIaH6akW+p7PPjCoG6Hck2?=
 =?us-ascii?Q?Y2tthDOjqRz3LY8LpmrKnOo+bjddeLhoCAK+2VG+rMnzrAPX/i41LyHk1U8z?=
 =?us-ascii?Q?aTz9EuwrLh53ixhfRR7ikDLW/qyEf2TH/FSgTKfo1pEnTOLaERlQfGihFLq3?=
 =?us-ascii?Q?Pfkbt+VVGQa/fVRAIuuSXGTvlkpJvRPaLa4WVRIem6PQMhPsjnnfdccUpDJv?=
 =?us-ascii?Q?JBFvn/NOozzKQZi58C/qFjDX+zhxe+DhYghTT287x726I+mIbRoDQqUNx5vQ?=
 =?us-ascii?Q?yfttXAhrOVbcdbZg+K2wXnYBDBVIu3REQzSPimHMkQJ8VH3trwArX0P6Mqn1?=
 =?us-ascii?Q?W4m1WaxK4FCu1UeJr6c27/SHslsOmbEtEN/r2IroZ2TGh5wqnB3M6QchfI3h?=
 =?us-ascii?Q?sTe5a7aKaD88s5Q72jpCz9FGIDMjQ8rx0uOCbCXucr7VDCuev9HD0mbLkGoS?=
 =?us-ascii?Q?Ld7BGmSSdv86yShTpCBMzi/ualmD+ALZOyuA4+U+QKOiu1ZX+jsmyc6vZwVe?=
 =?us-ascii?Q?ANy+wSzQNV7wBgYBCZUk4WnAIntgvPvQ6ky2BeZRJO8Q3DGsvrBnlX97GFcR?=
 =?us-ascii?Q?aw3ahyQbhMHUzVL6f36Yf12wErXdcloe5y+aDLjopgpFvFagWdNfAudiZcSH?=
 =?us-ascii?Q?fFdqVbYFjUyXxMkAph6sgKVTE1/PKUgELWq5Wud4I3z0fhx5pO/+MXmMw+8m?=
 =?us-ascii?Q?tKgqypAJah9v61OeVpLVb/TMqtCZqEWHdPsV2Hu1H6YBG7RMMJoGPTSnzdhM?=
 =?us-ascii?Q?OJubLCBw3/J/5MDq6qvuiny2r/iQn2LXYoxp3mQcnOA4KOxmD9U6oH3eQGMx?=
 =?us-ascii?Q?Bb9B28nLkRNaYU0AGgych+/s527VT8AYbD1ZcwoYDW20A+Q0iO9lUTqXXqau?=
 =?us-ascii?Q?iK2mUMGtlSvJvK48l1IQiRJ8SXEYtOUN/P/vZTl8VUNhX+42PkAGlrrZ3Q6+?=
 =?us-ascii?Q?4ZWVgzbUmR+PuyTcbuAnwBUXLU2sLU5DQnPwLwq9RT67lk+P7qURi2EwpO6n?=
 =?us-ascii?Q?UBJEv3BCEWKdNOv5MRqLWByChFNvJmr+hVMx06boU+2uxPpe10gZlbhpmtg5?=
 =?us-ascii?Q?gMUo8mFK0ucBx37THQzvUGtbikpjfqsJ+fAj90MksN50Vh3RiK8wXMA7tfQd?=
 =?us-ascii?Q?yxB/SCSA+6bkplGgPLuGLElzXO4iu8vNXH/dato8tinwgulv4Hn8gqXTClIb?=
 =?us-ascii?Q?dTBOlTBdbQf/sK5nQbCuWEvt3Ov0uuw4msT+5FcU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cada71ac-b493-4c49-e292-08daedea0b17
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:24:29.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eECoi09v6nBjcgzPS9vZjBWhVjV7srfZnzMZ6MRL6Ea61NI5hhiwAEL5x4jlqwAfxeVTTzs+rDMmLNnxlrxNAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Update nodename to syscon in patch 3
 Add A-b/R-b tag

Add binding doc for i.MX8M, update dts to match binding doc.
This is effort for ARM System-Ready 2.0 certification

Peng Fan (5):
  dt-bindings: soc: imx: add IOMUXC GPR support
  arm64: dts: imx8mq: correct iomuxc-gpr compatible
  arm64: dts: imx8mm: correct iomuxc-gpr compatible
  arm64: dts: imx8mn: update iomuxc-gpr node name
  arm64: dts: imx8mp: use syscon for iomuxc-gpr

 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  | 57 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  4 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  3 +-
 5 files changed, 62 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml

-- 
2.37.1

