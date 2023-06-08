Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67587287DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjFHTNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjFHTMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6E9D;
        Thu,  8 Jun 2023 12:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrt7GJNyF6DqyMklqSzL4KmOJuEZHqAMW6ikhVeD8z73FGnOi54WfYsTLbKzZvDRB3+kfx9ibLvJW6tdi+OMCVDBQOUGPYneNY1ri7ruXuHshpfjCzOoAXbgTtMf/El7h4jkkuV0aMTuPEpekNlCmlR8kfBGW8sg5LhWfsb+slZOiSGKzg++4UgKezGis5STWBN11De7QX3gmExZDJDMCQYak6DojUI+HMBJOIy3CrKJZcYDP830RqR4PnnnloYnm5gQc0lW5OH69fC8YS0ddbLX/in7wmSyjRhEQcaGuTj8Olec84qxvJmR3bcVb0BcdUY3rSMLz3O40AhACjBsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dOqqACfUJwO/by3O4wOEYvyIoycNd43moItLDSn8b4=;
 b=jtw44Vqqixdc90N1qck+ByUIMl4dDfPvrYriKXhLGaz3DLG1toZOkuVZFzr5hTipv908RZNEfEV9LcEuNhPv212DRR+sMToCqBpzBXVTjCkDQKEC75SwfDQIqP3c4mi3fIuEQiKjp2lQGt+j1UAJKJ3/yVU1Tjy2142rqDXGjMUB4c1poMhIo0xklKcIa+1L/ykSeYkyLCc/8miQe3W1sFaTUjCQtroNBG9U7YtyeshtiAkbBFiZGWwnWA5KYbZCk6iBhgBfkN4fINgBpv783UJPGYua3uw0bQy5dRUqH72hnMFqg2HQzZRQYmitvgWnwj/FYHG5MPovimCic4EDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dOqqACfUJwO/by3O4wOEYvyIoycNd43moItLDSn8b4=;
 b=EqDrln5D5wLuxdXQn19cIGSr4WYMz+2cbprNjlkfL3oz8s6EL0tOYZCP3FwNGjkxl/mqQAXYoWLsOJedS4V+wcsXxmg9Df4dcAcarhY1upvWpl/bZ1l8hidWeKDPd5z0BWuifAygW73Q/lLmCqw4NQ61qx+k5NhvzcjYSxepAqQ=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Thu, 8 Jun
 2023 19:12:33 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::3e) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:33 +0000
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
Subject: [PATCH v4 09/11] crypto: ccp: Add a sample python script for Dynamic Boost Control
Date:   Thu, 8 Jun 2023 06:17:55 -0500
Message-ID: <20230608111757.32054-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aed490e-ee96-47ba-28a7-08db68545001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhV1349TkqclRNzvLOKJ6v4YKCIUObSfGfsNnCBBOgsTBp668wWgcaeWWXAL34ijXaM0kMJ+6HzMIItzvJKSY6pit8nVOgtwWeW6RqrQvmvB/y50kJLhWCaFmvHtXO+/vasFBxMH9LoVJoflZCFvWzrACpDway6zNO6ChbHA6iIWpPJ2pktnxxsx1f3neJrOUA7VTrZ0ykMqRl9azW3SpDfK7Qj6saXBh++10aS17Il1xqr31T4AohS3+keUWtPG5r0OtBEJuZBknxcFgbqYQaMcp+nm2fVynz1y1TJe/VIIPfL7lZBa1eepvu614SCSbAoPxo5EtnKB9ml5EmfBHKus9Xtm4teSoyhLOGL/wNE7U9R/wDWWtYoZ++gRcU2L7NgPRXpO/RbxQ8mNOii0QqmeWGVtqtdlJfiORwVoz9HKRHwtMh92n6idTiVxNS+doCdJJ4obDNmUBtOQZzgtiXsoVXwxGIIZCuv+Un7Au3Y8T2ePRNRedA1z0ZYKZF9j367f74Q56D1KT+e4nxNeYnlCvkIINShafnKc4GKRF/CmswNwNCu2RHQeWS1NnbhfJDcNN5XSlRHAfAa2OTAWDlV9LYNxcmaKTmNUmawrsMULbnlux3IfKVjQFGr2jM27v9OemPraFF3uwJXIQoAp0Pi/HUCrzoa14At21M4iChr9jUIOf7JVm8+w+q+/TL5xjac5WQEX6r4wS3Jf64c8x/2h+kaVVn3HJ6W5VqVQYGZYSMzB1RI0Lbj/490SRG+/jsfiMZvjKMGr1b1UmCHBCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(47076005)(1076003)(26005)(2616005)(83380400001)(41300700001)(6666004)(16526019)(7696005)(186003)(426003)(36860700001)(336012)(40460700003)(4326008)(478600001)(110136005)(54906003)(40480700001)(82310400005)(316002)(356005)(5660300002)(70206006)(70586007)(82740400003)(81166007)(8676002)(44832011)(8936002)(2906002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:33.0445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aed490e-ee96-47ba-28a7-08db68545001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
index 000000000000..bee8a64b79a9
--- /dev/null
+++ b/tools/crypto/ccp/.gitignore
@@ -0,0 +1 @@
+__pycache__
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
new file mode 100644
index 000000000000..3f6a825ffc9e
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
index 000000000000..97b20553a676
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
+    "get-fmax-min": PARAM_GET_FMAX_MAX,
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

