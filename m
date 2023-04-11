Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265026DDF50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjDKPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjDKPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:14:43 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379185B9D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHCDs+rUC+lkHTFQs9ti1FJ/YaiYamXfLmHT5xRHU2jf10vz4N5QHOnWP+3Qp9ThxM+MVGCozx1kSWjdAeMcmIGO8ek1N5FcEWGV21GAoWzpgmxJsS3xjvgow3pjFzxt7OM6JtycTbOKFrf+HLtBYcCyQeVV82vExUjFgj+JH4eb5cD2YYQWHMz93Cm/igASKEPGseJ/Sr3cicfGi90rVG/gr+xDNO8UOBZGbPI9IbfhL/eCksTQQ13+KSr7R/0J7WJT4Gr3mdkOqYoIg+Wy1F1bojq99eUwkULRuO8SKIl8za2kfyTNZp2hwTBPo2EJ7xkyNVzsf1bTmk9BBoug7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugIHUpo1Yo8MvrNSkzKzeOS5DG0PsdIc4I8edIbHtZ8=;
 b=bnboJPy5i5IgwgLk7cRNfjB8EQEj6HMO5D8/F4GDo8Ig8CmoWEYCc4k3xH+iXcIr5pWl8jmxdB0igVZcfy6Ae1jN/MluPuTXZ0qEYZD4rIk+QAmRc5xwa6m7bRswQHkEQj1j91wdlZnmzmOtV+ijkaenlvS94HbWzGD8stCriq968GvYVklezU4n8n/ZIajsqWwTUXIpl+kOXEMZvFY+SrCgKJd6XDsg/SFbfyXd2PAORYzTG9z8pvirHHSkizXTCljZ/8tJudlkch6ooWgsBcajMW3xC65jWkDOI+T3FK0zy3Mu7OS3wVRI89rdT4ljljz7toaS897DFnQMZU/0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugIHUpo1Yo8MvrNSkzKzeOS5DG0PsdIc4I8edIbHtZ8=;
 b=YJlFjPBLkSx1JV2dxlJ8NFDp8ZJhNMPgrrhfPu4tJ1XZKDbUxLcqme6vlqKznqZrnVg1PYOY2c+QQ4IqN5V8P9tcuGIKpfTMhPy5IVR2j4w/m6/wr+1JH4QT9rJxyrown/T4JclgnNWSyEAdsHLhj0cTCu2dX+rKLcLrJcrfm78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:11:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:11:51 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 4/7] arm64: dts: imx8ulp-evk: added ele-mu
