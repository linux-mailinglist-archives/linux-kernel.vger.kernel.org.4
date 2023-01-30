Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBC681809
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjA3RvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjA3RvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:51:19 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299963864F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+FXWytXVz6puV7SvkwSN54I2Jyp+JbLFCHCbrLjD5LRRgfy3aVsYupbOsW6AfZ3oqU8asHyX2Zlfspq4atHvOuYq3105MprVkVmKM1CfseIPPT9tfiPr4/NWAilEgVJIyG9GkyN/3WYlstwapc9hmrXuEuT0ApGu6/JZ28Ik41x03BVCYUKwcjYjeZiEAvZ+X0+atvVxnwG6e4lZsSvcGPWtqj+43BXPk+vx2nsZDRq70XP1iCVFc5YfqeduWUiVgsaeH0CIngmCN1aAjGYSU0kVSJBwGW4hta11o5Kao3FyBbKzQFZi0QoHfXjVCP3NMtJBd4lx1z/e6Tt+tDTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt9uRrQkZbjY78Q2VvVJ2TVM3raLhuf9QVR2iA5uMJ0=;
 b=D7vucG+qO37H3j2OOwv1GxVZ27pcVMMr0fCj+4pfygWKZZEXTX2BXUZmJaSRJB83tHHNbVAnRnDUQ+p8LLKiecyW1E/DacVLonHo8YFBNXsIOzpnm6c5ga+LXhexQLQaF27upUxpzRSISU8Hx1WP4U9KzelRhksr8w0wqBOBO82wppJu2fraAbRZsPt2Xu1ou8eTaYSv5MRP1+YFsIebUaeMjvKYmHg9mCxuYRv768xJpfJgNkgs0opk5oY93dCQpsfYuZjKZPIM/vzvw125N/D/dIsckbx3a/0ETyrBAV+jVcCTqaLvtCj8+4aKP+IApwyaAfbLm+7qWngYEJSYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt9uRrQkZbjY78Q2VvVJ2TVM3raLhuf9QVR2iA5uMJ0=;
 b=qCxfSbes7A7wbNebklPMMm11XSGokx2Qi8m50bn+WI7ynvRxKatJdEiHS5B91+fmIPTi+zZOogINGb2H2lBxEcvGhVjxbvRy3U6Z1oI/BY6r9u50vfKpeDbsdKGNFpCeb0y7do+T+upmGi0pIfb84WV97NrgOfZkXdFUYxZuwn4iW5z7Q1DHOz94zJZaOelYua+ybUhkz+zVLcW10zc03ZSW3bztjUUPDKmFwMNPQqhx2T0yu20SOmnnwheH7lgvLr23LEQkKAP6qndyiQZl3AJfixttCwRDGLRhSzXxgyNBfkvgQjTmV66UsHJqjcMfh61JaOgCCi4Rj+5nj3JW/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 17:51:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 17:51:14 +0000
