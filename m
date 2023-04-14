Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741B6E2826
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDNQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:14:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB09188
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIJ5jEk+kfiVy8hI9M2lbU9uuNah7ECoEaMyuAhP0fKRDPXcQXTs8gwZxHXxMOeMNWRz7BwGiyJSzoUEPxIsdoqOnhgyXth6978Dc/QIdgIpt5U6fv2Jls+4PCbLIoI4zLhXTYjMGAMCkzFc1NH7fZEMl9lKqKM+Waw3PWmStHaDnHdTO/tYkmlqUyz3eUu7kCS8w2eMELYQ6A7kdk1mSx2KzqyNbob3Q4+XuiGGIHg+qf39C8N6B0E7EGWWs2MUnxEolpCfPDuQWNLyjzCFmhBcN3FPSIGIIAk0FCmSHThVudpKwNPlFUwDN15Wb1MWHXBWI5GOvgL3iwwc8xpG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbiYlR/SaNFfTJQG3oZviEk0oUla9vSUJoCxbNkEdmw=;
 b=fzolusn1y5Hn93e+Cfb313X/RZ0KISox9dKwnUxKOKg11Rjv+wtuLRVQmf3dsvY934b7bVY3WBtcYmfXmUDhVdVH5aHJfTwDdfDWfrVZ4BjEr5EEZeyOg2vqfKS5skXTFzIA3h9CYduNtBlNPvBrtJ6lQe2o7GwhfjvhTZebeuQH54SQ7SSYZ+0RLQeLHPE6urWys1m9+cuBoo/L/wqeIEIxzzy8bc71Dbq3Tei45oMyp1PDMx6XSAmGAQZsFRMeylIFLrbsU+vWeTp6PzFOyXegRGSoqV8N2yc8m9q1YWard1ZuMZMCXIEidI4FSzdmd/55nqG/qoB41ktbHGd78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbiYlR/SaNFfTJQG3oZviEk0oUla9vSUJoCxbNkEdmw=;
 b=tk2lXSxar4q2ayI8irq3YhBJ8J2j/HouEnI40nW0QfM760fD7C8H+kPfuEZpuxPAhtz9HOb3enqG/SflrE71K6nnseU4BJa0P75RyDQp2iCcEIz7zKn2e+48NPclqdYlrCBlWgQJEBYSCILD6KpVy8xHD2TLT1jY3kXbr1+Lk0c=
