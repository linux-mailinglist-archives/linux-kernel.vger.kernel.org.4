Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5053D6DDF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjDKPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDKPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:12:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C54C17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODd1drfr1KSGZrGQvvrY7zyTK6HjazvgWGu0KnF7Jp4CjDYhH346Lkg8fBkvosQf4YhqAKWWBBn/cJn5nGAXg4hmRRQNiw1R/sRrngd+d4PSs6ofGBUDJqOV5DnRt60ay6ctA056W2T4nPWNrXbDgYRckJwwiQavrvkNNOjFOY8henBUc1PPNKdCpohE/OX5++gF1bEJKrhgg/B+x1mwbxC+7CeuIetmiWWoYdgzY9JFzfEKe+fp9G2myOKTmDpbyUt6UbXyP/CldX+hm8peqWFNHV0WnWR49hY199aUpQ668O1E74OzsnERaRNAlCdXjXb7LVo6gYJoBq5NcmfLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFyzIxZnvOaPzlmylq1VEd/n8LVahEENfFCZeDmv1cM=;
 b=Sa1YPO5RiCQmRn45+AlX1gDnXuZ3oogoggF0ZYjJuG0tiQ7gX9suLIFu9JrhdJlUD/5ZTwX7GXk4brpLdKD4Wgm+0/YP8auiKTWOW0V6lXhrqD24ktnOuRcQELUy63SXtwRyz8lnzt9X3mDJTtP3o0ONovUCTjvVjp0mY4Q2AQlLjh84xDkFApBj/sOApS1/dXQipAhe1IfiRbUAr1Gzexjz5nbCY8FeNAbEFU/PHzpM52GJiNHgS34EHz47GyjHzUQkSb2sZtZK33nQP0XsTp1hfdk1R+5W0CqzlSRRrFc+q++ch1erzHCK5rQ7ATcHG408gQ7z1swcv4wxcLPggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFyzIxZnvOaPzlmylq1VEd/n8LVahEENfFCZeDmv1cM=;
 b=Wwu+9Il5tvzKSKhzy7W80wRrDjYgxjgmRPESfCjo4LlipOu+gu/mr1bbLOcAvEXYZJJ4tI9AImuzrOupWSOX8bTyI5dIkQ8JLEaVfv4OSB3Y6oZqnPcx4wJMJfkkSpBqvBu3B5jEUpWp3KlWwwtHPqaE40cRAm9j6sbv0e0FjBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:11:56 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:11:56 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 5/7] arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele-mu dma-range
