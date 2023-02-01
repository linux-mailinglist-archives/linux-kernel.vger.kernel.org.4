Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D14686EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBATZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjBATZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:25:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C20D52A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aprylrf1ANsvPaTd1yezWFVWPR6IHRxtVxxf4cZP7/PUZR4Glv79Nxs+SwNZhrycN0/E5NBwueZ/op5c6XTB3mffWZ9bwy6r5SUGfqP3gJ6ShVXpwEKlvBVJGvrLpBFgK48O3/SevMQRU3UfBtRTZmrikifbodbSqk1mh1pNpOUeVo54OW4NDXpnAPh2yEKGayPBEqSzJbc9mn4qA7kR75WC/OnHl6rhjn705InikXpkY1iNTry8LFbZn8nDRaYcMtMRkf0opn380gzDUOB5ImAHUJ0gO7i1pi+C3ES5fbw4F6w54lpk8oC4k7SPhFd28iJAS8PeHF/cJf38fcNUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR0A2FvVdQt6LpSWn/r96BZycuZ0OnaEU8ON8zAskFw=;
 b=UNuzuoCR2hXlUQ72CzJBzGvIl0V8i0tYab+8DY+pjFJQq6vkrrBaV0QMx2TaUE0pGDDPtXlB0bc97W41CKjkfAtAoJIrLN/dGPdMhSvGhx0tLIA3XuDqDBzuuY3v6eXxQ8s/RqV47cJreB4Q13A9d0XZo7/En2Pu4erAIueehXSHlLAdpuqodd7EvFyfOo/TuZ0ziyLJEcQyv1EW4uapuQsysJzIjD24My7Ex496hmOEs1lV6mXxJ+XZrsHeImVhbtH8PW0WTrS9/tw++TUHFuyAqZEzMuWWzFoXvlD2jR/ZWMO7Pd6KBN83y5GoXPCOVJFXFzhJqfoY01ZrP7aoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR0A2FvVdQt6LpSWn/r96BZycuZ0OnaEU8ON8zAskFw=;
 b=DkhzK/1u8DQfMeGa8pRJ7kyzhn51NA9xvwYnVSk4Sck/scrPQxXY18xKOIdSuTD+Weg2LhgsczB8h+nB22e1IfgjGvq9TGdxr7mzh3Lx0q+5hQPIaqS+cQ0a0YN06tNaust27V2+ycbv0iGtKmgnWHCzqRMrq2UleXafG4c+BcO81o+hCypGtk8HxEculbcUDd7ZuePHo8yK0japF+TWnSsTrbbP16oUFcvwZ+ZcLdt1cwxyM2HZvBpfDyJR+Jb+aCbVDogn8VpxwrHz/TTXgHpvmkWa4SN8B+LclHBgm6JD/2/EyKvzRbs6SDP2Nf0mh71ADh1/josG+bJwlwKvBg==
