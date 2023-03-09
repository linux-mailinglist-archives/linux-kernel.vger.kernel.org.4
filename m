Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9826B21F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCIKzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCIKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6FAE7EE8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR3LTLXUWI45a3QY+pCl9l/JsFPsipaP0jXl9geDgpXVTKR5IJdUgEOeZOoAmeVvdJBXKqE7PuVctTqkEIRX2Ib+TpNP9initSq/13pQQ4h3FiKfA1dJPHbrPdH6Jm1drM1CTEpg+canRW8OS+kdmgKrqFeg+9qt+zFOOY9g3wJNn5diNgnmjhmJGFMr1oQ1/g3ZQLOt/sZZav9kaxd/lAU87GpHcR2Thy3vAhXk6SWvoCCCWy5ukNIiaTJzA0FCfTmpzExgdv5n/+qWBYWmGvTLb0AuC+54wx6aFtikoiE3FI2UgUKotVaI9I50ppYUArtmxG1Rxif0IPbpI7JUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5uh0txpedJi0zm1j3xWje6fBmSfQB17NuXIZ/aesMg=;
 b=Msr4ykrfztxK8pwD2H3Tq77sHWXn39BWcoht60COKlflpxW+a8uTFflPJnDQLP1PuYST0eofGY0vKM3+ZX1Txs9SqPGAyi3dJrbQe7yJ1OWdtLEWLMa3nRFQJ5TCUl4xbpvCbQAvKvn2jEQM5nU7GWXpBIAPNvwPGYrX43VTzJraLQKBfdUMfz9OwqGa9KKZ5dVjx6lpSW9gT2+bWbOspVACI72uR86SHH4SrwD8Gf/IpW/1YKKOBkPQyYf8p3UlJN2wX1DzuPAggu9PGJR7rJ9Iz4eMz0vmy5Sf9uqTMOH+sNW5UUGt+/PmfprFN28CoJxmyL9Sr+RmcHFZOEt93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5uh0txpedJi0zm1j3xWje6fBmSfQB17NuXIZ/aesMg=;
 b=lUd7p+yknPQdMHotjfGWPht+pbW9vXtohzHGCzwdsCdQWNh3qn9Ke3urdFBdPgepqrp+8aPl8rK3FFjV1RlbfRCwxhtpetQvMZ+wKCZQ1iPndkpr2jiZXSZ/ytPckNdf94lmEsnXpxjwg9LmHFlVm2QzGSxKboftrRozj/Pl/vW8nI/aidIcvPvzctIF5yZL2BY6txNhznqHWj7DmcubZcr7IWn8Jv0m9Pcf2Mah62ZBuGcuw0ItEMtTnqh8lb8XhrDUCsifrCP7xFWlYwHp7L+2jm6XXuC3MBOrKuQM+k7OoT8NNNKwkciNnicA+/yB+qFGfuOkaJLffmTuQBp9Rg==
Received: from BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:54:49 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::52) by BL1PR13CA0002.outlook.office365.com
 (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Thu, 9 Mar 2023 10:54:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:37 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 06/14] iommu/arm-smmu-v3: Unset corresponding STE fields when s2_cfg is NULL
Date:   Thu, 9 Mar 2023 02:53:42 -0800
Message-ID: <995e48fe6eb9e31c71dbe8bb80d445aa34a51819.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 5644ae0f-0c37-4b76-806d-08db208cb3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCS2MVoNx7iiFq1hrtdJt5LXJe8GoliRz9heG1xcNnoKSXNoajM2uCCXRkdsXeHOciR9DJOnU6E75GULglV/JOx3EXXA2+Q+G9+uoh0Ns01RVEgxKyNgFSPC1e/nbrm2LPfPKpK8yx+bOfSWJk09F2BxlTO9CZoAH8BqogjM/oSCpOouztKYsXf79jHWd3ho3txQyLa12nps332akDqoDQJgQ2zMYxSQFWjmt+K+xow2PhefTaei0D/730B1sBbXq8M32DE62pSEOAr738hkBtSG2st7VFdeAvpUJ1fTsPT/KG4pIMaYgM8seGN35R1eX+61d5rIobGINtoYIDNEsnm321SMvWTmLMnFlK0CclQvXt6k5bKs9L+TQFB6+nrgeqPQ2TMliXzJx56Dw6wuUBRcAecCmKQXX/OZpc5B5nY0OSb440VgtygWJLmvAp2nFPsc9Fg/q6M49AqHehatHsuXahxnqUyQlIdnityulCAONi+ulVCFoMegO5tItUzwpIL9wFC1CRNm28iTEZe4YPjXdhwPHPj8tBKppPd8DrYzvll9UoSO1WDV2fEnL2FC9Yr99urZRkCXURkxLW0ihlojn8BvQ/K803CWZDQFqpzSnB21VTzdKaLgSIHmMewpuSyQwBwKRsV01BZJVBkWq+z4SQT9irBsRgwUkkDeq+W8i3n4PG9hPpA6fpzPU36Cv3/MNwArq+7gJsDDYvUXxiAI40lNC79jE/N1icCmb7VOMFVmv0+V7c8yR4UGD7q5
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(82740400003)(7696005)(36860700001)(186003)(36756003)(478600001)(7636003)(356005)(54906003)(110136005)(86362001)(316002)(82310400005)(336012)(26005)(47076005)(426003)(41300700001)(2616005)(40460700003)(6666004)(5660300002)(7416002)(70206006)(70586007)(40480700001)(8936002)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:48.3315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5644ae0f-0c37-4b76-806d-08db208cb3af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Auger <eric.auger@redhat.com>

Despite the spec does not seem to mention this, on some implementations,
when the STE configuration switches from an S1+S2 cfg to an S1 only one,
a C_BAD_STE error would happen if dst[3] (S2TTB) is not reset.

Explicitly reset those two higher 64b fields, to prevent that.

Note that this is not a bug at this moment, since a 2-stage translation
setup is not yet enabled, until the following patches add its support.

Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c5616145e2a3..29e36448d23b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1361,6 +1361,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
 
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
+	}  else {
+		dst[2] = 0;
+		dst[3] = 0;
 	}
 
 	if (master->ats_enabled)
-- 
2.39.2

