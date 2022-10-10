Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486F5F9C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiJJKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiJJKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:17:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917836AA06;
        Mon, 10 Oct 2022 03:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjsgFq+48EM4XS2ncwCf8L8zKrKqhdb7HS78IklHCNYMYgqZ0ScqCQYSC9Wr7tpysRSHgnzCt6A5BepP63NUqh1/qIOfVdxSwr9qCp0xPtEexJxk8qJh3etYp4d3ZPVGUVTGf1LYiEjdC4kjt/YOxr1S1uHZi6FY52oDC6tHhxNFZ3x9Wd6cDygtfhI5G1M/HrsWMD/+3Tqe/6u7b3GjpaaTliJipY6YbwJBMcvJlM5iJjBquFNsdH8OyV3LYmOgSVNcMJucR+zE52aBSMmipKSXVxTauDY7oMAUypvmMzHR82Qka9D2ABPyQFoqvKJGgcBVB84OtEHmjtFTqDnKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLWt2YA7QQxk30QiWa+tQHqe7oASMMCcbICjhzufJLU=;
 b=dEDOM7HZBKswnyGU+726qwgO/6nR8UM1W3jQJikiD/Ux8H1nEw6erZWPYJSsbXVynFw8YDhnIaqlvLFqDrXf9mSUnacwoYoUDCLHLekS+MQEQpXroAL+QUfIoDaB9Kq8L5+R/0RDvm51oaAVwHv0k47naAW/SGW3xDcZ7Qmw2cEDUjxK0uVasTb+nTqh55KjmDHsbuQx/SsSfdmW8y5MjsbMdmvqv08nvA4AnwTVk7aWjfs+MfyMQUjgTwVHz27hUH1YdbViciLcWr+0DFnnB8kXSLels17Z/swxkTnbeK50pyKnq+7Je2Dt5z3LNLYlukEZ3irMlP49axs1lTNSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLWt2YA7QQxk30QiWa+tQHqe7oASMMCcbICjhzufJLU=;
 b=i2HI3mBqx5XV51HrIQF60xMgGx1m0c36Tdb5up0hk+O5lAgnvdH69br3zAeRv9OGCyD6cdQn+beBvjvKRT2kdIs6MVVoH/CqCgmPDdLo6u+PFavBtltht9B06BsWXIsYLF9sPMkJbDZnIAMF7Z2h+mLMircfN1A2lJAjJV6bK28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:16:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:16:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/6] dt-bindings: usb: ci-hdrc-usb2: add i.MX53/6SLL/UL compatible
