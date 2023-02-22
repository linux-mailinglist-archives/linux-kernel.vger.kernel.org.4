Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3969F38B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjBVLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjBVLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:40:13 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B23360AF;
        Wed, 22 Feb 2023 03:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipu/BJynVblk+mg8O4GQ4NOZPjtn6f1H7PYZJm55nhxRO1hqTXl2rrrFWMrC5ATIAsRJFHefbuAyHwZHhD+jci2Y9RnH+XPJfvwbWzMk68icL03kCrKLukJqRcvBo6z+mzhzo4feRj9vIdxTZLmFJNSZM+ry6uSaU/Q6/lVkn62yPzY+bZn8RztlAaTmt2MxahirfFYcUp+nD0ZqKpES152jcXTyghxcHBwDKWiyd9IcKg9d+soyfcsmM0WnJ1uhH1Ji5MHaHXDbIJeBae8ml2hVGv5n1og09iWNptWeGeEzxyU5h/0pBw4TMHSblvYttXjWtEY69D/PjqRL56nvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16gx14VMElIdQbEwI64FhXCGTS9xRY4+XPbRhlGeT7M=;
 b=bdcxpF1guzGN3gfMf2FGUVaKGVoc2nxXrlSmHoeqwy/YAfv8kHiY1R4lBQA2srNqJMZ+mIp0fkxt9iSFDx4d5jG37ac1xZ047/y4Mg91J89krr/SH6mIXHdCRKgTjUmwJ7x1U6dbK7GtXPrA6OTvXTn2ogvUknwF7vitqoYMgf3nW4RSa20vsCT5POirOeQas/IhRabDL2fHosdvr1YXl5NL4BT23P81uPjy4hPcrmKWGSSIG+uHa//+Gzb03gRYwNYP9T96d3hERVEvTuwp8pBaQBURtUjZUWF1cu68eh+x44lN3iZcBjvenGWJu4R+UpLdG78Tjptafqh/6WEXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16gx14VMElIdQbEwI64FhXCGTS9xRY4+XPbRhlGeT7M=;
 b=EMrQyyZpVOl7lRYv9mC2pDIBGXGFOA6aWTMXfjs25+8eyWI5Koq9+Ct4l1auP9VuA+t0VXv58MBeVdPKCmGWhFSV9NL+XKGvJ5yIRUQ8SmLn2OBd4+wQ+N90edA43TNm9QwmpVn9foz/BYuntkkibPzPfmqqDqMq9oukgFG8Tdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 11:40:10 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 11:40:10 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to specify power up sequency time
