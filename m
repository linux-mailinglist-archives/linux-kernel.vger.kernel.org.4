Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9863ABB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiK1O5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiK1O5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:57:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0FF23156
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp2p9lhyYtUShKg2Fhb77khpY6ptaGDgQlJhgNDIu8XoC/7xhp5vkTkcEbRozf2Ueqi3g6mjoM2O94hzgG6WLBVxNp53ZAihzW1iHF4S219AWQRff30TRuYj1ijeEhefuwf3PZom5FXy4LawepxPWdKO3USbD6E0cofJK3VwuKFnfiLjUZ59azWRY7UgBZbBKOxw0ZwYWpRXVgQMkJL23mooH8cS7LcuSm2csAfGDSGF39+jQnmoC8J7h1o5EcVzZXDFLTlcvfPEx7PlW0rwk4Mf/iJAgI3bwn9+W5z607I05dCHTabU8VR/VvEy6z3P9RPWzFts4K/dUCAShm2mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B95teZYQz0vQcTIXA5Al57FleOummYQGUGDFVcsW9bI=;
 b=nhpEzAnSWxGRIw2zl8GlEuhZw3f4WVJoO+hSFGZxfljS6rdXUM8VhaNy92Nh2x0ouNHYNMGjOkduLzoETd/LCYCEs8pUJGW7oJkJhqxmJp9Oa++a5cpjHJ141lDY0hfFrFSMw7tdBwDueP9xQEWrGRxaMsXsGYF5XG11pggRXjFVyZEN6Pj7oylb8cBYCazMYsRkyoHJ54SUBIZc4eZvVQUcknD44A8fKEUJD//U2poFt1SgVNQ7TvSzlkgev65Ozq6uvYTYksagY1F0EiXct4/6J235kF9PbOYhvLUbdr51hsf9mRE9uVlXg7OqO+VE2e8iFzMcA/0Q5kuaw4zWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B95teZYQz0vQcTIXA5Al57FleOummYQGUGDFVcsW9bI=;
 b=L9cKgTRQONtXMMEoqyycQNsh5y5xJTHPMEx7AJ967gm2yqOsHYLA6a2FFIAmGzQqZb7dH+skilwiqVGO265dvk0ej8x+g1ADRGSe+w6lSYOVJ6MFOgV+qb82QVadV5RkzkLaYPiTmfM6NtXiT2lbJQcpIqLuq9RzEIwWqPqLYlJA9vXV7x2pc+TlnQNgQZOvVJqlUIXPrP7Yx71K5iTyiq2oL51JEttbREKbGkaT6FpW4RLeUldJGSLYMXruUHQBAGj+lu5zzxJIEKXZvSKxtoPu69z1uhJ6xfkW0JzpeQa9h1h53OYB7NsTzW/Wd8hkwXLVodXHpVYXxQM15qCknA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:57:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 14:57:08 +0000
Date:   Mon, 28 Nov 2022 10:57:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/20] iommu: Call set_platform_dma if default domain
 is unavailable
