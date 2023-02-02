Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCE68765C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBBH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBBH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:28:17 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF53F2A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:28:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipnGckK7wShcAorrvjhhJ+FcaD74FLasoUKRIVgWckNxcAl7VXmo8Mi3mml6cR1j9eBvYIyx/C/K7YR8FK9cEb3Gbzzqzvg1QaGhj0ahXRRVYO9ClpSR85eOp5zG01rR/T1f1QWaHbGpGDeq6p6QNZ9B8HNY/8Txfv76GbE8dhI0pZFFcIOTIvS5/zQfK63gsNSf6Li7psdhractTKoXQbD0JxcnkWIe08ERaIPooekNkFaNe+OEgYRMPXL4+1h3+cgi6HGpxMzilCXsYYMVvxbwJ1DnRp3a8wZhWNbO1i8G7DfbuWERo9YZtOnExjIC8LuMyFXQxiF17Eqi3c2EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSx87uuFJZ4ISGevB8rVmAS2QW2Smi1RVMFylHUJLJs=;
 b=ONaQ7UUZwzCUCQldpJ0z88hHcWKOgAEFhk14fKx2uxXyvXJ77gQ9L51KSn0qInIBs8D8krQiwuKFTPuXcWw6zq95puSGkVMkad4meAtGcu1vT++MbV1T0brh/SbA/ZIVBPYUx0haieaObOhHdg6oXkJdvPm2Y64CUaqZh9ZVoXPXHMFESIRyVIAUqiLnTxDcoFheiQRFUKMz+29ixxZfilY8qDMbaJtFovlO8wl2T6jsK1GttoezpX3A8kG5JaWmhC5YMKU4y2SNhoPNnkhEAbwY/Vcr++2jSYc3tU9SHLxzSXOVvqObF80Ih1CJNZfa2h1mg8y0gruZzd9nsrY11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSx87uuFJZ4ISGevB8rVmAS2QW2Smi1RVMFylHUJLJs=;
 b=g4W2MgPkL8cl5fgQ9ZYqWNSETNonBbhq0D1YLwnj0za6mDg50fNfgtwMBXzsNWVCxr2HSDk7ED3IwroyIcVvHx0k0PeFJkxlw3BKniDwK//EwHS/en+EdOk0VF+XWqcH7LSRtDHbRYeE59sXWQBBP5xKduuth2honV135gfaLbHuGcizoZOSmyDxm61fszjZSmhWypjcjH4tf5xaSzCUz6YWUbmX27t0sAkhI//6LUA47TDOOPuPWJj5PHELXEOdKTjvfRUTag0XO8Iq9ioDsVwKvBBnhVd7mLo52E1huDnjMHeiOO2fZ/dQ1bsmJTFGMmSkBSsTgDqDLyGpYt2MSw==