Date:   Mon, 10 Oct 2022 18:18:12 +0800
Message-Id: <20221010101816.298334-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010101816.298334-1-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecbd033-166a-4fc3-470e-08daaaa88e25
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5sMT65GV7euz+rYKk4aEhGGhBeSRP4iqMifgXD0IuWorm+Kcq+gP8TSinZT0zziQ/bFwmGIPD43pi0w4oWk7uBY+StGWeIcU9t0UbkDY08yCZQVIn3CaqWCSmA7i+cY7ihoVuQKrEygWZ34PoLW4Skmx4krTaEsdNqOgNSLX0XEN+B//B/ac2NN1eYCOvGQJFCrVlST9D2z1wS+PXbdTpcA16t18BUAcG9qvshNr/psKMNGld93hVJA1n+shP32IW5+DRWmu6iUU3jUc/Dnwnx1H4XiuXrbqEBa6zqcRgc8yaWICzoSGZ8OT7NJOCnlsgmmj8H2xDXP1GsIloF7ifV+Z3p3V/DrvcpgxNBIok2ttu5ItKQm5MASBqy66bBvaG/jHYzhAcaADl2dzq0MlSpr8CYxxzbNWJpyUAPrMZx2yeYpC5//zo5PFNyPl2YqWDhMh8dUF3ed+E281VGrR/hpLLMJEovaZv0ieLCv6hmiCOo0JwjxyoycxG+6WnZhJlU70qG5j6ShVqZKw8PkcyYGyF6wDv26uACnj3vQ6hfiJ441k6jOq4xHpA+QCdt/vWxtKZkoDw5qutwDDzoJguqlrDX4ijYpWPbpCAnzcGinImQE2LU/UrlqkzFrQTE/hg1Gh4pAMn6pNsR/ohxK3MqEXKtYAI2GZbCTIFqNadSRj0hEETYDrQABbnqcvGFpcFejeMrwpfvvQwp1WW5NIKsGUEW23NsBO4+4pA8OWsqPVcBBm1hmeW676LdEGP1Prp1S4WYBN+Yofq0KYxxVyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(4744005)(186003)(1076003)(2616005)(66476007)(41300700001)(6666004)(66946007)(66556008)(478600001)(8936002)(8676002)(4326008)(5660300002)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxdTV2fTEJYLmhUlCo+/mhXBX1pTNTQt6XvLr8st6hk9iwBNIt2NvAD5yttV?=
 =?us-ascii?Q?4LsKWQt/jYVJp/s6xTD+NDy9fRvS89zWQ9MpF/2LlxhUU90MIP15ymWxGvlL?=
 =?us-ascii?Q?6qbIJ46dms4oyGdMcYAwxO+swCmeEkVksMzUl9X1Yw7ey8u2znCpUE42C+MN?=
 =?us-ascii?Q?A1AtHvnyJOSsZHCIK6vh4PEnRj5znKFzmCZjIID357oza6nOHEg1HIxYcjGu?=
 =?us-ascii?Q?C6DB6qvHFuz90Bi//xtRYEq5iDEY78egZ/RpAoDxjc2zHfv0eFXHBnMDNPO4?=
 =?us-ascii?Q?ShEUsM5dDxAkZwkR13kwgmct8GbKd+RwCswVJ2C1vIp5TvDCXS8pwYIEbAA9?=
 =?us-ascii?Q?bf6GQglAvmu6WmY7UuNzXekG8Hi/U/4IhjViSiADwZO/p4SDKOdxxplLJAPz?=
 =?us-ascii?Q?+ufdWH24e3p8dl6YIxj83lOFAyiOaqkhUbjgwXtBqOGvPwHqaTLj7bo/yLNo?=
 =?us-ascii?Q?qC3hnh/qMT1tYWDWWEo7HTMh0xUNx7XZ9stJp0xUqRXALNsYa05AUuGqje2s?=
 =?us-ascii?Q?pRkj+Op2umoWypO6XvazyPk/5gXiJQQ5Kx0p5z3bbqEJAYHrf7L77BRrmNU7?=
 =?us-ascii?Q?UN/YXeWGcvo0uXLdOesfPgHTJZ69npQy5x1QHBuCLiPdsyJuDBd0DwxEq1Di?=
 =?us-ascii?Q?7agCtNoId7tqm+LWaGwdbW3h4vKGrGRYcrr8Gh5hSPWUK4qBAHSmK2NV+C2j?=
 =?us-ascii?Q?/lN3TDsegNiFUP0vALwCA9BVN1F2uVyLP0ix+xEDI0r//n5DGLgzT9ZTPJAF?=
 =?us-ascii?Q?ehD/GlBUAEIiQzDG2GPWI8XWXb+0l0gSz4W6Qu8c9nfxils4QYHQa0YhrR5/?=
 =?us-ascii?Q?GKJsKUIJ62TPA/5iqITGHszTW/9zJStGLAbj0J/wHn2B/hK5+DTRRmiahAkG?=
 =?us-ascii?Q?V93WRXx3ppSYVhYJf4FY+tS+aJ5h1Lk5FtdJS1drDqORr3X2uz5DUVEhaVpR?=
 =?us-ascii?Q?uyOSUhD7Skj9C7Ot5mhn9SIGbq16dNh/547QuOMHmjuEeCddNBgs31c4FFHL?=
 =?us-ascii?Q?37SdIh7REUisiIC2XkVR20MuccPkhDuT9rJ8j/d7OvqnLeDPQoP4xtAFTDWt?=
 =?us-ascii?Q?ZvL4OXsX7cWLAYOtk9slWZhmjDnna+J+Kve8QrpFInS9Ec2I8mxQLXNYuk/T?=
 =?us-ascii?Q?VH5jNOwD86sFACfo1WZdr9qmZ3iLnsuMc3d0vwdlgMhi7UiIu2/vDJX0obPK?=
 =?us-ascii?Q?Q9z56wk+R0y2LJJGg7lo2uW+WCcOcdHmQ9Ro3HxUdy2VLywSf7s0YI4WzL3i?=
 =?us-ascii?Q?jdmzQkwa4t8xAx5H9RgqymxpEaTxqHS1w4JznjMJ4D+td4aUt6C0Uj9r6zh4?=
 =?us-ascii?Q?O/wtosM6vleO2IaYsb+hRd7ijv014Mv8CFXW4VvdVJMxR20nj/rGQd3RYqkO?=
 =?us-ascii?Q?qaZ8uh/QcAJiBTYmhB32+Ysqs6mDclfIkxf2bmHp0keek1nTv+n+oAj1uT0c?=
 =?us-ascii?Q?zZPwdrrRLPmyaMhA6N0dqdLBMvMr9XGuAxXB4SAQrJnNUe1zjMmeEs6onHtS?=
 =?us-ascii?Q?P+yjhU4i+Zb2a8sDsGThOswsaWGqL0AswGpflYB36X5BXotQJTnaQVugZBPI?=
 =?us-ascii?Q?kVyI1m2OfB2/+GHeeVK55oB3eOFITqmQH2syZlFu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecbd033-166a-4fc3-470e-08daaaa88e25
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:16:54.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o+ziv/Oad8gEIa2sv2GnrJ72XflCf7Y+qAX/aeZOGsGqyQimBVqoO3GmBRGAHCsAF36pIjYjp4h6GZ85hjHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX53, i.MX6SLL, i.MX6UL compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 1c10691c45f2..575084ccd6b8 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -25,15 +25,23 @@ properties:
               - fsl,imx23-usb
               - fsl,imx25-usb
               - fsl,imx28-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
               - fsl,imx6q-usb
               - fsl,imx6sl-usb
               - fsl,imx6sx-usb
               - fsl,imx6ul-usb
               - fsl,imx7d-usb
+              - fsl,vf610-usb
           - const: fsl,imx27-usb
       - items:
           - const: fsl,imx7ulp-usb
           - const: fsl,imx6ul-usb
+      - items:
+          - const: fsl,imx6sll-usb
+          - const: fsl,imx6ul-usb
+          - const: fsl,imx27-usb
       - items:
           - const: lsi,zevio-usb
       - items:
-- 
2.37.1

