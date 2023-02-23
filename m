Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B776A11AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBWVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBWVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:08:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82532CE4;
        Thu, 23 Feb 2023 13:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3347MTg07jGRBNPLFMOsV99ya/9Qb6ZP+uEpDD3dtDpOKSiOEDgXLE+owTnr8DvgBMtPAW7zcxFfB/4vNcg9IWXxmb7Wk2TsuQHxEsjJaMtZ0mHkYePKOxOb9FY6XdCu3YidC9sHAYdfMxeg63apKEpmxIhjm0fiDRPWU8MzzfdK0UnusEBR7gIonUYDPCa+h9QWFx0GA3FcaSJuaYHu9EsmF5APvPf5iSZO3ZzHS5//mQAPgN9pzcA5bpIDq2vxjCMHd+saHo03Vl5bRzVd87jyhRBdNJxjzpv6SQoXblmnhLon2gx9RXptlyZNeYaNnMkXrPpVDynczlbSohlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SULXXX7QoR+quXsYdckYdQY+x8ddjtaNUbETbzrCL3o=;
 b=KgGStTH+Rfk6tEoDvt3uGWIByAi+x29QtiebEFiNHwVEVlUPazi8eu+a3PDCAXTL2h5HRmzqZHbkrAVIwQpbXrPk4NLt7OUVbmsPKKvZITMRSOcmh9VrYYbwrVOA48Odqdr7QTmJfAKdPu8niU6pm/YN149pNZ2+hZJoyFNcOOYOyDE4ZNNiJGqhCUsDLJLKO/fwJqiY8L1UcJDsZhFx5eV0weT9A8BFbw/mGHmV6dUiCSNEHZoJydFj8kU7SIbskIYLczk1gT9xET+Fc/VyQWDe7aTy3tMfAkch8el/JpclDWhKy0JbzuKvIYT6YPaDXMGMVIHpjmrkHmZEuGV5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SULXXX7QoR+quXsYdckYdQY+x8ddjtaNUbETbzrCL3o=;
 b=mknbCbZ1TGWCRTVfbq1cIjPUyADuuQ9sDlJ7NTKhYLigg0xIDiIWCrvnjl/SdC2YonQTzmAa2XX+6yr/5xVkWY1S5faLvZC5HdcFhdK486pQRNwE5cVZaYemxGx01ZEiGXggkTTFME+0pfUSTqlAoI3vLYtk3D8ZD2sqvEI75hY=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 21:07:57 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::75) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 21:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 21:07:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 15:07:55 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Yehezkel Bernat" <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] thunderbolt: Adjust how NVM reading works
Date:   Thu, 23 Feb 2023 15:07:41 -0600
Message-ID: <20230223210743.9819-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223210743.9819-1-mario.limonciello@amd.com>
References: <20230223210743.9819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|BY5PR12MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c94f7b-14bd-43a4-0f54-08db15e209d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYbQZPoqf9i+10cxpISl1xdjqDjNOb+Ru001DKVstqvb9GNwn9q+HPWfxGn/FFFqYdmSo2pr/84d6IowdpFnweaA/S46JSLJvtpWKC0KwFWm9s08UQol289NWcnuNicvZu2DmluBU52sRF3CPrDHMpoK99Vayp6jM+iK+Eq67GD/qBfQqspnrSdyzNBcxZ0OrmvWExGH3RmklttgXsWwDaiPe+17OS+1/1u7S2fQ92qQtPTxMJHk1gMTuWkiQTRFHrNb6e2CEN/0dFL99MiURAlu+zwWxRyfe3f0g/nTsNqiU0qVO34deNCLWm/sd0oCv5Jtjz+I6KjBZXZ3XCTFXbLSv70zNq5AT1Mwa4cOuOd007xYiFwsOfPhrmicB6cHzhSpdQVZmp0FqVHz72SrP07waeFHEA4cmlwjVBTw52mHiW0S/iS0FRPYyrzu6Y+AZaU1enQha1Yy460vLVvXMW9othBB8r3lpSuujbU5mMPYeegORbqaJoAXh78dnhbc5Ljv51cviyo9GjyVaOgI4ve8gomJqJEz1zhfMOQoqsDR7W+gflrdrChHyrSkKIJxNSds4Q1VIk9wYIEF3WH9z2gHSJmqSDtMy7W8EJfVV03Eat6XLrt2if+nIw5tt+hRXJRMNu+X/vSV9sR1DAH0+UIl87MOQsLHw0EuplI/q4dlfwQNu0f5BlQ35pJ7hxZwn+CTL9qKhtdwHGjTiEmPJBo0Y05bILyNhsw1EGhGDuI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(316002)(336012)(40480700001)(186003)(26005)(16526019)(41300700001)(70586007)(7696005)(40460700003)(70206006)(82310400005)(83380400001)(8676002)(478600001)(54906003)(110136005)(1076003)(6666004)(2906002)(36756003)(4326008)(86362001)(8936002)(2616005)(47076005)(426003)(356005)(5660300002)(82740400003)(44832011)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 21:07:57.3441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c94f7b-14bd-43a4-0f54-08db15e209d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some TBT3 devices have a hard time reliably responding to bit banging
requests correctly when connected to AMD USB4 hosts running Linux.

These problems are not reported in any other CM supported on AMD platforms,
and comparing the Windows and Pre-OS implementations the Linux CM is the
only one that utilizes bit banging to access the DROM.
Other CM implementations access the DROM directly from the NVM instead of
bit banging.

Adjust the flow to use this method to fetch the NVM when the downstream
device has an LC that can be used to fetch the UUID later. The bit banging
method will only be used if this has failed or no LC is present.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
    * Don't run code for USB4 devices
v2->v3:
    * Split out refactor
v1->v2:
    * Update commit message to indicate which CMs are tested
    * Adjust flow to only fetch DROM from NVM on TBT3 and bit bang on TBT1/2
---
 drivers/thunderbolt/eeprom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index c90d22f56d4e..8c9e553e2fca 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -640,6 +640,11 @@ int tb_drom_read(struct tb_switch *sw)
 		return 0;
 	}
 
+	/* We can use LC to get UUID later */
+	if (sw->cap_lc && !tb_switch_is_usb4(sw) &&
+	    tb_drom_copy_nvm(sw, &size) == 0)
+		goto parse;
+
 	res = tb_drom_read_n(sw, 14, (u8 *) &size, 2);
 	if (res)
 		return res;
-- 
2.34.1