Message-ID: <Y4TMQ7HazPWMdsNj@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-19-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-19-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:32b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: ea05bcb1-081c-4dfe-fba2-08dad150d228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 486m/QwQZzEc5lM1zhBon6QXUghhS0sg3MHJp/hrr5o4lRX7db2Bx2W7o53LxGhOMsR7Vn2fZUOyfYDVeIYZjHiNWRx+B6KdV4RH5DvBdf9AFaJ07yRkSY2AHwW7NqQ2xJBRFVg7+B6vEzWZ4chDNPNvccUyKOmXXAGxaphJHby57nENdItT2VhZrIcc/EkbDHYK4sMkMOTKx7tp7ZcrHlW85utQMYZDwci4Pi4jwMkGEVTrjc46gdgRUKnFtTfr1/Y9NrOyM1QrokbAJGQLy7Xk87eL5qqWSd/aCcy4/qRdvZ3cZDX2wwD19hu/d72fxj7pxDXfNDks/P9HphQbBfxR+zyLZcI37hSSRQpnh00DG7qkpSItuHSv1iXmRnTuP3RG2N4OC1eIC5fbDklq34gSMQLbmYgy/6xLw3sEfP+LH5TBgCDmMfT1vLI+5NR5VFsw7gN9WSx5fEkqiraYO5Es7iJUwR1MMaAJXdBgpmXM7nZ7YLxzN1lj3Y6b1gAijFPWdRfcSpdnS6+/Iw7btXg7T+zdjmyCNoZOnbwGQLkQcSksibjb2ogiHVIlWU/hVluvG14vsj9V74yY0Wq1pv1lTU2tgxCSZ7M9xSwE02WOhtOcKAAyt4TcfSp6q6eq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(316002)(478600001)(66946007)(2906002)(36756003)(54906003)(6486002)(6916009)(83380400001)(38100700002)(6506007)(26005)(86362001)(6512007)(2616005)(186003)(5660300002)(7416002)(8936002)(41300700001)(8676002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScUx67gT6p2vkj2lt4u5+EzfZiZdghbXOfOWBidN/HcisdMNxiYJbAFEUbS2?=
 =?us-ascii?Q?j0egxoN4wFOmzCK/NzuTotYCR+1jffxpMuE3BNgTyXR9mQ/qp9T/d4fUCkOo?=
 =?us-ascii?Q?NG7k7u/rEWolUMt9oePG+Cx9EkqFbEqXsbIcS/qAfazokaEzYSr8EoWexoP8?=
 =?us-ascii?Q?q4h6gYF824CSoB1+hTEIX8c40ZzCNDKvWfgYSU8xInGoaSKF0R4tlJW+DeBh?=
 =?us-ascii?Q?/AJ9EhYhD9YOTAx2oelBSXCrLaO++sbc2Cvi/e5/UzdvespIFnOpmqeALNsT?=
 =?us-ascii?Q?qR++0OiHOl+Qzo6rU26DKR5uU49UtcQxBGCU0wjJBMsvNk8nn2do6yjcxgST?=
 =?us-ascii?Q?5p8v9zFmwHXybVB2GpcTMPjqsnIAfO6EQ/JnDX6w/5y68D99PnrIbfaLGIZa?=
 =?us-ascii?Q?Mejksm/2G6zUFD3OK3BCT9oqxZYhzRE09ZWeHp1bXmtl9RB76Rb586udtdQJ?=
 =?us-ascii?Q?lLafAAi9CtOa2mhffCK3hUyin7+U8UsMpatohYuFrhqqdhpmoulJJLjtmIe+?=
 =?us-ascii?Q?D8h+0HScM06ZYknnxd07QIdZ5QT9l6qpv1+SU2YVbtLojpkcqyEA9SKbGfHm?=
 =?us-ascii?Q?gGCiGQjIarZGFPfKaKVyT7j40qCHzgu219jtMzj/jpXIERv6fCe9FcFg4l84?=
 =?us-ascii?Q?Y1lnK/NWi8pzdu3EYHjgMC/INlqIJTNSpOB2LdM17bXTpGllNagGd49jjFt5?=
 =?us-ascii?Q?KoPLMaiy6+1n09y3EBkZpixyNbeyDHIkfC/zJAYejYVoOmcwMev02QxdDkX4?=
 =?us-ascii?Q?h02t9A8ieVvVZa1Vd8mkSIOlBUYwunzfqNxt5VqwflRZe0lKFCyQk6lkcjUb?=
 =?us-ascii?Q?r8mTJb2LQh0ytr/1kRzgY0uPa79Ggz1AeqnPPRmw2IBPUQkBKwh+Ib593xuk?=
 =?us-ascii?Q?bPN0XjL2XmJwAy1gAs+yYeyShzSBsGiI3OW19anyAgxTgAuSwaWmEL1mvRre?=
 =?us-ascii?Q?WRsTEhMcfLiCLhGcfVQZVc4jgYpBQTEVhTiAJsLKmxxAvvQ5jrX50RXehQ65?=
 =?us-ascii?Q?Qq88BjenvnL3g/MsxMJciiv1Vyu3Q54D0+H1PGkNHrqsqp16kXFTK1ktB0tx?=
 =?us-ascii?Q?K2s4Nt7ztlU/bLzgdFBQyF5QASWQoLV1j0bQ064WuPWKYuGJbTnN6s5R8+Zx?=
 =?us-ascii?Q?SadVesTsBskqvazsh7cjGODnKycxFE2eiJYjZAATNOE/jKhJQalnCaxnpnXI?=
 =?us-ascii?Q?QyG137/H6CeF9Qr4Lh0AN2AECKlHybcft+HJyx5m3QxN3Tw18Fwh4Rkiqk4E?=
 =?us-ascii?Q?KWAcjZ5VXDIopcDRAWmFYfu0WXPlTmAPP3s1j7sEazup6kNOkwTgnDIJJtrK?=
 =?us-ascii?Q?gRDIv5ogKfYuTPveyvLwOCegdN0Kj1/tNXYMMmFvkDAZ2si+L9GrNYOl9RR7?=
 =?us-ascii?Q?5zkwszuwF/9ZMD2ewr8Lk2XKP/imuZ1wm5rgQs/5aRCAMmgn2LNf8o4qiWT/?=
 =?us-ascii?Q?aO4K7Ka1MzFbPSJHCXUgkLwjNfVuBfWXBvacghIUzLwRqAP47dkvsTv7L1RU?=
 =?us-ascii?Q?UeG0uUIVVLU+dHbnxEeWYNU8a5t5Hi6MY49pv7kpXxJMzrOfQAJs8+/SJCjx?=
 =?us-ascii?Q?kyM3Dx5WWbf10arv1jk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea05bcb1-081c-4dfe-fba2-08dad150d228
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:57:08.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcL9AN1jRFthSGKYZwpRMmhpVZgq9djYudqJstjhdtuKEXdsN0Bzfqkn9x2/MqRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:46PM +0800, Lu Baolu wrote:
> If the IOMMU driver has no default domain support, call set_platform_dma
> explicitly to return the kernel DMA control back to the platform DMA ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7c99d8eb3182..e4966f088184 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2040,16 +2040,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>  	return 0;
>  }
>  
> -static void __iommu_detach_device(struct iommu_domain *domain,
> -				  struct device *dev)
> -{
> -	if (iommu_is_attach_deferred(dev))
> -		return;

This removal might want to be its own patch with an explanation.

It looks like at the current moment __iommu_detach_device() is only
called via call chains that are after the device driver is attached -
eg via explicit attach APIs called by the device driver.

So it should just unconditionally work. It is actually looks like a
bug that we were blocking detach on these paths since the attach was
unconditional and the caller is going to free the (probably) UNAMANGED
domain once this returns.

The only place we should be testing for deferred attach is during the
initial point the dma device is linked to the group, and then again
during the dma api calls to check if the device

This maybe the patch that is needed to explain this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d69ebba81bebd8..06f1fe6563bb30 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -993,8 +993,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain  && !iommu_is_attach_deferred(dev))
-		ret = __iommu_attach_device(group->domain, dev);
+	if (group->domain)
+		ret = iommu_group_do_dma_first_attach(dev, group->domain);
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
@@ -1760,21 +1760,24 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 
 }
 
