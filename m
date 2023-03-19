Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915356C011C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCSLwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjCSLwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:52:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3926F23652;
        Sun, 19 Mar 2023 04:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxpJIBkU4z0B3T8InxC6yw5Lm0XvnzXQc/r+UZUj3UdExYOf6ZQVy+LOZokvhWuP5YQE/fzBPOc+CrnXnCE55ZXkUya1Z+TVg0/64kN0sV5e3yU8octzKSZoKbUPPxcSjLrSWbyg9gIqhg4tt6bgJGIxgLpc189jnXjHyVkaUqykiHPJCqtDUhUXW5GM+qLL8y7o76JkQPThOvLtF5+8vQpepMtb39pIWTaLDYwqGcRaJfoHYOO7Gpqnp0Pfj6h7+GH39/YJzdNtSvwYQlv3XSPlB4M3ftVTuBk5qcw1bkZBVAeyOuZKNbcjmE8fuNTFqPxj8BzA1BxZOoKeVvzsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJNo2IgufYk97JEDBsaiPrlY61EOTpQspqwn9wxkVZI=;
 b=isimr2lQVk/snzpVp9l3LgO5WEMyJ0nPlE5URGEXI1INgXL8SQtoYoAOalXviHLV86vb3J2Y7LZ3tGp9p97XVBG/AAP0Pg3C2PFYJu+Xr8XMFAtPG4zEOdaT7Y6CKaLV4UDG/1qM4HOHiWn6zjZrDu0733DE+OVZBDz9uhUg81oDHC+j7wONn8xOR1Zeb4B9Ru5CvL5t7zFo5uCQIPZ2BAc7yC02MxD86yql5xDQHrP0TD65CCWcp38Dyis3VM5FV/faV3rmJJGEn2bvqY3aWDgFRXsIRDcP2nOM018PSF5cwWmP6oud/tJaiML8wC8fCM2RZitKIqlxpBYtDLuwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJNo2IgufYk97JEDBsaiPrlY61EOTpQspqwn9wxkVZI=;
 b=W2pViOZmZY53VmyB0Rgla9tzxgD/FrfiDeq5o36wAiPWhb0EMjSqOW1E9cPEH3Em9AHV6PBD03Y9Ax1IYEe0I335kLpFeVlxlWINC1YY/F1MxSpPqR+744OWtbSj/aKBNxNIi39JxW6Uj80fQJnyWQCYy76mQnJ7hehBVDgcVnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 11:50:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 7/9] arm64: dts: imx8dxl: drop #stream-id-cells for usb node
