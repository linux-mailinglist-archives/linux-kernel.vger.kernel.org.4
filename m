Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AEB6BFB00
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCROrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCROq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:46:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F59C144;
        Sat, 18 Mar 2023 07:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWdsqJeYpHbr6iF4jtswJ4RcKNMRuJSjYpOebP6ipjGtkOx3Tx1UmUq/GIvnK8frjBcik08BxvjOFumOZY6/QQg4JBz0sNAthoZzCqL+jHYDTOweLqw0djnidnM5jSaM6/OUrv7b3VZVDtULtez9dVLvBMzWQokbKDnYwGN403b1Qx3ZrMKqg3bUqBmUwQkL1On346E+06uHXo2zPceZiEurDX8zfsxWQqdLBkyJ3HcIkOVhCTU+rzWzOB0wHMZCQF5B2HHhB+XcS/RnpvUTBrg1NnoNz3qHQJIECujbb1JIxYQfpzdTWgjXbfu8Z8/2ZFj5PvxXwjghUidIUZg53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nIv0m6aN9A37vO7X82/QveyknUc3Kl6UAetm1E2t00=;
 b=kKB00cQHRT9H/E9ozi+8qt1e2AaLkZLj/sYa9i+poeJbc52VWrPkOBzOG88Dn9tuyYciZkZHzCB6k9+0crTzOBbgCgKYT7xWSbSQxHjXZ35f2l8y9+lmTVSFmnfK+GNzAZtE2vlUfzuwjTA592olttWVxKa2wYD6ROsOPfgD2R6tYINACmtHJoA55iLoXMQyaxQm3QKmJEfxbt8wgEUqF0veZxpRtt/a6MURz6SVfjovm/BVdcOnVIDgJMjG1J2TgattitwruMtlrJzs/k9SHldBEOjjDmQeYWt5ReGtS7MBd6zRWkcBYLHKeS+8yKTNje0kUntfcUnf/3rvgQkC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nIv0m6aN9A37vO7X82/QveyknUc3Kl6UAetm1E2t00=;
 b=Rpsq/56eYGVVqQsGLV17yrogyAS1tKTyuxX4h9pkEUkWhFSAjKIQI3rHHgpoGgTt34vLx+ElYdN2LOmqiuF2+2zhm8sT+b263MvK+IXVRjwCrJecunRzbZZp5j2Nwai6Jukbq1PSbkr8HdmjDe92b3XV0W48zRVn6iKrk3gIFeg+xOr2nm9JlAa9v2u9ZlhEqX06DBYz1mZgzk8L6HTCuXHHGf6m8r5H89wi4r/zN1Zsv71sskVXADyXS51g/VaAyC+KIGLwyGmWlFZRTfpELQZWwbET2qofp7ozzA/XnrpQZSkRuI1StmAIf8i7c3Xw4kObb5yDFa6+ePf9h4AV9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:45:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:45:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] thermal/drivers/qcom: remove redundant msg
