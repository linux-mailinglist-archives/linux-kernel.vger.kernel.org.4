Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72C65ECA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAENQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjAENQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:16:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F76353729
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5GV35mnJReZo8Oj7ojUCERrNrZ+AL0Z/45llRX272uJHrjYMWQrDmM40Y9c/t8Dv518hy9FPVQ9l4V7gC7LBgriOv7wlKMeH9hqEHvHSfKfJcy/9zlewyJJc7iSRCxKsZ/TqYvJdIrJUkFsKsExA5FXSm7iT+hMl1D31nvFfywbEJUAyy8fkYd0dzaI7LeWw/uf6FkNlUOtpFxGj3RRdjfpQXezyMG6LOOXAarFQPYgul9GKU8HErl3hLvhtnOsdBIAViN0b704ZehiRVgX12zfHgvwpUqVaIG/zkwYBQkZb0pm7N2rKd07XezIOMy07lhThZd+4hVtRUMeKVz3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++ZqZQtGl+DNmoNwayvzBNeuavf+Kp++r+Fq+CobNDE=;
 b=LOPOW3c2RabWtNa5hTFDWU7vGxN5JtO8jcSd04Rx8F6XSoqOOoWpPlwWFR6poNw1cMcUsN+kJR02uKUlTfUGxTL3JBka6q8fnNFwbONZRhz8nHaoZMdGpIyJFn+8Fp1mWJuMMkoOrN/Vc2hH6y/6EAsfePz98XQL5EWEuJ+jI2Bwvl/N3tDta7KUNJ9vZheiNfS1LTcHalB4OFHIhrr0tKhUnfDP6r+oGWSGOtE9h2Fmi5wDotivVYRvuRU1lmfZYbCD0zktqhv200XY4IgQ42Sfazynr32xbZ5e1ifNDaqINh6fulkQwdl0f4+hEPoLpgBsaGzJ7i36irEPZQ6mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++ZqZQtGl+DNmoNwayvzBNeuavf+Kp++r+Fq+CobNDE=;
 b=LvdJ2GBLqvMjupxAToYxaUhe2LA2510qtQqn9ldEorHH2uOM/yckfF3FAEFd6LMsAH2saXQaee6C6A6hu9wT7KXQPeqd2R0ifHRpywb4lfaur6Z5bq+OfE9x1snCyKaHn0DgRjDrlJosk+5m1BF6kfDiWnRkxdVqLYjhmWtwavxdgp9llJRzxzR2zWy9I0aVXPleqLpbrhObrrLUAuNaY12EM8FhucJqfnkhj7P5y6Dn3lm4L0hXMVdsRvWrkl/Q9StM7JGFEzfz37/SCoNHHoUQOydfAjrVT6dYtb1+bDI+ewwscV20a6l3f816kBkFLYZYohWJbYwHRQapbjwZ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 13:15:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 13:15:55 +0000
