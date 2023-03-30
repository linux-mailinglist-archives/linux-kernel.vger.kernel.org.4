Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA16D0F32
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjC3Tp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjC3TpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:45:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979AEFB2;
        Thu, 30 Mar 2023 12:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK61vjNCFai8pnmTnnvYqj+RfT8fqntPVZdZfz3uA/X3DPCL/tayFlplkhfL4/l9tEiX9seALKa9F8J4XHEpoEaaJStmCp1tg4rBFp/W+1aSlpC+v6YNt+NyAtcSB0TAf7t8GpF4oh4tBijxWRDEFMrg1T6ThAXGmMsYEEoz3UVQ3SfoqVki/KqStHhU2RTugQkv3dFjt5C4KMbbBmJkOC2kvxSpAFCDBKTO2aJpbT8rKMDioikHtNIIBd3TQM39vZdUqSxMwDBawHqAY5tkm7QS419xXdj33HT+3ru0UQ0xbUXtBozEQzNPbIG/mlN265gCy8utHuZq2uHhRmmUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwpMImJ/K6BBLf8hdr2UcHl1SkG0jX7d5r2fnFX8UA4=;
 b=Suw/X5mVMAfrZQSQRSbEBMqr8ZtDo5jOFg/OQbsx8Dt3F2gYvxVfaH3ghawQ3ZuIt7yKlj9teuUklfAvNOpHiwrucZKFen0/LbLtIrpoERbZL6iiYwFcQxIeCXH3yjLc5CvH13ckOkGpbtVE3DJj6idcz4yEwLKmufg40jQAGoxCJDuCBJFRu4a3hSj7iTHLdxmUikTa/tb5wjhpy/ShfHMSf/FyOwCRIn5/RLC/a3aeM9AavfUHej6vyeyhCm6BFwNLobyfQGwZ63paWq7UC9HtLhsDuOptFZnFDROpb1nmGTztbmrLEyztXWevZmmUct6vMmrF7l2QMWKpR72ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwpMImJ/K6BBLf8hdr2UcHl1SkG0jX7d5r2fnFX8UA4=;
 b=xMujjSc1EFxczCCP5xYYw/MTk6sHkA/r+VeO4VlAvP8K5XD3Owh4liwIN51/Y7TNo0/9mVK7PfhD4OI6lt14XyVZfMFwivaSNiu+TzvMP4gweI7ozrfcrSUrSZEKQGtHAxW7AuDcAqxsec1cyZh+nx8SUngX08eOQq9vSjKmses=
Received: from DM6PR11CA0059.namprd11.prod.outlook.com (2603:10b6:5:14c::36)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:44:58 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::d7) by DM6PR11CA0059.outlook.office365.com
 (2603:10b6:5:14c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:44:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:44:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v5 2/4] platform/x86/amd: pmc: Report duration of time in hw sleep state
Date:   Thu, 30 Mar 2023 14:44:36 -0500
Message-ID: <20230330194439.14361-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330194439.14361-1-mario.limonciello@amd.com>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: b2557c41-c48d-4873-ddba-08db31573e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n2vOEMobDF2DTU3ik+2zCtPPNTDutbxi54u+GUbtqLZSB1JY1eFw7qghkMkZwd2tDbkbTPfAFVPtE8FYJqTV2AxKHCFt8/SNj6TEZqsbdkPzZPhNAIQFU62K3MtY06iRkto1WsMgwATjav4mYFaZGSc+NTQwvD//ZbfdyIRl4ucosaU+az9KkECyNRwRf/UpiwyamBh7F4Pty2jb+k2RIPZfc9Y6ZacoJFyVaxM9ZgG+oT3HotWNhKYV0ywEj3njv2sJuBXgkkGUX+xSoBLXun+eWpZIjS9IMdnjOXKpYwkJsNyPR+IdkEuZHaNl2qXaNcJUBdY7GSRVdIzIA9eU1CcKENTtzL/2g9RVZziDw6AdtW/UkFomlEmG2PLmZCxvmoVW7Fp9kuY9YnrEitxIoB2cOeKZw9U0cI9///i1ts+3ql/4uNt1C6X+t8+wNqzISndpKyUlE0RzhM8ag7PI97KRMzvHspn866JOURRMTKW85m3mYv4YEP6peg1YZm8hOrvyIkBLOyfeHhEqdIltgdaw8PTwOpY59tGO8iEidNdOB6Gbdb0qxrA9VWcOB1uESDQAViENq0DVIVoh6w+Y5AQCPSG4tlIS+EOyzpQX5cB2tg5Ib0uUvbZ7/okl+0+pTxEcGtYJjQj00LwQB+eEjRXYaWb9tZBIh2OOTQw3koBe72SFArisCF1qUDz1JLNRCd9tJxiolJnJ8q2HVfxciMyAdqycH9JuhcKpUed5tU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(8936002)(40460700003)(356005)(36756003)(81166007)(44832011)(7416002)(5660300002)(4326008)(86362001)(70206006)(70586007)(41300700001)(82740400003)(82310400005)(40480700001)(8676002)(83380400001)(36860700001)(336012)(2616005)(54906003)(1076003)(426003)(6636002)(6666004)(2906002)(26005)(186003)(478600001)(7696005)(16526019)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:44:58.1584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2557c41-c48d-4873-ddba-08db31573e79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmc displays a warning when a suspend didn't get to the deepest
state and a dynamic debugging message with the duration if it did.

Rather than logging to dynamic debugging the duration spent in the
deepest state, report this to the standard kernel reporting
infrastructure so that userspace software can query after the
suspend cycle is done.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 2edaae04a691..2c1ea9c14819 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -393,9 +393,8 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
+	pm_set_hw_sleep_time(table.s0i3_last_entry_status ?
+			     table.timein_s0i3_lastcapture : 0);
 }
 
 static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
-- 
2.34.1

