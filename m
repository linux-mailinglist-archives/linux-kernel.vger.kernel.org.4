Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528A75EFA70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiI2Q1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiI2Q01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:26:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37969130BF4;
        Thu, 29 Sep 2022 09:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT4Iw5REyPV3W0g4QNaxugYyuX9HeEq2w1cSDF4/SDfQa2HfxgEzxRDwL+cqKJaiQ/IFP1QSBT8i33XY8K+cB/vEW7p3i9qe7maxNKuSSAFo81Kes/1znk/MvA8KihIGyteez1LyU/1e0xjZfJO7nslNpVvG6H/RwoPawdxuNaNdtY2axDfQC3vHxeKBgOIe/2E8QlJy0nZ9OiRskD8OMVw/rY4XzHaxYocDHLisWSu5lMoxjbPzPdTm6lm8DV3JS2b2LYLQaGheIjBcCoYVI3bW9TD5MJ2BtPOd1qAaIomuBTW+z3cy655JovkD2z6pzdH/+6EMpyQBs53lUeWlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xiokt5oydiKsB3HbIjhnTIjtLPzDzjlRKb0+QoeaIk=;
 b=mB7U0WW74HEnpX5137t+5ES2RT3c2eVvZj4/yTGXinLE6wIGdQuiJwDrl42gS4o77bOVm/S0XtEwgMLXsfM/nqb7IUI+zCQ+WAmuk1C5uYVdCqixsimQm1rQo+SQhIa2kW3SLC/NScUmozly54P4VeTI44iZms+uTAbfH/+s5Ihpigrn32lTU9l/7wMK8wDBcJdK0DKOYNPClObgohV37APF7gCpI2Zh/931bQdPq1ZnF9ORAJrzIXwkPf4pO4CxZRbU7fIZgm/rMN5zk3kCqmi9I5LM0gsDx/lx0oNrjYyVj7EJZ5VLj0DWIz3Hwrwql7HY/gFxwxsqENpq0ABzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xiokt5oydiKsB3HbIjhnTIjtLPzDzjlRKb0+QoeaIk=;
 b=LP+LGxgX60EaMeAkzqa+GK5J/v6eGn5vE7qZLj8fJFiODhmDBjxAKC4CEfUz2dtDSwsRUpnOPYWc+qdw8ry7QLwDKVPmcS1bZqnNAm3qwYO1ls9/AmptduRXGQz6NKprDe1BRtIhEEmbotUfsw3fatmTAEZdd7Z5xEYeAkDJJWwnYg1hXb1k2Xj3fiEipGybh3anA0eGSe4LKqyALITbRCeiVu2E58o1r7t8buvb1TO0FS3TJnhcAcoTq6D2Q4JSbwatmW4rkMDUz1E1ceZdgEW4RDRAZ2s9KY+drayST5fEpIQQgawUEMIQdRkmKoth2IoOgZ9XQlgdT4R0pqx+Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 16:24:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 16:24:06 +0000
Date:   Thu, 29 Sep 2022 13:24:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iommu/s390: Fix potential s390_domain aperture
 shrinking
