Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA03E69AFA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBQPj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:39:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67FC4CCBA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:39:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO04+ceVXrgNNT+Ni/MMELB9u1IQUAc4Umbs6uec3MBZkLNUCgkWeObWYg3GtNxHrL9KNnA9EtvR9LjmJN3F1hnbgXO13i67i5DpPENQ6WsFkFmkz+h/GxCTJ4giD7HHbNDEUH7/etebqCJ/vKYFvD9jFZoNQRISpP8zp7Sa74u1Yzbwi2kG8D/Rg+6C4nmRSA1AgtEWke+v8er7Z7BchzHHY+VR8qz2xoVDEu2GcwCZqqpth3xlIVOokflNaHlH1LT4LAF/JfGprzztqc/Vr6OVB3q1Sc1DzIHCtOyqMRK+xqRBwy2MdE3+4ts1zWUu2spiJTQe2cH3qimSjmaFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7lJ+oSeQv+M9LerBGVLUbCfgU/6fhXwFnE+HxEuthg=;
 b=OB5j5GyhLBo86d86JGpxmf/QXeWHv8Vbx0NTvb8G0NmEZQPCFsNRPcuoPq1vLBpZous+/jFOkQy17Nwsuo4/4wVLrb5nYzdo64qi6vSz345abvVinR1uSOnzWYrdTT2z8ogn0qIkeVgeM7vgRsFpUywYOQ+NDWf6myyigNslGereZKaNNI/J8jWlh6vsEGCrSaUdkvpWaTkfYzm4rgH2ndjV0FvBHzdzcXpzzdZs5kg6BTQyz8sCHn2d0lxE4o8vEGbR2pzqZ4MyCbyP/emPMTba36tJL0gBViOTCmxcJIU8LN7H+Bs+RjzTP95yrG7gXys1bUYr38ZgbYCULHN3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7lJ+oSeQv+M9LerBGVLUbCfgU/6fhXwFnE+HxEuthg=;
 b=TsGBivhXRbOOy6ZY72XPmMsJt9RoE/WPHfpANsIDCnmxsmCcpcg6XK5LrwqEMLZO1eN+4XyzX7H4HEy/vNsLqn+rYzZc6KUVgz96WJ7zjG8+oDlMQ36ko6LxgHcJ7z2GKvdirBEzfE8xOlUkrpfz2ozZm4LQgMblWaD4T1F/E/RgK1RsqRYUzPiwFmhJO4186U87JaXX7z4cJc/hHXjMMgPg6XwLRoNdjFlGKSR+K52oAw24apZnQCFOKh7DR3DAhSOjmPF+fzjc60dyuK7SrPAoAmymvjQjq77QbnUhcyx6hAWuv526y7250kvVAm/L/P3H1cUsU7bxXQR8JB+Bug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 15:39:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 15:39:21 +0000
