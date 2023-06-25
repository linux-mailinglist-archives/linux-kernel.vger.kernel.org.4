Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703973D06A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjFYLZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:25:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19567F9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 04:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEwIYPD9QxiWgHx6meYlX8nyq50XqkXNMNhgmZlKqLqz+/cb52f2dimyOnnylShG9HPcb1dbMQYtk43H6972pxK3cfPhv8zFx4kxqoPtyhg8KQBvof77C8MZs+gZiVljj4MiN/xqtynkhIOCwreZAqZ8gWkcdR9+2Z4ie6wLx6tbe2XtvvuHJEMhpVSajToPAZiyNAn2JzLONUIzq79Fb1FF64lKDDmQLKAEkEVQBWLJbMTlFRcKjzAE3rAv/WLThBshxZjJAP5aXreB/QlrRdOR5cYvepZBESu8mP9US+jQBA0If4/09oquVoIpc40Jq+ix+mMd60fNGyT2zBah+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ob5fVxZAv8Fxi7XEBtw5Oz8Zl9bEJpiaEnFus6pYGk=;
 b=KnIPRspFOIrxS2Axku8IxxOkhRmtDIyooX5gYVkzTrNeStMpJtS3k7BleepJ3cFIXjPwylb5t5S/6A2ZHO/NivG79o/8kEskwhHM+/E/de/HVODmQ3TfTsxWKbeL2juPpwMhoGqR93YJxt/clWmHN3FvuoBKnmukEps4emzgD71dAVTSAIVkfsrcYXO7knBGffgsBsHaiPg5qNPipKYfrLAPX1vqRssuqbOA47OM+3tinFhU9mT2edArNmDqqJtXlg84LQdFCTzvGXFJj9uwaxUBL1d+R979WHBzn+CtOtv6cDEU+3SVBwFUSG2UmaIJoNmFrnGsDVkNo9vMBhhU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ob5fVxZAv8Fxi7XEBtw5Oz8Zl9bEJpiaEnFus6pYGk=;
 b=b3LjlRcORfxeaduVNORcTCW2LpioO6LMAAj3r9LL8ryp3lBab2POK/WyVoxHv0Mfs7eiR5jxj4Y8N9waG0q8aQcxgnpH5rRPEgtdHKMb2wvFTc/UmgApb/xc+LH43JaFxHmMIZOqG5Z7FgQREAXdO/Zz2PPnfd+axel800Ndevs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9932.eurprd04.prod.outlook.com (2603:10a6:800:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 11:24:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 11:24:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: select IMX_REMOTEPROC and RPMSG_VIRTIO
Date:   Sun, 25 Jun 2023 19:29:39 +0800
Message-Id: <20230625112939.4058616-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0784ddf0-408d-4c7f-7bc5-08db756ece49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWR+XLEEpNpNyLkvAS/HM6bxEC9FKSyeIwkdDip7Mpo9W7j8ZAlN10QwmoxSdlnXh0EmdQWgdGiCzn4+nM0qA/ryqdx9d5nW1UzQqh5XdFGga5WwsDXIx95syvDBIQsFLmOeCJdMYZ9Iw3ZdLtBqItTl//F6bNRzcOsQe9y0rjAlhXfPuFrVB2GZG/gXQeC2a07rj8iO2u8bDs9ZuXnl/jUwEsz5uGJPYIOnpLe8FzicrdqnTokX3mbAvDpQTp5F4t8PnW2M7vDers/NdSd2Jh10J4n/3ByWtRKMCley39B1L5iJKrRbklZIKKGfSBOalQcQCS0i7pqvwu25v7BnpOV0DXupt8Cr5E8pLbK+vcdnzs2fbjBpnVIWJHKfaUL1h1ZaePLKQJsSsQW9/MwX2dK5IXQXT3Jqhaa5LfWDx9MK/oR1abWjQxAhVPllgjYjiTsCVMEtS/ScjSe52VJh1SSVNOakdHLPiuPD83Q7TPBlcuhcHGE1w2TTXy+YIRH64fDpdXDkxQxGzFPkrFvt420NJuXfqrit6QWvtPWzxIxG4PMEdfQu0GUb718w5/SOMnK+WdHiV58uMocfm11ozLTauZSGmeyVC4MQTOi1L0Jkd3NGUGW4fnQLz7cOH5Mz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(5660300002)(4326008)(66556008)(66476007)(66946007)(478600001)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQu5VB71N0wKyM8Z3y1C6448Ptwnbv7E8qy4VZzpQ6TvFkDPPfHMMv0eh+Th?=
 =?us-ascii?Q?ygktFGb2VZOjUaJXmpfl9vMXM1DO3PAcUhI9yjebYeYg9q210aPiOa13qd6D?=
 =?us-ascii?Q?0i/J9NaPQbIuVOgPGAuS19Fd3FvQ0+1rGYqO6w2BriERfzx3PqKWOWjj3+vq?=
 =?us-ascii?Q?oKK6loqE0zZgYdW1Wpss6xD3lzsf3/UTEQkhZAfEpxmbd9yZWg2Kv3IAE7Jt?=
 =?us-ascii?Q?7KDLslufSE1l/tGjuvCCZvRuSQEjZGBttVtpQ1c4AZotf7Lm/zpOZZIJ+lmX?=
 =?us-ascii?Q?ORNEORTaq62D8m9v4nE738KhRNv0yIzFoauBHtutpcbPAsVALazebwZ1qQQR?=
 =?us-ascii?Q?BQiNEyAanPadhw6SlGKTw8eByxSS01nyeeiAAg5hrzqvDFMGMqhkBd6iUa39?=
 =?us-ascii?Q?U/Ptp6kfV4Io6fr1Km95XMchgE1jm5XFOOqd50DxdDO4eeZ64Gx+5zA4fd9c?=
 =?us-ascii?Q?n3joCULYiH1CDgBbl3DtTA6gvAzTF5jOnuuLCJ+SnSCnBUbhyvutNBmwhX7H?=
 =?us-ascii?Q?EXDVj67pDw8Tie0d/bFFvirhSQkGPVVhTBoKuu0F/01+B97Mwb0TbDsHO5h8?=
 =?us-ascii?Q?DbzfDCbYDL2jXK7y2YWVkC6Ry66qsjBb4NDRDpzbxwEOh6RcPXoTc0oOFX/H?=
 =?us-ascii?Q?6U95v7iJItq8V3JyURCmb28T1t4W71UzsWfPVIHh45m3Np1Y8I3NXLIrZynj?=
 =?us-ascii?Q?8vpSunvKgSloP5IC35G0Flin4ibSR/lUwlHqTlu6peMeNv059fSH780EO90n?=
 =?us-ascii?Q?/Kt9HzefDrY48D2m/A6Jw8jdehaxq5CbAyESjFgVcUY3SqwhKB5y74lurAxd?=
 =?us-ascii?Q?EEwfKYDiHxb1pA+klW/bQ+Wlo2HLJwEJU0DQWONpCgwKMpkZjpgPy64nMqyV?=
 =?us-ascii?Q?q8Ynyq8TAICNqcAlM2253TcFK3aIQ6cg80wHV+wkkwc1rtwgz91QlDYBX5oK?=
 =?us-ascii?Q?BGcCyad81fAAr/2MTCmDoyFg7EO/JN2T4Q1K9B5FBMIeAJeSlz06MprqbwUH?=
 =?us-ascii?Q?EAMByS2k2VqBI2sHRMUGRAWYWSwA3tIBXaB7HDVGrU8S6lbL2tKS+C8M09Pr?=
 =?us-ascii?Q?ouLi0JWraIZrOAnw0m1ZmvUQgrN0gu/wBOMAUjuJqwYwe57gtHcyfC41upys?=
 =?us-ascii?Q?VUP2Yz0ANe2x2CuNQ+Zf74RAuCS7yy11HENZNMVF8VC3sBLC3WOkGBHXcFB8?=
 =?us-ascii?Q?L6KDUM2pJ4O8YsE3+KxVJcftHTSms37vkPUQmaiur6pszh4krQSykynXnqO0?=
 =?us-ascii?Q?UMED1AWBBzUiIOR+ckhojv20PDHmbx2CD1JjVvHpAtWFj2GvHhhgNg9VCAav?=
 =?us-ascii?Q?XwMPAcD0tx/Clk+xKDfU52Hu4wLN4/FZ5cq3VsYuoDvQjF1hewfwDhaF47n7?=
 =?us-ascii?Q?FxYvL4VcRyJWKnB7IA/UAxb9rrVbXq2R6pWTKjT/MCOuNQpAdNS+J7Ax9L/Q?=
 =?us-ascii?Q?dalufWbIhZRbDlmgKNRSMxEVbyqnnjl3KOGD172b9a5sBVjU4UM8riT4UuDm?=
 =?us-ascii?Q?rBr9ZJfYCPH+6Nzzi9kRLd/MCwvhlULVmbM1Fpu5uvLE40ZFwjE45xePdHf5?=
 =?us-ascii?Q?G6TovMNMXAXj/L+XjQR0N6z/eJBx9CIM4Ndw2HXE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0784ddf0-408d-4c7f-7bc5-08db756ece49
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 11:24:57.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TWSUkMoqRbtV7is+Mlrav0p3w0yDUFr7zhq7RGEMmEIQXIZyh+Hb/qEp0gxso7hP5ObuBm6DxFkghH0rShQPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9932
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP relies remoteproc and rpmsg enabled to communicate with CM33
for boot purpose, because some boot related things are handled by
CM33.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ed733ccebff9..4bfb3c717e52 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1238,6 +1238,7 @@ CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
+CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
 CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
@@ -1249,6 +1250,7 @@ CONFIG_RPMSG_CTRL=m
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
+CONFIG_RPMSG_VIRTIO=y
 CONFIG_SOUNDWIRE=m
 CONFIG_SOUNDWIRE_QCOM=m
 CONFIG_OWL_PM_DOMAINS=y
-- 
2.37.1

