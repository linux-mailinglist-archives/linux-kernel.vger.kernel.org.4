Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025367C6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjAZJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbjAZJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:19:11 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6216ADD;
        Thu, 26 Jan 2023 01:19:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJhd3LjZ/C65cnShPqd7EX/QeI+vNEetXKKAaqFaoyRnZImbzFpsWnu1h4NyaEQY7NUWhy/K+vlnpXqv7hHmR3v1xKeg856RjkznlNNpNaNM5DA0aW/xPdKSWSYQtOukDBdn3EECG58roufcxbJbkRn47jrNt89Tx8EiTtP4SiBIdKAAZRn4g/eYvD8Hn38fl/21mlN6bP/nyVCmbXQE0mvSx8OMp8+m+mAzsbBSu3IuvWnEYG1b/hRe/8xs4bEKQ7cNDDwajKZK30OkcYhwPNBDLja0aMiJpZdAwFap4NbA+hqDVb9H9Bm84kNbfSjwhwY2zhx4uENCd7yJpPo/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wRsHZtWcsVDbpLif8cJQpKMKocgCvOdl+7dr9GHNuY=;
 b=Lm3UM5rSCs7LRh/59wGdc+4zW5a7rELtf1Gu/osZyZR9VyjaDMl52MF+gnms1rBA5iwl7qJVGGgNKzVWfBQGFy4KNEmgy0SYPIrpY+gdNqpIp0GCt45qq8MvCCx0VwdcCqx7j50laziaRF6b9TQUFbv/ZSZY4kaS0c5MgQpB8YKuaBNXsPwFy6RBjaqAs+wUgzo9RVkI2pTvheQfnyJMxlFGmMlFZLcEKtopINX16HNo9wsD0CkEiyx3TU6GooaIvH4uYR0j78DH+NVeDKGPdZWphZEHTnUgzQug/aWC9n38hsAx2vmlewUwegc6rr5YiUojzAXfcwIaK8Kw0o+lBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wRsHZtWcsVDbpLif8cJQpKMKocgCvOdl+7dr9GHNuY=;
 b=MUucOLiY21EngF2CxoZmcfO6gZ2z6P9LhY+TQlRDezKiDmfu8Mt/sLs067DbklY16PUOQTGr0Fte6dSNrEthwUoBDyIaWLb8rtXeCnkVXoU1TRMdTubpp9i9PxoOaI3lQwtxtPpOrhBqRws/vFk6ngomsTeih7xqnqO9AhP6/u2a9oTCKQ4XwHnOaPfP1YkcK0iFQnx4xejsMAxtq/twLcMlFUblLQzIua39Ri2VMiu7XEPaVwZsx3GvbtKHPv6Ri4woNKSGAmtCjALV9VP/KSbVezl9hiFsqKCgNwwmAM8jTFA8JkfbePa9QqWdQPa0YGqBK95tH5f+e+wpWAY/cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS2PR03MB9516.eurprd03.prod.outlook.com (2603:10a6:20b:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:18:51 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 09:18:51 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manuel Traut <manuel.traut@mt.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 3/5] input: pwm-beeper: set volume levels by devicetree
