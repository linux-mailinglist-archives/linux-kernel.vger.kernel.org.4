Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0873616FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKBVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:25:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38293386
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMs1yjbYhNFR7A5K2zpLKK4G46AJ6MGhCwR1OEhBNKgzythgqjtwIwSRjAxbPcvyz0Q0i7nRBYhRSIM5R0P2O0xcTBsmnOcdPVzM2yxGgYYAE7s2GMXIkVyM5K4xz5EKpIqP7n0cpwxSiscIvYgVoGkJNDqvRHMQND2B7kz8m2J3+6rbk1YSN0nXu8pZsNGTyV0cdlL4l/2e+OScuOWLPQALt8cUwdAx80kuq9crkzZHMoe8ygUkRMIVm/kEDuWxh3AHgiSU145GEFHVNy+4ZsjThODz14WlREV1WALfFbW5gWFoZCzPZNS/02hlyECnnvzTxCJMmy8+Kffcl4IUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFCsKyOQSozw9/zJB5OHaI6oGZyFZMbAWwcxRSzIlcU=;
 b=JsVQT7vihGw3yW+vSFa7KJaqGDPEB/uBvjjE0D9zpso9NTt9fjXmfx/IwI6RZh3j1zF8efoxE6mD8XQkkwNa254jPP/7+yT1fhXojC+yD2BhX2n4WMArZhZXBXZjdLV6TDIdE+pOsLfly4B4wHE+v/ybEvuy2jOMJXRXOFFshBMYVDeOW/l0+5KTlzlo6zmTNG8lY8wlFwl+ZEtatviL8XLzvHV+XgQfUzsWwiTVVd9b4bqDBm/0Nb2kPZF/UlstMLdxHNuN4SyBmhCjf7LHNdHvH7K8bYIlt30BNEL4WWe4AoYLSSKyb5qQ+knsdYR5XYYd+an5P+8Ml3CTyCYEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFCsKyOQSozw9/zJB5OHaI6oGZyFZMbAWwcxRSzIlcU=;
 b=AMOpF7EkQB5OA4XS75yptqDhl27hRTbfYIDWi5vf4fzPj7GhDCoLxfY9/UAhlcJsFIbFQfZN+8e2iLEktwX9lbtTvD7n2qk1ZsPo8rejIGX9bJeNml/PypuwlVWoDFUeILV0xtU4rhp0+OnlUYpr6dqH6Os6zPJwDPD9S3gabjo=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 21:25:02 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::b1) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 21:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 21:25:00 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 16:24:59 -0500
From:   Felix Kuehling <Felix.Kuehling@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        "Rajneesh Bhardwaj" <Rajneesh.Bhardwaj@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix error handling in criu_checkpoint
Date:   Wed, 2 Nov 2022 17:24:29 -0400
Message-ID: <20221102212429.623848-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|BL1PR12MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: efdbc1b2-a2e4-4d58-c4e8-08dabd18b2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68HY2wIABBBqBWJ2exNzqAfxV+BaSB53L8Vgbov2QFy66ANqZwF2/7hAUhT2xRb56MazTTSqvVGe+JEjxwim86hxbxPLOzUX14oaXSJzhEyfGRScsp4Gmi1lG2lPuE+Ge2MSTacfb3StEyXDksBomzIMC1dA9KT2aQ9yC47co/a0zlspjlYEasXnhSTGMaCepINRMjB+h7wXsxPdvR9x4us76HOHPNUJacc94JI0kAyLANiFKKYv+6rIMfXwSF2tn5ohOOTebTLcUNmJ3agEYqX+OJv1vTx6OyAVxn/EpNq00GIXJGqbqW9zmKZ+oRqrfGaDm2Qtrb7PWRtcQhqapeODKiOVFEJIeB+VvJVOmTZeSCwBPD+vdzQ+9/HkHaHsHrrxrDZMfJK6hsgI99TXFNF1w/VoNvJP69SNnWikvOCwRCron8syR0TogLbuT1CLxdB/bCSff64dQIuUOksUkHaaY/jtm/hINBE9A0whGTzwUHC6gh7jRxayPkAfeofZg8ZKYJzAdg2UrbUlvzVE1TRUWVauwrCEli1s9oRfQUBXULkX+sKonypEJ6cA47eSPLufVO4feto+u635Kout25GgBrzY+21RtGC1+TOK5Nxds20Zr6wWlCcV/UpGWd9EiP2JlAPvBoZ3D5OwUOtCu4LvPsMI3tisO5KLeDQlZWwf/exaToa96or/69QosWP/euHOP5+spKhiQ2GS1Z1ocT/FuuUwny+qG48TnMzkEQH/baTc6zjr80xR8/tMGu0pt/sJJA/rH4oRYZ9cCLMNjWW6JMxqsKWin/FldQtkcbU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(81166007)(356005)(83380400001)(336012)(1076003)(2906002)(40460700003)(6916009)(47076005)(478600001)(6666004)(7696005)(26005)(426003)(16526019)(2616005)(40480700001)(36860700001)(186003)(4326008)(54906003)(316002)(82310400005)(41300700001)(5660300002)(70206006)(8936002)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 21:25:00.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efdbc1b2-a2e4-4d58-c4e8-08dabd18b2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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

criu_restore is updated to match the order in which objects are saved to
make sure restored BOs use the correct private data. Since this is a
change in the layout of the checkpoint private data, bump
KFD_CRIU_PRIV_VERSION.

Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
Reported-by: Jann Horn <jannh@google.com>
CC: Rajneesh Bhardwaj <Rajneesh.Bhardwaj@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

---

v2: Also changed the order on restore and bump KFD_CRIU_PRIV_VERSION
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 31 ++++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  7 ++++--
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5feaba6a77de..666edcb40354 100644
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
@@ -2477,11 +2466,11 @@ static int criu_restore(struct file *filep,
 	if (ret)
 		goto exit_unlock;
 
-	ret = criu_restore_bos(p, args, &priv_offset, args->priv_data_size);
+	ret = criu_restore_objects(filep, p, args, &priv_offset, args->priv_data_size);
 	if (ret)
 		goto exit_unlock;
 
-	ret = criu_restore_objects(filep, p, args, &priv_offset, args->priv_data_size);
+	ret = criu_restore_bos(p, args, &priv_offset, args->priv_data_size);
 	if (ret)
 		goto exit_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 552c3ac85a13..069977d37605 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1063,9 +1063,12 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
  * kfd_criu_queue_priv_data
  * kfd_criu_event_priv_data
  * kfd_criu_svm_range_priv_data
+ *
+ * Version history:
+ * 1: Initial upstream version
+ * 2: BOs are saved last to fix and simplify error handling
  */
-
-#define KFD_CRIU_PRIV_VERSION 1
+#define KFD_CRIU_PRIV_VERSION 2
 
 struct kfd_criu_process_priv_data {
 	uint32_t version;
-- 
2.32.0

