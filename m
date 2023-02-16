Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA699699D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBPUTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBPUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:19:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884304FA89;
        Thu, 16 Feb 2023 12:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMJWvQJOKUqjaS67axh7kwb6LcCSH+lLjhaqQtSIUnAdS+isv6gJ/N0tUBqPoZq9LXA66kRVHiQxMpYLr3E8byw5/ID2kdKx5w1ww5yyr95vU8uv9M8L/LDK/JTrsc1lmK3lokbry6LLIyz3+ePhHH5Ffr5dAiSIpnhhPmXWspcgqVffDirL7BgfjdyXum7PFwckFoA/Hxsjv8BR8pt44qHgmCbzPunxLSSOE5S8eHoh3VWWLlItSiNGrY0QTljo3fYanW8HB+QeegX/7YpMUZ1ckD3tcfmOjZGFcYkor+zw86KBjiQHRzZBFE8RqVmT6xsvg9Yz1Mbi1ljOBKWEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkbZlfw6VknM2Zg3AWVJC06WBRsvZ/8QX92a2tX8HK8=;
 b=nszGxpKTOm9qrfHx3vGNNeEWmM7uR30L4/isqVVRk/S4U3c+YRDnPevyfD9RhkAw6/ljJfvfZsfwAcghGdHa5I4E31bdj86UzSvN06boOoKxIg9OAuASH8I89J4IzdnCyjkriWWVXSOqfJ+pN47ZWJji4zew5XhhIWQTPaTD8nWJ/aqecz1KEeU7vfVhbL2VgRfxO1ej2EWtusfSsR5PEvHs7TYBr+T3jYRoomCBWopyhqrrhrpMjvuh1yLrBV2UdjcDI1ueNzgtKVdfmh9aDRFmypP+rOJSfmzbkP9nbuV1QimmvHUPvJD9F+IKvnTjw+rG/HULqu6LjgH8W+LpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkbZlfw6VknM2Zg3AWVJC06WBRsvZ/8QX92a2tX8HK8=;
 b=BpWlfZ0Tv/Aly1kqYXsLeX8nHEYdrE+8ytPObG2Kh/btzadxsZN7st/Kvei8NhIbm9hKnREBYFOPoPrycqnjkrEvdEe7I8gHgIJkim31HPrltHQgRomESXn20YqyYxgcux25lhwa81J38Xll9Azt3HJ6fWn29RJWDvnBthtsVGk=
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 20:19:30 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::be) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 20:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 20:19:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 14:19:29 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] thunderbolt: Adjust how NVM reading works
Date:   Thu, 16 Feb 2023 14:19:08 -0600
Message-ID: <20230216201910.12370-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216201910.12370-1-mario.limonciello@amd.com>
References: <20230216201910.12370-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bf302f-6874-42e0-23a0-08db105b1bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVxNFqBppBU2itUsv10e1IEKwKCmJZfm+lBOh0C9HFcmOdnyLTV1B3/UY7SWaD05S0NqWdlRQPVD4Y4AqrOpaJ0pEHvLzSu0YOUaPq7QuZKt4SxqOP7CcE86jPEU4G9H9iB/MjtsptzNp1YA2+t7OP5slqzMrHTBEfoxzhuEEkrdEpylUDG6GTqqZDibWab+iVZ8ybhqTcOyUxOLS4KFQW/mumtGcKNkxx9FyiGYaxWy9N5KbnueGTohSu/H7mm/tWZgFMb72u0BfKKgCQkzLlP++2DMad27e7EaPvANpZLfzriUEO5o8IP4ZRV0LvhWGtAbhmU4gmf147MhxT4mQdbtfnaqPZkWJG+vwQ7hMHfU3/h3B+3l2Pek5sZjxEOe2lT2rOy1ncOfdVEDB5D4wgenEHfa5d8nAsYUXurOqIfbzsFQUVeUiD9igfksoc4h5wO5zNhWzfjx+IWMWxhjT2jp49QY+AV/O9NXCzbQhlyHFsSP+a4WIfEGAZaTt8euJwH9MLnMlbAwj1hD7xRVvpao2JsJ02PFlwTh1zxVFOEB459SzduX+CpCOwauD5gsHYDSMYX2Ps5QnKytsrRsAklr3GH/wuit3tkw2tuO9N/yjJAfjKnz/RBctTV34W2xQwBkqUZc4GcT9MFUXydYSHm7dNcKMh/v1x+LCe2l1tUXI3CBVOQSl4EwmBOyE4hZ+J3nYwC/WZcSpHUe4UvSIVC9mO2OSlxtCUShi3mOEg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(44832011)(26005)(2906002)(36756003)(186003)(83380400001)(426003)(336012)(81166007)(40480700001)(2616005)(82740400003)(356005)(16526019)(36860700001)(70206006)(4326008)(70586007)(8676002)(54906003)(316002)(478600001)(40460700003)(41300700001)(6666004)(5660300002)(8936002)(86362001)(82310400005)(1076003)(47076005)(110136005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 20:19:29.9878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bf302f-6874-42e0-23a0-08db105b1bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
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
v2->v3:
    * Split out refactor
v1->v2:
    * Update commit message to indicate which CMs are tested
    * Adjust flow to only fetch DROM from NVM on TBT3 and bit bang on TBT1/2
---
 drivers/thunderbolt/eeprom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index c90d22f56d4e..177bc51316f7 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -640,6 +640,10 @@ int tb_drom_read(struct tb_switch *sw)
 		return 0;
 	}
 
+	/* We can use LC to get UUID later */
+	if (sw->cap_lc && tb_drom_copy_nvm(sw, &size) == 0)
+		goto parse;
+
 	res = tb_drom_read_n(sw, 14, (u8 *) &size, 2);
 	if (res)
 		return res;
-- 
2.34.1

