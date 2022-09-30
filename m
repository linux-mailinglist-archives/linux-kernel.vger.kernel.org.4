Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180E5F0F42
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiI3PvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiI3PvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:51:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0DDFA5C3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkQLK2aCWQQfpVJXkGN7mmVo4Fqas6FgVuzS4upmQTBfK5MH7+HFGbTPXibhET1LL1LBugphyvtBemGpIKTdsexKdDmmbjYybQmVxQKDX1+esoIDL2DG8DlVwb1/O1XVz3Z8ZBovgB9PPwKVGEOD6IBLympYy+ui7ti3QLPTYXrJwpRLOqPGRpgBsg/6X72Z9wZozymvvt02T7E1LMFrUYiTvgm+8LeouNqSiDEj8ksHCBKN4T+4aZ9w3Ku1S4kNExVJYqC09BNVWu860s330m/OR/YlnDE/Z3VjaAM6OfRjoT/ZCrPzDkOvqc9sHYr44HMBQiDXOgh7aDa8W4m6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TELna/6CJO9UABAAOqMuqJ+JppOy41jRaC1zyOoWmIw=;
 b=k0hY9pIxrtncSBH7DPKo4TFXoqkiwziFdl6xk4brwCa2MTVWCh7ipoLsTuec2RxSANa6DNV2hgBxFNBBmeTJ60FH5JkhINu8nUPDPYdPz4v0WtQ3tgzjnSwHSuIsF32eEsD8GTJETWTXdK1RKBtMrlVEzDBgEbS9o9Q9+2cLtucQJea0FRFjWZsTqVdjBa5POsZR1c+kLwfiW4UPcmkDb1dYG0cv2/rY9xXmCC7hnf2djUJGx9xRgyks4fxUPKst90WLR32ybOlVPcN5M39ylUi4VWhnb5AY3/CNjOk2Ae+au3Awb9wLd2l1Q+hsFLgnfF4ZZwD91IJSMIvKnNO9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TELna/6CJO9UABAAOqMuqJ+JppOy41jRaC1zyOoWmIw=;
 b=37GQVI+qO87b3/N/qp+oLLAAmvdohVhlWfjNHsOFVyoobJsFom7nEPEC2GJfwpa+2r9VuH9eFBg4gOxln2h5iNarjqbXBYU7YO9rewB14INrOidyPViSyas8S2IC92kSdE2f2geSHyjqG0HvlII4TT5L6aqP2Ctc9wlKXqlXOgo=