Received: from MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 07:28:13 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::96) by MW4PR04CA0159.outlook.office365.com
 (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 07:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 07:28:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:28:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 23:28:07 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:28:07 -0800
Date:   Wed, 1 Feb 2023 23:28:05 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9tmBW/wnZJ0JyBk@Asurada-Nvidia>
References: <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
 <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
 <Y9qxdinaS6anoWhH@nvidia.com>
 <Y9q8llC0JVokHLf7@Asurada-Nvidia>
 <Y9rE6L8Nr0xShiKy@nvidia.com>
 <Y9rW01eROepZuMt3@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9rW01eROepZuMt3@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 35fcf490-8fdd-47a1-06f4-08db04ef0b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1EU1HqTGKB8LOlyn8CT5v1qOAcP71MYDVogVD6ZDgKjti/XtY2OJIyXSr25+OEo1ymqaWmmDngzvaiTy1PmPfouM4hBis4GpHk4wCwWbCTbJfy3whFAmEqHTOKBWJBYux3NgBJreSK2opYZxPWhuuZZImwBLVLWU3s3LXWz6TMXbncSToadPxWtDv+xH1wFf+yl8PzUYt+EDbtRUfXQcCD/41O0ihdu50fjVSVK8swBG+L9VMcG9/Kuf16zoYCARTrZHgGEo1piphtRsL+htGgxo/9qb78ZFsJp+akMv3Wttj1frgwiePvBh9d9Yj/FknxGt3CzWASz1TEbf6IxZYx/+kHglHcMtHNqMz5DfZymH5Vq1mGFAz2BzxFTvj1ckBjNjEqeNTImRXC2F+NgZr9vLHeLHoVuzZ1plLWDtF8J6Zf4RLEurp+FCie5uL6dJKYaVyJ1qnSFMUlRZOfPiSve8bPfxunHOQDB10D5WhvLDcCCJoVUUxj86+/1ghl0mNwqGCnhx+gk2zy0W/WfT+r2gA8pBtFKqnCl7Xz9esALncugP7F7IMw6Ey0OIVoDGh3jmKHoP+8iFHJFeE6BgvqBn+s3WhJLROug3dVFQ7QTzUJ6jEq402a8D3j9hNuYxiKjFcv9ZQ2OPhpSkiPXB5b3tFvbSg5+aTJfm6j3hoGpZ4psZcV3V2KVTJiIKEgdNYYtiNBYpWdlwtEuoUBBwQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(316002)(40480700001)(82740400003)(6636002)(54906003)(70586007)(8676002)(41300700001)(7636003)(478600001)(70206006)(4326008)(36860700001)(9686003)(26005)(186003)(40460700003)(47076005)(8936002)(336012)(55016003)(426003)(83380400001)(82310400005)(33716001)(6862004)(2906002)(5660300002)(86362001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:28:13.6722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fcf490-8fdd-47a1-06f4-08db04ef0b61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:18:08PM -0800, Nicolin Chen wrote:
> On Wed, Feb 01, 2023 at 04:00:40PM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 01, 2023 at 11:25:10AM -0800, Nicolin Chen wrote:
> > 
> > > The "finalise" is one of the very first lines of the attach_dev()
> > > callback function in SMMU driver, though it might still undesirably
> > > fail the replace().
> > 
> > It won't get that far.
> > 
> > Remember how this all works - only autodomains have the special path
> > that allocates a domain, attaches the empty domain, and then populates
> > it with the ioas. We made this special path specifically to accomodate
> > the current ARM drivers, otherwise they wouldn't work at all.
> 
> Yes.
> 
> > replace can't do this - replace must always start out with a
> > pre-existing hwpt that was allocated with a dedicated hwpt allocation
> > ioctl.
> > 
> > Wwhen the hwpt was allocated it must be linked to the IOAS at that
> > time, because we definately don't do defered IOAS linkage.
> >
> > So on ARM when you create an unfinalizes iommu_domain it cannot be
> > added to the IOAS (because it has an empty aperture) and creation will
> > fail, or worse, it will get added to an empty IOAS and make the IOAS
> > permanently unusable.
> 
> IIUIC, user space might add some IOVA mappings to the hwpt/iopt,
> before doing a replace(). If we do a deferred IOAS linkage to
> this hwpt/iopt, it will cause a problem because we are adding
> the reserved region for the MSI window later than IOMMU_IOAS_MAP
> calls. Thus, "we definately don't do defered IOAS linkage".
> 
> With this justification, I think I should include my patch of
> moving iopt_table_add/remove_domain(), in the replace series.

I just posted the replace series. But I found that the base
line (without the nesting series) allocates iommu_domains
always with the ->domain_alloc() op. So, we cannot actually
move the iopt_table_add_domain() in the replace series, as I
intended to.

Yet, a great news is that our nesting series replaces the
domain_alloc() op entirely with ->domain_alloc_user() for all
the iommu_domain allocations, including for auto_domains. So,
we can completely move iopt_table_add_domain() to the hwpt
allocation function. And we don't really need a big change
in the SMMU driver nor Robin's patch that passes in dev ptr
to domain_alloc() op. And even this device_users refcount in
this patch is no longer needed. It also simplifies the shared
device locking situation, if I am not missing anything.

So, in short, we'll have to wait for ->domain_alloc_user()
patch (in the nesting series) to unblock the problem that we
discussed above regarding the iopt_table_add_domain().

Thanks
Nic