Date:   Sun, 19 Mar 2023 19:54:54 +0800
Message-Id: <20230319115456.716969-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: ea30315c-c106-4abd-aff2-08db28701ea6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqkG5BGOpGW/f9wbIubE651xHjkIuroS0sxIWmkVd2C2PaKhpkzwYKloAtgHJ+RlwQvvQoTvVmakJmvtUAa6y9nWbFcX1P39+MaC4eW72t1MQs2DUrRTP82+GPnXPqpO5sVhdA+ctmSSmQkCvWil9G8KmMKpy+Jv2T14GfZuGjtqH71umoAAyg71GECrO1apcrQG6VPEGm4jlm5baywfceGFhd4WmSROMzGeWP9IrN4qVyvUJUKxTtZDMxTVHIpsMZzqXcUoMlnQLzBjh7Z3fmiVgfz/0TDAa4tT4E+PhruYq5/cpbJU7F2mUGZCtKZv8pYOvQABGS58rK6WPmhxF+kKEFu686ZzjbzG6BrBOpzZZmXAhj2DNgvIccdH7DOUEc3+dMKIsZmVEATz8k4uX+3IZfl50lpMUJ7rjGjRuw/5XDlgj9lXi+adMievKxXSqKV1UTay2ivoX9H0DWPIqOOeb1EfyO1UiEoPJDOaITMaCg2eaaD5uxVnrb6ldt+EV0x/QYLVvM6SWEvu1M1l6fLPd4KfixJrX/DIGDdrx+T8b/u/ZwO7pN1UprHX2FX3lCnOxfIYvgqD/H2gBSqRPtroOKIucmRwPibMH2UY7tcmmzCiZVYTiXhhGnVhADMOIiiVUHZ7Vz0YwXzM6xac+lXr7EQDMuChFa/t8qvKXUCgoS7E4poggEvYsizjcSffsH+QovnWWRgQZUDNWxZWLGGoPNLsWI2uH6+tSemub5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(8936002)(5660300002)(7416002)(4744005)(41300700001)(86362001)(38100700002)(38350700002)(2906002)(4326008)(6486002)(83380400001)(478600001)(52116002)(2616005)(186003)(6666004)(6506007)(1076003)(26005)(6512007)(316002)(66476007)(8676002)(66946007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9R7MW17kmaOUKykiUOLVRe+sgOsftxXs3DB6zdMjEncEm7XI+mqo/wMqUp7b?=
 =?us-ascii?Q?FIKGHXSGL6KrD0hOR6zR1ud+wlIwbLQolWe4iwkDvyWdHqyMIFA6bhGUsa6n?=
 =?us-ascii?Q?OiMXoVb5MJQSKZWdOj7EpEJ0c2Wj4g/YPj6vxSDuNhEac80L0ec75fDYoIex?=
 =?us-ascii?Q?RMs0xYBttxu3sWTkQs+Fg+GNa8lw1BeDUrK1V/rVp4JIkVNeEfpFdnF/vWh3?=
 =?us-ascii?Q?9lEPANfiqgTmRU4+7yFVDsvov7B6KzmpO5XLR2F0KY3AyrEz78NmrmrUnzNJ?=
 =?us-ascii?Q?qrhzPhQgxUeiNw4BSbDmvfUmLoaaSBnx/Z+fnFTKxi366eVAPrwQ2GijFWcp?=
 =?us-ascii?Q?mWTrGrzG1J9iScECaunxpunsNmE6V2N3RwHZQBXumqC3CT08mpFOsUX4VNbh?=
 =?us-ascii?Q?YWJ37V6fEqQq8A9BQbiKR0FYxr9A031uRw4Jy0fadonIMHScP1LCo5xUtJKx?=
 =?us-ascii?Q?I5BjsVXlqw3DzITDLWQWSlfHKhxx5OThwdS7xsXgr6GQFBK5JJIsPf5ff6Ts?=
 =?us-ascii?Q?JPCoNvLB+J5q2yFJI/M8mvtbmrU8Xt86eQyl1cvhcjl12nktAOU8CYSs98Ns?=
 =?us-ascii?Q?oksBRKlXy1LawP25frXaVxKV2hTam6bkuwj3BSMaHqzOpK/9Oibucm0pWzxW?=
 =?us-ascii?Q?caYUgo0wNS5uFLWg/f6oQQnGCa5LJSe3I555PzWdjU14964V2KLOwInUJ5P/?=
 =?us-ascii?Q?DltIqiJhXcGbmxywz0rbz7HFXFj0J7aanLeXZtv0PHvZKSYL/cVgRgF+Cwsj?=
 =?us-ascii?Q?rbExXC4HjDRXxSQDpEhhlIVn/tEwze8EB8jh58GxyKRElnPPiIXeEjVkrf54?=
 =?us-ascii?Q?75gIev6URjAXVj6B6ByQNXGXYEKlMRXg9zDSffuT3LQXPS2s4KP6TeGI56Ki?=
 =?us-ascii?Q?TDpw3lMqFZUKsN5LiLJSEUf1UIB1v6mhE8FgfNwxKk5WbkLQIqkjFso3etDe?=
 =?us-ascii?Q?4Aul/w9AUeKyEL7bvXHt8vUOetjl0Ehnm2VGMAeUf514PtbFzrsFFJ3f9f4a?=
 =?us-ascii?Q?zpKNZ2WLVR8nyfamdpa+6jqw6k+2RvFRGf29/iOkzgsrTm9D+q5cmlhnn8Go?=
 =?us-ascii?Q?/9wsoeAKJr+Eks5gHqEpe+4gL10P+m6Qf0qXNVIgovEqnBLazezk4wIsKoxH?=
 =?us-ascii?Q?xU/juNKqujZphjiWO3wCXAYmtGMxIWKfJ4okDYZvxPHIX3e7RwXHudCr5nug?=
 =?us-ascii?Q?g0JL/ruovmL4+0u02AGXi75cWtQqpcskS1GUqL/ZHhyGqAAwmG7oaDOyUu1B?=
 =?us-ascii?Q?4t3TddJ8hVfJPN7b/NPB1zY/bb4N5DazdnZk7TAR94UP5c3pp4HAJ8Grmd5a?=
 =?us-ascii?Q?gTdi5GDiOY1XBni2x6DP4PWFcO0qUaksfEgSK+LQV4NhbpIhJU7o+FfAdzEL?=
 =?us-ascii?Q?0LwOgtXNtZcHNrSaC+fK8xZETdoaNej3M+mopsBdUhyXxSNQQiFvlQD0vTEz?=
 =?us-ascii?Q?4S7ggG6U6Puhnjs0KTrNfxyfffS4dvhaRaXla8uRwhpRcDqirzWDiNJuh57+?=
 =?us-ascii?Q?WS34ns5DPANi/LYf4e1BU1M5xz37T6bl+96kxboCfbPge175u411npQFlnRo?=
 =?us-ascii?Q?lb8K/BH3TiIUiN+jUgj8A2Olk6kcERWDYIJa33AH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea30315c-c106-4abd-aff2-08db28701ea6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:22.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0GYalqpxi2ip46S+hKIxXEbQ+x5Cyk1OCoIqyJuVAjp8YzK1EBLP2rPU6bX5QWaNHFjaEByquRvIdcPrMoijQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no SMMU in i.MX8DXL, drop #stream-id-cells which
is for SMMU-v2.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 88913869ae9c..652493ae4bb5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -49,7 +49,6 @@ usbotg2: usb@5b0e0000 {
 		ahb-burst-config = <0x0>;
 		tx-burst-size-dword = <0x10>;
 		rx-burst-size-dword = <0x10>;
-		#stream-id-cells = <1>;
 		power-domains = <&pd IMX_SC_R_USB_1>;
 		status = "disabled";
 
-- 
2.37.1

