Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0AE618C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKCXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:12:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964CCD1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfsRc8hhOYd/Pl3nKuzaXSPJRI+uwU3yw6YHYYkQDAoL7ye3zClMUQDblN9jHmhi/iF+rwiZdhRtsiAq6EHWL7GM5Fjuc88CbSTtO+lTGiqlHxNJLPyIhyDhR2xeoORn5rfVgz01uHF8LvZIn6E71402CfwpWHtL2kG9RmDbC4AWOM6yDVUe05MCRQNz/LPN7+9pMnggKTcajWCcri1ryodqPq5kNhyoB0Ub0LGTp8IoMMzcVoQZ0rQQuUAZQ+Wylu/d8DaW0VACJXMZpm55iVt/7Ab+SAIbXi61NfL0LK0znBDVvI3lOdM6YygJHC2ZZc+mR8uCX+GkAFeskHoixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELMsDmx6eatD56TTbGxTGAuKwEWgTwLnd8SY4jnfDcI=;
 b=GB3BiHqAu/whgVsfSvSVZABpaSnYOaqyghAYGaVTJyyVy4r21KFaSItE7rJjJw17AD+yZ23HIOhtBV4/9zeZFcZXHSvA9fbiZz2XOh3kvwI28dFn0dOv5kf81Mju0sytOhE2RMqGGYzdf+snEI69Xygzx7rEQ/WgjKfgRAGKNqmqHRM6KOew6iSe7J2ul1F43BbEtpPPWgC98Jadf5pQb7n8DaAXmChsM3VC44vPRMksXu6F3tGuRAIS89dDHbYxfRYryHmkiRelBSIMVeOF5njsSLo+7hMPev6KjGlMQ7KuYK4gEUSsfk/adrPJ/iEqe1ZUU2DLtG352JDZluBf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELMsDmx6eatD56TTbGxTGAuKwEWgTwLnd8SY4jnfDcI=;
 b=jap4z2TTB8c0rYqkWz+xL5vmQi8ccjOFYhEO2+M4GbRy/1XIsqSOcwDVOdsnbLefnC1xRF9QdulOOeIWSoDCOBU06CxgmGuQ5GC7mhLs7VYNzIJcXEKZbaC7s7FgyMBWKdAhZ8Tt8d6AacZewdiRvEzo7ZTqBN5VV1NbloUq3NA=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 23:12:53 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::1d) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Thu, 3 Nov 2022 23:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 23:12:52 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 18:12:51 -0500
From:   Felix Kuehling <Felix.Kuehling@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        "Rajneesh Bhardwaj" <Rajneesh.Bhardwaj@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix error handling in criu_checkpoint
Date:   Thu, 3 Nov 2022 19:12:27 -0400
Message-ID: <20221103231227.916426-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2837b2-a15c-4395-8f4b-08dabdf0eef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tA30hd0+719oHJUaGYheGFUxlEKhGWTdlTNDwWgBqs/NhVxWNeN9DAuB38bFNkgasZzLSTxX7EUQiO23vkmHX0SwYv0s4c+xgNNS+om6BPD3g+UwIftIjDv0O5EFq3/iT1vLWl8Gy23Z1dMQ1x25DlffUGZIXKoUc6b319WbQFFi9bR0m4OUPGr+5i9mSfQ56EnHpIYl+1GbAdFhp4XOveZhB0D1s1GNpfFMmh77bsqkJGKuZsSIRSv1+2aJifnnP1PYOI8zBNBoLaMCqh6jX9yHHnLEW4ysZrGGv2qQgvMP9AEMVxaE1ktUhklD+6msOPuLi/AjsKN23c7HEL2aUAFYoYMhWqiP9IZ/LY5bx2WvYv0BluInWZhTMOC/lRJgkEP7hy9887guXTPiUm6iskfT5wwdq9BU6MSutHhpbkswRFVYPUqrmFP27huq8GFinxEzCCbTTT64wlsQqSPK2rfVVtdKg9IjdDfxZrAEF0nT5K91/rZ4OVilC1B1LdhdqMgz6IgBZ3BAWA7M0AsJNZI3WFrQ/02w+uAPf7kD7XLzcdOdW/uazGNXQsgPAJ4YwR79lOujpQPcE2qB3tEpE+yRHiCoaTDf3KTYpjkf6HRx+zO7sK+HhbneBwv+vxyRP4T4OCI5x4fESpnBANPq9w3Avv/wXbKg5kY2Ro+HChjGyUE/FZGZjmzbF16mHjyg79O0WvHXmS8Mhx+0tJRl2eikcKFf5r8fDkSpxNLcIPMPophX3+0e2Q4p++wnNrZJFNaJlXpa4oYYN7Q2xmz+elIVoyvOOQ5GJdv1r1I9mrU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(6666004)(7696005)(82740400003)(82310400005)(26005)(8676002)(40460700003)(4326008)(6916009)(86362001)(356005)(70586007)(8936002)(70206006)(36756003)(40480700001)(81166007)(316002)(478600001)(54906003)(41300700001)(186003)(83380400001)(1076003)(16526019)(336012)(2616005)(2906002)(426003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 23:12:52.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2837b2-a15c-4395-8f4b-08dabdf0eef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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

In the private data, keep BOs before the remaining objects. This is
necessary to restore things in the correct order as restoring events
depends on the events-page BO being restored first.

Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
Reported-by: Jann Horn <jannh@google.com>
CC: Rajneesh Bhardwaj <Rajneesh.Bhardwaj@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

---

v3: Keep order of private data and restore order the same.
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 34 +++++++++++-------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5feaba6a77de..6d291aa6386b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1950,7 +1950,7 @@ static int criu_checkpoint(struct file *filep,
 {
 	int ret;
 	uint32_t num_devices, num_bos, num_objects;
-	uint64_t priv_size, priv_offset = 0;
+	uint64_t priv_size, priv_offset = 0, bo_priv_offset;
 
 	if (!args->devices || !args->bos || !args->priv_data)
 		return -EINVAL;
@@ -1994,38 +1994,34 @@ static int criu_checkpoint(struct file *filep,
 	if (ret)
 		goto exit_unlock;
 
-	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
-			    (uint8_t __user *)args->priv_data, &priv_offset);
-	if (ret)
-		goto exit_unlock;
+	/* Leave room for BOs in the private data. They need to be restored
+	 * before events, but we checkpoint them last to simplify the error
+	 * handling.
+	 */
+	bo_priv_offset = priv_offset;
+	priv_offset += num_bos * sizeof(struct kfd_criu_bo_priv_data);
 
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
+			   (uint8_t __user *)args->priv_data, &bo_priv_offset);
 
 exit_unlock:
 	mutex_unlock(&p->mutex);
-- 
2.32.0

