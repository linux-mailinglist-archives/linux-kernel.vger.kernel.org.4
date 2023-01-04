Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632E065DDB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbjADUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjADUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:30:35 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120A38AD6;
        Wed,  4 Jan 2023 12:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGzwgSG2+ucIuO3fyqDuHysvHN32gmas7rrPeBzGABoXmjpi84LdRRss+IcWrXvP2PnNtuJyZnZdS52pPyMOYFxcID0aMcpkBVzsMhVOLoCZ+Uvfd+yjoUzxoN9kLzfvVSawb54Y7PKTThDAGYA6sFuSjvuZrBKRp2/lmS6B8/+go9UtfgI4xZ6T0SdhwjZXxscZHRyyd3wCkFTxJT6v0k3DRRjXXErKZvb97fvjx9X2LaoOPXQfyvBwsaSfffukid71VILZE8k+cjvQPorQ2vMczogVJE2q6i+AuhYV0rjrzM7ltPR01dZh6vZcyNMh2KwGit1U3mFM9bPiZwMKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv1sQUMPKGdnY/IkkYNbf+FC60lh4lQEvG1dxEmiBa8=;
 b=GSrctn+MXWHSyRvSYzIjC59VjOe45YFntzJ/0J18OQYKAl2aoZ8n3kafO7YUe5t4MXLIK/Vkz4k5yKRExasJa03iNBX12kFcBErB3qbXbw56dLPOWxwlr3F+mX2+9OpAzoiJNn1M+A82bBjEC5yhdkW0Gt2i+zo1ucbxdYbj3sxUOFOlzhu1LAdNAoX4yLv4/aNSfPzsbbm0yNM/hri3xno6u/XD1u0CpYoIPRyeTnY+v1DFDuqhfE36Bctw/41t/y7spmrzMLqkDHiLkpIOmXLZN46q2WjOTEtXA6L62+WxA0IjMzhovUFcud6nG8pcHF0Wk0kc6Cr4/dkqI5wvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv1sQUMPKGdnY/IkkYNbf+FC60lh4lQEvG1dxEmiBa8=;
 b=EDqPARpbGCDXvl1IgBca6oy2GVMn9xf5YIs4P+o4l3/mMyPRDiBowF4chhdbwetmxnzRC+W4c4n1KhN//Jk6vG93mhK7NhXqVtGxWI4coIBdj5XICEJZXQSOXKYrAOOmq0pGpaIz7T1g1SsqcPwK8EOvs8F0hDVwqB3m9ZOXAFQ=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:30:29 +0000
Received: from DS1PEPF0000E659.namprd02.prod.outlook.com
 (2603:10b6:5:100:cafe::7e) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 20:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E659.mail.protection.outlook.com (10.167.18.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Wed, 4 Jan 2023 20:30:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 14:30:26 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cxl/mbox: Fix Payload Length check for Get Log command
Date:   Wed, 4 Jan 2023 21:29:54 +0100
Message-ID: <20230104202954.1163366-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E659:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: c9543e9d-a4c1-4355-20b3-08daee928535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqLGFa2Rq2ctrOhNHzrGiukN6Yjx8G/XqiK/MHyB626h5A8Bej3zMm/VKeGmnlHOXVX9RGSJaAq1zcnvhs0aaigATbAYIuNKqxfwwjxcQhi09NqFo9J7YpGSliCPGyD/KEy9nQBMF3//E9UcJUGNEzTtOIJB/z6A/u2R/iNavq4OoCela31xqQ092vY1SGahYhd4HQ7Zl22zPRLC8GOPHplUKXA84/HRh0/R2QF2DhgfF5p5PpSa/MysvGpJTO42VvuWbu/7onMMj3ddyd+OFhQo2ex2lkuMg6H2cv3oos93Qnu6MkZKT+sOVij1u/02Vk7Cg1u7tVFwvVuV1pgJ56HvWk73gR40iszpVD2B/xvTE/pGEscHpklO4VYUfQxBVLmYLGQJNyC97SSph/jjwAJamm8oCGdZT3EDiVqkJldQTF/QgOHrQzs9Ubl/wUZPw02igrCVmPmOsLWQ1FXCstwZcNA5Rv/qnr730Um64TOviDeqomNA8sGjxF/EG/BzpISJO7g3yDGT5v+I8PQou2MQ/uAZe22uoiY5Y3ZK8VZGSf3mKvZ7yf8NycxAsB3l7lViEs5EeaSpf67SiCArDI+1PFCoQrQQUXi4IbvTBlCwbNoHjU+BAFHqDsxcuqvWbldhTSEu9KgdR3pSzsdLTkSr5ByhTBWpsfJDb7Bne/vzJ3eXPmGNIAAdR74UzuUtKRkG0K6sFehfL1aXiGMe86o56sW7Cma8ywsweEyKFao=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(426003)(2616005)(186003)(82310400005)(16526019)(26005)(336012)(40480700001)(6666004)(40460700003)(36860700001)(36756003)(81166007)(356005)(1076003)(82740400003)(41300700001)(4326008)(8676002)(2906002)(5660300002)(8936002)(316002)(478600001)(110136005)(54906003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 20:30:29.3052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9543e9d-a4c1-4355-20b3-08daee928535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E659.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

The variable payload commands GET_LSA and SET_LSA could be also
affected by this strict check, but SET_LSA cannot be broken because
SET_LSA does not return an output payload, and GET_LSA never expects
short reads.

Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/mbox.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..e93df0d39022 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -170,6 +170,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	out_size = mbox_cmd->size_out;
 	min_out = mbox_cmd->min_out;
 	rc = cxlds->mbox_send(cxlds, mbox_cmd);
+	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))
+		return -ENXIO;
 	if (rc)
 		return rc;
 
@@ -576,6 +578,17 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
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
 
@@ -584,7 +597,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		offset += xfer_size;
 	}
 
-	return 0;
+	return offset;
 }
 
 /**
@@ -608,13 +621,11 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
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
 
@@ -695,11 +706,12 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
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
 
-- 
2.30.2

