Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127973BE75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFWSc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjFWSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96352726;
        Fri, 23 Jun 2023 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzZuqcrTr8a6z51u23N61zS2qzby0yfPE2icT1v1g8BWWBma93OX75HBE7QV1HXX0nj3qp9Ty2X4hVHcIneGymkPvXIESWVWY9/AAPxuGKUaRDQ5DzF9w4fczLjOvbJwgIrouy3BAbAFAxl0eI2Y2TsMnaSnvJwiaNjV+m/BG+sfB379AxrqkNtYunD4erm3fWgimNlPDwzKNN4/v/kKT8ASG6egsYtBRJkBLk2wU10xKnCH1QoKzE7IU7MBF4ByjCGENztoqEYTQGDpAK9a9RgCkbFcdsx0izmKLVO2DVKrYYbnDhZYKd6+wVyWHg7FcyVHyPmEwlEWpekCoGI7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFwlNvtUXHTcR5sspekqsjsKgKPTL3b708AnLTSeL2o=;
 b=iqHmQpI65DEFSj/3vzQCMaj5LKimzwDxHk7LBDass5Xni5ExZmR0lXkkSCQC3thRrpMyrsHkeeJd7whPXxIA2rcvkTCEsvbBLVUA2uqmdQwSIBo1nVDrarvoL4dy0SAEy8QHaSf3zjC9tCf4TiyBIa+rl3s1RDCEuX24P+hqPp16mT9ISMwAYPEUCn1rfFQZjjcYX6efFKAVEFp8BvpaAYHytsuK++HbRexupBzLnuoDNBHtYF+04gRiTnmm8z+roRh24AfZatXaZkT/W4NYsLYOmgKOraFFhHyUh7h+Ul+Wd83lfcH3N64on/9Ftt9l8YhIo48beL/oD1k2gnj0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFwlNvtUXHTcR5sspekqsjsKgKPTL3b708AnLTSeL2o=;
 b=OKn+zy6smyAZ/cPAl5lX68tnfmarWFx8/ZM3kkc6o3TzQXmSJ5Higeb/C/+M01TxMlBgrNknhFZymwYo3xjhVFQXc/UaegiWFHrILs1Lvp5QyW+1r2hNrPq/5Ug0LyBCu4nhJNF2lKRjAaxJTQpLIlUtAD40mVeuG4/SWEXGTBw=
Received: from BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::24)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 18:31:40 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::f8) by BL1P221CA0009.outlook.office365.com
 (2603:10b6:208:2c5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:40 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:38 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 09/11] crypto: ccp: Add a sample python script for Dynamic Boost Control
