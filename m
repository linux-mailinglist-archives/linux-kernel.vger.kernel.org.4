Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09149747B56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGEB5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGEB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:57:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335E10F5;
        Tue,  4 Jul 2023 18:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC0DfOdobVz54YUDM7FL9pIvHVeyKkRYmCCfUuXSC/d/FzXIUm+0sTB7MQ2WVcK2eBcmRIh1jelYUimH/52CSRLERLW4Pni/weF81Pxn8g3/zp6d+aNbo9pE2rsaEB2U4Cc1dQLZDUuMHChrrcbn0o0Tul3mbY3ApYwE7ax4FFF8kCvBdIV2MdGi81k2+bCClqufiwYDfg9h8dAICSONPuqDGw9ItCrNKslsCfRG+vgQR3wrMETkomcMLChwA9Vk2TSe8ZOQ6cFHTZ9wjaU6feXfEg10UWgzheLac9sMnbk1F3ju6dTuQ/W1/QAHlGoGycIQ6YJphgm95NHx7iVaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=DeiWoCASMq7w68ycSIjOodWAJ7JQw6kmY6G2WOWU3LMppbxqChShFobjJX7S7zsSYlXJlM/nVNtxCIkq9+98e5eTWf59DHu66t5xdZ6pUJ7TtrB/GSICl1CPhSat8s/xxPlWUvceBrTRvBao1OQ4JqC8JK0FFW+VUBKfJ5aZ5uoSuSZUVKfIwfKhZkl4gRvD8v/0mvc3IFajLlRH5E4R7UpQ8f/jU3kI3vqaJ3atRWIocoppVnSNtMMYRY+UStOe5qvp7UUnHG74nFe8154Y4vp+hwphZOA7uybeUeyfCw+abxt++GZIYWwqy3ISrdZ08TIYFL4yGSQVExCzYasAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=gnlt5teHWZeMLK3bY7wtjGQzrIUDmkdCgs4XfHGZYOO1qNTn9PxsWLcoBN8UPbk8BtUowTHuGzm8oVA9ecjt1X4tYhanq1MPlPGI4iTFuYocl18mIs+ODxJkJf6DSoweHTW0cpWFBbLL9iQSqeXt8y8z1jHrsP1KWhLVS8+x+N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8845.eurprd04.prod.outlook.com (2603:10a6:102:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 01:57:27 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 01:57:26 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 1/3] arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for imx8dxl
