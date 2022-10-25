Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D484160D18D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiJYQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiJYQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:22:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C31905F9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H61kcLDRkuC5KeNDsqZ9Heiak07DPCil2QXbNnnYRO+ksnXpOQjReMIOQ/TLUPmfsfo9SFD8iyiTqItyfsDICX6nyCEbVwPGVlJPWAeg3dkKNY2ZHroh6oVQuh7MgnR1CiPhn6Qc7zjPXsKHKx/K8IMaiUTFD5pDDtKSQ7glCG1JPp3CbozqS+5h4Lqe1jBBdsH3otgwyCUOnWtNXDlYHQWgmv9TbXZSOh9Am0gtN2WeoVFx5W0N9pSMMTNhS2wniRgqBUhxdquRTTcGvKWPIDdhFbYAdXOqJB6Twy4vUyg36IILG5afA6cbp7T/6iT54rwTF1HClMI2Pf/u28154g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8d4/iBPrfokISv7bjU99Ri45rY4dvzLBALlBwjrf2Y=;
 b=FrIOpV5da8zGVjksLp/87NtmSbIzk+SXibxO+cq6gVKCuoF8Sj/piS/A7sOhDHohtSplqpvOQW+CxyfQEL+gEvyJBfZBESBA8AFDokhN1Mcp5nszmoFDjXNcEtMZOVmSUr89ZqH4ASl51D0DWUTkiMvdzrYxe6uLxMkBK5x+oi9nS/0pEoYjeDy/fiZTYcFjTrUvbUcaIG2hne+7QSi13/q6ezW1iq1mY69SfX1+2X+3Oiqp40NTxn0j0VgnHztYjJ9o2izgNeK+/cKt4Grj+/MIHDPPwHAiHl5+0vsT9iHCIdflM4I4562JZCdIJ0TQVrqmudUE5k0aGIIcEACaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8d4/iBPrfokISv7bjU99Ri45rY4dvzLBALlBwjrf2Y=;
 b=INhfIvhn065jdb5VPwNKcYDaCNNdG0nJyQqZxdl0sFvev5kxI6v0M8KTjF4mO+asovLB9DYQ/y//WRDjKALv23mV314k+j0vJhoEXQGcbe5OTwMtgUSd1zKVwFimVnOiqFKjG5jnTFNmPLcxbgCnBCp0SAx+9P7QhCrvKsoh0QbA8Q9dHpjmYQYTmRy06Z1SneAwFJKxHM/tiTYJ9zO9a+/u00tmnnnqN5f0sMriw/NGjwejGCPhbSexCZPMJ3Vcw7/bPTePYKbVm1q/fkoPqUyWXaaCpMu/G4UFkzrAhZ9IH18FTWOdrSVvec9aTTquhvMvnYi8NENo2XEU+U9CDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 16:22:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 16:22:01 +0000
Date:   Tue, 25 Oct 2022 13:22:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [jgunthorpe:vfio_iommufd 9/11] drivers/vfio/vfio_main.c:1690
 vfio_file_enforced_coherent() warn: assigning (-95) to unsigned variable
 'ret'