Message-ID: <YzXGpQkSG4cw3ahm@nvidia.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
 <20220929153302.3195115-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929153302.3195115-4-schnelle@linux.ibm.com>
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: e87bbfe7-73a0-4697-9c1c-08daa23707f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyQ45eVRpqBINR+wYIeGQDHNfUZqDWxBPJjbWwNCLkdC5aLnxta/PpNMh6HGsWoRd+rBV0JM7NUr58r8BqlNLl31g7wXcWU1GdYMb/tEaNWR+rq+elORe7KpLEHrpNSjE8aA2+qBqxCADtmUc72G3QC58TyNP6y1l1D8q+kyAkrCFzYRJd2HCNCWixkSqpuyXLNyElvyWZRX/SbCdZl2VNw3eEHe1kSQRrONVcyxMekSCXnxqPFbwPkfPHRHuPu0vAp5pHYw1hf3IyAlgpGWg1/f5eu22Q4WU3YxqKiPAGZIWU+sEaCxmCJq4iK+3L26XwpcEH8lBT4IS13V/hYFuD8ZyVKWTBOnDJZ3ralUUOCZBS90S1WNuqDvzYIDcSsODJpwMxtUMshd2jB+cdzb8K+MyJO7l5lLQqDN8tSWCKvvsdhhLo6xX67bL3tcttuqx58Z2IHqBnUySY0TcB6Qq/bOMlr+GDGU/Rs7IxwNUPjxmskq69vhgRlinqL3225vIY4MIxbR/nBd5b8xdQls7JhkeVqYbfUSf/5bKs5xj/uytBJpzCOn61mlSIniGJ3F9JfZHRgqnZI2k2xhtaSiij8afhAdsKZwYqaPo+EAl+sprJVXPY+d8qQU03GuOdg7tPECTR9HYV1IBC2LXSNO2qcgApkmNJPLOku07WODSVgzLOGJYfb2S9VDma8ev5T8Ufb3LvrzVW2cdqCgACRMZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(478600001)(6486002)(6506007)(66899015)(316002)(186003)(2616005)(6916009)(54906003)(38100700002)(2906002)(8676002)(83380400001)(6512007)(26005)(36756003)(41300700001)(8936002)(66946007)(66556008)(5660300002)(7416002)(4326008)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCTFdXdHdfQ4xCz/t+xY7PTOgMPchxngIL0nxXsH4vg8kp+QbIHhbmFifucT?=
 =?us-ascii?Q?4EevUiscXMBrHiyBetjlzuyWDVorUBFvDqQvoPUc7VAKzQ/G9Lx0ALlF5YIr?=
 =?us-ascii?Q?29gAi4ID2oiyFFGuO6FG92iKZh7KJKCytB5W2SK3a9rXFMLf3BmKL19FTR2L?=
 =?us-ascii?Q?YcWJZRp2NpjwWxuXUMbaaEWlDkYhdvaC5FdJ2EJHOhweMtYsLhfekVDUzOFM?=
 =?us-ascii?Q?yUD4sFVXq11/ZZ0zWU25qrDm4tKvYFqpCIFPIIoK+oKPW0Wyptrc46xW0ajR?=
 =?us-ascii?Q?X7ooUo8b1sSVEJ3yAjM5a86Oy6riltmQTW5FdPWVhFvKY7LyvlANGoTZwagS?=
 =?us-ascii?Q?+GGef3XS260Kl4bez7vXyPDKUHj+J8fYZsu4dbowwMrZOkgK+MYmGxujfNy1?=
 =?us-ascii?Q?GE1FdmjANYhjcum6d4a+B93vsdJ7aqklxn4s+cO8jEU/PNvvtLpjv9zAtBrF?=
 =?us-ascii?Q?dUYO2q23UR+4GgDSELqczBISm9zj5EnJDJt8IxSnCsWti8fr2UYd8O1tBgfo?=
 =?us-ascii?Q?skmq7y29rSqLudM7ixV3NzYP6U2PqVs1IjsOZafCZIXEYMc+2aGNa0c8GdZ+?=
 =?us-ascii?Q?lUfqHaRsnW7gHXDoekMu8mDmTT6N3M6j6jqhn+vqESr3gKB/QkfZkBsSXuJu?=
 =?us-ascii?Q?6+Gq3SBkrj6nI4xIvQhS4OvzmCxU3X6Rf4MHQQPO7OU0xf5Zk1LetfpwXu6a?=
 =?us-ascii?Q?HEB+f1/2YR0vBQ4OIUF8n+vKoxHB4439uRMeOGwnLEYCXtRtZvQyVwVg2TYE?=
 =?us-ascii?Q?dvHzOCvMtIuwX81Cr+ypg92UkG0m5aig10p8rNx1zI2vvrgLOhFqvhkF+dDA?=
 =?us-ascii?Q?fZVCBRzAHJxe/CiKTB7g9xjv8LxM/QcOXtTR9//xLItQ7SrXScddo951f837?=
 =?us-ascii?Q?dajHbZ/BrUATb1UEuSW8fHc0dRsxuacRXtgkAhtIJiOqUd2Pk+YOTJsK9PGF?=
 =?us-ascii?Q?zwhlFG/2PP+sspjmGHOATA+aHpVfhcB1FJnx8ttfSPohoOjg2mDRl6IShxW4?=
 =?us-ascii?Q?Vftfgnc197vBH8K7aPoL0FOa9RlrhItOdfrF+7pn+7QMeyA0w01r6m2F2sYM?=
 =?us-ascii?Q?SP4M4fk1oGddxqt6uib81uTaL97sJGp5SSiDaduScZIhymncZqW313X9hdWl?=
 =?us-ascii?Q?3TK1gWvnWKzwnoYQwk1z9mM2W5XHiBcn+wCSkFol0VdbU1SUbhxTM5Z0/QUi?=
 =?us-ascii?Q?w2/7HqBgH7lTe5X9jr4Pdx+oXERz9beRKUithny4xWgxeBxd2HGfWvEUQEPL?=
 =?us-ascii?Q?kpxlQaSu8hcqkRB+j7rdwJA5jTfJf2Ue4RSMwZUUjDeWfM6mHXNhpk/n3CRS?=
 =?us-ascii?Q?tMoBLYwBp4Yz25pZMbTWFT2HYdTVGo10oE4EkwRhWgxBXfADeuWMy4cjXD72?=
 =?us-ascii?Q?jTJ+PHTFrEytvQQjvBgFcggh3402J1gC67WcnA0ISoCWZJkRI2YHEoaP4rkl?=
 =?us-ascii?Q?5xr/tCkyMRO4ZIfD1qjLkZ7S3pvBOMH8WXZ2ARJY/5vOk0YyC+Ibex+Bqb80?=
 =?us-ascii?Q?S44aSCP0D0j/yazMblITtM0ICcASLx9BoCchg5KxJWQ+zjrmR18JmqteU5/M?=
 =?us-ascii?Q?2KlKV7YeNiFykc+x01Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87bbfe7-73a0-4697-9c1c-08daa23707f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:24:06.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmgYpjnGC0C81ePPsS3rzNLOCMzKyQLuEuZHl2R19pkH11Hm7zBVc5wTtOoA30fk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:33:00PM +0200, Niklas Schnelle wrote:
> The s390 IOMMU driver currently sets the IOMMU domain's aperture to
> match the device specific DMA address range of the device that is first
> attached. This is not ideal. For one if the domain has no device
> attached in the meantime the aperture could be shrunk allowing
> translations outside the aperture to exist in the translation tables.
> Also this is a bit of a misuse of the aperture which really should
> describe what addresses can be translated and not some device specific
> limitations.
> 
> Instead of misusing the aperture like this we can instead create
> reserved ranges for the ranges inaccessible to the attached devices
> allowing devices with overlapping ranges to still share an IOMMU domain.
> This also significantly simplifies s390_iommu_attach_device() allowing
> us to move the aperture check to the beginning of the function and
> removing the need to hold the device list's lock to check the aperture.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 50 +++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
