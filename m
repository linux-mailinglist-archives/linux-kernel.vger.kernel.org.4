Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D385B808D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiINFNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiINFMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:12:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084EA46605;
        Tue, 13 Sep 2022 22:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8Q0KynZ9pHWl/oLZhuWD58YLjB/snepBQltfvm2meDfPwN2HGSw0h5+rQYd7DYFnHaZCkWOTaOsqfDB7rnb8hR3TBEZic7EhLopu9tsB6qDsS15vtnVTj9jSSCVJ+cEX5/hi32L1biGfMu4hAZh/JKTfvt4rkOVzUdNVk+cpxAayipq1N0CyXKoMRsWFO4+lIFUy1FHKsDCZeBS9jeD+dT6k+8fkVqC2ez2mgHnLf/dLBHX2zOKUiHB7wzAjW+52y2H1djK6Vg6syxa80191al0YzRYySPz8CllsweYxsIT3C3U2lIkpzjifodlM/gF3VGaHhJ80XdG5mJtQsHghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE2hIVWhfjTEpuJG/EQ8E2pJreIJ8xNfuDZvqSktzVE=;
 b=gbijA2r/nMzHrDZd1nQe4Vw+BRPqN4BQf56Y7UJWE2iUY8SWWYcGsPtLzFwYfdh0O9PJ/b1yJitO0e/RgjYfyXHVhkjpjLV/3eKNsOxcrA6He5v7nQIqqF/yzg03xMQRLe+Z1Ezf7hbaI4FcR4s4+melX2ygM2N3Vm4idLtcjt+/amypvZ8Sf5Z8BvAzzoeqwjMvfaxdxIaLTmUkWjZw+HpoLzQzJCmOwj/G6TCp5MMqahZjAus/wrD6o2V+CJhMa1VEHO/99baGuKPddbna63ODechdcQeHtBerdSnHXeCDgG0PDmrhu1GVJyI7OlkrUjOZsy1Wnhfn1G3IKe2GjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE2hIVWhfjTEpuJG/EQ8E2pJreIJ8xNfuDZvqSktzVE=;
 b=USTaB1YS4GHcOa657piQfpo38jnF3iiexlmFHoyguqAadOBHndClATA8uc2Y1BSPfHwbYvUIj6hxEriuhlUCDxmPLsOLqMYjuNPLDQdpowi2ERzlBTqMG1GfpPh+nJp2jmEza3IawHBBenh4WkgN5sHtbMycNCxW+lo+GfKCvZzCoRLvXxJy/qKWmJFc5xwKlDvPKsUrFGuVdq5TcqTX05dh9THKEw+is0r1PNqdlxJgK0QOmKO760RSDRNHORtnI3yx1t3RNlIRzp9AM5pYE85lTJXksefnhzHKgz3k7HM8Gh+KJ6iS+Q25Kf0G8Pyx1NmEIv6bT18v+9OF9eqEfg==
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 05:12:53 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::db) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Wed, 14 Sep 2022 05:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:12:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:12:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:12:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:12:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:12:34 -0700
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
Subject: [PATCH v2 00/13] iommu: Define EINVAL as device/domain incompatibility
Date:   Tue, 13 Sep 2022 22:12:33 -0700
Message-ID: <20220914051234.10006-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f1f3f1-e9cb-4b66-4acf-08da960fc6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MDMHSQINcu3hNZLEpSHEggsqvNOC55e9B2UkrRtNaSyH77qfHoJuNzZq8rrr?=
 =?us-ascii?Q?F/B8vwsC4h6IxScLBQJ4bG7PzAg9G26rYBWCUYioecklgh6G6crJtqaM6pVt?=
 =?us-ascii?Q?sL/vpAu+4Vxjg/7Zl9WCr72+0YhANWEeRiFp5fnV/xCrjGb0fra1kCz4SLSe?=
 =?us-ascii?Q?R9Zbu0HfhzQQo0YjA4kHhuGSVGA8s5+17ukvwwJrxJqumSokg8iBzocLAnTK?=
 =?us-ascii?Q?7Hdp3zTWjKiLRFQ6AN7oIKhXIN9k3N7KNuMJ/JzSv2B9KRrSO1LhrKLHcazq?=
 =?us-ascii?Q?/JkOkQPncb5663xzHOMC8zl/MKIyTnz9U3Q6UYo27QIGhtBhsfsc7spMNIkf?=
 =?us-ascii?Q?Kgodk/+8fE3kxks06DxrX7VXNuLj2Uvq54OG3tWDAsrvsvescg3Gszf+lH6K?=
 =?us-ascii?Q?hnDyJ6Jv8m7P1nAfnqRN/p5SPN6LpXO/Ap8Yl4FO+MvrFkHs3HghvZu/NCSt?=
 =?us-ascii?Q?cmw9jUOp1Wt27n+qzFmqXTUYyACK4JbUbi1nZq+tyZiLl7Hjhn0B1cHU8uf2?=
 =?us-ascii?Q?wije5dC1ghnFxexb6joETnw5jSdcFDVtb8eBnji7WpeeRMK6TXCoNaZmTC2n?=
 =?us-ascii?Q?/rlnzhFn7lCyvZISuhjAsK4BAI8p9XIsVykMCZDHGFfQSyy+QeTabV/hWp9j?=
 =?us-ascii?Q?3STNzNrM6sliPgJWmKiOpYh9xkUtXEMgrQCwNxuZDEEwMmSU2SMu/lpyk/+/?=
 =?us-ascii?Q?6gN0rHMvejoEVg1fyxAvU5ViG489uu2KgGZYYr4zDJZb+TeKE5LEfNIQ7vuh?=
 =?us-ascii?Q?mg18xOFIVbX1F3WADLGC3bPrOgTlt41+mhc+Wu6wVoJTyhhdU7hfsBW1VDNV?=
 =?us-ascii?Q?aSr3iR+hiprSG7nwaWLv255HND3OUkeo0I6mL3cV6SsolClQRoek9FW6Fvma?=
 =?us-ascii?Q?3NgMlIGQgf/yzCkfUMgjPgeHYsnVWy2wHrDVHIhV3Sy4+0jQwU4Q8OCLL9TY?=
 =?us-ascii?Q?7zHitjGKxWhW+LY5Fy4RkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(8676002)(36860700001)(40460700003)(316002)(70586007)(47076005)(36756003)(478600001)(336012)(8936002)(41300700001)(2616005)(1076003)(110136005)(54906003)(966005)(40480700001)(7696005)(2906002)(26005)(82740400003)(4326008)(921005)(426003)(7416002)(7406005)(5660300002)(186003)(86362001)(83380400001)(70206006)(356005)(7636003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:12:52.6105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f1f3f1-e9cb-4b66-4acf-08da960fc6ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/

The purpose is to regulate all existing ->attach_dev callback functions to
use EINVAL exclusively for an incompatibility error between a device and a
domain. This allows VFIO and IOMMUFD to detect such a soft error, and then
try a different domain with the same device.

Among all the patches, the first two are preparatory changes. And then one
patch to update kdocs and the rest of them are per-driver changes.

Although it might be ideal to merge the previous VFIO series together with
this series, given the number of new changes, the review in the IOMMU list
might need a couple of rounds to finalize. Also, considering that v6.0 is
at rc5 now, perhaps we could merge this IOMMU series and the VFIO one in
different cycles to avoid merge conflicts. If there's less concern for it,
I can respin the finalized version with VFIO to merge into the VFIO tree.

This series is also available on Github:
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v2

Changelog
v2:
 * Fixed kdocs format
 * Grouped with the virtio patch from Jean (with a small change)
 * Separated previous ENODEV and EINVAL changes to per-driver ones
 * Redone some of the changes to have explicit return values in the
   ->attach_dev() callback functions or their direct sub-functions.
v1: https://lore.kernel.org/linux-iommu/20220913082448.31120-1-nicolinc@nvidia.com/

Thanks!

Jean-Philippe Brucker (1):
  iommu/virtio: Constrain return value of ->attach_dev()

Nicolin Chen (12):
  iommu/msm: Add missing __disable_clocks calls
  iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
  iommu: Add return value rules to attach_dev op
  iommu/arm: Constrain return value of ->attach_dev()
  iommu/fsl: Constrain return value of ->attach_dev()
  iommu/intel: Constrain return value of ->attach_dev()
  iommu/ipmmu-vmsa: Constrain return value of ->attach_dev()
  iommu/mtk: Constrain return value of ->attach_dev()
  iommu/omap: Constrain return value of ->attach_dev()
  iommu/rockchip: Constrain return value of ->attach_dev()
  iommu/sprd: Constrain return value of ->attach_dev()
  iommu/tegra: Constrain return value of ->attach_dev()

 drivers/iommu/amd/iommu.c                   | 12 ++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++-----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  7 ++-----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  9 ++-------
 drivers/iommu/fsl_pamu_domain.c             | 12 ++++++++----
 drivers/iommu/intel/iommu.c                 | 17 +++++++++--------
 drivers/iommu/ipmmu-vmsa.c                  | 10 +++++-----
 drivers/iommu/msm_iommu.c                   |  2 ++
 drivers/iommu/mtk_iommu.c                   |  9 +++++++--
 drivers/iommu/omap-iommu.c                  |  7 ++++---
 drivers/iommu/rockchip-iommu.c              |  4 +++-
 drivers/iommu/sprd-iommu.c                  |  4 +---
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/tegra-smmu.c                  |  6 ++++--
 drivers/iommu/virtio-iommu.c                | 13 ++++++-------
 include/linux/iommu.h                       | 11 +++++++++++
 16 files changed, 69 insertions(+), 69 deletions(-)

-- 
2.17.1

