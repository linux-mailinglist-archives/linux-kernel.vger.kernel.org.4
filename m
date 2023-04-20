Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CA6E999B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjDTQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjDTQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EBE65
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo0hh49YXsb2v9+gx0wnQDF2C3PVecNnOgCnCTeQngDJKMhUqqBzkJB13q5LsCYC+rY+zq8sezQnr+n5jzxPHCVQi5gY2pG80T/KHGS2fAUZ8dEdvkwj9dn0PaSEN+AFzf4ForOi5AwOKP3sGdyY0uXQg7UjnGp0gPkdb4Bub96RrnBX0v0UgD/8ZhiruyhqG9QztnVU+SoZaEx+RZ/gnVGQb/oK7plHJZdmcoPz/uIfLfCNVIaOUrhocqM00eI4RLX9n3da+quxCRs1ht92l9iJgUXCufr4oyDVdNG2GXXVD80g/9XV9e9j5aiPZvcPnsfoyPV/21NrJmDJtSzyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ2R7p1+EheZHnyiiVN2R3UsfUXuzN8/4nby8MGswZg=;
 b=ncXsfavgRH5BgqU8duhCZhynMnNxuNYgPeg9Q0jHNleWNp8Rrep6R32j96oJYhNvHewwUsOevt0v+P+OgBnucADsoGAh3iVgc2tBVK7d/OnA2WN0wBaiGW7C4qTZvmytkr3awGgDjPnY4qGahZgQkXShvWjuUie++YA6deu2I4Ny/AU1g1ZZEiAONFaS7X4hzs7sVl+zRV0DQEPKwFavOf0ZnKdoKEqry9L3iQXDoliv1hpxFVrH18Fahmv23u1tvigASyUdsgtVprBoXpXPAK0tZu2+bwcWD0D5KM3MVfFWrvF6NpMOWhJSjtOkSQwsVjiwihxmldaEzyXvqVGyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ2R7p1+EheZHnyiiVN2R3UsfUXuzN8/4nby8MGswZg=;
 b=zwnLoZhlOA5qp48O8dFmtqUxvK0f4JUCmFQzAo1N/xonkyBmfhh2OeXJwfSh3kdWcxerHkU20LuERWBil7QCGe+F0LLBBigFqVyD1pR1nnOmJwS9k6kMzlY9DtQecm8Gqp1VgApHj+1WzKz5kBl1DlUlwfNPG2syrdo9XWAa3dY=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 16:32:10 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::ce) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Thu, 20 Apr 2023 16:32:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:32:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 08/10] crypto: ccp: Add a sample script for Dynamic Boost Control
Date:   Thu, 20 Apr 2023 11:31:36 -0500
Message-ID: <20230420163140.14940-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3282b3-ba53-47c6-eba5-08db41bcc9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fL4fCd9XqvwI9swHLe6/EmGa2D76t0V2Q/MxShM0qVEuHH9A31xl0st2DjEGWJYsqSuaBu5f/ctQ3xqeB0niVqIfeSBuUfkOj/BIqJcFTob0aIK2DKlWE7WtV/IO1yQoDmK4nQkDaWAr3LPFksTPs50G56J5QROoMd+6rbG5bAVqxK9Rw8cnEfqJlRVlu3r63AZrB+qNWvIUxeafBrLm4Ensx/q6D48wE65/uq6e08uRJoXqhfDrUH8W6Stk/pwpqCG/uJ7AUkIlQ6OKcql/Yp9nOpURyhbMbiI2DbU2xvCYEasek0+J1twDGE2RvrZz8Kb8/GiFPdLM/yFPDGxHxi4syQXLRbq56PixcKJ360QSMT/qBOzG9SGLai3BXJoL/8kSr9W6wUJoPmkwB5/RY3SSn1DPDNsXKm1PNpuSRh84GmuLUss8hpCDzlLaqPRByIrXz3cl3rBvxHrTKi+DXqhYQWzE9+0tgdCX2XBFOGDJVenZMBXKp4wccgK2pFtE9QyuKGQFZRbuQdSlGLegGqgWcOqLFFE2ZXD1P3ERqfur3CBgkFIakOoZGvRnN/+mAdcK/+aujQ7u5F6U8JfTApJGk5QqOdilfcQyYR64tV6uTsO9x0H+q9tn6uV09Wd1stgZHkggXaFA6tF2QGeqy6IJRcKj/YF8enMZhGFaB4HAKkMWp+xekfPAQfzX8bSLTza7lPnvfJp0KApioIABmlYSf37BS3nd1FDEPgDqorw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(4326008)(110136005)(54906003)(316002)(70206006)(70586007)(7696005)(478600001)(6666004)(40480700001)(82310400005)(8936002)(5660300002)(41300700001)(8676002)(2906002)(44832011)(82740400003)(86362001)(356005)(81166007)(2616005)(47076005)(426003)(336012)(1076003)(26005)(16526019)(40460700003)(36860700001)(83380400001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:09.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3282b3-ba53-47c6-eba5-08db41bcc9e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

