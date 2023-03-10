Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B06B33A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCJBaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJBaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:30:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADCF16AB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ+zqFtICA60ugYO7CrVmSSQWCg9RoPi0wJiKPeoTQcrERaAbzvWhYTDR+2JbgJ0PSLfDn9nH8FAOOQkAVGKBtanQ4RV41UH4a5l0Sg8Djt4ZSsPUUYV58p+8IGbJJ4SXTZt0sm1jq9OUTrcb93RB3sX+r3KO3JACrYvvEE3rrvDWAe1ZyxWne6khIklgsG1LLTTVMDKduuX0Wzv0PtyrMy78O+jJ5s617Fn9bZuqGadjMKIsb+9lhp8aV3aOllqikBAEyPgBwMVXjzCpEe9I1cVoNG+wIYPBWQHzrH0z3aSOBMTIHWHjo2jMreAHEMLHC2sC6YkPyhGBdVG3Hwt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3mqeQHY2VfHUz2kyMp3wpxcvWtkQuSlA6VBx/zUK8E=;
 b=QkT8gmuV3zS/noQ3Nt+y7Hqam+GdDl4esHjjJEPobYSv1QmfQ2N6S0VvccBVC5mrdkFnrCMhNGYH/fKZY1CRGgGuyAyb8M1dDHeNymcWnYGqT9lTWm/hYVyLiLhiS7G2Bd6xB48/VjZOjOBEvj/qw8fBcL2h4zI4R2VQSBxqq7x+gQzA6ClBgbBN8pl0+ebe2L6WQ7v1yyS6ZhNIt+gqRmvkdvuruov365rFOM2vw7B2XGC7qDlJqh8gDlAtEFuWXe+l3PoZVOqYi+bGgNkCqB2xpth7C3Bk4ErDNCpt+QZb2d9b/BLOdvK64uNtNPGp4LWLHmnnj+RDPIXDTyHbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3mqeQHY2VfHUz2kyMp3wpxcvWtkQuSlA6VBx/zUK8E=;
 b=K3HSr0yFIYurXa3zPVMpJzAnGkA9AD1BwSLuKMM3GTMRpEUbR4GK4mKCNV89F1mNrLwRrojUxfMNN+ig5L/3pHDoZb7AdiI5+5Sv0c2FwXiTN7AQOKIZsyjUEIRQsZPERf/7K8CmLai48vf2LNfVpA14MMt2xY2hfzsSNkDNxgbB9uMPFqEOEiHHbiETRF/J89E/BR5diamYVbK4EKczFNwsuqomJQ+v/eL6ADpLeBF/kVJTJlnx4c3sE64lYW6GjHjZ/r+v+7uQTdrdjRTqTk7gbZulNZGyzzFbdPO5BCQU9NH33BFwqxn+8xx+TvL/54A3W0N0cA6p/khWoMY3dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:30:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:30:03 +0000
