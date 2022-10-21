Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B2607F41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJUTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJUTrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:47:15 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2133.outbound.protection.outlook.com [40.107.103.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5952995D1;
        Fri, 21 Oct 2022 12:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMdvV7s14r9LVFA4WWS/MTVDXYgu3bL8h6rhd09xvVdLWS6KQOAUHFC1iJVBpQKa4jVcUgfatuU5DzKcWAmpNfNXKiMQgLPJY/GwOIGVq8iQOP/8GikNLp9K/gI2XKvdKD28irBXne3YgbrlWx5tlbmeXdiUBWZbTN9P5H/eQ20TraEoEK0KY8wDMtJqYSqXYjA5bYRuUuHqYUM4HDi1J60qWthUcZM60l8lcaWQsFGRX4BszzHsQWGAEayGML8+NuI3LOqBeA55252qWEDrJ5rX7HM7a7wScdQTXpK86/NFWr7qbaOcWl53ejnVercRDKwBCwFa4eJWPHcBus0X5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=KdzCl8rz8X1/hufYkNAUKI5nh6NrmjP6UTGLtaz+6Qt7OdGlTKH8QkckFMLS02k1g56xp4iT/A7D0dBIvewzopbGJ3UrlGwqNtRL0O1gfo99iyqQwJUSU1rs+oSNtEZioAj1+WAGk8wttpCxWwtRqwU3FnnsDi9YDLkCHxeR4H+onCJWYz189YlTx2Jl+YW7D+YAP6wSydvB+dGicAXHrYFJIjGkd6LvadDorDJaJw5RtKZJ+SDK1KWkC4hwkmT/ZBCRudLsXR5r2skR4tJQDTM7hPdMc92YTl+ttUX2MzBW6c48p8YO7rSxiVk+9li1MFA51YhNos04K2/gRGKmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=keTz0JlaCay01yW6E2mFvzPz+jPuUUzTkvuD9pt7TU4d8t9ayqD7Upt47qJVd19tXx4TiwSPjpRgy0KYE01ehj805ib8Xh9LjwhZJgQrUTdGmoEC6QaituzmbX0/0GbBijDmYnZ8DZXJTxj5ihEPctv8q7pNjUgX1kn44lm3iOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1719.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:281::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 19:47:12 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 19:47:12 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 2/2] arm64: dts: marvell: cp11x: Fix nand_controller node name according to YAML
