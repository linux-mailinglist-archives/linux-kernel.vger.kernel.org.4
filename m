Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADD69F90D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjBVQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:34:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C05366B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:34:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdK4Ot4T5YBwcO9/DGnwSVZdc90MLE4Kq/RCP7bmA0yfvZaCw5KNlYrvELguAXqel02ccTrLg6jasJtpQ7SvZ7HXXIdoYczjwlG3mYQtQiI6AQF6wqh2nshg3i/YXkz7/A62T8Sf19X96/wZMeo7OlN3H2pky2hVfPm9d1fztaxGaNJwXU9icdDSnpubAf9UGozC/0VOyvPKvKlwk//1q3pI00HLGf1XE/AIALt0dKbN721zk9oMrs/o2GSFA6nyNmJz6YhNbhV0nQn2yCZgxlEFzeUHNprXiEYtOoB0PfJNXl/gQnr362pUJUsZssX99ymvq09LlY1DchlEExCD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwEydBToq8Co1unhxLmDNXyQ32zu3cINZ5DdNvCi2qg=;
 b=IrBPt5u1oHjWo0kc+tzNOH08c5Hw2VG9LyEl9JcOwpgRwjMOKbNt4zW7SSxbg3rSWGJkGVz2jkSv7EzN5YvrGtODf5afYmznVtPgqIEB/QDVrTGD0mRq0fWiLzOL0/lhQ1KTngAg4aUdLG5AnwUawb3xF8CF1+MI946DwGm0vWnJ4KJZcqGMZbkJyp3cuHJll7UymS5xT9jCqm7w4KBuisk37sRytRNfn0ZpGQboJ3hVI9YF29sL3YpkW7KlfWjd6/qUvrlNsvbMKI+q0etYusc2O8phk9LdNMyjz6GZfb1FxJBeDXFTRJYZDlT4tr5bkFRq/OeKwzokC98vj6UnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwEydBToq8Co1unhxLmDNXyQ32zu3cINZ5DdNvCi2qg=;
 b=zcUIaUalZkIlZxHWHlOpXfKTkTUzUTePw4ZKIA+7z6jOrbUtvhK5of1sscUzDA94ggp4KH2puwfcOOEWkgix3sjizk8C/TyTtNJcyiwjhuz1POm4Od88ZDtaAAJE/WYY81M4emeEBNclopXKVSj1+83JMhezonTkLMn/opJi2Ac=
Received: from CY5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:1c::24)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Wed, 22 Feb
 2023 16:34:24 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:1c:cafe::eb) by CY5PR10CA0024.outlook.office365.com
 (2603:10b6:930:1c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 16:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.16 via Frontend Transport; Wed, 22 Feb 2023 16:34:23 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Feb 2023 10:34:22 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Borislav Petkov <bp@suse.de>, Peter Gonda <pgonda@google.com>,
        Larry Dewey <larry.dewey@amd.com>
Subject: [PATCH] virt/sev-guest: Return -EIO if certificate buffer is not large enough
Date:   Wed, 22 Feb 2023 10:34:09 -0600
Message-ID: <2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083649.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc32287-20e3-4bc0-958d-08db14f2a82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbdDXWiQ5Z6hhEhNRL8nBQm1YI/vXE9sO8WwuzaTBQkmQq3BGzEmw2ygNFZaWveznc+JfNjclHm9jEG2vYy78isEJXPwkmksqI8KXnNaqLu+SHhDPODc5nzaoawpo9Hy50FUpuHTwvpo1iONMPkQBu6kUqHSdYi3ti8jANJnVyqabrntW1jzqxvdpBbfOS7ey6WVu/2g7wSDVKFe27hocP1vpKZ4mh0dHISKPLVAU3UsnJb2F0eUKRwwM408nEe8+SCGo99e77By/4vCwC3zoHdYA6sIHyq4Jvmrp5H7Z56t9w7KH1V2bBqv/eWUJ+813dQn9lNJ45ZvTw0eeaTVxXT2MQo12rS0p5+7tn4BOzCwhKaQrUjyCP1Xja/3klYu9t55yy8QhYW++uYXPmFjNdLt247dw8lD7QQRuuJ0LYR8tIVIcjOLUdSi/mb+0r3Yo0mJLw+dsvGNIz8vilRzIf2/jlVMXQMgLc8wKRVhpx2AFZGzezqNNlemVMLlrSQgZYrMSAUJaw9obdVV14L9UbE+fCDk3ifRXsouo0b4bys4nui3pLlgcE6TFalVv1sYcaJQWMYv3gCIZIuN00kDx8b8qfQhYik28xKEhHzEcyomjcJxvd5fcdVAs1+w8MrKUx7HVfXwR+up+X/fpe5CUARI0o/1JhMkfh8OQZXxm1Bs9akx4+uub3kZI3C/V5CGh17C4bWRqctmnMl1oUD/m2Q8EQhPUJLfsMi4Vc6DCH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(110136005)(54906003)(316002)(82740400003)(36756003)(356005)(36860700001)(81166007)(82310400005)(86362001)(26005)(16526019)(40460700003)(6666004)(478600001)(186003)(8936002)(336012)(40480700001)(2906002)(70206006)(41300700001)(4326008)(5660300002)(8676002)(47076005)(70586007)(83380400001)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 16:34:23.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc32287-20e3-4bc0-958d-08db14f2a82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

