Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7096BFAFD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCROqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCROqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:46:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8912A6F1;
        Sat, 18 Mar 2023 07:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFHeNvv92/YwBQumknCVah2/RITA0gVyqgy9OjNcDjPwurk3eIn8vW5eUwsBKAmXc82fmvn4YJ7k4L10a+9K9evvM1VWkqIVmefJORITxRDZ9QHq41U5SZ3uWsleQT/B1mfYJBfvdxRVW/1sQWZL3R76hPTIQLiIjyzYNIt0GVH2SBVS1gsYWSRlgfJh4r0/txyBlh0JC5vTWzP5CMhcRvPkymf71LLbEV9jCTJs5/niPGuUA4NlEqencHnXQfZSJWe0At0/Dzr+OjlMvn2zmWNTxQwGX+EyFafSJqwMYMOCviEa3Qdsr6GXTJVPdB5IbD91Wa3BW0VNJ0+Yv77oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTH0G+5G12eXJ8x0ITh15l9zXq+RDnTvyS5xuL1Ncck=;
 b=n77uOkU1rsslcKXzXhZ6t4hI9ZC6e7P1oSZUSluWXH3r3PYjweRNjprYVVWw7fOVDHNq/DVg78icxdC4g+2OOL9kFdfhDS3Pj+zTX5t8MvKnJ5wrrhhVEKLMYlcyJrENviDsKKEQKrgc2vZapic7QvkGBQ1E6EMCizUc415BhLmCtZizgYMk6qE8FRcY+aUDFFeZ8Ruzjol3NHVnvt2GlEkW3Ub8+FT0iTtRvb7UnQOdhx2JnfSiR8bdXz6ap/pLjL+shujGQ3Bn9fjix4M6k8Y+E0R5ffs/B9agnHLxVfYlNiRjeeFZgaFAC623CxAss+qZoVBYdUmZwrbYkfzOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTH0G+5G12eXJ8x0ITh15l9zXq+RDnTvyS5xuL1Ncck=;
 b=drAnEbjZO/QgvcaFnFa6iqfscUbwkrtmDNeIc55+fMVb9SwsUAjdqg5dUNKHD7cHEqtJK1CScQwg77FxGztJ9FxVqp48n3SeaQN4QrjM4Vz6y+BWMYFT9y10HnkitgOr2LGHKuPMUyE+mwDv6NUCjaEdCoi8pyHEgnMCESQEm5GR0ANarO46K7n8dXJqR2YZo0fuiJsQun2xbY/Hxc/UsE8SnnMJIXrnBroGBSUbsDTLAn8DbcG8zuy2cH2Xk+T+Nje44dKB6foHqsQr6fuXnRc7yEh5SyaYzmFX5ICeKNvb8ctU8zmMBvnLNSFKCZoQ0CxfC22YdWMYojBpzRnyRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:45:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:45:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] thermal/drivers/qoriq: remove redundant msg in qoriq_tmu_register_tmu_zone()
