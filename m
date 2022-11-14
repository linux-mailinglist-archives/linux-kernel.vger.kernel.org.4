Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCC6273C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiKNANg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiKNANc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:13:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E36B77
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:13:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I81Rox0SCpmxRGTB1oLsp73Zots0oq7jKQrTWwIGJKtrhLcGW1EvFqIQVOaG9Gid+QXyBTkX7DFWFht8YNc+8VMJOq7cpkXgGq90I9U2XL5CYQ56tC2KlDbSzhp/gBYsrRA20/kKWE6CJmO2gzpDf+wF2TLjDLjNdOHFKKRguEGE2z44IvzvjI6qoEC5U3p78I4+UuRMbQFLH37M9r5SvNkJ1EkS6mzdkfrgHtIX/msAQHk4Cmas0J14vRzmnSkT+XCf2gpr46G0GY82F27TMohlOtNEmYhrb9xzEIA0vNoXIi0xBLCIJ58Dz6D7FIYHXCfIFIn8M4mVCR5ywScNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMn4JPebg5MpLx4iXdinsjXldX5hoxtasNWamxng8GQ=;
 b=SeAGQTUpU2Yq6ZVbFeEddevmByHRo1g7TGb92qtIwelm3uC215d0rELd0zHHF+mlTuNcZ1HZbTCdg/cW9L7DH+/WyeV/OxDe8J/VXu8DmxoL6HFCuVNNaBH2HDV2oQl3nnl2jQyOEuDBoUeWgkp2tNps3sFmX8WQrYHmnQxdKuQcR2MX/cMU1e6SsgvpI4OsyWrhg/Rzh6usXJe7NeFmbH2LibcsurVTM/tVlTcxxGio7/Zj7GQVAlR4qyIDkIFXfSS81BTwlha1tzPFbQYtFd2kM4VI+zae83G/HNLCt08VtTK7i+cjitY6pnaKkwhXJJGtaMHBXa3mKNGtzE9Wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMn4JPebg5MpLx4iXdinsjXldX5hoxtasNWamxng8GQ=;
 b=1S0RLYHO0/qvDiwCfQu+fKJDn+XnM9b0Ca4nykREoqQdQ6AevvbIKJ5Ank2rvnMsyRRn6zffYYJzFs7eiRjn5+FoIuKbOZAkwu2S7Mfqp24mTCyM76A18QMwZuzE2Tuw9CoM6XFVgdr+E1ThDV3KiWnvpikQ6ejdUqr/wSl8Kj0=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 00:13:25 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::db) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 00:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 00:13:24 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 18:13:23 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Alex Hung <alexhung@gmail.com>
Subject: [PATCH 1/2] mailmap: Update Alex Hung's email address
Date:   Sun, 13 Nov 2022 17:13:01 -0700
Message-ID: <20221114001302.671897-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8febbec8-3605-41f3-2db9-08dac5d50c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q8dX9bD9bN0t5THJZJ/ensDlkRNzu69CJasZsskeIah/bM6lgDuD6M1OK1/XLRp/c/hLVHqwKE/0wOx3bi8aUWkykFyLvRk3qv5kK4h8aX+xxfcSmDB/qzHduRFhq1tGjFHhI7IAz0NDy/RNlQ58LhJNzjqwBZcfyl3/fGrcm0ensaTGTiiCqAjQypMk9GLfWhxqMXVr3IC/FOHwGHofOsDPEDZCpS/zbvc79XsUcR25oAXll3hrpziYkEQKpGp2rgrOMvOZxvtfpsOTfDyGVZt9ShGyRzTDChOiXZud5qEWQlt+bfZiLnpq2NN0mZM1t1xjJ5WvEWEXrjJ0saYtzaBXNQLg8TTXXGizMQnLjtN+X84sPWUUkCNjOSww5MeMqB324a7ikdiAIlEzwmsto6Hp1mo2aJ2YQRxbDhLlxJU8NMv/Y0ttDp1kAl8z19tUC9joU7b+ZpCCQVljAuovilXNtJEidjIZNxwNRLRELnVFtb2FkoQ/d7i/OcYORPPmsMR/zve1jWmOYsmBSTRdb3h4i6PEZBd0WHYQXpAFbKhw7wl6Dp8HiIx3sOd14ac1k87e6GdUyI2ZH2n23DPzw0zIs1yylGdwGcaa99a4kppOz5QyHPzFj2w06sRA8gcRs/21vtxkv9b5TezB4h1qBw5zmfZ3u6RbGTI12EIvdRur8Lp/v4qzP+UPPL9svRgF97cPRL/njCiqDkxb0XS2PxphVvcnK0mD7ELpso5X8WOYX5qvcuKnDACHnT76DvW01m21R9fpXuSLqU0pBsglSmsiuG5tSksIX//dJGbTIQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(26005)(6666004)(110136005)(86362001)(40480700001)(356005)(81166007)(82740400003)(36756003)(36860700001)(82310400005)(186003)(336012)(1076003)(426003)(16526019)(47076005)(2616005)(7696005)(8936002)(8676002)(41300700001)(44832011)(70586007)(70206006)(478600001)(4744005)(4326008)(5660300002)(316002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 00:13:24.6950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8febbec8-3605-41f3-2db9-08dac5d50c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Hung <alexhung@gmail.com>

I am no longer at Canonical and add entry of my personal email address.

Signed-off-by: Alex Hung <alexhung@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index fdd7989492fc..f9e4472b891a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -29,6 +29,7 @@ Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electr
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
+Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
 Alex Shi <alexs@kernel.org> <alex.shi@linux.alibaba.com>
-- 
2.38.1

