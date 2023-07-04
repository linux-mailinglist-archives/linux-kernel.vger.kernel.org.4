Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20769747218
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGDNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDNDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCA10C1;
        Tue,  4 Jul 2023 06:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+4f7WaVz93CxQTixXBbpwJ4dUujhqvFHXDk3vF3PyVY86a9hGpB1o8NevQzE5KA3M5QPoP56hnZVc1y+873Tv0fE3XYg144P8fn8tqfLIHV4rmFG3Cy9GOp2rub3BPs0enQv04FuJvyv6kdL7TXpkVUxbD1dMY2/h+qfUlxrLoTphFp+5tWzmZodkAVD9L4PtNfTwrEiqLFJDofQjRLlUmKLxQvS83bjeS+DmF94BCoqZpyB45fURPxoTOKTnu3y/bT3A+V1+5u2+FIQ6ufMjlMoSDge3xkWQw20Zxd9lC1+0Y+Sb8vA7DMUx6CAfGho6KpSceyv5U0Ku2ms6ErXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku/8bz1NMAVt6zr7o2BI0oqq7atDMIygT0R2tDWnzdU=;
 b=jE+hHDputEqQGEmwdo55UpJFiME50nYd1YkOKASipW9kGAIMlboi7lFmjNVyXei5c+dXNmAiDzLnk+meZGkVbDMwUew0MuXf8stuVtjd5ivBV+KAjpuma08z8L5gzFj6qX+Rysuovn3CKHv7lRKhlEGYYsFPXxIc7I0oJxAIP5C1CA4hyqDPNLlswbUlp1ENi6Qk+WK1yZIzgyQlTJuUgEdx+EYXFjUVFWd0tRgJ3IH83Lf3ofMQ80ffdcx10ZIexzK1IvccS0HXdPJ7Wq6qstjAGdZPuOqhSU9x8tbl7JnAP6MshzUkUpdnKpdAprWiXIRx4gHEtNwBt/QUafqn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku/8bz1NMAVt6zr7o2BI0oqq7atDMIygT0R2tDWnzdU=;
 b=Qvg+cfrlIkf5wF4Br8B5qSECtDy1FIunDX9EQFBPzIs6y9ntxOJsZK/sNL7SwmHe43CZ2lIEj5VBMSeYJsO6SovOyfkWKV4FuNTbmPqdBWmrgR91iEcWNCawFDtbgwURqcpm6xHPcRi/o3dDQXWpCR78gHs1Gy7Qsy8LGjvKkd+norif43mCSXp1H9KGz3rMaIRx8WIuwsWkFVVTA3cVji9EOvQ1Bw6jCYsaTVHblv41zOokA0aBY+YyHjciOWgUFNeeTejYP1VPtl2PTt5Cqan6o8B3uJZCh3kZJxcDJGrrXAt88pEkTAmQ20sDF9ddCs9JVOK3V83fWoQzZOr/nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:03:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:03:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] power: reset: msm: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:03:07 +0800
