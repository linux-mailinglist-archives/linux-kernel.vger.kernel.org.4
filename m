Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FD6BFAF2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCROou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCROos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:44:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E9241C4;
        Sat, 18 Mar 2023 07:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irL0RQhPxlkpPI0G311GjDg5GUudmCn/ofNdLrPQwOzioiLWCGJt6+uzUsdKpzzngj9qvQYzIqCffJQ8ZIdqv+NtTA+HO430MHD7WFe/VhwQi5DePI4Qv3rJeSLMi/tKNPb0bPwM7yv3A3xBmkMnq1eycmkP8L/q0M+lM44TqMAK0At7M9cCskPIN/TfmFR7faPSulJOj6gPQz92F4NdxSPpIsxsTiWzLnnhdhNnHnAxf/lsdjFyh09NTDcD5GhCc8JXymVtS0aHJJ+hY/CdzAgUYSFXfGZ46d7Gy+ys2UHfUfnPbSjgDugS5b5G97fyYCBwIzYn4saGxHqN9IBdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOQBVLgpalta000cV0syMmALdmujptmWpGBjRSRzoWQ=;
 b=b58e+4BoiejWoYI+Xzspl8c+T9n8kWGjgpnT/pG1gMFRJS711IhgNFIO93+Fjm0DiA2Thdz6/BythRD5pzAtO4JTRDiNVQfcJiqgtOLdYejyuKR7vk5Pv5mlEDefP1/7+EP069be9qXJLNpV2q4xplpcJ09OXjnU0thqRvPJtSFt70aMyB0AwWUTMo+dampncwV6u7kdAVMssaMgzwI69GyoVn2zEGz3SGw0bQgGRczqnp1mjIRxuqBSFVnhJYU8dT2PvMA+zHPxD4upRFZdwda1gNNRq3kM+lFkO2UrUi3DfXgvwK1ymWby+vbWZ3XhS2z+1pU+9cXwFlJAqect2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOQBVLgpalta000cV0syMmALdmujptmWpGBjRSRzoWQ=;
 b=eyN609/yhzEpZIZqyEfwUUXiyX+FsOK/5UWb5dT0qT/beTyQ2Pfe04974gcxiSujQkwKCq4wrfWjfkIRmWbz0omoSxc/HJsrkPJ66SqBVDIXjad+jnCbQtIzvsMpSAmtnGEt8KzCbwFYeXKsjRBm7jj0nAaXUc1fqgxhjcDRjVqas4PzIO0Or8zSb9f2KdDfD1RV592uFR+Cltcvt+brsd3HSWJSefs9rEwYI38PWGv75mDtiuxvvPLLhc1gpEh7pp69qVFPKYgXzsWPai7i9ObCYukvv8z+5eAR05ndkYyU97G1bV+yPPaDiXub/tNcnPGQciSkIMrG9rhYooZ86w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:44:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:44:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] thermal/drivers/sun8i: remove redundant msg in sun8i_ths_register()
