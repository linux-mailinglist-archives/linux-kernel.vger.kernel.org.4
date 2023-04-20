Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFC6E999D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjDTQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjDTQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C91FF6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks30Ngs+Bi0MWbOTTeBwRv0orgnovstZPxCbSnANTWhuSDUSnA2rT4CO7MUtsBeVnL8tukbgN6YevvofeoHEWI32zu2uHieK0D1I5D4qH8vhMSG1F+NqRMNaLBU5jibSF0Er3Aodrh24iBl0duqso0ruIfLvHUDN0srOxS/AzXOuYJMh9n50uym0vl6nssnnnoTL2Qhvt0eGznaMGNxth9wp6kbWqWXOlrAtGyJS3dijiEzKwQrhuK47M5bZ1fafwO6ujlbts8ksicXZLDoqFW5ACG1WaRWM7q+HhJ8U9L2ICifd/P81n8OpyGXv4hI0MUXAOtTuLDJ0oS6vIJqxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsLohCXeKuWWsdVkE72Ow68aKRakDV7sRhzRtAZBwgE=;
 b=gfRmh+QsiOacBzAaWH9NSqaSrhNRoKssNmI8kCSXdDklCdbnoD32VLu7bMjjUTSAXkrKuV3Ok/v4p8C74qX7yiPs2vbF6TzMnbnfsuGIDe3e4tpY6MnQdytnJoaA0RU7zLoHa49iTQX3UKgHFzkF1bqCvn0pD6rSv9jo4QqinKy9GYFuJY3vwkeZGAjFBQ59lzFIIhxqrMwHB3PawwO1z9uGiecfcD0G7ZRZ0w2OtpcJA2pP3dx/4XOlYPrtDAnPpIyvgxbY2katkqnDwIPN+qp+u6XvIyaL672JbFp+FDiorjwDLDbYEka6fiDNka4xAtpIMXxDpM/4wNnmdW9F7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsLohCXeKuWWsdVkE72Ow68aKRakDV7sRhzRtAZBwgE=;
 b=Rnphb6NuwrlLjzACyh81RBHENslMXvZ+Be/hXdynJRDYXSNuLcKRnFq7Q2CuLIm2xyjfhvk/hhWXnObvJHyw+zlx0yeamGzWAYaEuuZ3nzo7n9DOUcIZSgy4L6xUJtl+yGOwz4saA4h7GMDRuIQ1cbGL+wbXiq91KVT0eqdT1/g=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 16:32:12 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::4a) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.24 via Frontend Transport; Thu, 20 Apr 2023 16:32:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:32:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 09/10] crypto: ccp: Add unit tests for dynamic boost control
Date:   Thu, 20 Apr 2023 11:31:37 -0500
Message-ID: <20230420163140.14940-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3367d8dc-ca21-4d12-9523-08db41bcca90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6qbDykmI3XcbHafSldmTX9RfEgu8RN1BC6QCddDK3oM4ThsVGtr0mniGgetZFlo9XRXpvXb8/292q4Y+pjIDyQF1K+CHkRWHpAEapkzHAQ5tOAPynhl9mAyOD85Imxw8VnePFsXAcCioDR286msT9/bRnNAcYXNwu8YJrpuOO1oEt3egc2clYdQgybUcnHeVedfg0kk0LETAbKckKlyPZODEBQjIQNiyYB5vpxuU6ivmVoaLMiw8BszAcSoJnOzigpz9pfW/1oV+JCXf170b5l2xFip7NWG8YOoFUCnsCLaPr9elTvJFya2rvyWsssPYltlKelAiDHyxsHT9qicX7xq/IssCG25i/+qqPCYtgg4XjRk+wkWfIDqc2iuxwITXngc2w41J+7N7dM2ioIXk7YFwcxBIM1zqtLONhXm5G4bg6IFahC8lX3t63LIkJpCsHvCj+u+Wzy9EWeXsgYhu2kNeER147fSAjokUA6jjR2Ez5Wrkt5Duk3/PT7OzHXJFe1Ppg5ocj/uKwc23H9guxcVOyMuAwoYgnvOz0zpzgdWf+a2U0ODQlS9RcmWV/LUQ2wmFV3T7eV746QFMK38r4Yl+Z8iQQi+ME/NN9ZOiaRNQOri6ZQdc9wyizn+gf/DFPIguLxxdOML4zh5U4wrN66ZoovKnsp0mceLznY0yPhLORUTTjZPiZOLxDgX/erC8F5V/toCa6+2EF5uyAiWQrGTO4wSSeI5JYGRajJhVT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70586007)(70206006)(4326008)(478600001)(110136005)(316002)(54906003)(8936002)(5660300002)(8676002)(81166007)(41300700001)(356005)(82740400003)(186003)(16526019)(336012)(2616005)(47076005)(426003)(83380400001)(36860700001)(7696005)(6666004)(26005)(1076003)(86362001)(36756003)(82310400005)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:11.0406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3367d8dc-ca21-4d12-9523-08db41bcca90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
2. Production systems that support DBC but are fused.
3. Pre-production systems that support DBC but are unfused.

Unfused silicon does not validate the signature, and so this allows
testing more of the state machine and functionality.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/test_dbc.py | 266 +++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)
 create mode 100755 tools/crypto/ccp/test_dbc.py

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
new file mode 100755
index 000000000000..33f93fddb9be
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
+def system_is_fused() -> bool:
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
+        if not system_is_fused():
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
+        if system_is_fused():
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

