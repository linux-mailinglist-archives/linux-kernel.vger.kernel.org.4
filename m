Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2806A1133
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBWU1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBWU0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:26:52 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B85D459;
        Thu, 23 Feb 2023 12:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH+0xHUMZVWzsjFGSyAOijXgQXKaiEckhW2OHLEm9FcSn9M2/bdW9iNiM6iLeZJe6Z4viGZ7OyksLyT+Ci3vY6mbu2Uppjg6WDHnz2PlkGbyc0LiE9sqJuf4NF64aCr77chmeZOEEIYBr3VCnc+ZkamxOKpcMa2yV/7HM9vMLwreK/bD6Zr2z4pV5uCdU/pa+JcbB4+JyPxVpkJBd2f2w2QoURuvHkCYIst3/Q7+cyJAevCGXzWh3tjWaRges8+yziQ3xj9UWcWIlABlAYJ6INfHHIC/FRt2gxCY42XuH+ZTMY+F7PdC+VajU86OcDn86n0XhfnYkXGDZEuKTS4lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdsJ8Dgo1rO1r9yc/MJcGoCmfgA4SlLQIWeamwwOw7o=;
 b=OmVsSZuMoSXnINJ2wNyiP/aoBFFuJYVgE9T3ZWiyaI4TM7y/D0OYlfJ3cco7+GPw6WwVqbPAiDL5gvLIYO7td+3EGpbF4kM0s94nCzTpYGmzZKtSJ0mWkUuR0wDkS2jQXDFVHHo6J5V/ayqhNDWnL8/VpVmoqn5whyPgLmYlgW867VhYnh46xqx/+KEV/gwWnGIySAg36vySVSZuoMkt4YcV/e2THkTz/VVoIIJZOKETA0Pl25bzs1yXwdcAKvZw5whADSXJMrAu//cM+thg6CdXJJ9kiAGOsJAKCC6S/TY/TuKF3Tu4iMO8Nx/1SMy4uF3mSpnCQKmx6/hgWrhN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdsJ8Dgo1rO1r9yc/MJcGoCmfgA4SlLQIWeamwwOw7o=;
 b=JgRo4jv2Y4BYoJdlktXCy9b3JGyPnK1sr9bKl9PnvUawelieAxWN0dsfg29rhP4sI7VTIVwNaM6ofXTc7Tb0TGUfwU7CwMSMD+3m94ep0qf3sKOv1vvFFl/ARfCLUOhEe4O2wK4GZM1l/l+Ms3LHUhCvzA+QpayWDPY2rawBuek=
Received: from DM6PR10CA0015.namprd10.prod.outlook.com (2603:10b6:5:60::28) by
 SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 20:26:48 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::d7) by DM6PR10CA0015.outlook.office365.com
 (2603:10b6:5:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 20:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 20:26:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 14:26:47 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <anson.tsao@amd.com>, Kalle Valo <kvalo@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] Drop s2idle quirk
Date:   Thu, 23 Feb 2023 14:26:21 -0600
Message-ID: <20230223202622.9023-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e0ed11-e63a-40cc-d623-08db15dc4a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpcBS3herIN/HW+OQbqxSlQsrIhlp0cmYnYELL7nY7s7mOJKsicHG1CfYzApW9UE1/qHll5S1q7duhmCJM8TC5yDw/G5QY08cNye5kOQ1c30vSYee8Q1EQemisjGvPFYCPjao1Yd03sm5F3LmeyHRtTCo386siuZiBzOtRldIMaLbcS8Fi14qFgz4B4MLA1zK2jOaUaOX1bTuJJmVEz6K6xyYBNmn+0pqqhVq6jCrFIBRo4T90V0WXRiaMvbAXN9Iu0fVU2itbl4lwnV+W7Zl+2ArdsHYSJyDssvr83Nv/kGwmhSsrEwcZ/RjIZjcF4AwFW/UgbQabSBOsH0w/ChcSdlB/13HQjx8aJT0tQmN36wpvsnDW3cc4yVz3LoCmmrHnhkFg8hSBVOls7dyG1zc1IMiBYqqP2/J5fNLLNpoEl3zhbykF7jaOqtpKf27BQsRBPAcV+nHonzlwkuBVUURrb5eJVn8vsOO1UtvheDHPZVo9F3+R8U38wLTfP/xCNd51uhvwPpVcwBEjrxPykJi2onWtOgn2whm/V0Tik2YvyDHmFX1gOKJM74Aw/8VtBRuBaTcUYmFOwx6wwYGdHSh7jtNWRhGH2TdbXnT70eaVNaiRjsJwRlQxKf1++k9r2CcDCdxu3fPn6BZqYhonbOAAP5r5RMipYKQwtmfaA7aAglcDwAQ4kmPvR4f43yfjXED8MshExV5sIrZOHIQImjHljbriCKu5XFStgnFbkDdU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(6666004)(70586007)(70206006)(54906003)(1076003)(83380400001)(8676002)(316002)(8936002)(5660300002)(4326008)(6916009)(41300700001)(2616005)(16526019)(186003)(45080400002)(47076005)(426003)(26005)(966005)(336012)(7696005)(356005)(40480700001)(82310400005)(36756003)(4744005)(82740400003)(44832011)(36860700001)(2906002)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 20:26:48.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e0ed11-e63a-40cc-d623-08db15dc4a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an LPS0 quirk remaining for HP Elitebook that forced
it to not use Microsoft codepath, but instead the AMD codepath.

This was root caused to be a WLAN problem, and it's been fixed in
newer WLAN firmware linked in the commit message.

Furthermore, a separate patch is sent to ath11k list to try to notify
users if they have the broken firmware that this might be the reason
for a spurious wakeup event.

Link: https://lore.kernel.org/ath11k/20230220213807.28523-1-mario.limonciello@amd.com/T/#u
Mario Limonciello (1):
  ACPI: x86: Drop quirk for HP Elitebook

 drivers/acpi/x86/s2idle.c | 24 ------------------------
 1 file changed, 24 deletions(-)

-- 
2.34.1

