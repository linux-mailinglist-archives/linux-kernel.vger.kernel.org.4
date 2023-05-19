Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A041709E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjESRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjESR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7010F5;
        Fri, 19 May 2023 10:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+VuWDSdQLhBh53ge00NzEXfKz+5YxR5AuAKoTXQxkXkPyv4t5gvHPjeshzaXuerwVfnLKjgHUvL4MSmKweqUGIsOtnF9oeuGZDj9sGIj3qJBDSXwjCz4iEWmProehYr8pTyxPEzUK1ENRIzcRpjHA6X87ieyowoGOmCqX9KEaHU4BCLXsVZwZKpU7yGqwEUBTa0Nm/2pvjqbFfJb/WJGIZY27t6qTS91V4daY3uKBYazdhXKBwW1TEaBz6533xafI5VWpjiNdixbDRfw2RqM71rE2tr5mqQJ1Ajge9i+GtnS++m5dQM3ZXaGo4vPwAcIlglcbdli0wPlN2s+8diBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ2R7p1+EheZHnyiiVN2R3UsfUXuzN8/4nby8MGswZg=;
 b=ZmILaaoN1oSIFfqHMNiLhiGJFNS2T69O/cpDIdpAw4PTIJVwMD+B8wlJtGGlsuSTKZSDU3sgsyPaxRhG0L+d61UhVUKitwVaRxq7i3ARA/Qe/+apJhiQ9yc7lKyKbODmsFFSW4rCFMQI2SWEZ+RR6lVRO9iqiEr7cQvIY7yNVgMhHkh0UB0NHnGfomPMCaBUpOQQpwXMszvPslJISpEfhBoL3+rt8dSgRq+RCd+e4SYYFNUKlcR+CNUG/b1L+mVkUUGli5JVGLNuBr536/g5tlgz6jEHCOaIPNaBgyJsZR7aWA2E9xbd0kS4fFSfHboxwb4tmj0s2e5p8gTSaerGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ2R7p1+EheZHnyiiVN2R3UsfUXuzN8/4nby8MGswZg=;
 b=glxFIvHwQqLoqDYDg9iTHVLz6NIHLSy5NjJe1uM19gPgKpi6+7trE04ml1xnCCLZr5hU/Au9aUO6om0yGJ8gJkAuIX1f8zI9oe7pEWEXvGcCqnjzLs65k8YAVI3J0ssZ/0hsTaAXtieNuiKl+TfD/HE77Xd+5wbECmKONDBgd1g=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:29:08 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::a7) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7 via Frontend
 Transport; Fri, 19 May 2023 17:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:08 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 08/10] crypto: ccp: Add a sample script for Dynamic Boost Control
Date:   Thu, 18 May 2023 22:24:46 -0500
Message-ID: <20230519032448.94279-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: aff85af8-8230-4d5a-a965-08db588e8d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVc98Np0Dt3Agp2ph3WPy1MPP+RXbi1gas5OyErY6SEY8S5du0CzSXedhLm5w8ilrHhj8oHXJbGi5c3xY+cBA94AwT+shLKOrdc9bPhY67czt00lrxa83Ew4/0s6fma70/AqgqqgYr5WeBU4vaG8iByNg7EsSLahGz3XeqZ1BLXDgdFi50gcYvFu898exGioyvsGIEM2OCFrFuxIseHWovmrUyzbABTus2HiT7+Y7bCCWrJUVHLFFaa+Lq6+aIkJMbLZMDbrWnPV7evVxXFTkfbZSHq2rgd+uvxX69LRMAr6xOApaHlEf3ykPF/EOeULqXQjaWGxXA8x69uZ25117fNXz8Du5QCVBRSHRPgX5UmDAk+jwCn5KQmy6NU1OffcijR9zCKBOeC1/WjAfPl7/Ahy5dAJhsM01AgL65J+5vu3fUHbugzPs7pMNjxHcIRMQbX9PatYdWmDAG7ZzvTEsxFM6CJoGSqZ2AJWejmxYmp8vKAYJU2LCBXIYpCn7XKe276T+sZhLldwNrpf+s+Wd6+Zu7BgmBeoEprxCXmLAzixI4617TISKIF/zAYUoedRD3DszOiCbu9XYx3acwA9ouVR6qaVeoigbWPeV1pvxllKLMcVWYJE7RHqmB3ix3+wVU0YVxY9wP5chINOgknHkOSrqce7f8G4gES02zowwwXW5qrt/GnsJRyu19/1tgb6kKE/Eou3zv5viwxDGNfy5YWVWypgo0Ai4b/qUZE4zdPIkXt7B29B+bL8PIepW88OGGPIOorh/K1x8lbRFEOWXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(2906002)(16526019)(70586007)(70206006)(186003)(26005)(1076003)(54906003)(478600001)(36756003)(110136005)(40480700001)(40460700003)(6666004)(7696005)(356005)(81166007)(82310400005)(2616005)(47076005)(426003)(336012)(41300700001)(44832011)(36860700001)(83380400001)(8676002)(5660300002)(8936002)(82740400003)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:08.0439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff85af8-8230-4d5a-a965-08db588e8d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Boost Control is utilized by userspace with a collection
of 2 R/W IOCTLs and 1 W IOCTL. Userspace needs to prepare buffers
with the appropriate signature data and details of the request.

To allow rapid prototyping and testing this interface, add a python3
command line script that can validate the functionality of these
IOCTLs.

