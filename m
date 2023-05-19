Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B29709E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjESRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjESR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B2D10FC;
        Fri, 19 May 2023 10:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwFW9TS7rGNUePGy9IZy6jZOxVeu+TDsDv5cvFyshPyw4ftIZl0BSNYIV62wSS+ufQSCbVaFsBTpzN3n/gYO2JIrtS2cfjtZKf/45fG8BqHxdLarXZ5EmhoCckwxPQdLfz4jqh1IUbiGKMrjQA1UAVGy3Sy0umVDNW22FFlJW5zWUuzNYn0Jl0/iup+IX1GDob1s8wpLcgorgWBVen5uUre2BPaevzf9jXNa5K/Lp0I1lDoKCDoclZi3gAeZ16fEa29pUG4GRzsF8lkecc7/ugF+BE5r/UFM6/lS0LlSsjLV4GqNTfcDhYbK5I/Eexvv2H3nA8j6NjjeDyjjn4R4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vRp3oQ5mI3lG5LA7CKfO8Bfupy1g/R2DxOVyVWTqMs=;
 b=gBc6Qix/IBamjl/B2oM5Dwp7A0saf0zsirNmzqttG10B8mlZvN+6iYZduQlwSgIBVR4dnFJvq1Ph8NzA7kvkPgddtNG2YC2B1qyDqFrnUhIpGsjQXwcAN42o55NNqYgfVQrZxGs/h1FnCmmpeKfTk5vSROSsXDtTBE80H9lr5UKLLvwHguMl+bAQGpmaPKt0QdVvLCt8OGEZS1t3vJi7Kh2F44i0QECBcC1vlURSgHCJ58YVPPrr0FBT0WJZgRq5ndEEpJOHKB1QshVgLSHWWsJPiXjECJykDrVmsCZslJzpWi/k4Neqxe8uG5vrCDMKKd87Fc1b4twWVGOX+cR/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vRp3oQ5mI3lG5LA7CKfO8Bfupy1g/R2DxOVyVWTqMs=;
 b=j4XwNOc2K648TxtL2mOb1K2BSvoe8X50mHsnOq01MQYZytuHzL15qTQ2QGhjDNK/NBkljzBurqGJXLvhAGP4JOQJoVuj4uUVDcZCGHcasdx7IVDAh/Myue7rKr+Blv0/4xq06TSybUmWAcMkhnr21ut9ju8tan896Enlhujkzfo=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:29:08 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::bb) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 12:29:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 09/10] crypto: ccp: Add unit tests for dynamic boost control
