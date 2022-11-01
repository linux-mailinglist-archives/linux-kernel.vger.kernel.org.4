Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAF615214
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiKATQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKATQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:16:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C391D0EA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBAWaCBZh9u/bTAPwG2WHCpc0rZgk4361pMNjZ/iymwulF8cSANUsdZYwBT9k6+c6G3gCt1jG3TjCrkIobJYpi08EWskQphCEYDmsgefmCogTDEkhIJB4ABdYX0CI8zrSxVnrdLI/ztHoE41QjESIXJV6/pTqtAsFYSSyWR6wuVs//l6AxDLhLCY9W7nSe9vfAMUiSCuJ2Se/c1fQZSW/n7IISrSJ11bI7hvUO71xfCNgk+6BlaXmxDfuBjT8p58rS1BgCkBbNTHVv1rlLH1kRgHGUyaW/KDWXLPwxLJ66efa+Fl7OHBAoImV5K+myucx5NhepykEDq/4wCWxBNjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcjefSyM90rIz22oIZh+rQKY3iOC/xf2Mk+IzMIcPfc=;
 b=HG6NT0VxA9lPh6b3Z8yy83A1u23JR6PPYxJwvYHt1cDv9u08upCpuZ1EyTjhg32Ub/tksHWf/W8VpIhH1IgpKt2PMRGyiJ6Odq1Sx0VXa1eL3/D1Z1SCCBHsJAal9T5WQ7E1PUrPAPCkFFExl6/OyMLq2A6R7q3Yic3MltoamU8tBveXcF2EsdLBku4hiLv2tdxmPAxCJqoQaAFHSMo3E5shIAua8Lvg23IgepVoBL93rmROBEftCqROewobNg6EF628za53mfUqYBDimicRWzb13QCiIHuuKiHrtDWhlq1YCIDR3axEScFJwOC1ktjiEdSVl7hRmmU75cw5D8rexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcjefSyM90rIz22oIZh+rQKY3iOC/xf2Mk+IzMIcPfc=;
 b=hB1HFaiglg/55MzTuXMlHm8FvrFGqIOuwdSvNkksKUx5Z8CxSmYeZk8oWphlaw9gYdZcrAXrh0Pl/QQ4rWc0xsjvnVynIlZYocch432cwnQtQORS5BP/Tehiuw6yMqFXfP2AaEb7hWM6/Yh9XAS08zBWtByJm89fyWlHKkxd1N4=
Received: from MW4PR03CA0149.namprd03.prod.outlook.com (2603:10b6:303:8c::34)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 19:16:26 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::31) by MW4PR03CA0149.outlook.office365.com
 (2603:10b6:303:8c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 1 Nov 2022 19:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 19:16:26 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 14:16:25 -0500
From:   Felix Kuehling <Felix.Kuehling@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        "Rajneesh Bhardwaj" <Rajneesh.Bhardwaj@amd.com>
Subject: [PATCH] drm/amdkfd: Fix error handling in criu_checkpoint
Date:   Tue, 1 Nov 2022 15:15:59 -0400
Message-ID: <20221101191559.302884-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8774d4-4009-430c-5a47-08dabc3d92c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4/mVc9nihWA+7J9ifpR81h3etGzc3Oa/IJOBKAiLHZSxnTeygYEZEsTrrQVR/cgd/SlayecYJwAxUfnEW4r6+J6Qb+TWXWRUL0ssVPi+6rtbzSoYgIeHQyXthCCtC2niNef0NiNd+9SFPoBLdg7dPUVgk9LEjWiFr9b+vjgqxp8z/V47sPEUASz9GNn+DEhY+Y7xfGK9OxMPFrc5rxlM6LTi+FqEIMTf1+Y/WM43h8uliSGSWNfLACfbcGchZwcitscacYsuWS1rA64JARNaLOsXdOD+td6c+7VQyseiGnAEME8Gqg4ivvyPvei2cDzedBUuJXgv+XIBN/M5AdDUUHwDBw5G+pV+1mY8Tb7HKBPpIrdQ80zi4QEr+qQXDB8DI93kUjRJNSmn+c+qJM52lAFBJhXrOA64pm+p/tRCWlayfX8x5uzXHe8f86LcYLcNWJONenlbOsv1dlKMlq3dlTV0f38sERP/DmuZJPcQbD1i5WcnQywzRYY15ak637AHDJb9qmdc1t7oBESPmPO0+3gwg2+iTcx8nQlkTm+pXGkaw3T7U6ruKy7Er5XQvXfk7/bkFUXSQV4vCn3zqQb3QWe+y1/oyF0hqK8ocY5NnkaHJCByJceUmV1EogVBz641FhpS7JKjGzzoB+yPwzhE8jvIsL01sp6TOPMx0KN7IcaBu1lBlcWROzyul6fA5KysPFeE+IZCYeCTEP0hkSlEKoUg2TtPkYc7o8QnrYNQAwXhwFc3p9LgujxgdjIVPfpIwqdqJx5kJ0zRPMdVM4wDjiyMhBPIUqgUpD4H7fO/ZCnRB3ibICADtJJEY6X81Ia
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(478600001)(426003)(2616005)(47076005)(6666004)(40460700003)(41300700001)(7696005)(4326008)(70586007)(70206006)(6916009)(8676002)(316002)(356005)(336012)(82740400003)(81166007)(5660300002)(40480700001)(83380400001)(54906003)(1076003)(8936002)(186003)(82310400005)(16526019)(26005)(86362001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:16:26.6193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8774d4-4009-430c-5a47-08dabc3d92c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpoint BOs last. That way we don't need to close dmabuf FDs if
something else fails later. This avoids problematic access to user mode
memory in the error handling code path.

criu_checkpoint_bos has its own error handling and cleanup that does not
depend on access to user memory.

Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
Reported-by: Jann Horn <jannh@google.com>
CC: Rajneesh Bhardwaj <Rajneesh.Bhardwaj@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 27 +++++++-----------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5feaba6a77de..aabab9010812 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1994,38 +1994,27 @@ static int criu_checkpoint(struct file *filep,
 	if (ret)
 		goto exit_unlock;
 
-	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
-			    (uint8_t __user *)args->priv_data, &priv_offset);
-	if (ret)
-		goto exit_unlock;
-
 	if (num_objects) {
 		ret = kfd_criu_checkpoint_queues(p, (uint8_t __user *)args->priv_data,
 						 &priv_offset);
 		if (ret)
-			goto close_bo_fds;
+			goto exit_unlock;
 
 		ret = kfd_criu_checkpoint_events(p, (uint8_t __user *)args->priv_data,
 						 &priv_offset);
 		if (ret)
-			goto close_bo_fds;
+			goto exit_unlock;
 
 		ret = kfd_criu_checkpoint_svm(p, (uint8_t __user *)args->priv_data, &priv_offset);
 		if (ret)
-			goto close_bo_fds;
+			goto exit_unlock;
 	}
 
-close_bo_fds:
-	if (ret) {
-		/* If IOCTL returns err, user assumes all FDs opened in criu_dump_bos are closed */
-		uint32_t i;
-		struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket *) args->bos;
-
-		for (i = 0; i < num_bos; i++) {
-			if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
-				close_fd(bo_buckets[i].dmabuf_fd);
-		}
-	}
+	/* This must be the last thing in this function that can fail.
+	 * Otherwise we leak dmabuf file descriptors.
+	 */
+	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
+			   (uint8_t __user *)args->priv_data, &priv_offset);
 
 exit_unlock:
 	mutex_unlock(&p->mutex);
-- 
2.32.0

