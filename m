Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0786F1E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbjD1S44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbjD1S4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C694B6A5E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exjIg+g5CFc0DNuL/KUOZObTLr2itsr/B1HaJsWcwyUp0r5z6TLQwWtY6Hs8lVqG2ih0Ccl4vUkftPyYJ494ucm3e1ssQcAzWyZtFpEqObrrCDK1vZrWSPPIwvDdStvCVd749ORpoXplOslZA4E2dJ2dBKjPlgSi4ORWut/vckRAV0B6eVO2wRTAQ2NsKR4z6bbcl1pozE6/+WcAy1SEwnsuaHFBNxR20lGQXs6iCwkfh8IIxhH1mNW3Jp75cVMDTiP2dkl5hcsbTj74liJnKlCdaTc9n3YRr33Cy0UuCRvizNJjaBb13AK92lVUCen04p03ejRdWfvbVN6IP5Hndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ2R7p1+EheZHnyiiVN2R3UsfUXuzN8/4nby8MGswZg=;
 b=eeUK7lDdemklkzV32asHZuC+YIoY9L9NfswMziBYpU6+sIbg+ji42hpcX3zegcsh0NbpqGDuqeoXl/a1N2/2oMGiWUzcDTlX7KQKedMcYnZE7w91DEoW13QiXRa/e3Wi9rxZwj1zwRyE5VgLphXUS8lIVigF96ZeBcp4/+iH37ASXicjldefEZagFql9nW8N9ftWVwymrD9gFRSdZsHHjwioRehl5rj4AgDJvzza/auip4LZpQe7TlG6SM3NWv9pF4b34z53QjSyyAMIDo1MmIMTfKJ428KUn2yAcsRH7r/OzNib1/wY8rX8NhMnpU2ZKIpJwtgLV2VOE/4rjWhyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ2R7p1+EheZHnyiiVN2R3UsfUXuzN8/4nby8MGswZg=;
 b=xllvhv5BQzvR+EHXlq11r3anhZkVEGmAZMIMFUkAwLPIj+cUu3lVG0p6FCQUTpB0J9Kw/eMepKuL8osmz1XAtb86V04EAFSwASo9FRXVUKKfVaD+eLD5tYeX3SG5+88ymA2zsoHu4hkcY5Ol98SziwPGlXMzKAR5SRnNN0aQ1Kw=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 18:56:13 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 18:56:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     David S Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 08/10] crypto: ccp: Add a sample script for Dynamic Boost Control
Date:   Fri, 28 Apr 2023 13:55:38 -0500
Message-ID: <20230428185543.8381-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 59393b40-f0ae-4ceb-ceb9-08db481a3ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuAZn0TY9zoz6UPmDoJTKdjvlHvqGuYxutDjrf1yOwISDXsYbQH3phnCLRB8xVjHVrjpXUhcdkR/cn5/CSQTgKTvlVEKop0IyhDQB2bKeDL9d7hYthSgwMJBhYjqx9kCwUzTtYnG+8HAEA+Tz9pRoIHY5JiY/XAm07So34WdK8mGwdOwZvEnSbwkIzIfSvjlG5A9PPlv7DvHynBLuAYsEOsgkXuYx0itQZE/daSQponLATrp1zx3R46aNzujiH9aDS7oFlT7C849n/Tl0Xy09wMoUG4UweWHro2MP1BA5SzNGBQ1kqu4eQMR/5ZnNTUrumMPJFjiePogk4nWMu98hJpX+RDEFPZMX2YXHEIzn7reSArLjD1ksNpjNyzE3SN0e0dF+kZF/B2YO+lGO3kbQ476cj2AXrMBVg4hYbLUNvmVqH/yEg82RhSC9cpgpBUQEjw8iSsSFjat1UZJ1pCtsUENZQDM3MVYtGLrLMfH6d3ptIhO1YNSc3qWFo9WpbRehe5WifYsrm18BSKSMByNUYzbkdKsGtnqevZrC/xL7h1b8DPHLs0OWIs1c1PK59+K/rtlmntOqUykvSIHm2rANf75Jto/ChB5BfrfV64bYE2RKMi1IYQ+EJBped10NC5C/CglwzpuN3o4P0Pd4jvcQigE+67HMAKNazefoAgfgALL5UxJdnNUeXycmT2/vnlBI7uIrIQCqbYkWiUaJbOYS2h47MbbQjRf+2gmO4WpF3c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(70206006)(110136005)(70586007)(54906003)(8676002)(8936002)(41300700001)(5660300002)(316002)(4326008)(478600001)(356005)(81166007)(82740400003)(16526019)(7696005)(426003)(336012)(83380400001)(186003)(47076005)(6666004)(36860700001)(2616005)(44832011)(26005)(1076003)(86362001)(36756003)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:12.8746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59393b40-f0ae-4ceb-ceb9-08db481a3ccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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

