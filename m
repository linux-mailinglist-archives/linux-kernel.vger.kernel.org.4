Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372DD69F928
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjBVQjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjBVQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:39:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AC1ABED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbh8WEHQsfMB6bV9n+wXMv8MN2GLV3j79kFMyf3PgtzfF+RnhHtDL900q0wgLnkTvujDrs7/H4gZ6+PYE+vDEpnQheV7mjoWMtBZUf0Y+ilh/BlrWYPBZ4UFKHcK01yaxsCzLZPVTttrlXxhJmFvmOYdpl68xAhpmgcQcpQ40EZ95NnihMqN8vIzJzTeKkNRW6cipQN0YBum6i+KKVAZt25XbNkLhHRjP/6CF5g33I9bS6KdLyYJGiyEzSGH4K6jl6it9VIENoIqmvkWhVnr/Uj0DZS/3+P+HyfrbiuCPQRJaVS+CKc/YXAc/saWBFQiqlGYy0NNDKzxiJsOko3D2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwEydBToq8Co1unhxLmDNXyQ32zu3cINZ5DdNvCi2qg=;
 b=XugFA5wihLN0Oxo12a2UwhENwbrPzjQIQxfEIx/sFOFxzuJlGT3rfjL4Esll9wlRMfKmQ/clnR40BkyboiW/ZOLrIKVTWx7j4ntIjO7LZh7MHzy+gNdsXj3SU+eaLXZ+9BXRBt/A/KlkIHOygaJ7gK1ay7w1UvnngYtzs4NdzTXm2Iot40yVMZUDLfwR+oVTV1CJOpl6NtvqPzigNBIn8HzGDB4af9Sznlxbs15CDe3AbjjUV1YpgXoyHypzEyzk9s27/MU66MdAOmDvytKyt5XXovStyGDLqSCe06omCBFOWxNuSKPiooPu0vJwwTxKekAR4nkVrvEeiZmcu7oJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwEydBToq8Co1unhxLmDNXyQ32zu3cINZ5DdNvCi2qg=;
 b=2k4XRz1XHt4XiHNsIM+W+EhSQsNJqfOLh0shFJyWXmIumHioWL4sv/aXRMTBxX+iExxlYIMKjcRaAJI8EJjcc+11nwEgpq3VF1BcbqZSSDSBii9nfhseDfPgIzCzxLTd1JMyh011ZyKdsk09vB1aRpYedYu/krvpeYfuMlSuc58=
Received: from BN8PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:60::14)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Wed, 22 Feb 2023 16:39:46 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::aa) by BN8PR12CA0001.outlook.office365.com
 (2603:10b6:408:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 16:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.20 via Frontend Transport; Wed, 22 Feb 2023 16:39:45 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Feb 2023 10:39:45 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Peter Gonda <pgonda@google.com>,
        "Larry Dewey" <larry.dewey@amd.com>
Subject: [RESEND PATCH] virt/sev-guest: Return -EIO if certificate buffer is not large enough
Date:   Wed, 22 Feb 2023 10:39:39 -0600
Message-ID: <2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083979.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: be801534-93a4-4a5f-e663-08db14f36825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysSorce7bF90CstHYDvcEx2ROat9YkvGepGJ3dwGdl23pQVHDq3Xz7q6iL8HItCHtPhiD/Z7U+v7la2RQ5faIKSlxBwou0JbR9KG1V82Yv47KCi+OUj4jTVTI2QZc4i6KDW4wvKhdbkoHttNX4ZyDjS59H8UAYxxfHKYlVsBlOWOKbP12YySryMI1N5QkICoYRbSdqa0KKSiuoXvm5XkQmBaiiy3llYJ7/ZIZIvhRMIyQaAHhsirzMo7AEftWAzPXYZLLmZhc38T4ORBjd0BxlEqU7XAGrh0YywhApx9qrcMhCWpnTlHS4Pow3bAUZ2/5Q2cGlrNwNgTtwNmTN008OQn5uYCJwoLxwJnbR0GCBCrWDUFATgIOkxVwKLwWYnhm7rA7Arj6ASbtngYMC420qarczUgyo2dGwXAXJLDi6a/iDK6eGgQgfwgDNirScLzkTywzFczEUq+ZKHhFQ4R901doeBfKhoUcvnAknw9pZzwHQ1Bm8ewaaoyI2YEdRmUl+MCjbopdcT7fUovdwYXZ+pmkC0iGCTESHe/nYit5936uFxE+BGgwa/lE0f0lWM0Ig8nkkysPZlMHxD/WqIyQ5XRR9lsVXSff7C4ZfmkUU4DvcteDBkQo1iWCHjd0v60RnB4aN+IDt7KcZm0cv75k/A5yK7uCS9D2SHBp4wQfazs/6w9ny7iN93OMc87kjd+x0Q5ZzJFAur/Yg0Y1swgCzre4HoE/DMYZ5HQUnFeRcs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(356005)(40460700003)(82310400005)(86362001)(40480700001)(36756003)(336012)(316002)(83380400001)(426003)(47076005)(54906003)(478600001)(110136005)(6666004)(16526019)(186003)(26005)(2616005)(2906002)(36860700001)(81166007)(82740400003)(8676002)(8936002)(70586007)(4326008)(41300700001)(5660300002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 16:39:45.9511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be801534-93a4-4a5f-e663-08db14f36825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest
driver") changed the behavior associated with the return value when the
caller does not supply a large enough certificate buffer. Prior to the
commit a return value of -EIO was returned. Now a return value of 0 is
returned. This breaks the established ABI with the user.

Change the code to detect the buffer size error and return -EIO.

Fixes: 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest driver")
Reported-by: Larry Dewey <larry.dewey@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..7b4e9009f335 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -377,9 +377,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		snp_dev->input.data_npages = certs_npages;
 	}
 
+	/*
+	 * Increment the message sequence number. There is no harm in doing
+	 * this now because decryption uses the value stored in the response
+	 * structure and any failure will wipe the VMPCK, preventing further
+	 * use anyway.
+	 */
+	snp_inc_msg_seqno(snp_dev);
+
 	if (fw_err)
 		*fw_err = err;
 
+	/*
+	 * If an extended guest request was issued and the supplied certificate
+	 * buffer was not large enough, a standard guest request was issued to
+	 * prevent IV reuse. If the standard request was successful, return -EIO
+	 * back to the caller as would have originally been returned.
+	 */
+	if (!rc && err == SNP_GUEST_REQ_INVALID_LEN)
+		return -EIO;
+
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
@@ -395,9 +412,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		goto disable_vmpck;
 	}
 
-	/* Increment to new message sequence after payload decryption was successful. */
-	snp_inc_msg_seqno(snp_dev);
-
 	return 0;
 
 disable_vmpck:
-- 
2.39.1

