Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A920165D419
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjADNXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjADNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:22:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3647AC7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCoyK9NVL4tPOoFNQNTMB9knCGUeo6qBAifXwjJ6Z2fmL6chF4z3ZNBbDmIrNZQiC3Y8UYACpnRLKxPHoOyGSxO0Lj3r6GWseHOulY6xWLlqcwH43Pvxh36OB//tOjYF69YvKefH9bOU5GmXTDA9jm/uCZjFs8Jw1R9SjuSSpEOFzwE6J3RKmJFbRLS4ChJALf7ppPJ5ZOSPqy5QnGgr4mh48YOSB6rGDsqA6rcN771MlNyc5+qBX09IqyvJALtG5D8d5Mxo4O3AUZ3q4Ys6cGo82FtPNGDT1KaGCjuchRS1l/NdrzxNWRVk1g2TstBqrlT7dWwzY8xcQjoJf8T/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U5jbQutwUWXmPEhM1kPH6cwdyf4YNjLZwI1mIc5w3U=;
 b=WXOsSuB87DChh/sRvmZzWC3SH0LYlVmQe9sksoWN8BQh6LexmqC0Eeo2z+Q6FenrwjWwaGisxDI5PrsGhlFZlmCFUt0LbHiCSIG4eMnfCXAY+aiUFggmAuo4TWrfT0BE8H7lcOevQtmAC4uaqTU+GAOjCPgyGGm2ggzYSlq4zQX68AucXLJsdyHN4zTHlithK6Ij+nJV4AIiGHuj+3PgpBPfoByzTxV8j9/XPetoDOQu47qhOtFGt2m/VLKufCxG/132unB1iD4S/Z8N7pKTtU/1x9XBE0brXxMzQ6ZgKrdpt/+EJOptC0VTvt7r/nC+nZwtM0DvtZJfyj6nPzI8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U5jbQutwUWXmPEhM1kPH6cwdyf4YNjLZwI1mIc5w3U=;
 b=Z6Kfly7bh/cbtB1RJwRTg/YqYCRUDdQRj+62yI68V9YrkT+OLGaJQEA0FGsJNPg39UQ8tF0VTQKhTyhdVVHHcyOGVttfsfJ8U+A1RsDdCv64kOBnAuQF2l3QdqepOBA9xyUvFO3U4btjcQda3Mq6MsgHk8LNQLZkX2WAzfK773QDiqCE3J+90O/jsqYuQ4fHb99F/8VQ9Y7sr6e4is6nMSBxqQXnFgELBnJnEfRIKkoaYg/rij5cIxtSKEKd8LbkYjCGNeyuQ3ChTb0rDXenO+ella3F9MBjIDrkHRR6AKKkwzCm1/bFDiQCoIZ70ipciJaZwJyvtEMyJZ/ab+58OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:22:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:22:53 +0000
