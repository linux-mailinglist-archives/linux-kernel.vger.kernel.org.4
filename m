Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618306BD9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCPUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCPUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:02:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8EC97FD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l40SAhM4pBE350uLM414jEKEKDuXP4KlZp9mwUx8pXefdRyE7HiRJYjjB1mI7p3jFp9/zGBLIVW7UVioxSAEtzrE+5nbb2sY+WqNlfNmA798QE+KcnD8RzQ/aXiEq8yjSuSQi98pH0UyHhNec6kWHXFjsPAnoN9i/Ws9UQn55jlCFZQ9hPUXhTcNIFOtqkvCYlcnou7A4APoGeOP6K8OJOUUxX2m7v7pmHue/8DnPwT6mTmmJgLPcXMjwAwYl6qS0me/FjD9I/Qh+a696QS8E6iD6xUZPHnMoW2oi7ARENnwpCRPtGR4gRQbOTZeRyGt+LyFt/6HDoFPah1bY9B68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAA/20Cb19god8DuIzjNi/YwdEGeEtfafkmFczOAd9U=;
 b=cFxK5oTrgMlfHT8sG5Ghc3auuoP5YA1M8fTa0/Nt8SATyCZYxvZlbd2dkLUJJTOepu9SlG5WrOhto0v4eNYVzfCTmidkbh706K4T7DCBlUDvm2Yp967CO/LvM/jywDrPcYqN+4HbgRLVpx0KD0iihssdb086I2Px+E1LaIBs1tTiv47JWr1Rdqcdx9Udckt9IIPXDMx7Dd7OTye//aI0cpYoK2nZjoPwHsS+ZLiL8JtCa4a+nBl7B9PGH4Edlq0lYSLfcUZa+pMI7Yk+v20hKby/Re8CTDg/my0kJ0rm1ZiCghspkJQLiqHLqCXv0oVOzj4UtC0lZvJC0K9630e+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAA/20Cb19god8DuIzjNi/YwdEGeEtfafkmFczOAd9U=;
 b=Qo9PfxXuTPVZpiEY5q/DjkyYBCVuAvr4rYXcO0/L5vlyPB2VJ3RsGTskXfQ2GvIe8tmhORQHDEzdwRsII5He1TAQe5UqphQyEwq594V4pkgUj3yTvNgo6fLhWyMWEPCzHMi9PJZRBgL6gptPX7GSiw0PAnSWi1QDj0kOpEKOtwNs/1LLvZXNWgC7inS5zIzcUn69t8Y34EcsTQkg2sRmficwcMfw03eyy58KAR9WTgoDNefU0r0nY7WnL6ci1/XFDtavsJ131R7W7QC55wi60tgcsU496ycT61JVgiAmc3Ie//oZMa6i6LLgTzSyYnaZoXQRmzMCKFN7VjyAoCJcaQ==
