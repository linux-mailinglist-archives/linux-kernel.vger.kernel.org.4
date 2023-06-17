Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3766733E19
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjFQEvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFQEvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:51:36 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2040.outbound.protection.outlook.com [40.92.99.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0110C1;
        Fri, 16 Jun 2023 21:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/mkght0l/oKSpp7uA/bOIsk7Ihcw656r3qz861BqPy/S2ii6nIaxeVh3CraG7Q8IEfWMWT7XqcqaYiESQ5KcPjMtyRuTbwNEmdrW+DcJ/GnilsPqoibKP7OCog3fuAvG8o0dWOqRXmq8XyjbHLTHwwsN455qSOfkZUrzAziurCLqd1mzW6pwRWlJ2zbT6Q+DmVS3SyhBwig9zHWb7vJ2QYtTXQUrFVlM22IeNObDqA7YWOAbnMg2FPVYZnc52Dqoxe7ThzWOY1YDwP0QruhMvgIZJvfLUWeRx1TNAqI4x9e5f/KbADpzIaclwONOPZucf58MEwSmMi4a6UElCiUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7s8FkTC1WyVi27pLlqGj5X7bXuQ7QQHA7lLwHETL2E=;
 b=ilcc25C2v4u1umFXxGcNFLpZ7WOm4nOQXDq38mXAVHeNMnvYvp3gPqUB4gl4Q0tJDmdQELen8oe0BQ9URgaECgVLfxWMfJOmP5o8LoMywsIEtcQoGURZ5fkH57ekyVRj7UmosFXPRd9Az3gw3zwrNOtC7M9mokCbBYjX5QKuclBW3E9UGOVA1JwZtt/kCjwEhSAE1b0bTZfooVfEzi5WE9lFQr18dPEdN00tAufl1Ju2nnvVNP4tRXZVAr+94jNI9gFWzmdQKDZCgFKPzl6R2udIm5tA2YCNM6bdewfe7SOCNymUmAAET1YjiWQ880dlzEn4NVt3SiD+abBtkT7KxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7s8FkTC1WyVi27pLlqGj5X7bXuQ7QQHA7lLwHETL2E=;
 b=EXZzE/CQpPWcVgqTl6+60eihbaAGkCJCaf/RM7doyCPe9WzmwyASOkliRBXxMu/Tx9rF/mA7O98zSvU0HVKfDz+Eg1okn4q9QG3vTiL7+Ofvk+dIyk4kX8v6yUNXHlm/dMTZvXoBzi3b6XKbHhcPV59am0tWFBgbNYtVLdUK5tsCidVaEOiZv2MegqiiInr+oKmRxaK7MfT1/JsKAv/twBC/TDgMc0W3QHSxNlQyY3t7hqLV1y3ZypO9JoP4dkSo2KRNIhj2TuZXPyXkBEd/QD0wFGZG1jhf1ZeU6VOX8ArKvWM0XSDbfk+s46alfDhmYR1v/WVKgWX8Y2M0eZSfvA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB2235.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sat, 17 Jun
 2023 04:51:27 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 04:51:27 +0000
From:   yangshiji66@outlook.com
To:     sergio.paracuellos@gmail.com
Cc:     arinc.unal@arinc9.com, devicetree@vger.kernel.org,
        john@phrozen.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
Date:   Sat, 17 Jun 2023 12:51:13 +0800
Message-ID: <TYAP286MB0315C35BA080B686EB5EA980BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418090312.2818879-3-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-3-sergio.paracuellos@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qPYrW9yIVgjCXwVR7dGrKc+20NK9gIgm0H/c1PZBE18=]
X-ClientProxiedBy: TY2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:404:f6::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230617045113.9707-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB2235:EE_
X-MS-Office365-Filtering-Correlation-Id: 74677015-4e82-4ff8-be1e-08db6eee8216
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irY5Oj5/vHFTeSAesVhXd57DUgjZ7C0sOK50+yAcNNRcJhf0PQSjTHWFNCBPJ9c38mpQU+/L5Q0CZ379vg2xwJhpOX9FrdW2BvEiFHkIefM2OgaGe/us+9Sl87cwLE9Bsh0/rfwIqL6dmqMY1vYGVJVSDUNDUM3nSgH8u7+vaJFtVPtcjJ/6H0MSg21fWnB+VcoO+tv77lICbkDUmA4+saE04CBt3rgxnMmE+13co6VIr/ROzpvb6Z3uFkpIiUvtt0ORiJdBV/91A5kcltXYCBKhVu8/GtwHnARONqB5iWMnKP0QVaOLG4AOFQWyjNFTs9nukch8z4BgNDccCc7JNnEh3v1LM1zSLedseJ0/g76M6hW3uQbq/sE52rVwvM5vKFhJZopYc3H+1z64NHhoeyKRD6xOGlN977P0i3YJQw1IleLrJ/BmevVRArkPfHNTkTlfpuHlbR4y7pUWxz3Rs8U8H66DHSFxaW+GeddIhwEkO9Vpo59KsM95WIKq9/M0fq1G1vubElFgwKIiqT1l8lCZBDVxOfz08MKndVa9QId6yDqhWDIVF4tZdmlCTUz1mJhPG2fd/bJ/Bui5bBKa8gaYdrg0U+eGWMx68+5Rsm8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12neER7HZgJzAQkIbj8Iq0s/mpCCmozh2//44OmLrT6IkHhYFbb+z/4W+9LM?=
 =?us-ascii?Q?2EBJyxE4JMn9jc9YNDX861YtbvKVZNATqT01iqXzt3rNwddoVsym1MXxh2t+?=
 =?us-ascii?Q?ciHH2OSXf0h4ps2yr5U9+vyosuSNWZPN+0RdUkkMMr2pXH100aMch4HaXJ3U?=
 =?us-ascii?Q?MbmaFm6UJTMhOW+zh9AXCLjJKZOmL2aH8Ys8wCpCQ8NiVcliTJd0SIm7/udp?=
 =?us-ascii?Q?iD0/M58QO8MkihWfWC+Qlt1adCxoEVdL4iM2+Q1lEXsHnsVCPkZ/fzNl2U6u?=
 =?us-ascii?Q?D20Bzlhak0noBAGNEImqwyEa33pwbJylvP1lnuknm8Z74oI1D2iLBGUnlhLU?=
 =?us-ascii?Q?4c5XPpS20spMVxjdO1TuwDTaH2NzTQIED9icRkeo9ZDXAu6DWCYwKwE8PjON?=
 =?us-ascii?Q?nikUANLapTv7x49vI2jefn1yPAGeI4T+C8gLwpJwJxS49d80rdeFBwcQu4FY?=
 =?us-ascii?Q?CadvYwXzHDvQAbzkqzk9P8zLPy2efCYgfhQbQPwXeghCm284WV8X37h7+MoZ?=
 =?us-ascii?Q?WUUCGF1r3CTzXrBRVKTMhyNvK9cHHpcAljjDohh8C30O/1XOK1iWulSPzc9W?=
 =?us-ascii?Q?w1WEQEkqjCb6ulYStHCtmskDP0waPj2g2LFdKjZRqjTtzRB1M+3lSI5YMqjQ?=
 =?us-ascii?Q?HdPbp1Zo1Kc06hZHF2mQw5LDycLQ74PvobO4HhX2QwIdR/pq03HiGPLWwRvJ?=
 =?us-ascii?Q?wYqpUjj4QG5RCzpTLyqz5LOXEA7V4qDSgnM0BzUGHWn4cQ1ueYPziH8l4N6W?=
 =?us-ascii?Q?g5j85/HDJO2ah+oVBROKNOREWkzPhOOMmiMOda57SjGcGnkzfIuza/a8wet6?=
 =?us-ascii?Q?r8FyeKKrvLM0xYZuLhKHTOMrnIGC4BmSSNe7KhJMGX5eIGS2o1DUw3O/njn/?=
 =?us-ascii?Q?0UXBCoZvJ+F8qYFVZdpVEN/vnfYhpThioaVGlpmlJqA3U91g0ITKBWToCzh9?=
 =?us-ascii?Q?jeEVApfz90X23LofgfrQMwTdi0YoK1nEIIX7taiSauW+5jwH4iJoko6f6thJ?=
 =?us-ascii?Q?fdahUfxwUgkwOTZ6k7swrJHwYu9HxNSiiRTvKszEAb+HYX+pOUVw4H1bBmpp?=
 =?us-ascii?Q?mqKs+bdCh4HcRxnX/41JZ7LVDDNf8iy7CyAx87uCptr1AU2+g3T1S8y/rQHH?=
 =?us-ascii?Q?QOqkchuMiyxCpEA04m2rJlFxVZi4ydYaHUqLMg7jFXw/J58hhKrAR4rx8pM9?=
 =?us-ascii?Q?kMxnqXnYor+hOjauTlGoOejhGcgRz3aUpc527DJn/R/WZTaKKoNohgLbWps?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74677015-4e82-4ff8-be1e-08db6eee8216
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 04:51:27.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2235
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for taking care of these old amazing SoCs. When I ported these 
patches to OpenWrt, I found some issues.

