Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903217031B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbjEOPho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbjEOPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:37:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF51E56;
        Mon, 15 May 2023 08:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1HxOWabSo12mbIjH0ymhZyRFl1ztx+zbMVcKdalvg25gwouJZLJhadCBYRB1psgP0wnivD6lzyuhBAf8hCqwz3nBhrzzLRbZ8QMgm0sCbTu+AOoXxNjmpn8iF70ROJMw9bwuMbT8GXfikcz+heSCvq3Y+awyyGNwcKOIkWm6t96oYaSTzQR265tLshmHg/ECXl2HV70BF5qdt5MGJBlPsOZCn++rXObrEvClq94XHVHVihZ9e7aUUhUDbo4p1MOrV9yYspJS3YqMM3K5NyGZ4yCmaer5pcODT0xjRFZp3z7knO+fBnpTHw/Zh03NtcNfqVG/7qHanptDGHnMglOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dQ06Gza4R5qLkF7V1PLOxH/DoqmH4uhPvkcBMmqyBI=;
 b=hl1aVDP8r8e26pI5z51Wyg/7AUtddKpgfsqBt/hdqUlGUcj/WanFUcURWq9xPm1MtiYwJvNG3kop9rIgy2mAKSgYxMTxYaEqAoPK8fHEO8mMbK26Ybl0nPfYHsLrO1m9YwkwaAm8YMWYXK7/wVuhB9ZoltoId4XiYIOj4rnchcd6MxtQ9WIv7Xfzn1Y3HwE822tMgthA8Egq/uDno3rt5wjSNqe0AxdwGZ72aFDsThdmfkgCHnsdJ97ESAG0GGfOpM/mMtI8Gx42ocnjQAjYnOWM0waPRyj77W071YWkJfcnhDqWEihgH+TzU3SnX1kjgLSktpEvbLyWnnsXdjXmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dQ06Gza4R5qLkF7V1PLOxH/DoqmH4uhPvkcBMmqyBI=;
 b=XEUNZ/fmB24ieGsiDSO/VcvfGD1bSoRJvLWDfSMsT3JG4J2GwFxbGbubPev1jKYSFGYHC7M82+hpPvEZbUPC2alMXHO76iWcGs2lEqGx6EX1CuBSPT3ffdV26JkeFi1GT8wds8A99W8l3AWu6Kpz+xMUP9ZVNYIjj5s4mVKC028=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:37:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:37:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 2/2] arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at super speed