Date:   Sat, 18 Mar 2023 22:44:05 +0800
Message-Id: <20230318144412.75046-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318144412.75046-1-frank.li@vivo.com>
References: <20230318144412.75046-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9c9d7-270b-4fe2-2ba7-08db27bf4ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KB430VdNpnP9enNPHtbSbYnWiduKKIqaAPUkzqj+cpueA4c0c7ISnfhBMq+GIOOY0v2N7BKUr28UvnOEbw3nyTznA/asJkTIzZ3E7wThCI2IWYm72TBXHFKNobuK2iQPOrs5D2nynjQinRXtF67sASwvmeG+/SRktOldOAY6D4bZr5IySVzyMvzHA3VQ+lHIJwb63RnydfV2RtF/Hc0Ab7yu1LtT6aSxC7hecYZaWWHhARnQ6ZrxJlJdbxW+ZRoZGwI/pGK79RaUPxzpfI4cR5Uq+wQVZ2f2g22qZIRWhI/tL0myVzfElirEpRNHEI/C8rBk52STB5gGIO3TedX10z3TwQtbZMiz8tPTTPXOEE7n6qKN8FjL3DXkXnfNMfIRJEnYzGWtOfMyquLOKQnZQ3clcgVerWm8QZjLT8A0rr2QYQEddsOp5mDp+IbQSvFyiE68XHnaC76oCPVbkLUO18IAOAYJdfel5oGjeQk/95bsrWskKeluMF8rBUNYZDypqGLDqR5nBa6yy7TRpksnxTroCUyt0cr+mTp06zKc+Vyyp/3HX5E1bCzvF7dNfq/zb7IHWhJVHb7jwpsFmVva8HaaalfaaY1WsG2iHa/DQnqY/rBCDT33dD5ZaKtlI/2yzPFrWViVVDkIC4LknHFrvdHZ+IsHrbCeKURE7oaGy8G92/hfG0dJx+r/E4SomtpMsP8HZtmUgcLK8jgXBXf0/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(41300700001)(4744005)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P636WBjLO9Vx+dfqLJDT/GDX0IhbEjZmUPM/rImA9wjS3mzNTKEa43Q6UTq7?=
 =?us-ascii?Q?FdurZdoddeUzCMcI4AXUUI4O9IG2UokZlUrkeFMkkAjqlfeXLggeGn3tmnvU?=
 =?us-ascii?Q?ulh9TCYgYZNbStxxHcQXbFJP4LmlIYVcGL0yJXBTEeFzU5f9RRCuYigD/K0Z?=
 =?us-ascii?Q?+23DSGCRh/Us9dtLd0ePA9hI8BxscRuI9uuSIb4Tu+jBGREGEst86Yh4zQg3?=
 =?us-ascii?Q?qvCHAioNvplSXj749ACorwXqP6F1Qo2x2fHaWNMAne9svZQvacJMaP6wvEkv?=
 =?us-ascii?Q?6+rF7Kqu+qPa6bFPOlbeQ6bZehRUGQWFZIMJymgygw8EiH5N+uT0N7umWmfR?=
 =?us-ascii?Q?fzYeUHagGu7pLCb89LUsLp79q2qmQ9sIEJ70NdTbyrLxKt1qDcMEk8TTY159?=
 =?us-ascii?Q?M/oXHLW7WykTcquT7nI2thjCnaFIMFB+MJiXelDIl7kkY/NxwIkCrGM8rAig?=
 =?us-ascii?Q?KCNNGMtTEPxQcs63PJq7VdecPp2RVmeCZDtwJ0JKBjMBMWdb8eRAGLZ02G6Z?=
 =?us-ascii?Q?IYyRbFwyF7obAnZh3w3ORrTfxBCkunsd/Du5Hct/CJ05yP2Q/J8aRfXr1Jaa?=
 =?us-ascii?Q?ERGPqYsHN+Y++RdZBZCnqhW4buAPkF3GePPZdzuPSUM6HzQnXyhDHEAJwQTp?=
 =?us-ascii?Q?Xs5wxB8vgQaPeSsciQZCp3Q/bD/wN9peGMYVvSXQXivpOf10AD0VxgPFpb4U?=
 =?us-ascii?Q?V2ffSuNB9JRMSEeApd4sp+6OZGIHvkB0w2UNBGxDeWMuOxpsn1WeeyJcpLjf?=
 =?us-ascii?Q?d2TpnQOgiM80bUfC5qcvm6dg231S8dSg6DOXe/1WoqKyZsp9rUBhHbLn3BZ5?=
 =?us-ascii?Q?pa0ePd5mIKFiCmLI80P+pb7r2XZHT4MTe/G8IbFL9OvWFKe8KaLlFeFpZ0qw?=
 =?us-ascii?Q?eln9s3hzW2FYRROvQM8oNm2quCPoj86BFCS2HiWBfgUBJtFQD/IvYOCZ4DZ+?=
 =?us-ascii?Q?+2jWxZ2Rqm29G0vOKQUe2g1TUSkZLtAjtWqj9FSpOWfwcNDJDlmLQuGjRmuJ?=
 =?us-ascii?Q?Y5d2wMnKlRFWEUfMTWM2dEGTkhcv5b8Lro9OM3BKKQB4/Ex9MTZqXnnyKlYP?=
 =?us-ascii?Q?NctxO6wnIjB9yw6MpWdVi9/lzii6yoY2KMCiZ2AIIkw9Veu2JuqtvDF+Ig7F?=
 =?us-ascii?Q?hXQ72LoDEZ2RKra/5+UHKV06mi/ODihMF6ED27gmCekbkM+JBh5yeBgciX+3?=
 =?us-ascii?Q?ET2IqMcMCTj7KfCRtPTqJHaOGOxrUFSQ87nheQNEW3ZatFb82nkZmjfOVtur?=
 =?us-ascii?Q?Dg+N66WwpNoaHVP6DUeHWlxnsgoV/Fmbmmxk8i7yBn9EFiLf85gKsmnXDosQ?=
 =?us-ascii?Q?7nwOAknPzjclkg7vnEsI1g9PCxW9BdPoj7ceBAJSfwZgPHUoku5qiiOlGSTq?=
 =?us-ascii?Q?P5PJg5W7RTn6oZefGpPkoP54/GMyx/U9O3GrzBWBXJqxLe5TrRmutOuz5K/m?=
 =?us-ascii?Q?IlJvUc2hCLETaKN3+ueELpBLoEFhiU4C6pVv4uGA86oLKakO+LQkfb50ryGx?=
 =?us-ascii?Q?v2YyuaQhQuoz8AWsxMpjbteObswRei3KDiVG+E6G0kqlZ9EnNdTDhmwU4V+b?=
 =?us-ascii?Q?Le1GRWffJX0fXcgdgOcNVC6I+tVHFx1m+eFEZY+D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9c9d7-270b-4fe2-2ba7-08db27bf4ffb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:44:43.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqUS4EFL5hw83iXPAlGqqIzBAzG9ObVnlAdJp/8Fl6C8twzOgUVWubUH/EgDUjYVyEr5b+cyHdW+7jXMrQEHDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
2.35.1

