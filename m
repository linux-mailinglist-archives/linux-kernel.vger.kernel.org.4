Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0E6B3394
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCJBRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:16:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAFEDF727
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:16:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKIDjSbIboOCfiegSbAJR/TZ4WcIkVsbQN+zEM2/itKdH+Mxpd2qNkP0piejVg/bp4n8FtdoRawHYMNLi+I+iCG/rOCa6tVTOh0YF/zIVIXJtvzIHxz1JXuOdBCbgND2VBcVbmDmQ+jmwVQv50M+Fa84R7oYfFVsh0nAwbKcYaG4Ptu1HyMPgtCkvPAsoHX4K1oLRvdPbDw2AmhnxRCiNtlQIDRVWogn+pjeReaWJPaxZddnsHba6gtF724VliK1YlH7cP2ZO5hUhVvkzyGMiLAXfI0TnpfJVtmA6y6YZGZ7nvWTB05G0TLBRjNZZnBDsypdBGFQFFuAPqxZAhsZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHUGeP7GpM7lu7I3jciISIevTBOg1joutk7EVQ2OPmY=;
 b=OUjMKyFhG7pdtKqAm45tUXgZxcbejQ8S3o5ctb0f+F3/Cidx1ipwwXQZvbRZQMtoZg6WFUJONnEnV/SLbRY5PRVTRCyVAGkGH9XsJJ81Z2fTSnbHzg0NR6lhJjzAQ2Z04y/mzzzdEa7tMyhVM8X7XrGNZ/gFT1iFisx78BavQe7SN+pCn480wBcArJu/s4ghKM7KRdEV77vG9LGHtz9AEHO02NAKAORjCw2AimihmwAeAUJq4aMK/ZorArz/OMi4YB+ZVuAzmCbFupkuyyPd3krGS9n75Ne2hoqzKFDuN0b3I/8EQpUzFCHTL5D6yqIcRl9zOrt/W9pwu6ROxy6Tqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHUGeP7GpM7lu7I3jciISIevTBOg1joutk7EVQ2OPmY=;
 b=b9wDYEeES85iFgAjp+BA7r6PRS+z2Ba11RZNPtn3QwDv4xKZv42yDncOSPt3VGrSEzFyuYLuHqrMKVQLBKQ9TfRTniUx4TeuHLOVLsej3vHHSXZOgWxWBzyJg1OjSqps6sQ/YJbCIZ98635vvqFak58ewjEF9NudPP9SpMOwH+4XVmEpaWjYFUXq1qKnb+cuoo/684M6MWWa+HwKO2BIzuvp4Kelc1fpkcf0sAdCWNFhrr7AVHwb2pKO9np6OnCKWsnsb3zRY60GVl6uEZg55ra+Clv7JFNFp7ymcWkbYXLL6UUsVjXpJalvv3OrbvW+zWvn9lKGURRsDZqjwLbQlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:16:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:16:54 +0000
Date:   Thu, 9 Mar 2023 21:16:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iommu: Move lock from
 iommu_change_dev_def_domain() to its caller
