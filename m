Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127865C886
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbjACVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjACVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:00:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67609FD05;
        Tue,  3 Jan 2023 13:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDR8IQvSAXQ5Z2r4bBCifC/lZc3wEHQUrKse1YA+vkp8ADKpw4MTyqyYpECjpHnY1UMl1kz1LGXSHeX8V9ErTYXiWjxF6NIHIl5aON/akN18kBS1JkAmY7Ik1fkZhE/t6rmOhsITTyNfPvm0vnsUIT0y1/2YID5Wk/dLiCuguVTp3tJ0+0/104tyKFABpwKJYjm5hL5pKjBaJFt0Stv606lrKd8Bf2r9wH8cZZ/wQ/qP1ZJfqtiEcH1PWaJEPzy9plG6S8CP4g+Ym4foz052OvCVQSzGlfYkjun2zVxn3EAi7FvrXRt2KoFaX0yWw9zsAKX+2i+VSoJdVLO+PGvNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENqiXS9gTaGbJTbBz+msJuYQCDXdNVEETbLCtn87UUk=;
 b=ZzHNgORcQgLh+N1EEqR8WYuzu82xz/V78iT2Zadd3dXuNarUp7clXsSopaOX6a07JtQFyfUnKm0xgrdSxq2/mEpBbDU7MtbDKqWKWFZlAA83hHp1rwauEa8dbB5nj9p+OGHkqd+OoTWiqnhltINBaAMjxKgzDtSm3KTVuAHpnIVHUBuihqinfUMczXd36nobMDbrI0qToW4m32jQNgHW9AxtXPdXionjJhdgGBOcM/UQcy3c3HDPrHqWHq9SsHJWUqsXy3tB0DKQDCIFo7+4isxHvMdzFsH+Dp07NwxMOmmzRoYEC8w0lYUCZMJxeDOk1kvDTgrE0xGmW79aUpEW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENqiXS9gTaGbJTbBz+msJuYQCDXdNVEETbLCtn87UUk=;
 b=Fsp054vVzGZ9rLAdwXF3TTtvyEYqqunaw5QIgj8OKmk0NYNs6hWqZAlqccC1dGivK5pEIrhN/pLC3C5igU5IimSoVi5hh+nvubmSz9UdrqP3yau0k+hYZVM7ld5jWaygLSXV7Ijke2IUeWysEPr+OUFZSg3bxq9eNF8dHogc+7I=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 21:00:06 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::46) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 21:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Tue, 3 Jan 2023 21:00:06 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 15:00:04 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/mbox: Fix Payload Length check for Get Log command
Date:   Tue, 3 Jan 2023 21:59:36 +0100
Message-ID: <20230103205937.1126626-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d59d5af-4e7f-438b-ecc1-08daedcd7e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DQ7dBYKzAeyKlsTp9m5QW0pOG4tYdKqzHOoe8+j9T+v9yhPJPpjAyAAZbX1A/6RZnbJYqqtGTtWXVjiDZxkogFs62KSvzbGIASYwayU/q2ImgPCAPWi8aYFzsPBxUQwLvlma0EkXpfxRWhMfU46e46cdUi7a6qK+/xYl2ZbNhsddaCpizfSJpeOReYJ6nwSycbEsPVOhGE+ntyHrh+XHg61ZJGJ/47ittx1PXtYqiLrqbll1BaL6J/E2vpSVzHAZU3LUknQImGjC+VQeCqYJ6Ci4TMWMWa71E0YZw9u7hokwaeRQR9ER7S14/FjODT2quhMTtpCiNFHt9I6fr06ZM3Zvl7Zk7LFftO1jTensrLKGipAIV8wGRpqwDsrx7EQYKVAKNIIPm7IxeeouS/uELvWTPUjlm9iIbvu9pMAIvaPoLjWMBz9GLpV8Bo0PLGjcDWFdE4IFdvFcTS4oIP8H5DmC3PL7NATpuU1BWn37vT/UXXDWLcEM4bhZNDq6SVypnBBseFCuqj4C2BZh8aMqIpmB0T3C3EcQVhGRTzFWRDXMriUCyU9e3fIV36GcdWkNDxdkUV8ac6nHkt7PfWc5CceP03wUK0aVw1c3CR4ajNQhTTy+wZF3u5vfksd2jfBQ5bMGQbLsdJRErj9+431ovIsXvRixirmxVQwVboRWkA7z5nou87PwPFqYLJ7dIAS443BeEpqoCtD7lgbDESgK//83/pq7ztgNfk3+XqMiNFJKhcOtmNxdNh3mqCgccqCdS0olohHjfpzimNqcqbEwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(36860700001)(336012)(1076003)(47076005)(426003)(40480700001)(40460700003)(82310400005)(356005)(81166007)(82740400003)(36756003)(2906002)(70206006)(54906003)(110136005)(41300700001)(5660300002)(70586007)(8676002)(8936002)(316002)(4326008)(186003)(26005)(478600001)(16526019)(6666004)(22166006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 21:00:06.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d59d5af-4e7f-438b-ecc1-08daedcd7e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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
caller to determine the number of log entries.

