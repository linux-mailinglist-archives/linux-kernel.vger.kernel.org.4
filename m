Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DC68607B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBAHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBAHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:20:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23E2CFC7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:20:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8NzBQxawa7G07CywYw/I4cj+DfKmsUlGJZFOX0NDBsgLvTAq4wvabPvrSW1/dF0cFIAIXZFQE59t+suNZXPOsQle5IBusdaPCd7L8GIHRwwaPdz1vJowD3RusA5VH2rkR6D7P80yDEbfVn8maLCRI2Yyg2TX6x2JqJBLbdbzATElDCnb7v07kzY64X84W0DI5fTfwJ4ObB0OM3/Fxf8wQImoG+puSM7HkynPtIrw1xlyWC4MIYI7p2HObYAwB7XDNIYrxs6+WLiELrTGtJWPiRuZ7iOpXIp4BClRpO/o9ds03G83b4xYYtYQkGcDYIN1c/5REp4r5TXEjt6F9Bmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov97QLIS7pHdR+RHRb/8qTm/TBpV/VVNLpzB2btuaUE=;
 b=JX4JPDgVcnDhIEszVkd9q/2HbkYUJCM9S+6gfFK4r2wTCqvhTyfdwrTH9DsG/dW+1FOZWblNjYy40oHXIvb1xV67Njpt+PdnWa5n5ZDRAOjzqNb6Wz8JGvYCNRD3NWKZU4HhU0r9/fF4ve2g3QVCwNCEH3Q1tDLOmsjGFW+LK/ft7quMaZidtokUhl2d3xBSH/NNa8wBrl+32OVAhxMMkYuqgD0AxQEwSGPWfXNWUBNyJJ15hWyT4xZGl2nQKxhEx8m/qt43LCugINQBUgszuAQuTczPM1pJrL1WAPXSVN/CKUUrOs1COBqV0PeJY43wk5AlvjozHgbN/h0MmG29Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov97QLIS7pHdR+RHRb/8qTm/TBpV/VVNLpzB2btuaUE=;
 b=IUV+6gFRq6vqfge1W+2U+yOij8+XZvWGCqjEzSJOgXJvdfeluEUN3g1hxHBo332IcLJ8nj0w4RMCDEPblVXA01yC5AbtrPzZe6JThGFTEZREx9EgUJkR6OoPTDsFEHNs6DSgz1r20FBCfe6kv7lXB1wgK9DPS8w57ZrDe3cPBRs69i8npWIRV7G88vxjob1bbSjfa5Y6irxt+r8KAqpWbiM+qiLFa/uvrz2Mnm7WuRl2nEppETWJMabU7cXhTwkQeHRpPtarbGnXVEQ0hElL/ddixSaJ3gRScTgEFRzpWPPHkN/MNhxtIXHcd6y38wTVWNEtdzE2NQ1MStLuJc4YLA==
