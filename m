Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C82D6C421D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCVFWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCVFW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:22:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3105B5C6;
        Tue, 21 Mar 2023 22:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwrKSv0rCvYcuO9DSJ8VmZeuXiFFol0K8dibMhy2zp1zr2wsRc8hvfy32N0mrDclUzTfKw/mDhiKLjIM8GIAECwOGq5k2CTtRFoOMJeO6EUB413zl6gUR5Zcn2fY+hoJ6Ci7nDhBoA5ocY4/L5l0OLLPL2+tUe+i3ABICxlvDRYv30tI/5L6fmwAr9Q38BATN0AezxWx7S5fh5KnAzEalJcef7tDiosHvVJFGf4Ykq2ojEeR6F8UN19tWC1s87o69BsVoYFchPNVb733niCD7F9SR2P3TFPLxxuQZhHi3I88tpHiYpaIM1AdsxU4kNB/7MSGuEKAYH30R1rLyc+TKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDw5DpqU6K5S66RHwoUJICFaH7ygMKUR421HRre1JlE=;
 b=AdsIQeuEusXqQUtUY8wPXzbyXEfrFLJD99t9WjzWrPs70eLU5LKS3lSrGdSNmrUC8SWYyu8i9+PbeUVw4NbFuJurZXEiV9cjymeZOoFRbABV3RtvUvVD7z6oOdgR4EvQOVaZbk2eQFUG75Edwcsm2S38mcQ3s+PX7TRDU/9J0HUOE1mLByq43stRayivfuiV4YyZllve3PrFMwbow6o6+hgqhk//dx3fK/8LakQOiHD4SzR/qPYtUHWL+ItUzsJnob0Kmy6foS2hOIrX+gKLygM+2JX9Ls7NJW0Ido3Ynh7CuqwVMFDrSHw5Fz+70woJQX8fh/qorW8+QyDjzz8QLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDw5DpqU6K5S66RHwoUJICFaH7ygMKUR421HRre1JlE=;
 b=iJ9c4q5oGIt9/oMN6oDvQEFhSMwvJIcKFGFJg7KpvLgoXyC+U+pkQk1O2SVufTpuZMkuEuM32SZJjkoOKVNGbAKLcmYQWMkgYJxHmyr6DC0vOGauw399O7V7Eh3PjXFlyJDOQZIp7++Kx12cpYj2Q3P67QdFIyQeCezq0zv8rks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 09/10] arm64: dts: imx8-apalis-v1.1: drop ci-disable-lpm
