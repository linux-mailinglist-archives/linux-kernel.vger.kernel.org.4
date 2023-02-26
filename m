Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D351C6A2FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBZNHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBZNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:07:38 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71A6588;
        Sun, 26 Feb 2023 05:07:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPvoD2TCoQ2zd82IkzrlHaipolR76tcBk36gsvX3XQulNCD+DySzINr/jfVkabYFaRg7ECLD6G2WHeBySMWR23/CNLtXRorC6zu++hAn5QNCIHNU6HoZu4xA6aes0eFEKkPNF3dylgjTvsTM422F0kgT6OZWkuXDWXEZvsoXIxCplX3RFKOkD6nxxTG8d2BY8CPrEya1ggtCzmcKFrip8CxXa+ARvL8oG4tvmAqAOjb7jfb4eHrlXei9Y62xiGO4KAgOO4UTkYcwiacFMLXbEWdJhZuSvJ6xJXR72N0GtGRy6UGU7DcUCqlMY83Cu63LbTYo+tcvEHNOYyVSX51bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGMV75Rq2mXkb0yBPoDX3To722ECjdR76+Nggp8TojM=;
 b=nGMLBmjJqudjURkjLpxyHNbdM+reGaqpLXFCMIL1iYtrpUj4zBNrUB9LUfOrL8DgDSWzzRGcCMNli5UbQpF9bvvtX358dO5nXoET7aE0HRMFOK5jvtskkdGpuo3FhSs2vCnWJP0UKLsGSgyuwAGyu45dmZLCYzqdf92r5WROcQObPjwfL8GcPofyaYf7lphhJrdKUJjiqbwLYUpfi5+LoOCZTNhh4KLFgXRkak9dMb2OoSxlL2QS+0CyCAF7XX03UnIltvjJd4KrmyXGeO3WbNiEQxGVcEg81KyjJSXrReTwyj3Y+BN1IvE2dAG9WAZOYyaBE1N1tPOZfxkbFExvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGMV75Rq2mXkb0yBPoDX3To722ECjdR76+Nggp8TojM=;
 b=SYtBD8uLjAUoQqsrDGToBDtwvT4YSzgLUVMdehqJL9pD6WUFXFoa9Uxd1opLdVSlmcQt/FQpCn8C/iP1rRLrUcb/wAxYb33Ypli1ECn10O8SW5mTcyayO/nYZjcpRqQdhLTdTvsJE/W1KhrKS2z9sh7Tmtb8iFshJwjg9aR618Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:07:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:07:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] ARM: dts: imx6sll: e60k02: fix usbotg1 pinctrl