Received: from BN8PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:70::16)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 07:20:38 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::ff) by BN8PR04CA0003.outlook.office365.com
 (2603:10b6:408:70::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 07:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24 via Frontend Transport; Wed, 1 Feb 2023 07:20:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:20:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:20:20 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 23:20:20 -0800
Date:   Tue, 31 Jan 2023 23:20:19 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Message-ID: <Y9oSs0TJ/KZKWCw1@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
 <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
 <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
 <df494d34-d804-e743-023f-d1effc881628@linux.intel.com>
 <BN9PR11MB52766EAE924EB5DC320FC1488CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766EAE924EB5DC320FC1488CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 222b7f11-ec9b-4343-eea4-08db0424d0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ylrOSENg8R+0+CZnP67LFCvVSjZr5/zulR3Y5uWzfKsllrLWAlEv0QfNJFkMi3RwTMdSgY7D1Nq3NFOa1yLByZdznp8uuhzoZaWkRVxYhu1WbxIIKe5Z9IlYjMcUZbwHVh4+6c0EvbZA7FUwm4BjsyKPrcuI1ueds4FuYCV2ylvnQoLP7biFJosgr/q5krd66aB0d7G5/eaApz3oAZaUXpffnHN4dOPUSnjn/SyC7zlTnUFmKPyBW3Ec56ZZdcaxdDesZM9Tve2rzQ+Br/rb4jheSjZVqQF1Ec7yG9Vr6LMOhQa8d1nn07ChTC0y73MH8EnyCU5Bjxl4Nd7Ewt/xdhexseysEo1pdOXomLZIiN7h3RxPpp/kPdMCGsX4Hbhithb8dEQTp/ieojGunHfVItKFeNxrQdQKT+21FajfKFK44boFJxhgxplEL5+B/ZfevkhXYHBcI8WUKuRNYjDtY9viNgI6xDtxi6CtSA0H+/5ufQdAABqEQRKy51+TM86Pi5YTW9uP9yGeAdb+g5YbEnEdewdFXPs6hYJZcbeE+j3m4rmF0P4kalQWEtfxs1J8Davp0QiL4ryJ59eZTKmZ0yg3w8UmtcV1MojUYfRNEZUSXVhsVQBlzMRHuUW4fshVb6C+lfoh5uerGmSDhNI0xK+cfVALkrBBge5pBbqalTodSK/TNHIhGz/lg0nV8HaqQiQ2r3FmJovgQgKuBKSC+5yoz7fJqTgpAG9gloIPEFcfgbALK0/Myz6L9tTsz/EqFRfj7B11NrGMESdjeWU1FNnksGh0qMyKdlHPZ8Wk/E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(4326008)(316002)(54906003)(70206006)(8676002)(41300700001)(6916009)(70586007)(8936002)(5660300002)(36860700001)(82740400003)(86362001)(7636003)(356005)(2906002)(966005)(53546011)(186003)(26005)(9686003)(33716001)(336012)(40480700001)(55016003)(47076005)(40460700003)(478600001)(83380400001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:20:36.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 222b7f11-ec9b-4343-eea4-08db0424d0cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 06:59:21AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, February 1, 2023 2:49 PM
> >
> > On 2023/2/1 11:07, Tian, Kevin wrote:
> > >> From: Nicolin Chen <nicolinc@nvidia.com>
> > >> Sent: Monday, January 30, 2023 6:22 PM
> > >>
> > >> On Sun, Jan 29, 2023 at 02:38:55AM -0800, Nicolin Chen wrote:
> > >>
> > >>>>> @@ -385,10 +372,8 @@ void iommufd_device_detach(struct
> > >>>>> iommufd_device *idev)
> > >>>>>        struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> > >>>>>
> > >>>>>        mutex_lock(&hwpt->ioas->mutex);
> > >>>>> -     mutex_lock(&hwpt->devices_lock);
> > >>>>>        refcount_dec(hwpt->devices_users);
> > >>>>> -     list_del(&idev->devices_item);
> > >>>>> -     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > >>>>> +     if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
> > >>>>>                if (refcount_read(hwpt->devices_users) == 1) {
> > >>>>>                        iopt_table_remove_domain(&hwpt->ioas->iopt,
> > >>>>>                                                 hwpt->domain);
> > >>>>> @@ -397,7 +382,6 @@ void iommufd_device_detach(struct
> > >> iommufd_device
> > >>>>> *idev)
> > >>>>>                iommu_detach_group(hwpt->domain, idev->group);
> > >>>>>        }
> > >>>>
> > >>>> emmm how do we track last device detach in a group? Here the first
> > >>>> device detach already leads to group detach...
> > >>>
> > >>> Oh no. That's a bug. Thanks for catching it.
> > >>>
> > >>> We need an additional refcount somewhere to track the number of
> > >>> attached devices in the iommu_group.
> > >>
> > >> Wondering if we can let iommu_attach/detach_device handle this:
> > >>
> > >
> > > that is the desired way to fully remove group awareness in iommufd.
> > >
> > > but iirc there were some concerns on changing their semantics. But
> > > I don't remember the detail now. Jason might know. also +Baolu/Robin.
> > >
> > > otherwise as long as the group attach/detach continues to be used
> > > then identifying last device in the group always needs some hack
> > > within iommufd itself.
> >
> > I have tried to solve this problem.
> >
> > https://lore.kernel.org/linux-iommu/20220106022053.2406748-1-
> > baolu.lu@linux.intel.com/
> >
> > I may need to review the original discussion to see if I can update a
> > new version.
> >
> 
> emm looks there are quite some discussions to catch up.
> 
> anyway assuming this will happen, Nicolin do we still want this
> preparatory series for coming nesting support?
>
> iiuc the main motivation was on the complexity of s2 attaching
> but with your discussion with Jason looks it's solvable. Then if this
> group hack can be separated from the nesting work it avoids
> unnecessary dependency in-between.

The device list is going to overcomplicate either the nesting
series or the replace series. And Jason asked me to send the
replace series prior to our nesting series.

Hoping that we can eliminate the dependencies between those two
series, I took these patches out and sent separately to clean
up a way. Yet, I was naive by thinking that I could do it with
a smaller pathset.

So, assuming we drop this series and move the first two patches
back to the nesting series or the replace series, one of them
would end up doing something ugly:

	if (cur_hwpt != hwpt)
		mutex_lock(&cur_hwpt->device_lock);
	mutex_lock(&hwpt->device_lock);
	...
	mutex_unlock(&hwpt->device_lock);
	if (cur_hwpt != hwpt)
		mutex_unlock(&cur_hwpt->device_lock);

So, perhaps we should discuss about which way we want to choose.

Btw, Baolu's version has a similar patch as mine changing the
iommu_attach/detach_device(), yet also touches _group(). Could
we bisect that series into _device() first and _group() later?
Given that we only need a device-centric API at this moment...

Thanks
Nic