Message-ID: <Y1gNKJ1QhdcAn3rn@nvidia.com>
References: <202210252103.10UKM7Mu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210252103.10UKM7Mu-lkp@intel.com>
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: b79f355a-8f70-4ea5-e496-08dab6a50c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YEHyH3XxxXhcoGvmNh8rN5iKzyo1tJvTDMatOeoR5zZX5Yx6SAh1veTTOO7aqVynLOXSrQGhnYEgS4uoNE+P69XU3UwdlLCZHr8Y3hJfyuluzLM9JiHM9QgUe8jN3LiTkhNRMeNQjwaxsfo5JzdKgL5JLAM/55Sek422GaxSbL9zXuHXsjjER+jKwYppXMZ5NmNq3xWBJNgjyAGpkHNopSfiponiA/JaPYpgY+ct3ca0MEt8vhsE8PhTtxZqSekCLJzD4edqDl3RdQ0z9JlXa0Og19q1mIrssrv8ffh7h42Sgd2OtvCelOllmXPL/t0YmVEMBUsecwbV8RGtgFomZbSdz3yGXdLiEnPW/43RICDdz1fveEOAE89shHKygqfHYbkOYV7OKM4M0sf9CK+qFj4D3mx9S3s9FZwkahgsSqmslCNlWUXd4s4KDZ6PKKpbU7N6AwZzI/a4LiPYJtV5DY/kvx6J+0SmSCanMeEXaiIx56NfybTo0FqvJkd9NUZruBhQ8r0R/OSHDsEU7hvhET2WiGZg2ZpXzwgl+9VxFHW6DEhqstEVsPO4jrz3RJBtF4y+OYMl5oyKAf1m1exPHEEUBaF7fmQDF5iwrQsaRsY0c2qTi7L7SRjXaX1xSMAyDqeL+XUelLpNt2/0EU2fIJcxjAs1GlN5GXKd/BOKxgst49D6wwxEOVali3VF4+hf1K3fGSmSaL9M4GR6R1p5tL7VrqU6igKb763eeR4R4e5OPcYogeH97qGn4QLNuUDO2yF70PyPgfUkZ6IYiKVs+YNWirlXC1GOgd/wgCDWJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(8936002)(5660300002)(186003)(83380400001)(2906002)(86362001)(66556008)(38100700002)(66946007)(41300700001)(66476007)(4326008)(2616005)(36756003)(8676002)(6916009)(6512007)(316002)(6506007)(26005)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QamzajhkLneBN58MsxeF0AwpTB4kbsUmk1x932FbD8D3+ZZ14xGMIxG0C/pH?=
 =?us-ascii?Q?YyC0zZVA8AU3EKsLpFL1HGhqutUILlNNVWJQ5Duqej76I2S00x6yUeOLRlyh?=
 =?us-ascii?Q?YlnvhfbM8wAuaX5kekO4a9GTc8XddQ1VZdG+Vhvxnod6EY1TdzJYLE48xUg1?=
 =?us-ascii?Q?fwBJwXmPiGWhK8sHpHjKSwP8D3ttxlsN/xZSAIiMACJCIs8yMAozNJ1CRRed?=
 =?us-ascii?Q?rgoTzejTed8C4l61UH/+hbFDwv6+BYwZ4V8Z4cQsZ2vmp4c0PpIfmCLpIa2M?=
 =?us-ascii?Q?oq0wDCDtHOut4EJLhvMO6+LiTouka5KqB0iYqEPSYBp99OzahExqH0PxH/vF?=
 =?us-ascii?Q?SVxtoZ/RsdH9+qA0JeWYBwSLznQb25uv+o1cYjB75Pve+AkHv+RXzoiMLw7T?=
 =?us-ascii?Q?XOWKB74bocDYMun+odzO3G8pGcY/gsZl/pE0Xos2eSzGsv8hpNiNLt2CPn9e?=
 =?us-ascii?Q?ea5hYDgGUOfHdVoQf1cFJw9D3QN25Nsh1KQHGz2g2YQgSy9TwwS50RqU/8FV?=
 =?us-ascii?Q?eC+qm2ITjhKBtXOZMQK2ul1Kcv9ix2XKv0EBt9ePa6LtIxrqEIpFzH0v1vbv?=
 =?us-ascii?Q?e+IQZCosMQmpigfqiaG0ZPjjQqEhprQ9hO8jDXa9ebwHE6ttuH1AQ0EQ8s3B?=
 =?us-ascii?Q?4qcKC5rD8kX2XL3u3qu4HONzs0B/N4F4mXQ330aDsclQ5r3Ea7T2XHe/A62z?=
 =?us-ascii?Q?u0gJxj4KYRu6ROQv8Fv2W1JjuVth9rFGCQC7tLdTwISASj61gIDvm9Qyfwce?=
 =?us-ascii?Q?rk57QG2LhGkKTDn4iVXrxL5NRDcL1p0PlStiQRiOxiiDuyYYzIXb077k2IX7?=
 =?us-ascii?Q?yrxDWJW/1tI7wM5e5q7+kO6lmIL5wMOc7+/Pp7/OS3HUrlijPqcWNmGVBSqT?=
 =?us-ascii?Q?V8SBUyikaJ5Yuu9tnf6SvUAKSBqtS2XxmByIoouL9v6Xc3b7YMOg3rF1Lub4?=
 =?us-ascii?Q?qU4aTebFLDx/JHK5ABf0VA8qh6cGG6vvlHh3ftbULK7oiC/uCvGCCizDfIAm?=
 =?us-ascii?Q?z01oIDwBkYpv/5FMIDpBbsQrMujVqELo+EFHIQq6170jayKD+oni3wgHkcrz?=
 =?us-ascii?Q?YyXXdT4jX5+Dh/9iFHrOB295UVAfMCy9KQtLRfuoY2uHab4axc5/PyyXKmCk?=
 =?us-ascii?Q?1T9Gd1QUdQAJ2HQAcsqu8BTXeiev4vIUHYMo44tmYDKU2M5kXompr3YBB77F?=
 =?us-ascii?Q?/kBYe9UOKpZAmx8DNeadis5Hnc1LQBp5yf3e0lq7Apv/TnBU/HkILFF8g2yW?=
 =?us-ascii?Q?UQwsaFOZDzGmFw83ohKciWIDNbhRiXtkjIkWCQ2MxSae6pOZYjazwk6op1Jx?=
 =?us-ascii?Q?Zld/x9sMSl0dqkdM+lUwsaHk1DbHuhOGV17oeIiaZrDFg/TvgXYWPVleCIDf?=
 =?us-ascii?Q?4bf4nLgwOAXRYT6PLJNdaDqXPSga36VqHLnR07aC8LvA2p3d4h5xSzbhyy2p?=
 =?us-ascii?Q?ZSzyJtTUQ47nlo5XJ9PoGn9Wcg8l5pnxmDJogE+w55egZuZ3Hsw4A3rvEY/p?=
 =?us-ascii?Q?9lnWpWPSfhvTgMDRuc/tRGOkMVUX4eo3HKB6Q2LOXzqf90KjvwyNVsKeLFRM?=
 =?us-ascii?Q?BRLyrO5oyreO4E0gbDo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79f355a-8f70-4ea5-e496-08dab6a50c02
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:22:01.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKNDhZmQhMlZBzsEsDgpH4FCza58v5tOIR2sgMyey7U4JugceQJIT1TZJCzEJVDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 05:21:36PM +0300, Dan Carpenter wrote:
> tree:   https://github.com/jgunthorpe/linux vfio_iommufd
> head:   a249441ba6fd9d658f4a1b568453e3a742d12686
> commit: e44299750e287f3d64d207a5af7abb021634a31b [9/11] vfio: Make vfio_container optionally compiled
> config: openrisc-randconfig-m041-20221024
> compiler: or1k-linux-gcc (GCC) 12.1.0

