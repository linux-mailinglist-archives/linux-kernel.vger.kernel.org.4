Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA16472FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiLHPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiLHP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:29:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C027786B8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:29:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6WgMTbFzQR2mV1SO21Ja7EI6PJ4mrRLqkZNIMdgoyBu6uxjKAzfzETz3WzpI51Cw3ioqHcCDGCrgjYmXmaY97m29eMa9h39MRg1kqv6J50k2gpjgUQJ+DQhrYoE3dzg/fx0GhmcsLdn1+f5skmGwDygJRaRYTfH/6TTbnD5WO+yRD6AE/k5pP66Mg9DgTmXO/BQHEr7HZklLy737KPQfQVtBZf2dUqNk9LTGg7j1RTo6y+w0NVNVJ4PPXIP1YeTJMJZmOOqq4heDEZhGj7ZnH+QJK1cVvR8JUxwBRBn3sO+YtZ1G409C3/4DAeMaY16HEd/Pht/+uyuejGcFV0b0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3/5KXFRbhkIlZ9d4rNFPK+YWh58t2diCXT5iAPwzTI=;
 b=HCHI7UbKuevjTlVzOKYnavQR5HIfvoNoG2C9nBzEBVpm/PpZ1hQ+F857I0T74eH/lpy5z/UrvwKKzQmF8KOrWohUpY+eu1flkYITHpgzxB/ExoPUlBy2Naa7tTHEEagBcgXpeSdo3LgEhIVO1brm+tjKjrL8+FnZuHf0dm6y/w0fz0gr65mv7SDLcuGW3dVfLLc0D6M9CIe89tvUNJVruYLmj1PY9z9DQrR/Q7ZBToPBZuT73gMgDQys4NNhpKlPD3DHIumbRpuyJg+9sUC2wiFxwcp4/we1El5Qz3+rr66qyZHVfHSA5yF62fLFR8dqNGUYLLruT55nbjFdYvVZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3/5KXFRbhkIlZ9d4rNFPK+YWh58t2diCXT5iAPwzTI=;
 b=Md1x/pzLBXvzETwsfTFd6WARjD1lZpCyCnjXubPWEK9S0ipK+nnOnfsFmN84YDG/8UYJoYNkVUkxyefsvKt+jfE2r9lQaxAZ2GzwXbjueMtCx/DAn58xkmFlkgQbNS0jlaJBdnJvBN+9SEM6TMtoJf9MC5mYWZQLOi93BOHqZsk=
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:29:42 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::28) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 15:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 15:29:41 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 09:29:40 -0600
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
Subject: [PATCH v6 2/5] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Thu, 8 Dec 2022 09:29:10 -0600
Message-ID: <f01dc981369b80b67039bde355c1af28537130f4.1670513353.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670513353.git.thomas.lendacky@amd.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com> <cover.1670513353.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cac1db8-dfbc-4c34-6dc1-08dad93106af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02RuLV0M2Sb7ZMHBoe8hu0gYekwa+BqC/btxF5BZ/1hrnmn16OlJSqwabI0Do+S8van0eOnHQ0jl2yp1B+8dYUz+8QTtARNPgtV5TKfhAEbZlwCDfeqQh+NElsHnucXKTwLVQ73G0+Jnbe4piP9AXEUuPyKRulYExS42VtyGxnpjaC3Vrrk/eVTssC18n/CoWZkfuMr3ltvE+FnJRyJqq78sLV+MVl6CfcnaSADk4PBfbOr4u/JPGQAU9B94RcGolKRJPPueuGxbXr8mDeBzXs58JZHE+hw7mmTQWSw3uxoEOgTFY8+a5byAx7sMmxBRufTmU1erSbIyf+uffJHwfbofQyXj+g22W+mAvFVQmhV761T6RtfQsyAJeCO+8jEoBTcdESKGl1+UEa0hl6VZX1kDHlUKG+rGQ3RJYsL+I+kctLO4kWbLiaqcWdV3/NXw8HmMj6+7ZJUSQYnDB9Q6rgBNQmWKgvfU0MZ0B5uJNfQN4jwJfTG1u30I+2a+wf+BYiRpQErunKh6vluIoX+6CfzhK8+8HX/88gZ+Bo/nYLiyFAbRx9W0wMq8L6n2B7nGf5Hla/fIv1WHk0tc3ZzShDMtNG9k/4x10ULxFOLYwkpVJePxvkOIDeXtAkXbLzzad5KcyiiW93thMfvfu5OJhDyT6dlN3xweK0nNwk29+cL03EOv+YwrnyiCCubQc1XNhPStuUgkuZn9a+NF06gTbdIxud3biavByT+cuNG61K9Lk12R3yI/fuy/s+d87Y0hXM2+yBErX4b1OQPnp+GIaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(81166007)(356005)(86362001)(2906002)(41300700001)(4326008)(70586007)(36860700001)(70206006)(8676002)(8936002)(7416002)(966005)(83380400001)(110136005)(316002)(40460700003)(54906003)(2616005)(478600001)(82740400003)(40480700001)(82310400005)(26005)(186003)(6666004)(5660300002)(16526019)(426003)(336012)(47076005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:29:41.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cac1db8-dfbc-4c34-6dc1-08dad93106af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In advance of providing support for unaccepted memory, switch from using
kmalloc() for allocating the Page State Change (PSC) structure to using a
local variable that lives on the stack. This is needed to avoid a possible
recursive call into set_pages_state() if the kmalloc() call requires
(more) memory to be accepted, which would result in a hang.

The current size of the PSC struct is 2,032 bytes. To make the struct more
stack friendly, reduce the number of PSC entries from 253 down to 64,
resulting in a size of 520 bytes. This is a nice compromise on struct size
and total PSC requests while still allowing parallel PSC operations across
vCPUs.

If the reduction in PSC entries results in any kind of performance issue
(that is not seen at the moment), use of a larger static PSC struct, with
fallback to the smaller stack version, can be investigated.

For more background info on this decision, see the subthread in the Link:
tag below.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/lkml/658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/sev-common.h |  9 +++++++--
 arch/x86/kernel/sev.c             | 10 ++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..8ddfdbe521d4 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -106,8 +106,13 @@ enum psc_op {
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
 
-/* SNP Page State Change NAE event */
-#define VMGEXIT_PSC_MAX_ENTRY		253
+/*
+ * SNP Page State Change NAE event
+ *   The VMGEXIT_PSC_MAX_ENTRY determines the size of the PSC structure, which
+ *   is a local stack variable in set_pages_state(). Do not increase this value
+ *   without evaluating the impact to stack usage.
+ */
+#define VMGEXIT_PSC_MAX_ENTRY		64
 
 struct psc_hdr {
 	u16 cur_entry;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 6b823f913c97..f60733674731 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -880,11 +880,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
-
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	struct snp_psc_desc desc;
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -894,12 +890,10 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 		next_vaddr = min_t(unsigned long, vaddr_end,
 				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
 
-		__set_pages_state(desc, vaddr, next_vaddr, op);
+		__set_pages_state(&desc, vaddr, next_vaddr, op);
 
 		vaddr = next_vaddr;
 	}
-
-	kfree(desc);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
-- 
2.38.1