Date:   Thu, 5 Jan 2023 09:15:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Subject: Re: [PATCH v4 10/19] iommu: Add set_platform_dma_ops iommu ops
Message-ID: <Y7bNidP/px0NmvR+@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
 <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0047.namprd20.prod.outlook.com
 (2603:10b6:208:235::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: a80a4338-92ea-48da-84cd-08daef1efa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4Yy3BB8y8IIBhln78OXIl5RMb1yskum1dGKHFnOQOA/q9luk8CEaUjhwWTQdxei9504f1iIYnTXrAahumlknB6AHLc+6xKkklXcTYyG9l/nftSwNf7LzR6LoN2UWNpLun4/vPY7ShbHQzRLd1DjKsLjc+o2jICV18P+cqnnx7InIungoOkglGAyxN7woLiDTfLwu+QN+B5/PeBYtULaMgXf/bg5xYg3T25GXjNgN+tlKuXMCmXMN26UwNTWZQf0jmqQJxd7ygGmy23s+ACh1PUCztK+aL1zBUgrmdU2C05o3J+N8BTgSFTX8Ov81VDJ29o0R+sUoC82+FcgfnbTMOc8Xu0JoOKZAjmf9icxZy31z6BttaJuHR7g1bbziFt5x4C7J72dw16irioN1bC+F9TDmGBEVvxYEPDQP3iG8GSTXrXXqrll3NG/DPa0xEo/Xat2jOqVkDMypvJx2cuSDvX22lYClLwI5ZSuGAk2DWtI0kl83/C9k9GsbYqKKx3f8zvQm6OQtQCpVPi0WpsQmgT0vbQtn8CASBYDm46aaKkWkJVNP7vUYlnwOaQB4DhgHKupI9du3K6pKJYKoLiBR1xsYHqUFRpus5Wku9wbUT0btQohdXPbwZ3DiFfq+0XQl+Ov9H2xfgZr3+q4gb38zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(6506007)(478600001)(53546011)(36756003)(86362001)(38100700002)(6512007)(2616005)(26005)(186003)(83380400001)(6486002)(66946007)(7416002)(8676002)(5660300002)(8936002)(66556008)(4326008)(66476007)(316002)(2906002)(54906003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwT1fm/v0nAgFXcDZPZB/gddRdb4xhvijpELkmG9x1HnUHSHH30INBahi6Vf?=
 =?us-ascii?Q?rVtR8LQvJkuA1QbMkVrWiAPGk6a4O6mWqtj257NS5ogjv2b3LOEn3bFvGiws?=
 =?us-ascii?Q?DLSm5+HkDBc1O5skQablsTGvr5hcA2p3dnLhiYDUTWLSuyFlIM60dTlwr9fc?=
 =?us-ascii?Q?SMUhi7I0XPnS023HsLvn4rMDIiyvqbMOzzpmZVl7GqsMxUrTJ/7kOmcZcaxR?=
 =?us-ascii?Q?AL/z9TM9lhZg5MQYVD+vU9HfdJokI6EjMKKmRpXfFp3QGWvj9MesL7LLLfI3?=
 =?us-ascii?Q?anxbYLUYb36wejNi8TKmaId3E0ThJNcRo7EhFUku0tLV1nAYYnaKkRZrcY80?=
 =?us-ascii?Q?2tiGi6Pc0PnUHHO59iy5Up02pp6Ahw4m5PRlUKwbLRPMJJZu6R4xjuv4TjR0?=
 =?us-ascii?Q?20QvdrfnhzzHWXRg9EoZy8dYTPneJGktPJGDbXKSl+XI7eROL/EKc4u/0O2C?=
 =?us-ascii?Q?NyQxtK+UYR8dwyIzlgQGPi+5d07TRXQLPZ/ZJ/vG+yH+AaiKvsyf/2ocgIEf?=
 =?us-ascii?Q?POHW13YUFfTx7KpmT7MATnJuVA6JMdWBkL7wCdQkd8lhdo8kszIQkj2ACfW6?=
 =?us-ascii?Q?Lc3XKdHnjCb6kZP/en0LhvXOcAupCCOdxkx0amyJasWFMbmpABJG9ozVFa/E?=
 =?us-ascii?Q?1vul8DkwF5RKZPMdYenMYR8ODuAa18Y3/yt5y54WPvYPtZGL7NJmn5LHPDFs?=
 =?us-ascii?Q?xHfv6m3py9LGvNmG4XQYjyRHY+ZAHadI2lpDpp9A6gf77sZeDekbZPcdqYHq?=
 =?us-ascii?Q?1uuKFNfculUn639ZAVoKyKcbxT/jRB7ZC5/0V030t6symXOB37gyqWBDT6tf?=
 =?us-ascii?Q?6xHhS1OolmBtTSV2ersswiNQNIuR7OGByRVWJ2IOk6eG6CxleObWdkYvBn7k?=
 =?us-ascii?Q?au0pqbVCzuQWAEK7uBlyVlC1mEmvjEd919qXqGhdr6coi18z3QcSyaf65wGH?=
 =?us-ascii?Q?ghLjCILPkdxl6NXmEyqTMLIatg1q++nKRaUrG5ZO8/QCVowhnso0VPDCEY+n?=
 =?us-ascii?Q?agCjYi3xVLScV1oVlq+BORb8Nab1wtBI+50HFKsXgTb4mq2UkvvbmrJJ9/SJ?=
 =?us-ascii?Q?gCuTtrBi5ONnYI6NIg/sBEsm97W9TWT/j/BKVGAo57jDI1P3VN97PYCty+ed?=
 =?us-ascii?Q?j7aNUx5gRKKYAYSCRaPkotXNcZuQtDfBwbZhOt6hiQxbwLrTfm0vW7/k0W+a?=
 =?us-ascii?Q?Z4EtYvPHOheEtlOPmVeHGYvW1cgf2DjXpGJQAM0pZguwNC8i4gVyxXdzezCe?=
 =?us-ascii?Q?ChKl6kQP560uiKlg+RUp+s1eVzj8EuNwTV1SYgCHIG+BXduKgqBX5mZoehmV?=
 =?us-ascii?Q?vbPYI6XRpRK5Am/Iboc2gzggzFYZXvBFpHB7+QV+JZfeOVllTekhMoMP0XoX?=
 =?us-ascii?Q?8QZ9PUqTLeCKk3qIDYVMvmE4xSeuX7jjE8XDrKygPmv3QMo6wqCnnleO2uiJ?=
 =?us-ascii?Q?fdpNZ9FMljOR3EqQ4wngtxkGMTIYoz4UMlI4I5fak4aoMDQd6/4wL/U+MWG8?=
 =?us-ascii?Q?CyCjalOzteFppv/QqMYL1NnPl/V0ARr/1qM7v2zUj3Hd6rHjFzFEqMd98cyu?=
 =?us-ascii?Q?X+kKuSoMlWpZQG0vIC25tzpMa9eZDwtOeuebsLKE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80a4338-92ea-48da-84cd-08daef1efa36
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 13:15:55.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jDVmj80fKl9BqxJXjVHtpVWAlf7MD4eYGa0gZ74g7w69PXqChAoq6l5x2tmk+Wq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:58:42PM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 2023/1/4 21:17, Jason Gunthorpe wrote:
> > On Wed, Jan 04, 2023 at 08:57:16PM +0800, Lu Baolu wrote:
> > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index de91dd88705b..4e35a9f94873 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -2163,6 +2163,17 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
> > >   	return 0;
> > >   }
> > > +static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
> > > +{
> > > +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > > +
> > > +	if (!ops->set_platform_dma_ops)
> > > +		return -EINVAL;
> > > +
> > > +	ops->set_platform_dma_ops(dev);
> > > +	return 0;
> > > +}
> > > +
> > >   static int __iommu_group_set_domain(struct iommu_group *group,
> > >   				    struct iommu_domain *new_domain)
> > >   {
> > > @@ -2177,10 +2188,14 @@ static int __iommu_group_set_domain(struct iommu_group *group,
> > >   	 * platform specific behavior.
> > >   	 */
> > >   	if (!new_domain) {
> > > -		if (WARN_ON(!group->domain->ops->detach_dev))
> > > -			return -EINVAL;
> > This should still have the WARN_ON..
> > 
> > if (WARN_ON(!group->domain->ops->detach_dev && !dev_iommu_ops(dev)->set_platform_dma_ops)
> 
> This has been implicitly included in the code.
> 
> iommu_group_do_set_platform_dma() returns -EINVAL if the iommu driver
> doesn't support set_platform_dma_ops (otherwise always return success).
> Then, the domain->ops->detach_dev is required and a WARN_ON was there.
> 
>         if (!new_domain) {
>                 ret = __iommu_group_for_each_dev(group, NULL,
>                                 iommu_group_do_set_platform_dma);
>                 if (ret) {
>                         if (WARN_ON(!group->domain->ops->detach_dev))
>                                 return -EINVAL;
>                         __iommu_group_for_each_dev(group, group->domain,
>                                 iommu_group_do_detach_device);
>                 }
>                 group->domain = NULL;
>                 return 0;
>         }
> 
> Perhaps I should add a comment to explain this?

But you delete this later when you remove this.

I think testing the op directly is much clearer, get rid of the whole
ret and EINVAL thinig:

if (dev_iommu_ops(dev)->set_platform_dma_ops)
   __iommu_group_for_each_dev(group, NULL,
                                 iommu_group_do_set_platform_dma); //	 Can't fail!
else if (group->domain->ops->detach_dev)
     __iommu_group_for_each_dev(group, group->domain,
                                 iommu_group_do_detach_device);
else
   WARN(true)

Jason
