Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064F46742B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjASTYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjASTXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:23:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF759DCA0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:23:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKtVdJrjGwccWD8QYPH5LBJsW7D5oynPxvS1/CwuL0GAfR9n72RM4rnrvNvg9/HQ6PdCO24b6TQjPGCewZ7g0aVUSnriLg/c/o7LJ0E9zfM/eA4q/iZl9EBYS7wBhiEGHiEJ1bdCyBNgi0aOg4DhqKJ2LGelEMFgOpmgc8lsjXe4XmdjvjCyJY3el0ydC9k1M3EO4uj0KA+UjLnifWS2G5hxf7ErIqEKdQQUQgVE6hIG2bVY5eLZ6MxK2usXVHCE+mPLkndbTgwTPnD0Lxl5LidHZGAYHFzsJ/IG/k+3yeSqYf7Y/jLhac/ZwVMkUo5UfdbvxXth6f5zOopO+eYBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw2BqFd2mN+LQdtBuFDNwiBdqXEBLE1c0Z4rRTRrbek=;
 b=Lgw517UQ2qc8Zq/DmA+R12Wew+CSM6tBbfQnFwZxAR5grnme6wMsne1y19OzikV2OLM4UjNQC2PITJ4B2473RUvE8X842tWrq5B9H0kWDGecAcEne1sS0c5iaZdu/hlgmH3bxL4/wC8Z1Ch+r7wnWs4Jw0QM+K0nKNx4u3CynTV1+pcxJYJdg1bPOvipJ2jYH3PIc+lEswlLIwZNwB6JwmcQp8ulwcZ4aoDVVRub6QrZ/RK8hsXTXcOMa06/K/iKT2NLscRveejPV0WxEtJCqUoEziQgxDhdXidW4u0BbDJ9jXRsyYlZgYZgfrhpGOiWL09LQRg1QDso1jR8CukwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw2BqFd2mN+LQdtBuFDNwiBdqXEBLE1c0Z4rRTRrbek=;
 b=itM5VEIlkKLhGz+oJpmSrzwHeYsHXa5CFf2/8ImXIx0jgpv6JTpCFOU0vqUGDfV1JwtIdj3RKcIHnRmsroMdSe7892L25nko8Lw3uHARjJGdzAA0lGVZUYd8XhMn7bUARcYCVcmLRadtzsuv152siXFQkj70/0Gxrsu/lyEAfGRoZEHkx/sdaw/CR/gsb3dYbRkJehTUiJcbiqXic+6aW2vzb+ymuvuAKAIYPjr/W/8iCGbD6cMnR78uJmWq4dA2PRl5+7OpDm4CxoLOaVSy226EX2tA2/JX6N7oqeWs0hr+Wuogb92/AcPIK9qTk7Y1tBAip8dLW8FHWf04CXkIwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 19:23:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 19:23:02 +0000
