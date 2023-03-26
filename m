Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9D6C95CD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjCZOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjCZOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:48:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9DD30E9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlMiBHJLanl9bzP8PguXQ4mPf5Izd/odCyOsrVG5joqXb4AKv59sHXSyLBQxB+umWpyWq6iSZ7DeVrwli2/Wv7gNsnJ9PEQtiO8e6JbqsS1pR2k3Kh4GVK00WSFKAAKER6zqH6tKEasayLvMDsRfT3fb+c0rdKOVJOQsVwsGGeI/r7e3+gDR7W/zjmMEcNk7liPLW59g2Jt3+r2Q67Z7ND3QW/y7KvHkNstuio4JOtJmc+dhiA5bJN96Xe2tFj21xfxSMHm7JHJVBVyLQdB5BpOYKKb+uyzV69xb+3b65vuPULe/FvCFU59KhO9l+6wS6/lbaRUx6biPXJwl6Xt0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFu5SRsi1J2C+cEif7W5W5/+jg0BMdRNnahFkdxqaw4=;
 b=PSr0OdH85vcD8RHPmEwTiy8K8V+fMXrQI4owDaQk5LqPIV3I9YRrVE8dYf3cfRaSk3Hxxtz0VHfjEh3D8uvSBi11BKTLktUIhy2eD3UxLokte6MCeDp3A1pO00ID59HtNe/kjEK1ulCyC1h1tkIlTjVQ3XNZYdNEBB2TzEjxTlTAmTmYMqDjANjn9YbrCwFCS06crq1PCIY6O55o2efZSyX7gHqjE7UynvCh4amotMMnQjbgTwMjFvm7QsEmW4Ls49BBVox8KtCI+gZBSeEdX3LLDeDmc4ND07PxC1L/bM2OVt8G7vu9ymyZMvhI54SysHVM381P58B2XWupdbWOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFu5SRsi1J2C+cEif7W5W5/+jg0BMdRNnahFkdxqaw4=;
 b=Kegt4REZ5DLk8JUCDdBs/Mb5kJi83zi8qu+Lmj9sk0q7MmMAzst9sRwVetVmPb75gOvpdkSynSRDn9UlzrtZa3xDvOyQorO+8IaenK67Eg8TAqKnPJSwEoxU/S0Fo8KzYj6He7bOivR6VAYmUv3jalSQpeE4l3KqSvTWjD8/fo8=
Received: from MN2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:fc::24)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sun, 26 Mar
 2023 14:47:54 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::82) by MN2PR02CA0011.outlook.office365.com
 (2603:10b6:208:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:52 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:49 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 09/11] x86/kvmclock: Use Secure TSC as clock if available
Date:   Sun, 26 Mar 2023 20:16:59 +0530
Message-ID: <20230326144701.3039598-10-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326144701.3039598-1-nikunj@amd.com>
References: <20230326144701.3039598-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 247b6730-66c0-4292-3afe-08db2e09140b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ/Ct+nFtwmXkRduVx9WTqee0FAnYHJZf72iX29PmSEypCkdBTzTlehjCBr4hzMFFyKd+uhHGCXugpu8LTr2fJjCObtAAwajF5UWAxVSVpdyAK3kChVEn5I7GwM8/TXK+LlBCqLVBUcgSb+Y2tdGeadeGxh8imUbdfqf473vZ7sHRWBX82suYARGSQpIM6KH349jlD1N++v3gX4ui7W6PkVTCF6d5f6YffisH/9J9GtXW5E29Ofg7OMAcr0Jh6piGn/7EvFzc6NejVVNwVqEnqWADk/KGG+nGTU5iiklXT38MtzLLSll31HZPwOlel5DtbD1KQ+WnOTJ/wZSVpXC6XR406NAC2DhFSxcDxNacec2oT0eFlbN2mGXfgViIxgqMLmPe/ee9LTbLdgtmlDsuRdOO3Wxm8qqpAD6C7gpd5NyaQpSrIHaNKkixUdXfxNuPfRcPPGE4GbFqO9uMPQfwPxMc0C4QNAGv0UZb/ChZk84A7LmpJMZFs8s5tSin/ZjhSEmmz6Df+SLhVqt9ueVhr1ryH+Wo7i+NaxQ+XOPwb3HfNDLUcCD5l7TlNugqEGoV0hC1hC/qu7xllsF4qDhaStbB/fuK5TPF7mVQtoB07jnPBpQgA6GWDicvBN4vY+Ord80RKn9WQcHbgNjtGkDl5/AeJ0T4Oz08Oke2SvQtCj6y6SOpu7DQrB2df/BlUt9J/pLSBLk+8qVZ+7zlNpkZeQeBEX7zZVTlAP010ww9dw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(316002)(4326008)(5660300002)(8676002)(70586007)(40460700003)(70206006)(2616005)(82740400003)(26005)(40480700001)(47076005)(426003)(356005)(36756003)(336012)(41300700001)(2906002)(54906003)(478600001)(110136005)(83380400001)(81166007)(6666004)(36860700001)(16526019)(1076003)(186003)(4744005)(7696005)(8936002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:52.8452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247b6730-66c0-4292-3afe-08db2e09140b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD SNP guests having Secure TSC enabled, use Secure TSC based
clocksource instead of kvmclock.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0f35d44c56fe..1be342064851 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -288,7 +288,7 @@ void __init kvmclock_init(void)
 {
 	u8 flags;
 
-	if (!kvm_para_available() || !kvmclock)
+	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
 		return;
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
-- 
2.34.1