-static int iommu_group_do_dma_attach(struct device *dev, void *data)
+static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
-	int ret = 0;
 
-	if (!iommu_is_attach_deferred(dev))
-		ret = __iommu_attach_device(domain, dev);
+	lockdep_assert_held(&dev->iommu_group->mutex);
 
-	return ret;
+	if (iommu_is_attach_deferred(dev)) {
+		dev->iommu->attach_deferred = 1;
+		return 0;
+	}
+
+	return __iommu_attach_device(domain, dev);
 }
 
-static int __iommu_group_dma_attach(struct iommu_group *group)
+static int __iommu_group_dma_first_attach(struct iommu_group *group)
 {
 	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_attach);
+					  iommu_group_do_dma_first_attach);
 }
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
@@ -1839,7 +1842,7 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_attach(group);
+		ret = __iommu_group_dma_first_attach(group);
 
 		mutex_unlock(&group->mutex);
 
@@ -1971,9 +1974,11 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-	return ret;
+	if (ret)
+		return ret;
+	dev->iommu->attach_deferred = 0;
+	trace_attach_device_to_domain(dev);
+	return 0;
 }
 
 /**
@@ -2018,7 +2023,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	if (iommu_is_attach_deferred(dev))
+	if (dev->iommu && dev->iommu->attach_deferred)
 		return __iommu_attach_device(domain, dev);
 
 	return 0;
@@ -2027,9 +2032,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if (iommu_is_attach_deferred(dev))
-		return;
-
 	domain->ops->detach_dev(domain, dev);
 	trace_detach_device_from_domain(dev);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1690c334e51631..ebac04a13fff68 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -413,6 +413,7 @@ struct dev_iommu {
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	u32				max_pasids;
+	u8				attach_deferred;
 };
 
 int iommu_device_register(struct iommu_device *iommu,


