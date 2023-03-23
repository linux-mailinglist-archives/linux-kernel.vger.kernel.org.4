Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2183F6C700B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCWSOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:14:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A763C3E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UACqp+l5dkEuchGoiroGmDOIeZkfIN190lbB6yu+UmZ+igGecFkxe4awZ0D+5OR/uSnHp2BORWnaRsUIFWyzKiSZjDozcQ8ucgxQtsRiVEEp6aTV4JK8zXOtXbZJCMg3P2ZdvtOOmp1l7/fjXlq/F/j65OkjKVTQmUOCxbrutSHu/VZtTCuo59QBULN+Blc628QAA2BYeZ5iZhfCNqMbl01AOrEAVE4aEMIEzjT3HpTre20LWKH5YTf6PZjeC62mrEyc5dmsZ89bMhU5AmxuvYEGf/igcUtUTiQr14937zFGhkUeDVl1/05kg3oORBfX1RFLq1ugIaDompbFyNbbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcZ2gXhpstQd46HAtCUOYcG3ikahhpzSYtvIituh0jg=;
 b=DEV8l49VHgNVFAYtVbyeTuu4phN6j6cO9YHc7xg9ih0k6Ggn2/q6TJDXKgR82OB92zRwT0VALlM5rehxrzpNw+wro60wkUCn5laDa8lccccBKp2sqsg7pMiadd2mbqESX/QGApZoCMbsFqztoh2o9ntYvRn3ZuQpHSKzI+S2DcN1M9wnFJOH9q1gdtJi35siCYQ9CiCFC7wd09QnIqX/99ARVWuQXxOYcrqWlChbZmx7FXae+0OlvetI2yAjOH2D+Gmdcmn+GHzLDKJbIn+mNkMTb8l3xGyYw3oRcJV5C/txiHW/UxRnTZBDruLYGDfhIW9VCZfs/ax3QwOdKlu+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcZ2gXhpstQd46HAtCUOYcG3ikahhpzSYtvIituh0jg=;
 b=JAzpzyOb5BGtdLFBcnXYDe3J0ZYP/ShOs1ab2URXzc2XJSda5eDNAIE0dAcdC4onimSehe4xHvGdreZKpHXHFoKsamJxYtKyxYjCtA7/h1ACqyac4Odub3kyBmb5wt+Y/k4s0lJdA3kqgjz2MIBHmepshfjpzq7yaiWsFjG5wodgScPw5zPzc6OpXvRtOH2x7cGPhhMO/g7km42vwjYfj0GVT1s3LMJIBgLfr+7k6vLEKak3SqAn4kmQOITr/HKcTZ51BNd0Kwn2v5TFunodcs9Y8XAljVfCLUNFuhI9hAJtZYZt1BR2lGu+OVP9eWyMZSqxCm1Mf5woROI150dXsw==
