Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115672DE71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbjFMJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjFMJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:57:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F710DC;
        Tue, 13 Jun 2023 02:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOwbPjqLpvz9GZ3Saft7C3M/+rjadxPKhHUQyPezzwKzYqkBXNCUioEHfJ5aEWyhGeyqv9bbHTue23ldtS5mgQfRGsIwqxCPxVshTWwJlPJMrHacuQIYKGJLdjoe1Z2r91kDtfR8Uqfvb6+amxFbGS+gm0CD+HpWglWIBqpeLBzswhPyoUgbNw6fRZfnLU1U1q0msLMYm1x93c3vn0m+u6Q0fAxojV4vf5BzOVX3vidM0iz6Jyg/R9VBwEIr9PKu98vZ+CT60dMyTRgwWD05fE1+ikHMpfwmujGJMz7swdOjITrWDKYLLX4M1cxTzdL3Hhb/ROesV7Y+gZnQ5H5zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Ha1tRsob+jqsqACWErpPA/fxmNzTh+5HmmKy1c0Js=;
 b=BH6iaCMP5X3EYD74/of//vVDoICHhC6paOvifkcDsXhOixGZoJs8v0ezK0cuAczpDS6rEk0bJQVTU95oj9sgVBDrv32AnH0byQbE4q7rV8hnbddY86l201VKZrLNA1pOamcbrTaT98ofP2HsP1SRlSOVSZT344/hxVL6U6dKkfmmulfleQMUXFd93im7rjtNff4WyB5Ie1rX86UMrunkB4t8OcftSTpa1lUHns0BRYuyRKrB3JfIg8OnMjrJ+BH+XmQLKxheH6ac6Ad6PfC9RSLMtrhXmA42TRw2uqqaxzIYgxIvx0gLkyDpZccB3XmRttrm87UWnYzHks77xqsd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Ha1tRsob+jqsqACWErpPA/fxmNzTh+5HmmKy1c0Js=;
 b=q7aFEA53Waw6iw2sdDfQ+zCrwzN6xzCGgYaVZpgZA0+6UAwQ0qX1dy3zKk7ezKcS8abSQ1DsvgXkJMeAUOrCcFNZpu5Fu4OTusGErVSsxBynvMraY8HvW9Ir0iL3959n5oCbyLoFe9aLZHc6CTZVXUwQcV3xS60xiylApxzLLpqpRECuNPbGePTKwGex7D6p9xOulGeZnYETfKUvyuBdKdfahwlM1OrYBy8NIL6x+0hipgBSeb7+KvCqfB62HrDFbtCSwFsk5W//FaqqXN0kD+1HLVnW3lf4nnCHhhaTgjthuE6Dg5Ea1nAFL+HL55G8cTZxrMnTxosmki6WfwlRXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 09:56:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:56:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [RESEND 2/9] thermal/drivers/sun8i: remove redundant msg in sun8i_ths_register()