Logs can be bigger than the maximum payload length and multiple Get
Log commands can be issued. If the received payload size is smaller
than the maximum payload size we can assume all valid bytes have been
fetched. Stop sending further Get Log commands then.

Also, implement CXL_NO_PAYLOAD_SIZE_VALIDATION as special value to
@min_out to skip the payload size validation check. A value of zero
for @min_out is already widespread in use as default if the size must
match @size_out. Thus, zero can not be passed to allow zero length
variable payloads, CXL_NO_PAYLOAD_SIZE_VALIDATION should be used
instead for this case.

On that occasion, change debug messages to also report supported
opcodes.

There could be other variable payloads commands affected by this
strict check, the implementation of GET_LSA and SET_LSA in this kernel
could possibly be broken too. A fix of this is not scope of this
patch.

Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/mbox.c | 41 ++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxlmem.h    |  5 +++++
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..0c2056ae8aff 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -183,11 +183,16 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	 * Variable sized output needs to at least satisfy the caller's
 	 * minimum if not the fully requested size.
 	 */
+
+	if (min_out == CXL_NO_PAYLOAD_SIZE_VALIDATION)
+		return 0;
+
 	if (min_out == 0)
 		min_out = out_size;
 
 	if (mbox_cmd->size_out < min_out)
 		return -EIO;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
@@ -554,6 +559,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 {
 	u32 remaining = size;
 	u32 offset = 0;
+	u32 size_out;
 
 	while (remaining) {
 		u32 xfer_size = min_t(u32, remaining, cxlds->payload_size);
@@ -572,6 +578,8 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 			.size_in = sizeof(log),
 			.payload_in = &log,
 			.size_out = xfer_size,
+			/* Any size is allowed (CXL 3.0, Table 8-36). */
+			.min_out = CXL_NO_PAYLOAD_SIZE_VALIDATION,
 			.payload_out = out,
 		};
 
@@ -579,12 +587,24 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		if (rc < 0)
 			return rc;
 
-		out += xfer_size;
-		remaining -= xfer_size;
-		offset += xfer_size;
+		size_out = mbox_cmd.size_out;
+		if (size_out > xfer_size)
+			return -ENXIO;
+
+		out += size_out;
+		remaining -= size_out;
+		offset += size_out;
+
+		/*
+		 * A smaller output payload length indicates all valid
+		 * bytes have been fetched.
+		 */
+		if (size_out < xfer_size)
+			break;
 	}
 
-	return 0;
+	/* Total number of bytes fetched. */
+	return offset;
 }
 
 /**
@@ -608,13 +628,11 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 
-		if (!cmd) {
-			dev_dbg(cxlds->dev,
-				"Opcode 0x%04x unsupported by driver", opcode);
-			continue;
-		}
+		if (cmd)
+			set_bit(cmd->info.id, cxlds->enabled_cmds);
 
-		set_bit(cmd->info.id, cxlds->enabled_cmds);
+		dev_dbg(cxlds->dev, "Opcode 0x%04x %ssupported by driver",
+			opcode, cmd ? "" : "un");
 	}
 }
 
@@ -695,11 +713,12 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 		}
 
 		rc = cxl_xfer_log(cxlds, &uuid, size, log);
-		if (rc) {
+		if (rc < 0) {
 			kvfree(log);
 			goto out;
 		}
 
+		size = (u32)rc;
 		cxl_walk_cel(cxlds, size, log);
 		kvfree(log);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..2db24b062913 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -102,6 +102,10 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ *  * %0:   Payload size must match @size_out.
+ *  * %>0:  Minimum payload size.
+ *  * %CXL_NO_PAYLOAD_SIZE_VALIDATION: Skip payload size validation check.
+ *
  * @return_code: (output) Error code returned from hardware.
  *
  * This is the primary mechanism used to send commands to the hardware.
@@ -117,6 +121,7 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+#define CXL_NO_PAYLOAD_SIZE_VALIDATION	SIZE_MAX
 	u16 return_code;
 };
 
-- 
2.30.2