Date:   Wed, 22 Mar 2023 13:25:03 +0800
Message-Id: <20230322052504.2629429-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ce800e-640b-4170-c639-08db2a952e98
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mSOi7Adg12ucN65xYpwYVKFubDpiRNfWOQ6xEJkxEdGtHELfS5SbDs2mJ5WpT0BIHheuNav7q0xhmHkXhIQyborkHS1M4njicWfrd0Oi+ram/er4Kb1hxD1URJNBsFQkzVpOblT+EEbHCPSB+PSsGKSraX7QFe/NTU6xshY/Hs5we6ohJ6FmNzBKAvoV/LfIt5fCIoND9dgCA30iFlMQEKaAFVzvp7GFXpKW1ZcI880+rx4upXg1ebf+rpRxxzeXXX8a/egGVSDQSQ1vGKzbKop+GI17KiRDEQCov31kKogODiatGKvsKj58akUYo7AjhWvqBTuoGtFq5+Ts17HkuifZOxmbLep1XYiN0gBjE+MDeRC5tnVkVaUTXjKYTCP/nOeLE9amyGDXdEJxI+hVpPQQcM6M00PFg0oDU4zH9cJl3Rbe0vSeKM5v3lPzJ7X4dlPnP8+cq6eObNsn1oJHWlgFB2lrdU3sBx9ese2TSYoyaiianVSED0mDvHAUmyMYh+8i5rZoU5MfeQpNedVTfIk8FkcHacFqx5sA/bU2OTvqpeIrUCvIppyKcabc9vjLPkL29/VeX1dT5ib5qB4LVAnzXcAVomm9w6ngschgKkTJZADYLmOMJG2c3sGADpgoT4u11Ajo9Gg/JawkiEENPFJNHatU/VrgeFy9FwmwwUe7+VZd2hgK82fZRwMgkkyGXx/bxJi1fWwiCscYI/peQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(4744005)(38350700002)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MjGmVo262bET3UX+/BDVV7g/qJG3ChBGqLS+Ay6QiNVNu+k1AemdQ7ndQKE?=
 =?us-ascii?Q?QWaMH9y+pFSLlE3fW7BQZBta+PNrsQhkG+W8v9ZkUy0d6nV7qumVKfXvv+UN?=
 =?us-ascii?Q?lfibmdj0/WayJRBxTgfTjlqS+Ui7SELsDIZrUmfGhUvrBABDc4KPoFLXuJrB?=
 =?us-ascii?Q?1Vv5+xZhk5Brkn1ytthHCDBkzj4TI07fwiToya3Y3nTx8rkLx02wzoK/ugIW?=
 =?us-ascii?Q?2BW/uhNUGwtbP2b7T7IVGEpufeRKKXpNy28G8sgqPV6PDjE4On6KSsO2sO2O?=
 =?us-ascii?Q?W9zABW67+08zDEicYMxx4EdsDtVgz2GmRU50L0MEu9JZ8+xGEo6ueaMnjwo5?=
 =?us-ascii?Q?gdTiuMwKQuApVFcKNCknBbJVYDY31rxVsgQZOZmXj+yOFqUPLjllVO1lkKTo?=
 =?us-ascii?Q?1KDHKj+rkw6dDy+3y/vJjelRIQ0aEAmZC43BKD1xycby/qVfhLpxH0ksDFEx?=
 =?us-ascii?Q?3bAP+DAQPqncbr9E2i0t6TdvgMsNBKUUf37aybph6PfkIG06mFuKj2xsdAtl?=
 =?us-ascii?Q?7+5lR3o/SWtv/jRSF/USJjXMFBdZPGAOuAlmX+i6PpqWcnCqscrQ1k9sfLuX?=
 =?us-ascii?Q?bp2vVlq1d3tLlMF/pUVS9YG1Tkhzdl5JmNllr3NgSjO30RGIluKmPt/CK1xW?=
 =?us-ascii?Q?OOa0hpL2MD9tXpmAW3IzcqWmmEWOYIS9IEUFff3s4Ec8xbgEutK5x1I9I30K?=
 =?us-ascii?Q?VyzL2EvjgXFvCOPDr1lLqTuk7Ln0IfGkQ8IRdjZ9hWTY07WR2DNdqsX0X5Kq?=
 =?us-ascii?Q?VUi1SGhvSDCpYqojEw6QZlgRDdp/0GqVYkm5BGB9TKsF8vNMTLkXKh1/0eye?=
 =?us-ascii?Q?8HMirRpNdoIJrDV9f8d2UrzX5zdVRBBlYaJOrs/91Vcn31WSld9xeItXAbvJ?=
 =?us-ascii?Q?+4V0TzRWu3R4IcSuYuQM9fVq/Gj+gv7JDjmg4dMi/0d+xeP2Nov1dTx1cIA9?=
 =?us-ascii?Q?IXKmurN+vUVM3NbxKusUWPbRxlQzW6w3lNWmHA2K24QOoZDk/MtwFBQs9KwJ?=
 =?us-ascii?Q?5kAP1pJWsG12Ss//Kj38W2Oh247PqFpDDYUg/LXw62hNgQRuW/fvUVTKPEDq?=
 =?us-ascii?Q?KXYE3rxncrwvafj4MT6l/8e0PfEPVMEyBJeSZwWuc6oxh025AcSqYaez9BXB?=
 =?us-ascii?Q?KF40O13psWYoSW8NMhlVHXWR0L8RYEKWK1rB0H1vbDXe04Ogf4ndtTQKdT+J?=
 =?us-ascii?Q?7awO2ZnSe+B94ysYaij/aKCfxc/okWnPPpespo598NUSu9Ok7E+1jBox3ecw?=
 =?us-ascii?Q?WH4VgYTGh5ULNp6oHLLytjPhfML3PhBr3oSb0T4rWkKnUxwMi3ZNHTswe8Ho?=
 =?us-ascii?Q?R2h9zz32OxDYuhizMzKSyv76ZF5DBhhXyeLw+3K1bXk9MaC+pkNgd/jIXVzm?=
 =?us-ascii?Q?iSqI4q5Nsadrejr90i9Egw1W9C6gC+ewHK8EmPUmXeYS55nlnXgdV4asnUas?=
 =?us-ascii?Q?qPY2jw8WEqKXA7uRdi4GL06FOAFciNnlOzPcfiW2Qna50acBLs+SZBauApiC?=
 =?us-ascii?Q?0LoH7RbqsigzNb28SasWaWcVV5RMKqi/1P719oyT9ZA0/fOL3w84hSkYvxzQ?=
 =?us-ascii?Q?D9Jtmx7S+dM4t+dFNsxiHQsUCd2MUrlVPDLPzj2o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ce800e-640b-4170-c639-08db2a952e98
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:42.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpqsXV15yrc3oD2uf430I5E4iEg1r+gINoKCBBoonIgdkEALZcYPvwLS+ANE803S8S2k8cbHyasFRP6uysvQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is an NXP downstream property. And no binding doc, and no
driver use this property. So drop it

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 486adf849452..bd5d771637ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -726,7 +726,6 @@ &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg1>;
 	adp-disable;
-	ci-disable-lpm;
 	hnp-disable;
 	over-current-active-low;
 	power-active-high;
-- 
2.37.1

