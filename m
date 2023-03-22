Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275446C41F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCVFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCVFQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:16:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825F51F92
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWWWUZqUSgHFTpGD+RlH8Yf3ThEPouZtdxCjYNSXiUrTI5wjWj3svuw6KEFAiT72dIxP+MBN3eYkWo9SnozllJYy6niX9ly9mJl26bnFsNRjtvL1dTMotFbojJTMNtPKpk93Lwkl448stAcqSXioLJRFPIo8yXSjcfr2aY5sNJ+aQanBlqQuGw+Q4ocFd9LuwBYMA+qUSfi2//SmpaFknkwcpaPF11l6nSA2QonKVch5hSX1MXZiIwRCfgMoUvFjNv0yISu70q5IGE8uHyNFfULFgRXWXZbxMz8pn7bdsBdJatJ1M4WQRZw677vMWBvMJl3l0pO4MyHV5yLYw1nydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEW7ofhRyooaA3NA0a5GceEEO0qTe08xtALupVaz3yo=;
 b=lb6x1eRdkvhq9iT+LOQHDtVcaddHvj44TcKVIjwlNuOlBtYwBpAi6mWYsiXma2/gPcYv5DDBaXEbXeavu89SONeAO1CCxACm+3yceJVfUO6hmE5DstSsFZBVo/kyq293XPVnZQt6FAx37rFJuJwpJthTnuMXd5aKGKPY4RBOPIAIE94AJxrd1RQFg80+Jq3JYadiL8TThE0UICvP81d6EzHrwsdZvuabEn7Ku/mAHE+jIpLhIrZjwi0wmk9oXbth2Hr+JVCcuyDzcyv3RSzlWKm7NjKcXey13uuo+7+uLbFvaezlUjSQNKKaS/wa0PrVQp3axZcn+ZpF+Nbloo+6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEW7ofhRyooaA3NA0a5GceEEO0qTe08xtALupVaz3yo=;
 b=GtQc0IoujzYB87NT3A5cqZIWLoVpcmvoCicFXXwZT1qynMhBTQ/J/lcTGb7fBAytxy5ScglMzKLwgoWirIw1uB5CNs5kL5rByxRgYDyPkEAqE2lniJdQVlKxjLOjD+FHnUwwRGrozugvEgjfmQHKD8PmqwIVA/mALy8CVxNkwb+naaA0t1PKEW85y5i7PMMGb6AoMNb1QhHsPBFH5MqYkDFOXI0pwpK4PnBXubImjqP/7ntHy/YZZvWnDSFAZK/D24TuEha1j7zAzT0Rxwwa8GJxl+7Lp6wlW2kUO3pvQgY3dD1ln2A0xazkgmO1fU0p9AUx5+cf+wsS3iUOHOW4yw==
