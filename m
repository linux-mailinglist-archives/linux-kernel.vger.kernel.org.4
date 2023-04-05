Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7DE6D7D45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjDENDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbjDENDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:03:31 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60969EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK4zHsqVUN++RbMDqubgvUEqOgZEvXFBfQIXiKU7VHxGYYShh77K1Kt85IsKKABZi4qd9xyI9OYJNIdLaWUaFq9ZmoehhnPgUpJ7bs45kMlwxSHgpVb/CriKims3p4RUfHotTq9idCfY3Cc3MlEUktA9q6YaVoVH/F1YwNEaidG2KCUPyIVobSyD2elyZKD99odkq4br7B6Vuk6xmEd0CZ15Mcr/mQL8cwmXRlfXrDTmk0jCVCwWrj5cmdX+h+Rkirc8pcgnp75CozHum/URmkfTNXBfBZ0fa/6XOQnzazKGR7xNbDCY9pf/Bx2CkfX6evZwSmEDHm/+79Pa1HiR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfowwl97qjc+UT09pkNWiK9uWebJIFvjRn6D2kAJUyw=;
 b=LBd0WtM/cRwg6TcdbmxU1pMNFy1Rqx1dkz3j1ezkNWNWZQRHQDEiynZbupLSJfBL0JVX+kXVYkml2mKuJGxMFw5HaoRcgSkPNnyY6umN6kEZNUCoI+9yqwkbL4dcB8WkHfG6LU2hfNe18INAGNvGlb7q3lDdEZDlmeH1FgWz8uh7GrtAX1UUkxF/0GMTfJmJlzPKNeP8Na62JKJQ5E5WFRQINZopG+5sWIEa/ES55HCOPU4j3HhNwIqCuFt8GVn3BhwmcFmHijF1O1sSpu1ec8rOemtHe2UeH6jBY+Zs+yNuuSL0XMU8bCwwo1Glw0lS99uqee+FbAK03wwrZZ8VIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfowwl97qjc+UT09pkNWiK9uWebJIFvjRn6D2kAJUyw=;
 b=IviCqariIt4EUtvmKunn6x4RBlAkRyDsN41u8P330THyWicUE7Q0ygq4jy/zYMchsmfdyckKdv4yJv3wvKeTe3leEqVUZe3wtCNz6wkgJHIqaWu7R20HHXZhqqv6OWlg3lwfJbuAyRqcmJ1UC/RpcEQy2e2+vu9B5rbqCU2X2nk=
Received: from CY8PR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:4d::24)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Wed, 5 Apr
 2023 13:03:25 +0000
Received: from CY4PEPF0000C968.namprd02.prod.outlook.com
 (2603:10b6:930:4d:cafe::6b) by CY8PR02CA0013.outlook.office365.com
 (2603:10b6:930:4d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Wed, 5 Apr 2023 13:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C968.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 5 Apr 2023 13:03:25 +0000
Received: from ruby-95fdhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 08:03:23 -0500
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v2] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE
Date:   Wed, 5 Apr 2023 13:03:17 +0000
Message-ID: <20230405130317.9351-1-kvijayab@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C968:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 94098b83-254f-4b55-3c7c-08db35d62462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RnisrA83pIHdSSdMnqpCFG9rcuE1zwmMHX8/EUMLxhnvWXCJDwNKKCA6rxb5lZxnt6PnNfhYwarJfxm4Fff9OOp9NthNbvJOqiqSdQgZc0iez0sMHBJs7yTHIfJVQLfIa6qhcLo3WjErF4AAwLzCPf6/Xo+78wqPE+63IFSyXHRG20HljEIq3AByMe2YYY9fRqU4c00UKdSsMV3Q2AiqA83pwNcWv69hRCcl01rCCgQz4YvhSi5lTQANP6QJJgc0Qa2QkmeuwfktERJqZRPYYJ/BKf+S8+JvhdLhYmjDnPEmh3TPk/LYLazuMXQ/Ea66sn5O/Bjo8xPcY19k4xJCZGbiVpdorMInhJwFIYRT5Oy8yuhRgYjL/iIZxpiNKGmNPPBy+ww9QUE4Ke7XOHXcbVqYEPb/WOcMGuMzebm/5agmieespCesBi2lVz6ZQuQko9N3V6F6jP4hh/yhHN5cBa901Run5Qsl2MQOWLSLcmVPKg4TrsHjS+Ke+vJy4uJk8g+N+pVqiBfuTcbt0iITpdf0BQbRbDYcJkvaaYOYJO/AfnJd9fK7LeOlX2fDyjmlH4fv7ue/5BcRtT427YaiOa//yiiSU6NNkxfACs91LYQbR279wmFRNnaJ9LlYkHWr5r+lnkCFOACRONIohLuawvukzeMt6XexVjR8mVWsbbZl1fMey/60L19mAy5pbwKuhfzQqypY4fOO/MQsFabEqMynuu3LCU4E+u4yx9tmZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(426003)(336012)(356005)(82740400003)(5660300002)(47076005)(2906002)(70586007)(8676002)(70206006)(41300700001)(54906003)(316002)(4326008)(2616005)(110136005)(81166007)(8936002)(36860700001)(478600001)(6666004)(26005)(1076003)(40460700003)(36756003)(16526019)(186003)(40480700001)(82310400005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 13:03:25.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94098b83-254f-4b55-3c7c-08db35d62462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C968.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
(de-)activation code") while refactoring guest virtual APIC
activation/de-activation code, stored information for activate/de-activate
in "struct amd_ir_data". It used 32-bit integer data type for storing the
"Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
"ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
Table Entry).

This causes interrupts from PCIe devices to not reach the guest in the case
of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
bit in the "ga_root_ptr" is lost before writing it to the IRTE.

Fix it by using 64-bit data type for storing the "ga_root_ptr". While at
that also change the data type of "ga_tag" to u32 in order to match
the IOMMU spec.

Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
Cc: stable@vger.kernel.org # v5.4+
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
---
Changes from v1:
*) Fixed ga_tag to 32-bit data type as suggested by Joao Martins
*) Changing ga_vector to u8 to align with IOMMU spec can be done as
   a separate change since there are other data structures like vcpu_data
   which is using ga_vector as 32-bit data type.
 drivers/iommu/amd/amd_iommu_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3d684190b4d5..f7cb1ce0f9bb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1001,8 +1001,8 @@ struct amd_ir_data {
 	 */
 	struct irq_cfg *cfg;
 	int ga_vector;
-	int ga_root_ptr;
-	int ga_tag;
+	u64 ga_root_ptr;
+	u32 ga_tag;
 };
 
 struct amd_irte_ops {
-- 
2.34.1