Received: from BL1PR13CA0332.namprd13.prod.outlook.com (2603:10b6:208:2c6::7)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 20:01:57 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::15) by BL1PR13CA0332.outlook.office365.com
 (2603:10b6:208:2c6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8 via Frontend
 Transport; Thu, 16 Mar 2023 20:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 16 Mar 2023 20:01:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 16 Mar 2023
 13:01:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 16 Mar 2023 13:01:35 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 16 Mar 2023 13:01:34 -0700
Date:   Thu, 16 Mar 2023 13:01:33 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZBN1nbjHzu1BJdOO@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
 <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
 <ZAtS21vqhp7LqA+B@nvidia.com>
 <ZBJvLsfeIRhV6cME@Asurada-Nvidia>
 <cacb6338-6dc9-e8b6-426c-aeed3104c8af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cacb6338-6dc9-e8b6-426c-aeed3104c8af@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b34c8cf-d974-46e0-62ee-08db26594af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKEhAoJRailymkImL306g1iczDmdDHaDXb7hr3Y6ugSpkZFKeWUkuU7QKPKWHNgMCjoOSpzO6wV4Uy7ntsP21VOlQWJL90ipsVfWnIcn8cQTCLjxEppBXTajJC1F3HjwVIRlm3s3Kx4rAUCSAAoFsmcxh0HEnw0Na2szd1X8HgCN5PULtpvcKRO75faDae8fQ/XenY9bmZ9E17aFm/goCotCqZ1TfEtbPrrmDen7wVVgLr034IUenNs8i8U9U+tRO9jmR5AmUQ+V50B4CPdavVfN4PkCCI9KgUyQa9l27/BrxnG0jbMzZVJdOFIDqS000dSx6fUs9pq0TM3DD9heeLNB7Huletgn+3/Dwbo6LDc3EkgumWAswxkS+Q9rav8oJE6bmK/ot69a2Py9O2aRjJmzniy9gKHYEjCIqmo38lPV3jpl2gF5BnCUuKf/XTne0IJjhRy29E5TdKuhPe/dmfD295AVQPFWPeFVzJlfwZITYJ2OE8rwBLrUtqBBcJi1QGMH4Y/9HyZhxOZStsyGKOokvx/RXgLwYevcR0IEU4btk5QDjNZyhpIMHJuZRvndI26dqR1xO0UHBnWsOpbuQEx7PRNw7H4tbkPi1L2XrcPf5RtYt6nnilZ3Xo8cmIK7Hhxy9sCuGb7TZ0pYHSyz8Cs9/6E+SvEO1+orGlhLP2Z34L8qxvfrxSfN/t846/NVH6dzJWyAe+qUSfZf3PPPvjSxWCC/n+7g60j+gGNIeTW7YPv+ZnT5iYZbZA0v3x7C
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(4326008)(7416002)(5660300002)(8936002)(2906002)(36860700001)(82740400003)(356005)(86362001)(7636003)(70206006)(478600001)(8676002)(70586007)(6916009)(40460700003)(55016003)(33716001)(82310400005)(40480700001)(26005)(54906003)(426003)(316002)(9686003)(53546011)(83380400001)(186003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 20:01:55.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b34c8cf-d974-46e0-62ee-08db26594af7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:42:07PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 16/03/2023 1:21 am, Nicolin Chen wrote:
> > Hi Robin,
> > 
> > How do you think about Jason's proposal below? I'd like to see
> > us come to an agreement on an acceptable solution...
> 
> I think it's so thoroughly broken that I suspect Cunningham's law might
> be at play, but fine, you win :) Hopefully it's sufficiently obvious how
> the other pieces would fit around the patch below. FWIW I'd still prefer
> a generic domain->s2_domain pointer rather than any op at all, but I'm
> happy enough with this compromise.

Oh, I appreciate that! Looks like we can move on with a v2 :)

I will include this patch replacing mine in the next version.

Thanks!
Nic

> ----->8-----
> Subject: [PATCH] iommu/dma: Support MSIs through nested domains
> 
> Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> which might need to be aware of the stage 2 domain encapsulated within
> a nested domain. This would be in the legacy-VFIO-style case where we're
> using host-managed MSIs with an identity mapping at stage 1, where it is
> the underlying stage 2 domain which owns an MSI cookie and holds the
> corresponding dynamic mappings. Hook up the new op to resolve what we
> need from a nested domain.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..66b0d5fa49f8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1642,6 +1642,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>        return NULL;
>  }
> 
> +/*
> + * Nested domains may not have an MSI cookie or accept mappings, but they may
> + * be related to a domain which does, so we let them tell us what they need.
> + */
> +static struct iommu_domain *iommu_dma_get_msi_mapping_domain(struct device *dev)
> +{
> +       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +       if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
> +           domain->ops->get_msi_mapping_domain)
> +               domain = domain->ops->get_msi_mapping_domain(domain);
> +       return domain;
> +}
> +
>  /**
>   * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
>   * @desc: MSI descriptor, will store the MSI page
> @@ -1652,7 +1666,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
>        struct device *dev = msi_desc_to_dev(desc);
> -       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +       struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
>        struct iommu_dma_msi_page *msi_page;
>        static DEFINE_MUTEX(msi_prepare_lock); /* see below */
> 
> @@ -1685,7 +1699,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  {
>        struct device *dev = msi_desc_to_dev(desc);
> -       const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +       const struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
>        const struct iommu_dma_msi_page *msi_page;
> 
>        msi_page = msi_desc_get_iommu_cookie(desc);
> --
> 2.39.2.101.g768bb238c484.dirty
> 