Received: from BN9PR03CA0799.namprd03.prod.outlook.com (2603:10b6:408:13f::24)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:57 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::a0) by BN9PR03CA0799.outlook.office365.com
 (2603:10b6:408:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 05:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 05:14:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 21 Mar 2023
 22:14:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 21 Mar
 2023 22:14:46 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Tue, 21 Mar 2023 22:14:45 -0700
Date:   Tue, 21 Mar 2023 22:14:44 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBqOxNuHWPuhNy5b@Asurada-Nvidia>
References: <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
 <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
 <ZBiDcYwxL7eV1EmQ@nvidia.com>
 <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
 <ZBig0fN3l7LsUlQg@nvidia.com>
 <ZBjGPI29BE/puciv@Asurada-Nvidia>
 <ZBjauQlH3TYbZQ7P@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBjauQlH3TYbZQ7P@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: cca81a6e-0db7-449a-df2e-08db2a946109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47LXp5wegNDvbRBu83T5P7FxRahpW+C158uQYAw1UiisZqvfvZNAV9eeEiS1ie4d7htdC+kgSNPndLYjB2EjeEdIx0Zf0wIK+FvIXxDwVl/LIMyLdbq6RyzGGACuR6u6k+8tWAXBlK7t1kLHY6DMKo2Tu5SGNb/GqoVytMe1Ko0W7xOVCjEuSn5gS/pya4xRl1IiqP4NTaHK2eAGeE9nFe1S7QZ9PACSeRirJb4LEZ5h06WdVC0Bd2HDc+J0RY9yUdWUvjgiDODBCuJ/5YR/MZ2Fst+E07jM2Yy5dEM5/hf9KP9d3sH63QPgKJxPbUCGA3r2cn/aIamwxmqvRIRHiTIHO1b3t9Uddey7CQ0EQuNeGWdIq2MzqPMvF0c5PXQAC3j0qGBAXxI+uuz7VT1E8Rd8SnV8aDgAEc937N9LRUKtQcZdo8jYD53s5KhAiT8qFJmu60mO9IzgVZQ8XE3mCv/68fjltFr6/D8Js1jRi1tG304IfN+j4HKmtOjcOM2pxzyBY5i1yc4KygU7kY2sqfmEdP+MSVcfPi3CGbHq19LVUF49CDvHQ7Q+k7/a6HmrHpZUqr5u0XQeUfoPbg99MD5TP3/4mUL/j6xYFG5YMYpQ57zJ6jZksbw+47iL9mosHHsG9uFulzvoicDJ6HAkMoIya1ErP0XGVRE0OwL+PfG+wDH5ih1RRLFSWcG4UQ5YiFb6VZrf6rSE0bI8sTkcI6F4sVhnoWILO8RflxRNoZj+t+4/70ulFhhuvYVKErNH
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(47076005)(82740400003)(7636003)(186003)(41300700001)(6862004)(40480700001)(336012)(426003)(9686003)(2906002)(478600001)(55016003)(7416002)(8936002)(26005)(356005)(5660300002)(54906003)(6636002)(36860700001)(70206006)(316002)(70586007)(82310400005)(8676002)(83380400001)(86362001)(4326008)(40460700003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:57.2433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca81a6e-0db7-449a-df2e-08db2a946109
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:14:17PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 20, 2023 at 01:46:52PM -0700, Nicolin Chen wrote:
> > On Mon, Mar 20, 2023 at 03:07:13PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Mar 20, 2023 at 09:35:20AM -0700, Nicolin Chen wrote:
> > > 
> > > > > You need to know what devices the vSID is targetting ang issues
> > > > > invalidations only for those devices.
> > > > 
> > > > I agree with that, yet cannot think of a solution to achieve
> > > > that out of vSID. QEMU code by means of emulating a physical
> > > > SMMU only reads the commands from the queue, without knowing
> > > > which device (vSID) actually sent these commands.
> > > 
> > > Huh?
> > > 
> > > CMD_ATC_INV has the SID
> > > 
> > > Other commands have the ASID.
> > > 
> > > You never need to cross an ASID to a SID or vice versa.
> > > 
> > > If the guest is aware of ATS it will issue CMD_ATC_INV with vSIDs, and
> > > the hypervisor just needs to convert vSID to pSID.
> > > 
> > > Otherwise vSID doesn't matter because it isn't used in the invalidation
> > > API and you are just handling ASIDs that only need the VM_ID scope
> > > applied.
> > 
> > Yea, I was thinking of your point (at the top) how we could
> > ensure if an invalidation is targeting a correct vSID. So,
> > that narrative was only about CMD_ATC_INV...
> > 
> > Actually, we don't forward CMD_ATC_INV in QEMU. In another
> > thread, Kevin also remarked whether we need to support that
> > in the host or not. And I plan to drop CMD_ATC_INV from the
> > list of cache_invalidate_user(), following his comments and
> > the QEMU situation. Our uAPI, either forwarding the commands
> > or a package of queue info, should be able to cover this in
> > the future whenever we think it's required.
> 
> Something has to generate CMD_ATC_INV.
>
> How do you plan to generate this from the hypervisor based on ASID
> invalidations?
>
> The hypervisor doesn't know what ASIDs are connected to what SIDs to
> generate the ATC?
> 
> Intel is different, they know what devices the vDID is connected to,
> so when they get a vDID invalidation they can elaborate it into a ATC
> invalidation. ARM doesn't have that information.

I see. Perhaps vSMMU still needs to forward CMD_ATC_INV. And,
as you suggested, it should go through a vSID sanity check by
the host handler. We can find the corresponding pSID to check
if the device is associated with the iommu_domain?

Thanks
Nic