Date:   Thu, 19 Jan 2023 15:23:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iommu: Factor out a "first device in group" helper
Message-ID: <Y8mYlV/ODKZ3EG57@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <592bff75a7fc4d50d5b2435a09dfff19f1072973.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592bff75a7fc4d50d5b2435a09dfff19f1072973.1673978700.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:208:134::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 453d9201-22fd-4c41-64fe-08dafa52955c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHCSFX48yJQx5ESn2DWZoCOZ7Wc9NSEH+QgOrXw08pHkMuwgn1nJsOBYD84WSHv79ouqFSrocIuU/EWiIdbHcx+q7h2Dgr2IccLe59mIWaGEBtHWt5zG/oZrdUjxoI93L2yJJGvHUZIFQKSPA3WLRfUMMB8uccKjqkOyhnZgvY4jGv0s2nmQssveK4Yva3EU6x24LRhgpcE6LOvdds4vzjOyqGCPWfHbqd3jwN/tzXwQhA5nS0uvErttR55KZbrRcXLXsUJyfln7wkwO9/FAL0WFDiVDGN/Qr6RzEHGN6ydGxZnJbkp2FYk5gJYGmUWGm9x5PBt55YJngTYJ34AYCHbDqjAL3zm4t7ICKVlQsABc0aYs/FclfrLIHldViHj24ipfYTq9Dmdh8+FvWLauZPj48pNY8/sn4EQTvR20LkCq5ThDwrM+91IfBwBSc7N3/A4hqGEefSePWsT3N34Nd9QmTF6fOISNrTcP4Lt84KkbNk93EFXsdphwI/1mdhXBXcjQmteukpRaWr+mNc2W2uOC8+jlLF2FazYZZIbdb9tNAHFkHC0FJW4dvcQXaZB+I2FF1uZ2ZliUOo3fPANHXuG9PMG3zpt0d1v2hRmncS0ni0ZAEDgY90ZvU4IbrhANGT87ZFS5ZRwD7MUxp00MdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(4326008)(41300700001)(2616005)(6916009)(66476007)(66946007)(26005)(66556008)(186003)(8676002)(6512007)(36756003)(86362001)(5660300002)(83380400001)(38100700002)(478600001)(8936002)(316002)(6486002)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?te0WtrnZENyg9xQoo9cLFEaZtw6CJlQC63VIWqCnT6haJJjxf6llA4KRo+Za?=
 =?us-ascii?Q?5QUcNW0Yc+/sxpugu6GZ5bZy9IwawNc9cUPQT83U6uEEg0OcuxOVpMn653c5?=
 =?us-ascii?Q?qtvEopgDDpVLUiaZtPeYOFQxS6J/aq8SQNsh+QJDzFOoyXu8rv0kiEe1XWEH?=
 =?us-ascii?Q?HVd2t7KuRR0bEH2LcBfvysichwmFwEnO7UCKbZfidh2NXyafnldJ5TAbKxu+?=
 =?us-ascii?Q?JsmOBw/a9NknU1TAvWWqYZukRgmZywoVrWkvMoTQS2NAhk0czOoWtZ+2+ZmZ?=
 =?us-ascii?Q?SAEJoxpZRqgiYK0AvkINUuPy5SwB6jLDhlqQFZBz9d7Oy/cXgPg4JW04tqYQ?=
 =?us-ascii?Q?g9dJbUoCYfjNFobHXuo135KSrLSBzvPcYE1ZcCnp5XuUYrqLmBCsRtCZ/LYL?=
 =?us-ascii?Q?mr/oSqVza9SkRSLCYczEg4/ijY+3TcfrWBFO2qVSRz1J8XRsSdEjvfKvCTAb?=
 =?us-ascii?Q?h9kqVeJ19JUljo5KydqCL2jXyPNrILrnDSKKMOzAQ5fhawJ1G3qligmWCXPI?=
 =?us-ascii?Q?5DS7ZUbWu0xMHeActVvscolL0KiGtr6l3gI9T42dfGaHzQLqMxgib6+fAEd0?=
 =?us-ascii?Q?uo0RJTHz3UUYzh9EUnLO418VtfK51o04OXzJyFdmw/GKR2hOnN9UM6U1r89u?=
 =?us-ascii?Q?XrwHUDf8guCjovK5Bm7varoBUI+wS4KqmEded88jYHTS/SruV8R5OX3wppt3?=
 =?us-ascii?Q?Vb+oNB+VEWWMyRXnuXLdj3bs9y+BjOFWaJs2i8r3Z/tCxRBymaJEbLbaTCg8?=
 =?us-ascii?Q?hqstt7Cnj3aW+yk4fX3ckY5m+o/rw115qKhBGlgySQ5h9cZ6nJia8cvMVtqm?=
 =?us-ascii?Q?d72Nu6swy7DkoR5SlB/vcFrqNQhTAbXUtKGZq0HbaLRRTxGISrC4jX/Z4nFt?=
 =?us-ascii?Q?cdMudBxMAMw0gPQ1E448I/XPAFULmL7TKlHEMBSWxVU8fzOMVjHl82BqAJws?=
 =?us-ascii?Q?Pn1Nx2bOOl+JGWU1gvhVm2LXztmU9gmsZi4Q9NtzE3epyghW4QhP9cGivVy5?=
 =?us-ascii?Q?mBzBLL54Yck9Xj26Itbu5QIzD8WLWUkwChRQisNPm8wwrqPF0R9lNhi2Mqd6?=
 =?us-ascii?Q?SeAs/NouzNptfklRZEoRiI/lF74i/jKIiy9lABswungh8liNjGgPx9Ad3ZZ8?=
 =?us-ascii?Q?eicGlsrKTnQHgr97I9ud63r5T4ATpRWTMHPmtwYzNAJ5qJ/6/pYbl3C6RxLL?=
 =?us-ascii?Q?VHkYoRjdmaK5tdlsHfmLAZgtVVrZ0aie5a8pnoAPFon8YZq5lvUKjg5zjS+w?=
 =?us-ascii?Q?7EDjMHhAt2HD3i80C3LhPew2uGR0eeoydtMZ+I8Le+x5qf5WJARl7Bc4w0fo?=
 =?us-ascii?Q?w1buMy7Gn1XE/ZVbgeuSMc1WE/hhPKDFML4Y/CqTx9N7V5TKBkeR2T/Pk4gp?=
 =?us-ascii?Q?KH0nkj8mwzxZhEXlL1DzeRKiw/IKaU30m4ZrC9+VI4eCK9ViDvzSaGxHBU22?=
 =?us-ascii?Q?3TsPqKst3a9/LVZhL/W9ADGQ1l2KHkdsJSrFMlKLjvJpToXFAXHOk3BU4fZ/?=
 =?us-ascii?Q?BnJJWPlTJbBj6Bdr370F9SAeM3b1Isb3BVSahL4jb/v8uXW3y7D5ycPb2rCd?=
 =?us-ascii?Q?71mWwJgi3110DQyG/rWLy+2WW0yftAvrySz+BmTx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453d9201-22fd-4c41-64fe-08dafa52955c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:23:02.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npO07yQD/U0yRK6zG8J90yTxCYtH4CsmARikQyZO9r4vQVV9vEftrBFAa2nnlRTy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 07:18:21PM +0000, Robin Murphy wrote:
> This pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index bc53ffbba4de..5b37766a09e2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1084,6 +1084,11 @@ void iommu_group_remove_device(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_remove_device);
>  
> +static struct device *iommu_group_first_dev(struct iommu_group *group)
> +{

Add a
 lockdep_assert_held(&group->lock);

?

> -	group->blocking_domain =
> -		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
> +	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
>  	if (!group->blocking_domain) {
>  		/*
>  		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
>  		 * create an empty domain instead.
>  		 */
> -		group->blocking_domain = __iommu_domain_alloc(
> -			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
> +		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
>  		if (!group->blocking_domain)
>  			return -EINVAL;

These are extra hunks?

Jason