Received: from MN2PR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:236::10)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 18:14:07 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::bd) by MN2PR05CA0041.outlook.office365.com
 (2603:10b6:208:236::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.17 via Frontend
 Transport; Thu, 23 Mar 2023 18:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 18:14:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 11:13:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 11:13:50 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 11:13:49 -0700
Date:   Thu, 23 Mar 2023 11:13:48 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZByW3CkGpt1W59XO@Asurada-Nvidia>
References: <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
 <ZBs6xlqMGYhLbI27@nvidia.com>
 <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
 <ZBtZ7F3NsxngcKIq@nvidia.com>
 <ZBtoj3deE2Y6k9lq@Asurada-Nvidia>
 <ZBxDM9JJSbx7yB8e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBxDM9JJSbx7yB8e@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f61773-1be7-4808-f768-08db2bca641f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KM+D678HSjz6KM7Pu7YAFDPP8TyLnrYC4zXB4P8UHDMAsCbHLcuVO3nJCLaXjxJI7xq2ZAVCMa0lEPGe8etdNup0HXcnagA4zp8DT4iC37Fdh79okKE14T4lOkG7zdiTBOYiTULF/35xhHmL3JZgwc8JmWZ7kGq4UBs09ViQCZzPM+75ntjiGA8dZRpfoDv0Dgk14L9lD/k/n6Nu53YKEq80pscf03L/Gv9LVSuUB7GVqZxQRSxaKUMEngwhKlTbPq73tcgsJgCMw2hjgj8pDgMXO7qAAqFwKkzjfTc8o1HCOIHU7SajRmJUj3w03ch50zumE9yV4uI+hcIf2X8DGlyH91j44E19BFWJtVzei+Yq1V/lmi2zRwMZkDrW/yKzaKlW5Z8gHKXq+Bim3xoAr/aznA+x1CHPJhVmetdNIW85qShH8teGeMxHoZECGVOD/lQ1sPGVSYzsTgEbo3ZcHzelIK7vXMOKXsXIha2y7ht6J03Gix3Y7hqKxL9hrTezBQy5F1Iaa7DJYMQBmdNVYnqhKGK1NqmNbP46h+fVcPlXUEEd2/cW0r6Gzlu36iglSvATYLaGOrZpkQ8jYM+DQq/6ccqB9rXTh7GX1Nvi+MwG5zCWznKGDv6vUdRe2a8dCk7KK4iFi6Te8HFV4ofapbGSbkafJtNv9QpifgOmxMlgu1+IV59FYiS8KBF9y6l/ex1GHmpIIVNV68/jjwau2DIiNoKzVGXWF7Rx2arRkG3pcX8Q/nh5grunn+PM40ZU
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(6862004)(86362001)(316002)(8676002)(4326008)(70586007)(70206006)(6636002)(54906003)(41300700001)(478600001)(7416002)(356005)(2906002)(82310400005)(7636003)(36860700001)(26005)(82740400003)(33716001)(186003)(9686003)(40460700003)(336012)(40480700001)(83380400001)(47076005)(426003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 18:14:06.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f61773-1be7-4808-f768-08db2bca641f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:16:51AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 01:43:59PM -0700, Nicolin Chen wrote:
> 
> > > So I think for ARM we want to reflect the physical SMMU instances into
> > > vSMMU instances and that feels best done by having a unique S2
> > > iommu_domain for each SMMU instance. Then we know that an invalidation
> > > for a SMMU instance is delivered to that S2's singular CMDQ and things
> > > like vCMDQ become possible.
> > 
> > In that environment, do we still need a VMID unification?
> 
> If each S2 is per-smmu-instance then the VMID can be local to the SMMU
> instance

It sounds like related to the multi-SMMU instance too? Anyway,
it's good to think we that have a way out from requiring this
VMID unification.

> > > > Our approach of setting up a stage-2 mapping in QEMU is to
> > > > map the entire guest memory. I don't see a point in having
> > > > a separate S2 domain, even if there are multiple instances?
> > > 
> > > And then this is the drawback, we don't really want to have duplicated
> > > S2 page tables in the system for every stage 2.
> > > 
> > > Maybe we have made a mistake by allowing the S2 to be an unmanaged
> > > domain. Perhaps we should create the S2 out of an unmanaged domain
> > > like the S1.
> > > 
> > > Then the rules could be
> > >  - Unmanaged domain can be used with every smmu instance, only one
> > >    copy of the page table. The ASID in the iommu_domain is
> > >    kernel-global
> > >  - S2 domain is a child of a shared unmanaged domain. It can be used
> > >    only with the SMMU it is associated with, it has a per-SMMU VM ID
> > >  - S1 domain is a child of a S2 domain, it can be used only with the
> > >    SMMU it's S2 is associated with, just because
> > 
> > The actual S2 pagetable has to stay at the unmanaged domain
> > for IOAS_MAP, while we maintain an s2_cfg data structure in
> > the shadow S2 domain per SMMU instance that has its own VMID
> > but a shared S2 page table pointer?
> 
> Yes
> 
> > Hmm... Feels very complicated to me. How does that help?
> 
> It de-duplicates the page table across multiple SMMU instances.

Oh. So that the s2_cfg data structures can have a shared S2
IOPT while having different VMIDs. This would be a big rework.
It changes the two-domain design for nesting. Should we do
this at a later stage when supporting multi-SMMU instance or
now? And I am not sure Intel would need this...

> > > So, I have been exploring a different approach by creating an
> > > > internal multiplication inside VCMDQ...
> > > 
> > > How can that work?
> > > 
> > > You'd have to have the guest VM to know to replicate to different
> > > vCMDQ's? Which isn't the standard SMMU programming model anymore..
> > 
> > VCMDQ has multiple VINTFs (Virtual Interfaces) that's supposed
> > to be used by the host to expose to multiple VMs.
> > 
> > In a multi-SMMU environment, every single SMMU+VCMDQ instance
> > would have one VINTF only that contains one or more VCMDQs. In
> > this case, passthrough devices behind different physical SMMU
> > instances are straightforwardly attached to different vSMMUs.
> 
> Yes, this is the obvious simple impementation
> 
> > However, if we can't have multiple vSMMU instances, the guest
> > VM (its HW) would enable multiple VINTFs corresponding to the
> > number of physical SMMU/VCMDQ instances, for devices to attach
> > accordingly. That means I need to figure out a way to pin the
> > devices onto those VINTFs, by somehow passing their physical
> > SMMU IDs. 
> 
> And a way to request the correctly bound vCMDQ from the guest as well.
> Sounds really messsy, I'd think multi-smmu is the much cleaner choice

Yes. I agree, we would need the entire QEMU community to give
consent to change that though.

Thanks!
Nicolin
