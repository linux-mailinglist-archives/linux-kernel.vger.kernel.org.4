Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8CB6490A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLJUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJUj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:39:27 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2111.outbound.protection.outlook.com [40.107.116.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82515FE1;
        Sat, 10 Dec 2022 12:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgXLKJkMLUGgcH6+4jZsY0vMPpPCM47fEM5fvNMracemX+Iyu+71ugYTHH+tBZKsPLJMBjaoDt63nEoiJoHsxO474MiqU5JBEtNPortOv7lQ3wZVRmBgPLjhzBlXsyHM3WJofFWxp7MW+YrcuUZVTG7ms0Xsw3uKgS3jEWT/DoSLh7j6UrT0zNuOXZZlheoUcM5jVcYrW63xiYx/ySHENh4CTbX7WVbTYt7LM69EQEbntNSk2AOGxQ+VUs7h8nNMLtCxMQkxJPkJXm6CXxe34LfnTubEQMxb0fc+GC8dTN56b4xCdFXI2cO2xXMZ9XevzmFXKyVA2fX6DMBhbe4TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNLm1paGyjSFoirpoBdjsg4L7rtUMf9qWaw+l99k2AI=;
 b=E/O9OSVF+4b8h64yZxInDtYNkCzLqWVllLZ+bnY+24h4AIQ7W+Uvlh14n0mpnJQaqaxfmMi/JzZ5B3zFchvdmn96vDAdgyRZS2DFQk65jApNCwpPJW4J/gi/rFW5sWOtHnISJOZ08RfycvewziIBFT6LAu4nlWPpX1JnG5e4I3KRH8vuf9auKy6KLvljqA4xWGL6efX5QJgju+sxLRbByxjx7BAS2Aim6m5Kai+zJVKqUSZk04MEFyIi8PEi7r2L+vXOi0a6IlEG8c8HpkVdi+4vI2mHTn7lShoHonT8vwT/e+2SAJWPKwBseKMD0vo11arqH2Cb2kxJHG7+cU0vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNLm1paGyjSFoirpoBdjsg4L7rtUMf9qWaw+l99k2AI=;
 b=H/njA/feyi9R8i5iEkoYL3cZ3XF/1EipwfCtCgz1hqEBYZV5AkH4WXxwtGUAsr3ETvGQCU6GJflAYrRIEtfdfMi8s8L57DdIL9/JBF8Fs+br7Jo21mcWlee2WIc56H981r6fDTe4emfWe3cCcwVVTBX19DdGDLGC7sDL99ATmkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YQBPR0101MB5880.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 20:39:23 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94a9:f6fc:9cd8:7bf8%9]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 20:39:22 +0000
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH] clk: imx: pll14xx: fix recalc_rate for negative kdiv
Date:   Sat, 10 Dec 2022 15:38:35 -0500
Message-Id: <20221210203835.9714-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0035.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YQBPR0101MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1804bd33-8a29-46fd-45f9-08dadaee9ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWCp8OlGR/oQV0OuKYkNaQM1szcbvCaekqYkCnY7Qxs4xBT8i2KNhm6t9g+aM/VSdX+aWSPeST/ZA4uRhZBy70tpXMw+FQB3hVXIlZdY+rWcbZN2Z6yjYDd/IcAPUo5yXTF7UlrWifT3N1AbkDznNxSfqBHOF5fQyMCZggWZTsBWjWbxvkKIAHv11cGGYfaKh5IA78EVFHdhcmQ8biT8eFvq00A11SlZ6UYBSqTnE/4tOiUsi9mUuv4/5PM2X3QM7MjjyqslcSDj/fKFbD46VH9ezcn/5z7p+upqamCo9qvtRgNU617COCt2Lya1pUbD3rzB2zxHu3JNbtKFcSgITsrbPVT8CaHWtYR8AliKt/fOBeWvU3UGdNnk2w47jUccLGE6rfAqRKyjw29PspTajE+LMbfHTeWG+oIEEPEILdlMJOGhpeVJf2XspPUgDruD7zCxNReDy+i7KhA2D9DGTk9DH1qklnk7L3M/F4117q/vZ5+WoFfg97Q+gWDey98X9SkJs9G7d2+SuEMp52IusJILscAzmAgLMZIcy7LNiTFHSim28Oa9jUv/tkZUggoAxQr0hdxpxyx2iSr6/ifMFJky3rxGG/SNbU99DHmlidMpRQCGaobIoo0dH2ctNzIBv7taN16Vzt9DrRPBUrRIwcndU3uoK8jy7T31GOtq6CjsFmvO6/rOOWwSa+QeaSIr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(376002)(136003)(366004)(396003)(346002)(451199015)(6506007)(6512007)(26005)(316002)(6666004)(478600001)(6486002)(4326008)(2616005)(186003)(1076003)(41300700001)(66556008)(66476007)(8676002)(66946007)(8936002)(83380400001)(7416002)(107886003)(2906002)(5660300002)(36756003)(38100700002)(86362001)(110136005)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qi48sSSIWt6igGaRX4ZJ6rf/NHO4KqIB02YoLHtXao8GV11eMt2YPG8zlAA9?=
 =?us-ascii?Q?2ymLdJKxJtThRyDGmpjGhtK1+MAOOLx69vk+FcS2BLzU50CTxySXHOzipoHo?=
 =?us-ascii?Q?OA1piOWAMrLqVd7f1hxh20qFcmdqDjDttRtB42pw1qpM51/xWB7qwwjtQcUV?=
 =?us-ascii?Q?BnKT7815NjJvtaidZwnWC7wGD9VL+Y9QyO6ruvTOJSbZURJN22hBXGX5CfH6?=
 =?us-ascii?Q?3zh4d+yVlocQjOi9d9O4kuvuObfEzfmRPTSPuSVLHvdzZV9096CadslQmV3U?=
 =?us-ascii?Q?3PYA9dXCn8Ba5sq1nVQYuJSC8J9Vv1zUZCwNW7++sWzE1NCYlMwz5+LZ0ykO?=
 =?us-ascii?Q?O0cTQpliOSFjp7oKhtWWd8Qk7WNF/kbhfGX830m7G2Fk+pV9z4+3jwMbvYDV?=
 =?us-ascii?Q?6pQEjyCIcOogpv8xsb6jwElrWm+FIO9CtXjZh/Au7siZszBwuvVKkrMxAiN7?=
 =?us-ascii?Q?bP+iPGvWrmRmdyGzi+WzR2Acjd/27/1tkJ0LRPq8/aglqC1276LrTZ6N1DPy?=
 =?us-ascii?Q?C8xB4JZUQ1scV6zL5Z0LNDjljvbXdAig8AifSUZzHugj2LQfPmL6CTG/MwjP?=
 =?us-ascii?Q?RLW/ryGCK7Yff64O56GOhRmadothTKjEb6Fayh/EQfoDuq1uS7KGWx4an46a?=
 =?us-ascii?Q?a8Gyq+0Nb33Yfnc2Olhzebs97O45Y2VL64FfvI1GJ7T8R75EiACnkqePQS7f?=
 =?us-ascii?Q?mltUzirDcnbnxg6HoFRaABjFLz2VUkd/6TBZXFBqaN94cbymlaTsUGHQZtj4?=
 =?us-ascii?Q?0ySEJ7Cqpg6mHwRwh+8/vEVG1A+JNRvuULeyhH+bcqqyQmG4WX+NaftlL+21?=
 =?us-ascii?Q?pap/u2PyT0zRvVJ4ulcnDwvQcXMGci4a11Om8HdY/N6aNTIc+8A572psTvTe?=
 =?us-ascii?Q?GpnoOk3WIfPH3ZWIu/lZ4RFowarPQC/IZwwNu949es7wLwhz94pcb/NTFalC?=
 =?us-ascii?Q?lvz3DaHvlUmJE2wQk+Y0+Hz2mFy6Ps9zleTjiuR0QKBDvcqoiqn1/XC+cD5a?=
 =?us-ascii?Q?xt4J6azrxUpCRID6zVWLQZvjw1EcwgWo2R6bfoBv/S6rWw3BSoWRlgXwFxfp?=
 =?us-ascii?Q?CWEbuof6qT+0mSYTpRxxhJwahqb76FjqV6NW82dAhScytAV0SUYeg50xVMUw?=
 =?us-ascii?Q?CPVW35yyEN5s9nbg3qi4dRPHssuYJEVzlAGSze3HGGq2dlXcUYnEMzkALhNP?=
 =?us-ascii?Q?Vdug8iMSJs7hAOi8c8j21xGzxayKlImwEo203io67zgx1RbaonaSv38RkkMo?=
 =?us-ascii?Q?prRsqQF4oR2MxTwAbiNLotdYuFplfomVfuumXYeXX4fxvql1ILTD6rGtvGD2?=
 =?us-ascii?Q?1BCdeHWwDAtMgkuFXRIJttTRW+LABgE3kDGF3OoopwQcsunZEXYVav+eP6fs?=
 =?us-ascii?Q?cdo2iQg7jVcCwJoFsr+1eUUb10mNsL0Iz1CC0957Jz9PDeMwOISlMnUcGlWZ?=
 =?us-ascii?Q?yWlVbHixEOGpP+Rtag98MixIEv5D7j6pX0f2g2eigxaUB4rXwephxgtu3/du?=
 =?us-ascii?Q?uCRB2Ng8cPxwTYexQj3eJmV7d+MATARaFQleYuKHAIcgFz+0KbO14vMh/deH?=
 =?us-ascii?Q?0VEoAVAZqUxjk/4PsI2tI49e1M9LJ3mHmpZdRZ5fwNWFfz/hrLQK9P50UkTm?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1804bd33-8a29-46fd-45f9-08dadaee9ed4
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2022 20:39:22.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrrYT9iI9yUiud26KlrbYTwUjaLtJkULtiZHB34faijrdNpF/xRDfzL12eDN8dcp1zDWNRKippJI895LMvmHeSAAb8E0b2Ic41D3Monuryo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdiv is a signed 16 bit value in the DEV_CTL1 register. Commit
53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation") changed
the kdiv variable from a short int to just int. When the value read from
the DIV_CTL1 register is assigned directly to an int the sign of the value
is lost resulting in incorrect results when the value is negative. Adding
a s16 cast to the register value fixes the issue.

Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 1d0f79e9c346..d12194d17b10 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -254,7 +254,7 @@ static unsigned long clk_pll14xx_recalc_rate(struct clk_hw *hw,
 
 	if (pll->type == PLL_1443X) {
 		pll_div_ctl1 = readl_relaxed(pll->base + DIV_CTL1);
-		kdiv = FIELD_GET(KDIV_MASK, pll_div_ctl1);
+		kdiv = (s16)FIELD_GET(KDIV_MASK, pll_div_ctl1);
 	} else {
 		kdiv = 0;
 	}
-- 
2.17.1

