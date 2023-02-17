Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74A69AFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBQPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBQPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:40:38 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B771C90
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:40:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnOj8ZW4lLBZ/XJE49o5dtgC3nmQfN5bFpP/nYUh90b0y4BIa1eoAQXIUbwxBJQE6F0c9tL0CxaR8h0YzEjyOmO2q8AbAwUB8DDWFGh9wN17KWJYVVtaNXlV1PhKXvDUBW5TPfsFVAv/cvbBWeERzDwPya0JxCLtLryESPyIto4dh9Hj6MrVQrdEIxMBUOcqzS/CGaYnx72PIuqD0q1n1fooDrm6DxAhvSnQ5SGpj81gsMU2t/a0YZywUV/PArtaPZsEUoZ1uh7xdd2IX8/G5MvA+Ffpq8421qfp8IS499XoA1jIqVS05xjh873q/38YETc4xwXkjGYRGnOL1kufzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx3U8Ur9Easzgvg1KGcbx++CIsiMLeOJ0nmVztUl148=;
 b=RVt+FNrycidHW7oR/9QKODAShgyRZYXSVesElJfj96e3X+t1cWDhirwzoKEm1hiwi7bAdC7zauR4XFtw9hZe3MzyS5I9FtoC+o0iatv+UPwUNKjBPQM6i3br3YhHlCGOPVAYvftSirrdyF9oQAreqf503rHK/duv0bKem3oTFeR6pCnz2Jz9+zJGFah9+3jVlv8v8DSyQcQicFazvuovkWGH0uuPIM9bYdNuLkTwykuGQaavQ9yWcEv236Zf60E+gitOcRYpHB2egIZ7wMG697fijGjN8dyVrvN62cLLVumMTd4BC+kVLct7YIhbZUsF9Cbu658paqVD4PalYAMQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx3U8Ur9Easzgvg1KGcbx++CIsiMLeOJ0nmVztUl148=;
 b=cHdMUB4481C7VluePe2X/EhRdfRhRG4xAtkyhi1sxsRnxjWOiIivXnoESORN9tnrDAOOA/Z+cw4CVQEtfthwYGr9rq72NUWqh23NzdG9mw5Vbj33J5RjJhaTDG5ox8fdbIlsTsrBWZSmkZq9BQqvfzwUzcrUDrM73DfBfNCexpfaXxFdBzlIQRjAPi3ZsjHRAGrHUQtrsIBHeLxXMN7sR8KdEjDL01LxG5qdv0iMTG2Tlham91pHi1wRQf6xAqWbTh3AafmL7iXM5RtMTtU9AmKU0snbXCqCYLPgYyQVK8cTS0VrRouzXzSyPKjc3KY+DRvRsWBZI9iVSTdgC8lwIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 15:40:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 15:40:35 +0000
Date:   Fri, 17 Feb 2023 11:40:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iommu: Same critical region for device release
 and removal