Message-Id: <20230704130309.16444-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704130309.16444-1-frank.li@vivo.com>
References: <20230704130309.16444-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf2aeaf-48ab-4380-f467-08db7c8f0eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmpZQis59jGU8OGH0wE7GU5Vtsi2GGkLzdxCyx4UiiGiXk+LCeeVv7GKDCpk/QDxynt0AO63P8m7btWhD82A1R4Fs7a95xkEDkQntJPmBjlOkl9l5SZ6Cpa515GDByCI3JpQgO8epNT0GiOvhSbEizoXuunFNvpu6F4nJo8F+5xaHNKWZNhjsZvOUCHhLI4MfdNgYVvoe5ckiSP1w0wEavmJLKJIMNr1vZHl94tbxVSbzygCbbkzMWIFV4hMz5gcPmG5WuyAL7/B741tbrEN33un75p53Ec8GUuiLSMb1F8iLDQhpTicwCCjCQZQvuBm3eR1s+4ZRnHz/YWHLOynO4vWE38aobBqS8CRyLtu12/5IB2ZXYtqSogJVWY1BzeEWKdfaI6gv8Vrte4/DUBbWEa1jv5FgpuRZwcupfvj+r2BD7QumavUep8YsVebxjm6p7gn0f28VPkUVQYisuyWng7yngjyqjw4il8e5icdfT4rMlwGN+GZ/1irpWzRySj3phol/ar04wYGKDWukEyxAttZmRZ9hD40q2xci8TPmc7MV7YJD+MfFFNhklw5HqL5qCbSL56D5mLzBvdkd2A1e/aQtGp3Df3dBsImrO+M7vhvhNkPRcZSZbf7UaWfJElw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(4744005)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I80zqzOlZ/zyMUit6Bkzn15KYz6q8FERNrEJKQmH2WusO5zy+KTwzqwe1t6u?=
 =?us-ascii?Q?gzYfMtsduVW5GHwktSOCCAuOAvFdcLwYsGvJyJnfmEjYKWBXrpGC+2jCZBji?=
 =?us-ascii?Q?7IW7RnGoec6D5t/BhI22RpObf06Y0ohdTWimozqR/+FwNeZmaGgqRJHdboUg?=
 =?us-ascii?Q?daqixL89bQcYjAngvQy3AZHhEGwW1n9Bbij/B/OaooiS7/URXlZUTl9XSoEa?=
 =?us-ascii?Q?IEhTFChQpY1CtjrRCmOn1jh1fCtDVgikGXu9uwthEMWJdN10QwBvE7MmDREV?=
 =?us-ascii?Q?lvm8pFHSIv2XC/vVDYw3cGJx+iIZrcm/ZGV5IpORK929b4rh+NX+H4+2Zh3u?=
 =?us-ascii?Q?0iCz3gdbRPT3AHZkx6lLJwTZiQdpgS3MgGJDGjVZt05CuUu7liuFd+UCzhs9?=
 =?us-ascii?Q?OoCME5oOVVy/bWw9Fz6OO9wGT+9RQOhm9m0HpAXF/3+kdpZ/Zzx6i+SkGa0z?=
 =?us-ascii?Q?RLW4RsnGBPpRwhO3+Q2G4cMtzRLsNmOJVxuGOua8+Lou/E9LlFPfwI1DfBtE?=
 =?us-ascii?Q?4f/nYF8XyjH+DCJgedPJabEflKBCakFixi9bni5DnFBZcW1koX/C8dKXaYAo?=
 =?us-ascii?Q?trf94yYmOOXO9IWfMkycdB9xKmrtZyEcH8NV3LIBQbzH/sTkNTQD7MMULRhf?=
 =?us-ascii?Q?KTiZ8xjwIBde8YZNqhzgrpDab8je46CiGb6CC1yxEIGdMQ7emjtYTWR/1sQW?=
 =?us-ascii?Q?t5RudLhLZtLheyRc2eJLRTMG0mNhFuaz7uPwXIkoKQgNd1Jn8QhQTu90sF7X?=
 =?us-ascii?Q?OpV8PtFnc+VdE0Ully43ZBzyKizOpiwiETp6w1JGUfe0Cmw7MKktZoPKRwVN?=
 =?us-ascii?Q?KCDINX48TFRosXOybmWeoUZ9CdRK8yNhwkCiXZMFvSGA4QFNdcT9a1gVZLVE?=
 =?us-ascii?Q?unrN12EeywneZzP30VG9ppBl9UhtS5J9T8wfJ/we2i6oEOaGQYGAw0Vb8lDp?=
 =?us-ascii?Q?jPD5YDjQUDO4m2B++s1+Ac0laORvDa0pUIssXBJb/859g2cll7DFomayPnE4?=
 =?us-ascii?Q?deKS+rLiLC+hgWh9aRD3dwf4KulU6Ht17eJ8QCKQBXXvOjgcaVafHHReF4FC?=
 =?us-ascii?Q?XdnjRSQ6jtwmxNRCnoWrQvE7CNoJxEt9tdv19EJhewNvfosi9aIO18kMSUM/?=
 =?us-ascii?Q?nCjUIVIYHS1kVZ643w1mfTeffqetNZ3PPuv1AFPUvqZ/ewZMY/AIfVtEPole?=
 =?us-ascii?Q?t972x4FVUtBBdaXp4AokgG3FoE1upc5J9ivt3VQFx59K8YQsJKBHi6Cgef9Z?=
 =?us-ascii?Q?78yV/hFnJo5a2YkvoNyxpZmx40tB7BV+b2lZg79TLklOQZsiXwmmzFFyCzKT?=
 =?us-ascii?Q?fwuEszsSt2km81UsvrAItyTT4cmfn4O+Jg8HwVGmGBpAU4PFSPVS2UARgQE0?=
 =?us-ascii?Q?yE2yOYWK+GO9y2FOySMpoDK19Bs5x+UGdEtBx5QV4yIEDB2bKjoD85AzoNyL?=
 =?us-ascii?Q?wFGU0H8Ta4z2lJVt+V/s2aYq7r0Wep0x2S6LrR8hIh38xrHtIrXkwk90wfNL?=
 =?us-ascii?Q?6TPql/UFsz+Gi4jRO4Jtv3dkYjGtnSyPgwmkekyJMhicI/08dhfoMkSdx5LJ?=
 =?us-ascii?Q?XY9O2jLRNBVBKz+tCs475in4ji5EVrUQXxNiXF8p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf2aeaf-48ab-4380-f467-08db7c8f0eaa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:03:27.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5rG+5aagQGVEVXam/s8pGzo3w1ol433X03RKPAR9j6rI6zPfAJ/jq0jb0CI2A+Lq7OoiU6OEg38ni9L0iHghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/power/reset/msm-poweroff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 0c439f83bf65..5921acc5c51d 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -36,10 +36,8 @@ static void do_msm_poweroff(void)
 static int msm_restart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *mem;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msm_ps_hold = devm_ioremap_resource(dev, mem);
+	msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-- 
2.39.0

