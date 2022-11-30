Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96263D6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiK3NiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK3NiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:08 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2124.outbound.protection.outlook.com [40.107.6.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048A2657E;
        Wed, 30 Nov 2022 05:38:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEVQs+e3Et9rBEBGiYwbofkUt3KtFQ1+22W45/BQ1HJRv2x0g35rOuxMS1FCKN5Fpf0TjW+nk0ZsGYd4Tda0vRfdv+FrQHHt+ZnKw3OpXOyF9VaSbp5R+clLcG2Ysgm9ZfABEq2Wp2RoQL1iNm+7DO0MhRlLpPq2xQBvPp5sIj2qS9tV66Y7UAVe4ONj9KrPZBEtvGNGt0lLa2AyAx/4hvipdI/YIfkgiBWcFnUE2F5Q6wTbHigE7TtD/ghX/9qLaHADcaXKKefdSKXViF5j+edl0hDjs2uTbN2YonDtU4SmEqGPy0jSNqQeSU1TIQa6fUqFJ4x9dLjpffa1AmX5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0RmFWtsyIIhxWt8P7rv4fFdcu04b8fqNdyLYDMSsP8=;
 b=ajErR5wFP9glsbVLrvgdwm6isLhRKggvhlKAg1mDYkfkPEf5fhlxu0kmHA/bHvi2/DiforlvfJ+NTXrnTlrUTi1cU1T2faC83hsxK2GpUnoEoDN/JWNNKSvG6B/hQzp2ftHxzzoEcVXcKjM1NqaBXvhEJEKDNwVyeen5rsqTzMGUb3EqFoHhHd2K6sWzsyOKqv32YBIkpt/wHKvEMpJArpgHNzD0CaLvwY8jQzyRfPzeeT2NRwDMiU1R7ob9sb1BBKwEfyt1mGdXfAE9kMWFmV70vERqohTQd9WzccRG4c0WG7Aj0CVgSq4u48ZAd/SaXSlWN9AUn/nIt+MldwKjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0RmFWtsyIIhxWt8P7rv4fFdcu04b8fqNdyLYDMSsP8=;
 b=A+LTXQnh/5QQYjpgvugkjvsQ0kYjM+bHJSuvu2Gmvxp8SdIprFT8wl9cWnW8LQS/+fmtlNGaWGdIit+UTTz1R6GcvDHGFwXwdvd/BPmpKThp9J8kjLh64pM9m4YmznuklkvWsWNbMEHBjVQjReE2okv0JJZUnJwZRGUqjwl+4as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PR3P190MB0858.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 13:38:05 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 13:38:05 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 1/3] dt-bindings: mmc: xenon: Add compatible string for AC5 SoC
