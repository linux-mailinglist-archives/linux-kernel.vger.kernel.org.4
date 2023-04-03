Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE66D5356
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjDCVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjDCVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D43A8E;
        Mon,  3 Apr 2023 14:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5/nnsJwXlu7q9Xc3VC0SdvimiQze6KwFGIroANnJ02EJTDDxoSmu5EE6SgAvm3BxBwWxBX3V6WRF+vEqcEpLYI0No3rvVOfiFd/9oE+m9hHyNXoF1k+tNkVqzPFaKV5+qap0PTIddSwdao8vVsvwA3G3bZfZ3lc285oRuxJUlf8uvtXsL04bXblQ8bfSehzxTbwDCs9GBx8Ox/eZmsoPlBF9BeT4vst1SpayFvsyUU482eOTXPnX5vynrzpMCnGTGfN0R9IvwSC/EsdVllMnRuadmcFyKBbr3TRaMFtPTfMmk0Nra9z/sIiQt/EsGYsYFxG3LMGlaTO0UcFO7rSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnHrV1lWkLBUvshwq6Zj32NSdVLSIDtQyqWdZ8MAdcg=;
 b=UAEO6bjq//s5/70RRJNAkRDrPSYxvnBqQXUmIcs9J9+Uq/NnA9GNPVi8Ml6xshemSjx9uoaMBt1hgqz7Kdq6YIbVVJ6DQHIJiHRE/zfGJAyAz5uhNjvv0tJ0sUjrM1B4BYnwzUGp7MfRoBOqaJL9Xsw5+CV2qFySoEwKbHzRmQdkBaUIXnErCiWuufQMFzETBHW/nsH2+s2yIJaUw1y7SQNVKVrKiyDyYWldIYpdYH5SFFcn1DT6rR+0Zz/QwZ0odd5u8fJC7py7hI33Bt9Dmhz+mG8KY9wh8UrRh4W4uuHW1pHb9TCqGIlbSLCepzt8fZbbTRL76a6jvxCVKnq/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnHrV1lWkLBUvshwq6Zj32NSdVLSIDtQyqWdZ8MAdcg=;
 b=ZvAOp6iQ3LFKITxgHhKdd2dYODH4bChxKZd+TShwwJpQxKSqzaFIHvtADu7AMXK/1qNRzO/uyM5sseEZO27E+1/1G6o9udHY2UUn1B3EQhvgK9Ur4swvT9C7s2CEC1FiPw9vLyZhNx3CD5W+n/rN6dxOuYjg4yShkBiBPtymt9Y=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 21:18:49 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::5e) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 21:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 21:18:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 16:18:48 -0500
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
Subject: [PATCH v6 2/4] platform/x86/amd: pmc: Report duration of time in hw sleep state
Date:   Mon, 3 Apr 2023 16:18:28 -0500
Message-ID: <20230403211831.4010-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403211831.4010-1-mario.limonciello@amd.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fce2e5-3a42-47fc-7d2d-08db34890484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrse34GZWfoTFztftg6QWFylmTYAYgR0dwqXi5d2N5VJ4anTjTXG7KIWaRjAWf5MzeXQM/IZCzEAQBeFNoqwvrv/899sVjge8fvHs51I/fZgO7m6ec3sfWhL9WOr47uP+M8DFYvnMq5/hb9440SQ7OCQzZOp/o4c0LSN7uCb6vuICR6Btb5x8Ml4gMT3otN6L3aFnmaFgCP9qlhnywp5UOmq7CrFSFd7nlzydkPlD5dhdSOgqtXrTBlcLyHBtXjm1qKi8in02K7BNXPL73tWyJAJJthG8Fzt75eSBznkmvi6M3Tn/QqF695RSn/DUirsnjT1c+nSfH0xburRRRz6R2SDMIKUgyjMQ4BkWtKumZpKeCbcm9AM9nL0j+BE8dZzUvUftNCZgi61RjSHK/Ns9+4zGvySF6bZIMAjpfIzBT+2cxH/sgDhvNC3orQyWMLG06sm1d9aIItqlggGLNQq4qz8BgCzsv6KiChbhOtIRLV7QY2YLPg5EDq5nz9Xz3drXdbNDAsA0h4YVeTuJhpxTS69llcFl1U8U3MqB7QB/4Ci9b5TuXu4KGOe7Q14jQKQcsaOktS7DWm/IVkDRyU+yU2KatnGuq0CswRLPw3SGmPb7zU8pghgpTMT+/1hqdsKl5/njY3RwZOsWyOTXlqDIizxvquc6AnmKjgfXlfj1PgJDRWLZM65FTaYP1N8rBBHY6aT1JR5t0qxk6NKc6qfzR2KkYsURqLKobRmrvN9PbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(41300700001)(478600001)(36860700001)(70586007)(4326008)(70206006)(8676002)(81166007)(6636002)(316002)(110136005)(356005)(8936002)(426003)(54906003)(82740400003)(5660300002)(7416002)(186003)(16526019)(47076005)(83380400001)(336012)(7696005)(2616005)(44832011)(6666004)(1076003)(26005)(86362001)(36756003)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:18:49.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fce2e5-3a42-47fc-7d2d-08db34890484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
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
index 2edaae04a691..6aa474657845 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -393,9 +393,8 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
+	pm_report_hw_sleep_time(table.s0i3_last_entry_status ?
+				table.timein_s0i3_lastcapture : 0);
 }
 
 static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
-- 
2.34.1