Message-ID: <Y++f8UmMK4AvrwBF@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217094736.159005-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: aab17aeb-2b42-472e-1f93-08db10fd4f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: migm41GzwKGDMyP2xu0lta3Dq/e+tVmIpTq1E8PIX6FSiWK7z9/jzqakJAqWd/JFFSI2PHrI2xAHiMnlsAxrgGoFcpvcdFEg4NHKyWl2Y+oXWQnUZlrNxRPT584b6F533AhHjROkw+Z1iESFTkEMIeJKiBsb5eKKoFKBxWtR0WzteYDbUBp2ioMgkDEJtoH2HycPbF1PAGPy/wmyPg3Ww1GEhF0Im4RMcvfflEdKwRj9UjsX0z86ghglK859qyL/mj/nncDSkVOBKRozZe3WCSP7ybVFCCVNPl/z9RlkA4OvlRc0Ch5yqKu9TQQ+5xa1HkTE9xYWqYUDhX6z9pXK4MNzOj6opRQEyiMpgIgdHOnse99D0pw4OmB6HX0+GPOAx/QmIBOFIaEldwmMSZtIAr4vwTI4Yz+naiQn5VUKTZiaNmc3J0AkX2ChBzJOwVk0fslO/4QcFx62wogI/iTp2/2BAQzaWatFFIKXpPhGrULK1qV2EgJ1wpZ2r3BLUmD/iZ53FgBnrVsrpvQfqHah8+TsZuy3GceWWhUO0YW9l/esNjgeZN1s8+txk+CTMDZTA7gDcCX+TIblyCAomlazTc2AsNJpmuCg2Uqfz10x9v3/nzsv8eeg0WsC7F5RsSb0FfYfPocZW/bcVTNuooEUFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(478600001)(6486002)(26005)(6512007)(186003)(316002)(54906003)(83380400001)(2616005)(6506007)(8676002)(66556008)(4326008)(66476007)(66946007)(6916009)(41300700001)(5660300002)(38100700002)(8936002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?guJ08uBnZUxsaSf3lPMxAHGyG5Ni9Zw6ZtNy4s29VETRkIiwWqtEjp9TU26l?=
 =?us-ascii?Q?HUN0W9fp9KAzuWCyWi/mPLJ5fLn+0Wa1Di58N0XhnacAD4f/3ncC6VfC23s7?=
 =?us-ascii?Q?QUNEjfmbNP0Fn5KJcMIGiZnFk3n2+sJxyil8pGFqpdOZ0MaQID0sBBtSZ6/v?=
 =?us-ascii?Q?88DYW/2vaeQmc9l7aIt/8+WDIpLpPLpVa38UtpXl4jGTPGUCRb8ZKbQj8yAK?=
 =?us-ascii?Q?06nIxpF2iCiha6wpgn5qoCPqu1T+zhS8a1yF6epYpfJr4YMyQnjAh+1a1VBd?=
 =?us-ascii?Q?AKbhsqw6AQYfMgzbHjRtCAybfteXdyzNBrZnw7ALSVkZkRMbB3fxCZxICR7N?=
 =?us-ascii?Q?RZf9laENJg6Atx3WxhbFj4ZbtQSenuLKiMKArWuvXyDZJlI/QPQgMuazTKue?=
 =?us-ascii?Q?9xzUMvoSlsKPwAfcsisUk5Tfjj5KO6Cqw3EbVExQLE7d3FFWaPxGAFJnJsvk?=
 =?us-ascii?Q?gpw2SW2mhveAXVOjcg2Ecn28QzPJtkOfdm5GmPGAQ7z/+ik7ao53Lsn1+CIF?=
 =?us-ascii?Q?PSSBEcIb/tMraWcFVRB0eGLvsiNPIkVpuF/sHZ5sSqstOhWbSnxbjJ9anGuW?=
 =?us-ascii?Q?i6JJ3sPXRcw2tzmYz6v1HS7gxwDED0kJjdSGnJQg8OQzZRK6AJfnM9Fp/kiP?=
 =?us-ascii?Q?cH9/UaGbii9tS8fma0hKHYPkSn9q3TocXVSxl5gtS4DuokIq4xBbJaa6PPNK?=
 =?us-ascii?Q?IpEooqUYNzI2pZJ6FMRoqRVY8Qvmjvd2lbZKdqdjnQcQ5WIYmAAei70k9I7l?=
 =?us-ascii?Q?ZWfLB67JewrCLMSoxgy4Agz2Hwi4LQUz5Dt7O1ZEmNbY1MwJAJbWtd7AqaBg?=
 =?us-ascii?Q?YOCJ6JNne6uIHFYqkOIG/XKD7DZq3AYchC9xTacU6KSlHnWcJ8NUGqIzEHe1?=
 =?us-ascii?Q?j05NdXk7zgB/xLy+ODAlx+yGfjazWauUpahB2YPzuax+r8PGBhcLT/8AipwC?=
 =?us-ascii?Q?WYVAWzEqOgVYlloOhvAJS5q4BTPyoLrI4IXYbl0qTolIRzet1v0xLnMUqwc0?=
 =?us-ascii?Q?codyPn3/TUqI2MvWEU74B4xUdpMeLGdfL0V8xqmaBN9S5mff4JtkLe9rOzDk?=
 =?us-ascii?Q?jsIisFnSSyjCTqgF9maaCzzps7gy2kEeIMFG+AqP195WT93BOvRwby+X6PRP?=
 =?us-ascii?Q?XvF0XxXUul9ibWGVMgd5N3pBjYqcSitLM/GkB2yHSoq5/v9PUtOxyNqJqmRN?=
 =?us-ascii?Q?4KEyZ1A0mrfKDiSl8/Q2hA3ZRt7yaLOFfIau9sb7mr3JJBIWr6C6r0orMjGk?=
 =?us-ascii?Q?PuGh7I4g7cRKh4vAUif0YvPoZ1Y+T5/jN9DY6YKTVXhZX+bX2ZMCWcMNkjml?=
 =?us-ascii?Q?rhOR5KfLplnYnLS3YNFpJlYzbDG7W0GzGYbRuLtNGerzFTiDnERvEXFpZCWQ?=
 =?us-ascii?Q?gXYhgqUQmB7KW7hp/UFyE7OVvAAWjfhDCznDJZDtTViE1BnPnrqTq8bFzwCz?=
 =?us-ascii?Q?Vuw1+bOFq8vYLNQiA6YrMKISh02Z2M12FyTbYu1LGLYU82FTk5EVTNdGkI8F?=
 =?us-ascii?Q?dMZirZbpICj55J2wLXB/r6ijdv6iyD5+uny89Vo7rECH3PWFB9e98ZKGm3uq?=
 =?us-ascii?Q?6zmn+owiscrO4wrgT12SSXUIC1mg6xOeZxR1pZdb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab17aeb-2b42-472e-1f93-08db10fd4f69
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:40:35.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0odraIbcNRNcTpG03HJc422SFG5tQSd6Og/8PEXXiBL8Xuw3LqdSbhgmuFT2IH+
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

On Fri, Feb 17, 2023 at 05:47:33PM +0800, Lu Baolu wrote:
> In a non-driver context, it is crucial to ensure the consistency of a
> device's iommu ops. Otherwise, it may result in a situation where a
> device is released but it's iommu ops are still used.
> 
> Put the ops->release_device and __iommu_group_remove_device() in a some
> group->mutext critical region, so that, as long as group->mutex is held
> and the device is in its group's device list, its iommu ops are always
> consistent.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6247883991e2..093692308b80 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -101,6 +101,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>  static ssize_t iommu_group_store_type(struct iommu_group *group,
>  				      const char *buf, size_t count);
> +static struct group_device *
> +__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
> +static void __iommu_group_release_device(struct iommu_group *group,
> +					 struct group_device *grp_dev);

Seems like a hunk is missing from this patch?

Jason
