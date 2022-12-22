Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D36545FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiLVSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:30:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9E20D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3B+xO7DkzFna+c8+vqRoJ8EnpQIgWUOfHBE2P0EcnZ71L0lCLba+Sez/zU882r4wpDW38BeJ/lkEuWlnvZ/aRCbAL8Al+DTYzPWzr0mGeAsOy5u7BUAnEQsTsfpM/GO/FuvnVNZ2HaBFKNh1RbrauwCBCnNNArg5fi8llako/p3RSEo4bZqRcLVwqz58kjOEM9jwxPGkPL8CWQr5zeQ8slO6K1IKFpd84eBz49ljHkTq/gSVEuEtLkhuZ2FlmDumZ8xcKV7R5b3mmA1izAoh8pZ6gYSwpG91UTfWXpkyLDmkIBQDekAlgXzw7Q7pv3RpprnhId9kq311V0cuw/Lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH1qMhRE9Ggw3CGUNYB4BLxIKgkwh2qMbD5kFyCG6YE=;
 b=GyLmvJE0PtJv1WGd08yC3W722JhCYSmMUo8eG1IyNx2w9Fm3FCnc9qrqR0I4RmVboDcchxVXi7jw7BMji7zd4hly3+a3NWEOUEhqX+BhjVlxqp97cVc3HWIuHJhiG/IiZDcBpE049RjIBBDFU7bi7WTmPoDq2W2tUEl32b0tNr6/iFyW+FZ0bLUgR6l4X3yOg7LDqYQNJtyZ8KXNiZcB8DBhR6oM6dO8al39YNX5WgSI1oJvNCjIA8JluXqc6V6l0hyJ6Gj96rsRT812MeWQpO4766HbIme0cD/nEgqlomXyuo4AFnFxbYr/gWHrRwV5pQrODzqb6wbXvDenoI5kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH1qMhRE9Ggw3CGUNYB4BLxIKgkwh2qMbD5kFyCG6YE=;
 b=y8uzRtQiCp1m6bMPrEJB+DZKtyNeqzsqDkONp8vKwd+FhV1ru0TotO8ck4Kq44fQ7OEvgfV6DVFmGjMm4HTMD1uK3iPzALV9W1vHKAoSPhSJW1nhEBl8nn0we3CCxuTfGTkW7gUJZjWv68qzISSGBJetAT7BuKzkZ6jKJQ2n5V4=
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 18:30:40 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::ff) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Thu, 22 Dec 2022 18:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Thu, 22 Dec 2022 18:30:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 12:30:37 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Carlos Soriano Sanchez <csoriano@redhat.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        "David Airlie" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH 2/2] drm/amd: Re-create firmware framebuffer on failure to probe
Date:   Thu, 22 Dec 2022 12:30:11 -0600
Message-ID: <20221222183012.1046-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222183012.1046-1-mario.limonciello@amd.com>
References: <20221222183012.1046-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a68fb0-c963-42f2-4c2d-08dae44aa012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E59BtYrQGV8TTFTzJlKDAa1WE/fhHNkvclmh+FshUfYsBJKlfVQE7c2MvDZAREf06WRz0mCMqDIv8jfD9DP7qlGewy0zEvdZ/cfY/xD4TMAF7QbV80Fss8VW2Kl9kWfoDs7DC8z9BnMOq986cZUdTPbAnUXy1HfxNSO6UidT7m2n/ySfDgNMmcuMj7e8wTSYmm4SRbN4yaO/7jGneC/CMM+tPMoLmixxF4lYkDORgkb6+iUY6OEpPNvYPeTecGtQLlRtxjHAALaQ7w/ESV15KEjIc0mo+hZdjMzZfojySmOh36Q8Rr8Ao/7IVMif2AkTbwI2U70Lpc5yZMflTHTnIO/sjBYJw5YmnQU2KzXDv/zMo0aK4qhzMrku0fgV/WTs9VNtgxVSzoiasSVDjRBdBGElDv2sQhuvzbE9nv6ayAfp3RKf+fC+Ie9kF6qNux/T+XGqjA6csSxW6vq848BdHvaS3z89JNPQ23VCOTWTctUQk/dQPRB/5CE+la0DBhXNcl4MeLCCkS0lkwvZ4lSonhrKAyHLM1zke8CBAABquE35Q7Nu/4EOvL89ZKjppDzdVrEBXVfFvB4zf7O2n+vDjWRkO09vght62+UdyZPLbNJ4k9koGMGvEhb+sijEu4+iMpYbXBIwmGtnMKOqZBbRaogwd3lA0iPdsY1OB5HY7AFQIMTXfybzJG5mYENFriIn4rdMILu5nYmbRhR1gBzuw2TRNxW1BtIUDwt7D2KOtp4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(26005)(41300700001)(54906003)(8936002)(36756003)(6666004)(110136005)(7696005)(336012)(70206006)(70586007)(16526019)(186003)(8676002)(82740400003)(5660300002)(4326008)(40460700003)(2906002)(81166007)(36860700001)(1076003)(44832011)(82310400005)(356005)(47076005)(2616005)(426003)(86362001)(40480700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 18:30:38.8894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a68fb0-c963-42f2-4c2d-08dae44aa012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe sequence fails then the user is stuck with a frozen
screen and can only really recover via SSH or by rebooting and
applying nomodeset to the kernel command line.

This is particularly problematic as newer GPUs are introduced because
distributions may take some time to land newer GPU firmware.

So when probe fails, re-create the system framebuffer so that the
user at least has basic graphics support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bf2d50c8c92a..8961c62ab29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -40,6 +40,7 @@
 #include <linux/cc_platform.h>
 #include <linux/fb.h>
 #include <linux/dynamic_debug.h>
+#include <linux/sysfb.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -2187,6 +2188,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 err_pci:
 	pci_disable_device(pdev);
+	sysfb_enable();
 	return ret;
 }
 
-- 
2.34.1

