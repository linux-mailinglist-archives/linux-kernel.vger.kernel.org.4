Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8345BDC62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiITFYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiITFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:24:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E705AA27;
        Mon, 19 Sep 2022 22:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiDvmkXWKTIOs8VZe6wCfLyY63vx6Y9MW/Xz/ReesCCjQh6lW+CJcxhRU20TUTbrBxo/DucbLllwb/WRBig/eY/KgVsS/UhfzRtK049lthGNAI0IOK3tfnMK5rs8gW6b05i9kNf2Rt1QWcTlJFC+WCKnBkhUre2o9sZgXW5dw22exWI9Aqyv7rV7NF011vDRDJ7KjKIagLsgvrLCHFXHrpCedpx/NUOTkuVqQpRDufDbxdH3WgwvW4Ww/EpvZsT6Y202uzTA5X6txsKuo/WQ/wOI1aGViA28tO7ztbfNVFDQffRb28wwMERdVi1rJdty/M3i/hegCd8V3Ar8m0//hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/UPX+p0QuUQTbNg2MrUHXzED2dyUCA2iBWi9BfFig0=;
 b=OBN87YZvbwytVBvFTk/8TsO66PODoyhJzUYVMlRTIIL87D77AY3sZA3FPI4Yl1pqmCrRZ+jnQyj6rPJPJOYss7Y4uloz/Gh0UEhVpSMglz3ntdi4JGEOPvSFoG+6vJTVK7w9KWaf3kPaGi9KqCSAlLmoU6la9FmX3PMZxtXp02d7p0VWVeaudPAEIleizxLTiUTjr+DkGrEeJwCx6OTB5O7dqovxowvhty/Abp1pqfYnkBzFol26tQEGSKzSLBLn+1AZR+NwXr/GbC5tfKNvjyJVvYqL4gtq+6znPcl9PmAki7TbkdJ0PGSZCsy8BGAXXJ5wDEa/VXM6hE1oqyWmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/UPX+p0QuUQTbNg2MrUHXzED2dyUCA2iBWi9BfFig0=;
 b=QZtdTbn8dQ0QCygQtaE0WllYjYDGJBwY5liiHNDxZs/vg+O/3erD+2y/fWBtfBsU8DtRgcnWuhiv8FFTdj6FPNKBGgqA4qebw88GkwBvRIXyLpPdPOZldS7foEReznt1/gNHsYE4MtYVd+dxN1l8TG9wC1AeDFr5B3G60W+zEZE=
Received: from DM6PR08CA0035.namprd08.prod.outlook.com (2603:10b6:5:80::48) by
 DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Tue, 20 Sep 2022 05:23:09 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a2) by DM6PR08CA0035.outlook.office365.com
 (2603:10b6:5:80::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:23:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:23:08 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:23:04 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/2] dt-bindings: usb: snps,dwc3: Add 'snps,resume-hs-terminations' quirk
Date:   Tue, 20 Sep 2022 10:52:34 +0530
Message-ID: <20220920052235.194272-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920052235.194272-1-piyush.mehta@amd.com>
References: <20220920052235.194272-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: a0562285-9b86-48ae-3216-08da9ac834c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vAdOPaiXumTcGwI4YdgR9pwgkn3Q0c0BymXOSjY7BtVPTFKcddWzFg/P7xcAsTDipEJj8yGLp9755ZZzVWEmY571ne/D7baFqdqCxuvh87uAXmnlrJi1U9qssCcHl4EwlsQvcnyBCagm4EUXZoGpYoX+AiT9Anf/H7y29zg/wBhvPVtNWmz3BDQwCvl0wB8Oo11CCbf2I7F8YIt9pVjpEFOIefMyEvTZ/160+VydSF+q8r+nvTY/Ff9kN9WPf+ccBUYPVGDNh9SEvKN70p1SezzTEEAt5pJQNsGZ6X+Uv0EJVP2LCWFvcc3W/irI+dClz4JMfKzZ5LWwF0pj8x9GtLKoqs0qPawSQMAocfFdDuJecP1vH8jcJKY0HgcDUldg+RRueTZ/K5/oyGT7aDbh3D6vLKR+sR4lkKLA6cif8O41LJrxY78Y/yBEsFnDUUT4t2dnT54E8BJTCCf65tKEq24Qs8SNUsVJ9lIaNv5oabpHkk1UgynHJl94IQLMK0v+Mut5e7OMuQQGeajLqXcIRWcCa8CgHzVjKNOKI2r03iiZZpNUqs4JGjcxli0iGjHKpVfGnbwQN8n+Fv84vunF47oi26P7J9tD9bOKj/58P5jx7UPtTCi1r3Hfpio+2uAX0iVCac5RUMadenIN/gWwVY2lAMj4U3Ag91dRGPV6k5dQZgk8rT6jUkgvKiEOQr3au/EuLtQAgE9BSnNSBHBpzm6j4H90pNFAOdviEPEAHRqWjUlgDE66eNdxhj2jjnIgRYaE4EpA5XNhv85QyiM4LsIrmRNIm0M5ulhXvQ+9My948gz5vI7u9bRlvOkMkWtY3c1GUs9BVUTBMfWb57c+18z5axw9uiG/WSyaPkNesY9fHV+DPgFvgKrLR6adc84
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(426003)(1076003)(82310400005)(336012)(356005)(2616005)(186003)(8936002)(2906002)(40480700001)(26005)(81166007)(54906003)(40460700003)(478600001)(316002)(110136005)(41300700001)(70586007)(70206006)(966005)(6666004)(36756003)(4326008)(8676002)(86362001)(44832011)(36860700001)(5660300002)(83380400001)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:23:09.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0562285-9b86-48ae-3216-08da9ac834c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new 'snps,resume-hs-terminations' DT quirk to dwc3 core to resolved
issue of CRC failed error.

On the resume path, U3/U2 exit controller fails to send proper CRC checksum
in CRC5 field. As result Transaction Error is generated. Enabling bit 10 of
GUCTL1 will correct this problem.

When this bit is set to '1', the UTMI/ULPI opmode will be changed to
"normal" along with HS terminations and term/xcvr select signals after EOR.
This option is to support certain legacy UTMI/ULPI PHYs.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in V3:
- Addressed Krzysztof Kozlowski review comments:
 - Switch to amd.com with amd SoB and ownership.
 - Added Krzysztof Ack for DT patch
Link: https://lore.kernel.org/all/6499fa0e-3e07-85b4-0800-849db7c2593b@linaro.org/

Changes in V2:
- Addressed Krzysztof Kozlowski review comments:
 - Update the quirk name and No underscores in properties.
 - Modified the quirk description. 
Link: https://lore.kernel.org/all/e15168ac-b5a1-0c15-cfb3-34fb518e737f@linaro.org/
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1779d08ba1c0..6f9107fca6f1 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -234,6 +234,13 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,resume-hs-terminations:
+    description:
+      Fix the issue of HS terminations CRC error on resume by enabling this
+      quirk. When set, all the termsel, xcvrsel, opmode becomes 0 during end
+      of resume. This option is to support certain legacy ULPI PHYs.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.25.1

