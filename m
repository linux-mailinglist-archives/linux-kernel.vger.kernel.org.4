Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8C7287D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjFHTNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjFHTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B274D30C4;
        Thu,  8 Jun 2023 12:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy6AomcSYowXMmQ+DSChsD7v+wAsfb7Iyj8L1NHm3OMFssbXBc6hijN61aEmE8aIJAh0LExD+jXT4wAxrewc83ogc1Dg6eCB/LgnU0rxQaI3+vckaz+kLDNLpKu/vv7AbcJKyKE8VeQH7DVHe+CRZY3cZ4m8p6sDKaawyvvzNra13rAa7b1Oo3YOsqKMz0EK5aC9R8fJF6wg2euFGQOxY3NC8ysgohtSdI8jdlOmudcRodkCol06O/+6dMxGNEO0s1YOU582g0G5tpLU8E6cwK8TvmNgGrTLWF2GZBPJ0rwonRpv/Wc80+BzeHougr3C28/Z7AMsdgZU/F01hxBdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fWtlEw/qV1KAfjJmylo84c8MbGkwhO7fFEruXnluLQ=;
 b=atR/7eSx2ldF/uSukGm5r1I8QnYFitzJPYwWDk/92ARSglqCfBFxIKhJ/qxGs+zSyby15wCHbZ+255HkCxSpB89NGDb7ZRW+JVAh418rcOZC8ThvDgQvmREQhZzEh4K5mj8Nsr5oscwSG8ctDcWpWr9sPezYGn8tIlmJgwt8GMYwwwH3PwKrfinuqvq2P3x+E66GUY4XKAuSGsAzdPK2AOAmKpl25B57n52yPeJspm8J1OfhFAPThskHYiQZo/wP+CuSv0TZGZMAl8p0murjTlDm0Xi7LsGPanBjp9l4mI0YQXAPJxjYGw6wF6NjTS/OldmzENV9ovn10jI2HK5orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fWtlEw/qV1KAfjJmylo84c8MbGkwhO7fFEruXnluLQ=;
 b=jcB/t8qPTgGUjlmaGGCk2qw6z37u63b2AxnnYiXJnCugUFx8W8zcmOiip1SRGGGel80eoJiL8pA5q6R5KXjSn34Krzy4fmZypUcrnevLmFBdiAbUEufXtmvwnZpoY/eDQZ/cuud9Ai+pJfUqHyo5PcN/SypUTiXZrF2I0TR0NLY=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 19:12:32 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::e0) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:28 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 08/11] crypto: ccp: Add a sample library for ioctl use
Date:   Thu, 8 Jun 2023 06:17:54 -0500
Message-ID: <20230608111757.32054-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: d6085949-ef7d-4020-7cbf-08db68544f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raPAFcc4wYRvyC1vrl7Hzo79FM0mDESkeM+P88HOvc+gkLKRhBsc2hWEOmdSpRz0hE3lj/dbyIS5lT6mBqJZ8Bf1yM0RaEC5C4MQzu99Zmz+GRYyhdMrRth7C8Lry4GBC7SA3Ku/JWHwN+HzFKcTC7eYe9H3aeK2MQDImN7xzbl+Fn4d0g74QyydxntduxI6MF9wWwlk6pa4iaGCefvZI4I7VqksKLzOXqamaESLp6dTYV+daaIC3KO12VGhdC+fOPVzffuLgBZE42bvX5XVYczpuGA383RoKQigNXw79au5KPiS03mwroTL8+MTSBpbYrfXK2m7E3uYE9ad1Z+LI4HxY4WcYHlLD12zq8HVvMhQrXcRdMoNBknAAzyq7MpbA0d8a7CQHkU+akJFv1xft5metYx3mvVhnDqIlybF5zVbqcAOzx4rUEs64a74PtunG5pQz3p3TE9rQFHMwklZbUTx8ZL7LWLzRlxag9omtnA9XmhZKRZCpm14LZBy4RTtOjRdEvIyE8ZvsaYZS9vn48E9UywWMGr8d92fxcgw7LOxqpBG7ftN5GvT2ulqF0SidHYnA0wurv72Z7NzdEiTIceDe+Cc3oqw7ofmzJav5+dRc6BKGcxql0q7x0vwSCt03hvZUkowZmOTe9/m6dY4tA8auofftznqCXNdasx/2KmRQ3+MJEHgN/glyW1Ci5mJAiCNFfWq9Thd9mvEZi2eJ21TL94kIaBhXGfsSHjXQFTzE4Z2zpofU2/3qrUr4VRgjoVXnzElvUBdzee0tjPGEnkfHS5ORN2PKTwqhDGCsAc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(426003)(336012)(110136005)(44832011)(82740400003)(54906003)(40480700001)(478600001)(8676002)(8936002)(41300700001)(70206006)(70586007)(356005)(81166007)(316002)(5660300002)(4326008)(86362001)(40460700003)(6666004)(7696005)(36756003)(2906002)(82310400005)(36860700001)(16526019)(186003)(1076003)(26005)(2616005)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:32.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6085949-ef7d-4020-7cbf-08db68544f93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a small shared library that demonstrates the usage of the
IOCTL interface.  This library can be linked to but, is
intended to be loaded and used by higher level languages

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
index 000000000000..ae4a66d1558a
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
index 000000000000..37e813175642
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

