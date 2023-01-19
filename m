Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949226734C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjASJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjASJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:50:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BF16D691;
        Thu, 19 Jan 2023 01:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXOGjM+AzbFRn34h8PxU6C0aclbiSYxKalYLXnehEj4ZL6CYnV22kGxcs81SJNGPWZLTxeYpAD/WuT1RTGt8gjV/Nb01WJH/pHuzCW7tJPGwo+RbAt4acYVda+ZRMxmcJlqgR4BN49x+wtYPbyIwj9JuszX/DST3zsQcwCwOcx/1CEOyLJO/5IzlyuYTzp9rp1uXw66yObY2EwIT1gdK6OVzpxJ5Sr5t112MjK8d8EA97Flfb9wcYp2bEmmGNXG9bBufscZPd0p4VQDXl8ZPC6F5Vq8/1yjnkWw1nSWd1Nix8PSR27GHi8PgUy6MJGiG05emgFxMUuAOrPYUoC4vQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrMuActR6OQJCCPByn6IEjBw/ExEYcClaeKJ5xFz3cA=;
 b=P1Bf7l8jQPGhrquiW32tLjdMrf8Vcs6kIKxi94MD56nQ2WOXRdN2lCn/PCLbWeS9DZUqRHV9e8HHIQAMdoI1YKZAsTUkKaJXe2Bqy85yFYN76a8YOBLR1We3GPCOOp0WeFCMCBqe5W7mpF8g0hgyDXRTZiXTraPIFy1NSiFJSTY7igfE0B/sx5+96uKsKDE4Bcd0YLy8h4aymjduxbS6gF8ep7e6eb8ecZVoM9gbIoQ+G5BeNwveUuuhoOJ4QI4JxJR7Sst0pqEx4RaoCy1Of8UhacOZ0jgOmt9pRk59u0CSfmOMUzhztbGuaOn9aSYgWp87CWI91DZUrbPbfSRDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrMuActR6OQJCCPByn6IEjBw/ExEYcClaeKJ5xFz3cA=;
 b=n9tzCm6+VWNnARRr3DJYIeDMMHLG++IKaZ78uc0RHlgji8GmhwAAjbGXDXytPiPmO8MOCpQtDeuruwAe8tkxpt6Ym3EXp3Jb1k3afgQLx69ShG3vurHoWmNl64B+CF2udbc9D+InIpx9SP/WJkVdwLo6+h5pporYvHFWaSYraBk=
Received: from DM6PR07CA0100.namprd07.prod.outlook.com (2603:10b6:5:337::33)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 09:50:10 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::b3) by DM6PR07CA0100.outlook.office365.com
 (2603:10b6:5:337::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 09:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Thu, 19 Jan 2023 09:50:10 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 03:50:07 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] cxl/mbox: Fix Payload Length check for Get Log command
Date:   Thu, 19 Jan 2023 10:49:34 +0100
Message-ID: <20230119094934.86067-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 80da876f-de78-4398-7b07-08dafa028e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2OdQaF04f9esJz5LTLL0IuLbTutx2KGu2wRTnRtmgwb/rYoJms7UFxeprHGhUiNwbmXlq47pzFLBWwr5WjxAdLH7hKacEgiFP+dZYxgm68KBqZWHrAaZX9O6K7KVDGIi5L36091IKRQ78DNv/CH6evnIjKDve07x+nv9NDcRkM5+STtov9lMj6t4Tqrshm/OGeUY2/4+Nqb3n+gjmJD533h7+6ydfX4dK/EfFCqiX2TmXs9GAzy9WEp48JlA0wRF+JXLn/iCNz+d7vMBUcUKvQHlM+kY2ZUeZK/L3SFcjSfLjUsmA/uVG7p9qSRRJjAw0Q4NQI2LgaQFd3VTRcYjWrwnZzIKCbfFHxmaA+EvBoFAwkQgRmUafrOdQVulxq3/n58by0EDmHEnJlmCUzULwTciAWmiKx3vYXnqizE7NTJjQM+ApD+xNy8DUTnmkjQilGRUdQ2AwOfcPQ+uoVIxMpkoU83mbLHDQj7q4V7zWKDqtoIdNqFhMzMw4tbqivPr/Z4tSiJUZsC6fLFft7lAFiq8OP2ivFggwZs8Fx7gHjdIslYWIcZ6l2CTiqLBB+ksOiCRI/b0BY1YUoBHSvd4zYr3mANa3EH2m4FirtZer4gO+tCTVlbCHjRyf37HpAp2w2GwWhzaTQ1y7E0MpW9iOdy8aMCZVY9fLHI7zx9VKB6zBGTgsZMtxSPfayuG1MGWmEYgpjzIBaFWWLLZxt3tuWnaoTqa3L+vChm0h4/r9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(70206006)(54906003)(110136005)(336012)(1076003)(70586007)(316002)(41300700001)(83380400001)(8936002)(4326008)(8676002)(47076005)(6666004)(5660300002)(2616005)(426003)(36860700001)(2906002)(36756003)(82310400005)(81166007)(186003)(82740400003)(16526019)(478600001)(26005)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 09:50:10.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80da876f-de78-4398-7b07-08dafa028e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2aeaf663b85e introduced strict checking for variable length
payload size validation. The payload length of received data must
match the size of the requested data by the caller except for the case
where the min_out value is set.

