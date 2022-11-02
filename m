Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB21616310
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiKBMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKBMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:52:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43E22B16;
        Wed,  2 Nov 2022 05:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4GecxCeESLLBRoHN4DK9yrhSW9QHt1Cc0FXIp5jv0Gany9t778AzDlVEEfEl7GJW3LqRJ+eBa7MU9nmacc44nJmKaEk2Ip+EwDuzJOpv3fqQ7m8oscPq/2PhVlSgCLq7vQ0H7cS/SoLr/pKq0PAPBa/20Rva12tIxqyvYlsVDVkqVuFZI0MP+ZgeLEo70jz9c9Kv3Gyp8ANxWIhyW2F2Dk0hA4Bl/JT86g/SA/SyV2EMYiuNdFJikABsNwzAX+2mggEA6I/6eDuFoVKo846WU79uJw0mZb/eIMrirBmpDy3Gof0ainqlfzw5K3FKVBMfwDPm1BuRVtbgeLzKOVPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLn5sm9jB4iChIy9YVdBNcIz/Kc3dpqgq4R0HzGWXFE=;
 b=eusigoItp5nWKIK0O6MnVrC1OQzXwGz1gjwrg22SP2m2Y/hM/LirzB0C9xj+kLNpEu4InYuXbAthIZtU6Exs/b+bIt5Aj5rouqFTyGKPjgCDPPALGd/fYSSx8nfVcfRC2nS5oyJBtwBSXdpUxHRqsnd/wAeQNOCO61HmCaX+FlM5occ/imcJdoN9BMwQ9T4F3K/mR+6ZnqyFP1rc55RXRFg3vobR3WKrmIiy5j7XfuUrP8+CpIWOkTU/Q+OlnhCVqpgfLgMCm8lFkUt9A6TLTVxmQfLucZzFgWc0tUifHkrd7dSAzlFkWPw/9vlBKqInkXCrZqlnhYEasx4tkqvWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLn5sm9jB4iChIy9YVdBNcIz/Kc3dpqgq4R0HzGWXFE=;
 b=EgDkb9Ce6HiMCWPOUcf+W8k2g8ia576DbpgXMuMraoLsIpEgUqpNWmX7n73lARaZJI7v+aCTBW0xdm0hWRWj03Iy4wqNHgKSWb2Hg0x9BLzGHsuUTIb90lxBHTEQtj+kOtqugcRdR2oaWlbDzVajhtgjVoeS7QgsxpoEFE68r4X5llHlnrw/8ZPF6Pi/Fbo2qwBpGyNLwIBMM4W3jPfzECrBBJiJCMRXmYRPgN5kcCFJHgMNwZHFWR8wIrY8iLt9BtBAFGRh4xBGyaZpf3mjKbLP7cVHsdSyZKZx0PqmwJIa1mL6SryxcVUQJK+dadjvVBWa+KDz425jmybbxBgtyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 12:51:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 12:51:57 +0000
Date:   Wed, 2 Nov 2022 09:51:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org
Cc:     will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        quic_jjohnson@quicinc.com, suravee.suthikulpanit@amd.com,
        robdclark@gmail.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        jean-philippe@linaro.org, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, yangyicong@hisilicon.com,
        yangyingliang@huawei.com, quic_saipraka@quicinc.com,
        jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [GIT PULL iommu] Please pull iommu errno changes