Date:   Fri, 17 Feb 2023 11:39:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ARM/dma-mapping: Remove iommu_detach_device()
Message-ID: <Y++fqH7Eeq3Njoa9@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217094736.159005-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:c0::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa77511-aefd-45a4-0165-08db10fd23a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDaqxYb5JN47z8gz/rQ8rAD8W5CLWPi3y8e8H82XoKkMKDUwKIEa2sMoQPqVkok8Fcx/4TwhuEVTg3cF/F6vML5L/Z8IPrArPJ7aCmi2Fv73isCxhrOVFeOIAg7SiIv1FHxMLdprcttxaXC9pLchxmI5otxWXknQu0ecTKn2d7MvwqUjz+PzWtTDtsOVJjv1PXC79Goj8wrD1OtYwOrs3ZYmkmaoiGRKQvVfnnBuIzV+doyiq9i5DmZu/RglnMl1zu0kIX3yZOQOkWPuF6BqoLFZs0tkKMlzhlO/0pMPeO1Je7zBNQDNgj6qsSJiSiKsRMD3gUIE7L/SnwiKJR20tudQCaum5KGK1Gun25vlAmxVpZkgNJn9hCKLniJmOYLw1TjBQKkIGArbMUqIl7Joy9M9tmWS91HFxfREM+NcNkg+iqsH4y06HoMrr1VFVnwtArXbRxZxIOlnC8/quWvzAAOufjX8ZBmLrdrWQg6IcZ54/dwAgtdfgzrPA79kL7wzPCx4F8RL9p+CZhYUraXf0mLNPDYtIOeFAlN19Sf65zoEqVYlp3QzgrCLWT6SUMOLiACMZyiYLDCfDT0BdAaHl+aC99BSS69rzMhEnv3c3zoPgkBoW8BHJWoTb8e7+Sg6x0vi2sWTz+/l+wmxDIeOIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(478600001)(6486002)(26005)(6512007)(186003)(316002)(54906003)(83380400001)(2616005)(6506007)(8676002)(66556008)(4326008)(66476007)(66946007)(6916009)(41300700001)(5660300002)(38100700002)(8936002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1oCJpC2C8Dffg0Zp+2CWBG0WsAgXs6qcZBKZ6D+WSl0iZFCuNJOKpGNdOXlU?=
 =?us-ascii?Q?feTv2T7OFS+4dJQX+WGAZNi4BqGcLvKW9O7ivcCpW2pkNyqVMeDj4GwDAYSI?=
 =?us-ascii?Q?i6gc1LzsXHMKvqRDeGFlwsVZZDBv2asXwqItCIfGtlTqFPD/I/fil4LUAUHw?=
 =?us-ascii?Q?HEyOHECaf8oj1oIEkVTONYHsUKkp+kpf6Ti9zJnv8CjrtWYFmK54Ml05HSVm?=
 =?us-ascii?Q?dSa7Dme0LkxvOhfeT9TDPNtc0hgdYH+uz1z+KvPrKm64vcDvWX0dZ4PciYPI?=
 =?us-ascii?Q?G+G/BIPptkPtAO5Q6ckLdUPslKKX6U4RQMn5L/LGHgRx3fcbSvfsmqrH6Vgq?=
 =?us-ascii?Q?QgXAZmQD330XmI9on0TDHFnxLiPy5lO//uI2qbWxG1Ab1juVYI8jdLNHECgD?=
 =?us-ascii?Q?oEmtFc9JOng0bf8XLQMcJgj83kgNbdrG1oflKlMrVA1tc/HEjB3Xu/BnIQne?=
 =?us-ascii?Q?Dftabheuxq6DvF8fAUzdsgynj4rW9Mr0MVHAp3jMF6yzgbR/lzko2ihxrgg6?=
 =?us-ascii?Q?Ma7or46+KCWx5zlkhJnxZ9xjSGcCxbyPAIt1zzfsJ/ero3m/3cd+v0UAqYVT?=
 =?us-ascii?Q?1obV0YFMdUe7xmnKLlSl2NVyDTSWlrkENoGJce+fSxRKK0/SBpMyjMRd4Fgk?=
 =?us-ascii?Q?4WvFKFu/8axrhjvClgpvBNAQ7Ywe+bu/P6kLKdZJ76XBMcFY1HBQ4otojY40?=
 =?us-ascii?Q?IadaohW6v4uJGNv9/aQzeNIVwFNzv/i1wicZEaebERMzlItw082Z+oXCi9WK?=
 =?us-ascii?Q?C/Lu9qlhXFuTe9BffajTdDaNcEWVAIdDMXgBQUytpkcEQz1jsT6iaZGQOQdG?=
 =?us-ascii?Q?+xjqYqjSEkZGD/xNWexAyMZX46KiKIMmPFVCZCqORktmYv7gN41PQiXCzLIN?=
 =?us-ascii?Q?bg0IkQ8XECNsbL3po1foe79XepgLDVburYtABWUqrS14qON/AY/thVGMNdXI?=
 =?us-ascii?Q?JuMA0hYlGMQsufVPC9ZjeigdhbxwTp/wuTye/0k3ckchTPR7KYmiB46jj9Wc?=
 =?us-ascii?Q?mRe7rnJeI5R39rL407Tomb5J2q2Bo1iZapUDmPvK9pN4gZL9vlMQSVffTI9X?=
 =?us-ascii?Q?HuCLAJKBSKG+OWGQKAkTSSiibkBytG2VMPct/FwzEDa7xMFiTNjveS0aGrNx?=
 =?us-ascii?Q?AMhY5xmh73zP1rWpzaQgdsFfliMlhKtltVQHXRv13dq/khXwHDmeY/9kf9RV?=
 =?us-ascii?Q?3Vz9/h7Op+rvt35Evf8cqFjShE2Cja5illF4hOvLctpz1CTT77ApPIAq5U+F?=
 =?us-ascii?Q?kpeuyiYiMLVFyfAM5dDWicSdEXbLZrCXgPrhJsObsmPBbCJpqHTc8145dJJ8?=
 =?us-ascii?Q?f83t0xeZ/LQlwOQch1tmVlhFnalxMekZmfRhTJLKcPjnAgtdycbXC9RGWHhd?=
 =?us-ascii?Q?RbYH1+UJ7PFLGOLQP6U5b4hOlsTa80Nvow+DebncDH0C6mCS+iAdCP8MVQYM?=
 =?us-ascii?Q?KGOO4TmmUO8hoU07qGIFmUsEK3exig8D5QWsUEzgWMBIZEnJR9zhazhmH38z?=
 =?us-ascii?Q?X+yzx3SxEa5hJI34FrFBH0bIAQggob47VQknUHiq70zf8CZgRjdznd/SK108?=
 =?us-ascii?Q?gOsK2XpOeKDIqgO/elWodqBvHzUkOuZjDFooYDP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa77511-aefd-45a4-0165-08db10fd23a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:39:21.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cljAA4aM5/Ly12VJwgag1RGXoyOCnp2TWJ9LKKK3Jt8etPVpiacwtIQBKkzveL+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:47:31PM +0800, Lu Baolu wrote:
> iommu_detach_device() attaches the default domain to the device, or if
> default domain is not supported by the IOMMU driver, it calls its
> set_platform_dma_ops callback. If the default domain is supported or
> the IOMMU driver is not iommu-dma aware, iommu_detach_device() is
> actually a noop.
> 
> The 64-bit ARM drivers always support default domain and iommu-dma is
> even not enabled for 32-bit ARM. This turns out that iommu_detach_device()
> is always a noop in arm_iommu_detach_device(). Remove it to avoid dead
> code.

This isn't entirely right..

The purpose of the iommu_detach_device here should be to make the
iommu driver stop using the domain that it is about to free. It cannot
be a NOP or it is a UAF.

I think things have become confused.

What we decided is that NULL domain is supposed to mean the DMA
translation is controlled by the platform, the concept is modeled
after S390's private iommu implementation. This means the current
IOMMU translation is invisibly set to something that matches the
device's dma_ops.

arm_iommu doesn't work that way, it allocates and assigns domains so
when the platform DMA ops are in control the group->domain is not NULL
- which is the opposite of S390's design. Further when arm_iommu asks
for a NULL domain it doesn't mean "put it back to platform DMA ops" it
really means "park the IOMMU it is not being used anymore"

So.. Blah - we had two meanings for group->domain = NULL and didn't
quite get it right.

IMHO the way to make sense of this is to always have a domain attached
and remove group->domain = NULL and set_platform_dma entirely. If the
driver doesn't want to use dma_iommu then it should provide its own
iommu_domain that it wants attached whenever the iommu API is not
being used.

You can see this in the exynos fix because what it is doing is calling
__sysmmu_disable() from set_platform_dma which is either IDENTITY or
BLOCKING IOMMU behavior.

Then we can document what the idle domain is supposed to be doing in
each of the drivers, but the core code is logical and doesn't have a
confusing overloaded domain = NULL case.

Something like this as a starting idea of how the drivers could look.

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0cde22119875e..143d1abcae2641 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -948,6 +948,20 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 		&pagetable);
 }
 
