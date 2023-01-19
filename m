Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A167338A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjASIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjASIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:21:38 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D532654C1;
        Thu, 19 Jan 2023 00:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm6N0R0wwg9GK8+72ZW66J40zXZy7FQsxgVy1t7NBs4aKJu3Cf7GHPioos9e6KpQ3lOYkjmVOBnm605jaBwIfx78WA5EyXXCO+A0MfPhIskhIfvZapleTIBdrdlaxIt4DIFXxpImTtN7qkXtw8XEMdmSSMC5Ek6E2Hw/vG5VU2Ak4MospiVKvc0x3UN7vsfSL/vb3zdi12EGXndnar0r0KBe4uD7SEtLbchLBNSfz3FwsqoKcwiG4msrmiYj0Mi3WjIJekn034dQVLox0/9J/36ncP3AcGDY++JCrb2YWCaSNwORIyEtpw3vwvQSLvNVDKo/+OPc3Vzp5/F7ee7/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i5tzL6N4mKhgQeh2EiX4+nLLBN1fmo2IWKz502BQe4=;
 b=HE92pdno2oz8l565R8Ue67PjkwqUHOYHrY7mnD/V0edKnrb1bc2pHJNhV2PKTvJxjRXNHii3OXrbzJKWaLaSvoztQtM2PgFOC9LrTMLjAtlUpcumv2/iTWan4xfh/B392qzfvcsRv/P1KeU7pYK2YAY9ozzjvzNCRy79XY4kuZ1ji82q36anVDimmEi2AjdS3nfL+buoibPy88msXstdXdDI0Hoqubs2ZJpiO3NXXUHSICb1BlU1540JQeylswKnE+hE0cTBxmP5l6C2zGcFWjFwk8pbrYL1mMIsdfdkROKwHUTshBunW+GG2itBPNWbYwqzDk0xpUIhjYBEMgtlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i5tzL6N4mKhgQeh2EiX4+nLLBN1fmo2IWKz502BQe4=;
 b=2j7Di2uriiDXaOjOe94yNyYgKgwhhOepQmhzeytbJmC2P5IMpapAdMjJpmKQ+UJ8APQo5WgHSmc3Is1VT5SYSgBn96f90z7iXpsCX6IJHBaBE0qtNvgWHu+wjhK85n/ObOA4szriKuuNGuT/RvzMHxJAQoFPP7D3MAgIFfag6ag=
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Thu, 19 Jan 2023 08:21:32 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::aa) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Thu, 19 Jan 2023 08:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 08:21:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 02:21:29 -0600
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
Subject: [PATCH v3] cxl/mbox: Fix Payload Length check for Get Log command
Date:   Thu, 19 Jan 2023 09:20:53 +0100
Message-ID: <20230119082054.80550-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: e08f5a57-d3d4-4ccf-2175-08daf9f62c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIybUPksYAEUEzZlj7/G8z1YMawU1AqBpCw0qSyD/k2n8MQ9zDeoLiRiPNc3gMwx2GwTUX/pRFgBLm7uSWNXh2WKi68FjYDMlRJ8ZWzcomO09rUrOly62H5VeVsT7eADRkXNgL9yg/BMmoOUxU08XTB0i8InDYmtUmdPCtuuiWbIAfkTfbU+oTEeFHR5x/fp3EptyPOq3goMBgRb8wm8BeI/UyjpkCAxFqTfVxvYy1pp01bvm3drEeNLL19y1S5CAOjiPgVd+dizT2njLnOkN3brY2Two6rLG5k8SDof6QIMKlcBMKR8T1vwAVPdslfIVJV3dRc6WCq7eE9NlacMPh0+DhIs+droc+D0lU8aPVMVg7/KzlYi9oX5UYPv69LFxdmk3S/fqdHzyvoB/wp0hJ18L3yjQhnzFhdZu+K5a7H0nYXPNrWSTPWUOUncS6ig+hE4bPMU29TTgcO7osmVAsf4OpCI3EqsOazTSFVXQCXrCMiibaUk4ewpXNn60DHfn/e6qfenqB18ndc+z9oViMJi4aXwIcTqLfwkRn/DdpLuCk5qBfrWBo25+ZxFT7zerFhYkP6mza5LnqNjL15G9vMk68aRrrB0DWeohrxp6PfbqmceEZNmkYUxWIgw2RCsTZ3Zh0xKO3guMhpQftGwrXcuicHtdqwWzuUkfs+3TcH0KfJiKEEt5TiCqHu+wG1nZ9KCX8MEcnrG/Lyo0bBjz+rxfp128urpqzxnY65I/hA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(1076003)(70586007)(336012)(110136005)(2906002)(316002)(41300700001)(83380400001)(8936002)(4326008)(8676002)(47076005)(6666004)(5660300002)(426003)(36860700001)(36756003)(16526019)(2616005)(82310400005)(81166007)(186003)(82740400003)(54906003)(478600001)(26005)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 08:21:32.1410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08f5a57-d3d4-4ccf-2175-08daf9f62c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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
v3:
 * Added comment to the WARN_ONCE(). (Jonathan)
 * Passing a size pointer to report the payload size back. (Jonathan)
 * Moved logging of supported opcodes out of this patch for a separate
   change. (Jonathan)

 drivers/cxl/core/mbox.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..395a96a3c696 100644
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
 
@@ -550,7 +556,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	return 0;
 }
 
-static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
+static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8 *out)
 {
 	u32 remaining = size;
 	u32 offset = 0;
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

