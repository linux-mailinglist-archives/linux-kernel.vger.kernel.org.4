Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2B73BE74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFWScZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjFWSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F1272C;
        Fri, 23 Jun 2023 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJQ4vp2IyL81qApJFf3sVc+MqI9h5vyvx7jbj5AI1SJF23ooVSvCF7zgkSmLoiZDkl0p6OCkQjlPVTg1vsRBspiYb7mrMBGuwIrBgSWDnHlutqgx9yMn6iIu7d2x+lAJVclTEFdEQrawvvJHF52ZYWvrjbOuDzx8JTt74DCsjBTiq0O67TXMYVwNn2o9kpvJ17cWcWho6DTx9oHyPR6CWBY+P+IBM4fDNGmD6NFC7DCIgrY8LotZaI6OU3hYVtSBf2uDc18Dx0nbdI2AnuYugCjLt0Cpfq85XqPwsIL236/5EUftqvYKq4Rzp5FRW6q9a3eIcJA4k6T1f8d3pOfIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3Yypmip2TtWCDRgZCVF732sfv63Kv0948BfdGKrlts=;
 b=est/vjAElwCERd/eTz4cRbOP//MQyT3SCwcGWp4RUOq8sYIzr6CcugcK/C3WtEr5XYeNKtSLtXvgHojqzhwIQo2XKEfSh9DmnWUcOcxscXrxG3aN3odI2jzzFvUqSTJn5v3DH6UbjiySDQDFTIc+k2PSKcwOp2S/yzQ957gL+eekZ1itT5CsVMGz5XAVpSJNDHqajhooHica55IkaHRvZVizfBxIyrTFSoHclJuWbhyeGwyRp0cdcwjU+3BQ+/pDY5XduULxZ9sXhvJWbRki+jt5mWokp8ra/WVhz8wR0syuXJV36LychTynbT2nS/v4el++Pnz7GChw09Y02LAWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3Yypmip2TtWCDRgZCVF732sfv63Kv0948BfdGKrlts=;
 b=xs1VJggVAJv+W9JIi/q9ScTX1r18siJd2JXSGVcTq395JjJMdiQXC1N7o3L7QUzYb48dXWzvzwEk4ddCjpwkUoWvVzYpO0KPppwn+b85OkwTEWn4/V3SiRsUyPAMWBmi4dV3oo4ecBDC6hwWR5lYSQzUfrPs5sObMNmFiaDnc28=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:31:40 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::1a) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:39 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 08/11] crypto: ccp: Add a sample library for ioctl use