Date:   Wed,  5 Jul 2023 09:56:00 +0800
Message-Id: <20230705015602.29569-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705015602.29569-1-sherry.sun@nxp.com>
References: <20230705015602.29569-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0b968d-a53f-4f5a-42e2-08db7cfb2ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKC0RnwiXwA7c1nXbDroAuCE9/HoJZVUmINgffpw0dGmZoBw8Zobued+4+r0xolzsRAteisFiGEVky1gKecOYfcXa+RMFam9d19GJeTa+f6Z5VxRglKowFa1SeJDAu6myAk6v6U5PJxU/F1eR9mxfZ4ClfyS4tEi9egPbR9I+juJt8U5SqIGZQL7X4lFeBKMpU6SXSRhXGIhxiKjVdGxaAtYSIItFZWjDEN75yuTqAYPHOfXVm1kY24PS/aQu0hBOltBeEdKoY31BMeBAmrBNPY9PYtXoHvRoJjMRKsE6JtzJlRepK9Aai9KrAMXetOYSooYZtqXlrhj3Bkop75YYkBd3yaYSYJ2fk+icF2mWuIpmN/fOJzOlVxNDP+HmeLjkw3dj2iNDjMIXNnKLElBOKKK8B84EsgmKwe8NYuOzpUGwxWL9y6EtOHbTvp6Sn4/heuDwsT8lrvxmYBYwXG3WBp+kqP4JVm3TxePTZvialMrd44NcpRhQYMb8ARmlhYl5m7oITyd+5RmWzZAxHzR2Pri8MqPcqojdY9WQWtq6wToHtKl43apfe/n+t5mP6M2QFihqEvdt9Hp25pE3EyCaUv8j76BKE4te63ACvQhZYnbbRwqa7BMDDPKG465RGb+oxpWv9bWUrKqvT1eu51aWwi/9mAJ5w2tJeAt7GlIfpqFsWS7F3Zx/5d5wv1Izwp8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6512007)(1076003)(6506007)(66476007)(316002)(4326008)(38100700002)(66946007)(38350700002)(66556008)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8936002)(8676002)(52116002)(44832011)(36756003)(5660300002)(7416002)(86362001)(6486002)(41300700001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MG6n38hZX0kLkMO9epSq9E36lpIe4NqBr2Jnb4fcRGYHjakIyJJgleAJTXpO?=
 =?us-ascii?Q?9OSJGlwx1VAf051Na0S7ClWSDgs0pKJvC2+tN9I04PJGZlR/NfaHdJiAaBeH?=
 =?us-ascii?Q?njpufHMFJvrYVnh9U3wBe5qbOEHByiZ2xecR9cUSJlD6rFe9bHqjaxd1ODbc?=
 =?us-ascii?Q?vPN0bqk7GhVCDG0DBNXgs8vFBbPtpgOqdXf3G3m9T2G73itu4faHumHYNhms?=
 =?us-ascii?Q?/Er8Zm5Wr6nyQ9VwfBjSZ0urLL8EL6Sz31QEQk6lIYK3/50DM3wACb6anZ+G?=
 =?us-ascii?Q?B6SmVcYZoLUqsbYmxm1uH1OmtiLtCc0JDsBUPoEtiICIyO8SJuSklxmTVNsG?=
 =?us-ascii?Q?PbeRCLDYDqZUx9EvovaS9wgAZnB4VvZY8T68q/QQ+STJTt6IrTOVZQ09XkJw?=
 =?us-ascii?Q?9M/lP5Rkjbs9WGRQkjgR66DUQW7f++oHHSqB3uilhTwc4uNjOPsOHDy7RZUu?=
 =?us-ascii?Q?ZkGXOSTeKy4kwKdzgAE7iGbX1sNkWa8C/GTyKF5pnib5cYg4pGCPBGuWpjMX?=
 =?us-ascii?Q?IuZVssYPDlKzNzRdCiV7AWC8ctPFGGzGEXzz/+M9kf4+GsiRxiAfdHxpUfmw?=
 =?us-ascii?Q?Ay9QrN366ocq66x0DYhgaTWgv0wcj+3Fijf3wO1q4or5tG6eqSTPQ9QsZPB/?=
 =?us-ascii?Q?avy5gJfBX9dkZNMbFvfkqKBhXrK0iRKMk2gDqf1iFcBpUeIMajxdY0krwaEW?=
 =?us-ascii?Q?zIKfS9MzImFhdv0jsaj3+UApwi8/Slmr6TOrJC5meeUi+MjffZ6OB4mabo/m?=
 =?us-ascii?Q?qTsOJC2CRZW5sdyzoBDDQ57OBeM35QNYQvCNXuz6xHT0wKH1pLQEEXwDr165?=
 =?us-ascii?Q?B5BwGUXY/PDxYOmt+JqbqD2kei226DszkOptd46Rw6n5S7fQr9kv6smA0q6K?=
 =?us-ascii?Q?VA43c9KpqAsEZ7asQQ5wwTL3DKD74nAG8P46Z23nR1ACOqLjayWm8Zblf3pg?=
 =?us-ascii?Q?6+euQXkEDsZuIog1VM5xb2LP3z74Vpk7FWWARkczVWJ/N5nI0qwZU+jOroFW?=
 =?us-ascii?Q?sVsjU888sWJmqk7Uza8JYjvJjRG6CLueTLpAEAmBFbPPq33D36HVaKgT6TmD?=
 =?us-ascii?Q?AtuC7440RWqHLZ3oDzWefLU4+YhqCfWrxwiW25hdWvMofuUCVG5xADRz90xe?=
 =?us-ascii?Q?x3EKGsMkKXBiPrN9ObD6v1ONzpPPJSUlTdtis8FFUxxii5ny4mBrxiDf0Ve8?=
 =?us-ascii?Q?nFOx9P7Iuj5DcCa7+Lz1GzickRXNXx6gmkdDYo5cduxqLRVSAJ6JZsWLW9w8?=
 =?us-ascii?Q?vDzSh/40lUsKOdx+61jVMZPPNtORG9eqDYDSoG86y2WpKtuksxgzIm9SrU41?=
 =?us-ascii?Q?dntd9xv6oKBVr109feapNUH5Ih/cMRZiiVgppb5fHEdIbLXjcdMiAu35v2Ag?=
 =?us-ascii?Q?m8e7kdVh5EuzOktGSZjGAMNhizdCqBCybYXkAwmDaK38MBPjPA0fcTPGA0Qh?=
 =?us-ascii?Q?WLg6arr8AWy5wspeZLD68jocSZ+2IasUFC2XST2Eko8OSgTqf2Odw/mY6dS3?=
 =?us-ascii?Q?LR3TprQHUz9zjcKgXuLAInctLO7vSlQRrCK4/PpAYMtJ+EG+oa5cE1uOG4yo?=
 =?us-ascii?Q?paO7PMEMj5ovq+DI+0s0VWzmaCfdU/BOstyNpnSh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0b968d-a53f-4f5a-42e2-08db7cfb2ecc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 01:57:26.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQr0yyAdVT7jrf00SMMowDiUwSKSVnvo4UVChQ8CmaBEExsWGALAnox793e/1rpnDMeqUGZT1RChzpjhaW+n/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the i.MX8DXL backwards compatibility with i.MX7ULP since they
differ from clocks handling point of view.

dtbs_check has the following warnings:
linux-next/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a060000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
        'fsl,imx93-lpuart' was expected
        'fsl,imx8qxp-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
        'fsl,imxrt1050-lpuart' was expected
        'fsl,imx8ulp-lpuart' was expected
        'fsl,imx8qxp-lpuart' was expected
        'fsl,imxrt1170-lpuart' was expected
        From schema: linux-next/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 6881330ab4c6..e2eeddf38aa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -36,22 +36,22 @@
 };
 
 &lpuart0 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart1 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart2 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart3 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-- 
2.17.1