+static struct iommu_domain_ops exynos_private_ops = {
+	.attach_dev_nofail = &exynos_iommu_detach_device,
+};
+
+static struct iommu_domain exynos_private_domain = {
+	/*
+	 * This is private because nobody knew what __sysmmu_disable() does.
+	 * When someone figures that out this should be made blocking or
+	 * identity
+	 */
+	.type = IOMMU_DOMAN_PRIVATE,
+	.ops = &exynos_private_ops,
+};
+
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 				   struct device *dev)
 {
@@ -1400,11 +1414,11 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.device_group = generic_device_group,
 	.probe_device = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
+	.idle_domain = IS_ENABLED(CONFIG_ARM) ? &exynos_private_domain : NULL,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
-		.detach_dev	= exynos_iommu_detach_device,
 		.map		= exynos_iommu_map,
 		.unmap		= exynos_iommu_unmap,
 		.iova_to_phys	= exynos_iommu_iova_to_phys,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705bd3..b71a1667f43bd5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -387,14 +387,13 @@ int iommu_probe_device(struct device *dev)
 		goto err_release;
 	}
 
-	/*
-	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver. There are still some drivers which don't
-	 * support default domains, so the return value is not yet
-	 * checked.
-	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
+	ret = iommu_alloc_default_domain(group, dev);
+	if (ret) {
+		mutex_unlock(&group->mutex);
+		iommu_group_put(group);
+		goto err_release;
+	}
 
 	/*
 	 * If device joined an existing group which has been claimed, don't
@@ -1645,7 +1644,15 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	if (!iommu_group_alloc_default_domain(dev->bus, group, type))
+		return 0;
+
+	/*
+	 * Driver must support default domains or provide an legacy idle domain
+	 */
+	if (WARN_ON(!dev_iommu_ops(dev)->idle_domain))
+		return -EINVAL;
+	return 0;
 }
 
 /**
@@ -2172,17 +2179,22 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 		return 0;
 
 	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
-	 * platform specific behavior.
+	 * New drivers should support default domains, otherwise the driver
+	 * must provide a domain to be attached when the iommu subsystem
+	 * is not using the device. The purpose of this domain depends
+	 * on how the iommu driver is operating the dma_ops.
 	 */
 	if (!new_domain) {
-		if (WARN_ON(!group->domain->ops->detach_dev))
+		struct group_device *grp_dev;
+		const struct iommu_ops *ops;
+
+		grp_dev = list_first_entry(&group->devices, struct group_device,
+					   list);
+		ops = dev_iommu_ops(grp_dev->dev);
+
+		if (WARN_ON(!ops->idle_domain))
 			return -EINVAL;
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_detach_device);
-		group->domain = NULL;
-		return 0;
+		new_domain = ops->idle_domain;
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa2286..a17069368d70d9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -91,6 +91,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
+#define IOMMU_DOMAN_PRIVATE	(1 << 5)
 
 struct iommu_domain {
 	unsigned type;
@@ -272,7 +273,18 @@ struct iommu_ops {
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
 
+	/*
+	 * driver wants to use dma_ops provided by dma-iommu.c, return
+	 * the recommended initial IDENTITY/DMA domain.
+	 */
 	int (*def_domain_type)(struct device *dev);
+
+	/*
+	 * Driver is not using dma-iommu.c, when the iommu core is not
+	 * using the device it will attach it to this domain.
+	 */
+	struct iommu_domain *idle_domain;
+
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
@@ -315,6 +327,7 @@ struct iommu_ops {
  * @free: Release the domain after use.
  */
 struct iommu_domain_ops {
+	void (*attach_dev_nofail)(struct iommu_domain *domain, struct device *dev);
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
