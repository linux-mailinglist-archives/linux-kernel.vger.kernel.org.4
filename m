Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E965E8B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjAEKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAEKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:18:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B93D9EC;
        Thu,  5 Jan 2023 02:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwYVKzvX+qlewVlf6IMpHcz6Rf08XM+op4MormX1I8osMSRS5jjfus5bxn2pNnvo1GCZdyfSq2j4Q0J041KrdhvRQtxEwHfUtZrif5n14QmHybYEspYQqbfqqb6VMYLcZ+UnPgVLkY6ihYVcEhUVCsilPB30e27seKoA97jrlRIKnfeX+EvLg9CqBQ79FHVDGr1q7N3HvM3p+6wz9TxE6Rxre8zMUBOyeeEfGP2ETZkTXJbUg7qQrIkxdqvbdz2GNSq+hlB/DYnBRnHEMidWIEOLMbQWGCpZjnNP5e3t1NHo9beTCUFIJePg5imUhXneCUQfTBB8TwnmsD3HfSMREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iYPWfHnIZxElIquFKJ9V5VgJyv6/nmMPFNem29MP8k=;
 b=lpHurRuwKUf2kQqSM0iVKZOwmgVpr8ObsOA5lfEUJ3x7VssfxedzgoYSvvUs8i8Ov8LAGz898/qNETgz1jTswHYy7ILfpVI8YW8I2Nl7/xmPuTwBBiqhxREEsM/SRdzbhrJzxogWy7s7P2IvYTUD59097m5RnuPVjLdaF4gsKZpbI71Mda/1MCPUPLGCTdi6ZgpEftuZd4Ff95d8MroV4SGfnPGoWC56zTC97ofnU2NZ9A6U3SQoZcd/Mx2oTHwjl7fEGVcGyn/NWAkMu02cukg83C7TmV2vF62LrWszfMiUjY8tzeEuwFXrCFjwiPw5n6xBusj9A5VrUPW3ZlZ4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iYPWfHnIZxElIquFKJ9V5VgJyv6/nmMPFNem29MP8k=;
 b=B2/euzMNr549KmPSSy3PcH1uPbUZvIpPrLjdM+/mP0kffdcUb58xR8iavoyjcUEL9M6RX8GOUWUO8ifLAqHeHPiaa0DXx50KOfXOGmyIF5iUkGglT3WhNRcw2LnA9ShJ6N9Ao+QVPIqQKS1xKPpbM0iBajxJL2gRJFHScRAw6To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM9PR04MB7699.eurprd04.prod.outlook.com (2603:10a6:20b:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:18:30 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:18:30 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 0/4] add i.MX93 TMU support