Date:   Sat, 18 Mar 2023 22:44:12 +0800
Message-Id: <20230318144412.75046-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbf9b63d-707e-4ad4-fa8f-08db27bf6546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3UDln+th3ckpOA6mz7mgl0d7T7UcoLMrwKKqNiz7CZLfQxgQSqDrxtDnKSTY4KOywuTArS85gGDS6s0ciEq1FESGIIBgatByetyFOACG5s+9ef6y70occ35RpiIAaQvMKOntCdibzhc7GrjDbBbav+oLsuVKWvwUSSmY+SrsvbA75k7df3jsmBpxU2fKB5c1MxFootH8I/E6DLdI519ALFNWUOoWpsTcXL+b3NACiX2f2eSJI+seHC+Fl8Su9Au879dAdk3Pno67RmdAJxE3LDHmqHvuv7TFiq3NbDiebBLtfRSi+nOEQBr34CQp3KeOrG4S7xwg+VPq9vw9ty/bkoB5KQofZ6zQi+RT5Rjebch7407OcSoJqdNk04lBJHlneNXCZS22RnfRdJX0sIGpjXXKzHax+83DKGGBDwjxxsIAy+4/O7HE324N/7WBxpQmCayd9aaCbb4eD+QbieClJJHmgtMbRKrwxZiWg4sfobfpDBWScoRxgNTpnLy99NsEq4++rU8c4C12xeL7W5SiL0pc+4yWlpo+7nz1ZJUCRYcRU7SDoEpNxJa/25+J95QlijvMs5Z4/6S+5bQbVclLRJH/2zr3yyUBVVXSgvQR8VztlcBJ2pRQaORPzFqz0ZTUBNBhO6NRWfsiHibtXsDOs6dxpagpu2FltuiSqvJqwGenxa7f48+tcjMN7scgL6jn5eMjksVXrw5LoFZAtKFsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(41300700001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+NwwH8ekpB6ioEa9aZX+XzzjFFt/HjaraFKbxWHORcRYUE7SArOewx172mY?=
 =?us-ascii?Q?1HiLGAmcgysI785O5Ft+z3fJvGYiG0MI9T+f5/V2Tfcd7YdIYRsdrpK30P1F?=
 =?us-ascii?Q?U0vQWX8YsI/Fvrb2P0hL9PFBSGRWbJrkl3HRDFi0zXKM1VoflXZOYv32qbIx?=
 =?us-ascii?Q?h8QT/ined9Z4eJkUlcAWmO2sMIc0SuNzoXgPcEylsGWVumDfyvXAYTtC9UQX?=
 =?us-ascii?Q?xjtm3cfsZHHU0I3pBps3T9/TKieQLEDpLPevq8YgrmqdEZVk0Wg3UdfJYgrk?=
 =?us-ascii?Q?AHHlPOmfLPiRilQQE3+XydRdQAMscnHDDuSBO1cWHMjV5kn3/yI+9u/+m195?=
 =?us-ascii?Q?zpHqcxOA2N4VvQVHQS2XaIuYHr1uz8ysW/qQp5LUeqz22Vn5BlSnEYxt/POG?=
 =?us-ascii?Q?Da6LE+UvbXQAddpyh9sb+O0COpg8l/KLi0tCM2DY2xo6rMQFm6zKpztdTZM3?=
 =?us-ascii?Q?+1irfvlzbBhqtih81i2dtHl1u5wx0EMErDE6HXl+KM1v+dCGGuLgbjdxgIr7?=
 =?us-ascii?Q?sPz7WP9Wful00LRVp1rFB57TAuFWy83rRXhIpjOOZ8kbnc9uW5Z5X4rYtGJ8?=
 =?us-ascii?Q?5PJ9tHgpvotKhOcg0T72Cf3+9k8Qwxw5QX3kqRTBrltRvQYUjoe782a32F0D?=
 =?us-ascii?Q?2FG74eXDqWM+8cEnw3TvDxwKZZ3VVkCy6+YGaYyX0kCBow59XTjBTFb6Ti2d?=
 =?us-ascii?Q?9HnB2Fe9vw/QWR9bSgMdzRy9hEk0PvuHzlhUU0lADgcxPieOhM1nhQYwgmQG?=
 =?us-ascii?Q?DyhpO84XKQqzwyJOIaMk1T1vfvM41Fn692vwc168gwuIaYGKrI883kkZC+BF?=
 =?us-ascii?Q?jqPOpHYhfMxaXctpejAHEMg/6tcjXMjtQBpu8QJYXHxfmb+Rgtd4v4ENoHNj?=
 =?us-ascii?Q?FPQRlFI8POhpUAcRdWqO6Lke+5i6S6yvL8lsdR//EE8tkty3d4jK5BeOe3vB?=
 =?us-ascii?Q?v+Wocm3jtp+Z4UIlsgBqNNmPu3vmkp6mPnG5MpkI+eyASo61CXT3/ueTB/A7?=
 =?us-ascii?Q?gORo3T3Rr/slJu2A0dsx8/9LYyvKZfukA7JuTY5o6Yusy6ZYrlZUxJcxkIyy?=
 =?us-ascii?Q?jEb8+uGDj8AYK49fMk3kwFNrvInMVVPTSDJVZ2Zl16B2ClkD+QWxK2zW6Uet?=
 =?us-ascii?Q?tVkxFIQkVo5y7tKzukb0Ir/C05G1nIkI1iYKmJXU6rvQKSKgNVTNykuHy+CS?=
 =?us-ascii?Q?wMUtQkF6jc4F7uSqeLnumU9Km/tTnzp2OSaVPbCaDlbXOYRhrfXXpOok0QG8?=
 =?us-ascii?Q?4asasrISmuz7UGC0x5socgP7pUERDBE9oA8UgIk0MMNI1CU9BURaVKsb3kRz?=
 =?us-ascii?Q?Ci3Ii0m7ZAqQLelVJI3Y2pFUs20po9AP72y4UhiEOMeWRpxiXGPiHuaTmZHa?=
 =?us-ascii?Q?t4Qs8T4+hH8xmGRUY+CVN6pgYeknJCmYYgKfUW7MRtxLQsyVp84Sr699d+0+?=
 =?us-ascii?Q?4tPhEDlemRO4wizocIR4LjOE4AtF6xFoXtuEkcTWGNzxqG1tNUNnqeHCVXJ9?=
 =?us-ascii?Q?EwtBZy8SydGOPowaURuj8uKsqw3j7D0iPLA7gTJK7af7FX5Ii4TYIeC302j7?=
 =?us-ascii?Q?773Vjb0kWvxmFyc+6UTBfECkDc/LeOpkh6Ccnseu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf9b63d-707e-4ad4-fa8f-08db27bf6546
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:45:19.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJffMyIrAL1HdutmE5dYT1W5VNCMEw0ryki/gMgt2ncHFcPZ7eBcHUP7OIoiZcSxl747FPpZfAgIfuk09CJv2A==
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
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 4 +---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 +---
 drivers/thermal/qcom/tsens.c                | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 5749149ae2e4..5ddc39b2be32 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -689,9 +689,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
-		if (devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd))
-			dev_warn(adc_tm->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd);
 	}
 
 	return 0;
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 0f88e98428ac..2a3b3e21260f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -459,9 +459,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev))
-		dev_warn(&pdev->dev,
-			 "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
 					IRQF_ONESHOT, node->name, chip);
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d3218127e617..f99b0539468b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1189,9 +1189,7 @@ static int tsens_register(struct tsens_priv *priv)
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
 
-		if (devm_thermal_add_hwmon_sysfs(priv->dev, tzd))
-			dev_warn(priv->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(priv->dev, tzd);
 	}
 
 	/* VER_0 require to set MIN and MAX THRESH
-- 
2.35.1