Date:   Thu, 26 Jan 2023 10:18:23 +0100
Message-Id: <20230126091825.220646-4-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126091825.220646-1-manuel.traut@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS2PR03MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: aae706f1-5643-4ffe-80c6-08daff7e567d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJ1GSxyrmysgbdFWirjRg9TA7d5rI1c+GpiZqxz2IHplYbjIACgHdALu6fD01Sm5fWuCA81aYw65B1m+lsmoSZ8mhRD1t8cPy4cqFfF19V83e3SbaJvV4aIepbhLMA9fU6LnXzaVZqg+BaiDq7GoQlHFnWPPkP9CBHhIbkFALlDl4+5n6kPTtPO7QHd+ZPcsUGudKCOB0rjZnPFjha0VKIxsKg40lqytZbsQpfy4K8CzsP9AXDhdvCq7oKUUgcRaoxI8/Na3IQligxV1Y/a5BUAcbqiY/TP3AQ2ejFPh7vQ5YJh5dQY25nMxNWkuuemlnpNN+9cr0EAfxoUkzKH6EF0kDOn8sjA/rxseCIM/uxyjn7Q04BehZ94UxhuuRL+9+DFE2QEEAt4aCJnc7fr97vxlgJr5rkG9vfjX3bF03PIcqRe8MqgyEndN8Gz3mDZtadWAl7pcn8Xy2djhCnoBiDfdWhJHgn7UKGvGPRynjJIihPdBS4r0nXneZDHfgyxhVBhiXxSAiUm6Xu2LoxOKpGAiAd1grZC+opXhJIYQveL6OXNyqOIzAsAMYqCU8SThZAjcZiNOQX3ykMf+VA8EwiOGtZ1951e4kV/79aEN6W5a1vdxDP/XY15HL/C0O52UOc9CkwK1WifWBOMix/tzAj5c4Q8hKw6zdWbG4TImDoQYM6JHhihglFdVzbWW0qbc6btcvfDWO+QXxLTa/19a6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(44832011)(2906002)(38350700002)(38100700002)(2616005)(1076003)(6666004)(6506007)(6512007)(186003)(26005)(86362001)(83380400001)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(8936002)(52116002)(6486002)(478600001)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kqAWAsm84KDP9ChgQ+MY8jiaGqoNALLl4jO3hjPKCkeU+UcbiP0p11rb4Jix?=
 =?us-ascii?Q?w5kzHcYiJ34PGu3+e4MjdNvawxPOeohrhlW72Miz5h1zmemY26bVwCERgvMz?=
 =?us-ascii?Q?4LZ20SYmmuji0hkTF0TUBy0w1DFX2cxZuYLFE1IRdGzCsJCNfESO/Wwt+Ako?=
 =?us-ascii?Q?upzMiH611/YdRwwirTS20b88CDWRLCYnMsw7DfsXgn6i7phOkRHUQUBpoaTE?=
 =?us-ascii?Q?PUZ9znyYWYVciPtPZGpx5aX6vOj3NPCOKcWhTrzS4SyoLEPhPTfCi8049MXK?=
 =?us-ascii?Q?XZvjzrMbfev21S5FPGqmbBc6TlkThNEQR+SGyOCWl6EV33Gq0pXA415PY6mF?=
 =?us-ascii?Q?qtGH52CnqWyCNG+3L0m747ixyLtc4gK0AqhzE+x86FWRotdL9L9lwFfAT6Wu?=
 =?us-ascii?Q?Jjg3g9MdqmBqnGJdXnLsHbzEAZJ4kwwP9KSvULIjo+N2mFVLiH9ELWaBTEox?=
 =?us-ascii?Q?2BVXJiS4hmtiBjpb0CpBQPGAkRHk+Al9V9/Gr5NaOodSW+nk//5NP2r6L6k4?=
 =?us-ascii?Q?u3jUORfNi2wwWRbSImmE21DUWZ11oI133xOQg9Fwpmk1VMW806bVDJ91c8Oj?=
 =?us-ascii?Q?MK4T/m7McrXj2zM7eq4DFqfGHf1aYUC0fdyYYQElvNM+i86tMLvqQG17+zMO?=
 =?us-ascii?Q?A3HaqIEBEXVWZHsbiR08iQoqNssN57mF9PQIx5rIt4BwwoYmY8BWHHh8WLRI?=
 =?us-ascii?Q?TDN+IsZY2JSbfnD/MsSJhvPH6gj9YdvCiDsjzG0mwitufhZuN68xF4bb/O04?=
 =?us-ascii?Q?eTA/N7qn1KfB9NHLqHblDukNLf7Q+mAhjPnR4aRHGtvmCC1lMvYpWPNbezOq?=
 =?us-ascii?Q?iSfTUPm/EFL+xdrzCZGPdmjdHzMVQ/XTPTPhtuqYdWvaty0Smv+B6kwWJsGL?=
 =?us-ascii?Q?0d/wyKyjKsZh+/i5xci46mGxyPUSzxRK5iHr3D/5SdBvZvS2HlZUvDOajw/I?=
 =?us-ascii?Q?doASMdaZ0Ls+FNxsgQoSnsC//BeqY1wmv2oNHY877W8htKaxX0i5cMz9Ve5Q?=
 =?us-ascii?Q?SXm3AynFYrTtFs6dCdMuTFacnOoVgSGA6eR/tZzou+MGH5bzV6idSdBuH7et?=
 =?us-ascii?Q?3R1ZhZZfOjZ/ConvwrRNMJ4qfRRf0PphYktdTSPuu3BIk93eOf5WCtq43eVM?=
 =?us-ascii?Q?ASeVBSXr242M9BBnurdtmOp6rpS1p+eRCL9fc5ofOtcn1Ayp7vv1w9Z0isv0?=
 =?us-ascii?Q?/FXjUdpIeqwaNj9r1Y++sccZAMHZcP0a5uV+PqcVttzfWs4EK+kYrIC7+gQZ?=
 =?us-ascii?Q?qcVCBTp1wYsmJvg97Cqba0uWjMVqyjCaYequFsHIJTClUIbgbXoi3Z92BgHW?=
 =?us-ascii?Q?JZ3/noP6kTqPOt/XRIgacGekKPSU3XGsp3XyezneZDc4aE/2zswm5mzWeX8J?=
 =?us-ascii?Q?29WICkXhl/DMcyjtmfPBCmLk6Ni72sSC3t5TGvAeFL21lzNKMSzCyAzSkN/T?=
 =?us-ascii?Q?r791fZTJrBOzAqPYiGNhgF6+YlaK2Ald7zSFkQ3d3L2E9a2iYW7jIr1HMYs9?=
 =?us-ascii?Q?X5Y7o6boZy0TB5U4qPzzI8Yi2jTX/XKGAbrzka3ztu85Ioz547jgc6m6onqR?=
 =?us-ascii?Q?L2sxu5uVL0iwcETh4nT1LxeAN7LgyZ/fjzCcAIpD?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae706f1-5643-4ffe-80c6-08daff7e567d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:18:50.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoQwFjQiLuAT4tU8/XHidCVGj50qnkZZp1T8slS4F7vABxnkH4X0ASMDFfGhQLKqTU2Y+FHe/sfZq04B7I1RiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add devicetree bindings to define supported volume levels and the