Date:   Tue, 11 Apr 2023 21:55:34 +0530
Message-Id: <20230411162536.30604-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411162536.30604-1-pankaj.gupta@nxp.com>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 091d9f41-07e0-4c82-81e6-08db3a9f1681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNRqeAqm/+7bmxmg6Lz7YKLdeQF57GB6DmtHMgMyVD1kaSlqqEaU7AWc33HRckfz/XGpv+KuT8+MPyhykM52GlhB8rIf/pwqaXqkMn6K+qv7KwDGvml4oyB4gVp4fD8dr6EjDPBA7AzH9wyRKzOV1xZEd3EgoeUu0WE1hvTzNOKwwa3+lgVXaUl6gw1nif6EOvyRDsPVQegq4tygOeGFRcOxs2yyzicO7bPzp3ZU468SmLTlBNUNzoslYpI/fjwXhUKrUJu2vMqMyKV0yqL8t0t8uWjWRmjwBPk0yYbZqubWvSbEe4QHUiSrYq4xSTQliTFKujNK5POfQN9btLtBj5CW1bAQI8TCzzspcjo2kxi6+fTnAEXw9+kyEB55XrCh2d/0piPLBAqxqOPvOBUJaxmlWSlcCiE+Kd3OkL3mHE3Vy4fGPHC9wkfAwmu9a2lPlk5zc08lcnjtS98RCjy4KF24wLPoH+arGVc0Y+M2qTf4o3slgj+MDAhy/y2G8zH4aMvMZ55ujSMEQz3/aB9N+JqqiKMItERRgDmKi09cCldnF7sfdsrHqUCPYC3rUVrU0xl6/yauW9bZl/Cqv818CcPODDY58mTW1nw1kcbiJSUH0UXjzg1yu+QSC60WWsDCcQlM4+Q7jTgtLNZsspsezs2IID3r4NW/Ea1ccQZRUV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(44832011)(36756003)(2906002)(8676002)(8936002)(38350700002)(38100700002)(5660300002)(86362001)(478600001)(52116002)(6486002)(66556008)(2616005)(6666004)(6636002)(316002)(186003)(6512007)(6506007)(1076003)(66476007)(26005)(66946007)(921005)(41300700001)(83380400001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5HhSiFNE8tMp15oDJJjA57r6p2+/ix/lXNr3UsCC7TUipOZ9KVWpfEUb/zg?=
 =?us-ascii?Q?dsChouG8Rv6FVCRmOVLaqRk6et/89TP7tnCeTKtAKrEmAI1c05BFep7ridZ3?=
 =?us-ascii?Q?SYOuQJmyx28x9EbMhO5izWMn2wrmjgSIgfR0G6uTWgCwafWMtS0E/+3Ucy9P?=
 =?us-ascii?Q?8WJVWfN0HDu+eeJamk1l6gEZnVuHZTSy4EF4vKZUjqJC7irEWeJkiuoWKqoX?=
 =?us-ascii?Q?C7Gwmc4FgYJPOw8UC1cg4oHYP63C2BLAumCGECTSqyPyTaEUSClo1bYCKoeX?=
 =?us-ascii?Q?wnGurRHF2FAMHVsGyhPEcykQ/HVXMkcCqw+eCIT0pyTx8QxWIxS/AfWlIN/h?=
 =?us-ascii?Q?j8f3ZRNpRJQcouDKlvfPF6bm1sU5F6u5NDplx3fDHs7/zsjsAquoMpXoG+RU?=
 =?us-ascii?Q?15DVs0ddh9fPl9fwuWK2xwGcTaHVr0dBsIFodHARyWYhaGst+q2yKFuEII1d?=
 =?us-ascii?Q?n4/rot984LUD5qcn3/b4ap/YOkNp5SUKRD7Vml6bZD8/nWKDLF32iGTFsRMb?=
 =?us-ascii?Q?s0EOwpx4flY7HLx4GdCFfReTwiP4fzVoPmoOS2kKVPYpCOC6AYpRzpw7nqWz?=
 =?us-ascii?Q?OfL7xBBiTvmnEXAjOZENs1tpUO+gzoqYauejWP4OC+6Fi2CLeuV2qKCdvp4O?=
 =?us-ascii?Q?CtumutDjPwPXEnXJP2Mb8HNyXQCjzcHBMalQKf7t06JEuRX1psB0CzwIUVqI?=
 =?us-ascii?Q?Ou/T092+zzpdDxII06AaCPhhhBsE0LMycdGcQ4+iQx6NZlFRKTno3IXDcKXl?=
 =?us-ascii?Q?BCIymwvQynOLQMcG9W9tb6x2+BU9gs75Bg6BgGggud5TxgnWk7Tqei9QmP+t?=
 =?us-ascii?Q?ItKyElEaAsmy1vgz+b65jjQ8dS00tkMkCVhBTfkb7+eFIYNGv0M3lpOi8fBq?=
 =?us-ascii?Q?tzOjIEMm5yb7wxqcXpwiX+nX4OdrDU5mSKTGojZh97DrA7lWybmLp+wCDrjz?=
 =?us-ascii?Q?tlkG/txusM0RS2UY7WuU73GEpp3WoC8hXgT6pB/3Pf4MjnnrAJR+FSk6WGbL?=
 =?us-ascii?Q?UTa+WJrcmyg6sm8L6rSNMMXlENZjpvGB8LiFtwN0bMmd/9R2lm34xlmdUTRo?=
 =?us-ascii?Q?k0QLPr2lBQgO0NhikkVj+/HvUJo6WsfVi1PGT3Er0RAZFaL2x9dwdBEtXNi5?=
 =?us-ascii?Q?vFXzjCOLOmzP4ee2vpdKxEyQNjOkwRHAG4dAzm4Xkm1jJWCRGT0/qq4lgnHI?=
 =?us-ascii?Q?ALxK3YgcZZO/WvfUqdcKvzpcVRcvLPtB1akZ2MMJgFkQy98f/dxOsGWAzuC3?=
 =?us-ascii?Q?J5keCBNm8MJ0KY4TG+pvkR7zA2F8VW74quedo+X/jUEUopzhVf/rhyOfbNQS?=
 =?us-ascii?Q?Y8quEOwDSSWK3dgEUq4X+xXobDqXHg7iFZPXM0QfU/jxGDHyBEBxoFQZiXuL?=
 =?us-ascii?Q?8h6Hz42WFgbacb6T0o+LF/ccBs8Hgkk9LPaopW2meJCrLalMRuQA2yLVpvSg?=
 =?us-ascii?Q?J4tWl6uyHq7Rvfn9MmdkzAxAOKib0cYfPECJTcLABn5gt9dI9Zm3o2aOhs5Z?=
 =?us-ascii?Q?jBhXpgpn1B+4Mtmw/bHIAaT/qDs54wAdBEkTVUaA/invHcvZW2ji7s2wLT9Y?=
 =?us-ascii?Q?kMoPnWVCCl+w7gyHdb0YgL/YNR398MnDOdnI7Zuu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091d9f41-07e0-4c82-81e6-08db3a9f1681
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:11:55.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xWsyrpitZVTqKOHsVzqloQgPcGB8/kcf4AaAZ3AiuaWrn994T8sRgi8/WuNOkPc2vAZDF4JR2qfjl+bVbHQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x90000000 - 0xAFFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..d2a39e9aa951 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	clock_ext_rmii: clock-ext-rmii {
 		compatible = "fixed-clock";
@@ -53,6 +64,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_mu {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.34.1

