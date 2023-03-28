Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB76CB67A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjC1GCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1GCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:02:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8D1BF6;
        Mon, 27 Mar 2023 23:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyQ/EqP4aoqEL2oRvvOORVybbukLTkMkn+yC0e4YiFUPdzUHZpRGokW/eCYoKvpwrnieGKi3N2OkbKGTbKmJr4Vtt9pWwCnad/UmNwnUd2Kp/JcYYFiWQXKaJ3NaePCBRb9nnudyqT4n8yOb4PkaDMmW+XWhq3E+rkPGs0PMjIFwx/tkuI2onupTwQ5ub6oMaY5i0vi/dM6erJlblxe2hy9a7BvbtoNbVgU0oos1hfdYaKVn0geOsgSpgsHvQkD1WZE+IRKKWsxFkjn+sy6jwRzhh6tWghTSkzyVcyysKDM+5nT0hWckseHcKylvekbgUMhtpvkqzzFdqrBEF7oMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF9azS3raXi72mJsa//bVXYmPv4PR4gwV8fjyAc4p5k=;
 b=KTp8cE/cq9JhCfsACmnGn9jbbdUwqaKxCKhZKFVzAK+4yy0uNgOCp5n1cDVaSPbQ1V/ucNufVpOSdKfBStKlIzS/65Rn0CNiwT/eJlSggqhCGJRuFJ+r4AUDcjOSvBqhFgZpnVVh2NG7Sgz9SM6UMnUGZMOGa3O3+/blGaG6Lz+e/9wYXvnrJcwhqH8jglQQsWOvOTLq+uJqCmcTpwdqVU+0q/vsEenxlqqdNhxKjV2d5I7H+cWPn/Q+cDXD71ZxPvf+3371hX2YXkhKtWnr4eRdqGAJ0+ipNlMOaCm2Jqf3GoYQfguEyfuRFAsYP3m7hKjpYKYwGElZa1cdIWw0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF9azS3raXi72mJsa//bVXYmPv4PR4gwV8fjyAc4p5k=;
 b=Jt7AlelbOcZJ49a0a4sLMnMXvPZhoTNBfVte888x+/rG9E3B+PORYbvwYj3uvBHyHXnvib0Ra0CEBAzNwX/j3KSSgIRwCdLvfyYgGLGKOgBk/hneKzv3tDM3jB3oCzPSoQanCaYYi8n0fiw0r60otcDvG8INpfARG3KV314akkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9325.eurprd04.prod.outlook.com (2603:10a6:102:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 06:02:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 06:02:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: ref sdhci-common.yaml
Date:   Tue, 28 Mar 2023 14:07:40 +0800
Message-Id: <20230328060740.1984239-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: ded3b9c5-6ec8-4856-5840-08db2f520753
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FIyHxNye75GHGY/QgCBwru5ONDDIjRWwIniA0jf/aWOii3zKbONR/vOOAzrEoJmCyAUHcCIBuDZcHgnWKdzn7Q/aBM7UJDlV1HYywPux+ABzNpi8xWY9XZd4T+mMvlUrOK+YWQP1Aco62iJyQBkEA8yAM8H4ljRdgwaQtaSpL+3La5zM7h815/LVx3JcqbhGuorSDjk1JgHRXtrpd/utHIq8/mzqOpJnuYghh/y22+VGsbTdpozbhWc5rSV9rCwv0HX/QLV+ctRMcjnsT4NgfvUaj1nGcCpi84EjNOdZBgEoNupX3SYp+AeiYzsPLbcuPh/ADQq829jci6bj1mtQlkUYSPxXjCrgfXZDcgUU/ErSVinuKakCPnxMH6eJ2lB4Z2UMfptvnGhasHBEcvKE+qx+987gSccNNUahaz5+b9+ThUKfvzcM/loZ8VFyEj7bS+tpoH5d42Tt+yvc4VtsUH4WHWMCnsN++kPWr2AZHUe6tcah0Xk4faZqkWofjn//ZwIa3Js98mvkp58McjJ1aup3kc9yR4o3Pf5WzzQtlqNxwpq0pHfjW5E2PZIifW9NbLbp4XrTLpaA+rjUT46q2gyXqPz+95ZDvqHl4GqQCqAwHlXgaFyrS46zwN/u9Sq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(4744005)(7416002)(52116002)(8936002)(5660300002)(1076003)(6506007)(6512007)(6666004)(26005)(186003)(2616005)(83380400001)(2906002)(86362001)(6486002)(4326008)(66946007)(66476007)(8676002)(66556008)(41300700001)(478600001)(38350700002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFf5FrmxckyaNbusH2MQ/DLxisd3vXFymvO9Uvq4QXtlafpgpsFvsR4phnfS?=
 =?us-ascii?Q?2x1yiqpaMdkNQ0L1tww6SbF7p/eEoAAZFv7Us33rrok1AMCe/8G5T29zuQSJ?=
 =?us-ascii?Q?gLzivihQ/wGOPe9v/aoT6IIYctegavbf5sCJ11wi62uaVKbcaWNbS4+SxNCk?=
 =?us-ascii?Q?rml5MDJDnpM9vhC8PJ69GJfua8dFEAgvKDUCNQu/iABA3DwxcA3+udM8jxYb?=
 =?us-ascii?Q?Y+xOKojAshES1kjgBAxeOYggrqnSh9/UPTP0WQYjjyf6+N4h7dHeWq9QOkvJ?=
 =?us-ascii?Q?wnSoqvBSCDZU3VirqjbwwN53X8PDB3K7Ybt0ljNO+nWUsffeEi3JKBdHBTKz?=
 =?us-ascii?Q?t7TPmXSBLHiEbxfbKIH5NHimcs2i4C246PDj9hbjIZeaR+VnLurL7Ztjjkt3?=
 =?us-ascii?Q?V0k2sVdP3LZF+QMZQc28toWBmfQFSHZHkQZgzJ+AuGei8L/jOUvXnrOYOX7Q?=
 =?us-ascii?Q?apx8yWcu/DDxJfF91QrhZryS2a/CXQGcxYLgMnGZCDjHm67wg2TzIrqQhHMA?=
 =?us-ascii?Q?bGkTDsh2Qw3VLHXCUmvGkrgDbYFsjZnzXbDS8aczIyJQOECCKj/aGu0NYbco?=
 =?us-ascii?Q?ec9vrMrkFCbK1IJR2bcL0/jnvtfJtqXl4aobOz5Jk0HQJrx5Tx4xyRcqFE4/?=
 =?us-ascii?Q?+Avf5Bbu0i0QltYws5p6EZ5ppQ9uSekwQRlAyRSzwu2unFmdBMtI1sPKd9t6?=
 =?us-ascii?Q?aC6NUZEo040nl4IdEeA00vEr2rxLliEF8+qBCh/hUDUO3shaUL29Rm6NFOKW?=
 =?us-ascii?Q?25DcdCuceEbadymAEQKaY7CEZpxRG9zSIhBfzhARJPqVoEOyxlzSoo1OxrGH?=
 =?us-ascii?Q?MQRNltVCJpnMPXoa31B9A4f+lxWHxSk4ZTsa78UHmm2ISjVKlnk56pZpgDPZ?=
 =?us-ascii?Q?fLS9WBj+VqRwxjW9d+JH5QkiE1FS3iFKJrJfQROzklZ0fRHtP4UhCsLD1mTf?=
 =?us-ascii?Q?gPOobBkQNRzIOcnvxJAofhtSPw5lrJdVWk8GtVEwWezd8xdd+64qPcLZDOT/?=
 =?us-ascii?Q?C7rx4B2+rGfKxiVMS/s7OZ6+04bJCqFA1RHL4ioJ3rWeO+w1/68gXuoCel0g?=
 =?us-ascii?Q?5sMqI/wQt5JulRVFutiHfIm8qgkoIQsVIyZhyvlJ39qDG94jv/18he9bK7BF?=
 =?us-ascii?Q?hwoFQjxNjVx30gGjmBHpR9i55+OTvoECFvC30FmkhgFklYviAZStYF26pusQ?=
 =?us-ascii?Q?tQcSHa0uIQoMFcuDAL8rbwM6kt20FjVLm8ZFizieyBogk6HTZtigzRnepcDx?=
 =?us-ascii?Q?kKKqV5ZgxuXsgVyI5ucHoyP8MgW6nQfLfD5k1eC2OidxW0+l2PksgFMXljuk?=
 =?us-ascii?Q?6aZH+n+XgpVtyHSiuhKmZ7xmaCZlbyaWDoLIy5015/Kr/xVE6ccRKY49/+Ix?=
 =?us-ascii?Q?x/rIY77Mq7VQRtGTHnZJ8aTxssM4K09qtoHZRUqrXfamV8Bx858737mqACZE?=
 =?us-ascii?Q?GJ4PqoXtkC+0hDemKuuB6HKXVnUsWaSb20FfpCG0Mb0mNmzjy4hPOyhoxweF?=
 =?us-ascii?Q?pFBP40mKDx2vTGb3VqNur/jlaK8k/0ZexYvuB0TgJsWuGKBuRTzNws0cMDKr?=
 =?us-ascii?Q?XGSu84cQe66O5Km0pXH2eO1FTi0y+62hiiPZ7MhA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded3b9c5-6ec8-4856-5840-08db2f520753
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:02:36.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIfAV4d2wYM7L2nnBCY71FjbqC65piQurjIhm1fA8fhnIqcMUU3Wz8/m6gzuei0qHJNueMoDLuLVlWSP0t+kRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9325
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Since the esdhc controller is sdhci compatible, the fsl-imx-esdhc.yaml
should ref sdhci-common.yaml to use 'sdhci-caps-mask' property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 7f721fbfb009..fbfd822b9270 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Shawn Guo <shawnguo@kernel.org>
 
 allOf:
-  - $ref: mmc-controller.yaml
+  - $ref: sdhci-common.yaml#
 
 description: |
   The Enhanced Secure Digital Host Controller on Freescale i.MX family
-- 
2.37.1