Received: from BN8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:ac::19)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 19:25:24 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::ae) by BN8PR07CA0006.outlook.office365.com
 (2603:10b6:408:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24 via Frontend
 Transport; Wed, 1 Feb 2023 19:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Wed, 1 Feb 2023 19:25:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 11:25:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 11:25:12 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 11:25:11 -0800
Date:   Wed, 1 Feb 2023 11:25:10 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9q8llC0JVokHLf7@Asurada-Nvidia>
References: <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
 <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
 <Y9qxdinaS6anoWhH@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9qxdinaS6anoWhH@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: f61ea10d-4026-41fd-d5ff-08db048a1120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2pyBmRMXkIYQLAZwQLfiDISKzYeZEmmB1Q44wO9L4yvx0/wLZurMDD3V0WnqyK35bViRJ72byA3ZSpUGOKb8SHjH/iu2zoUCSXZTZkYBzLrgIuUMEIZvkM7Sx9PEpo5S4bCDSE9f0yYHFaDSoQHR3bHS+5qXhSO+X84wqR+vO1bhpiQPKTc2EZsikHFQU00euzGJlOW4MFYG1lTVMVVpwSFQlctWpEYwyqFXw0+/LjWwArLOErVQnKAYt1TdiZFBkEenPmTimwpRfakdcZvZv8VHSfLZxwrISTDIuSg0UgVVYi+zBvPjtZeQtnn0/tTWqkLPMafaeCbIBQGhH27g7Bq37OLWiVNvSXd1lDjoOKcIqibJrkSPEYzXUPDTDXGyt0irYXnq7j2kE9n/mly9rzixmV49fOhksT38ht3j/CwIuxtW+1BdT+Uw7sMLif3c+o+b4sTqmeDrYl2f5LMZg/Nt4iC3BPV2PFDAa1ZOYu94sw/K0uhOcVqnI7YzzmQdTTzWaqd3E1zZTJppHuiG4E9QGoHJAicjDIZdsX+W+u/rTou9+Yy4rZYAVOwZxxlvXnoRV0aCxR0qhe8ZYQJRMnnsVGtkx9aJx51py1SuoQ9Iduwsg/oVk6pZ8C0JOtjRVJU8iaoHLm6pyxTmGunDBtuEsxiwNVC8a6q2kY7+vdtmwuXgLU888sE4XN6vfjC2Gf7+3acTrA7MLqulACilrdgT+udFzUYLwXyi4WsS/V8r3Acw8P4Pv3THE3RcLZGlUf+qhEhWVOo/7Tc7oms1Q4dmWNNpxoNgE9aOuVYqX09EziWCB6g+GZLvIBuEAvtoQPCTFYXQ2RPWuQq86vytg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(316002)(426003)(47076005)(54906003)(6636002)(2906002)(6862004)(55016003)(40480700001)(36860700001)(8936002)(7636003)(82740400003)(356005)(86362001)(82310400005)(5660300002)(33716001)(70206006)(70586007)(4326008)(40460700003)(8676002)(83380400001)(41300700001)(9686003)(26005)(186003)(478600001)(966005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 19:25:24.0544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ea10d-4026-41fd-d5ff-08db048a1120
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:37:42PM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 01, 2023 at 09:46:23AM -0800, Nicolin Chen wrote:
> > > So the issue is with replace you need to have the domain populated
> > > before we can call replace but you can't populate the domain until it
> > > is bound because of the above issue? That seems unsovlable without
> > > fixing up the driver.
> > 
> > Not really. A REPLACE ioctl is just an ATTACH, if the device just
> > gets BIND-ed. So the SMMU driver will initialize ("finalise") the
> > domain during the replace() call, then iopt_table_add_domain() can
> > be done.
> > 
> > So, not a blocker here.
> 
> Well, yes, there sort of is because the whole flow becomes nonsensical
> - we are supposed to have the iommu_domain populated by the time we do
> replace. Otherwise replace is extra-pointless..

The "finalise" is one of the very first lines of the attach_dev()
callback function in SMMU driver, though it might still undesirably
fail the replace().

https://github.com/nicolinc/iommufd/commit/5ae54f360495aae35b5967d1eb00149912145639
Btw, this is a draft that I made to move iopt_table_add_domain(). I
think we can have this with the nesting series.

Later, once we pass in the dev pointer to the ->domain_alloc op
using Robin's change, all the iopt_table_add_domain() can be done
within the hwpt_alloc(), prior to an attach()/replace().

> > > Is there another issue?
> > 
> > Oh. I think we mixed the topics here. These three patches were
> > not to unblock but to clean up a way for the replace series and
> > the nesting series, for the device locking issue:
> > 
> > 	if (cur_hwpt != hwpt)
> > 		mutex_lock(&cur_hwpt->device_lock);
> > 	mutex_lock(&hwpt->device_lock);
> > 	...
> > 	if (iommufd_hw_pagetabe_has_group()) {	// touching device list
> > 		...
> > 		iommu_group_replace_domain();
> > 		...
> > 	}
> > 	if (cur_hwpt && hwpt)
> > 		list_del(&idev->devices_item);
> > 	list_add(&idev->devices_item, &cur_hwpt->devices);
> > 	...
> > 	mutex_unlock(&hwpt->device_lock);
> > 	if (cur_hwpt != hwpt)
> > 		mutex_unlock(&cur_hwpt->device_lock);
> 
> What is the issue? That isn't quite right, but the basic bit is fine
> 
> If you want to do replace then you have to hold both devices_lock and
> you write that super ugly thing like this
> 
> lock_both:
>    if (hwpt_a < hwpt_b) {
>       mutex_lock(&hwpt_a->devices_lock);
>       mutex_lock_nested(&hwpt_b->devices_lock);
>    } else if (hwpt_a > hwpt_b) {
>       mutex_lock(&hwpt_b->devices_lock);
>       mutex_lock_nested(&hwpt_a->devices_lock);
>    } else
>       mutex_lock(&hwpt_a->devices_lock);
> 
> And then it is trivial, yes?

Yea. That's your previous remark.

> Using the group_lock in the iommu core is the right way to fix
> this.. Maybe someday we can do that.
> 
> (also document that replace causes all the devices in the group to
> change iommu_domains at once)

Yes. There's a discussion in PATCH-3 of this series. I drafted a
patch changing iommu_attach/detach_dev():
https://github.com/nicolinc/iommufd/commit/124f7804ef38d50490b606fd56c1e27ce551a839

Baolu had a similar patch series a year ago. So we might continue
that effort in parallel, and eventually drop the device list/lock.

> > I just gave another thought about it. Since we have the patch-2
> > from this series moving the ioas->mutex, it already serializes
> > attach/detach routines. And I see that all the places touching
> > idev->device_item and hwpt->devices are protected by ioas->mutex.
> > So, perhaps we can simply remove the device_lock?
> 
> The two hwpts are not required to have the same ioas, so this doesn't
> really help..

Hmm...in that case, we should hold two ioas->mutex locks in
addition to two device locks?

Thanks
Nic