Date:   Wed, 4 Jan 2023 09:22:52 -0400
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
Subject: Re: [PATCH v4 19/19] iommu: Remove detach_dev callback
Message-ID: <Y7V9rHPWoKvHTyrZ@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-20-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-20-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:208:32a::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0f5462-77b3-468d-36a0-08daee56c8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CNlRgaopwD1+tDkv8vd//z+N+OqbA7DJrs3jJ6gXAZFajsHIbDA5vlBbqvtn2F+GtFghsssrEzR9p6ZJbqcc7aloMurKDTkg/7ARoLZ1e7tiv2LgO4+1SU3vLKDhw+PrU7OHxBHUnwSpFS1gqhfB5xlyQXqhaLdzYEhF5BJ1uXVU4qtmonSUTPW53PwjQYf0l7BQdjw/PqRkGR9XqvOFnOvTM4TLaUIe02SA8gLzbEyok+JcE6HPhU8RTTxrpCmUXFhNSzp7wT0T5Tged5l9/GlyKiRfTiWXV7M2ogUXtRhAprT5FLwC3luKgN4yo+4q14Ek1/SPnjjjx1RjehWA+BoNi+wvO8SjrtFF0KiJEeOM8RgFtXlutH9+M0gQmjTKTDnmvW8qIK+Nkt883hbLydyFE0QK6onK4SQA3kpI0qgXeD0SP4YBLcUGPArkGtdtwdwCQHNgoAQBHqe+PrXIywDuc4Dwx6zju9kPMSnnqx4tZEuxfKyoS9iC29++6g8FW2I3HHMsXMM0xbJx7sd3wOuBLQpZFIAxZQDpzbaJbssR4tLp7H5XmqBS4AZD/D6OGLpGJQdILbGu5vzBhh+qSpdaLBOvc/+yI7covNbRsp88yUMbxInQwBVt7MAJ/RqpCEYVbFB+59w7UNDTC494w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(8676002)(4326008)(66946007)(66556008)(6506007)(66476007)(478600001)(86362001)(6486002)(36756003)(38100700002)(6916009)(54906003)(316002)(2616005)(83380400001)(7416002)(5660300002)(41300700001)(186003)(8936002)(2906002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPcHeZRElIiZMOE3zcfJ0CQhgzccca4WSO8Ml47aqUz0ciRLq1l9OkKty7+P?=
 =?us-ascii?Q?ANHGuHJBk1lmWy7ML2rYIQaGUFsUWO877qWLH62QkqcFkeCSPCS184XA165c?=
 =?us-ascii?Q?tC//Rqpzrm0Nk5XJwDRVSOw0YInqc4+ANhUGUoJtc8JjspzQzSZlYiyFU+91?=
 =?us-ascii?Q?Dm11KzpywYjf/VYYMTo1XBVtdgtFxpDMyf4MXmqgSgiek8RmQSYcCmRHtNqh?=
 =?us-ascii?Q?6rU2qDjsM0uiHxAxSewglqWJIVcFVk0G0do1sy2BxaQXM846Ykmv+QFxUlcU?=
 =?us-ascii?Q?xuPaD92DoyQIpuGbsSMWdLeVUmTym0CjJSsjXYe+uDNNGV1/z/yjqxQHgIvf?=
 =?us-ascii?Q?Y/3TGg3BFkVODFodA5oGnOpCVMXc4Aha1B+V5ySMh/AUSB7umCK6AHz+SnWX?=
 =?us-ascii?Q?Om7lNIpMGk60G4RgbFpKlSuVoKptty8pJU4mblt16/X05z6SJpkFmBjMhrcK?=
 =?us-ascii?Q?ETONQG/VrYtCMk6dsXOvmMmmW6UVVNudi4O2rsUwncWACHu1bAFl2HfZfgvx?=
 =?us-ascii?Q?7HRygk+Cn/YaK8+7xKAaW51v8hhoS6w7YgFb90v/3qNp0XMgR7VCaKZWrAEl?=
 =?us-ascii?Q?SJUfS2ClFrz5NJv8VmKSLlxdgyf7oTamNrX8ZtTrJerMjYmHkYD1SdFj3JAL?=
 =?us-ascii?Q?qryq+PwddIhIQW3Mn9r/GZ2n4Re7iJn1krCA9lAZDiL4/LKZ5o8hIO2+G5vy?=
 =?us-ascii?Q?7aMjuprLE1jDLoGU61gwZolWYAcn/xZZIU2nUu3u9LMNpmwc6aw1Gr5JoobR?=
 =?us-ascii?Q?FH8/rDyV7JBX1OzMF9Hb/z/S/EFP0lFt0ptlK7lWP33BP8mLX8H+uCQ2u6Fu?=
 =?us-ascii?Q?U8G0ZeSO4ypVPJfzLFBQXEfNSGPLrOd8baPgt5/lx6gV3SA7qchQtUil6g45?=
 =?us-ascii?Q?CEvp6s0QhAD42GobcCWD5t73ZMJVgxfL+PYbbY1brVw9DHdy4yWLyPaCTv2z?=
 =?us-ascii?Q?vwPde7JQzzI8nMth8m8EbYenkax2BtoBKUGo7ZCGjvg1RsYBJ77+hhCDBleI?=
 =?us-ascii?Q?xeybmybCxqWYLNG69v69dABHE0IYLUZTkXN0f0TIl+OEbHSGkEincNyiqGmR?=
 =?us-ascii?Q?i5KXQKfN77ACqt/a6N/kGvhJZMNl/pkPlCaSioohGXjZj5Ed+A+pWuMgIwiZ?=
 =?us-ascii?Q?ABjvrJJr31ggqezynlrs25hmcN6mnAGsovWO/ZFCSB+BFpeBV1Yk3Mo9jH7P?=
 =?us-ascii?Q?aJwkTwc9DuCor84gb5yr1DhWKB2Jqu4S3yLkGD6Y0EJC3m+YJPdGeyuTTL4y?=
 =?us-ascii?Q?y6FJbidtVQLPhd/igU0V3BH5l4Blr1HAD5Vr+bcSz4ifx+XYoA3XKejG0PG1?=
 =?us-ascii?Q?IEWZXvqqfZ0BXOICHlViiIDOXWM/9sngNli10ig34Y/RG9bEsOFxVEbQ4Vk/?=
 =?us-ascii?Q?yareUSSZcsB60PypU9zcfCwOtBBp4kWxwp4bfpMelNsL310gw5IksnZvIizy?=
 =?us-ascii?Q?0KQ4lNTfZ0ZM2l+qUAgWqwzxvmzabfBL6pLjvcc77uG9c+pITmEUrs8Ydt28?=
 =?us-ascii?Q?kKiIXhAl02Emsy9xtXv7rp+jRHgbeJlAd9+SopjNhCgF/CmjfJtDtCVkr2nN?=
 =?us-ascii?Q?LQ55at+GBIqhX3y0YbYuAtUxV4sRLYbjdFrKc7ya?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0f5462-77b3-468d-36a0-08daee56c8c5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:22:53.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s5eTZ4I5htqP7gZ/9TyVLHQQB942BpTuSoSY0cub8161PJtnKSLRk4437Vsspri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:25PM +0800, Lu Baolu wrote:
