Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15C6BDAED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCPV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCPV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:27:34 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563EE277C;
        Thu, 16 Mar 2023 14:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0+WNunNLlpA33nU4IzA/B097DWwLcvzGb8tQD/T9FYOsbfWfjcsGbdXVZHmqf0+19x4FrucIGLMK0XX5pBLtZXwTmaHUm1bX5GiYp9Uda6JXPD+m+dE7iK2TocflDztHm/RK5ksEHYTex1+pfmkiwCqgH7Wg40ZhTw7Hsy9w3e944bubta8DOmOLmkjWKwC4sFwCrNCjTD5UljUqlYDuFplTShAUGOADoUBtgA57z48PiDpfmvVOXGmjkMlRKux7RDIMYmEoh7cUlZ1lfyyYXsdvn7g1ezHh94MjElWEa9ZEi6PrbkESZc4uX7lVHLsa7TML6P4MDm7XOVjxwXm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKCG6IcKQe9m3N/cGMRwz6Ocj15/n/XWX/Bucc9RH1o=;
 b=c6IT/27KWpuPjgVCtQ67cN0D+yymOa93mZCD4azxbv9xc3DcyFITf5DzMRvND+robn9uBRvnQofsut7CgzQjsCLKi0CTPGQZxGSbuP4mPfvfimwbCSfB1jP5RD8+eMiKls6aGBktwyP8qYpN7QftRRAVWUtCOh4obN5CHULzKMGs+wZiFgn9byXoQcHuogsvMFNl4rOHMKLDCyQ8HRXl51w0qJPMdu1j6Lv8O3xfkvcWiy9c0PIfElHyuPiZUdBJxLHpf86DRpi7AagiPladJpPn1LIg/nGEJjA32bJzDemPe6WZcnQ7zcKJX82moUC6t/9AjoAXwhmdeoiZrXtREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKCG6IcKQe9m3N/cGMRwz6Ocj15/n/XWX/Bucc9RH1o=;
 b=H9nuAk5dUSOpbD14VCyKVypN2/D8bcdsIsbv0VmpvQq4m2AzIkI6xTDf+dCY+JieDp4YByLe3QKBjP32vKz8NYmjjhWChfL/uSiA4MJSRjiaNXS2qiG7QCb08ObSjyScnOghLJZQTmbf9gCc1z1ZCJihm7fqEDNMMF38xOfP0hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Thu, 16 Mar
 2023 21:27:30 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 21:27:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: [PATCH v2 0/3] dts: imx8qxp add cdns usb3 port