Date:   Fri, 23 Jun 2023 08:49:58 -0500
Message-ID: <20230623135001.18672-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0ddbf3-14e5-4195-1ca1-08db741815bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NetTSPy6lWI4s1BLI685jNcF3iI1ep0+5pv0sbGW5d0H291VHTiVm3rWGjMJLUzPeQeC20RXeB/yipTzq5CduCkh9UvkIP/SZJf5AdtEsqEM523wtEW5s5VXDTyuPD/9GaV7nN2LFCnXdICDe7mggwOt0Tpfmb+xijqybZhqxJfgRrOhcZv9ZqSJQet3rL1qdXIHj1MYeAQwpfzXzAh/0b0KR+Da3UND5JZbf05I3tTGm7uDZIojBaUjKJfH9M+/WGZOa4uekk+JAFpMz6CjcAjQ624Oe5RPUOUkq1os2H8iMkV87Vsx9DWeaoc4/NG47z0+FPQ4HqK1b+IQ5fcfwe8UaWRlj8gYT3PfJfBVOwPYLM5weIMBt8e+rSLqW29S9PWHKiK/fZNag6lktBP7TwaJ6vkUhWFS+n9dAaIYZ5p4GcplOO0jcR5hIXxlyAD2tYt4WY3GJNga3CXe7ACwCRTCc0bQwrpAnMZhvCR4/4poIFwN1TYlQexe464F2cyeOyqd8/+gsybg0fSPmIc26zU7BAaNLm4HSJFZrtfifkpukkoWCZNveVVAEdbHnjp4CcoGbO99JkHsDPe6gySslh+V1FVtDFUeZ/GNSueqQdqVxF4rD22eAqonai+dQsjrMgXEncXOVp+gHW2jx7J/wR07xjM2z05Lv7FTDWU+dl+/SwJ+i7JN0+nDJscB2ikeCHMXnK5evPkhhmE6wTtp3wFgGRUgfNKZBPCtC2r7PYYlhXMz3zFKSjTlVrKaK7iJO3HmZE76vVXz1wbvi1YcWYI3aCYAV4INnWzYwUcW6bw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(8936002)(5660300002)(44832011)(36860700001)(36756003)(8676002)(81166007)(356005)(82740400003)(2906002)(478600001)(6666004)(16526019)(186003)(40480700001)(110136005)(2616005)(54906003)(86362001)(82310400005)(26005)(7696005)(1076003)(70206006)(70586007)(47076005)(316002)(4326008)(426003)(336012)(41300700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:39.5275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0ddbf3-14e5-4195-1ca1-08db741815bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a small shared library that demonstrates the usage of the
IOCTL interface.  This library can be linked to but, is
intended to be loaded and used by higher level languages

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
v3->v4:
 * New patch
---
 tools/crypto/ccp/Makefile | 13 +++++++
 tools/crypto/ccp/dbc.c    | 72 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tools/crypto/ccp/Makefile
 create mode 100644 tools/crypto/ccp/dbc.c

diff --git a/tools/crypto/ccp/Makefile b/tools/crypto/ccp/Makefile
new file mode 100644
index 0000000000000..ae4a66d1558a1
--- /dev/null
+++ b/tools/crypto/ccp/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -D__EXPORTED_HEADERS__ -I../../../include/uapi -I../../../include
+
+TARGET = dbc_library.so
+
+all: $(TARGET)
+
+dbc_library.so: dbc.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $<
+	chmod -x $@
+
+clean:
+	$(RM) $(TARGET)
diff --git a/tools/crypto/ccp/dbc.c b/tools/crypto/ccp/dbc.c
new file mode 100644
index 0000000000000..37e813175642f
--- /dev/null
+++ b/tools/crypto/ccp/dbc.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure Processor Dynamic Boost Control sample library
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#include <assert.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+/* if uapi header isn't installed, this might not yet exist */
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+#include <linux/psp-dbc.h>
+
+int get_nonce(int fd, void *nonce_out, void *signature)
+{
+	struct dbc_user_nonce tmp = {
+		.auth_needed = !!signature,
+	};
+	int ret;
+
+	assert(nonce_out);
+
+	if (signature)
+		memcpy(tmp.signature, signature, sizeof(tmp.signature));
+
+	ret = ioctl(fd, DBCIOCNONCE, &tmp);
+	if (ret)
+		return ret;
+	memcpy(nonce_out, tmp.nonce, sizeof(tmp.nonce));
+
+	return 0;
+}
+
+int set_uid(int fd, __u8 *uid, __u8 *signature)
+{
+	struct dbc_user_setuid tmp;
+
+	assert(uid);
+	assert(signature);
+
+	memcpy(tmp.uid, uid, sizeof(tmp.uid));
+	memcpy(tmp.signature, signature, sizeof(tmp.signature));
+
+	return ioctl(fd, DBCIOCUID, &tmp);
+}
+
+int process_param(int fd, int msg_index, __u8 *signature, int *data)
+{
+	struct dbc_user_param tmp = {
+		.msg_index = msg_index,
+		.param = *data,
+	};
+	int ret;
+
+	assert(signature);
+	assert(data);
+
+	memcpy(tmp.signature, signature, sizeof(tmp.signature));
+
+	ret = ioctl(fd, DBCIOCPARAM, &tmp);
+	if (ret)
+		return ret;
+
+	*data = tmp.param;
+	return 0;
+}
-- 
2.34.1

