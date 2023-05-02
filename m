Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E126F3D61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjEBGZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjEBGZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:25:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932EE6A;
        Mon,  1 May 2023 23:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2yzP0CBXnrbXf6OcUEYr7wuu2aPB+FJOptaS6THVnpD3hETNV6gFwWZrpl4xGR24I44cO/xXYRYUhcRswIe2RjMzoKH42aqUNgDyTofjCHFUXRLbwKp+i2iCXQsgkBB3fsJs41bpfSz8o89+vKYW6jL4iQx7D1uDp5nQLKvQ0Ex75l2iN2G0EiHmBDPvRVwNT5FZfK4dSREnriAUzRM3s6YGqpWucwZWH8vp5bSNZnTaHA70s2JM7VK3z6GN5cybGo54sCUdmEvB4b5xN2wpvZorlbs/BpzQCwcKa2NSfjaiTzoDoLctTqbJ5uFCnv+OkxpKI+OGKTFk4cvjt6Wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHKePC7h87ObI+He0ndlPiNW5FUGs/BRqHtvQIAJy0I=;
 b=Ym0wRvUogdiQsSfqras9h1eYvKsWX9PDYm5iQo1BEIfItJJpfenP+7g1FCdnndbpV1CDoUBmTt2LY8EokJWeRIn360q+mxhcDeT+FGqf2x6gBvEVFLef+IGXHq4neixpUzsIS5lCvb01dw9a7htEpxlPU6UkJ04ch+5RY+OSBlosrgA4QuoHaLrjc/yaSjzlf+E7GDoF9juzmGubk1Nahm/rbFWXgvKXToc1Vy7u1IsMj9fG27oSWMAbep0CiVwulu2PKlDbS5QI+DmwfsAmBuoad7O40hs5mBtXGkA3ZB8TP9spd4rs7ic/qzBLRmQYFxJZuacvYLMSMsP6F9m6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHKePC7h87ObI+He0ndlPiNW5FUGs/BRqHtvQIAJy0I=;
 b=Q6ahe5dMbXxkf0EnQXsed9ESQW4zK1WIN14DLAnpGywbq/Dwphk6UqVmTxHCffD0G0lbVGpnCnWnhA6RpBWJjpjnPaOYgpD4WnToZdEs7omoMWr7HKFP7blYPfWI4RHSRwQOmjQhf99fY1coWVkIU1J1PWG4f77/VAQmFi+qqMg=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 06:25:26 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::db) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30 via Frontend
 Transport; Tue, 2 May 2023 06:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 06:25:25 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 01:25:20 -0500
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Dabros <jsd@semihalf.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        <stable@vger.kernel.org>, Sourabh Das <sourabh.das@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>
Subject: [PATCH 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
Date:   Tue, 2 May 2023 11:54:33 +0530
Message-ID: <6a25613e87158947b4d102be4859f406edcb3f0b.1683008188.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e45f64f-bcfe-4b6d-8aec-08db4ad60454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m48kheRU7KsqjgnaYCvRwSy7XiuQBU1yQayA6710CJ4InorYxQKNO17OLw1c35hmnImRWLTwdToD7TfbxJnS8H+/Kc/4hUUPRuvvnd8mKOoDxGBpHcWIb0XabQSqcGae4TDQsp0sCaPKp5YXU8UhEosdKVgbaYFsWIT5KBjr9Dy4YC36emAh4qRjh+ByJHYv6G3X40+7Ga3M8QuXUtlY3Vtjul0zZ/j3hZzzPIThs2AUAL4QnwIoiMGc2xP2r3frvkq4WJOHh8DbU1rkZmPQgauFJlcyifR5YtJkaoZe8AaqwlYC1QTXREgUK1KgMPciZ9jkgcctsanfjFGXf0Q4C86YO6mTOYzRp0BBRmFV0GikAwKLx4fmkxhnlVs+CpcNAVmp/HBAoXxYGq/hv755MVAFWIHcTRLbx2t3rJ1s7E54d2H39QG7paY5b0+EQAHEiPEpSrI7+L01FOuPlRaiW8bSZ/hPMJjJCuopJPAuyDIPtwyh++c73BDRvj3yU9bjk7NkjutG3aCDWqrs3qVX51TB69db1TAVZmwwhxktQ1VMYJ9tLJqb5vofpROkOD5xgPTikcSsP8pYJ9MW9jooh+ZsnnFB5Fq0AtbdGR5R/myo9MIC9nVWbOrlvwNX3MfaBbC3oWWmXe6C9dA3Knk7XkaTaLJH+hxZq9YIzsH7/nFxm1ijUJbD3QY5VnmRmYwvK4olTJhIySQDXA0tIUF+ZrphVn7Q78cNKzifgzuVQEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(4326008)(70586007)(82740400003)(70206006)(81166007)(356005)(316002)(2906002)(40480700001)(40460700003)(8936002)(8676002)(5660300002)(16526019)(26005)(186003)(7696005)(6666004)(36860700001)(82310400005)(47076005)(83380400001)(336012)(426003)(36756003)(2616005)(478600001)(54906003)(110136005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 06:25:25.7757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e45f64f-bcfe-4b6d-8aec-08db4ad60454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
value in 'return_origin' argument passed by open_session() call. To do
so, add 'return_origin' field to the structure tee_cmd_load_ta. The
Trusted OS shall update return_origin as part of TEE processing.

This change to 'struct tee_cmd_load_ta' interface requires a similar update
in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.

This patch has been verified on Phoenix Birman setup. On older APUs,
return_origin value will be 0.

Cc: stable@vger.kernel.org
Tested-by: Sourabh Das <sourabh.das@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
 drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
index ff48c3e47375..e2014e21530a 100644
--- a/drivers/tee/amdtee/amdtee_if.h
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
 
 /**
  * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
- * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
- * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
- * @size:        [in] size of TA binary in bytes
- * @ta_handle:   [out] return handle of the loaded TA
+ * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
+ * @size:           [in] size of TA binary in bytes
+ * @ta_handle:      [out] return handle of the loaded TA
+ * @return_origin:  [out] origin of return code after TEE processing
  */
 struct tee_cmd_load_ta {
 	u32 low_addr;
 	u32 hi_addr;
 	u32 size;
 	u32 ta_handle;
+	u32 return_origin;
 };
 
 /**
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index e8cd9aaa3467..e9b63dcb3194 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else if (arg->ret == TEEC_SUCCESS) {
-		ret = get_ta_refcount(load_cmd.ta_handle);
-		if (!ret) {
-			arg->ret_origin = TEEC_ORIGIN_COMMS;
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
-
-			/* Unload the TA on error */
-			unload_cmd.ta_handle = load_cmd.ta_handle;
-			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
-					    (void *)&unload_cmd,
-					    sizeof(unload_cmd), &ret);
-		} else {
-			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+	} else {
+		arg->ret_origin = load_cmd.return_origin;
+
+		if (arg->ret == TEEC_SUCCESS) {
+			ret = get_ta_refcount(load_cmd.ta_handle);
+			if (!ret) {
+				arg->ret_origin = TEEC_ORIGIN_COMMS;
+				arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+
+				/* Unload the TA on error */
+				unload_cmd.ta_handle = load_cmd.ta_handle;
+				psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+						    (void *)&unload_cmd,
+						    sizeof(unload_cmd), &ret);
+			} else {
+				set_session_id(load_cmd.ta_handle, 0, &arg->session);
+			}
 		}
 	}
 	mutex_unlock(&ta_refcount_mutex);
-- 
2.25.1

