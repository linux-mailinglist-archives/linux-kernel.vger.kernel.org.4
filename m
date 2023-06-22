Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53E73A222
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjFVNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjFVNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:45:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D45D19BE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khStNyMgWhhXs7Z80BBVqK+YAZhEBfR7aI9iyhXxbvLiWHToiON1x0yDPxP9DtTL7a9eoIIAu2d38cuEIc48kedXKDQaSDMYbDCTPNiF3YXWtNXi2ytiMWtmgbOqBfGkhVGk1LQhpgTs3N9TaS48iIhiHBgVBqHCVC5mNvFPgm/7GwPp0dMAwxb303fHhjtnjwJTQUlSwe1NDcWIVJ0KhFbHXjLXmqIWBinWaQbNfF7W3rksyiR6TCNgATl01fIgqtTJf3xxlLqmJ0pHM/8VdZfi6m9yqV+uYIjLJTCJJYT+kgd0prm+DVX2R7ipJQpk94UHoaALqHlQpgu7vZScEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVbWRY2Pc+IPFQImWAlkcCbB6dISD7dkrzZrGEHg0fI=;
 b=T7mpzFxrpsiu0CuMP4VY+7IX/JGSrt0qIY0r7B6k4C5zKxbV9up74FlVVa7lnQGGlckpNEWVUL4eq1XjlEfCRml9J9C+Lp4J8hvULLaJyt6fFkMcYE8Atp3tJzMCKNEW5mXJopc3uBSQO3GGwSGC9SzkgFcazn+3WgTpvXzTG+7AtK6XEOzHJTVnViNloglPPVPScFEkkk5oiTHu7Uj3NPzY+vYijoyiP5jWdzj7SqhCobLmTp/TXr2W4C0mpb0miDpiBYVsdcPnPuTtNApQClZwZSYmh625Rrez39DhjaGt0Ow8VAquPBhMFlaqrMVc/TKQI9m5sr/wfN1uDfU3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVbWRY2Pc+IPFQImWAlkcCbB6dISD7dkrzZrGEHg0fI=;
 b=MX/rf4GI5990DR9jcsvnosbxeTAJ73orqr7FyxnXKKsYONSs3YSo+rGVxeaUylQcBpMa3qlqRWfNgFVZR8L1amdSgCc7lKe0pyVZCWjrVvNU+OAkEWBDMPM9JWx0z1Omw/oDYgg3nMBnD6M59g6PUXbVJLyNaFJ3dmIYemcwjyM=
Received: from SN7PR04CA0154.namprd04.prod.outlook.com (2603:10b6:806:125::9)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Thu, 22 Jun
 2023 13:45:34 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::3f) by SN7PR04CA0154.outlook.office365.com
 (2603:10b6:806:125::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 13:45:21 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 08:45:20 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH] x86/sev: Change npages to unsigned long in snp_accept_memory()
Date:   Thu, 22 Jun 2023 08:45:05 -0500
Message-ID: <6d511c25576494f682063c9fb6c705b526a3757e.1687441505.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c76cd8d-6201-4cdb-834f-08db7326f33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Js3J1MGyrhj0TCJ+wn4bqALoVGvtCBHWHA6BFaKSbfkNPKSqsqgTEJ31ItOx+VlUGxEDQJYkhgjKDyX0+qt0gwrDRWDKUY+UG5ij2JQsR4FpGEYxN/v4qoyrZkaH2j3p6WrQiQuBlLrXQJj7BtJHD8nkzvnpGPwxu9XAgue7BwQ8mePFQ+XhqM94KHqqw7P+tGlp6dtHOLyirQy6oPO+9NuPh4bkmcQ3kZw8JYNs3dfILkX94h3zXnSCUxKfh3D2qx89NSL2LECmglkcpavxMHLoEfueM6xnte6P4FpBWixllvWoTQzETMFeE3Fut7KOsrwcb58nxFnKi/ibRBSNn/5TM/QtQ/rxFUj4dNMJxSRwO8mUaoHAsXV+Sj43IS6HK8dQ1uFhrK1D75pshP8UKvHhbaHm9DjnrRgqu7GpLxKY9qp/Eq7wGc2hoyPSugDkwBgwl0MfpZ+t4/jbmRuy/svcu4CTQQJ6w+X8mmRV0iiumM/PYXQXnfuLpt41JYuQ6wYv0bJmcqBywRrQ9WMRDY/n/6GsCdm7vNK7fK+3+/+PsAdd7QhysBti7Xd76nVs7gzciZVRyhG1OuBVFbtITvf8VvBQ4aPzzrUPaiqrVEZxWUkT0JSkykE0cpjIJDVHdNieQhfh0tkVPgJoNMZ4HF2t304tGdIm6YmVLLyuqu1P20/KZySZgX9LNKBwEIGWYdGN8sXfb4hnUudDuoHZa2PcEejJi7O6hQlwOk+isdAJdKOUztS+L5KKUFlSw51G9btn1t11joW/syonp6lzww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(356005)(81166007)(40480700001)(36756003)(40460700003)(82740400003)(86362001)(6666004)(16526019)(186003)(26005)(8676002)(8936002)(4744005)(5660300002)(478600001)(110136005)(41300700001)(316002)(54906003)(2906002)(70206006)(70586007)(4326008)(36860700001)(83380400001)(426003)(336012)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:45:21.8899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c76cd8d-6201-4cdb-834f-08db7326f33c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snp_accept_memory(), the npages variables value is calculated from
phys_addr_t variables but is an unsigned int. A very large range passed
into snp_accept_memory() could lead to truncating npages to zero.

Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ee7bed453de..2b0342a03c1b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -868,8 +868,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	unsigned long vaddr;
-	unsigned int npages;
+	unsigned long vaddr, npages;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
-- 
2.40.1

