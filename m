Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B468FD8B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjBIC7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjBIC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:58:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB3527F;
        Wed,  8 Feb 2023 18:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2C0CqbAMKitX08MZIdgz/ltoFm3cfQLE/dCpJOwVjoKRmw7sH6eTeXPNARX5gpDWxz4ZFigK6hTYtYfLUrgDjI9Ssg3STKAEYJSYvBtoovYhI3Kfjo4Fp53xo25QCXCdhGd5QPCEbj+exbCsSIM8w/mXlRTlVga/w2/c64NJJonBlnNTAdKE4V2iqLG34cg+EBqNrOIMtJDhOXoeurlndaXG7nHMtqDO923SpfNLZLD4sNT2rF6B6KQaUv22ub3tzPfV2EchhHUT8kQ5Sa+d2Cu+Gt6XF+Hv+fyv2xZcIZzr7xZ6vEQNdYy+kwRSGy/Iiv1JiAW6y9u4E3CJ9SK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mJVWkFymDtPXLQIf/gcT8IE7Qw9HV8/2UMvvSj/eI4=;
 b=oB3N2lYjFbhtpIOMEYv2EIHunvAwBtkW0Y3Ofl0etLy30BMwqsn9Mz4FmZyg81WDb++APyu8NwGK6l+5lSCnO3UaF2UdLjgtEyZMCjKzsZkAEfanOeR3xt1w3W5nbwNhfzFm6BIFygnJnmKOrglfSfiQsKQV0rOEu68D74T7/wZYdI+7QbsTqXOxrUeTmjPoycCvfDqKuNYqIZILc8OQ0FBCq+OUibOF2ffPw111y+T1Vu74zQF8TjLe9icframa0lA0HmUvQMansm21ZXdDwSMZ1p/0ioM3XYJ+7viDz4G3WuA8o3yiZlJuktoIE2yUtdaIZ8KFOTR80XCItKePkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mJVWkFymDtPXLQIf/gcT8IE7Qw9HV8/2UMvvSj/eI4=;
 b=jj7np/Z690FpqiMprGZvc4j8Ss/s4P/vEpjiJLVq2XFo63hWKgulcctvs2SSFFpVUVRra4QX1BLMmryfUtYJMBotTW301iTFbhS3xrexi3a3tPA1jenSOIuqb/VOEW7I67gDem7J3Ocj4ySdEAJub5/GQ3ntWhuwrSfHnYCcFfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH2PR10MB4391.namprd10.prod.outlook.com
 (2603:10b6:610:7d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:55:41 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 02:55:41 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: omap: add phytec pcm-049 som and pcm-959 dev board
Date:   Wed,  8 Feb 2023 18:55:24 -0800
Message-Id: <20230209025525.148872-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209025525.148872-1-colin.foster@in-advantage.com>
References: <20230209025525.148872-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CH2PR10MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: c4041ef3-6a27-4a2a-4113-08db0a49211b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uj+AwUvDsfC24K8y/fvFA8RNKHOm5FjgE6JV7WQL7eOhWD+DDGq2yV2BDiPxcyTzVhUhvvK1WJH6m5PXc8kdLALu+sheaFnvIsUhuG8j4qDOFBe+gg8DjOUH5YjpsV8zS2FxFyocIvqXrmRpxZGAblTXqvIbdwbHAgGtXvZCFvM7vhLapTpBNXSo588oTtPGQFGjXtJRp4EAKmRNZykEZwVWY9PJWa6NLovrLfeNzzySPGEVU/LSGAcxbRYcqwje67B2oXL1ORukrXcRH4mfwbtGIWGUyWKySK+sUuu2eqZVcapOBWnXrpB2V9rG3Rs9e4jSuvCG1XP0uqFdpf9ogF2DLQbIl94YwGZUPnqr5wh7oo1NEZUwnKbBTigiWRXDpAv0li7eRiXli1SvFdakz2GNljShRsqwE6owlqyj1eg1e6E8ZY5Wpp4nCjdDz1PBbHfKT7VMELDFfhpjMNaOB/YRBdr5cnjleSWs1brdfxbqe3Oxv0oqkN3GslerBiovR33xySrxgbNGrqoRbUPLLVA++ek7AUf2ixnBS/vR9Nf0uv+U5X6BZI2NMk8Oji+crr4ucgCJUlz2bAU9SGbnJTXstnIPU6mevSiuNyn1EEGctxGzrQmDBE11SPRUjN2icPN/c8FjcpaWpJ1n9gJkAoEBCQAshI9Dq98r3kpHavlCUqKvKHoKFdaXDDm6Ubx6NV5Y1PVZB4Kxx6dHJFj+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(396003)(346002)(376002)(136003)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(1076003)(6506007)(6512007)(6666004)(86362001)(478600001)(6486002)(5660300002)(52116002)(54906003)(7416002)(44832011)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2YkGm+vh0lCBSyF5S8fglb05oJG9wgHAYOjZL4kuQ4pGqN609CYADpfRxwt?=
 =?us-ascii?Q?lm1wzDwTk5CukhEzzkSU3MFm3kS1WkOIqRX1bero69J/11ri37PO6+oQiuJw?=
 =?us-ascii?Q?xPdHZeFeUNzGBpWX64t+enT20fwG7tanFtexNB/xrqJwn/ltZmAk/Coupubp?=
 =?us-ascii?Q?3E9a21oZArqBa3rF/JtNdagxbu7HDq6pcxMP/GevmA93KcC+yf2xJ/bqZx6V?=
 =?us-ascii?Q?fvR6Dfkx4Ym8vryiDGlQg7lFbTD+S0OsqRR0N5a46q1BhEPewu7S33kSJEEL?=
 =?us-ascii?Q?556Djdu1rM5MfHEGQTq9C78GXiacp8gWLFzeaYRTVJ4YjUAxv9LJ30lclblE?=
 =?us-ascii?Q?w7eLGfGr+Xx6zVJEADWSOwd8m/if274095ZKHfR5oAa0jk3D8M86Tw8dJdFW?=
 =?us-ascii?Q?bI82OnqOlbkoKd8/YuFJ0a20tPtDwanu21vei1pspetJ+CbhytWh43xs9XGi?=
 =?us-ascii?Q?Jg/hjFrDJT+ygAzS+WTtkHeOY6Zoy/ejGinlbrN6X3iuDLFGLsXwhNwcxhAB?=
 =?us-ascii?Q?uBQTD74JxybiUCh76OgIchcQWz9fgTHNLvYfoC9huBIHwoMKo+hkH+Ehls2N?=
 =?us-ascii?Q?JsmnN129YpyI7ISUTLtas9z3F7a3QpMvtawvPzqaH3LpIXieH0lIo2bxzJV7?=
 =?us-ascii?Q?5VCCoxAm9TRZUu8BuUwDmYIMOioWaR9jEL5e1W/WeQ5GQzdNPmeOpnmk6v5X?=
 =?us-ascii?Q?t/l/bBTE+EVcZpkww7NMJf5pyNA8jZnG5YtL493J6/6K4MJyKFFF5IVekAHK?=
 =?us-ascii?Q?/Sd5O+FfJWEQzhyIqjsnsLbGlZwOQ0tHNkka6bqct70ZWJr3OkaB56U/ZFGC?=
 =?us-ascii?Q?JRKrE9rYAKSvzdlhF8QUFC2cLJum/Ku0jBE2o1Ogae5szZ28hJramcM+8Pvq?=
 =?us-ascii?Q?FULbU5ujBpS304sUkpEd7V0blMnnO3wtRfqnBLjQ6w0Tmw3PT633DC6kUnGw?=
 =?us-ascii?Q?D07JedRT7a+/QQW76A1CvWxVQhGjweR7SlLORQagoew6k0DDdiQ7SsmCCKAl?=
 =?us-ascii?Q?IutlZxhoCH+Oq7G6z9+9xrccwO4KHVTXvLQkAOX2KzE1QSdKTcgVdrOvHpTr?=
 =?us-ascii?Q?mlyoBnMPnva6ScRbLDDHdM+l+qd5EcmyXxmpQ38pmectUCdjX4BKPbhOkNSk?=
 =?us-ascii?Q?R6a2vjC+KvBNJeGsbjbpNklfQW4y8c4U9INvNh9Gck0PfwuVTRCqoNuGJShW?=
 =?us-ascii?Q?/Qcfwr6gw+2rD9hlgjGXSdSFLwXA2oLrEcsy1pMX8BaivBWKU11+ZEf8ASLe?=
 =?us-ascii?Q?gDgrPElwX7BfVaZwAGM2TPWgvYfyX+kflXIXNDTlAD3pUlrroYYVuSt6CX8X?=
 =?us-ascii?Q?iqLN2jNxgVdrY0Fcmivzbcpi8x8v3qGBpzx3kPX0253KVIuuDuWzKjncW0Bs?=
 =?us-ascii?Q?NnglPWH1+bqPHDENifiv2qfGtQdl3S/c3oSpZoQpY/A67VnYNDW0rV807A8b?=
 =?us-ascii?Q?VLzLTgNNqhuie+rV1A1lulfOSxLDQxykjDAptEOtsvfYzZxrHi2nyi0XBpbL?=
 =?us-ascii?Q?f5fzfLyy8XgHlXU3LEyZUhvvg3hUvpkuXIkvJS/8lp4ne3eWgb7kkJt50gcl?=
 =?us-ascii?Q?XCoW29h59CvdPRVbmBYUst3bkh+O7CpAHehzykdojUOXwScBTb5ZiBUa8ozV?=
 =?us-ascii?Q?pGLoT5ufTWzhh3/Vnbwo/Ro=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4041ef3-6a27-4a2a-4113-08db0a49211b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 02:55:41.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRX0mCyKi2UCq5gCS+KVzsVZ3x5u7BSVdLm4EAcFncBHhV/iaCp6ZdYO2Ak+RlSspvwnCb5NroXHQ2zyfSpVafwAdub05V6VLl2E2p7+uQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for additional OMAP SOMs and development platforms,
provided by Phytec as the PCM-049 SOM and the PCM-959 development kit.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v2->v3
    * Add Krzysztof Acked

v1->v2
    * New patch

---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index fa8b31660cad..0a28215dfa12 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -131,6 +131,9 @@ Boards (incomplete list of examples):
 - OMAP4 PandaBoard : Low cost community board
   compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
 
+- OMAP4 PCM-959 : Commercial dev kit with PCM-049 SOM
+  compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4430", "ti,omap4";
+
 - OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
   compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
 
-- 
2.25.1