Dan! Thank you for looking at this branch, I'm going to be getting it
in linux-next very soon, so I will fix whatever your tools will spot!
Let me know


> New smatch warnings:
> drivers/vfio/vfio_main.c:1690 vfio_file_enforced_coherent() warn: assigning (-95) to unsigned variable 'ret'
> 
> Old smatch warnings:
> drivers/vfio/vfio_main.c:1907 vfio_pin_pages() warn: impossible condition '(iova > (~0)) => (0-u32max > u32max)'
> drivers/vfio/vfio_main.c:1974 vfio_dma_rw() warn: impossible condition '(iova > (~0)) => (0-u32max > u32max)'
> 
> vim +/ret +1690 drivers/vfio/vfio_main.c
> 
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1671  /**
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1672   * vfio_file_enforced_coherent - True if the DMA associated with the VFIO file
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1673   *        is always CPU cache coherent
> 
> This comment sort of feels like returning false on error is the correct
> thing but in the rest of the code it seems like returning true on error
> is correct.

Oddly, true is the correct result. "false" means you have proven you
are worthy and that cannot happen on error cases.

> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1674   * @file: VFIO group file
> c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1675   *
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1676   * Enforced coherency means that the IOMMU ignores things like the PCIe no-snoop
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1677   * bit in DMA transactions. A return of false indicates that the user has
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1678   * rights to access additional instructions such as wbinvd on x86.
> c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1679   */
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1680  bool vfio_file_enforced_coherent(struct file *file)
> c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1681  {
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1682  	struct vfio_group *group = file->private_data;
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1683  	bool ret;
> c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1684  
> b1b8132a651cf6 drivers/vfio/vfio_main.c Alex Williamson 2022-10-07  1685  	if (!vfio_file_is_group(file))
> a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1686  		return true;
> c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1687  
> c82e81ab256955 drivers/vfio/vfio_main.c Jason Gunthorpe 2022-09-29  1688  	mutex_lock(&group->group_lock);
> e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1689  	if (group->container) {
> 1408640d578887 drivers/vfio/vfio_main.c Jason Gunthorpe 2022-09-22 @1690  		ret = vfio_container_ioctl_check_extension(group->container,
> e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1691  							   VFIO_DMA_CC_IOMMU);
> 
> But this returns true if vfio_container_ioctl_check_extension() returns
> a negative error code.  (I haven't looked at the git branch and I
> suspect it's different from linux-next)

Yes, I should not take this shortcut, we would be better to explicitly
return false on error return.

But good news, I just deleted this code, so all fixed :)

Jason
