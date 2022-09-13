Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF75B697F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiIMIZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiIMIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:25:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B01A3A2;
        Tue, 13 Sep 2022 01:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IABepUh0M+SKT9Mwqt5FeMGa22QIMo+UH8pBhEHWDIFccMrWcH4sARVwwcLGpSnjw+T3RkBvaiqI1aCdg6QUKSsmuk6SPnSrhriKkU3jOQV2R13o4T/Mc9baT4PD92rfzKv0C8LSWTFNz1Nlp1iyAvnsRbqEwZTKqsmKUErTCgzRgf5aSDA0ymp1XquwSbEvIDCPWSUn7P6to/E6La8CmkU6vcc88EH4AErIrgdhkNFg4izkOXJxzpUZ5nmH7EGQqGUDaMv/qS56ngKzRHJMIG6ROkXZjoAOlMfV7g85rHdgYCL2apEmEpfSmfKjiFGz+rLl4hIRVtTQGOfM6BQQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwCQi4CIBvJZXrZqmHYAH2TI7NP6us4Ywl2W+mDuQh8=;
 b=KETtcqXB9vPljM3F153T0u2RpbulYHBQR2MS8KX8/JtzIiV8uUy+KgXfBtlFG09i6CPYi7179Dgn00qjVHtsjP1SPG6L+9jFczNvUo6B34CzLk1ylAfxoT+JlDK3TI4ZyzaVFPU5qyEpWEAtFE7q586T9XJuW/IR5qusvBaAJD8XFPAGxJ/OSP3BMLYwZ02MR5j3tczJG/JNjeEV3ZJUaSSOEx5/nq7kOsEx9n/1JdnlC0BF2uuTvCQ8HAfPi1wyZj54ZNcbGbMY4bPtlrmaA/esVC30JTUeINW9KgYINKDLk6jemq/s+yovv/UIdmSqczK0jY+wQVo99Jh3BpSncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwCQi4CIBvJZXrZqmHYAH2TI7NP6us4Ywl2W+mDuQh8=;
 b=RKsJ4sCq4FF3r/GDpzlLFMCPsVMquYQ+tLNWN0IiweZFdgWVRvnAlSgzVpJY/mp+xm6tOq/wiZPqI+g4va2AkhUJBfRV3pJxhR8PLKp+zQIQJDjmv+wTsmOJITdkRN1jeMS1PYoZV/rNRQY4CyLMxAEbRgfkm8/t9kOqHKh56+SP4MgEFScVe8gfRgRWKdctj7KY5t3Md82SINS6W/hUfvtVwBz+peoemmKwJ9YIxZmnY7JvjrK/WSiX8ZIvscVjHsKO/n8GVWy3vL7wtTPZoSlwlZwcMCdraEckbPbrv5PHFTUeRqER+XRX4tV7DG8UUWHB2JiUoR19I/+SXC2Xvg==
Received: from BN0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:408:ec::28)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 08:25:01 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::93) by BN0PR04CA0113.outlook.office365.com
 (2603:10b6:408:ec::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Tue, 13 Sep 2022 08:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 08:25:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 08:25:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 01:24:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 01:24:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 3/5] iommu: Add return errno rules to ->attach_dev ops
Date:   Tue, 13 Sep 2022 01:24:46 -0700
Message-ID: <20220913082448.31120-4-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913082448.31120-1-nicolinc@nvidia.com>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|BN9PR12MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a303aa-49a3-482a-f547-08da956173cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQeY4K4dpFGNjBMs9GkjFgZblTv6JStd191oDA1OyxEwHYZRLkHwreiYt1rOEGixZ68HlvYkvUiST1b84fPa3sRVdsEAs274xg/BdDWUcy6hGdTcMOJjxJlzAR4MvcohcQkKZnDwSpE/35zpUCdLMg3w8BifWM4Uf5LZ9LuEBwMmwedOF5ORmUb3fj5iCY2TfDPFMsClgTRb2rMBpl3K9xY1iqi1fc5Lsv9MuPiIkJXtkHlk6bNA6MGFS91kd2VSKkj3C6pUPqpJ3oZxQ8l1z0+MLztocce3M5OvX+cQrFokG30JbaP2ikfid3RuLxDYvSAJSnzksEI0lZfiZ58C9dsTbS+mOOG+4XSeAR4ZvecmWp0iPSp7Zjv/MEG8x3ZjXP+JK/BH0TwW4JLrnt63IWX43xh0ex/VIxZdL+PS4REQMYSsPbsamu0sfPJYmJtO3XKqy1JIaUejc3tgjdLG49zI0fQd7Oqh6vfAWB1+apCEo5RM+TBXyFrcXK5AqRk3L+oA5gZd+9MOwwHoHlSC5wT/+EZYhBuBZffRE3rDSe2NImLI692oKXFzNVoOojjsmwMOs4vovfSOH0SDs5D7rd6jDGAma1KycCNx6eeKw0n2T0I78UnqdicE7cmfFytLBJR6+1K4JdQzJRpu6cPJ6Lw/DDF+tqhRko1pdrvyaYvDv7/CL+/ZjBfVRtOvsrzUV9q9XNtD84LfB1PqdgcICFjBlHOqxbnli03t0zu0US6nhjXlueO9DS+fpT7T2V+yMtzVqRMquGcNGUgR2KUtT7pOyqQu1kMDLIN5W32oeVK5P1Utmtywg0i8d3wTpDy3XOHtw4tmNbq9Og3vYGlvsDRMWu6IFR2U/t2AsgVUknrXdr0YftnTFlJoeEL8sSVa
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(316002)(5660300002)(70206006)(40460700003)(7416002)(186003)(426003)(7696005)(40480700001)(336012)(478600001)(36756003)(82310400005)(4326008)(110136005)(47076005)(921005)(83380400001)(1076003)(356005)(8676002)(7406005)(36860700001)(70586007)(2616005)(41300700001)(26005)(2906002)(86362001)(54906003)(82740400003)(6666004)(81166007)(8936002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:25:01.1846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a303aa-49a3-482a-f547-08da956173cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cases like VFIO wish to attach a device to an existing domain that was
not allocated specifically from the device. This raises a condition
where the IOMMU driver can fail the domain attach because the domain and
device are incompatible with each other.

This is a soft failure that can be resolved by using a different domain.

Provide a dedicated errno EINVAL from the IOMMU driver during attach that
the reason attached failed is because of domain incompatability.

VFIO can use this to know attach is a soft failure and it should continue
searching. Otherwise the attach will be a hard failure and VFIO will
return the code to userspace.

Update kdocs first to add rules of return errno to ->attach_dev ops.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..c5d7ec0187c7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,17 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
+ *              Rules of its return errno:
+ *               EINVAL  - Exclusively, device and domain are incompatible. Must
+ *                         avoid kernel prints along with this errno. Any EINVAL
+ *                         returned from kAPIs must be converted to ENODEV if it
+ *                         is device-specific, or to some other reasonable errno
+ *                         being listed below
+ *               ENOMEM  - Out of memory
+ *               ENOSPC  - No space left on device
+ *               EBUSY   - Device is attached to a domain and cannot be changed
+ *               ENODEV  - Device specific errors, not able to be attached
+ *              <others> - Treated as ENODEV by the caller. Use is discouraged
  * @detach_dev: detach an iommu domain from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
-- 
2.17.1

