Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079995B8090
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiINFNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINFM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:12:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B332D46605;
        Tue, 13 Sep 2022 22:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6SEEr6sEV5MtpGwtJjmnU6ztU+VOSiEItfFOsJQZRvUKgyZVYPLYU85NT+FEUPt/Ug3U7QmJWMLelAUn4K7JD1wq7eflhP6Eo7UsXz0jK0zfcuQSfgdvPD5ipvVa/AW9dGGrCLlBrHqyh/MN/2Lc+IctyB4NI8xE9P52DEuXCreJEQbheV9dX1WHrRRTu5gnqNjAK5esPvYw4rc0PPHsrX7VUxJKVZOVTNP3F5knOFQv+cYlznicMXVoA9bzb10DxBTxWR/cA3qXMoAFRVT+c6d8R7rU+4gE/RaQ0wz7MP7RdjVnfMIlXA9ocOXvd3MxktQ+3+DfQvs3rOgrtRuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO3eXFHSJKRFGhEPdpPj6fRbG2ZhcKNogQgsgNn9fGI=;
 b=M3gP/D6iqyEwa73EKxl3D0h7lHUOo7nK6wYDZ9DW1LzUuZuw39/AQZBJaUB0Z3tvCu+7hmYToIG7srSZIbUUty+fa8XD3n0gLCLVwEWlNAfEPbjUD+9V71pI/SyKMlgXxT8AUjCngIdAZuIXPTV8l/lgRg8yNzNpktZ7PSRo5+jxDloArOqZaMA7fobm17c7LkDuhcQIFc9K7GlW/9Uz/k5aosOzcuDRYbsX1p6X0duk1wwjJ0HBNHN7hoem2jn+Fm9O9cEJw+7bKEldiWrHO1oIxQmfqiIFxDX4wGQd39iULnmrlr2P9rqPR0jKQa4hYq1RziBTnIeW68amyk2/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO3eXFHSJKRFGhEPdpPj6fRbG2ZhcKNogQgsgNn9fGI=;
 b=RkaT+T7GgqV9msDIO4IVE9yspkT2TlpDb8YsWKq7UpI4C6tz7pm2FYqr2V/p6rUJOB1D5TXpxH8NMFlMv35qLWt02zWCohWGChhfK9FoHABbxO12bNOucxvLiWe3M9tY3/zsPH2fPgnyuUdlXsM38x9xOQ/4/Gnsr/2UBRJIms+tEOxLdWh2tEOmdiD70/JdzG/b/imeIVxE3avQId6P0vs3W2q9xLaK2Gdc1womi7v652l7L8jLolG6nh9uffHNSaj6LV+tie09H+bJ1y7eQDQE1Yia2pL+hoUd8oMf81LxIhjP7e33uTnr5xfo3LjAK1vQloA7qt62daDYrSryaQ==
Received: from BN8PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:94::16)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:12:54 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::d0) by BN8PR03CA0003.outlook.office365.com
 (2603:10b6:408:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 05:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:12:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:12:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:12:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:12:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:12:36 -0700
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
        <virtualization@lists.linux-foundation.org>,
        <kevin.tian@intel.com>, <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 03/13] iommu: Add return value rules to attach_dev op
Date:   Tue, 13 Sep 2022 22:12:34 -0700
Message-ID: <20220914051234.10006-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914051234.10006-1-nicolinc@nvidia.com>
References: <20220914051234.10006-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d251b98-5dd8-492c-c823-08da960fc751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zghb4wZ9N5X1o9qQA8ubbzBfRJ0o5Xz80/hPgkd/54iPtTpUX+1ejhtTzLTPNuHpgOXOX/R6t7nVoUnxEyQJEGhq0sZRDzcNj1YgeX/kkqEpAoRk1apEFmotCIlgm1rm8RgSx4VZOctuM+JQRLlSkxtOSFSzj6DeYfn0McsGuszFGfy1BpAr+zlMN0MNq9TfG5Fn265Z4myQcYoi9m6iZ4tavbTlay3rAGD6FnBRLkbKXH3Vegn1Yy3rKo7CapYUgf+8lBCwq1vfOv7t5dUgDiypRv9VzTPEE3yAgOkOE3cKU7Gq4MlZTOQ2dpm6zigMPnzVsAk4R2wMSl+K3AfVmQLbO7lbNTBCPo1tEH7xinoe6srpeEX1AtiJUL1xc/cD19u9Ycq8FYCIYwFNz7+5MrNxTx9rukWnPkKmKqrGV9kAUlvwwHXsE+XRoky9RsSJfNLu8ZOnT03tYjeftA/hfYD4LKlyKn9WfKELZyXO+Vt69IzBOoB6W42uzh7THLYt5mjb4kGmjkIOm5Z+AgQnQqWbCBdRWuKYokzAJsg/a1lg9rBzoR5P5nqz5qER63F0XnVOv9sBzF9TLigIYluCcbtvNbCrZacRdNJ/3MflOxyjGWJ3/pkaIIvc76w/xM3qwNDvj/egDh3pH7LwhY3kRHyajfjvHKv/IwFG3iylpvYJwMDbCdWVa/rMAyIj2+/hwTz+H1OZ6rOF1STPIFstq33U1WZdKUAnRVlxRFUZVfIZJFjY0zH1j1x7gqMX0PpU4taBA1K/zTHpAV4yzY/Q5LsfinPSJh7oM/RjR2cOUXC4CIEIJcnmPoi8Rkf05iOTZ6kGViYVA79A3EozjxQkWA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(36756003)(40480700001)(356005)(921005)(7636003)(86362001)(82740400003)(41300700001)(70586007)(70206006)(8936002)(4326008)(8676002)(5660300002)(26005)(7406005)(7416002)(82310400005)(7696005)(110136005)(478600001)(54906003)(83380400001)(2906002)(47076005)(426003)(316002)(2616005)(336012)(1076003)(186003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:12:53.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d251b98-5dd8-492c-c823-08da960fc751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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

Update kdocs first to add rules of return value to the attach_dev op.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..aacf9a2b151f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,17 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
+ *  Return:
+ * * 0		- success
+ * * EINVAL	- exclusively, device and domain are incompatible. Must avoid
+ *		  kernel prints along with this errno. Any EINVAL returned from
+ *		  a kAPI must be converted to ENODEV if it is device-specific,
+ *		  or to some other reasonable errno being listed below
+ * * ENOMEM	- out of memory
+ * * ENOSPC	- no space left on device
+ * * EBUSY	- device is attached to a domain and cannot be changed
+ * * ENODEV	- device specific errors, not able to be attached
+ * * <others>	- treated as ENODEV by the caller. Use is discouraged
  * @detach_dev: detach an iommu domain from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
-- 
2.17.1