Date:   Fri, 21 Oct 2022 22:45:50 +0300
Message-Id: <20221021194552.683-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021194552.683-1-vadym.kochan@plvision.eu>
References: <20221021194552.683-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1719:EE_
X-MS-Office365-Filtering-Correlation-Id: 238d46d4-badd-41c0-2afe-08dab39d0c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViiMWcZcmTtYU8sOK2uHnbqHVLW7QcK0Xp0w6fhNy2NYDzufVRycDhdoERgnlQLuid/c3mJZii9Scgbgh7Ni4n5GZnoh86Cbi5HMx5T2em7OR/v9WvUmI9Sw3qGWVsvjv6lejxMBGiZv3tmEnuhmGzCmRvKLIpFPOnnGB9TCO8JiAG15/eCVJ8ce5oq807zsIBa0qhEFaSVFhMRgT+foqzXUW3x8XmyYox3Wqnn8zsXFjBPf+RaW343AojW0ONCB4gla96TjUXJF0ZDWfhd++Y7yimf5nWHhB8ePfQb+FpueFkBQ1CGfnW64/LrRyTBJFgigUgRDZQSqrNr1I8BqlLNMfFleoQ3asu8leC7pyLIhF8WV6rxJIMKYqegHp7fbcFGjTdx8Ulu86TATod5a4wzjfLbMrW5WXxm780tA0v0cKHhBOyiGkBBA0xklCEuw4VWeDss/nYZScqpW9spvMjtbc2cy/rArrBEQOT2VIwKU8ks4+7MqHYV2SCl3LJd88vGCGM07Cq9Gh9XLQ5k3/0+HHeHxyrlJFBGVGEXoSjEN7niWglKmvjVQihw2htXJT2rgFc0r0K0nND9BkHzyu58rv1EAwVGA0gY5iglHc68Plo81h5IB/BYEOj/7NlXiUuXBaoe/quPkM8W72u357M6v1UQ7Sau9Nq4srgpWe4UkUneZDaW81VwZwF9nj3/rXZaKNA73lwziIwZVIC9130RgGmJaIaQBrzXTssGXSSu+BTI4vahvS316hyHX3ZNsx9DgZy5NrvKRK4pgo0/Fug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(39830400003)(396003)(376002)(366004)(136003)(346002)(451199015)(5660300002)(186003)(8676002)(2906002)(26005)(4326008)(921005)(86362001)(2616005)(508600001)(66556008)(38100700002)(36756003)(110136005)(66476007)(6512007)(38350700002)(107886003)(6666004)(66946007)(54906003)(83380400001)(41300700001)(316002)(8936002)(41320700001)(44832011)(1076003)(4744005)(6506007)(6486002)(7416002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luw9N0tCyd5ToF5A/DeWtQEpG5axmhZy47WR+FdZ/ooQNd54NAmfCUdMtnTM?=
 =?us-ascii?Q?9Ofe4k14d+X56p4scmLtizCXpWnmG1THB7VhzkF5JslW4Lt9w8DpVPdsyfnw?=
 =?us-ascii?Q?wOVAFYoDt6iVOq3Y229jBjn/S+bQ5EL8w6XFXvuO9l7a4nCIpGogpW0ORcs/?=
 =?us-ascii?Q?GjYowB1dmCW0t3SutvAf1vemQr3yurub9iJeTk1O2Bf3YDBMO0Gg9jN1nVdC?=
 =?us-ascii?Q?7QMnCiEhj1ljZHszMvPMutdYAt6ZhG3Vo5hO8Tl8jwVrmlrKwwTchme0+YtO?=
 =?us-ascii?Q?+qjag33rGujMCGoUXvX7WrLi9DcUJMOB/Aq+aFIOPzGK4UjiezxQwIRQ1tX0?=
 =?us-ascii?Q?J+TMvOkqAdIU3e2AytEeovEqxEPCz2CZ7dCd29pmQ3q9WdfvLoW251ko56ay?=
 =?us-ascii?Q?GqgganNg4bH0A+i73pZ61Th09gUCIBYdaJjuLA7D5y7wDx6FyrPFvlEUIyq+?=
 =?us-ascii?Q?9KDJPJvyXm1RjMLRD+nzGPOwZ2vzZo9+PtI4O1/BVUHrfR/TSgAfz3Rb5Z8T?=
 =?us-ascii?Q?jAtRlHmjwujPg04hGHUyu+gwIRQyh/To18qbqy5IdAj5gQi43zB9fkmKeB/p?=
 =?us-ascii?Q?iN3c6dyaGBQI+/V8MnDFbnosnzFYWbc96ysPrnI4hZcekZ9IQJWEuuAzzAvu?=
 =?us-ascii?Q?O7A3qMoUpFPNAkcVeqVHGFmCmB2OlDAbo89jm4cNVo5wTonxqJdNiYNV5hnO?=
 =?us-ascii?Q?0gNgziPfWTDk76Pi2xVuBe0NZXFNg4iHEFHsNYrHhec4fIPx7+v4V5TegAKv?=
 =?us-ascii?Q?l5OCVVkVqKORfDhq/tF//lYNAgkDkdacZZXQORxP6jiEjDY8Ln1PkP3ZM0XI?=
 =?us-ascii?Q?j9t59tr6Q79xGTHevB5cVmnCS49xNFIaZlxWAGflMmThU2jkTswGC6dKgd5/?=
 =?us-ascii?Q?WFQG8U2uQwm086Xt37gfN9AQNNWGkWspl/AHZB9bm38y0sw5seE+pfrOm+dU?=
 =?us-ascii?Q?WJoluLkfPkg8n/TLY8LIk75GZAHbXHDtTnugVMXbUbjIyBe5AAautfmWDawG?=
 =?us-ascii?Q?ijUDAnA8W9NpNi3PLrhpTWyHGeDnw5kmJ8jOq0OmdxixVKq4ltqKFE/mxFMN?=
 =?us-ascii?Q?Nf5Jhxqej0qIOpsb5n4TzevGWN7lI+MGaFNu50e2WgU7BgsyI9+tcj8ASrsf?=
 =?us-ascii?Q?xyJutgeBkjuCzTLVIGBVTfQk9KvZdp5ioK9srwrSJHrvATDWAywz0aAW7Krz?=
 =?us-ascii?Q?or399JPyvEUeJWGMSMvdN63seKIT1aQyCHZOGvl+sH7qVybvBsMuithgEWJm?=
 =?us-ascii?Q?i+gnlf6NUFXYajH9mVtZqrj4UULx2WqTpSzDYiGoaFxIRGzk0DAKsJsZ9hlp?=
 =?us-ascii?Q?5Ocg2qVR+legSPwdZxWw40TBoAlv6f33htBJ2WTp8Tydxypn6zuZtK9vx8ds?=
 =?us-ascii?Q?FNXYYBOPAE/8GO5h9pGYgrQaUNZISj1ixd8GaZRLx+V6pK/aTF+RSynxMFtf?=
 =?us-ascii?Q?lkf9Tmp0Jmw0WzsXSeCcUyjb5IAxoTBotWQXDFVyAMgq0ksWUgPmS+U5pXXy?=
 =?us-ascii?Q?OAVrcKcV3n8OFAFLhg+n6WypXRq0Mfxrk5M6WPmzAf2TGxXurDOAiE8AxlDJ?=
 =?us-ascii?Q?9HAGWaBYF0Vm9JStMuz72sjIxCPuho4vNtTGUcfUhw/njGSBF4+2QLQtAEdU?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d46d4-badd-41c0-2afe-08dab39d0c42
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 19:47:12.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJrVXvurJ7qCQrKcV1BKlwihYpeHIjgSnTKQxLbAfuZerjD13TAPFz6Elp+pTud0XYxurRFOAsL2f6wuIMraYVCYUmCjfQXpjurSUbFceUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell NAND controller has now YAML to validate it's DT bindings, so
change the node name of cp11x DTSI as it is required by nand-controller.yaml

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 7d0043824f2a..982b180b33e6 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -468,7 +468,7 @@
 			status = "disabled";
 		};
 
-		CP11X_LABEL(nand_controller): nand@720000 {
+		CP11X_LABEL(nand_controller): nand-controller@720000 {
 			/*
 			 * Due to the limitation of the pins available
 			 * this controller is only usable on the CPM
-- 
2.17.1