Date:   Fri, 23 Jun 2023 08:49:59 -0500
Message-ID: <20230623135001.18672-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3432121a-9b21-4a4d-6544-08db74181646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcIrE+hpIKmON3y75+vJaxxl33WpgmvJBgtb+bSE0MxpmqcCG47rcTFqOvbb/TM4HaXj/mXyopjLJg7JaVGt+ZK/Q5hJLI3SdzsSSk3xxn8ND+rGY2k2DHeay1yAoNqpW3gD06w7QlD4bjscp1osH7OSFt8tYDI4sUMX12q06fXU3pDHYWa/WmybLzkWUUx/WzmXmD9YAFEd+15Seje+fIJr7ETQBSLpVfuhw0Hrrf9M2Uu0q6717WOnvmmdPiUBJmroxymNGZ132aulU8naVQpDk19MjUQAxKA9Kqs7lXQfnv43n95ycjuDwRv0A+93rGOcTRqHQleoOulCrQ1853PJ90ke5GgJwMH0HnKZpoGxw63W4zNuSdJ7tkKhS93+6fDhZWGUtkCPSTRyT+fJB4eWfAmRo3AN7rzsxUK9ZvgbMSuqi0Tg7RsnUjqQdvLWj94hjxwBMc90XvCFvwgkumP6FU2EGpcBqDLfCyHSlYMIpzdKJhlLEZCYcA61IaPoDewQxA9NHmG9ke82x+cSHvQz1JsJia/kTWINX1PrnU/YeST8Sa5fzzsO35AbS79QOwxzXvdIIVeTcQoe7D8+T+pORPrHra7WEVgjmTXtvWCvz1cAuG9a+EFiNmPv7rlNJug/QyZHZjOYn/efnNg0xiAWWXiluJARDzU97zK3hBMKU5ScQ8sXD3KsJdlyETJImx6KaWTJuU7USzcydwEceNao6/cVjjSWg0kzsUuKRjeFEJwsCu5eOH3fpQ5tLjUDq7L09QdfbfaUG3HUuosAMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(186003)(16526019)(26005)(1076003)(2616005)(83380400001)(336012)(54906003)(82740400003)(426003)(7696005)(82310400005)(2906002)(478600001)(36860700001)(47076005)(36756003)(6666004)(110136005)(40480700001)(44832011)(70586007)(70206006)(316002)(5660300002)(8676002)(4326008)(41300700001)(81166007)(40460700003)(356005)(8936002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:40.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3432121a-9b21-4a4d-6544-08db74181646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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

Dynamic Boost Control commands are triggered by userspace with
an IOCTL interface that userspace will prepare proper buffers
for a request.

To allow prototyping and testing this interface, add a python3
command line script that loads the dbc_library.so for utilizing
the IOCTLs.

The signature to use and UID are passed as arguments to this script.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Fix the `get-fmax-min` message which was accidentally checking
   `PARAM_GET_FMAX_MAX`
 * Pick up tag
v3->v4:
 * Use library from previous patch instead of python's ioctl interface
---
 tools/crypto/ccp/.gitignore |   1 +
 tools/crypto/ccp/dbc.py     |  64 +++++++++++++++++
 tools/crypto/ccp/dbc_cli.py | 134 ++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 tools/crypto/ccp/.gitignore
 create mode 100644 tools/crypto/ccp/dbc.py
 create mode 100755 tools/crypto/ccp/dbc_cli.py

diff --git a/tools/crypto/ccp/.gitignore b/tools/crypto/ccp/.gitignore
new file mode 100644
index 0000000000000..bee8a64b79a99
--- /dev/null
+++ b/tools/crypto/ccp/.gitignore
@@ -0,0 +1 @@
+__pycache__
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
new file mode 100644
index 0000000000000..3f6a825ffc9e4
--- /dev/null
+++ b/tools/crypto/ccp/dbc.py
@@ -0,0 +1,64 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+
+import ctypes
+import os
+
+DBC_UID_SIZE = 16
+DBC_NONCE_SIZE = 16
+DBC_SIG_SIZE = 32
+
+PARAM_GET_FMAX_CAP = (0x3,)
+PARAM_SET_FMAX_CAP = (0x4,)
+PARAM_GET_PWR_CAP = (0x5,)
+PARAM_SET_PWR_CAP = (0x6,)
+PARAM_GET_GFX_MODE = (0x7,)
+PARAM_SET_GFX_MODE = (0x8,)
+PARAM_GET_CURR_TEMP = (0x9,)
+PARAM_GET_FMAX_MAX = (0xA,)
+PARAM_GET_FMAX_MIN = (0xB,)
+PARAM_GET_SOC_PWR_MAX = (0xC,)
+PARAM_GET_SOC_PWR_MIN = (0xD,)
+PARAM_GET_SOC_PWR_CUR = (0xE,)
+
+DEVICE_NODE = "/dev/dbc"
+
+lib = ctypes.CDLL("./dbc_library.so", mode=ctypes.RTLD_GLOBAL)
+
+
+def handle_error(code):
+    val = code * -1
+    raise OSError(val, os.strerror(val))
+
+
+def get_nonce(device, signature):
+    if not device:
+        raise ValueError("Device required")
+    buf = ctypes.create_string_buffer(DBC_NONCE_SIZE)
+    ret = lib.get_nonce(device.fileno(), ctypes.byref(buf), signature)
+    if ret:
+        handle_error(ret)
+    return buf.value
+
+
+def set_uid(device, new_uid, signature):
+    if not signature:
+        raise ValueError("Signature required")
+    if not new_uid:
+        raise ValueError("UID required")
+    ret = lib.set_uid(device.fileno(), new_uid, signature)
+    if ret:
+        handle_error(ret)
+    return True
+
+
+def process_param(device, message, signature, data=None):
+    if not signature:
+        raise ValueError("Signature required")
+    if type(message) != tuple:
+        raise ValueError("Expected message tuple")
+    arg = ctypes.c_int(data if data else 0)
+    ret = lib.process_param(device.fileno(), message[0], signature, ctypes.pointer(arg))
+    if ret:
+        handle_error(ret)
+    return arg, signature
diff --git a/tools/crypto/ccp/dbc_cli.py b/tools/crypto/ccp/dbc_cli.py
new file mode 100755
index 0000000000000..bf52233fd0380
--- /dev/null
+++ b/tools/crypto/ccp/dbc_cli.py
@@ -0,0 +1,134 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+import argparse
+import binascii
+import os
+import errno
+from dbc import *
+
+ERRORS = {
+    errno.EACCES: "Access is denied",
+    errno.E2BIG: "Excess data provided",
+    errno.EINVAL: "Bad parameters",
+    errno.EAGAIN: "Bad state",
+    errno.ENOENT: "Not implemented or message failure",
+    errno.EBUSY: "Busy",
+    errno.ENFILE: "Overflow",
+    errno.EPERM: "Signature invalid",
+}
+
+messages = {
+    "get-fmax-cap": PARAM_GET_FMAX_CAP,
+    "set-fmax-cap": PARAM_SET_FMAX_CAP,
+    "get-power-cap": PARAM_GET_PWR_CAP,
+    "set-power-cap": PARAM_SET_PWR_CAP,
+    "get-graphics-mode": PARAM_GET_GFX_MODE,
+    "set-graphics-mode": PARAM_SET_GFX_MODE,
+    "get-current-temp": PARAM_GET_CURR_TEMP,
+    "get-fmax-max": PARAM_GET_FMAX_MAX,
+    "get-fmax-min": PARAM_GET_FMAX_MIN,
+    "get-soc-power-max": PARAM_GET_SOC_PWR_MAX,
+    "get-soc-power-min": PARAM_GET_SOC_PWR_MIN,
+    "get-soc-power-cur": PARAM_GET_SOC_PWR_CUR,
+}
+
+
+def _pretty_buffer(ba):
+    return str(binascii.hexlify(ba, " "))
+
+
+def parse_args():
+    parser = argparse.ArgumentParser(
+        description="Dynamic Boost control command line interface"
+    )
+    parser.add_argument(
+        "command",
+        choices=["get-nonce", "get-param", "set-param", "set-uid"],
+        help="Command to send",
+    )
+    parser.add_argument("--device", default="/dev/dbc", help="Device to operate")
+    parser.add_argument("--signature", help="File containing signature for command")
+    parser.add_argument("--message", choices=messages.keys(), help="Message index")
+    parser.add_argument("--data", help="Argument to pass to message")
+    parser.add_argument("--uid", help="File containing UID to pass")
+    return parser.parse_args()
+
+
+def pretty_error(code):
+    if code in ERRORS:
+        print(ERRORS[code])
+    else:
+        print("failed with return code %d" % code)
+
+
+if __name__ == "__main__":
+    args = parse_args()
+    data = 0
+    sig = None
+    uid = None
+    if not os.path.exists(args.device):
+        raise IOError("Missing device {device}".format(device=args.device))
+    if args.signature:
+        if not os.path.exists(args.signature):
+            raise ValueError("Invalid signature file %s" % args.signature)
+        with open(args.signature, "rb") as f:
+            sig = f.read()
+        if len(sig) != DBC_SIG_SIZE:
+            raise ValueError(
+                "Invalid signature length %d (expected %d)" % (len(sig), DBC_SIG_SIZE)
+            )
+    if args.uid:
+        if not os.path.exists(args.uid):
+            raise ValueError("Invalid uid file %s" % args.uid)
+        with open(args.uid, "rb") as f:
+            uid = f.read()
+        if len(uid) != DBC_UID_SIZE:
+            raise ValueError(
+                "Invalid UID length %d (expected %d)" % (len(uid), DBC_UID_SIZE)
+            )
+    if args.data:
+        try:
+            data = int(args.data, 10)
+        except ValueError:
+            data = int(args.data, 16)
+
+    with open(args.device) as d:
+        if args.command == "get-nonce":
+            try:
+                nonce = get_nonce(d, sig)
+                print("Nonce: %s" % _pretty_buffer(bytes(nonce)))
+            except OSError as e:
+                pretty_error(e.errno)
+        elif args.command == "set-uid":
+            try:
+                result = set_uid(d, uid, sig)
+                if result:
+                    print("Set UID")
+            except OSError as e:
+                pretty_error(e.errno)
+        elif args.command == "get-param":
+            if not args.message or args.message.startswith("set"):
+                raise ValueError("Invalid message %s" % args.message)
+            try:
+                param, signature = process_param(d, messages[args.message], sig)
+                print(
+                    "Parameter: {par}, response signature {sig}".format(
+                        par=param,
+                        sig=_pretty_buffer(bytes(signature)),
+                    )
+                )
+            except OSError as e:
+                pretty_error(e.errno)
+        elif args.command == "set-param":
+            if not args.message or args.message.startswith("get"):
+                raise ValueError("Invalid message %s" % args.message)
+            try:
+                param, signature = process_param(d, messages[args.message], sig, data)
+                print(
+                    "Parameter: {par}, response signature {sig}".format(
+                        par=param,
+                        sig=_pretty_buffer(bytes(signature)),
+                    )
+                )
+            except OSError as e:
+                pretty_error(e.errno)
-- 
2.34.1