Date:   Wed, 30 Nov 2022 15:37:45 +0200
Message-Id: <20221130133747.3777340-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
References: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PR3P190MB0858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5993ce1d-3f08-499b-b770-08dad2d81c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lvTgZrYUyvp16wLlcHqaWxCIpc1CACJ8NgIilweUTXJagIOCknCcfAfGwtPNXIe0Fv+8aG48cIKgfMYcpMNbL2xYrMsafhYNMKTCrRlf1MTttGQ9VYUvvF1HZZPgi9JdinFyzSherJ4GVi+FHMzDotBxlu68Nj12tgnISuxnmItk8HpqgKlkkgNvO5dkDfZs3yjrJ3hP+cdeh0fqHIz4DdtxSiBw6xBUArYxVbszD+ksxKxE5SnI/k+2iD26tRh9Tf7BQXSpniOKs8JHx+bAgg2TCCQnoO0roy7BeaOBacfkU9e2A4onKRR65pM6uoP9C0oTh8O42KY6Yym92OyTbL525FG9gNZ6vkM+Mw6WhbrCmsR4hBWSxB7+amib//AL1GJWIo1xn4PNS1y/8A2tbSDVIZyR2/YypidMg0EIEIpE+cIeSgMxWsCYHUgYEdQ5yg13eHoEKIEQW7xzzpMYtjWwLLYhco3+vRR8tDV6024uTKp4NEjw+7BBzO07g+y0oEecUFnDoP3FL9PSuxkZ/I9uL07a5qf/dX+o5rMe/E+9K2iMDv1rYqujZpHxgVV1bcVLPsj9ZgrnsafqbB0XFeauNDRHMVn6owZtGSm1ICR0BqSFUij0fAvfChPNYapuiTXTA9qBiEkeyX8lVV9e+nr0Og/u8TNNTOYCrgbLTdYfHsPnJXX4aTm15A5y04em1pnPGL591OCaljqQcasog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39830400003)(376002)(136003)(346002)(451199015)(8936002)(110136005)(5660300002)(54906003)(186003)(36756003)(41300700001)(66476007)(4326008)(66556008)(316002)(8676002)(38100700002)(83380400001)(107886003)(6486002)(2616005)(6512007)(26005)(86362001)(478600001)(7416002)(66946007)(52116002)(6666004)(1076003)(38350700002)(6506007)(2906002)(44832011)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bG8gA2INn1ilQ6f2yFksVZnCJeNzAtgf3jiV5EZLzZQ8DYAm+fM2jGdo+BI?=
 =?us-ascii?Q?Tz5cCPFbgtNMYA0k1onNGkcywY6Cq1cyKDWLZTZ8Mr5GaZawck2VXrAmjuR5?=
 =?us-ascii?Q?oKD/lYLklauFeE6osksJsWzBaD+C3uO/vaYKrxQ55JE+i6jK13jDJATiqc4O?=
 =?us-ascii?Q?W1RmXHdG58/C9hD3pMOvZ06mLdYq1gFOsQE0Om/PoaYb6YCmkk7g70Txmc0Q?=
 =?us-ascii?Q?nTlPVqGDsXitLDfVyoRZSH2qW5MWlva+purEiPe64XvDiDtLTuOO0wCpoynS?=
 =?us-ascii?Q?7+77ewSy6ISZUpqk7tvGRdcX3beolDCUIPKZGiValOZxPCzVDkUJz+LWGdbS?=
 =?us-ascii?Q?5tFx9EckHFRkGb+CMeIzKQLmFgD3h/euAvW+t+rvc+XLJEJalxWbeQDWM0KA?=
 =?us-ascii?Q?mMGQgAvsBkIkMWIs+9/FZU/Qcf9n8PK8cR7lGWG2vox+YQUP3diFP2aKQOsx?=
 =?us-ascii?Q?uzv4cop35x4Gf0qCJzm/TD6vjk7dje453b9yt7bx/M/u15HKLBWpFvBR+8Bi?=
 =?us-ascii?Q?gqtb+fwDZ5Cma7ibF0PhWMcv/IsKRu03rDmco/cV/0t60LfU+E49sE4qPyCw?=
 =?us-ascii?Q?o8JBJ7s9xRBUo7NioCkVLL2E5EVHD9ij4SAoN67KwiCZH88Ko1pVp+R1Erbk?=
 =?us-ascii?Q?wyprtnzQoUr0ZFY0HuwgKQsKiBYqhfy74noX06Z4v1RMn6nfMb0leamPp55H?=
 =?us-ascii?Q?uUrch7Iy25gMKO3oHksGA6co61qWwJ3qz2XlZyBu9+Kq8W45RawWusrgziQQ?=
 =?us-ascii?Q?Wlm541GpkR5mpsLdswo1N09SnAScy59PBh3PhSTmuVmlZt0nR9E3ZyZx0jDA?=
 =?us-ascii?Q?AmpgvDBzRv4u9/DGL6Vyq6fYvU3f1AgZ3awmVc/Comish9wivcn/S2U1SWyp?=
 =?us-ascii?Q?ffoq6W+qlgYGGUtwUPoQkMJWz7JzsX+QL+HpBPjAPBVS61E6Ef0wMlZ35IUW?=
 =?us-ascii?Q?yx1DHkpgDM9U1hx1aL7dC3smHbLLKiEMVVg26Ws+cUBhqtGKZKiCx1tLF0M9?=
 =?us-ascii?Q?3upF2wWyUJ/Pl6TQoG/5ZQTAbSO/E9jDyPkn8Br+jnLxucNqslfZEyR4D5V3?=
 =?us-ascii?Q?3YECLs/S/Oaj8AU29xV0RnmWtDVItYXVCZDi5iZVq/ptyJlkLga9NqQEwnGU?=
 =?us-ascii?Q?aGQOmBc06jQ4EgZs+3EJzYAljs6V78w28T2ojixtN95oBpTIiPsOUOPcYAGu?=
 =?us-ascii?Q?5BvtFayQ1Bxw47Sp16HceEl1Xn3mn0Ku8Db+YwfSIoapxcxWPFWWWPPo4ACx?=
 =?us-ascii?Q?Wl4+UNk3DCiakp/CID0rK3qUiv5hJEw2kS2jrjtpTTF5IqVKJcYiFLeSE27s?=
 =?us-ascii?Q?IXXrXTJVsbjm8gcmt/QBg5by999YDg1DTqIueTMoHjU97dPrvusBkDzZpI1z?=
 =?us-ascii?Q?6B2B8SwqHGD0xvtJYapQuqd7ws1xopB5oyB8vtSQmzdehkKkU4q6BHj0ArrW?=
 =?us-ascii?Q?6YUVJPsCf1EqEO+jgPh/LMDOdQpxBWnkDVr580cHI40r4+gS5mf0TQb+1Evk?=
 =?us-ascii?Q?ST5JyHi19NUMk2+Y3o5nprIbFuwm7kiKPKyonT0fFx6PuxYTzBuxOqawZ3DM?=
 =?us-ascii?Q?qqSuhqzfCelvCkRFn0Yc1fJRsUJ0q6aKFb19OiVE3UU5/yiJSHUTGOeyEkH/?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5993ce1d-3f08-499b-b770-08dad2d81c07
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 13:38:05.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2PaGnqb1NBL80o5c0DayoNFO5gYp789NBcBUa5YTq0d3QieE18J9Fah7vEqeL01O2aR0/IRQB2K0cSzwAWbvZCfrVgZoqDxzW3ncK1gpVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AC5 SoC has Xenon SDHCI IP, but with a limitation of maximum
2G DMA address range.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 3ee758886558..e1178a49f264 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -25,6 +25,7 @@ properties:
       - enum:
           - marvell,armada-cp110-sdhci
           - marvell,armada-ap806-sdhci
+          - marvell,ac5-sdhci
 
       - items:
           - const: marvell,armada-ap807-sdhci
-- 
2.25.1