Message-ID: <ZAqFA8KERGh2Emob@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd34f7f-67bd-470e-e45e-08db2105225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHBkLdA6JyF6o98A2ns/jA6Oy5xzyDZhzNxaRZC0qcw/Kn3wp9lzpiHtDVcnE0/Y2HGjZTtGXYXGD7JWFqdSFt8tv4AiJ6BozQwerQdpIesiZRFg+x3gOx5GdnudnWB85RuSew4WtZFmNlUs/aCGXTlqE+n5Ki9CPNTRb3TNRaUICRNUtZjVrqzu/kKv7yJjRdft39YHIrVUbq/Q2E+WFx0x/F4yxlCxTmhY1Ww4VUL7M40TTMyfRwvO8OXmrnvb2O/ymAScQlbsrR+yiy6R4kOQO43kVn2PSHrgNTq2yQIIa5ugBudJNjGVeeAgImxKza54WXm/gUKqGfvD4wMN32qym/hagKQWZYs3XOP6qkVD4ZJqe9K0Vc/qYKho5hYMHhSwBjBZZGK9MJI7vZMLnl/I3fahvJJDFNT1Gcb7n/vdFiAm5ma9qF1i2ZbaPYiFPwrxmqkAGFwxuxVlDf4hekdfB7ITl/RHfB9Nza5KftGA/zf8bD2QUoF7imw3eKQvwMNCvW7VNCWKLN3UOkHNII1cClLBokVKMS1hXo9/hdx7bhkW7tG9rKcMyvNuRN3RsjcVT17eBeMRyVRWLGiZPhI0/epy+3jL56TvOCJf5PV2xCnUunT9LiV9yUA9pYwGVvmZkps00mr8ESeC0MZbyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199018)(66946007)(2906002)(5660300002)(26005)(8676002)(36756003)(8936002)(4326008)(66556008)(66476007)(6916009)(316002)(54906003)(86362001)(478600001)(6486002)(38100700002)(6666004)(6506007)(41300700001)(6512007)(2616005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iXCvrR2m/ZC+cXNOpkLG5DM1egDq0aq4Kz5k36SpcLuAmX6chXCL8Yh8JDH?=
 =?us-ascii?Q?VLQhjDM0Th6z5+9RhCVXEFsV9YZgZgslENoNPl93odZ2lQWkfowsfXntEAWV?=
 =?us-ascii?Q?UeMg6yzbVuzAP5pOiprqTu1WbyLj1iancTfvXZENZiMK6SRCtO/ci6TTwx1B?=
 =?us-ascii?Q?0NfxWXx8zL6uKO6DSRHC4M1OW6P7pV1qVn79ootgyRMjdOrxpg+WTSF6ecG4?=
 =?us-ascii?Q?8f7L08YuQK2hbubalRQDRqma0qptQWw35YFpZ8FGxQAEEEUz95BXafT6QWTB?=
 =?us-ascii?Q?6BtQ7l2LPcFVyom7J7Dd1N056VZZuVxCZfPKoBTlnviwKPnvxOmxtJ1Lv07Q?=
 =?us-ascii?Q?pKMl+4kHG+mx9l1sV3ngM0m526FGN2IzZmZFYmmiU+8gBJtil28fuJ0nZB6O?=
 =?us-ascii?Q?ztdUvZg+wXhkvGBo+64dEXrP+R8+CwoA8pFgU5emdmB/KIPORXSBH6O8pePo?=
 =?us-ascii?Q?z1RbGerenGTvqldYECpSl/Rj40fSmP4wSw4m7xhhVjXijE6jcoSmpcVJD7Fx?=
 =?us-ascii?Q?I/itPVxRn5lMRzIQr0W0iRHP0fiU340V8/UHumG1UOWYG2HEmnRG4YMeNXMP?=
 =?us-ascii?Q?Bda0iL3X5oKAyYLfGiuBhE3OVp1LQU/sm4ybvgLgBdad5YagN+n7fzM6lv0M?=
 =?us-ascii?Q?2mqa6Anr0rFJysO4tLuTXTJBqCZPpe4XMlGdH+BhnKDmtogeowu/IVErwslN?=
 =?us-ascii?Q?jX/cn8oOkiNdSiwSh2iPDJWaA7oramDFPOkWcWl/EWblwQ2H9VeoguiteTCo?=
 =?us-ascii?Q?N3cN6S85FkVwxql902TinBjzBt42cv+i7/IGp8eNTt9g9BsEBQyu+6Sjn+qr?=
 =?us-ascii?Q?BoV7D1F7JiTDskNExU3/waIUOMMDmPCSrNg9NT1W52U4ZvB6MQajkX/MuRnP?=
 =?us-ascii?Q?Kun/S16FMNEP0PsR94K+emXe3dblK9TLiQGipM5r8b2duStdchZiFLnEeyi+?=
 =?us-ascii?Q?/VD1SalZQy4bKr7mhSvGCTrs2CEvjVqCxh2uxHSzaILVTUe0dZ7ZR72IpsxL?=
 =?us-ascii?Q?sqn/ijl+ZfmoR84wDrLex67HwAiauOqwcJB12tn5WtNenZPKxcSvLAilGSe8?=
 =?us-ascii?Q?cNSffUDVqREIfxzqQEe7u9XgZ6iFqsxdDQWzqX/79Ln7tqcV0GIkvVZjHoVt?=
 =?us-ascii?Q?UuDcCxuiw8wMwo/88JgDn3bcreZGKNJ8XdZ6c+tUnhwv6kBrspygdyqUyHE4?=
 =?us-ascii?Q?qGUUcRfglKGDUeA6jLhrojRGO1xEKQLNboxwGQqi9SxH1c89ITg9m++UVe7K?=
 =?us-ascii?Q?M+wDli86lmfYrJMCtpw2hSvzegMjzazWZDv5pLlhIKzKAiZEzdrdSocvTkyX?=
 =?us-ascii?Q?FGqxTQmFmIdXR5XLDt6hC3Jr0kBInfv5iI4gpQCh4N5Ww9YsTUWIiRdtn1m0?=
 =?us-ascii?Q?envrexzIr+W44WckmNqD6dBh9/RkHRbC4g6PXvqOI9qIG23QQgZPi/6MJcOv?=
 =?us-ascii?Q?052c43NxdOsxbNfaSpXLvtkd4UvElnthLmq+ssxlO3F7McoRMyto+kVNJZ3T?=
 =?us-ascii?Q?7D5YTQqAvGjwfUiyOAcHwyUv29LE4iPej6FW839kk5NNGXY2romRTYpn63eC?=
 =?us-ascii?Q?Anvxu5VW+NtDOZ352yxET1+GD/5KeChfT/nMBOSE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd34f7f-67bd-470e-e45e-08db2105225b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:16:53.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZymyqyaiuqkMFOOPPMCN6yNtVr3NZnZAx92iYNGBApS+G5vsl9V0RuzB5zZzRhY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:58:02AM +0800, Lu Baolu wrote:
> The intention is to make it possible to put group ownership check and
> default domain change in a same critical region protected by the group's
> mutex lock. No intentional functional change.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0bcd9625090d..f8f400548a10 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2945,7 +2945,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>  	int ret, dev_def_dom;
>  	struct device *dev;
>  
> -	mutex_lock(&group->mutex);
> +	lockdep_assert_held(&group->mutex);
>  
>  	if (group->default_domain != group->domain) {
>  		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
> @@ -3033,28 +3033,15 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>  		goto free_new_domain;
>  
>  	group->domain = group->default_domain;
> -
> -	/*
> -	 * Release the mutex here because ops->probe_finalize() call-back of
> -	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
> -	 * in-turn might call back into IOMMU core code, where it tries to take
> -	 * group->mutex, resulting in a deadlock.
> -	 */
> -	mutex_unlock(&group->mutex);
> -
> -	/* Make sure dma_ops is appropriatley set */
> -	iommu_group_do_probe_finalize(dev, group->default_domain);
>  	iommu_domain_free(prev_dom);
> +
>  	return 0;
>  
>  free_new_domain:
>  	iommu_domain_free(group->default_domain);
>  	group->default_domain = prev_dom;
>  	group->domain = prev_dom;
> -
>  out:
> -	mutex_unlock(&group->mutex);
> -
>  	return ret;
>  }
>  
> @@ -3142,7 +3129,19 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  		goto out;
>  	}
>  
> +	mutex_lock(&group->mutex);
>  	ret = iommu_change_dev_def_domain(group, dev, req_type);
> +	/*
> +	 * Release the mutex here because ops->probe_finalize() call-back of
> +	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
> +	 * in-turn might call back into IOMMU core code, where it tries to take
> +	 * group->mutex, resulting in a deadlock.
> +	 */
> +	mutex_unlock(&group->mutex);
> +
> +	/* Make sure dma_ops is appropriatley set */
> +	if (!ret)
> +		iommu_group_do_probe_finalize(dev, group->default_domain);

Everything about iommu_group_do_probe_finalize() is still unsafe
against races with release. :(

Pre-existing bug so maybe leave it for this series :\

To fix it I'd suggest splitting probe_finalize ops into probe_finalize
and probe_finalized_unlocked.

Only have the "bad" deadlocky drivers use the unlocked variant and fix
intel and virtio to use the safe varient. 

We can decide which variant to use under the mutex and then at least
"good" drivers don't have this race.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
