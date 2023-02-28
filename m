Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61FC6A5604
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjB1Jlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjB1Jln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:41:43 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF62611156
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:41:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYfy398KOut52nhP1mRtDqGAzXgQ35yXg4IK8iq+mVzLkgnQwOuGyqk1+wvVYzP7XAy6fN9TyC5GJeR+gpGgdUkSs583aHL5VaqKSP3bamxtvM2d6aGmL+LjLPWGAAIk2ItckE4pZ9V+HFDuKvx9VHCx4D5SGnmp1Zy9yuGdOIXvTsF6BlyEker1GGeMfyDm9nYqhlWtdb96bHHoPWk80OsIxmgfUX7YvODYXMPPFqkTtrOULSkKC27DHKx4ZYfZ1eDtz9LrWPVNpEBDLUH+FORsDwHJ+DoRZ5BeqdB3rNFMFeU3X9RRH5ReTJrjE39BbtIFvhukG3/5OOjWe57nPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YKH0iEVgwSeyTflt5K5t5rzlfb2rXHFL18d11B22x8=;
 b=Ia1T9w/LphkzryFnYfJhdOub++frB7nkVjSCUf4KvuPGoclswqEyFBxvv8aIbVghKLD+54cHG+hfNLrNjbkiWRRM4yPLBUimxwwsvsCfaYUdHrXoUaGcEUecY85qmDasG/8WK2jxO9bFALP+lKiSW+EkHTd1hyo+OOx5M32Qf8RSEfJZB8zuovmru2yA/vshfqLjaR4DiGHBcM5ZnF7wi6Tb0HLzafcfaRBc5vyjnJV9YDoEj17gml6Z3qZKWnoLO36mNtLWRTa6mTpKcucVMHYBD28cL2Tx2d9V8Re7nj9r6VCCDzwz5oc4W3ADNbdPirbfECSVDjZT2yDHqMvysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YKH0iEVgwSeyTflt5K5t5rzlfb2rXHFL18d11B22x8=;
 b=B17qjOssfOB3C7O67sIVxzlJ+P2dSY/bJtQm7apyMjCi9jASQe1VohmhiNfwf2CXcHaDsmEAE2YvTafN/pTlR2bK6DNbE5jjT2vHO/M9JQjBGDLpG9wT66VuhA5S6wzERYeaOmAGGHVOKdoRQ68hLaVm2YJzJBHHM2vpS48JYqI=
Received: from DS7PR03CA0215.namprd03.prod.outlook.com (2603:10b6:5:3ba::10)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 09:41:40 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::39) by DS7PR03CA0215.outlook.office365.com
 (2603:10b6:5:3ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 09:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Tue, 28 Feb 2023 09:41:40 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 03:41:36 -0600
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        lm0963 <lm0963hack@gmail.com>
CC:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        <security@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tee: amdtee: fix race condition in amdtee_open_session
Date:   Tue, 28 Feb 2023 15:11:20 +0530
Message-ID: <5bf4f1d679e2f80814d07937309602877afd02c6.1677577036.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 2190e061-7146-4abc-71f2-08db196ffe65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABihjT+IZjY1QdXS8JLAYUuS2JWY3lDsyQB95IVmpudFI+GptjreJ9Id0/covq0cGDCTKp5r7bXdvPP+f4BEt+mA/HWmX+KmmMCUMQyh3TSu1TrtjeDVaMNKw9WHeGpzA6QXaR0JVxScx2hQfd26NF/oYbjugkCmQbLYnGO9ho6y+4uguk0tZ8zzUvlZXcxR1VjEqCLMOsS9ywFCPi2mQg+8J3ilTphNOlxh/DZofbjAvQ2sSK3hBQG+q92zQKwX3WsjDSyY7GLtS+1mMTY/rcxQsR7tiJmBkPaFK6mP+DzxjdR4iOXA/eQPJCChWti8HQey2dryUkSn3WzVAZV3p3GVgY/N82GMVHgBvR+CdvmwGgiHpi5R7Tg7F5vjnmc43ibH5ERZcTpMRf7gw2ElCvMGWTz0LCYrqA/QHn3ohJBRm8pwqAcfltyD3bF1kwLlMbYQdICppdfJgWhkSogCIvd2MFF4NCKpp0GAHqpdpl5Q+n/OpctWei+Ai5Lner9sW2lH8uzoNlBVQgbB7CyXT1G7d6lIrWqQDGP/jpuReFYE5s2J9Nb0JnVDRhw944K37CZ5A27hpjfv2eXNHrREtAmyajefX9JGuoh9TRuPq0FmvxIlSF9BxMOxZSBp6WeCmi4ub1cHMVMNXdXKgiZphPO+YNqIDGelzhfKDHOj2kdmfp/b88gw7Hy7ygYl6up+TEpJNamuYgCTOrtfdgGzWSEDUjIuc+hRz0Ky3iWBSU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(86362001)(36756003)(41300700001)(40480700001)(5660300002)(8936002)(4326008)(2906002)(36860700001)(81166007)(356005)(82740400003)(8676002)(7696005)(6666004)(478600001)(54906003)(316002)(70586007)(70206006)(82310400005)(40460700003)(83380400001)(47076005)(426003)(110136005)(26005)(2616005)(16526019)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:41:40.2401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2190e061-7146-4abc-71f2-08db196ffe65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential race condition in amdtee_open_session that may
lead to use-after-free. For instance, in amdtee_open_session() after
sess->sess_mask is set, and before setting:

    sess->session_info[i] = session_info;

if amdtee_close_session() closes this same session, then 'sess' data
structure will be released, causing kernel panic when 'sess' is
accessed within amdtee_open_session().

The solution is to set the bit sess->sess_mask as the last step in
amdtee_open_session().

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 297dc62bca29..372d64756ed6 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -267,35 +267,34 @@ int amdtee_open_session(struct tee_context *ctx,
 		goto out;
 	}
 
+	/* Open session with loaded TA */
+	handle_open_session(arg, &session_info, param);
+	if (arg->ret != TEEC_SUCCESS) {
+		pr_err("open_session failed %d\n", arg->ret);
+		handle_unload_ta(ta_handle);
+		kref_put(&sess->refcount, destroy_session);
+		goto out;
+	}
+
 	/* Find an empty session index for the given TA */
 	spin_lock(&sess->lock);
 	i = find_first_zero_bit(sess->sess_mask, TEE_NUM_SESSIONS);
-	if (i < TEE_NUM_SESSIONS)
+	if (i < TEE_NUM_SESSIONS) {
+		sess->session_info[i] = session_info;
+		set_session_id(ta_handle, i, &arg->session);
 		set_bit(i, sess->sess_mask);
+	}
 	spin_unlock(&sess->lock);
 
 	if (i >= TEE_NUM_SESSIONS) {
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
+		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
 		kref_put(&sess->refcount, destroy_session);
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	/* Open session with loaded TA */
-	handle_open_session(arg, &session_info, param);
-	if (arg->ret != TEEC_SUCCESS) {
-		pr_err("open_session failed %d\n", arg->ret);
-		spin_lock(&sess->lock);
-		clear_bit(i, sess->sess_mask);
-		spin_unlock(&sess->lock);
-		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
-		goto out;
-	}
-
-	sess->session_info[i] = session_info;
-	set_session_id(ta_handle, i, &arg->session);
 out:
 	free_pages((u64)ta, get_order(ta_size));
 	return rc;
-- 
2.25.1

