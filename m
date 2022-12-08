Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1AC6472AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiLHPSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLHPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:17:49 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D699B29C;
        Thu,  8 Dec 2022 07:15:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcqoCOw6M8G6DxzZYlJHrAkXkhgtoArxrPTnxZLLGRjW1cTQL2Mp/MiLu6KW5Kqe1U03eOCKtDL+nNEnc9kTnouX/WaviZAh0z5yTGzB/7uW3S5u4n1a5a6mE/TeR/FajBJVQgUHkB1wOETINTjH4N6pXKk3ytp1DiS5YbgKXZYlQZyFYI6qcTdZbED/lAUxe4WTlThOvFnDB+msFTQ/pSZGQlGZ8Aj4veR7x1Q8bio1pC2LkEoTmd+gRGU+pprjgVliYLa+3qRPx4O7VEH7fqL+vo5i8cMhXMthNxvFrCugt1saj3OCttci+DQcr0Y7E1oZq4S7pxD0F8LZFbHObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfB0hF8xj5xSy45sSCvyNvucOad/YqfjphkS6J56NhY=;
 b=oPWPWtTGPKbvJGYpFQO49Z/070FZiThIK/bOyOTHI84wR+500R1CmqJp6TvA1klBR0x0sYKSAt1VMYC668SorP66hrRmCOfXbttHo3WTqr4u3KNt4xAqraNKcao+DIXAqclix+ods7KdNPc/DM6dtVYvLxvNTq8HM4Kbnsu9EcNZBq5tHHmCOnOzmlRtDXNS6gp3NUCurO273AyZK5yj0oSnTZinxvF1/C1uckk19iKkWK4KxoqxcG/j24UVQeeFBwyfg4YvkvtysIfUlWgTHYRIH6Xbo70yBnnEJ2A2qzd/pg6Hgo9mCf5yEQBMnMkTdptOIzFMyRlk0ByNx4K4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfB0hF8xj5xSy45sSCvyNvucOad/YqfjphkS6J56NhY=;
 b=nZhYsTRkG/93nZmBNouWbPjzH59p93yzHwKldTlnAs8W2KOJqGuFfvgW6mB95gdT2BfMsT19nBKsbCSAJFcuq2Q6foXXdFDIBWXwsK+XcCAlfiEEQYCpl2yRbXzEoKsSkKE+iA5FX6gQDnWWFvzWw33pKEjcYk+Lt829mDkGyiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM0PR04MB6961.eurprd04.prod.outlook.com (2603:10a6:208:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 8 Dec
 2022 15:15:34 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 15:15:34 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, iommu@lists.linux.dev
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Date:   Thu,  8 Dec 2022 17:15:14 +0200
Message-Id: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::37) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM0PR04MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ce40fc-2661-469c-ad3f-08dad92f0d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSdjvIS8GKY73MzPot8K3qFJffhLGvpTIcXvUBsgqfg79j0X8oQk/yHPhRrYY9tqZSGyRF56bO8s6LXLXqEL8gBk22lrFaHMQ8hAYwGGjt3c3hxCyH3CaJ3b0TsGfpnpe+L4FSOa22PsNa6aIo5ozh6XlBUSY1OoxI4AZXyeydcDIaGbBti1qhU5nNBw+5O2in2R64UCXsLLDFmsY1mwTDNnWhw9PxL2/iSD27vMytR/U8AtWNg0rdemL4ogHwNN09e6EpJk3bP165ebE+ID6OUbYqJFLgM1aWO11qT+3FhxQgFWQzKI5L/4oF+wBzxa4cbZhfksiMaG6ZO6rqGF3hLFPqSTL3aAw6FanIeRfAVIrxdnfj0JP26orTlfmdccOg+sa3ds6TKyT3ByzlXpB2/qsqRMznnWxhI2akf7aoLK/MInUx09kGQy05IzXRXBSQXFfemFPFq0aUm1sP8PqIMyPr2H9IHFCj6DEgYHc8+zHQRv5X3uNj3Vzi64Gr00xSFCRTLARw0e0o6R9A0E6lzhfmix7GCBMuJfv5TChEXEDJtRv2DPrqk7QaN6x9410xZI1EVax1V8okKP6B/7X8aW0i4ZXnl0lzvTkVVTlulApGZP0sGzN7fFmDLbomYr5qbzctUKQZiOf6Jgql3jVTxeAnkPcpQmIewly2wSXOZiR3//cbsT6IG5k/dFm803PaICWnpWlgecaxeQ1X0Vgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(6486002)(6666004)(478600001)(6506007)(52116002)(26005)(6512007)(66946007)(316002)(54906003)(66556008)(4326008)(66476007)(8676002)(1076003)(44832011)(186003)(83380400001)(2906002)(41300700001)(38350700002)(38100700002)(2616005)(36756003)(86362001)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhV0LlYPnc604XmEG1eD3vCYEX2bqAbxJJJCtRnCVuCay1AxdtGg9DcVsI1z?=
 =?us-ascii?Q?zDASL07YCahxfj9RQWn738BEGfCIZReAD+//DJF0nuxWU4mCK/k1esioCXrN?=
 =?us-ascii?Q?UlopUf1ZauEaaEcd5dzSbTKokLzwg9WJ154FEOM/gwo5cJ5NsdL9pgHfkV08?=
 =?us-ascii?Q?5YyYp1XZuSWOsGoVF3+XJbGuV8WyDY+FHQKhKkuwSz4WjSjP/XJtsXyMdb8K?=
 =?us-ascii?Q?6NeaEmUDk7L/1D4spvhgGh6eaD2DwshpPJMikFBShzWBdVWYGisvgK9I7Puu?=
 =?us-ascii?Q?fwNqwvZoyyoABckzRXlu0a2ruO+Dyd/QhgDuKnkAM2+eYI1TrXDvm4EJs34C?=
 =?us-ascii?Q?aGBxpdnThYwDvggwKhVD0maCD7WAE/XWQYOWcs9Xx5IPtqSdXMBmHfV5yASi?=
 =?us-ascii?Q?UzxqoFG2I0tmAAue4rhoZcETwjfv50OJw3AOUql6N6yzVrsjzdfGgPQeZtcn?=
 =?us-ascii?Q?whs8zv0GVSgcSDQZMdaJ3OzZlPAFU8RkPgMMa4bEigmyPOLUpIQsVvM4NfcU?=
 =?us-ascii?Q?eUkxUOb6fFSjdN/VZOQF3F/3t9eaXR0KuG3YHgq3Tn5lrZd2MLtc9NvwEuVU?=
 =?us-ascii?Q?aY1m8t/5qqMY2SQwFOFK/UAOYVVhqLbmHxmZ6kj3UOU3IMPYqHAlT9TY8eU+?=
 =?us-ascii?Q?ZXzHNN6WczhGG2cf0QZo2U7migmPy5Qu+ooWl5wbdjnAgp8LEN+AhvLUdSMV?=
 =?us-ascii?Q?7dIdpEAhodT0Yf7kHfraIFlWlr7x7GcyeSSBUzQnfC2isiMIusWXifiBweSm?=
 =?us-ascii?Q?T7tD7+3jdfF/tkSmzRLU/DytUBeJyUhNM+IzNajnj3HanzLp9Uephm1hY0Xw?=
 =?us-ascii?Q?00Osu/QAHQ3moj1Auo+4KeV8kN6A0K6LG4jd74AmpuKefRiRrvL6vxASIqJA?=
 =?us-ascii?Q?Zowdm2gkeu3vomAT4zBHKQgZqT+mdDefENp+MNbIz8+uRbczbXEsVhjYMBcY?=
 =?us-ascii?Q?r7gSNuy9ucd4+cusxoLPV6y+v8HpKqY1AWxLj/ao8W6GtStuHzHZpeq0n+CI?=
 =?us-ascii?Q?J4HzZoftJaaIXHmaRnbExkMQ+BfrW431rwi0UqObzwXhluy41EJLPppTRyuT?=
 =?us-ascii?Q?TiJDDnzUJnMLfviAGALmx7fF+gxBfP11ldzXXNKFFMMCHQtImdjew0X6EqTT?=
 =?us-ascii?Q?nIn4Hcy9vVZsyw8kFHHi2GFffUSczHorJF8owWyNDmiUwxG+Z3hvsvSqbTIF?=
 =?us-ascii?Q?6Guxx6PvmU7Br8ibP7RcvqI5fB0UppSkwJClUSAjzppII6U+mfCPBDOd9MJt?=
 =?us-ascii?Q?VPmli52UMsR9wRrhdH0OQEV3aTz5dOOsSgPMG773ENSWfJC2hDtvPMHkKqPM?=
 =?us-ascii?Q?MnS2/O6NLrG89QeRVd7C2lLBD+OKd3Jra9SgfBkpfoxwMocXxWG3knL7BIxd?=
 =?us-ascii?Q?5Qx6KQeIfuD1h3P/6O+5yh9sidT7UAL7IW0hzUkUoAtSV5MHuYKwBBSK9oel?=
 =?us-ascii?Q?9vpZEiNQ2bD8TDe7Y8b1e2TDwawDljzWwNnDuuH2FXvUNQcWdO5tfHzb7O1w?=
 =?us-ascii?Q?GPeEFBU3azvDaPFw8kSATctjDkBz8TBbgFhU+eYbYlvYLtrzvZeTXQbatmhG?=
 =?us-ascii?Q?H0fBearxIrV9SnuJoN7isqHHYSokfUwiFnA9BsxzG6+GfZLfeG5KbOJRnK/B?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ce40fc-2661-469c-ad3f-08dad92f0d90
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:15:34.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wX5X+rKRdsE75FzdbgxeonAd1T82UIoPLPCG9OY3dzrUUvKRIJb/Apgx36q/rZqB2x9qFeAOAEmLrM52mjeLHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit df198b37e72c ("iommu/arm-smmu: Report
IOMMU_CAP_CACHE_COHERENCY better"), the SMMU driver will say that a
device has the IOMMU_CAP_CACHE_COHERENCY capability if the
ARM_SMMU_FEAT_COHERENT_WALK bit was set in smmu->features.

This breaks vfio-pci, as can be seen below:

$ echo 0000:00:00.0 > /sys/bus/pci/drivers/fsl_enetc/unbind
$ echo vfio-pci > /sys/bus/pci/devices/0000\:00\:00.0/driver_override
$ echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
[   25.261941] vfio-pci 0000:00:00.0: arm_smmu_capable: smmu features 0xe9e
[   25.268877] vfio-pci 0000:00:00.0: vfio_group_find_or_alloc: device_iommu_capable() returned false
[   25.279271] vfio-pci 0000:00:00.0: vfio_pci_core_register_device: failed to register group dev: -EINVAL
[   25.301377] vfio-pci: probe of 0000:00:00.0 failed with error -22

The ARM_SMMU_FEAT_COHERENT_WALK feature is set in
arm_smmu_device_dt_probe() if the OF node of the SMMU device was set as
dma-coherent. In the case of LS1028A, it wasn't.

Fix that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
The LS1028A is not the only SoC affected by this, it seems.
fsl-ls1088a.dtsi seems to be in the same situation where vfio-pci worked
before. There are also other SoCs which don't have dma-coherent in the
iommu node. There's also something I don't quite like about this patch
technically introducing a regression which requires a device tree update.

Can something different be done about that, or are LS1028A/LS1088A
simply to blame because of breaching the dt-bindings contract, and in
that case, I'll have to suck it up, put a Fixes tag here, write another
patch for LS1088A, and resend?

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 383829ec7be7..bcce189c7a0a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -715,6 +715,7 @@ smmu: iommu@5000000 {
 			#global-interrupts = <8>;
 			#iommu-cells = <1>;
 			stream-match-mask = <0x7c00>;
+			dma-coherent;
 			/* global secure fault */
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
 			/* combined secure interrupt */
-- 
2.34.1