Message-ID: <Y2Jn7Jskqzz95XB4@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BsckruZV/wiPefnD"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: b10d7d34-15e9-4218-36b7-08dabcd10705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARK3huCaEMhr5z2Ic1nE43p3WsDZXRkRM97w4iKFpBahUdzxskIKC7KMPzslZYLkHsRkL+pghhlG3T2ncrAyfMsUDybrimHVwsN2Lc8rfV/t5oy6K9dggZir51xm/JPd+fyvsu2V2SApBNRiyssS18Vm0/WMJX5RzSK0gdT9ydKe29ZTHC/qgEETFEz89ruvoeq3/Na2/+lb95JiOxaoibPKHCDJhiQiNG1rIPNymfSdxIA6ia8sC0X1sVORw/FvVtlE68ymuRtKw32ChPhNzWoSllrsP/SdS3R8kIqauYKbzkDPxMCn8eMru7xSS5X5bEObav1JXaMlNjBCKUTINWnJOHweRObMIbW3EKGKLXsVAZ9lFnsVSaquK3rFiaA/HnIaG/wlb2IBdlJTilLzWMUZiURurDukAXi5YS/ESkbDYsclIhbkzvo9mca3pJTjzJODiSZOs/2tw4LLl+ICf4dK5ff8yzCM6hx1nSagfpTPCROp7Sno7kRP7yzyjLND9Z+X2K2AsipYXQjo8NDEWoT34o+U+Bh1Pd201WUZRocdsoG5TURviw3aWcXEY50dAaHCJYFNKnBuCx9EXMUbfwFrdVXrq+XZ0OXav4iKNH6T/9LMkARF0p3m0kjwfd7eJ6DCn7foS8sbwHt9xK8LpS+vBGFcx7Q7Cpj8ikeZo8pkldfhUoe/0TzJ1Q+8uxVrbAJfZyZbQs4iVpkFFoVCKv+QeI9KBxoAxjEvFra9cVQDUuyOzSUaR1DcFyZ898rARXX9M5w2O+udIwTrrkboF4xJZ614k6d+ZsNT/vKUJvBxIPjkOJUCyW6bwaP64w5DDCA0PBlhQBk1+4sILt0rGk+epZeH3kTFePyaJ52P7fI8KsLbfFkXDBiXJETQkXoH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(2616005)(26005)(44144004)(966005)(6512007)(6506007)(83380400001)(21480400003)(186003)(478600001)(2906002)(4001150100001)(316002)(66946007)(5660300002)(6486002)(8676002)(7406005)(8936002)(66556008)(7416002)(66476007)(4326008)(41300700001)(36756003)(86362001)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPZJsHVeouuiYW5XvGOo42jp9d5dkFhSoMCVJLI2Sw3LW2Kj63Y0aOV4v10d?=
 =?us-ascii?Q?fHvfr4uLfSXL7MyQU4DzM43m6FKHunBVCry6RNU4dTy5ipklhb6BhVnnF870?=
 =?us-ascii?Q?xvwWeTpyge8ORsaIffD/vDopejaP19TTT6htKxjPYHBxpIzB4TyYukpoTI0v?=
 =?us-ascii?Q?pMC8Sp3nhoAyYGhFvesyNYeuuO33DNzxDN0bok8/jrJXNHRa9NdXd74ot9jz?=
 =?us-ascii?Q?mN3tbW71SCrdAeM2RTNNDsG5PSyAtkorT2T66BNNktgdTU/ZpcdGrf7s/dLO?=
 =?us-ascii?Q?dcpaUxe1RYeetbLyZYFP+M3v5wK+9/Vp4PZ0lmznNd9e0Fmx8i1/U+ZZdohY?=
 =?us-ascii?Q?RLWEtIJECb0gEt1d4zug78dAFico4DbRpi+sgQm4N77mj89gPnF49NstNpy0?=
 =?us-ascii?Q?uWoGcl7Mtimetfoiw2kwlS4r4wvmscDt5fDHMjUQeagdTHqlMQijJzot4XTh?=
 =?us-ascii?Q?qDgWN8UDTNCBhehjQvQNDgh57jQsxwzG9v/BmERiqQY57YYJE4gEXXgdD89c?=
 =?us-ascii?Q?uRJup2ej495XnsE3sl5r7dX9ySP6nIag7LS5QRLmO/B/ORq5EHrlFANFxCyF?=
 =?us-ascii?Q?fh6uRu8sS3Duwz/Q+y+rGRkZDLJMslKjqQBcZlB08oy/tM8DlfGmSy4Py3/7?=
 =?us-ascii?Q?1wy4ZxU70Le5z24bnIPbiGZH12ofmIMX7s8xoLPNaCNur7UktTJSx8nhg1it?=
 =?us-ascii?Q?aEQ3+T6Zzl2caOpRlV/3XJ4zibiE8VsRgY8HHaF9bCaV0j+BX8dZsqfHcPta?=
 =?us-ascii?Q?dOsPS2Jkhv0MShCS3KOs49PD0uMBoR78AbN8U+4tfUbRIKnreeGQlqOVlt6E?=
 =?us-ascii?Q?4uSJJUvgnUTy5xGZVylnHTtfg24w1KAxGMs+pcQ8L7weJBksvv+KfA/R6grM?=
 =?us-ascii?Q?+M360GSm3OGPM7k7WI3vHsCRQZEwCoDwczaEwJidoJvtfF/usvcAVcVPieRn?=
 =?us-ascii?Q?OnAgb088sn3l3BKeeTTzKLSICky5rB8zX/KwPIqtxkk8VpdEK9yRqpEOYgyO?=
 =?us-ascii?Q?kukZy9joLHo3aA807OIloL4f6NsyTyECShMKmM+/vRIdOK7g5CbREaeqIyKA?=
 =?us-ascii?Q?WrkMeRcFq7adEHKTmoNE0I6QpgaFgPiWiR2BKWOLZaF6FP56uj5P/cIOKJau?=
 =?us-ascii?Q?W5jcKePepCWoxzrGcgPrD6/8xUCxfbridX3JfW9M9kfYqDOR3tVOohL5BRkY?=
 =?us-ascii?Q?JUiZgJgXeV2Ab7hZ3LIkrFGIb6Ls23QQy2evBjYe/NAx1M29Gf4F1QYTRpfD?=
 =?us-ascii?Q?etfgEC3G46nOXbuEZ4wkWfaYC3hEkH4vBb0tGXhVfjSH+CPsxZmnAkjWC0+j?=
 =?us-ascii?Q?Zy6zotqHVmsUzhwHA1QKBSkht6VLsYCZhtEfYJkaJD1s7lZTcYkJPR0tvstg?=
 =?us-ascii?Q?Bd/ZbR1bu8w8JS8zOWA5xrCPr8hFf5nAYsQywY3XgAOnHhICBvsosawuRAD1?=
 =?us-ascii?Q?F1Z8ldqj4ldboubK8beM++ex70Y4diPBGstxBsJcA7DCTTkfLfLbzvAfScMT?=
 =?us-ascii?Q?Zv6u1beE3lNs3/EC2oOcmIma4VhgWg/t/JyA6VBGAVGCp6lcfRFlEGkDHt05?=
 =?us-ascii?Q?xZwF9bKEZVUkRgqRQIA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10d7d34-15e9-4218-36b7-08dabcd10705
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 12:51:57.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPIODLA6cxMKQoeY5mqiiUMadmsHrL2eYQMqaoyudGEeXLEYQWQQ8OmPBs1qg+85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BsckruZV/wiPefnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