Date:   Tue, 13 Jun 2023 17:56:17 +0800
Message-Id: <20230613095624.78789-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613095624.78789-1-frank.li@vivo.com>
References: <20230613095624.78789-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffc0e59-e1de-410b-088b-08db6bf47fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uE5ktRvaCM1coz1z6Kp4trGe2eGFgNxQcnn3siuBHbrDyvOXjdOlP0IKXKPQKjJGRVj+yALc9L3TSsXK6kQgKskUvPcR/G8zpHyrJ0PXmVO1wfkdzcW1edYVjIzoJxCQV6sdqGFc51Dq8NCwU9yOud/qEbtCD9Gg4KEPrfebSf2RpVjCjiQ3dLYNyBhhDy/gw3w+vrZ+AsBntiyeqzilGt8mdF88BVOeRKhH225JSK2D9R5IrbDz99w7wAA33V41iuX/4RLIRCS9dxYOBGdKLFFbAmBFCnNMDCux2rDs5bt3swpiAI3X5nkksaYcS607j6M9cSLWN20cwovHNaLUDDQSoZwCquVGslDlOK5u8HV4QKU8M0hYKkuF0AfEruG3/e1TjMU28dGLxX0GUrqtw31KFjGTTTe5fH1W04av6lLORxBhwdsDiyqrfXoZcGPiqSbWCqhNgUZyrKWc+6Nj0hVPoaCbo8LwT7jtsqA4MFvX1dMbuNNv7h7zBj9XQxoC5b8UWyq1KJIEZvOM5WigeAhtqSX9o4CCI4Ra0MnhfKUJG8faLh4VL9B5WU2p3j5cIIdImOPzMs6BpSJtA4BkRUvqCuUI4Gi3UOM5ZeYkkkF+k1qumoX8Vf7mJ+8PAMGmyOMhiwlStOLifRrwq7Dt6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(4326008)(8936002)(66556008)(316002)(7406005)(7416002)(66476007)(41300700001)(186003)(2906002)(66946007)(4744005)(478600001)(8676002)(5660300002)(6666004)(52116002)(6486002)(107886003)(1076003)(921005)(6506007)(6512007)(26005)(36756003)(83380400001)(86362001)(38100700002)(2616005)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JAC5IxmwnRwaZr875fCUHhldvTEme4/rY8yKkOlfPlqLmpjWcBtw5UIsyFW?=
 =?us-ascii?Q?BuFlSlx7eu6mEYWedTIxFn9Ct596ltlw2MhIcMqss4efm5ecTxbyFyEJYE50?=
 =?us-ascii?Q?yoZCtzyRf5AJSVfEwcNan0m2TH1p29+tOOdkveMoEnPPd5vwzEQ/mVLcFO/j?=
 =?us-ascii?Q?d3rmLeUe+ppJaRUpt71HErX3YgkFKb1PSEwIZouPyWwTLKmI75gtQZzCHmV/?=
 =?us-ascii?Q?kM4WayNJDb8NWlG7C0S9eJWQuz0yD797w0rTcOyUCUz2Zvt9ZgQCIqKV+hQl?=
 =?us-ascii?Q?Di5BQK5Jl+k109gw8CjVK+NLyXQ6q+hwrYKP9tiE3GLyZGPtx380bM/X7kXK?=
 =?us-ascii?Q?3wbzVpDYYVg0RxGOvH+hPbfNEreb6xX0duqh4xFw42fOY7Qgd7LvEg8numL/?=
 =?us-ascii?Q?LuKPLNJlXMw52lecpReQixl/SyY6CKZJrqoURGBMM686x7W245esls3T8cvT?=
 =?us-ascii?Q?ockgm764cJiV/elO6vjzBRNptFx+idokTXKTJqD0V55f0+EZ5jyo29q0n/VK?=
 =?us-ascii?Q?Q2K8mprKeu7J6WliliJoa5amG/FVSkQmtpurMO8gN3p4pLdvj2rOW17124XR?=
 =?us-ascii?Q?fkyw5gR+hI0EhpqkqRPqyKT9xFuPOg7BAHp4WaI1eVREZW3d980kn5ZYvl4Q?=
 =?us-ascii?Q?iH1CdAWqEx8FluBShjgSzY+yJwD8079b1byaoPfuEFD1fhIn8I37PpiuHQPI?=
 =?us-ascii?Q?z29ArDVdDFtLZBe4BAU5Sh4KHRhZ7eQ3LONxCeylNZ/7Wu2Whf2jhk7Fk+wc?=
 =?us-ascii?Q?2/evOPALos7FzSw6EftMUIyh7Sv7okTZ2xuKSi1JnMZ9U0FFnKp/fm+gitI8?=
 =?us-ascii?Q?CjJvvsVRL3SNXUBTYdFQ09SzqM4FVTAaMvbESDHeSfXnoW65Om1o0Qea6Rzs?=
 =?us-ascii?Q?PMgX+c8SsM2saygsTqrFlXStaiTr9ukDhijq0fDxI59KuDdgRMo0pzVwFJ7O?=
 =?us-ascii?Q?62BWWJUXt+1I3hpQQ5Mc1KtNtrM0F7TUQHDrra6iG0hmIhs5/6ygRYZ/mGaI?=
 =?us-ascii?Q?hRblRadsIKYIRJ8Ib/mLsmQ3Oh4xZmUBQJ6/hB9Xu4Rbl6K1/JXEM9TFXD/U?=
 =?us-ascii?Q?mZSeTeqcxgTcAhefOomjUOoXhlHvvTc51IXdkvkM6GvF1mb8KX3jj4Hixa+I?=
 =?us-ascii?Q?BX7UMvhcP10+GO0+tPTgPcm8PHmRLhaFd1S7pXu0mrIeoVNTVxHgqKwN+xmd?=
 =?us-ascii?Q?CmP8Sggi1IdbIoYjEmH3BAdOKe6KVSsgjjdX2HxSSq+Tt4GTP2hutU7fl8ft?=
 =?us-ascii?Q?X+0DWSFiL6csNydqeriusE/DzP6yesEHQlVcjnjKsk7pSQwBbHR1+/o2s2LV?=
 =?us-ascii?Q?5N5v92wPS/j9bNFeZJKHIT+L3t8uOFw5zCCWGaTcDbQnao/sJQANAdVPMEjn?=
 =?us-ascii?Q?u03hyp22FJSkdfF4ePWV18b0tHO7YIVVgdC5nSLTRineM/YoXX7okqIeHojQ?=
 =?us-ascii?Q?+CWymRqYkPcRSp1/cmYg1Y0bqAXm1KoxCb0kz8za+5ozkFCDOG33lE+yEO8P?=
 =?us-ascii?Q?c2NhNEmmsOjDlSuYErsKDux9NaypiJdqhQUUy/GPtt/HRR0Odaq6+9VVj8rs?=
 =?us-ascii?Q?QvaDNJFx3g7UcxfDX7T8JzhTVFiA/iphsKwEVnSs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffc0e59-e1de-410b-088b-08db6bf47fd0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:46.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzsMOtkjbBhJ19CKKhfDiu3bB+vzcr5VCp0n5Pr4M4w3izV22zq3X9C57Bk3dJdhtLcNKw/G1lwTP4umFGvcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/sun8i_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..066f9fed9b86 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -475,9 +475,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-		if (devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd))
-			dev_warn(tmdev->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}
 
 	return 0;
-- 
2.39.0