default volume level.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Tested-by: Manuel Traut <manuel.traut@mt.com>
---
 drivers/input/misc/pwm-beeper.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 865e1ec5c39d..82b05f7f4c70 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -181,8 +181,9 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_beeper *beeper;
 	struct pwm_state state;
 	u32 bell_frequency;
-	int error;
+	int error, length;
 	size_t size;
+	u32 value;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -228,23 +229,46 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	beeper->bell_frequency = bell_frequency;
 
-	beeper->max_volume = 4;
-
-	size = sizeof(*beeper->volume_levels) *
-		(beeper->max_volume + 1);
-
-	beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
-		GFP_KERNEL);
-	if (!beeper->volume_levels)
-		return -ENOMEM;
-
-	beeper->volume_levels[0] = 0;
-	beeper->volume_levels[1] = 8;
-	beeper->volume_levels[2] = 20;
-	beeper->volume_levels[3] = 40;
-	beeper->volume_levels[4] = 500;
+	/* determine the number of volume levels */
+	length = device_property_read_u32_array(&pdev->dev, "volume-levels", NULL, 0);
+	if (length <= 0) {
+		dev_dbg(&pdev->dev, "no volume levels specified, using max volume\n");
+		beeper->max_volume = 1;
+	} else
+		beeper->max_volume = length;
+
+	/* read volume levels from DT property */
+	if (beeper->max_volume > 0) {
+		size = sizeof(*beeper->volume_levels) *	beeper->max_volume;
+
+		beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
+			GFP_KERNEL);
+		if (!beeper->volume_levels)
+			return -ENOMEM;
+
+		if (length > 0) {
+			error = device_property_read_u32_array(&pdev->dev, "volume-levels",
+						beeper->volume_levels,
+						beeper->max_volume);
+
+			if (error < 0)
+				return error;
+
+			error = device_property_read_u32(&pdev->dev, "default-volume-level",
+						   &value);
+
+			if (error < 0) {
+				dev_dbg(&pdev->dev, "no default volume specified, using max volume\n");
+				value = beeper->max_volume - 1;
+			}
+		} else {
+			beeper->volume_levels[0] = 500;
+			value = 0;
+		}
 
-	beeper->volume = beeper->max_volume;
+		beeper->volume = value;
+		beeper->max_volume--;
+	}
 
 	beeper->input = devm_input_allocate_device(dev);
 	if (!beeper->input) {
-- 
2.39.0