Date:   Thu, 9 Mar 2023 21:30:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iommu: Replace device_lock() with group->mutex
Message-ID: <ZAqIGFnJ8U0s3ffI@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: a99c4736-fb7e-48da-d52a-08db2106f8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NzZY/CI7rIzMwOuhXjq5aP0HBzStKcUtnn1Ku/AlfUrgvAOGjgb7GQHPMXL2mxntR4toSK182IkwY35UObj2EJpZq2yb5vsKbwWctaG3tjyf6qvnFW5pLfxvRyv1KS/bhghpTfo84jwdd/OkNO3x2YcGfjrcLannKkXvvUnMsI/zs/h+QMd488fNPhO5yPNDzfZo331k6xGyTRgO52OtuoX5v2mMluBb6qNVMWQ+tgqz9NV9FIBHebDGZcCU14aff2OmBCpatoBIJU+HkF/T0mGKX4+iyblCY9Xv6NOOIQ3vR0aTmdmcGcaCnwUDNQHVX8GC0BsLofaGOvACs2TfmvB3Vzlbril7pRFEB17z/87U//QEqcfpCwSVxWEP/AeVWwjLMXi38LMW8RVRiJ8iph0h4JmwItEK7/rMAMVm36lrBGjq+pBrHoOGkcf1pQ/G7N9DQ2TJNrUHmbvBUKTebBGsiMyEiXqHH8kQEKT1HJIFri0C5JttWYJR+BUUVto8dV3PqkApX5j2qAbyqRUD/a/O5mwuD00OsKXMC07k202iOlVMF4IbzKSxhAbsdiL3Y9bT+jsJNx70jRs65BB0JTNrL8uh0iQ20jrIgxvfRD9HYrJqQu/cn0aMtqzeM85KTMKKh8ok7YF0ffbSUIDvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199018)(38100700002)(36756003)(54906003)(478600001)(6486002)(5660300002)(41300700001)(316002)(2906002)(8936002)(66556008)(66946007)(66476007)(8676002)(4744005)(4326008)(6916009)(26005)(86362001)(186003)(2616005)(6512007)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6n3jWJPt9GV+Q5tz3vhGgOolYXFrubtGj05YhQ+JQyQyLCbemcpzk4VO/LeW?=
 =?us-ascii?Q?orL1fzgjhng6A5qWpDOVQa2/dyajKgax9IwsdO90VLiGG0TEyXwmGZGk74vV?=
 =?us-ascii?Q?+VnnXrupUWXS3q0K/y/fhiYTaGQCdax01Xvychg4NZfY4T1aZg9UNCrC65zg?=
 =?us-ascii?Q?PzkQmy2lJtQFKo4jufiXv5AK4Kl3eWvMIaFdK+8RUGC4pGP1BE/wJ4Rp0+Dq?=
 =?us-ascii?Q?lOm+lDoybtdvEUgsYQbPG9yy9+Xq8usOBopQd1qfIoy+1ZfdBadqnqboF0Bp?=
 =?us-ascii?Q?LYU4/z9DY4/0VoCRc3ah37VV10tv9aKWl6soa58dpjjpDGzTtgxbLa8reClu?=
 =?us-ascii?Q?cto4xk+v13QVAC6Pc0MgKnVvC1HBzcggmDUy+wrjVFgxXH3VGnh+D7a2usLa?=
 =?us-ascii?Q?6bn03JA09awSvOJ2lWjExaPvNJWhLce5XbhwZRKFxusfrHVjcbC6d+wke77F?=
 =?us-ascii?Q?tmZjb6UNDukKOZdyBZ5j5VszEQWgWa+li0YV6cwfjPP4zMMG19Jj2VQFGn8o?=
 =?us-ascii?Q?StaenxezPyd+x5MjMEczx13+R3stLUMgj3+3aeRh9MvL+MkzhPQxcOy9alMQ?=
 =?us-ascii?Q?t9M8N2QLeV85K1zQJo4J6SJCoDXGYlcCghq23eekVTi7Gs/2cTHth/2CzY6H?=
 =?us-ascii?Q?31cvF53kKWoBWUbRo/u1p+LyNgwRJO3IXmDaNx1BOBeJUbANxDj1YU5pTYXp?=
 =?us-ascii?Q?bMvZTjKfGI4hoh1uWg2b2SJ9nb+UpMIdwHAAmhsigCcqy8UkuIW9EasqlMWo?=
 =?us-ascii?Q?wzQa/tPHPtljjQo7GfwP6EfqCPU1od36JglLWGbtxWcC3ssBpZEEWk2542Mq?=
 =?us-ascii?Q?N7ESEI19Hat+v9gwVLGs/GnLcPY+A4iABuAhRxgwoA7DbhWNcEYhqbndPJz6?=
 =?us-ascii?Q?lRCMQi0qAsx/ICW4ghvZ8XwQO+eb3dOtvTHEzm0koIkAuqdtJSK2C8JL9pCA?=
 =?us-ascii?Q?NXIq9WLy0vZRkIDCNkf78+tmaxAnzNmzK3y6y6phYAnzp/bc4+rUhVKuM0B8?=
 =?us-ascii?Q?SVwDI9O8jc+1yLF2wu8PDv0rmJ5K7D72/+jDrne5SV3IiBFo4F+QE+YRJOPk?=
 =?us-ascii?Q?gxFrIG4KeZqT2f9g5aM1d1iznJKdwEL88J16RZncfRtDYvSkBVN7ynYz5woG?=
 =?us-ascii?Q?97qOuZu3/rR8pONzl5/ini6d7LGto4bdMr7XeW9zxqI91E+znJL4TPSbulTj?=
 =?us-ascii?Q?7awz0RBHHraJP+iyBCBe3R+jt9FviS0ip0Maihp5PmL8Xp9WuBz+HwtOU1lF?=
 =?us-ascii?Q?pxKMmkNXDmCAGfZJALUN+zJL1SFeE07ePhX9toJ8cqKxGn64vgoYUVLQy2Yr?=
 =?us-ascii?Q?AZkycER+HJW920yU9HSqLBXLv4ElMN1VehEIzvT+Ge2wcT+2yZC4WcjGccJn?=
 =?us-ascii?Q?/avNmYyGG68OPL01EoyOtGaGd5htRo7AsjTJFqGoaSghyUxJNtJ6WD6+wWpF?=
 =?us-ascii?Q?hrPWYljzwlw+w4CbIRPLWdDz4uGNCnD7nDNNRLasGquUs/rN7tIz6O0xjwqq?=
 =?us-ascii?Q?FDSFcQl1oYz6f25ThVP89zPuDwj/yj83pl/db4MaKl2YO9/Hv5wIk+6B1Pkk?=
 =?us-ascii?Q?XFgFd+aQZK1CRnNq94/v9wE9l4Up7tOSI2xLACD5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99c4736-fb7e-48da-d52a-08db2106f8fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:30:03.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KqAIMhsfee6skSaVUtHib6ZayJsj26gfAgAot8xOH+vh+H8gerEjWgpqLEaAtI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:58:03AM +0800, Lu Baolu wrote:
> device_lock() was used in iommu_group_store_type() to prevent the
> devices in an iommu group from being attached by any device driver.
> On the other hand, in order to avoid lock race between group->mutex
> and device_lock(), it limited the usage scenario to the singleton
> groups.
> 
> We already have the DMA ownership scheme to avoid driver attachment
> and group->mutex ensures that device ops are always valid, there's
> no need for device_lock() anymore. Remove device_lock() and the
> singleton group limitation.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 78 +++++++++----------------------------------
>  1 file changed, 16 insertions(+), 62 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