Date:   Sat, 18 Mar 2023 22:44:10 +0800
Message-Id: <20230318144412.75046-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 877e84a7-abe3-4d16-8d06-08db27bf610c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQIb4DtBfGdSnGfI73wxE6OmEm9wrbQkw/Bwecn7jHGwSkiaRH3IEUa9UDIGziGD/a5pq2u1Gy8tTQApxm/d8vFZtVCFo73HKbwjwnM312QB7sDOJCsnGUcnZIEe9kGtKVjuo6YsNxAuLotzpy51PV2c8vumthkUg2AGse1+hPaR7REN+Eq7keg/dQNJS2ayUziYSWpXsSEm7gE/GPi2ANgwbIPf5gve5lMzWl0gj8thGG7aWRTi37VkTsrnSplOh4hbXrIhKDo8xQ5b364bJsisNyJf06x6oTXBX+Od05JagCIzyfPxtpIX1Sr7lKeEOjPbSCbpqf87BZR422RosHdJ0nka9y++tPCdBkeYBmLdkY8ib/D7q+DiTKl0dwcTg7JSzDSPmcg+AuNw6r6bSB4TWWscGtXS8WuUOko9RNBqg1NU5O4BQe5m1mykpASPo1j8ru71buiOxbnWJE41G2xNdBmdwqrSqsccz6ch3Xcx3GGi5nX4iUGpfXX/3oG5sNSNM+Nl1N4EE7XOCuawoAk+I4ucHZol/1Cm27VWe99gtUGn8REx5peuUIlfht2JEGtk+zQc6tF6qvBIeVg+ogoPMQuo1QHGkZ7Ky1OHCzVwWL7e8m8wCSiVJIb4d1nsmAa3wFwcPGSLIWP4ZJRhUumKczce4ZqI6CG5jGO4GnokERBlnCvDukX8ewz+RnlVX7U6rcePJgYTkBPDFGFL5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(38100700002)(38350700002)(8936002)(41300700001)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EQGbv/SFBxMKJkaEz/2fSZLFszc2RhzynEdrl5DCj8DRX/vnLrJijZwe5C6?=
 =?us-ascii?Q?RmvrfExB52q2CrylM9NVnJr3OYYRhE2QjPge02iWpaDGbXgBCUOgqlLlJK6X?=
 =?us-ascii?Q?V+Pxfqs1zvZuOXTbAFnkPBwoaFSmJQwoLZal5I4yjctjKxQc1pBfEIJoJd+p?=
 =?us-ascii?Q?dwB9yCRToGb5JW/xfAuJ+TwSNcKp614LMSEWDdaMm5WhsHSVaY7tfzUmR/Pm?=
 =?us-ascii?Q?q88sR28L/vTD6ttUS6S6W9/6h5D0FTtoirkKHOzYxn5vvQmAahO1RT9h2E/Z?=
 =?us-ascii?Q?CHe9dV/DM4BC6fNWPxGQZwBT9gxjYJdQRxFXsC7GwgbLEN1FgoQI7z7CL/cc?=
 =?us-ascii?Q?EIVrnjoeaUCu/rA1vvhMq+fJIe338QNAhHj+dGpOuf0Acj8KgQqtPuuGDub7?=
 =?us-ascii?Q?m1c93Ic5OpN04oeuL5AZs9Qc+EvE0JmlM5pRBrXpKTzyO3XjGADCjxPpjcUI?=
 =?us-ascii?Q?Fp7QZAKRE/FJZwNLYwaaK8Abi33+Wkt71px4RmjkPeSF+kSWQsoBj2+aTtIU?=
 =?us-ascii?Q?jWWcnGCt8gnhcS0dJtDRhXhMX49X/AyCJhmHSoBgXC2KDuxxvBMq3lkxepaO?=
 =?us-ascii?Q?a9v61i+8mvlB2pLiTiM8nC2bnGKFZqZMid1PpFrew7RQCvkd/rSPh6b3u8p3?=
 =?us-ascii?Q?cawT8+5bfCqX7x1v0YCHGmYHok5rseRxCgCMSqDOnAqBkTKSthGGxabBdWYZ?=
 =?us-ascii?Q?rMIW/92RgOF1b2zBz++SlSYERyFS1Dsp5qyHO0ZjojCBiI2eGXI9yRcR1Wpc?=
 =?us-ascii?Q?x6KTPU7Omy5aNw1HBVTlARjsri3mq8qH6QpvieFrV/iofvn3IzB7J3qtI/Wk?=
 =?us-ascii?Q?PzYLyskdfxNlqnMUT1eg7AjidUqUTJ6jUW/4pi6zJdCDARTN9Wo7aF8AH8yh?=
 =?us-ascii?Q?V4dtVCm7q1cglaQ7ylDv4Ecb9AN4AifBn0SEQ65IS0wzlN+A8Atcra+ZDZW3?=
 =?us-ascii?Q?vesBv3A6n7JtbSTRVAZp7RV9we7W6sLgGpvTPBEbR96vOv48PNAmMd/p8pa6?=
 =?us-ascii?Q?aXFasNw2akxpJoHwMQG/iV2CFbZDNQoWN+OlB88oyOUvshPKe3k+IH9ha0SH?=
 =?us-ascii?Q?FCnn+hjKXv+4LJXMo91pAML1K5E5Jf9FGk4kOW3zONx3QtQ3uQxsN8L2qHNP?=
 =?us-ascii?Q?ATe/e1/ot2iZVg4vOfYzQ+dxd0be0WoZQIfsUQAyldHJh2cTJ169UhA3FgVR?=
 =?us-ascii?Q?UGgFf4ndfjU3qLjOwKEqrABiIYAJ6ZSeYVwcbEzMcArvVdATodEiHoKewKnH?=
 =?us-ascii?Q?3eo9wt9U5QY3reJNDEKBcghFiZ2g8PvmzsbJpqcYls6KR5aMNRvUKNLwO+LO?=
 =?us-ascii?Q?dFvmhBVTuMFMwYpkft6tm4ZZTtjuJFGOWLyBZGPWt0sKh4Uadda+LWq90Kjr?=
 =?us-ascii?Q?PZYe9Nub5tLHP7DYizUJkQy7lYy0gfbCxnHv4+Fr/KNJHqtC9XW9BYUfTWTP?=
 =?us-ascii?Q?Y9s+m4XqxW2Rz8rioGbizMmbivNIjiIhZWN04hfFcCPVbsl077+oan8AGhpn?=
 =?us-ascii?Q?16Q4uHM5GplETpKsCz/fTb7/po2TAH74RoIb73o7jCmYuKaaQ99U19zvpohK?=
 =?us-ascii?Q?iAjBI/4qybrQWqu2A89QRD2Ld1cxEo+zQT4aVaSK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877e84a7-abe3-4d16-8d06-08db27bf610c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:45:12.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpuW1KMLW3O4PJhW8k0H6UJ3U98YGojun1WSYvry8NbgiMWT02LjBbtSXAS/ycNq9ElcS14X7TIkQFXv0/Q54w==
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
 drivers/thermal/qoriq_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e58756323457..61b68034a82e 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -157,10 +157,7 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
-			dev_warn(dev,
-				 "Failed to add hwmon sysfs attributes\n");
-
+		devm_thermal_add_hwmon_sysfs(dev, tzd);
 	}
 
 	return 0;
-- 
2.35.1