> The detach_dev callback of domain ops is not called in the IOMMU core.
> Remove this callback to avoid dead code. The trace event for detaching
> domain from device is removed accordingly.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h        |  2 --
>  include/trace/events/iommu.h |  7 -------
>  drivers/iommu/iommu-traces.c |  1 -
>  drivers/iommu/iommu.c        | 29 +++++------------------------
>  4 files changed, 5 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0d10566b3cb2..a8063f26ff69 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -299,7 +299,6 @@ struct iommu_ops {
>   * * EBUSY	- device is attached to a domain and cannot be changed
>   * * ENODEV	- device specific errors, not able to be attached
>   * * <others>	- treated as ENODEV by the caller. Use is discouraged
> - * @detach_dev: detach an iommu domain from a device
>   * @set_dev_pasid: set an iommu domain to a pasid of device
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
> @@ -320,7 +319,6 @@ struct iommu_ops {
>   */
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
> -	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>  	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
>  			     ioasid_t pasid);
>  
> diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
> index 29096fe12623..70743db1fb75 100644
> --- a/include/trace/events/iommu.h
> +++ b/include/trace/events/iommu.h
> @@ -76,13 +76,6 @@ DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
>  	TP_ARGS(dev)
>  );
>  
> -DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
> -
> -	TP_PROTO(struct device *dev),
> -
> -	TP_ARGS(dev)
> -);
> -

did you want to add a trace for the set_platform_dma_ops in the
earlier patch?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