Date:   Mon, 15 May 2023 11:37:10 -0400
Message-Id: <20230515153710.2799008-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515153710.2799008-1-Frank.Li@nxp.com>
References: <20230515153710.2799008-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 2feced4d-a88c-45e9-d799-08db555a4ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDapwYJYiYUkj0amphzCug8YFhRUC/P/2stVHL7KyG+3SxB+4tVzLQSZGmNiV++S4iKuK9pEqVnM9i0RyEA/FGop5D0g+SGvW+PZX9YsRhAdWXlAQFBq6wAhpoCOOCNE3altyiyJzel4leeldxDurbIODRPd4OrSRkGNHQ9d54wkKQtfhBHqpyuYkjqT7l3A+7NbwztgyAQbR5GVlOjgWCfec4WcyhhwJhLNSxQ/rmFTr2Qx/zDbF3zRxO1oMHHttLozXYaJ98vm2gjB3AlBcfDPLC+MtlZWBim+V8Ku6B7/KWdj16wNrMVPeeMSVaKzjiAMYZqK44VR7FhPIogxnZkSVvzSKaUuE0Mbv0kaQNnTJujZ+3dCNHjXMF8KFjxCvPVmJhr3lHuDSem1z6KexqCzqTzdkWqXIiUeNpbJm7hzDVynNQCeRrpx7RMXn7x1IigcRf8KrCZnkCNDxLRL5XIbHk6rF1QJ3zJxIZFFSRHIg9/WtzKVrLyIUZVfgF39TOyP1RjgdNkESQa7ypuiKuBKjG8qyRqYolt1drM3jepMm699Rv/x7EQmpX12sVHO6ShmQfmmOFJOwqxPKUomwAXCe0o0PmBRUbxums+2Z//j4SMWZpG+2rlUctbMtDnLV2D3YH3l8K6O9JNwg52uZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(52116002)(1076003)(26005)(6506007)(6512007)(478600001)(110136005)(6666004)(186003)(7416002)(2906002)(5660300002)(86362001)(8936002)(8676002)(36756003)(4326008)(316002)(41300700001)(921005)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lty9bXfBEvb9n8FigAAYL+o7l2rIX24WuFNVRySSKp+SUvToro0XsmsMhI+y?=
 =?us-ascii?Q?zgG4WqtTAJieYt9O1MxJRv+w0srJmqxE6XgZBDwsRHSigx6fQkjTBOxRu4CY?=
 =?us-ascii?Q?puKBfi/K6BEh99ERWqZF1xFk27+BF7sLA2o2SYf1rN+quOFoAhysDEZwOKvZ?=
 =?us-ascii?Q?mgpGXGW5970H+k0jzuYHvdTLw5tKIJIHWoyPPb45dR42L1k+mvLv3RuHVLp2?=
 =?us-ascii?Q?+F+JjHZpUrPIt7l69KuSQaTPXyc/CezyUhVS7q12UCP6q9R33rZ/7EKdXYG9?=
 =?us-ascii?Q?GYIwpD/kCv573lY6o+0gQtZoFvnqY1MdAuJ9HWRd7imTbY5CgUxTu9HXl/L/?=
 =?us-ascii?Q?svA9RwaWy+4Wkbak2xGkwXEvaSGUMb4rZ8L2wIK3DisfS9P6O4GUB4FbR48r?=
 =?us-ascii?Q?YOMT1pRfuTmIrP2U6VrgWFhlNanEwBKz3ctbJnlChXBpgo5Sr1RApVQEYpS5?=
 =?us-ascii?Q?LUeJBIViBC1lHQ8vukVcL8blKT5bGn235YfUIPiqcWLyyxLtawoNuGmFrwFo?=
 =?us-ascii?Q?fXMwqFE9bgnB47X4woE/bpqGwJDzsORKQ/1p+aF4wf585j9CmHcwC89zMCSh?=
 =?us-ascii?Q?1KWkIXStwTeCR3XadxQfyc2E3h8DpZTWmQHBafTyXMi6cT7/a7YH1qbFVdK8?=
 =?us-ascii?Q?cxfMhq5K001TZhcfohVfAGVOmswLA5xyDjHeOGGYD99FDi4fIGBY46/ZaA8s?=
 =?us-ascii?Q?eEyXXp+wl85W2d64fN+zHVDADgBy6zezUJXIs8aUyVMiKbtd1J4MvQpoEJWW?=
 =?us-ascii?Q?ayy6uIsatsqSFcxfO5Runh4bRRExvHSz/ljSuteKozujrOdDkMRBGQZEY83B?=
 =?us-ascii?Q?5PqRA2K3W7iyau/tUDUqngpjWkRoghejQHYSj8UGUWZHgho3JeBZdfQrLSzG?=
 =?us-ascii?Q?aljbm/8Hy9m7xu7CKQf9VstZCqUkSUZ9xgrXTd8+7lhRDMZyDb3FBLXoCsb2?=
 =?us-ascii?Q?pL3uosGhhTii8XgaWZHrhrePPvBWlqi2SC/+EPBiX3MaaF7Th1ZrWw2JE77c?=
 =?us-ascii?Q?W1+bb2KivIHKMrZtx4Pljzz0wIXGg1AsS34L4bKxf0pyMvXxzU0ly62u3Kw6?=
 =?us-ascii?Q?pt1uDMHhU1bKkqtB/05oikCQXJvZv62XD6/aY+i/qy+7r7kewVYbSRX0+SmU?=
 =?us-ascii?Q?f7pvpFqNXD6NDQ0qs4Z6sOCLg2ewFtVWunrCy6PY4bAV8DJJRpX/j4WT/1T1?=
 =?us-ascii?Q?E2ThMR+1TAiQFPjXQOKIUrhFIw7Mp29qhX5A+Z1P1efX88PMFV9hh53bAJr9?=
 =?us-ascii?Q?/p1ma7SShCffo8yWW4uhZN8a4tGHXMbSbQnKNvxxR8mDDLp4MWjPjSXBtHmw?=
 =?us-ascii?Q?6zj4xu30695/nlZ83KuMv/fKAuwYx934N0a2S3jyCg5cSIhcRa14hFDQgFDS?=
 =?us-ascii?Q?seoZP6/J7G9m5K7B0/13dCDNOkAFvBpGzzHO8x8I41Mb0OOfE1RZMnk+hW0y?=
 =?us-ascii?Q?/U4eROTCIPUM41pQhYSScut6M8dmHSZrZ3Scy4rIN7P2EEgPGHc6+OmRj/7Q?=
 =?us-ascii?Q?W0uduuqz/n3JYz0lbUlBBQC4mPggjDSLmRG+W4HwkafRLquF8cwy65qmo0x4?=
 =?us-ascii?Q?tDXt+f5CLWFBP97IxO4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feced4d-a88c-45e9-d799-08db555a4ddb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:37:35.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B/dAGcj69Z61lwa3CBrKyt7pl7oUH+pHLNk5skY9geVYYeX8x8jLHBjcZMMvdGelywc34mv+dFIPRepWUok/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with
single IN and OUT endpoints, like mass storage devices, due to incorrect
ACTUAL_MEM_SIZE in ep_cap2 (32k instead of actual 18k). Implement dt
property cdns,on-chip-buff-size to override ep_cap2 and set it to 18k for
imx8QM and imx8QXP chips. No adverse effects for 8QXP C0.

Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- fixes warning from check-patch
- update dt-binding doc

 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index b32c2e199c16..030c273c8be4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
 			interrupt-names = "host", "peripheral", "otg", "wakeup";
 			phys = <&usb3_phy>;
 			phy-names = "cdns3,usb3-phy";
+			cdns,on-chip-buff-size = /bits/ 16 <18>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1

