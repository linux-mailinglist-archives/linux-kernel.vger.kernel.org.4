Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0C645AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiLGNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLGNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:23:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D59259177;
        Wed,  7 Dec 2022 05:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQryyM8WXCJqimCqrjsP8kkuTWwqbxzDE6wxPXXfzCK9/YTMs3IC23XO6yZsq99Sk0Qjvg71KU10zAbWtahytTb2d+iC/M17HJkMZ5ewaqd7Bf74MPzpEQiumEJf9zretXHjCifQOxcRKojkFeknYgiPtjtbFdlYNB7tnn75NNSenXPUom+3gDOgMeLaqTIr0I/lYa63VDnAoGjJEMslRUV+Qpb2NhQryvMTPyLXVm8p6Ck8gRKiQmvSpVFvNmbyPYjkme+uK7jDa7QdtCxG4BXBYtP8Ix9EATWzH3zp9YVzuroMrLg3hp4iqnV5+zLFWFH48IT0ClDxmGoANTx8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbSciM4inIhGX6Kp4lwBdn2OzijwnzcsLqUy3hK9ENI=;
 b=N4uGkRNEU4+kUPxFsIYBbz9kLVMVnjWEfR01CfHvkycNTf/0YkO1u2l/f0bujSID2PkcIHO5zQGIEVGN4rXF6tt1ler7rbHTmQwPkLAvUU8tuFBSnKAVMQuL3cuMRWj6eS15WJthZ3Rja2lkPg6z3m+3ATDGd/4aijHat7LHhMg4Fi+OoJfRnJVrgN4j/oZpa7sJB3dAb4zpXMPy5C5utyQd2nVuvXN886970h2wdAcwrsF/D9eRIgiJCc3DXH2lJlst/glVYevQZGaSLJt1/rggSHeo53/JnpinqMTVszekhNObYmLM3VuP/O5lD3AMJhefkKaqGJvGMzVDA/uJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbSciM4inIhGX6Kp4lwBdn2OzijwnzcsLqUy3hK9ENI=;
 b=Z/2wHl1N4R8ksfdECZqYlIXjT285w+TPdJlC7ave8x2g0TXmPTZobEwZQQpVIq5yeBAHVaIhHzGQhUsgjWuUsBPr1bEiU+iXmv+8H9RwQ3SZCuOwPnXL4POwNKgGyPUQy+dzT1Nam8xR4LUILBXbs5evWg1dXLIOY/WoFE7cgKU2eP7M/98uVH4/7agea40qujlLWoN+6eLubZFQ56HZWQ3+lhNCfwCD5OaVQAYK+mvsYnCrKxlc4xXJQVc4Xu+GnATJJGvqhv+P6CYQlIyvC3a4LyYNKzOQRehQU2givGA1YTVFHadJ/3uVr2VNhB4IZhazMfjCAUktZ2WGFs8R6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 13:23:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 13:23:45 +0000