Date:   Thu, 18 May 2023 22:24:47 -0500
Message-ID: <20230519032448.94279-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea52ae3-3806-4ff4-7e82-08db588e8d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4A9A+sJXkXWjko/GPoIJZW+BAdSNFqOvf/n+QXVNpN7ascIv0ph0QJpp6co8VUViUGhv2UA9RCpZz2GGOLmBQoO6A+5zwcU8iQfox6PNCMNYiHiLzRgQO6JEmXhH6PJmS40Bh7ERc+tko1XxYQnI4eO4gOsO5AgTsEduo6yJxPNrnvMfURmH6+mVNUCgcNypa6JSkrjVLa0QNkI4qQeIYKR+vqyoUiJcNUUpAKyRtE1T6PUQ8mICBhKLQryr4tYqFxnZsnOiBNvKwcWQEUOGe4H4OzW2V05TpojfEjNuB6nOJRKdLRoXSc4j6+5nfHWRXVNlpmypWFJFqIAtT8Mdl6RJ5gxWhX+GT+A/SARqv5Kr0V14Hhbk3ZQmomr7JTJ/us11G/zPE0TuFcKua+ypYPQGv7hyF+RivRDF2KJo+bWFX6AVxg28tvYpa1CumtypX1MOMeoTwekzbB3SIPdUJraDJ6vMFyACvCh4YlJeriZKScrmJiCycqgYTbmRvrP5vmr4+raFfVL09ku1RgDjQCCEDvBCvZEAPOZkZwkZXAjVDphnh0nfBmnBc13CXfT0WgObiqwi0NTEvptJutcDxAjGpbVkSHoqiMt4NRdICPIprsmpwO8K531k+5phsZK9L/YM5oWoU7EcfnqXP/hkdHhdvt5IF/ROVuKwp8DfVZnocuSyCO8zeYPqxrUZTKI7+oVbV0xuf/3/QE/+yGI3XZRWPY7XZjKoSspdTKINTj4bkbmXNaedvR/w0ewUxMgZe7yElrGrBS68iBcSeiq2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(5660300002)(26005)(1076003)(44832011)(478600001)(186003)(110136005)(316002)(41300700001)(70586007)(70206006)(4326008)(16526019)(8936002)(6666004)(7696005)(82310400005)(86362001)(2906002)(8676002)(82740400003)(426003)(47076005)(336012)(2616005)(40460700003)(36756003)(356005)(81166007)(36860700001)(40480700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:08.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea52ae3-3806-4ff4-7e82-08db588e8d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

Interacting with dynamic boost control messages requires the caller
to supply a signature. To allow validation of individual dynamic
boost control components, introduce a set of tests that can be run.

The tests can be run in 3 distinct different environments, and so
certain tests will be skipped depending on the environment.

1. Systems that do not support DBC.
2. Production systems that support DBC but are secured silicon.
3. Pre-production systems that support DBC but are unsecured silicon.

Unsecured silicon does not validate the signature, and so this allows
testing more of the state machine and functionality.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
    * Update commit message
---
 tools/crypto/ccp/test_dbc.py | 266 +++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)
 create mode 100755 tools/crypto/ccp/test_dbc.py

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
new file mode 100755
index 000000000000..a58c153d52e6
--- /dev/null
+++ b/tools/crypto/ccp/test_dbc.py
@@ -0,0 +1,266 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+import unittest
+import os
+import time
+import glob
+from dbc import *
+
+# Artificial delay between set commands
+SET_DELAY = 0.5
+
+
+class invalid_param(ctypes.Structure):
+    _fields_ = [
+        ("data", ctypes.c_uint8),
+    ]
+
+
+def system_is_secured() -> bool:
+    fused_part = glob.glob("/sys/bus/pci/drivers/ccp/**/fused_part")[0]
+    if os.path.exists(fused_part):
+        with open(fused_part, "r") as r:
+            return int(r.read()) == 1
+    return True
+
+
+class DynamicBoostControlTest(unittest.TestCase):
+    def __init__(self, data) -> None:
+        self.d = None
+        self.signature = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
+        self.uid = "1111111111111111"
+        super().__init__(data)
+
+    def setUp(self) -> None:
+        self.d = open(DEVICE_NODE)
+        return super().setUp()
+
+    def tearDown(self) -> None:
+        if self.d:
+            self.d.close()
+        return super().tearDown()
+
+
+class TestUnsupportedSystem(DynamicBoostControlTest):
+    def setUp(self) -> None:
+        if os.path.exists(DEVICE_NODE):
+            self.skipTest("system is supported")
+        with self.assertRaises(FileNotFoundError) as error:
+            super().setUp()
+        self.assertEqual(error.exception.errno, 2)
+
+    def test_unauthenticated_nonce(self) -> None:
+        """fetch unauthenticated nonce"""
+        with self.assertRaises(TypeError) as error:
+            get_nonce(self.d, None)
+
+
+class TestInvalidIoctls(DynamicBoostControlTest):
+    def __init__(self, data) -> None:
+        self.data = invalid_param()
+        self.data.data = 1
+        super().__init__(data)
+
+    def setUp(self) -> None:
+        if not os.path.exists(DEVICE_NODE):
+            self.skipTest("system is unsupported")
+        return super().setUp()
+
+    def test_invalid_nonce_ioctl(self) -> None:
+        """tries to call get_nonce ioctl with invalid data structures"""
+
+        # 0x1 (get nonce), and invalid data
+        INVALID1 = IOWR(ord("D"), 0x01, invalid_param)
+        with self.assertRaises(OSError) as error:
+            fcntl.ioctl(self.d, INVALID1, self.data, True)
+        self.assertEqual(error.exception.errno, 22)
+
+    def test_invalid_setuid_ioctl(self) -> None:
+        """tries to call set_uid ioctl with invalid data structures"""
+
+        # 0x2 (set uid), and invalid data
+        INVALID2 = IOW(ord("D"), 0x02, invalid_param)
+        with self.assertRaises(OSError) as error:
+            fcntl.ioctl(self.d, INVALID2, self.data, True)
+        self.assertEqual(error.exception.errno, 22)
+
+    def test_invalid_setuid_rw_ioctl(self) -> None:
+        """tries to call set_uid ioctl with invalid data structures"""
+
+        # 0x2 as RW (set uid), and invalid data
+        INVALID3 = IOWR(ord("D"), 0x02, invalid_param)
+        with self.assertRaises(OSError) as error:
+            fcntl.ioctl(self.d, INVALID3, self.data, True)
+        self.assertEqual(error.exception.errno, 22)
+
+    def test_invalid_param_ioctl(self) -> None:
+        """tries to call param ioctl with invalid data structures"""
+        # 0x3 (param), and invalid data
+        INVALID4 = IOWR(ord("D"), 0x03, invalid_param)
+        with self.assertRaises(OSError) as error:
+            fcntl.ioctl(self.d, INVALID4, self.data, True)
+        self.assertEqual(error.exception.errno, 22)
+
+    def test_invalid_call_ioctl(self) -> None:
+        """tries to call the DBC ioctl with invalid data structures"""
+        # 0x4, and invalid data
+        INVALID5 = IOWR(ord("D"), 0x04, invalid_param)
+        with self.assertRaises(OSError) as error:
+            fcntl.ioctl(self.d, INVALID5, self.data, True)
+        self.assertEqual(error.exception.errno, 22)
+
+
+class TestInvalidSignature(DynamicBoostControlTest):
+    def setUp(self) -> None:
+        if not os.path.exists(DEVICE_NODE):
+            self.skipTest("system is unsupported")
+        if not system_is_secured():
+            self.skipTest("system is unfused")
+        return super().setUp()
+
+    def test_unauthenticated_nonce(self) -> None:
+        """fetch unauthenticated nonce"""
+        get_nonce(self.d, None)
+
+    def test_multiple_unauthenticated_nonce(self) -> None:
+        """ensure state machine always returns nonce"""
+        for count in range(0, 2):
+            get_nonce(self.d, None)
+
+    def test_authenticated_nonce(self) -> None:
+        """fetch authenticated nonce"""
+        with self.assertRaises(OSError) as error:
+            get_nonce(self.d, self.signature)
+        self.assertEqual(error.exception.errno, 22)
+
+    def test_set_uid(self) -> None:
+        """set uid"""
+        with self.assertRaises(OSError) as error:
+            set_uid(self.d, self.uid, self.signature)
+        self.assertEqual(error.exception.errno, 11)
+
+    def test_get_param(self) -> None:
+        """fetch a parameter"""
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, PARAM_GET_SOC_PWR_CUR, self.signature)
+        self.assertEqual(error.exception.errno, 11)
+
+    def test_set_param(self) -> None:
+        """set a parameter"""
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, PARAM_SET_PWR_CAP, self.signature, 1000)
+        self.assertEqual(error.exception.errno, 11)
+
+
+class TestUnFusedSystem(DynamicBoostControlTest):
+    def setup_identity(self) -> None:
+        """sets up the identity of the caller"""
+        # if already authenticated these may fail
+        try:
+            get_nonce(self.d, None)
+        except PermissionError:
+            pass
+        try:
+            set_uid(self.d, self.uid, self.signature)
+        except BlockingIOError:
+            pass
+        try:
+            get_nonce(self.d, self.signature)
+        except PermissionError:
+            pass
+
+    def setUp(self) -> None:
+        if not os.path.exists(DEVICE_NODE):
+            self.skipTest("system is unsupported")
+        if system_is_secured():
+            self.skipTest("system is fused")
+        super().setUp()
+        self.setup_identity()
+        time.sleep(SET_DELAY)
+
+    def test_get_valid_param(self) -> None:
+        """fetch all possible parameters"""
+        # SOC power
+        soc_power_max = process_param(self.d, PARAM_GET_SOC_PWR_MAX, self.signature)
+        soc_power_min = process_param(self.d, PARAM_GET_SOC_PWR_MIN, self.signature)
+        self.assertGreater(soc_power_max.parameter, soc_power_min.parameter)
+
+        # fmax
+        fmax_max = process_param(self.d, PARAM_GET_FMAX_MAX, self.signature)
+        fmax_min = process_param(self.d, PARAM_GET_FMAX_MIN, self.signature)
+        self.assertGreater(fmax_max.parameter, fmax_min.parameter)
+
+        # cap values
+        keys = {
+            "fmax-cap": PARAM_GET_FMAX_CAP,
+            "power-cap": PARAM_GET_PWR_CAP,
+            "current-temp": PARAM_GET_CURR_TEMP,
+            "soc-power-cur": PARAM_GET_SOC_PWR_CUR,
+        }
+        for k in keys:
+            result = process_param(self.d, keys[k], self.signature)
+            self.assertGreater(result.parameter, 0)
+
+    def test_get_invalid_param(self) -> None:
+        """fetch an invalid parameter"""
+        try:
+            set_uid(self.d, self.uid, self.signature)
+        except OSError:
+            pass
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, (0xF,), self.signature)
+        self.assertEqual(error.exception.errno, 22)
+
+    def test_set_fmax(self) -> None:
+        """get/set fmax limit"""
+        # fetch current
+        original = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
+
+        # set the fmax
+        target = original.parameter - 100
+        process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, target)
+        time.sleep(SET_DELAY)
+        new = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
+        self.assertEqual(new.parameter, target)
+
+        # revert back to current
+        process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, original.parameter)
+        time.sleep(SET_DELAY)
+        cur = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
+        self.assertEqual(cur.parameter, original.parameter)
+
+    def test_set_power_cap(self) -> None:
+        """get/set power cap limit"""
+        # fetch current
+        original = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
+
+        # set the fmax
+        target = original.parameter - 10
+        process_param(self.d, PARAM_SET_PWR_CAP, self.signature, target)
+        time.sleep(SET_DELAY)
+        new = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
+        self.assertEqual(new.parameter, target)
+
+        # revert back to current
+        process_param(self.d, PARAM_SET_PWR_CAP, self.signature, original.parameter)
+        time.sleep(SET_DELAY)
+        cur = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
+        self.assertEqual(cur.parameter, original.parameter)
+
+    def test_set_3d_graphics_mode(self) -> None:
+        """set/get 3d graphics mode"""
+        # these aren't currently implemented but may be some day
+        # they are *expected* to fail
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, PARAM_GET_GFX_MODE, self.signature)
+        self.assertEqual(error.exception.errno, 2)
+
+        time.sleep(SET_DELAY)
+
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, PARAM_SET_GFX_MODE, self.signature, 1)
+        self.assertEqual(error.exception.errno, 2)
+
+
+if __name__ == "__main__":
+    unittest.main()
-- 
2.34.1