NOTE: This script does *not* generate signatures.  They will need to
be prepared separately and passed as arguments.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/.gitignore |   1 +
 tools/crypto/ccp/dbc.py     |  98 ++++++++++++++++++++++++++++
 tools/crypto/ccp/dbc_cli.py | 123 ++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
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
index 000000000000..f1b7342060b1
--- /dev/null
+++ b/tools/crypto/ccp/dbc.py
@@ -0,0 +1,98 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+
+from ioctl_opt import IOWR, IOW
+import ctypes
+import fcntl
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
+
+class _dbc_get_nonce(ctypes.Structure):
+    _fields_ = [
+        ("auth_needed", ctypes.c_uint32),
+        ("nonce", ctypes.c_uint8 * DBC_NONCE_SIZE),
+        ("signature", ctypes.c_uint8 * DBC_SIG_SIZE),
+    ]
+
+
+class _dbc_set_uid(ctypes.Structure):
+    _fields_ = [
+        ("uid", ctypes.c_uint8 * DBC_UID_SIZE),
+        ("signature", ctypes.c_uint8 * DBC_SIG_SIZE),
+    ]
+
+
+class _dbc_param(ctypes.Structure):
+    _fields_ = [
+        ("msg_index", ctypes.c_uint32),
+        ("parameter", ctypes.c_uint32),
+        ("signature", ctypes.c_uint8 * DBC_SIG_SIZE),
+    ]
+
+
+DBCIOCNONCE = IOWR(ord("D"), 0x01, _dbc_get_nonce)
+DBCIOCUID = IOW(ord("D"), 0x02, _dbc_set_uid)
+DBCIOCPARAM = IOWR(ord("D"), 0x03, _dbc_param)
+
+
+def get_nonce(device, signature):
+    nonce = _dbc_get_nonce()
+    if signature:
+        nonce.auth_needed = 1
+        tmp = ctypes.c_ubyte * len(signature)
+        nonce.signature = tmp.from_buffer_copy(bytes(signature, "ascii"))
+    result = fcntl.ioctl(device, DBCIOCNONCE, nonce, True)
+    if result < 0:
+        raise IOError(result)
+    return nonce
+
+
+def set_uid(device, new_uid, signature):
+    uid = _dbc_set_uid()
+    if not signature:
+        raise ValueError("Signature required")
+    if not new_uid:
+        raise ValueError("UID required")
+    tmp = ctypes.c_ubyte * len(signature)
+    tmp2 = ctypes.c_ubyte * len(new_uid)
+    uid.signature = tmp.from_buffer_copy(bytes(signature, "ascii"))
+    uid.uid = tmp2.from_buffer_copy(bytes(new_uid, "ascii"))
+    result = fcntl.ioctl(device, DBCIOCUID, uid, True)
+    if result < 0:
+        raise IOError(result)
+    return True
+
+
+def process_param(device, message, signature, data=None):
+    param = _dbc_param()
+    if not signature:
+        raise ValueError("Signature required")
+    if type(message) != tuple:
+        raise ValueError("Expected message tuple")
+    tmp = ctypes.c_ubyte * len(signature)
+    param.signature = tmp.from_buffer_copy(bytes(signature, "ascii"))
+    param.msg_index = message[0]
+    if data:
+        param.parameter = data
+    result = fcntl.ioctl(device, DBCIOCPARAM, param, True)
+    if result < 0:
+        raise IOError(result)
+    return param
diff --git a/tools/crypto/ccp/dbc_cli.py b/tools/crypto/ccp/dbc_cli.py
new file mode 100755
index 000000000000..2dbefc2b7ed3
--- /dev/null
+++ b/tools/crypto/ccp/dbc_cli.py
@@ -0,0 +1,123 @@
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
+    parser.add_argument("--signature", help="Signature for command")
+    parser.add_argument("--message", choices=messages.keys(), help="Message index")
+    parser.add_argument("--data", help="Argument to pass to message")
+    parser.add_argument("--uid", help="UID to pass")
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
+    if not os.path.exists(args.device):
+        raise IOError("Missing device {device}".format(device=args.device))
+    if args.signature and len(args.signature) != DBC_SIG_SIZE:
+        raise ValueError(
+            "Invalid signature length %d (expected %d)"
+            % (len(args.signature), DBC_SIG_SIZE)
+        )
+    if args.uid and len(args.uid) != DBC_UID_SIZE:
+        raise ValueError(
+            "Invalid UID length %d (expected %d)" % (len(args.uid), DBC_UID_SIZE)
+        )
+    if args.data:
+        try:
+            data = int(args.data, 10)
+        except ValueError:
+            data = int(args.data, 16)
+
+    with open(args.device) as d:
+        if args.command == "get-nonce":
+            try:
+                nonce = get_nonce(d, args.signature)
+                print("Nonce: %s" % _pretty_buffer(bytes(nonce.nonce)))
+            except OSError as e:
+                pretty_error(e.errno)
+        elif args.command == "set-uid":
+            try:
+                result = set_uid(d, args.uid, args.signature)
+                if result:
+                    print("Set UID")
+            except OSError as e:
+                pretty_error(e.errno)
+        elif args.command == "get-param":
+            if not args.message or args.message.startswith("set"):
+                raise ValueError("Invalid message %s" % args.message)
+            try:
+                param = process_param(d, messages[args.message], args.signature)
+                print(
+                    "Parameter: {par}, response signature {sig}".format(
+                        par=param.parameter,
+                        sig=_pretty_buffer(bytes(param.signature)),
+                    )
+                )
+            except OSError as e:
+                pretty_error(e.errno)
+        elif args.command == "set-param":
+            if not args.message or args.message.startswith("get"):
+                raise ValueError("Invalid message %s" % args.message)
+            try:
+                param = process_param(d, messages[args.message], args.signature, data)
+                print(
+                    "Parameter: {par}, response signature {sig}".format(
+                        par=param.parameter,
+                        sig=_pretty_buffer(bytes(param.signature)),
+                    )
+                )
+            except OSError as e:
+                pretty_error(e.errno)
-- 
2.34.1

