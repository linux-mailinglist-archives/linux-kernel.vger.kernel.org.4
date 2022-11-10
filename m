Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB1623C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiKJGtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiKJGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:49:32 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926402EF55;
        Wed,  9 Nov 2022 22:49:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRCl/Vq51U1oHhkrba/tNHxiyiBq9rMhz3P5zUo7j90OIf/Sb2TrsAvRS6P3cT1LrnpI89ULoxxo4Kti8ImKduep5sLLotWwKScE+mjMpgG4OptEunmJcQMXP39cFT+W2iFsQspawBlqMGNyFpNmTAwI1AyuC/vJmAyIjqY69jzEdlOSGHdXj0YonpmwAxMe0hj/B+oIi6o/XaAz5Uc0O2t/mwDTnSbJgrGkQoj0cAxmCFt9QBryotHmm0zVIQKQmLuY3CzE/6TyHtwvv3m2jsiAoafZeJIXFRJlvTP9VwGNevNz5pWzGxEHypNczkvt5uHHnBz0kvrFVw1DbWkJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee+mbOGvEiSCH3gE1+nUkaYutzOUMeYFRaKsl7RE2cQ=;
 b=A6TbpKQVTW8JbKxQt5E1vmbLOB3MoBx/8PKPCRuFtUBvO1ttdax//vVxcMEfAVgoeNjwVNyYUvJx4MfvgITM46wXALtYMoPClpN8R0xw+h9YITroItTJ5LEgSvp1e5biUQ5v+Trv7QG7OvRI8XG6NdWdtDPpCdfdUwbvwyRhmQvWPuqDnRucoCeI+H4jv1eIxEB6MKK4az/NZjPqt4fg7qfXNNuFldq36zzWfn6/iOTFKkr12T9Srb48MIIPK6F4OLcPZLOfLmWzkQWjSpmPTskvcKRxblnKhr3pg2DpH+icJxJEFBuebC0b8/xPyJztzEKZCnOTppe/0AWCvI4R4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee+mbOGvEiSCH3gE1+nUkaYutzOUMeYFRaKsl7RE2cQ=;
 b=pK30lSVsIHY+Nb4HRqsSRVSKINPSB705pcSlW+4xYCOBUI1umoj7TB8TxdHvUuuOWBXRT0pl9qRLdwQCpXZcMPgCq79ZUrMUTH7Ld1O/wn2y7i/RViCbwEcEs1AYVzA8cDvNp5hxek5UE7qZlo9ikBMiH0TSBp7SKMNF5zTYo58=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 06:49:28 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::c4) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Thu, 10 Nov 2022 06:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 06:49:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 00:49:05 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        <rrangel@chromium.org>, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [RFC v2 2/3] platform/x86/amd: pmc: Report duration of time in deepest hw state
Date:   Thu, 10 Nov 2022 00:47:22 -0600
Message-ID: <20221110064723.8882-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110064723.8882-1-mario.limonciello@amd.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|CH2PR12MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb0439e-bcec-471b-cb86-08dac2e7b672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnmYbh/+wElOH2WYg9alt2pabkMlw7syi3YhYw2o50ZEg8LH52TS2GAwQhlDOKKgdQEGDhKQq8Accm4oeolKsJNZ7u84osJCUvKDr0s0/29RYytKEOfrVPIPbCtjqcNNuJguNQucopki/TiGKVmdIqSToU4/nErK8fLZz/MTUmbbZbowaaq8afoeV4pGNV5xWdFk0XJEY9F7iynMONFQY5cNdw+gqD5Zvo96ifdTkeOfL/pVD8LzYwQCjFlAfFWNlQS3Q9tCtbXKzUbHvS/70R+oJ+F6Eym/dC6b7pGjyZA9lv4vwdf4NtiD7ekMW8H0WR8HMRF7/WnF3cLNCIyfwavcGvMeDwWvhpDEMu+J+3WU+z9oGq981SSjHAeAaSMQS99cE3mcfUjX0//qSRUwJgThmvLpJ5F+sGq0N+iv0ee65BmFCqTNvhT8F0k1wk98miSttNj9D+S8PgU5lj7ro7W7oM+WECAYAnHmKdMHW/9qz91HdNovtgUZB5KMN7Pvit+uh5kIbpL7V54L7mspQBG/7k2XqxJM+x6NelclekDt3Y1g76C7xj+kvOsUR7+saJHbFOff+Iy8sNDfqz74IVQr/gUnsLywGGLAUzzFcHIEucjwXhrtAMLMa4i12J2fFwJNINc2hLKI0LruzqxFtL28SB1ynjh6zte41Ca1/SSoEKzaaSKYOKQ69yyTblE+pHThI5gRd3zCQ4LOXhTcXcMa1E7vA+hJihIlgrO8yLHU/eyiP0jniquNOlkJMP+3EhAOg5NPdvrGdWTbnKA05DoOef1vOxzu2h8zkCOyBCieoWoP6h4/WiMOhmx2f4j5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(1076003)(8936002)(47076005)(426003)(16526019)(5660300002)(186003)(478600001)(2906002)(83380400001)(336012)(7416002)(44832011)(2616005)(36756003)(7696005)(6666004)(40480700001)(41300700001)(36860700001)(26005)(82740400003)(81166007)(70206006)(356005)(8676002)(70586007)(4326008)(82310400005)(54906003)(316002)(86362001)(110136005)(40460700003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:49:27.8992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0439e-bcec-471b-cb86-08dac2e7b672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmc displays a warning when a suspend didn't get to the deepest
state and a dynamic debugging message with the duration if it did.

Rather than logging to dynamic debugging the duration spent in the
deepest state, report this to the standard kernel reporting infrastructure
that can be accessed from sysfs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 96e790e639a2..e583bf966f47 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -363,9 +363,7 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
+	pm_set_hw_state_residency(table.s0i3_last_entry_status ? table.timein_s0i3_lastcapture : 0);
 }
 #endif
 
-- 
2.34.1

