Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7185F62D52B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiKQIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiKQIjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:39:42 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6942997;
        Thu, 17 Nov 2022 00:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTkVcXA/MQ6xz1J4+/Y/p5NT9j3fdtuUUxRZoYDrnbZmVKeK9b6cXv6LZ4Txr+Mr6VT524HuhPq28OwTN+0JAoEFD1bRjns1YuLmAUgCiaGeP2vDV4nqam8fp/dD/uaH1stFWTBzc4mohaUSbInF1iQZTz5DnwIPzgqv8uN4TJhLviSnOZXO9g6xahsmdo517ojjkZfoHilotAZWK4jkbBvGoUSnMz2Q79CUHQqbkqrPXy5EAY42zbEN0CZAfB/MCiE+F25T09QRaD+aRoN8ulAgBZY4Ka3qHTIgUUQQnDhPOhEISALUQqnap6aB8NF56SFjzazTk5UqIe3vhhOj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1Of+jQkBps7U9+07hn86C+onrICmalbopfSm/Lzfng=;
 b=Et+4QNJUwFfNu8kdD8jEJWbc0BRNBH1RK8VkyhDbIhDe1zq399DsmtAVIT67Pi5weQhiEZNq0CVe1eai6t6MTF+NxV6Li2siMTwpXOP/SoB5qVihXIEEQhdgoQrRXOHUg2Z756w6osdIkC7ofbnTEqKeCF54eCzn5zvMvlrfW7xHylfXGgbqt/IndGayX+rkUumdlVqoamWJBCmu3WpL4/AQkmnhCBICaM+G41qkNX6CdNCwAvh1uuZ5g041UWcenu5X35FmTjbfZI5V4VQeISpT6Q7E41w20wvpPICq7lZV2z64CAx9b0sTXyedibgx8cVPPoTPk6XAgLPrCp9MDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1Of+jQkBps7U9+07hn86C+onrICmalbopfSm/Lzfng=;
 b=Gl1uCt3p0svKNKH8GTuF/qAz56RojLWu2T6l/gKYrWCQFP5pdzhkX0N3oGlT/UNl+OgfocHgjaGVFD7QN1YmymHJC6JCFifYzey/kVNhcjPKpokYQGy/dAXkd+LMH/xgIa1FzqCzDeE4Z6etzsgtpaMRbuvm8zmKZHg0M8oQMlg93qhWu7xaqfgcKv0LuJGul02UpnE113wZp/UsD+mvUywVmH8oXDqx5p1yiU6M5JIwF1TnE6bQ4yfqRoEAOgtMEhg1eUYOdeuwOGJYThfwwj7syO7aynMBVFIYRXrFYCpVSvuuGkrHcP6suvbJSPkt1hm2ozTsLmGX2HH9yU5cxw==
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 08:39:40 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a5) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 08:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 08:39:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 00:39:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 00:39:24 -0800
Received: from nmalwade-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 17 Nov 2022 00:39:22 -0800
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     <nmalwade@nvidia.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <nicolinc@nvidia.com>, <rkasirajan@nvidia.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] hwmon: (ina3221): tighten attribute sysfs permissions
Date:   Thu, 17 Nov 2022 16:39:20 +0800
Message-ID: <20221117083920.20493-1-nmalwade@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: 96516c49-4f17-4e45-c789-08dac8774441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvfI2zxBTiMjy6ifgqGJG+93IgdCLPk8spcbabkwHMhmn+cEF/BIp27C35xjZsyxDcSZRA0TbuIYw+1hyrsUPBmGl7tAO2U/EuMonLc0N5lKA5OqR85FFkuG4ioVBO1RViD0ntEpObLTryEv6wLWcwyYlYeaKFOKYS0vyxTdPjJ85/l0UJIAs8u+R9bEsoKMPTolXnOJI/F2fEGXDJGWLKtFKmJE73Bb7qelL/PP3DP+gWbHvc81uS1NZQe/ak5aCWCOanewbJjVtEq3z/W74ZJRYV78ziAttmvNgLwKBT0kgCmkCACFLwvObcfX94UCTKeRTN8J7rA3bvPrVToE4otot2nAJTf5ZsSG4g9/XXWa75xSLREOeuyZjMQ9IH2cyFEeJR/uYXvhvQMnmKEi41matFqEniZFkM8zVadEwsYBTOd0qduTeJHD+JFZvPlTOhTXYaKz9C1wUkI26hX3zobXqF2qdZugyOM7OtGjs0/sWZ9DlmK6lZn0WpMXtATd5H6yYHqeIOq6JcLkVzfRHrIe7+nqrnx53p2G1OuVJ5aVOQaSsrVYJl824mNdVwwANWq4S86Pc5pLk+ap+Sa4hkblX5bwK/4wnVkYi/H4sFKirHnknmbT0/rZyuBiVCMRC+7NbgaqAwJ6kqlhVMMISvLw6whS027ApgQTqMmu0Cf36G+jYyycnXB17yI4Gf3bj0ybFFuP2c6OElT9H239WA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(40480700001)(86362001)(36756003)(40460700003)(356005)(7636003)(82740400003)(82310400005)(316002)(26005)(6636002)(54906003)(7696005)(110136005)(426003)(47076005)(8936002)(186003)(336012)(1076003)(5660300002)(83380400001)(2906002)(478600001)(4326008)(8676002)(41300700001)(2616005)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 08:39:39.6609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96516c49-4f17-4e45-c789-08dac8774441
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INA3221 device provides voltage and current measurements for
various power rails, including the CPU rail, on at least some Jetson
boards. This raises the possibility of the Platypus attack being relevant
to Jetson. To prevent this possibility, modify all attribute
channel permissions so that only root can access the values.

This is logically equivalent to 949dd0104c49 ("powercap: restrict energy
meter to root access") upstream.

Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
---
 drivers/hwmon/ina3221.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e06186986444..ceddcbaa26dc 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -605,7 +605,7 @@ static umode_t ina3221_is_visible(const void *drvdata,
 		switch (attr) {
 		case hwmon_chip_samples:
 		case hwmon_chip_update_interval:
-			return 0644;
+			return 0600;
 		default:
 			return 0;
 		}
@@ -619,13 +619,13 @@ static umode_t ina3221_is_visible(const void *drvdata,
 			if (channel - 1 <= INA3221_CHANNEL3)
 				input = &ina->inputs[channel - 1];
 			else if (channel == 7)
-				return 0444;
+				return 0400;
 			/* Hide label node if label is not provided */
-			return (input && input->label) ? 0444 : 0;
+			return (input && input->label) ? 0400 : 0;
 		case hwmon_in_input:
-			return 0444;
+			return 0400;
 		case hwmon_in_enable:
-			return 0644;
+			return 0600;
 		default:
 			return 0;
 		}
@@ -634,10 +634,10 @@ static umode_t ina3221_is_visible(const void *drvdata,
 		case hwmon_curr_input:
 		case hwmon_curr_crit_alarm:
 		case hwmon_curr_max_alarm:
-			return 0444;
+			return 0400;
 		case hwmon_curr_crit:
 		case hwmon_curr_max:
-			return 0644;
+			return 0600;
 		default:
 			return 0;
 		}
-- 
2.17.1