>+
>+static const struct of_device_id mtmips_of_match[] = {
>+	{
>+		.compatible = "ralink,rt2880-sysc",
>+		.data = &rt2880_clk_data,
>+	},
>+	{
>+		.compatible = "ralink,rt3050-sysc",
>+		.data = &rt3050_clk_data,
>+	},
>+	{
>+		.compatible = "ralink,rt3052-sysc",
>+		.data = &rt3052_clk_data,
>+	},
>+	{
>+		.compatible = "ralink,rt3352-sysc",
>+		.data = &rt3052_clk_data,

It seems that there should be `.data = &rt3352_clk_data,`?

>+	},
>+	{
>+		.compatible = "ralink,rt3883-sysc",
>+		.data = &rt3352_clk_data,
>+	},

And there should be `.data = &rt3883_clk_data,`?

>+	{
>+		.compatible = "ralink,rt5350-sysc",
>+		.data = &rt5350_clk_data,
>+	},
>+	{
>+		.compatible = "ralink,mt7620a-sysc",
>+		.data = &mt7620_clk_data,
>+	},
>+	{
>+		.compatible = "ralink,mt7620-sysc",
>+		.data = &mt7620_clk_data,
>+	},
>+	{

I am confused about the difference between `ralink,mt7620-sysc` and
`ralink,mt7620a-sysc`. Do you mean mt7620n?
https://www.mediatek.com/products/home-networking/mt7620n-a

>+		.compatible = "ralink,mt7628-sysc",
>+		.data = &mt76x8_clk_data,
>+	},
>+	{
>+		.compatible = "ralink,mt7688-sysc",
>+		.data = &mt76x8_clk_data,
>+	},
>+	{}
>+};
>+

Thanks,
    Shiji Yang
