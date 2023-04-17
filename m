Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7026E4D28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjDQP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDQP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:28:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AEE91;
        Mon, 17 Apr 2023 08:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2ZWGmSZZggPKzPvAbpQR4ippu1od8hyY+oZwBWbJ2ZXBWpZ1Jy/2zl3dnymVi9Z6gCE06iIrcYXKrEMV7B+kvXioW6PpP4UmlqpKEJ2Ww/Pm9GVrfDoQSGNI1mgcMLlHhK2Pcy84jMryoac9Vd6Zxr5/F9su+itOgbss5plB4ILU2yI/OPD2EiYEj+8W29EEIXPKU/tnpm8ZRP7W4TOIScKuJpygW4cWq229v+cnS5BIp+YLon20tHvUVn42sA812jj9rrKyV5QyM3oDh7rP3jX85EryIHWmjEcpxq09gSt08bu5IFaHNBHERO1RYBZqvljGsZ4qZ5CzVzzwmkaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6fbg24Ws5/6z6CB9XfcKUwM5vz/CPdbV6Hj6+qrwp4=;
 b=HzIpS8LzlVuBd/UdAA20FX5aq1KNlniZxxf+X72Y6uPDWm3W1iAdJoQUHoIAw3GZ+BvWW0RU0Uq8/ZlnqKrriFEK3XLbzJD4VKNQBUfjlJmVPyncyjxgeZ+S9KQ2Tj+0ZSHG+urY9vtctic3BEVJ7j7EWwoqwRKhbHZTlN4SczGxIKH2ytu/L/n0eo32tUogAiS2QLnzmaYEFro0FuBCSy7Pf03/wHzB5crkSIexU304F3e94+4mxF77wQT+wc+U4GWWRoWx1fb9Vmdqdvon8GuQKfF2Y6WON2Nyi2tmDjqP8xtDRnzMGgt2hF5ywMJqQ8nbbPQ0izLpJJSpHukr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6fbg24Ws5/6z6CB9XfcKUwM5vz/CPdbV6Hj6+qrwp4=;
 b=zE2vkbj3+vCgk8vl5NcxGf1qqOAqpddIOOXSaRzR68oRa+zEJFf0kdl77JLiTY5DuyuX+Z+nag8guwyDTMgJLUrXq/kKrplqsMtA+ud3cq01PV1Keb2lMikfl3SIEdw8rBuaybIeUBF7Pu2/gY44y77jhpeuTG11iMc/XgCQBgQ=
Received: from SJ0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:a03:333::20)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:27:31 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::a8) by SJ0PR03CA0105.outlook.office365.com
 (2603:10b6:a03:333::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 15:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 15:27:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 10:27:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v10 2/4] platform/x86/amd: pmc: Report duration of time in hw sleep state
Date:   Mon, 17 Apr 2023 10:27:06 -0500
Message-ID: <20230417152708.3599-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417152708.3599-1-mario.limonciello@amd.com>
References: <20230417152708.3599-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aa1261-ee39-4eb1-b44a-08db3f5842d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIU5+L7donW3wls9TXY7EmOiIgSCpOpsKZd6Mr/RAdsLhIq4P6lkjDytawqm/pSaoLfeNrkMROxwgENBaZhDiPchZJXYqezhLMsXuSfOBtwc64KR8lD2niXIR0T0i9iKTdaNO/aRYTfHgZbwVDAbpsCcPX1LztVyb/RjaUIV01rY3gW4fvjouckIPDq1ds/dOVfuo7E1miacf7v21BWV+FIp8gesM5R8b0Ml6jQj9549XvJyfB2VGa8mebZmSsIroFI0TII95mSIn2OaC0ajgFcgYv77IhZYKkUjZtNyT+tXHXPqgjM0D0xc9TO2fAgDdllurQqM4Xw50x/F/DBR3YhJCoJJXpcelD63Kf7O63pWyuICCh4qSJ4wxcA3Jf42znNmjIhAUONoOCrgM0V6/8HXTKceLlFpHdimVqfGC4sy/fwcMbfjMrDydciXvTBH4+mrYW/WYWTTxFpgDzRBzanytJXV/27G6v5YHPCkV25vamdrTMlp4LQwpqeyJhZwfGEb82dILNzT23defkdHsDq63E5UtYtoSr9sUePvTzNxEjJTp6zaXqOiyIAVnK9YmvsHZWNP3yCNbccGjVgFNYnXwyWRMXnsvbxNPK4vff922zuB+6jqoncU8oE/naoAkOXQfARCw/xntKo/NUaO6GjZZNYl2BgYlfgB63VZ43UxgT0G7ETC117pOuENE3XlfgocAJ9+bs/NJpiQZ+huoLGa8QEuD5nB+fLpLiPztBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(336012)(426003)(83380400001)(36756003)(1076003)(26005)(47076005)(82310400005)(16526019)(186003)(40460700003)(2906002)(44832011)(7416002)(2616005)(36860700001)(7696005)(5660300002)(6666004)(8936002)(8676002)(478600001)(54906003)(81166007)(356005)(82740400003)(41300700001)(316002)(40480700001)(70586007)(70206006)(6916009)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:27:31.2534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aa1261-ee39-4eb1-b44a-08db3f5842d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 2edaae04a691..e610457136e6 100644
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
@@ -1015,6 +1014,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	}
 
 	amd_pmc_dbgfs_register(dev);
+	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
 
 err_pci_dev_put:
-- 
2.34.1