Date:   Thu, 16 Mar 2023 17:27:08 -0400
Message-Id: <20230316212712.2426542-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d75218-4f37-462e-dee5-08db26653f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVg5yCFqb+7VbVwDxtzbVjzUP1MxJkbuRrPOxmuq+4ODdMy3iK39Pk0WziUgXleyXi1nOGFstnJGGV/UjYW4srdja4VBTfcYDdwwBY0VMqzG3mC67cm9rpLMMmKs366CcF/kNP3kJMGQFVAPRM3cYtjajsNbHnZgSAdrriE04gfBbJRTsxszItkGV7liVPMq2XrMiYF9rXkmT2wOrmsmRxy5sam7F4qvNNMW+XYxsnla4wNxv+yo9uq6J9X16L8L8TyxRxazhUkYWhRpLcHr+aI2dF6b4sVzRigzzUNYvBz+nqpZGmcjttC9q5hXQ059aWLgSZFuetDPgBGyuDX8HwL4sgzE+DtKdxq7xohufaVIyiRhK20lZ2eZaun5AeGp3fiJetLOVOec0g1Lhf+fM+AWIIjHXdJj7d5OQS3eJv5W+sqmPsXTlgBRZvPQ7l7/j+n+iFLqPZTF1pNlkhqfNfCC2nPOYkbRIxRbHQZAZIGmukoRB6oRHugowzcX/xA+f+U/JCgkYx9aHXgv+b5gXDZgNgABpJf+8TYcE1EQpXS2WTonXW/MBvDT21IOe2Eu/81TQJhYky9RCR9TSmCqoWopps4VvSykyrWYLXqSHLllKLjYicsFPo2Wf+Tce5xlF3LCPF5aGOa5Q+KD3SfOfFGrtFfGlcJZ/djrL2/lK9Tsesyk1ES388b5mLW+oWCci04drfzCBW9gmruoHVSiLxpQaT9ggiCbj/S4Q/wfKnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199018)(316002)(38350700002)(38100700002)(2906002)(478600001)(36756003)(8936002)(5660300002)(41300700001)(66946007)(66556008)(66476007)(8676002)(6916009)(4326008)(4744005)(7416002)(86362001)(186003)(52116002)(26005)(1076003)(6506007)(6512007)(2616005)(6666004)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHXQWMYViIPYBE5T62sTY/fYAgIrlDY1Rs9+iptPoVKX/KSr+1G1WAyf1fHg?=
 =?us-ascii?Q?mdWEsK6/V4oME4fGh/iS0Hb/u7czG38xtL85ojPodWCVGOlE1DDX/SHNq89o?=
 =?us-ascii?Q?X2g5HfDY9mXmXIKALxF3kjNMzwrpLOM7p1xlKb7+BvAUuzSsGNHM8s1ZC6Ob?=
 =?us-ascii?Q?N4E7bzzVpVAA51tna+c3RA3D156djSL7QIU+hJD17N9oUNmLyzipOwrW5lgm?=
 =?us-ascii?Q?fPY4Odi8OClB7x624Qnyc1bDpUbogygnrNXXZAihbCnJ0H1nWfd+/Brdlfy6?=
 =?us-ascii?Q?TvFKaPMDt6xHvGpupiBybSpiqStEHPicPeE7qcXNxvL/PKHodXnNSfQ7ZT7q?=
 =?us-ascii?Q?ad8rmjQH9S6MaA6m3HV0MquQxv4kwT1oCCElJb4y+fPx37MxKCF8T5rKPfRe?=
 =?us-ascii?Q?pnvtVXyU0CglavRm4YSUAt9mkdHBlKRJEll7ZUlU4zjIzTNi3LDU3LWLq3sK?=
 =?us-ascii?Q?B5N+6RYo99UqfqJBecshseBQsgfh11SI97XpsRnCfO4b5c+DIqCbQXqTNZWF?=
 =?us-ascii?Q?1hwZHOlMVBBY8WtPR5y8JEwzh3ISH7dxtOfdoAWiag48hiB+xrUkFplPPoys?=
 =?us-ascii?Q?Zc4z3Qy122nj1Q6w4k++hQaygmK/O5JyYOMljVwVNbE4q9kWL/8ZV6i4mPTm?=
 =?us-ascii?Q?LS6D1h028/gb/R7aJXvxLTRxzjkY0Yn/Cj0C0g8Vft0HuRisTx5+fsyEs05R?=
 =?us-ascii?Q?0hMUPXbUlljfy3vzyi6sXU6Sy6wCbc7fWmFPSan0IByo2FeRtPP66lMZGXFL?=
 =?us-ascii?Q?H80/q4e2dzx75L8Cf8szW0TWjfSMIi3+xeqFSPTYnpoubfJReiNAEXynRRFK?=
 =?us-ascii?Q?FSsyRZtNlYMfQOaV+IGGDTH3XOUzvH7mFcdBrDQxnyp4yY2Z4SzjdwmLdro+?=
 =?us-ascii?Q?vT/L00qCmnxBgVYLFKLpUGz29up0w0SVqHZl/x+JNVJ4IY2x6qh165OWS8wH?=
 =?us-ascii?Q?VrwOQ9nNKLp6a+E5/DqBDZdjnnJc5dlIulELJBallOp5wiVyWnnwADpg8dAM?=
 =?us-ascii?Q?/qR7dVFko8GogcyAsn9zVsQJImGdW1ULYdMKVcQ0AhCneAyfnbd6eWz6jjkp?=
 =?us-ascii?Q?LmXbCf370XzMzefUy9Y41CElY8sOYpMFWRi34qnYERR1iIhEJn8LPbyHQy60?=
 =?us-ascii?Q?7CukJ+PjBo8xEj0UQHDFZ+hecShzdHLlmsgN3+ib5LqvMXrNWINYJ+7d8Gn7?=
 =?us-ascii?Q?AK9xdAxEnJzRGmS/cUXe2q/a8JRsV88HT9q5FgPiVFhQXaOqW2lar8AKITV9?=
 =?us-ascii?Q?7WSPG3BMNaqFGiherzTARrIE+w6Ns/Vi9xxTfJLIWGB8j9ny2sx2xXnsBW0G?=
 =?us-ascii?Q?O+PTFmqudjAon6U/Pwmgv8/77jsBpsxrwBQB0TX7rHameh0tmGbLB7yY+/OV?=
 =?us-ascii?Q?SUb9Iziv2YdvAfjJsucaiF58bSt7SGrgW8+iW9JyFcMFjFCF6h9dpSB8/Vb5?=
 =?us-ascii?Q?NZ1WP1X6Pc2/doeApisg3jMU4abde6J9Uwd9V1pFSZCR0x83XPfc1KhiZcZb?=
 =?us-ascii?Q?4LkJtJVUPJDckZUZcOtRWdXWW+7SEmK0sK3IchrkSTV4jwyfT+MIEezfGIKb?=
 =?us-ascii?Q?9wshb1QUGFXWiVajts0YoGX3Onfp9K3Le6BnG5pc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d75218-4f37-462e-dee5-08db26653f65
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:27:30.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NXKGs7Q4wKVUM+0dj6bgAl5ifr31iqDom0Pfu9H3rusk2pTbI1r3CuO3kG61wpYGLDLx0PKy9uhUuImG4DWvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns driver code already upstreamed. but missed dts part.

Change from v1 to v2:
1. Add binding docoument.
2. Fixed all shawn's comments

Frank Li (3):
  dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue bindings
  arm64: dts: imx8qxp: add cadence usb3 support
  arm64: dts: freescale: imx8qxp-mek: enable cadence usb3

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |  72 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  85 ++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

-- 
2.34.1