Date:   Mon, 30 Jan 2023 13:51:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 5/8] iommu: Switch __iommu_domain_alloc() to device ops
Message-ID: <Y9gDkUc0rMFjHd2w@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: BLAPR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:208:32e::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: dae4ca81-933a-4192-0537-08db02ea94c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfKyohnpk5RJLAq5vLPnATtkEbn0Rs6dAvhpK+ConwsrKky7tAX0la6sjXtMuhsc40VDyR8T/jm6F91zTYtbujoKXqT2eWB0+y8PfLWRuMY3XwjmqPyQYDP03ozS96DyH2YVQvn2WjT9F4pMKZC8hyT/h66kMekK8Kqyo5Hapg5RX4CvbEpw1vNgYlMjnPDbmaUQxXdBuWRhOF0ko9vKRQAmr9jz47Q2ZHDWopqrQpmbaeJ5/yBhTyy8qvUg/HlnSqnCZ7tFhAF47qeS1anh7QRp2Qyg5ETvnMCmFGCYQKR/uJlhd09u64bw3EuoY5zaAaKtd2M2/zVFgR1Et4icB69Ag8CPsPlRO1+PMUQ6v8ypd0Lbbljs1ovmoXilDtmL8vsP+Ef0IjrheASbRlmdl7fVdXVRczQ/THusRB5cSD14odJ5z/vGH2mrGEVk+6xVX5DRUho7is2vpv3O5TkmHlLJReQHZz46693Zld9JeDDlDzv2ngnE6LtGtaVcpXyOB/VVNdWumJCaRGM/QO7dSRtJcPYNSB7uG1WRuzrj0QPsnRFa8U0LZRc3kCHTIlSj6L39b6NFHhwlbwliAKYp19CUxs7nlh/HyHOcnAgzgDlPTW40W428hgMC3f/BylZ929FK9Kx+An2t7ZQsy38l4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(66476007)(4326008)(41300700001)(8676002)(8936002)(6916009)(66946007)(316002)(66556008)(6486002)(5660300002)(4744005)(83380400001)(36756003)(2906002)(186003)(26005)(6512007)(478600001)(6506007)(86362001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVn9NxCITDTWknoqQgan17got9YBCMiuxAruTbQ4BbW687Mgs3+QnWrqkBp0?=
 =?us-ascii?Q?EZ+0gNXF8bjUvBtt6zLG9JZqQd6EZNc2xdt9N6eiQUQx1OEKWqHiKEgy0jSy?=
 =?us-ascii?Q?mmZhzZBhYLomDi1Ml/eAJy8MIxel4dsUVKkHMz6/s95mPDluiXpiYo79OF1U?=
 =?us-ascii?Q?8YsCbwogVz3B5ogZvRJlPoTVa6lBFDaVDf6ejTVyYXTu3EMrii0hGL77rJlV?=
 =?us-ascii?Q?LtqLqDVZpV4x8nmaElRulmasYg+Sai/JsnXFe8McmPP1sVdLFdebxTCT1aW2?=
 =?us-ascii?Q?iEcbkHpVao7qwrmP6hox0dMtbo4e1tkPqeZ6tFIqpd58rmPSzrOORYvEI28v?=
 =?us-ascii?Q?mEE2TPCUbomTR9YxtcxrsENqwsg7/sUNg6piNsh7QePvIggMCtSy/q8dXbqT?=
 =?us-ascii?Q?aHeLms2S7Puu6nhWZIh6m37mBriZW8/jtBxes9+TjKl5ARM/5ERzaKvBa3PS?=
 =?us-ascii?Q?Y1Ht1HADi+f6sJZtfTkgEGBDrFbiVZSxd+uAK2LUok5zHtNjjYSBC0Qs9Ei9?=
 =?us-ascii?Q?hlEOQnlr+mzXfG9/5dzx7ulTLLHcBnayHS4mGUzwNXffvytyBgFSellemlFJ?=
 =?us-ascii?Q?sYEDhoJc3cYXIvi81m6SGTvLOYZLKopPWAJ875oacIgfCiZC2neqpLHxew8u?=
 =?us-ascii?Q?AJCNB8KLhwSo1Fvof68sp9d1mw4/ucuS1+GVVH/GlO92BX0Z00bK7ZwzxYN2?=
 =?us-ascii?Q?Or8MZqXUHknha1fKQfws6J/lJb/yu+Bh1iuSso6HJAvwtP10V0OaUXWj7zkH?=
 =?us-ascii?Q?s6HvD5PwUZ8zsa+YPH0a0BcpH67UxGkCCGFvfFWGbzaqTQRbYB80BU5r6LAU?=
 =?us-ascii?Q?WtnipzvLK4qXbU5WhqUK5RB9qjx5Myl30JftQel7L019dO2DV65s6hWQIdPV?=
 =?us-ascii?Q?MvOI0dbMzGg8yivpkH9dV+Y8Yl3cIWkaSpPc/+GUwrqUjbcYRNQTfRKrSOI/?=
 =?us-ascii?Q?+27/ZfPUl5PzwglgvnP19xPlB030/cULDBk5i+vW6dgtgrzaTYounR3M3unm?=
 =?us-ascii?Q?HQHF5UxTN56tESqQvaIXqn5CT9gRJgV30fZ3BU9rTmnhaOh2nDTGG/g3K1FL?=
 =?us-ascii?Q?QIMiy/eUX9f7eb9xh4XawiG89Pr3m/iqdn8Q1P84gzjWW2azSXTlc9IbWPU4?=
 =?us-ascii?Q?DD0HUfWB43X4bbLuiwax18MNtyIpGFwSCJmUKy4SfVXOT7E2cSs8TQk3STI5?=
 =?us-ascii?Q?AYQPgMbQqRc4rLC1vaWScNnY4HjDihO36Pd6WAWeMf3dAs2YczSuNKkxMHq6?=
 =?us-ascii?Q?k8CHIeEkhpF2p387uGKMrvlL1bbqmVEEH8QFOGyU0dpKi9gT6D1sbKgVY0zr?=
 =?us-ascii?Q?uzgZFh1ERP1gfyvy7dB9VfXZjyUt+0076kQkOWIC3hAxqc2fJGxjuFDXszFR?=
 =?us-ascii?Q?dPhRY+LCWYmxWAtvCjGlx8DuCBvvd+3URdVVpl9gRTIJneb65WlmwTbP8r5i?=
 =?us-ascii?Q?gSPU33Z9+BjEwq94q8iPxjk/MpTQhuP+iJhMkPmtk51smRSrZMvSPBPZGq7B?=
 =?us-ascii?Q?WkRWjAXSLAM2dw1FFFfdwNmBFPHHYI4X2ofp8ClAMqwUr//iyRoMTo8D8OLv?=
 =?us-ascii?Q?bPZ72IgKny9ImkS3Gzhrutw2e10hyltrZ7x4a006?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae4ca81-933a-4192-0537-08db02ea94c9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:51:14.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTU/EdGjOi88Fbk6Mw9mQ5l81faAoAT+nylzFw8cuiwTmC7YmKKlHsVvZJeVU3Mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:20PM +0000, Robin Murphy wrote:

> @@ -1980,9 +1978,30 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  	return domain;
>  }
>  
> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> +{
> +	struct device **alloc_dev = data;
> +
> +	if (!dev_iommu_ops_valid(dev))
> +		return 0;

This valid check is necessary to be done in __iommu_domain_alloc()
because the callback coming from iommu_device_claim_dma_owner() never
validated that the device/group has an iommu driver:

> @@ -3120,13 +3139,13 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
>  	if (group->blocking_domain)
>  		return 0;
>  
> -	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
> +	group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_BLOCKED);

Jason
