Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE155ECA69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiI0RFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiI0RE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:04:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB8B3DBDF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBeEsRlql6zsgb+aklMXlx+qnV/7cCXAH4YnAqwm13W0Sklhrcrjh58L4BZAf4ORMnPY3EwVXUlDfPUM321S7LAZvfMIxf1XGxdpDKhuEsuAjg4qV0g94XJN+tKqc9tsOk7TeOh1aNIYk1USM8g1X2xFBjBt9IyEY2X8g3/tjPJEb1eAzYk54WQyErC4ldaDMhI+GxO0HLiYlFuMz8zRNVef0pO8OBshLf2ocv7T1ueHT23l06pxNQPieEsvzZX4ZAa07rx8V9n3OipHWpEC1R1m2N52gghIPzrjgFRSBW35Yzaij5pDRlqCR/1DGFee4PQ3QWqPsLz1+8k9Vxo4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=war+ya38wIWlUAuZ6WglQaQbbAjpTtdjhkfj0LELJsE=;
 b=SOlhOMIR9sQfzkgt34EA5Bi9NSSnG38xy9svUJTD6ncPMVyfCTgT08T9jzKYUY37+civ1HB0CwdwkH9mAJ861kQqFCLyA/b4PLp7FAr1OLGVs1CxnIFryPX3BFBs5LHaxttNCYAgX+wpNTsJnfq9OJc5ezjFUCJh2RuoxtgaKGMflWzXzikM8uA4Kz2h3RtwIGzWdN2WfIzYBlShgHpBjf9Ng1XxbNiGNsSWDLbqFqrwI8uI5YCcuVIlDEpGAl8G90m9yT3S3uTkKG0apYkxZOg6kybQ7nZLWkb52km33dBqx/0clYjYVQ8iDgJWxBKokyBikPqtjDvhd3Uu5wRpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=war+ya38wIWlUAuZ6WglQaQbbAjpTtdjhkfj0LELJsE=;
 b=WVnq/Yhgm5cbgLabpk1mbcLu8gmJRi2/gPXvCfpWbVqWGzTYrmJAYeurCCGrxoPJ0FJomvLKOYqSDjpID8WoVszA1z88oKv+NopipSVzozFXCC56VwWGM/RWl2SNn9HX+l6bj5KoTUzmmXYu4MS9ALwdyd1Qwp4kb+w26ywSl8I=
Received: from BN0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:e8::28)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Tue, 27 Sep
 2022 17:04:51 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::11) by BN0PR04CA0053.outlook.office365.com
 (2603:10b6:408:e8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 17:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 17:04:51 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:04:50 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 2/6] x86/sev: Fix calculation of end address based on number of pages
Date:   Tue, 27 Sep 2022 12:04:17 -0500
Message-ID: <91dd756197cdeffa5b81d812a55fc8b74924b344.1664298261.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664298261.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1664298261.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: cd787eb4-b04b-4ce0-d5bd-08daa0aa646e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhGEyRLxGWQ82/BlAWBpYxDMe1UVTbh9Obb4e2YOpcDema0kxk6QRagijthOIdIMtTygh1Km/iYTMGgUniGdqBwOGOE4HdgQNxJcAM6rNw6lsuIx70sdvveJriyKSBX3E/fvYPOpzU6963Z5er8TQjBsvFRUUL1uDQ7D+VBNZzNbjH4cVIbuThN0RwjMVlhgl4bATPQdQyUzmpGlHRLsGw8L/U+VncrBiSP7ywgNJA67gsJq4eEiUOomqNZbh7CbUF+TEQYr+/zTL3/AAKk2ZuXPRt6XYlFgXQrc9tjMl9yWzJ/O57Xy5+qsl4KE9sVt69+bm+HrvxXEEAnrGFSKbfVnQl4EU167i8z0YFt5P11ljIEK1Ic+NqBBLbTcD9xFsZoqKJQ+3jZFY6cbpUTfXs5awrCon/2q90atPSIX9MklaGwdLjqEq8FXf2IjbcLkAvADJe2ule0DhGC9FoXem57c25sOABxsZngKQrf8Sklfp63XwVqOgRTuj2+tiSyq49rcwua2mun4dqdBmuRIJDORnuK+31pW5Bky/J+h0JaQWAWNrcw3gVd8XCnsMdT4+RObz1BfDNC9ZAKHqdOzY3kK97uw6s1m0z/JQzt4Js6rL0ygZOfLjm+7+ioMJClkXiKAGDzI1ThzLGhiHBNiZAGe/wP5uSh9l0iy2RQwFYy7KB9Lrn2941ZYUxKVdKs/UysRq92pC6+Qvygon0z1dPNCnOzS2MjWwptOcdQsxODhAUVFojNQ8LwLD/BDUWhFOrZH1zLiTNocGpgRVMWC7WJY6nJ5z6eJ83WUqvtjYnJRLkjMZ7mKUV7i+Y4cWhMh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(356005)(70586007)(40460700003)(336012)(2616005)(6666004)(36756003)(4326008)(426003)(82740400003)(186003)(16526019)(8676002)(7416002)(316002)(4744005)(7696005)(36860700001)(478600001)(26005)(82310400005)(70206006)(41300700001)(110136005)(54906003)(8936002)(86362001)(47076005)(5660300002)(81166007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:04:51.5435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd787eb4-b04b-4ce0-d5bd-08daa0aa646e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating an end address based on an unsigned int number of pages,
the number of pages must be cast to an unsigned long so that any value
greater than or equal to 0x100000 does not result in zero after the shift.

Fixes: dc3f3d2474b8 ("x86/mm: Validate memory when changing the C-bit")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index cac56540929d..c90a47c39f6b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -875,7 +875,7 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 		panic("SNP: failed to allocate memory for PSC descriptor\n");
 
 	vaddr = vaddr & PAGE_MASK;
-	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+	vaddr_end = vaddr + ((unsigned long)npages << PAGE_SHIFT);
 
 	while (vaddr < vaddr_end) {
 		/* Calculate the last vaddr that fits in one struct snp_psc_desc. */
-- 
2.37.3