Received: from BN9PR03CA0616.namprd03.prod.outlook.com (2603:10b6:408:106::21)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 15:51:15 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::f2) by BN9PR03CA0616.outlook.office365.com
 (2603:10b6:408:106::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 30 Sep 2022 15:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 15:51:15 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 30 Sep
 2022 10:51:14 -0500
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        "John Allen" <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Fri, 30 Sep 2022 15:51:00 +0000
Message-ID: <20220930155100.164920-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: b323d102-5e6e-4ab2-73ef-08daa2fb9b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +utMrDtO6gbmQkL5RdjiuwNQpTVaQ4c0EWunqbT+oTGMQ0RZVkVWIGEI5H5ib1QVNFoARXzR9ekMq4VsD0+McWVbxkBSpBbDgCk17PEkHoCckOZBvHZ/zSPvkRdeCRR2olshYaMRwliot6VXQjBcRgKfZi0rTiSYchzqbwjxyhiaoiIUhxCT4Qc11cD+rJuVsBB1imaWEC69247NeSHBzYFGrIFSag/JV8NzSyYoqqO0yjrd85U+zmKfrAVcM57SQ6BJ5xhqGuumubzNOd009FXX7HCYxWFkfYbYL7wviHUpthanhfzVaFBDqfA+L4wak/lw1iIhVQ4SPCFywzv4e66HEld79MT5XUbNhA5uZsl3ysbhmg8PMtlrDPNGgxTZ8/oSogC9wdqgkKEM5wtvDlPIIM41wLFriCu5g87CB/SFfi+zKn2mEe9I0nUSERYrZWnc38SlMzLGMJqh0u7Zop/Z0XVmPWHd/X79/WFnXO2rpcaEt7YSdEGv2aw1WGmfJWD2QMykcEPJQhKYKcaPLHkQLFqONQMsl14hIdyXAyaIectcaTbYSv+LvTVLiqcX5MJQ7R5R849r+e9ncTZJ/WYpANR+JWff01R0y5OjDDblNe85dKanGExetieWtz0P/lwP0q/I1nBtGAD36H1qDxJ8dgLXuhHpj4KjozDk466nC+FUsc03Y33vMGwEF2jF1walwiAa6RvxczRf5EKYJf4vlZf46kTBI70hbsQthw4Dml0SUxQbZcxbKP4p9+em2wkGQRQPa377pSfstceygO5hGZnc+o9Wh0yzXIQ3jrrHmTmJfyGwabboWLSkCR0K
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(40480700001)(36860700001)(81166007)(36756003)(54906003)(40460700003)(356005)(336012)(47076005)(4326008)(316002)(82740400003)(110136005)(8676002)(15650500001)(5660300002)(2906002)(70586007)(4001150100001)(70206006)(41300700001)(8936002)(186003)(478600001)(426003)(16526019)(6666004)(82310400005)(44832011)(1076003)(83380400001)(7696005)(2616005)(26005)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 15:51:15.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b323d102-5e6e-4ab2-73ef-08daa2fb9b46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 LICENSE.amd-ucode                      |   2 +-
 WHENCE                                 |   2 +-
 amd-ucode/README                       |   6 +++---
 amd-ucode/microcode_amd_fam19h.bin     | Bin 16804 -> 16804 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/LICENSE.amd-ucode b/LICENSE.amd-ucode
index de5b29c..ea47c57 100644
--- a/LICENSE.amd-ucode
+++ b/LICENSE.amd-ucode
@@ -1,4 +1,4 @@
-Copyright (C) 2010-2018 Advanced Micro Devices, Inc., All rights reserved.
+Copyright (C) 2010-2022 Advanced Micro Devices, Inc., All rights reserved.
 
 Permission is hereby granted by Advanced Micro Devices, Inc. ("AMD"),
 free of any license fees, to any person obtaining a copy of this
diff --git a/WHENCE b/WHENCE
index d929b16..d67b12d 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3971,7 +3971,7 @@ Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
 Version: 2022-04-08
 File: amd-ucode/microcode_amd_fam19h.bin
-Version: 2022-04-08
+Version: 2022-09-30
 File: amd-ucode/README
 
 License: Redistributable. See LICENSE.amd-ucode for details
diff --git a/amd-ucode/README b/amd-ucode/README
index f1ad2bb..024fd51 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -36,6 +36,6 @@ Microcode patches in microcode_amd_fam17h.bin:
   Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301055 Length=3200 bytes
 
 Microcode patches in microcode_amd_fam19h.bin:
-  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001058 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a001173 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001229 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001075 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011a8 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a00122e Length=5568 bytes
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index c99e86d9fe533d10a2001a6c8dc0dcf3562c17f7..c3f9f6c74dd1cc8acae67e786bed5186e0a9fd5e 100644
GIT binary patch
literal 16804
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
I{|(3eFBRAqXaE2J

literal 16804
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
G?*9TO*nZ^z

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index f455758..f143124 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmJQUh4ACgkQ5L5TOfMo
-rnNRwwf9EZ0S/qgZu4YdO4JPF1+86Y3C3aUdNk/+dyWHIc4yOQg2TvDY09nNmoKl
-p4JTzmjw70PfRDV7FnkUtv5j/D0aiKWmAoUewZV0S1gxYSYgiC8yAGEH5samFqJe
-UKuRYapPMT6ulyWcVEWQtOUx3EqDTodN0XY+TX7Rs83HOzRUlDCqwFdt1S3ZtkcZ
-f4r41IqQidYYsdFeDEjTXrLc3XHv8c15aIEjQntQWWwV6ZrOFkJskFlLPfrW8e7V
-lF8LP3RjKsnoRtrxOxCCzOBu0qgq/hZpaQkkFpm0KtLMLH64O2c8XTsZTiI3X3lu
-+XTsmm6QiNmzw6RYRiE27PoJ6nbP2A==
-=Y4UB
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmMzKVYACgkQ5L5TOfMo
+rnNlHwgAjo0pufrCnTQCj3c50k92Mph5FT4vW3oBVAPZD0c3AIfQ0A322N80stEo
+SC6nnMRamCMy80cP/KUjSWRav++Ng6YKfs64qHhwgcNux9a2dhj3GPeXWweXKxVd
+PEbuP4XrStG+sjjaeJKMwOE8Mmo3sgK7hZHopS4vS5e7mM6xyiK1XNAVLTFXE3s8
+Ea3Fr5c4Z+xPdl5h9Ya4HJPaJa0L1vSImls/vb19pEatdK1GFHhzF/KLJ00NksVW
+cVibL8LNGo31/jpnoHgv+DVG/OGmJqMgFj8daNtmCYivJP5AqykAIx6mDGAf6927
+tZ+WZIKGZSM8rC8rRrKA0t6M/PWftA==
+=HQE4
 -----END PGP SIGNATURE-----
-- 
2.25.1