Here is a PR for a shared branch with Nicolin's series. I will be
putting this in the iommufd tree right away and Alex will need it for
vfio as well to progress this cycle. Please grab it to the iommu tree,
thanks

Jason

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg

for you to fetch changes up to 04cee82e04d2aff3d177ef0021ecdff228daf7b8:

  iommu: Propagate return value in ->attach_dev callback functions (2022-11-01 14:39:59 -0300)

----------------------------------------------------------------
iommu: Define EINVAL as device/domain incompatibility

This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/

The purpose is to regulate all existing ->attach_dev callback functions to
use EINVAL exclusively for an incompatibility error between a device and a
domain. This allows VFIO and IOMMUFD to detect such a soft error, and then
try a different domain with the same device.

Among all the patches, the first two are preparatory changes. And then one
patch to update kdocs and another three patches for the enforcement
effort.

Link: https://lore.kernel.org/r/cover.1666042872.git.nicolinc@nvidia.com

----------------------------------------------------------------
Nicolin Chen (5):
      iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
      iommu: Add return value rules to attach_dev op and APIs
      iommu: Regulate EINVAL in ->attach_dev callback functions
      iommu: Use EINVAL for incompatible device/domain in ->attach_dev
      iommu: Propagate return value in ->attach_dev callback functions

 drivers/iommu/amd/iommu.c                   | 12 ++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +------
 drivers/iommu/fsl_pamu.c                    |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  4 ++--
 drivers/iommu/intel/iommu.c                 | 10 +++-------
 drivers/iommu/intel/pasid.c                 |  6 ++++--
 drivers/iommu/iommu.c                       | 24 ++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c                  |  2 --
 drivers/iommu/mtk_iommu.c                   |  4 ++--
 drivers/iommu/omap-iommu.c                  |  6 +++---
 drivers/iommu/sprd-iommu.c                  |  4 +---
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  7 +++----
 include/linux/iommu.h                       | 12 ++++++++++++
 16 files changed, 60 insertions(+), 56 deletions(-)

--BsckruZV/wiPefnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY2Jn6gAKCRCFwuHvBreF
YaUcAQDVwu1W5Ju+SReB7lFO8un7TR4IDb/buDjg8mi630JAhgD9GoSb648jPGRW
zo63odNSUA/R1ly8EBdT/qL77ktaogA=
=HzjF
-----END PGP SIGNATURE-----

--BsckruZV/wiPefnD--