Date:   Wed, 22 Feb 2023 19:39:43 +0800
Message-Id: <20230222113945.3390672-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222113945.3390672-1-chancel.liu@nxp.com>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: fe21a4c0-040e-40bb-80e6-08db14c98d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+IO61UdYVZHdIVKk/zgjm0vYW/4+S9QQl54D6XC7OeBr7TiHm3UDe2Vo9fJpHtBvg7jwY/v00DpBfQmKvQMRcd7GLuggL93SbIokKHLSCc+y1O4orDwlcy7qlzSnqudh6uDuzXAGoIP8rJWwgLjaW7IH6G87V8wZqX0SKf0agBMIY518jGpkQSpinJU2YrSfw5ozFSI+XiNRsKuO8eZoGWFJIIx9gEgkYltjjtSRzlTuJZj17KNaaVGsEI8huqddQItbYySLO5Rcbvj2mYtTPOwcH+H1h25ss6nzJeuxGN3up7ZCBHI243LWpvwGvZPVd/wDdxZfXHGcp0aaI2u156++BuTKN8UNWmQw3A57QCIlXiXkjEsGacwiwmVi/84jrL2eUBY4JHDxIqcQX4LpMRrq6a6f1UqnOMlxxIlihOdPXTYEqiY+BPdv8HS9qlvWA8b5Tpqv/f19skYHjxo8Pj2W+LjnZKss7kemQR9zEQWWsB1u9xJkIx2DKBeZxrhxSejODGIOWDzXbeK8fwlCR7J8w1T9cu4E/N9VO9vKjug+zIpj3LRsSLJLxgpKfqrA1ePmC53DLE6X+WoG9iuYx53VPwWaQEluvH4qzuG8mBBgNYMoOz1iRzwFC2KF9RWQjElXr4Lrsm3KrTNeogQnba9nmMTOes4QppVyVrLuoZofWkWZ7kbQVYG+2GlolEbw8xGCt3cJIjhfq9UdwwZYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(44832011)(36756003)(2906002)(5660300002)(7416002)(1076003)(6486002)(86362001)(6666004)(6512007)(478600001)(966005)(8936002)(41300700001)(52116002)(38350700002)(38100700002)(2616005)(26005)(186003)(921005)(6506007)(66476007)(316002)(8676002)(66556008)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9TABfv2TOfbvMyKltvIrijbsw/6zicFml/Y24aJqWt9Uq7JUl7gEgZoKWHne?=
 =?us-ascii?Q?F6C9A1O5j+H7WS56mbVlguTGAVRv26yXxWE2H1XNNRGX1labfexqDq0Xznp+?=
 =?us-ascii?Q?IDPNco8unBCYxYi8f1088FP+HvWiUyVTpZuZg8vNLgrGBHLQ+hpvDZTVLofS?=
 =?us-ascii?Q?m1B5XTiapfQZ6QJFbKqCgX2hha5MInVTZYQVrhFN5AOJemaODTkFa2Qs/vo+?=
 =?us-ascii?Q?4YvD9KExz00XBO/FuSK+sNE/NJ6qyHnA7BaJxD3E5aPrI7T9vRG+UXdmyACT?=
 =?us-ascii?Q?kUORjSdtRfzGNusBBsf+LBg7UpQHouEBx+rO9lMAwl3zTdMTo95zLt8os2/Z?=
 =?us-ascii?Q?hAswK3ow3xS63ettdk3iK98euN4cCqHRoVFKqxvX321tEWIkK2DXytCiC4mO?=
 =?us-ascii?Q?7vjmqtKiyDO3ii6Vk5JnpHgK+raHQKHONJMbjhyYOwiCznpEbuWgCm9x82UD?=
 =?us-ascii?Q?VkHYuVBYHfV8cH3wv+kzoq6CjpyTOPTFmc3SvVraOwNNs7NglRSN+VDwgZnM?=
 =?us-ascii?Q?kAjZYIvMsvD6xDuiRAv8smohQs2AM9sWh8Dpm17Wos2lHLf8bcdzTlBG+sw+?=
 =?us-ascii?Q?UbOfh0gsgVjrHUPDG2yK+JbUR682vfo4isy+uKNNey1q8IFPcFir45yIoNiV?=
 =?us-ascii?Q?CAEfhVxutKssBd9CpbatNVkpReL0agWDLDoBUx1GtIYXyayDTRPgDcxEGHDb?=
 =?us-ascii?Q?Y1W9mMdTdIaWkGU9FO80WVJcW5xyltp3SicZFv5yjQXCdkrFLJBeOmxBPG47?=
 =?us-ascii?Q?FrIWB6Zp7hPbsnj/US8/izPxncS/evDpv3c/pmi1++ZDe1ocvSZLwp+zoWYi?=
 =?us-ascii?Q?4ClBjBtdJEbdVi2hdpGiE6pS/ZQcPA2DusPt4/TTguw/GzqmKwzZsg1zBCGe?=
 =?us-ascii?Q?1yGgNkRuEke111sE29Ui/ggn7lwcB5IULtB38qc1hWIST68wJvm1PtuC6SZe?=
 =?us-ascii?Q?JPW27z5S78NJNwDC6mdO4rR7THRqL4yRWpIwgP5NjMDYwSZdJyaWqAdt7Wbr?=
 =?us-ascii?Q?WRdmXpJeewIohUt6nifJzNPEN6sB142VhYpaLNlsH8vxr2Uga2msHWU0HpJj?=
 =?us-ascii?Q?Nn/Fzt8T2zIJ/KZYfPlxmxBnNeoX1IJehTCFQML4AP3iAvN5D7HckO4F/Q+i?=
 =?us-ascii?Q?tUo8YsZqy2IwSWaKdxTjl7uvrLohg5T0MOXCUFp4iop6xDFKvsRevfqoARcO?=
 =?us-ascii?Q?6sHCd3D+NuuAt49jACKiXW/C1FziiJu52AFWdJe+sxin17JWHdzFeFtOpeFu?=
 =?us-ascii?Q?lpl0ZF7zRcOE6pQRLx/TgrZRS3sl6ANAedtOEyZESpXz97El+te0KQnXC2C2?=
 =?us-ascii?Q?GLbP1ZM50nn4iRlKi+g5ZRjo0SqFwRs6sRqF2iQxVvSsEX/3KtEWbzxf5nfr?=
 =?us-ascii?Q?27EQkQW6V7ilNC0KHCElxApewip3F1Mob+1G6ypwgoc6dsHKp2tNKWr8sqop?=
 =?us-ascii?Q?36bV8K4HP4RrREesBOvlb6YqL8bDrE6pwbCLxvU3Zcgx/JLc1ZJnzVKAmv59?=
 =?us-ascii?Q?o3kSAsAwcCjRxdZfzglJMSbeiWxtFQzMrSLCjysyqvVnif3HyXwUJCyqz/T0?=
 =?us-ascii?Q?E9mOB3Knsk5W/htzZhrWgCLbpnbS068HlTIxQIFj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe21a4c0-040e-40bb-80e6-08db14c98d83
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 11:40:10.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqU1rth1RrXjF3zajrgjpTpTr5dtGyMbyPrYEBOuX1SdQatgpBdFoStcf6CqaX1fovw89+LeiRUPDwug86ZFzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property specifies power up to audio out time. It's necessary
beacause this device has to wait some time before ready to output audio
after MCLK, BCLK and MUTE=1 are enabled. For more details about the
timing constraints, please refer to WTN0302 on
https://www.cirrus.com/products/wm8524/

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 .../devicetree/bindings/sound/wlf,wm8524.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
index 09c54cc7de95..54b4da5470e4 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
@@ -21,6 +21,15 @@ properties:
     description:
       a GPIO spec for the MUTE pin.
 
+  wlf,power-up-delay-ms:
+    maximum: 1500
+    default: 100
+    description:
+      Power up sequency delay time in millisecond. It specifies power up to
+      audio out time. For more details about the timing constraints of this
+      device, please refer to WTN0302 on
+      https://www.cirrus.com/products/wm8524/.
+
 required:
   - compatible
   - wlf,mute-gpios
@@ -34,4 +43,5 @@ examples:
     wm8524: codec {
             compatible = "wlf,wm8524";
             wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+            wlf,power-up-delay-ms = <300>;
     };
-- 
2.25.1

