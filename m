Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50316FC084
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjEIHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEIHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:33:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1934EE1;
        Tue,  9 May 2023 00:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+DgwcGAZOkp2SBcLp1t3TKL/xjVusMmmhXGBHC7yxyi0FOmCYW+96LrXqF9+wOnURcF+BPPU9Tv3dXy8ZoCR9m/q1evM7EDP40Xqw9vUM1v08JXhCjRTLbYDwW11/yA+CpEmjogOCPcrqrp91fpLUT6qaIXR57eQnUd7y0lzT3Ig3fnrZoJaCq8rydK5IsRhSVXbVUPcAqhgsWPtYFGhcdHiANK2gGKUsuouhGWkD0o2Cmbsr5rPHU5R84ZpS43dtNGuMsR+MjUdE99pIEWVVbUmA2xJwKyd6N33dkp8vhRrO1aqDUwZLloBWserZb++6sebCoPiXD2DeVP9mI5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v03AMaMgK7wUzZy8Jzxn04siyMwf0osQNOZJgh5qhs=;
 b=ZL6kQDvS1PryfG8tcBRY4NSYEHqUKqh8yM/ekxHYWbXzayOguArxDfu/pkcMTTUDXVAEwxfCzcq0KzZJgHJVGKihw4G9iplely7EdB2wXbsHxy6yyEsPwEdPZEPvawSq6C3rnpXBGzQ6wP16q+Ui7C7zTvhLYK7/VFx1w8ig0DlUfhpWV2Vy4EXPEzjY6DKdilRyjW5anGuc5GCR+dlFRcVscIBJZYBVI7ddjf2i4vF67WwzkaCuqe6AA3DqlOc1CjJM2q6TIMVg1v1p8Gw+chV0LmuWynG8X76BxMoLbC8XjnbRjMRFbqH4U1xlSKnzwUzOs9oEY4MPnEMPfy/neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v03AMaMgK7wUzZy8Jzxn04siyMwf0osQNOZJgh5qhs=;
 b=QZZOEXb4hYeYSWH5lJ5uO+SjWjiOgoFfMFEPv92etM2sZaqx03ZBSJQhcCOboeUSRgu8gSYwTZQdh/9Dczr7KyAB7gbZTGdXOGH+wwyj72a29aOyy4t7AtdwXvSFBqdXiiCY+GLCYMhbW9n4A2HfMffmI+i+nxGybRzisOoqoFY=
Received: from MWH0EPF00056D0C.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:5) by PH7PR12MB5783.namprd12.prod.outlook.com
 (2603:10b6:510:1d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 07:33:04 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MWH0EPF00056D0C.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.0 via Frontend
 Transport; Tue, 9 May 2023 07:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 07:33:04 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 02:32:56 -0500
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
Subject: [PATCH v2 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
Date:   Tue, 9 May 2023 13:02:40 +0530
Message-ID: <a52cd6075f806eed82d577a6d437c705c7f36a26.1683617412.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e6e7dc-09c9-4fb3-9d9a-08db505fa07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95xu8ZmChgYBoXNfCzzIWaaJdoIZl7Q2pid3f5ikdqHClPlPBAT7fy7NKYj29IipsT191PzrPZ1t0LD41HMA+mdGibg2tZ3IfNaGm7CIleK4ejPr6vHGlQZdIciw7locvb1g5owSFugRMcFTuoo8m8HxxPTZFDlesMFqxvBDXBlraCn/4bKUPIpwwY4V9ZEuQS73qOXJmYZMVcPxF+qOlFFexYB7YpqvT/pvVlTfD71Cy+DUYsu8CLYKh7c05xPwid9fdtzgh8GEzdio+KgQpJGGESxOc2q88FVFkDCF+agk1v1UbzMe+3Z1yivPBTm4sUfz8kwDHbKLj4DMZITZsV63xsZcJaHo+TR62LkK6/PWaaDWo1B4aIVnI+OGi7HAOEew7Rz0FIRciB0NgVC1RYk2WvAK/47X+v5x3Ym2l6Dtui5qK9w+97gyK9uIOXbzoUqetFx4POfXFmMskOWjI6DqzDrVWb8akGZjxe8HnE26Hid6VL/ZOMpWSD3nd6lHxGrY9HW2mevOGe71WV7kctXg9Usw3rgBsgVIAPosvVOt6/H5bBH/VC0wEJLRtm+bVU8u4F6dwtmUMOX3BBdYqPIIeyclDs1IvyTqP0tywWnzDrHSp0KMM4BxKUbFhUS/bx9D8RYvbZPqWGUw5ipXt+jGzke+OePd6YhJyoEXp7CDZCcoZdO/riFCjoMgzI4B6ZZcrq649xQsB4SNKPRHhAZZmRDwQBLTepIXNJeZVPw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(26005)(7696005)(83380400001)(40480700001)(426003)(336012)(2616005)(36756003)(36860700001)(81166007)(356005)(86362001)(82310400005)(82740400003)(186003)(40460700003)(47076005)(5660300002)(54906003)(16526019)(4326008)(70206006)(2906002)(478600001)(8676002)(8936002)(110136005)(41300700001)(6666004)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:33:04.6065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e6e7dc-09c9-4fb3-9d9a-08db505fa07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Tested-by: Sourabh Das <sourabh.das@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
v2:
 * Added Fixes tag.

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