Received: from DM6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:5:190::30)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 16:14:18 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::ce) by DM6PR11CA0017.outlook.office365.com
 (2603:10b6:5:190::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 16:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 16:14:16 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 11:14:15 -0500
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>
CC:     <linux-firmware@kernel.org>, <linux-kernel@vger.kernel.org>,
        <suravee.suthikulpanit@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Fri, 14 Apr 2023 16:13:58 +0000
Message-ID: <20230414161358.180759-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bdf774-e1c9-4216-598f-08db3d034bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hr7EBg89mrdJTQJhCajv9wVEpmRmplrD88iHsxxIVbE2iFBFC3eLI/VYjrUrj8HqxhOqtYML3qBeXaZcfELsA356ALtV7WTaZnL+W7Pn6PgH2qlqEQycmc2DimA5CoRm5HdYyVSyTe3VeWfSxNGyk1p7MCs4NWQwj45c37HuEsXhaN+RUQxVDSf+B0pOnsyxAjqFB8mMu3NOTyyFZJOS9eE0Y0mWID4ZQZDRCFQzAR1IxAVzZemAtQhPkvesAAztO77tlhnPPzIPKWs8hC07Z6NFaxIMfeZJtkks4SqNFpCxkWyZT8gz2zfRZ821KIemuKMsu2GRqJbIinsFbNfuz/kR/i5bt/QXjcB0wP2Sl8WiK0fKmrW7tHwT6LYD2bISHiD7U0BAt7QZ+4rXOWKRVi/LB86y7KreJL952s8hEqG0y0zIR5FSthJil0siaxFd3dr6REgav9q5MvWAaCSzGXHsk83DgdRmidp3S4MPKQcU4DC3AwLmopWrvYM1qGUnzpgIM41+tjOe9dL29alURqjkgg0PFovbaNSkANhz3SKsf1D68gQNE2Wnz/TI2VUtzttLt2Cb4A8Ew30gILUc1zx0t2r+2KjcW/jxaUpMFCRJUdOuQA5IDwtuCZIe2ojFnoH+H/gihG4J1fO3nciTaEiicDf4WnmkvC3QJpJVla5/G1/BqfKdoXyx7lXZhEYF4O1DR477tAk4Ln3oBVDg8gVHVO7DfbI4x05htdoIgi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(478600001)(82310400005)(26005)(1076003)(54906003)(16526019)(186003)(8936002)(8676002)(82740400003)(70586007)(316002)(41300700001)(6916009)(70206006)(4326008)(7696005)(6666004)(86362001)(36756003)(40480700001)(356005)(81166007)(44832011)(2616005)(36860700001)(15650500001)(83380400001)(2906002)(47076005)(426003)(336012)(4001150100001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 16:14:16.8679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bdf774-e1c9-4216-598f-08db3d034bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 17h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/README                       |   2 +-
 amd-ucode/microcode_amd_fam17h.bin     | Bin 9700 -> 9700 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/WHENCE b/WHENCE
index 7cc9afd4..c2295e13 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3917,7 +3917,7 @@ Version: 2018-05-24
 File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
-Version: 2022-04-08
+Version: 2023-04-13
 File: amd-ucode/microcode_amd_fam19h.bin
 Version: 2023-01-31
 File: amd-ucode/README
diff --git a/amd-ucode/README b/amd-ucode/README
index 0adfde27..0d97f910 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -33,7 +33,7 @@ Microcode patches in microcode_amd_fam16h.bin:
 Microcode patches in microcode_amd_fam17h.bin:
   Family=0x17 Model=0x08 Stepping=0x02: Patch=0x0800820d Length=3200 bytes
   Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
-  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301055 Length=3200 bytes
+  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301072 Length=3200 bytes
 
 Microcode patches in microcode_amd_fam19h.bin:
   Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001078 Length=5568 bytes
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
index dec3871929a36792a261578aa834e807b5bea77d..37d899cd534789e461a5cf3ad666fcd587b8ab93 100644
GIT binary patch
delta 2695
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
BMdttj

delta 2505
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

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
index f5b1e4d7..27da52c8 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmJQi+QACgkQ5L5TOfMo
-rnOMKAf/T14Ixwan/IPPOEZHhsB5reCrEWLM89hey7z3vn/h8RWLAfJnAQwTuv1A
-B18gOWwUQMNARsoeDQZnnDvIQBB4w/DpzAaoWBoPnUR8Ko9jdl8ou7aUwdJzYC4T
-h6+LeSmHGhQ/h7AIJWABplXJg+weYfQiDr9u/ulFsZdCvfBx+8USNp75HddVTXWr
-+SunY5MrUZKmQvj147fCojByYVGzNCkWHJe3V6obd19kubTT357QwUX8A7/ZwgYO
-8DlxoVbYg9X224/7Cck6dECE9jKbmaVJkmdMg6ACVirjDH5U/HAACYNwwcO2olPn
-BOxF9sZMYY9cl14WCj2R7WS+gEjYWA==
-=pSDv
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmQeEvgACgkQ5L5TOfMo
+rnPOpAf/dYhPqq/ktg1muI/khV4EhDiguX6OXib3fmfSZdvPIAI0cRI77M3Lvf0b
+nlV8D67e5HOQ5foJbix5tunz0sZjqr2QU8U9dNk/ut0KC7UiCRc8VH40aSi/OQBG
+Y8c7tb6IJ+N+jyJ6Ii6koUuRO2Lk2MckcrWLRuLRV4bB+osyJrGjc/X54Z6UJ/Ma
+VDg13Yxy5WvC7sMmlmnY42JLeLBKDVUvg0zDvJ4aOLLxRE2l3eiAKE+TV122LmxN
+ca5WA/ESYQ9BjxHYIrpTd9nQaWa/TIZ+rOmJGLMtnQ1gGlW97zQuJR7zh+8vdLzC
+iwVlS1cu7kcV7KYDytTkWJ+2gwb3uQ==
+=lP2S
 -----END PGP SIGNATURE-----
-- 
2.25.1