Date:   Wed, 7 Dec 2022 09:23:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y5CT4BBO9hsmjJfD@nvidia.com>
References: <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com>
 <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com>
 <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
 <Y4Zm53o1ovdIAqr/@nvidia.com>
 <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
 <Y4/LsZKmR3iWFphU@nvidia.com>
 <f9433a12-eacd-9e6b-a517-c3be438193d1@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9433a12-eacd-9e6b-a517-c3be438193d1@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 910c307c-1454-4812-d86a-08dad856445f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRnZSWeqRyJF8SFZni6hJT7fol6oV2wwiMSSmzG9lITbGBYG7pH5L5f9LTMSgWqmjLc4X8gtlCNeqZYgF4NPRCb/nAkWooiG0/RRfEyHS+PIOql8orYiO4O5qANatxkvrInCBbM0fgwnIqOlPL4SIyLj9JSwpq8qHttFhoUrMngAVcnLNqyD9Yn2TK1Zol2OTCimDffFHr5lBzzU3TNwu5cPW510kbvcd/p5KIPSe4wFXWBxJrZXX1wYzcruzwR6q4P5Hv2TbeFSfdTsEUx1q4ozB7JyVMJpiXDgtq0BPTp9us5VeQGikTmViCN/IxeHFaLfXW+tMVE59O6oA0UTRw8B10MvYYUI84sm/ScgwEsJH0LW7i30TqdbQvmIj2+7Z4Z4fq4iZnCB2zU+8hu9ACjSfP6KoZ3y37JovAZH9Mm7CXeElaOj/IWTq0Y2w18gLmlTDW2zWpZghDP5IaCypik6wbfdYEn9PxshzMfko3xin60k6FqN9I5ENm1Nr5uZak5++MrYIRepn4066I5mMueRIZSNmnEgzwOE889FFFu/2wx09KE7WVtTuXsUCNWxmD+E0ainkJuS4VlJymuJq3pOPujREDvNJJF/VkaTxUOSTsD9f0soOT0uprpJWoAF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(7416002)(5660300002)(66899015)(4744005)(8936002)(316002)(2906002)(38100700002)(54906003)(83380400001)(6916009)(478600001)(6486002)(66556008)(86362001)(66946007)(66476007)(36756003)(6512007)(8676002)(4326008)(26005)(186003)(41300700001)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqRFA3W6Q2bAeCpz07KZP0Rjmahn+CRJEGHqZCULh2k44tFYRWy1IzgW9piG?=
 =?us-ascii?Q?lLbjX6cSgPFm+2H76fjrNSZ/jOkkhGAAZ01NUDS5e+FS7S3EJO0PkkRFssGd?=
 =?us-ascii?Q?FBTKriAq5SNyRcj/lv7A51gpeMeenK6mGqz8ipqFIOR89UGHc07rlOq/mFL7?=
 =?us-ascii?Q?lDi0WsEKhJ7AzN8V0DR0h3APLpOu89Fvy9p5gGxMKDMTi4v+DL1lcUYS4tL+?=
 =?us-ascii?Q?Y+JdPWenMoWWv/pO98MvYIV2qTtBt/Bo82wWSRDjfAUziLI/QMM0LTEw5bH9?=
 =?us-ascii?Q?KZ6PCscy8dIcXlqkb1Sm4jSMExzNdaM6odeV9XUrUOaWoRUeXcv1qJrQpGwa?=
 =?us-ascii?Q?nqWAeC2vXKTHRenUjwaGKp8r41VWgz9InuueaOxbyMa4rYKJtpmv+qn2YQjy?=
 =?us-ascii?Q?Xq7dQ988/fOzUEJqLrGYEEaO2f/Q2w9xQ6ZmLVsITuLilTiusKsaeoJKpbic?=
 =?us-ascii?Q?tv2+UO0bAmPgLhTLRuQzu9YwVRX4x095Y1DjjeOFsYQs4QlzziHqAkHUdvh2?=
 =?us-ascii?Q?hvamwfpR0RYyywRXSR1GjgiL7FIWVRCvQoPXoEk/Tq/b+DTpoYvLQnmxM9Im?=
 =?us-ascii?Q?Kftxp/HpszR48LcikBNVGMrdG+C6HBdiCks+vCR+oZ5QfU186f9DjUtsXD5S?=
 =?us-ascii?Q?oYA279tvUpowsCDaYnZVIoWuXjHIosfO7IyzdbBqR1tGZwEgvj1GEjAwdVwP?=
 =?us-ascii?Q?gX1uWlBvxdZ4zFmBtK74sX9hrE5Z30nK+shox6ifTt+vzzT+0IPAx9wB1b1j?=
 =?us-ascii?Q?dGE9mDGsu9nFAyjfqGkuyt/K1UTpLQ9+8F1nO95Fc8HJUfhy0B6R9ZRyF40v?=
 =?us-ascii?Q?kI/FQc4JosgTjcihhxlHrOISHZOY1FrXWcqBSlFTUzvwy9b3VlUbYaV2E17U?=
 =?us-ascii?Q?avRn6ZY6FtruSVg0bMyqBQcofXghAGqf8Ew13mpPkWVscggqntK+s7uj8k6M?=
 =?us-ascii?Q?yz91UkK+OHx8H3gm6qFaCefMM3VaThK5mtUHOJoINCfF2nK9fRV8WnNvkEKO?=
 =?us-ascii?Q?KwGjeFEPmbS7sFCEolsNvP1L10pY6RFlNzXIKpv3B6dvimsTZpPuBWL5Rd+E?=
 =?us-ascii?Q?YbME/p7crUIPc7DefAiPFxXCJPGH/lkG9fOvc/LSg1DeL2mQoXpMD8bNIazP?=
 =?us-ascii?Q?IQB/AGnpAvIbtBxSmVdOGFdh7KBVBKyUAO6Dlyp9SWIzlg2OmQAeyUBntpD3?=
 =?us-ascii?Q?TwkLeW6LUrPnBljpQky6PJ7SrAZkNwrnoAtijwyxbX+0EaUe68GZIq3eT+Lc?=
 =?us-ascii?Q?wfxiQFHNUvoteDLpawImTYa/lX79euY2nh8/9k7W08sieHLk3427mwVkFhan?=
 =?us-ascii?Q?XtxmhevJ1kGrl68Kxl3KfkQr7YKeyMMryo/fs1YMjqqwG8GYAdyC/YRoi7Zv?=
 =?us-ascii?Q?EqelSpBdqAOf/gzHoAZ2RiYU4m6+VhCQdApVJEzmxSKnMli9pPxiLMWvDgqh?=
 =?us-ascii?Q?ktHWuzFVV0ityj21+bZdfxgKoDyOlIP1OSw1tcQerrSAHdtu5oY7W4CA8jhQ?=
 =?us-ascii?Q?GYpQr3tGrclw8tod1xDDXAkx/rtcB1Ld9i6wzpENx3MW20Cden0UgqDpovXO?=
 =?us-ascii?Q?/+pL0uU0TYpbb4O034U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910c307c-1454-4812-d86a-08dad856445f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 13:23:45.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM3ZpEQYQ17/JAyNdNB0mnD3dwhoy3NKI4zVWI/TkjKxpYBbFsXICbwiwhonOqQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:18:19PM +0800, Baolu Lu wrote:

> > -	/* Check if the device in the group still has a driver bound to it */
> > -	device_lock(dev);
> 
> With device_lock() removed, this probably races with the
> iommu_release_device() path? group->mutex seems insufficient to avoid
> the race. Perhaps I missed anything.

This path only deals with group, so there is no 'dev' and no race with
removal.

Later on we obtain the group mutex and then extract the first device
from the group list as a representative device of the group - eg to
perform iommu_domain allocation.

Under the group mutex devices on the device list cannot become
invalid.

It is the same reasoning we use in other places that iterate over the
group device list under lock.

Jason