Date:   Thu,  5 Jan 2023 18:17:44 +0800
Message-Id: <20230105101748.6714-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|AM9PR04MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: badea4f5-2804-4678-b719-08daef063160
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dGT9cceGvPid8qN1bWw7TPLVscylQistU6CdJM9dDn+SZW7B+lkEfUCwCkAP3TGVcwAMr8FlJiDVi2eTjEVvP0nuQO5LYRKj497gqqpIp3CSFriAuxi/ABxKPF0xNY7mIAErDnHsX44YJwbv57eBxu0mAJ7S+tYwcSTLqIwfwfML4jbhBSlqazVPUsCWNyqTeBldYxT3fCQLXdFvRoQ7hPYew4ivd4577Qqptmm1vJ5o26XnpHddHILsanmtsWWDNPi+QTaBsmvjbLjZKfAd/nibANDuF66xNT3EHlaAguCKmwYfbH/UbwR15be3UpWuDLqUnlohv28HPsaxe6FqdHwZ5xDxomOLeebHfazt8l9kzIjuRq18N+Y2wt26RJcxyTAjCZwPnbR/RyPO+JTcyIGsLEeHMNqWqkPJZDawgBJz/vSVrN/FhT9ZuN9BKi1L2xWhlCH3oMMAp8xnRxBUnRuPB2q95RkedLLL9gv9p9pNmXPv4mCDVlvJVrxnr/BtJ9+nNsMPiR+EqZUn/+7pS9XU4+BlPz6c0ZbzLbso6RUL18DkVy3ETOc7xgVM5uVBikrXtDkECzvEQoOLVkjmTV/uIj415u9NyuG7eFQGqVje1tXAi8RJ76d2zMMQDx7qWZ1+wAUTzWeG4zTbAzYgacDnj7XACXjuaFVdZVU/6Mv9APtHO7FYa8yKAcfTZ/xuNSk5BH/+N7yAw9tNPYmXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(83380400001)(6512007)(186003)(26005)(6506007)(6666004)(86362001)(1076003)(2616005)(38350700002)(38100700002)(8676002)(4326008)(8936002)(7416002)(41300700001)(4744005)(5660300002)(2906002)(52116002)(6486002)(478600001)(66946007)(316002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7A3MOOZIl7NNfTdxcWj3VKAhY50uEhL48DxGSgv2tYZpBDXixaCbXDXYBDRR?=
 =?us-ascii?Q?VXNZKTokUtxhXJHCgZgWeKbWb4M5nd4rkXdTTk/fw0niWD3VxxhpZHoca4zG?=
 =?us-ascii?Q?gbivS7tidO1Yq+TKApeY6zWH+BCbIcWgkW130UIdvEYZvJ1M3YwkpmX13+Kv?=
 =?us-ascii?Q?nLDssuM0G7oTCuOuUV646d2h98uuuGH1ZRBKiC5b+MxV41Rn0EkeqApDj73S?=
 =?us-ascii?Q?9hncpiMLT9hNb82/PnQ9XEwXal3P+vNm00P6pYKNNbOnWHIhWejz3z9P/UTC?=
 =?us-ascii?Q?4DHG+HyLSn6pqahavYJcVa+EFatKG/5UCVOFbP8sanf7GX0DxiFBZRqyXxoQ?=
 =?us-ascii?Q?9zrCGsnIw0Zm7rMh2CunZSpMd9ynydU58dCxbviv3F+Ia4nzAC2piRnGpvPZ?=
 =?us-ascii?Q?SfmGh2WamZiJhTo4IYIT2TpBM6kMnCpQZ2/Ux+VQEYe3eVCO+PLMnT+8MaDY?=
 =?us-ascii?Q?9w19k3wogZnXRPcFrMI2w5UMM53X/uf93kFdFUyPhgoyFD0+i9UTtNSA02Y5?=
 =?us-ascii?Q?ZPcydU6y+hGvoBq6a/l9086rmZf6RiQikxQPL1fbMR8robH/nXfE4/e5XGPa?=
 =?us-ascii?Q?dQLKYOdQSHpFLale2YRrOto/DELN4teZglJIw1OQkJVeTot6vMxRR6I5MJbD?=
 =?us-ascii?Q?JjmErLvf1DsjWm4sJ826UPw1nMFC6/GROMDjH7BmNqtqQ5d+iG1c8kPduRz2?=
 =?us-ascii?Q?98VnzLE81C/iPw+Bs6wzs62ucquUSQsAQhSa720HMNT3vuHztzWjSkU/0bMN?=
 =?us-ascii?Q?ZZMDRJAUHJXnO5dzG90Chk5tdhaq3oZWQJavzpY+8TkOHRaiUCC0N8cl/Fyr?=
 =?us-ascii?Q?x1cQEXZDMtHIkahzhsjdJUBPcj2Lo4OZi17dKfvanPvKy9C425Lwi8tk8zaW?=
 =?us-ascii?Q?eonyZYlxcaCVKVIXDtMqkOLhbTJVyEzhdHfxwYmuvJuUHkOXGW2Ej0UeMEnJ?=
 =?us-ascii?Q?cmZ4x5wdYOM/rX92Y+tNgfXVSUn8wSyBgOoAlhJ/Ty48RR4iLXRDZFV5kuEK?=
 =?us-ascii?Q?A8TqjK7dSj8CF+CRKV/rEEqK6vq7Dys9PH44e7lTpzYpQ3pQHhEoM7kxkFYY?=
 =?us-ascii?Q?wVw+4ZSASqM+n72Qiy8p4hAtTuLIFZVYsN7emhX6hClg4cB6ryuTW8BBdpRC?=
 =?us-ascii?Q?s6QUJfI0s5RTDBx0WNpLSVTXcRjpAeygMtyIXpWdUgvnHCy6WW1PnAv1Drdc?=
 =?us-ascii?Q?GnZaUyqUiVUQRzJoIydP1lYIY+29hiFJ0xFD213SHtER8Drma2Keo4+wvEe1?=
 =?us-ascii?Q?tiHxCpTcFFuVYcvwSqL6rYe4m80h3l0PvCWhSOJ461EbiLmaUJsfAGLXunAs?=
 =?us-ascii?Q?wPKk9kQ/qrEPlArs4ygleLvwDWQq2xDe3dilwpawA5/9BunjKa3yKGFPD+7R?=
 =?us-ascii?Q?4ubwcgm3Aag5P9PfERBK+GrByPK0HoHek4LW1g0Qdowd0WVLYQ1PJItszUo2?=
 =?us-ascii?Q?kQSt/s/IJKsyF56cXxy0iy+TFLnFIYK1URcvnDoKiYyjAq12FV3bgX/qS3lz?=
 =?us-ascii?Q?oBTE4eGBxMlw9qCTW+biXCQHSzYbBfkz+y6zF6kW0K7iccNxvucS6e2ifJzu?=
 =?us-ascii?Q?f0NtqI1RpHLNqsnIJjCmjmrAzK0NZgVWOVMO1A2n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badea4f5-2804-4678-b719-08daef063160
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:18:30.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8M6ThgEBov80+L12S4j9jgykHofCa639HQHnmZ/arjxWYOl3JoGvPQOwxSaKXbfyrS7L9mAOkdqa3dr40YPh3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7699
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Alice Guo (3):
  dt-bindings: thermal: qoriq-thermal: Add compatible for i.MX93
  thermal: qoriq: add i.MX93 TMU support
  arm64: dts: imx93: Add CPU thermal zone

Pankit Garg (1):
  qoriq_thermal: No need to program site adjustment register

 .../bindings/thermal/qoriq-thermal.yaml       |  1 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 48 +++++++++++++++
 drivers/thermal/qoriq_thermal.c               | 59 ++++++++++++++++---
 3 files changed, 100 insertions(+), 8 deletions(-)

-- 
2.17.1