The Get Log command does not have a header with a length field set.
The Log size is determined by the Get Supported Logs command (CXL 3.0,
8.2.9.5.1). However, the actual size can be smaller and the number of
valid bytes in the payload output must be determined reading the
Payload Length field (CXL 3.0, Table 8-36, Note 2).

Two issues arise: The command can successfully complete with a payload
length of zero. And, the valid payload length must then also be
consumed by the caller.

Change cxl_xfer_log() to pass the number of payload bytes back to the
caller to determine the number of log entries. Implement the payload
handling as a special case where mbox_cmd->size_out is consulted when
cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
that -EIO is only returned in case of an unexpected output size.

Logs can be bigger than the maximum payload length and multiple Get
Log commands can be issued. If the received payload size is smaller
than the maximum payload size we can assume all valid bytes have been
fetched. Stop sending further Get Log commands then.

On that occasion, change debug messages to also report the opcodes of
supported commands.

The variable payload commands GET_LSA and SET_LSA are not affected by
this strict check: SET_LSA cannot be broken because SET_LSA does not
return an output payload, and GET_LSA never expects short reads.

Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v4:
 * Fixed a build issue.
v3:
 * Added comment to the WARN_ONCE(). (Jonathan)
 * Passing a size pointer to report the payload size back. (Jonathan)
 * Moved logging of supported opcodes out of this patch for a separate
   change. (Jonathan)

 drivers/cxl/core/mbox.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..a48ade466d6a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -170,6 +170,12 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	out_size = mbox_cmd->size_out;
 	min_out = mbox_cmd->min_out;
 	rc = cxlds->mbox_send(cxlds, mbox_cmd);
+	/*
+	 * EIO is reserved for a payload size mismatch and mbox_send()
+	 * may not return this error.
+	 */
+	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))
+		return -ENXIO;
 	if (rc)
 		return rc;
 
@@ -550,9 +556,9 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	return 0;
 }
 
-static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
+static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8 *out)
 {
-	u32 remaining = size;
+	u32 remaining = *size;
 	u32 offset = 0;
 
 	while (remaining) {
@@ -576,6 +582,17 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		};
 
 		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+
+		/*
+		 * The output payload length that indicates the number
+		 * of valid bytes can be smaller than the Log buffer
+		 * size.
+		 */
+		if (rc == -EIO && mbox_cmd.size_out < xfer_size) {
+			offset += mbox_cmd.size_out;
+			break;
+		}
+
 		if (rc < 0)
 			return rc;
 
@@ -584,6 +601,8 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		offset += xfer_size;
 	}
 
+	*size = offset;
+
 	return 0;
 }
 
@@ -694,7 +713,7 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 			goto out;
 		}
 
-		rc = cxl_xfer_log(cxlds, &uuid, size, log);
+		rc = cxl_xfer_log(cxlds, &uuid, &size, log);
 		if (rc) {
 			kvfree(log);
 			goto out;

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2

