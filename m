Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C486DE656
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDKVSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDKVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:18:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53C3594;
        Tue, 11 Apr 2023 14:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDh3w3cM5JUMa6NC/qQvNZTVzAcfwQq41I7zK3kwz8BLzzBtAT+rzflm83fZlEXe3tuf6AeMgguh07iqySD+kmO1FR9wnCO1WhDEqSCnG072CZLdamZyOR4AW4eKdVQyfkQwqRd+USbbDy4CGf5L+OqnbEYeNzGpDkz4b62Y9MvvrsdNrutk/CEHXyPCngRFUsiZ2ORoKdADTR8wJWDJwZDxZ3OGf5JP3yXcUkod8zwaI4Ln/f1PDVdEst1PMXrkjdEpz+Cd2Vk9S4EOgIdp1Y/QG/jaUuTNEvc4rE7x9tgEvjGXRE9206wCDeiH33qZ+D5AiU/baGWKI4JurkYNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnHrV1lWkLBUvshwq6Zj32NSdVLSIDtQyqWdZ8MAdcg=;
 b=WHSUVoNDZixp31W2lBlRUscElIGjXjPig92WEeo1973X7tPQNEq5Wd6yFQJ1O7GFbolpUcx6FXabDr0r/rAW5HeQV/8mpodFwdRLL7pZjlUC8zA9UDvZvuH0WoaBlLqxFJAHmXmlHQ/racyduiblzwzqVKrS4Q78HmQHFRnRtsBf8+B9c/6qkfbTZr4xm+JarkvB+PGOTihFV9msqHmYwVi4c75zeEDtQr1Wqzu/lnzIHOqVSWkSI38N3/O5mbE89UFc4AWxbGFb4E6X3Kbznrb7jPDtT76b6GbQzfp3Ccaxe0jEGmOyw9gaF5NGIxHMRWAwayaMZMHhftGgXK7Qlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnHrV1lWkLBUvshwq6Zj32NSdVLSIDtQyqWdZ8MAdcg=;
 b=o32JrNZR+TTDHoStiPXIU4ObIACM8at7yYv5Qw0d5Wx0RoeJJx2PN2q8ldln86vx7JgkH8ssPozXED3gyxMXXEoS6OpTIQIIfKhglWUrhUUWiQMxcwhLWL4XXOpNaP1JxMygEj9TbBjiSAScbomgKVNgcTygC+Et4uytYhWurNY=
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 21:17:51 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::13) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Tue, 11 Apr 2023 21:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 21:17:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 16:17:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Mark Gross" <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/4] platform/x86/amd: pmc: Report duration of time in hw sleep state
Date:   Tue, 11 Apr 2023 16:17:16 -0500
Message-ID: <20230411211719.4549-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411211719.4549-1-mario.limonciello@amd.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: dc506fec-e4ca-42e5-2abc-08db3ad23529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zod+efPOZTYvHINKreDAgzA3ySn7a7wkpbBfr6TjFVjMTBOC7Rn4Cxl2jinTawhYh70IHVRGsWHB5WfGvz0wTf4yT43z+jo1SflME+PKaqA2rrePmjRPu+qicmntoATOqGGqM3t0uG0NfLcIecjRrEB5NR6ghHYwjrhYAbHVgp0MUopzSY9ERoTWWmPf+IJ2w14fhFncXEJwHkb4j36Ff6C9ZNSpJLbq24aSpjH65Mmfo4IJwHxkyFbCpCP5AA/s2WTowa233RYDBlV5l8KKiCc0Nyo2d5phaz3NWleJCkUO6ac/eDcs3tU9ur8Hu6J/OvZn+4RipXpl++uuDnMv9bfwhyMDpYWe2JWnmHDF65TZMdNrhwCT01O0vtMGD2bci+LZ5JC5C0KxqdqTwzHGVP+pBAQ+T/jdgRLrAHQ9WWSNnKXZdibz1j5NDLYP7jKzdLet3LQO7nUpnYAazKjYApV7DvOlerfTlo47MXC8mxCC5sKryIKL8s6Pup5pnFKRsWIk4wCGTgh1yuWpWwDABtOzb5vHNW6jQbz3DSHAfmdXeM6XhiyHf7GiZtrF5dq6bL6YC2RAgt+yFR3AlabfvKUG6EhopXhAVWHsnhtkCTqMOu29JkYbUZm7PzvbpzQPfMl2yxx6MNxC+clOZ6cjOYmX/dUi9VyjSchEIDpO7x+SkmYvPbSEpLtlb7LFy3dqMdt39BLvgAW/T9OktZO9/CGJ1dOKp+4bNVWy14npSNs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(7696005)(40460700003)(316002)(1076003)(110136005)(26005)(54906003)(16526019)(186003)(6636002)(5660300002)(2906002)(44832011)(70206006)(70586007)(4326008)(7416002)(41300700001)(6666004)(8676002)(8936002)(82310400005)(356005)(81166007)(82740400003)(40480700001)(47076005)(83380400001)(36756003)(336012)(2616005)(36860700001)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:17:51.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc506fec-e4ca-42e5-2abc-08db3ad23529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