Date:   Sun, 26 Feb 2023 21:12:13 +0800
Message-Id: <20230226131214.278911-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226131214.278911-1-peng.fan@oss.nxp.com>
References: <20230226131214.278911-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c58d40-f08b-44ae-b206-08db17fa6d45
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEOQZ5eCysDMKHkDexXpn/bCRHCBUJqWbtYoa+wIsFyAs6ytapYZSg50R+k21RVo0A6qW15lM4jQkk98H7EYxUo2AHF+5oko6XyrLxQbOSM681TxgRsvj2HczTuIsRLEZ7LQ/RpA9O+61GnNf88k7QbLiDZ78T82wdlf4WyHI0P1Jsef8fXTY3wK6dBdGzcdnIilVDiKqpWQcfuddriaoIfBCSWQkSYcI30W4PvMDRn08uSEy4FlbAHvgO1HbUNFgfd0OdUmLEgFGLr8KI+ZiQx9ChZxtthb+B9+gEwADY2rQN6Q6kxOKYuWBeVysTFkYgS7gh5tnbZxIKKa3a4uBhtB61hibRWRiCkFlTrHYhFs+OTVEO54EN0fMWbFJB4kXxb2/ZuzUnEioH9SY8p2xluBxT4OM7OWYoXMYORbKUQH5aNhHuVAV5aeebtPKXBdIubciT9nebvXsEkXJdcoNVDCaRGI/M0M55HhmNDyFvoBAYeCWWVdSibe++UjBULf/XxFNNG5udVBnq2YH+Q7brslkfrCQ5AiJtBkEbarnXQTncdXdMcSXsgYS3jKHkuKTrf8+uIx8xScWC8RbjbgZ2CG5i1MdvutIxygEdj/4RlBX0D+mkNjtDgDYzgRikdAcZPg45RgzPMxo+nQbE+z3yeLsxD8WQZHPW6nJaZWYsGiVRLECJCXLDT3iZerrTp12cBJwmV4/oZ/+MhOlNY7fMTaAz1O5iDAe3FWHXXCHfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(1076003)(26005)(186003)(41300700001)(6506007)(6512007)(6666004)(478600001)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(6486002)(52116002)(86362001)(4744005)(2616005)(8936002)(5660300002)(38100700002)(38350700002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbunAH/y5A2AIrv3cK8vLscTMuhCPy3eqcsLVruJspwLED/AXpAZrD4ABWfb?=
 =?us-ascii?Q?R+KCLo7nyYdjCBSM+YY4VRZzA+L51l/knDFSHDIuqChSrAcvFmaUG/AQvmTZ?=
 =?us-ascii?Q?MYXNMWsXslu0UrBRoEHE1qi8ZSUtRxk2pV7Qq6b8EBm7Yax4Cg6OVICh4T7r?=
 =?us-ascii?Q?M46E/7r05AWr55NkzSqyopELmVHOBDQ4xIQViYFuRs1qvs70RASXMmaWM7dt?=
 =?us-ascii?Q?fOAFkShBMF3A/AdrJAT9HPEzCgIoQ52e+U6Qq3gxfPlalqKWmWzj9ZuqLTOs?=
 =?us-ascii?Q?oVFteJLkMCzDiLlj35cjcYsK2/cqNqetgpt2ilopF9Oa47TDUOcCiuo2Bp8r?=
 =?us-ascii?Q?qjNT6J1FqcUQq2VjAXyWc1fsjWgAb+/gUyZ/iIgqzQfJnQX+NtFXfBKBLofP?=
 =?us-ascii?Q?2ixoGq+nLH09dKoL/y+G0b3VZxcZvPeTJ/QfbcEhESkFEoAgspmdGV/+lhs7?=
 =?us-ascii?Q?l4InKbhdJlFR9UJcnlTHp5Vx2Nz2UmYJ/PEnA5TCBgsBFqDiWrOURB17jpxW?=
 =?us-ascii?Q?FrvnRd9WarvZEEa0Pub0XleVPjdXxGG2SYOVxR65VFdsZbm7E/7XtV9Y/ajw?=
 =?us-ascii?Q?mERd247dyWQkAzXeqL3fmRBcxiyhVCP39tjul14q6GAzuGamA0Hyuj3CZ1Gt?=
 =?us-ascii?Q?WdRjhRkPiRW3rduBxWjLa5L4YctGy1OjqqQnSAtiG7kuun5jq3FvsGkvtQ/7?=
 =?us-ascii?Q?oPqIXogGaJrK7PKt9Cwn2pKbvv6tVFGluZ8BXDk3go8/TctqmdJV+XXjx3PN?=
 =?us-ascii?Q?D5/polCzSDHbcm+iTlYDKkRievn+URs8lLHJlRzaAqyjDxwNisHgSZ9WRXPi?=
 =?us-ascii?Q?+aabIaEasgpXr69EaaWotPouEK+lopBSg8rS+2wYMqnmlkN1SZSCLbLyigkD?=
 =?us-ascii?Q?lmZpRJvH02pXzfhR89X/bK0TR7C4MJNwlTb1pJ0U6LGUsvFCLuQPxmjqATlj?=
 =?us-ascii?Q?CZtfxab6S6E87Kpp11k+TpCMkczQ+Kh3Tag7e5zxtuSrhYDUxBHBpDkqV981?=
 =?us-ascii?Q?BYq92qphaLGsBTqUJdohS2asaQlJnO2Kzu1ueXKAxn+R+mdyRGw4/RhAGWCB?=
 =?us-ascii?Q?2lbRnIgVxqfC5YtxRdz4QUf6ZU1HBs7a/gfUul14eV/UUhqyr4m5E66rEN3W?=
 =?us-ascii?Q?tTus3YX1aR4hJMqI2Vuh60lP8Wj9uDLWVLhYEcW0w6byV8E9dGHXldc0jrtO?=
 =?us-ascii?Q?vZfkOCAMbMe/2on/2xzCo6vaq2b7yFRBHDAQQkf+rFWxyPijgrEC4+Mc/f5i?=
 =?us-ascii?Q?Mx9ZsEjjiPy5zryDBTu8GdZvL8qcufYp6K89ed6duMR7/dxYQVtKEhd5fraP?=
 =?us-ascii?Q?v+6pN7V1n6PrDxtTavW3rcwFkqq5aUYj3E/ZNKMUSsOIFb/pf4+/10PCc6M5?=
 =?us-ascii?Q?rYK+m+/R6vUeLWFHICZA/lN4kRRuXJI+5ijDx6ZoPHeFHrmC+Oi1Yihayi8J?=
 =?us-ascii?Q?e57bgq+l1XfyeUCYyZrRiBpAyw7N4AZb9BB4+MD/hziGqae/KBX0F7eR0dth?=
 =?us-ascii?Q?NGhksZPG71/LbA0mMDjyh9UlC2G36rp696gGBwPyMXZcmkIxkYJ2fld94h23?=
 =?us-ascii?Q?e7iQXzrywVXbTk6nOlxkNa9f3lnqx82jatTtZtFv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c58d40-f08b-44ae-b206-08db17fa6d45
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:07:34.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAxV9r49kQokZPaCE4d3roRU6065RGtXNp5XvtxXGBMWF0ti7I758A8Sj71lJbTu+7puUCjlIm9IGkMwPEE9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

usb@2184000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/e60k02.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index 94944cc21931..dd03e3860f97 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -311,6 +311,7 @@ &usdhc3 {
 
 &usbotg1 {
 	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	disable-over-current;
 	srp-disable;
 	hnp-disable;
-- 
2.37.1