Date:   Tue, 11 Apr 2023 21:55:33 +0530
Message-Id: <20230411162536.30604-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411162536.30604-1-pankaj.gupta@nxp.com>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: d1be206f-fe2d-4856-e097-08db3a9f1412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvA7ezFII4zlgoHoP5hvA1oFiG2+rQu9XE6YrFyqAWOkYFVozKdhEsRRot+2utVLNP4AOzCO5RMuAyiPE56gVEifmKXOppuErxGmJDW4iAZ0/U/EWtXyambpNzu1BQ4HIhf6zq4Kdyjga8kYUE0dd/rzbFQ5rDXODlwshysIwHzPKmXA10UbdbW/sNhrkyK2EpWl3BhGhQ+eI2Cdk5/BgEfRwuzX+GhfwIGg2bKP7rvs7mk1SLbSzyZRyAVHj2SUTZJUvchDuG0XYk460dTwUk2GITV+4Djp3AS453vK9JGNPj6z2Kns3al9CRB3vvkxdtU86janFnpNQsrWdFyWpegRbEsPgz87Qzf3R4Ry/rxiWi2zJVbfiV5Ca0Ub2riJMtUxNFK8jFgLqjLnlPH74SSLS0eTKIrQGJMsjD1DKBlLIHu8QunejkjiI3mdqBi9eYdr/LcF1wQFM8WQi2FZoZ1dMUfUaTOWBP9wY1f9eiQYkci7mAS1JQUfVcV+tlprhfXx8+ipCmb5MqkTtiS475jIQptLlrqaly7bFf2CmKj+R48Kzce3yYHpVDW1/6LwYXlT+nWiIn0V6H6ubHIByf9ChQOBLlOqDEmzWXrQiKzlIOYmClW0MoU2LGHricrp6qjh04wXS+LB0mBY6ME27iOA2Bs2nK6BZiHmzmXENvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6486002)(478600001)(4326008)(52116002)(6636002)(8676002)(66946007)(66476007)(66556008)(41300700001)(316002)(86362001)(36756003)(83380400001)(2616005)(26005)(1076003)(6512007)(6506007)(6666004)(2906002)(8936002)(44832011)(5660300002)(38100700002)(38350700002)(186003)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59Y+jKkMzYiOKXqSURVb+v2zDd0ihWsYq+CmT1ldF62BSdx+VO5ZhctvCv/P?=
 =?us-ascii?Q?Q9dJJ/rkpUJ3DLUA08Jg5PKLpI9wadhU0r5b47yM5H47LvHesaCD+Ur9otdM?=
 =?us-ascii?Q?beSL/94KqtGDgm+0F8QcHftu1rfqiOZaIvsDbrWZ+AXNTAumEZX84ZgQncaS?=
 =?us-ascii?Q?uyHsOa8rQiVXH3cGPwScM3t+SeqE9+dmv+HUC0k2p1b2bnnW+Kj7bd2s107W?=
 =?us-ascii?Q?UC53A/Fu7Cl8RoiXzNxyJp0OMZmB0ACezK3NzxzqCxXqArfJEU++9uSAEwrS?=
 =?us-ascii?Q?VPGLOjZLC9YD15WNwpH4z1zYmxwOXWUBaVVi+/h/FmkLFGf3Mtdp1qpznCCH?=
 =?us-ascii?Q?FhscRlyNjL5JNIKP/Oe4S+Ydm/zjUGaos5ESdr3KeER1LyqJ4I3ujCrEGdxc?=
 =?us-ascii?Q?dNqeQpSD03g/m1KDouxFdz5i/63FPHHbHGlU6JcF/C4LQq3BK7ZTxMH47Ya+?=
 =?us-ascii?Q?ywI3mqdHSNFcKP+Td509jS/DekaOCZ8vmsI8eZPMM6WECOe+xqebY/Ke5tDs?=
 =?us-ascii?Q?YpG7IxArUiOg1MIujC/29bmgqsA/kGzZuzACzw6gNKqAU/Kz43B/9iQqUUEi?=
 =?us-ascii?Q?cddgMtat/um1mMOuN3i7kKDtTrSSHpEnmvTyVOYqQln8xea09PxFtSNFdB+N?=
 =?us-ascii?Q?dtaEy9ccAFllqHPuq/tqp/wUyaBDRSQ4x76fZWFZRcTLFkAMcfdxxD4BcFIC?=
 =?us-ascii?Q?xTYhScTzYTJ4N6DpZALPGnYo87qQIE8+lUa7t0nyhwiJOfUoPGpiMMago0Np?=
 =?us-ascii?Q?TfPON5N++m9/boZYKZPKjQH3i4z3NwQOQizhFFo9IbbiaFuBIrgXxin9nin6?=
 =?us-ascii?Q?tYwy1w/nvyVklRSYdlkRC30OGy5nXWJdjSPNQNIP9IO1iLZVps0wg5zSCgQx?=
 =?us-ascii?Q?OJo5uSEd29VV5JKa7sJmsiAUQg+Hk5710zbGc21V3g9wG28IKE8T07SXXKDT?=
 =?us-ascii?Q?BZ5YnPT3LLIspKJqpCmTCfJuk+l77qa1Xk/koQRkuR5wP7X9bwhUGFRTlSxo?=
 =?us-ascii?Q?U80s0JrNF6o/6vShXe4KlshMN7bd7t5mvgrNofNVRDhO5ZVqfQAJmbRivmew?=
 =?us-ascii?Q?UwZyQYtjE1XYYboikxJRdj4LXgDIPbhSRjNA+Aj3CmC//5gd7qtwZoGYZxZ+?=
 =?us-ascii?Q?EX73LqPJgOWYSqXoBqLEB+6PL9yECeQ4jCxt7Jt0l1CSroqHK1h+FS0joKhc?=
 =?us-ascii?Q?pRzNJl6BQNm0EfP9dat2Aal4grO8tVC26MYaPJMGC14TwYRU7d4gw5860dF9?=
 =?us-ascii?Q?JVwa5n88XO2LFeEvtuswPY8xmOMHTPRjF6hf8wMhkMJ/PNhULjcLqixb60fi?=
 =?us-ascii?Q?+GPvdcKEpd6zHqA8h24ol7CuuXv67BGgNbPqqkCBp0dyVtdSUE1Rkco7L9Ml?=
 =?us-ascii?Q?GwGUB+WjFb5iu2/3FpUO/UjMeQ+yP59BmJOMlGhytN/aneUDgEaYFsFG3E3f?=
 =?us-ascii?Q?c/h3op63JSymtqELJZ5kr7H2UWjrygpNTF2VbO74jKXo7WLUVnyefC/YDP3u?=
 =?us-ascii?Q?gSRu853Za6pREQCjtplYPIvFa/xUvPaYX8Jm1pBOyIaIifIkIqOqSQQeSPwS?=
 =?us-ascii?Q?fw7puF/KPBda4ENWa327VIJPMzGi8647heJNrj6v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1be206f-fe2d-4856-e097-08db3a9f1412
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:11:51.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be7PPI+mJA8S7YYsnixjUC6Hz2Ag2W579lC85dFDBclEzaz+87yc7iJqKbN32JdNkj4Ir05pX+Nd8Qf6N7MwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added support for ele-mu for imx8ulp-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 32193a43ff49..2ab240258a67 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -113,7 +113,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -160,6 +160,17 @@ s4muap: mailbox@27020000 {
 			#mbox-cells = <2>;
 		};
 
+		ele_mu: ele-mu {
+			compatible = "fsl,imx-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,ele_mu_did = <7>;
+			fsl,ele_mu_id = <2>;
+			fsl,ele_mu_max_users = <4>;
+			status = "okay";
+			sram-pool = <&sram0>;
+		};
+
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
 			reg = <0x29000000 0x800000>;
-- 
2.34.1

