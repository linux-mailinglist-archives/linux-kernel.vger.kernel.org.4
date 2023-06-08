Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722ED7287D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjFHTNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFHTMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FD30E5;
        Thu,  8 Jun 2023 12:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNgnxbE2CyrxYO7sqFlI8ve7IuOO2ZnaeV8tM1+Gp292WRHSgYhf0BCPsP3woLZdzzT+oJziCl+n2rKFE1sfi0NTBU33uT+zVHB7qX5sZ3koVDvRWs1r1siO4OKtLyXFsF/DblZ5aIciS0TAef/dR6BP1Tf9GNGq6dffD0eId5WXr5HV0soA73vI42FOLXQE/pxMLrMd/iGOTNkkuT2rovWKocIdJa/f8z7CtAlCZwiId/Eg9BANulyleUkfaPWwccXX7c2gdWG72vG9CZHXRu7yv6kiqpInjq+z4taPZNBJLQ3CIp+HZoTWpQkNkwLcwcaQf+mygf9itrfylzhd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ykFk/3ZWZys6zoBv+TOKGD58LL6HOx/A6TINKmESTU=;
 b=SSg36d3TRCKW+QWf0BPm7NQLGLe5mBUiMqY1ZVloFOyRTZzuxexYU5L3mBs1uhKfgYPquEL4TRc11D7z2gJ5bd1YyS5CPDw43lAEtRD0ZNya2dLH7E3jSqG3iBY9JTTGEPV4CjrNDTfkD/uWzarC0+l5cbiKoHDgxjEFOEA5FQKK+0Wm4LfJlaVnnnLHGywA1EyggCM+pKQEyD2cUcAhb85nz6LYfBm/H/UlWtWr9qvp7ZXfns3Innwcg4N7rS9u341bmKWxAvYi77+QSCBV4gfv/3rUB4GxCyIPbGRyHE3M4wZolKUP4rse7uph4Q/gvmYhyRlkZoOh2cMwDVvwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ykFk/3ZWZys6zoBv+TOKGD58LL6HOx/A6TINKmESTU=;
 b=RcNidzsu9AGrOB+OrY2u51qOvp0Ry9kSitoyk0UUIEicEq0UtP9pxeKwFxFojzlH4OqT7Pzs7ZYzFWQbQ0axcf0JoVQ9bBkDWQ12au1GatBVMdKryEib4gY4ZN+bo1R5F7Je8oKYU7JkzTsKgVcd6WTutMUlExt8QD/j3VSDM2k=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 8 Jun
 2023 19:12:33 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::e0) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 14:12:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 10/11] crypto: ccp: Add unit tests for dynamic boost control
Date:   Thu, 8 Jun 2023 06:17:56 -0500
Message-ID: <20230608111757.32054-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b6e2f9-8571-4035-9c5c-08db68545035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMKglQA0si8iFF5msk/fGN+33CwUr+blwA7aDiRsgfWegSokl6vz6qQhiW4IeQKgL9jiebIOd4sI7xZThnlO6pMAzjXPzSss1FQSrmuSPR1akDruKoW8aIJO10O+e81CrU1aX41wcbz59TUGiA9GrKTpIPlMjpl0/VMLawWaL0YkeEtN1Im1Uwm1M7M8G2fKmJihmw/r3Fq3facW8mJkfIEC7YLEl/qFZnIvsP4LYL/RpLXR0utz7y1WoRTNEKfpgncGxHA++28CgeEc2unhCZU2ISHj3pj5hRGgmlF6uml+U4ap8eZuiBmJ/MrOiHPpwSWdlMA8ZaPwLa+GCXaSQ4+Mgf9ZbHcJNhAcI7TDqHCoNgdDG42Dihk9pV+JSYpWyhUHTYTspVt1TP83xzedj+209+7Pvv8Z34XdmjqlvuuQvQ059PwQjgtEFLjsoQj3/GZyGS0dd6bjNPWaDiavVUBfp0iy8Z3doKyQZarzCSJaJtKod1Wt9cCUBKmVb7PJ/lLGgCO0kByakSvRtTqqYtu7LQwcxdIHMHMJR3vVI0AzgkOUzWrLh+tWhZKXiFUqulsIkJ+TcAuCRkgLYERUwY6ULpLVkCadZui0aWr6cioRmwqN9QI/tF0X+fzzkZrXli9dRM5MmJrQ6J+QAePZBi15e+0R+igusJdWKBcv77DXiN2hpaVIzG7Tsxj5YtSrqjwnJWT6o1/KUC9Dp5TNsRYO5w8vNfCEDMVAOgA7GXDqC3GJygX4Hg0DchJZAVwItIXk1w9t4pzv7sJdx2Af+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(478600001)(110136005)(54906003)(41300700001)(40460700003)(7696005)(316002)(40480700001)(81166007)(356005)(82740400003)(16526019)(1076003)(44832011)(47076005)(26005)(186003)(83380400001)(426003)(336012)(36860700001)(86362001)(82310400005)(2616005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:33.3883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b6e2f9-8571-4035-9c5c-08db68545035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
2. Production systems that support DBC but are secured silicon.
3. Pre-production systems that support DBC but are unsecured silicon.

Unsecured silicon does not validate the signature, and so this allows
testing more of the state machine and functionality.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Adjust for library changes
v1->v2:
    * Update commit message
---
 tools/crypto/ccp/test_dbc.py | 266 +++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)
 create mode 100755 tools/crypto/ccp/test_dbc.py

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
new file mode 100755
index 000000000000..998bb3e3cd04
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
+        with self.assertRaises(ValueError) as error:
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
+        self.assertEqual(error.exception.errno, 1)
+
+    def test_set_uid(self) -> None:
+        """set uid"""
+        with self.assertRaises(OSError) as error:
+            set_uid(self.d, self.uid, self.signature)
+        self.assertEqual(error.exception.errno, 1)
+
+    def test_get_param(self) -> None:
+        """fetch a parameter"""
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, PARAM_GET_SOC_PWR_CUR, self.signature)
+        self.assertEqual(error.exception.errno, 1)
+
+    def test_set_param(self) -> None:
+        """set a parameter"""
+        with self.assertRaises(OSError) as error:
+            process_param(self.d, PARAM_SET_PWR_CAP, self.signature, 1000)
+        self.assertEqual(error.exception.errno, 1)
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

