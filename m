Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC29686D59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBARqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBARqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:46:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945261D48
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLKmJFG4USz3EY0Ql3ja6KWpkyrfN6eXpF71cI4EzSzDxiHv22DWby3RVdwM5UvcQxK5I4uPt8KX78AlK9oekx9204r7EOenK3ownFC0mztARUYkFnMXBFjd/xqT24dxeicT7FROJKBojc7aUo5049yGLe4+fIktIotYilOs9uXxPE4VZq3c7E2hN3L6qkvL1IIN8nyJW4sRi3Jg9thJvRFRwzkDw5k0zhwLbIoqXrsWZI9wQ5DgZP+xdpY2SBvKNAji6HLLoj7qHDye/hFRq5ZSqeZbk1DUxjcdyKwYK2Qn1oz9L7PObuVTg7knCJCxTnxtogZHlZo5mntDvwMPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8Oux2vjEEcrJ3T6P0ma5Rzyyx1qmZnUUjYoZAz80go=;
 b=hgEXACcbH7DTAGW5Lmax/by6bLYs5ceHqUHMkqdAxULpxmWqKwVAEjOcv7B5anXDPNuP/MAVdb9PxIcKSONRfBKFaKI+LbXaMhrCmROxQWLEQX1dOd32n+e1U0fYwHC9cInBB88AcivllMsCmQSR918/VoYgD0vEubukvLLmprwMhnDTTAj8jih1206YHiKMbQ8rsdA/tE23rj84E179pOVUtLozSyoNC6wNZT1pq3+1ri6mXD+NYjZy2zOllCPRpYVCzyFkc52qyP0piqObC0ync38hbih54NROURS3SbuDRSp+Te6QuAfoLuXhhsnuRTEEUWLSrCSpDU5RIQ9tiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Oux2vjEEcrJ3T6P0ma5Rzyyx1qmZnUUjYoZAz80go=;
 b=ggU80eNNsj6cgSUVTukGkSkmLCG67G+ISSG/Jf3Ogo+aZG3YvMcP837dLhR6pu8ipePvAI5VKn8gZIe8yYf9YQ6fh6Cud1PYn7xn1elr9N/C8hNEmP+d8wIykHI4vwlX8rEf5MG3VfYxNT9fLHO7Y54591CXaTRrahjjX4RcxA77XLP3s9A/Va0+QAaBSvDeVO4/fmwZXHr1qQLHnwu4rHh52kfNh43QjHf1vdUN8fzouEmXhBETs1NzB26ZxNmaHpybHRl3nYeB7h8R5RAcs0KikRDZNzqWRVosRIMUzbBkJuVbjim27GOUcHNBfiRHqLCLOAPsuKGLE7itAesrzg==
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 17:46:38 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::7b) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Wed, 1 Feb 2023 17:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25 via Frontend Transport; Wed, 1 Feb 2023 17:46:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 09:46:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 09:46:25 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 09:46:24 -0800
Date:   Wed, 1 Feb 2023 09:46:23 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9qK3nJHjU4Bvxaf@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfc4110-aba0-4bb3-b57a-08db047c4504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YolmMjG3Tp6XaBxgIpmjZox3fBfbAJup6i1ZN+i6Kzw/9Uyv4kfI7mc6H4/4ropHKcHBOFjZQZFT6YN74OpUVuElJ5FbodJwcLQ0d98aB8qBK82nn3dL2Jip4ahhLaG8JvXmwMWm1h42HJIlabNs0oWwvUBypVk7Zq6mke8gkeiut4NfcxSNYqFkQxMBu/nXp5YjKqzAC+UATvZFNDV1E9Nr6KYYo3xrtBi8Srg/7cKVe8K+V69QZwkTuwiR9OOVd8kW4MeR/baDQ9FkHStZMElW3R4S82pmb5IboTe/unpLsyzaKvh+Xn96yDR/bzLH9vHs+3ygPmCtq4vaqkjxfzxtbKbFkb4AbV4w87ydFwRht3zr9B968cc2T5cxfrM3nONSRhvH3KdwpdrEYS0XFflFHVu/bERUY9nj6yjJMhyt8M6hKY6aZ8hkCciUmIXWNRUIe9Z8zFCeoUPjdQvtaaO4HToMJL9dzJnDTP2UuBWy7pRGhP6h3TK4grYQkZHhV5XwUVQlPzNlxyEGECzA0yc5H1pXhCkK5ucqk7Xi1iH1XKptYJaBCv/XJNs8ocpRdX3TGwQkcO0mfnUlbOdFnWnTxC4ckos0DXxTtijlZUW0qNAoCD+0LG1YSwahb0PiUQtGAc+5vzcY+XlLChFVY40VuDNfo9gkb/RXk2qHMY9nJFrSuZOzP+wOtb/Uqd6I6bRGY5A7diPIcsrqH09z/w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(41300700001)(2906002)(70586007)(70206006)(316002)(4326008)(8676002)(6636002)(54906003)(82310400005)(36860700001)(47076005)(478600001)(336012)(26005)(33716001)(8936002)(6862004)(186003)(9686003)(55016003)(40480700001)(86362001)(426003)(82740400003)(356005)(83380400001)(7636003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 17:46:38.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfc4110-aba0-4bb3-b57a-08db047c4504
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:53:02AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 31, 2023 at 10:57:13PM -0800, Nicolin Chen wrote:
> > On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
> >  
> > > IMHO I would structure the smmu driver so that all the different
> > > iommu_domain formats have their own ops pointer. The special
> > > "undecided" format would have a special ops with only attach_dev and
> > > at first attach it would switch the ops to whatever format it
> > > selected.
> > > 
> > > I think this could get rid of a lot of the 'if undecided/S1/S2/CD'
> > > complexity all over the place. You know what type it is because you
> > > were called on a op that is only called on its type.
> > 
> > An auto/unmanaged domain allocation via iommu_domain_alloc() would
> > be S1, while an allocation via ops->domain_alloc_user can be S1 or
> > S2 with a given parameter/flag. So, actually the format is always
> > decided. 
> 
> No, it can't decide the S1/S2 format until it knows the smmu because
> of this:
> 
> 	/* Restrict the stage to what we can actually support */
> 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
> 		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> 
> So the format is never decided.

OK. That's right. And the solution to that is also passing a dev
pointer in regular ->domain_alloc() op.

> > that we don't pass the dev pointer down to ops->domain_alloc. So,
> > the SMMU driver can't know which SMMU device the device is behind,
> > resulting in being unable to finalizing the domain. Robin mentioned
> > that he has a patch "iommu: Pass device through ops->domain_alloc".
> > Perhaps that is required for us to entirely fix the add_domain()
> > problem?
> 
> Robin is making progress, hopefully soon
> 
> So the issue is with replace you need to have the domain populated
> before we can call replace but you can't populate the domain until it
> is bound because of the above issue? That seems unsovlable without
> fixing up the driver.

Not really. A REPLACE ioctl is just an ATTACH, if the device just
gets BIND-ed. So the SMMU driver will initialize ("finalise") the
domain during the replace() call, then iopt_table_add_domain() can
be done.

So, not a blocker here.

> I'd say replace can go ahead ingoring that issue and that for now
> replace will only work on ARM with domains created by
> domain_alloc_user that are fully configured.
> 
> It will start working correctly for auto domains once Robin's changes
> get finished.
> 
> Is there another issue?

Oh. I think we mixed the topics here. These three patches were
not to unblock but to clean up a way for the replace series and
the nesting series, for the device locking issue:

	if (cur_hwpt != hwpt)
		mutex_lock(&cur_hwpt->device_lock);
	mutex_lock(&hwpt->device_lock);
	...
	if (iommufd_hw_pagetabe_has_group()) {	// touching device list
		...
		iommu_group_replace_domain();
		...
	}
	if (cur_hwpt && hwpt)
		list_del(&idev->devices_item);
	list_add(&idev->devices_item, &cur_hwpt->devices);
	...
	mutex_unlock(&hwpt->device_lock);
	if (cur_hwpt != hwpt)
		mutex_unlock(&cur_hwpt->device_lock);

I just gave another thought about it. Since we have the patch-2
from this series moving the ioas->mutex, it already serializes
attach/detach routines. And I see that all the places touching
idev->device_item and hwpt->devices are protected by ioas->mutex.
So, perhaps we can simply remove the device_lock?

do_attach():
	mutex_lock(&ioas->mutex); // protect both devices_item and hwpt_item
	...
	if (iommufd_hw_pagetabe_has_group()) {	// touching device list
		...
		iommu_group_replace_domain();
		...
	}
	if (cur_hwpt && hwpt)
		list_del(&idev->devices_item);
	list_add(&idev->devices_item, &cur_hwpt->devices);
	...
	mutex_unlock(&ioas->mutex);

do_detach():
	mutex_lock(&ioas->mutex); // protect both devices_item and hwpt_item
	...
	if (iommufd_hw_pagetabe_has_group()) {	// touching device list
		...
		iommu_detach_group();
		...
	}
	list_del(&idev->devices_item);
	...
	mutex_unlock(&ioas->mutex);

If this is correct, I think I can prepare the replace series and
send it by the end of the day.

Thanks
Nic
