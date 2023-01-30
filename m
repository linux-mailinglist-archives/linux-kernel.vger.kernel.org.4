Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657EA681B11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbjA3UFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjA3UEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:04:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A84740D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diS95kK+a4/XwvdWVXUq8EIihjxAUsosQmUS2TGj+fjQRovBCjcg7M/L+qrxIYFLIPe1prmWKkYEesg8sxt8YmiRAsbUFLv8blMkwbg33nAYOouoC5AoEr3hJltat8nqxwancHbKgjvQD9zXLhvLxBL+EtBzezoK1oGgnHGAypwcCkyGpyJk76yCdsJ1EIJQtsFskEsVpk012toUcC7j8hiaJxTcTHk0vbJ1YnCROS74TqlwehiACZB/XS+WY4wmCHzhNAji2QjFMnNk02Z6i7gFca+UtlA6Z1E0vXlCdJaklyaOOuU7upYak2KsawLPodkRKvq+lAGn6u948ihvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM/c5bDiJO5Vi3XpRvEaCQalsOAojFtioPPhhCSbyHc=;
 b=Xf77+7SWSzqLHq14sURzjtbR0CL3Un58wmOOnDxmup+9wLIhkg/bOMbyFlqaSiVu3I7fue/TDyyfLBKg9HXn3Fk7a+72a97oCSUK6MjWOVjg72NwxhFYCNHrF+TZ2Z8jbASnjxNcDHyzYxXvN4HfA6/D/ZavM+1+qxsUBPL+wSN3j8wPyJp4bSPvgTPQ1QAcQID4JjtbUeRWZ2ZCt5+737nm1kHzYZB7a2wy9vSc8xqh+vnc2XZfb4T8hsciQ5X9IhuyX+j/pyZ1sW2WYg3JULyFLMECYqpziCTgmb9jtR1e7KhtB2zxCF0ICycrLr5RxkgX1qqPo+5FGliABHd7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM/c5bDiJO5Vi3XpRvEaCQalsOAojFtioPPhhCSbyHc=;
 b=apdTiXQE+rHOQTnBPNntfPcZGcUcbbhgmfQnnQAQl7n4hSaS7R9/mI+OvwLbh3KCO6tCnGQagAC8CDUy5fwuwBJ+KuXPjKSQ/fv9nsZaZR3mIINDugp0td2H3gKZRpXrLS/IMJplWQ0LarAaSnqKpWuNjlSJ/vEaFP9Y4vw18bIjywVoIZRxNv1NNelHbG51fbfOnKZcAIXDnSJNcuJZtF8bp/N20CdDH+3nkQ7wgQ7AsnBJX+Wn6JnYeF78NFXj/eodgS2veH2DXAg33VDcDiu1PSQMC2jYjykZ4vAgN7IY4aaDgKQji0vnrLhWonGbALEtx3Vi4fecfjC5UQuqLQ==
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 20:04:46 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a8) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 20:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Mon, 30 Jan 2023 20:04:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 12:04:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 12:04:35 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:34 -0800
Date:   Mon, 30 Jan 2023 12:04:33 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9gfbx/fszb0aTJn@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c2776e-19b6-4be2-5c5d-08db02fd3c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SodUnx1yD2QL6MapNCxlq3PEI1SsSeTvcoIVyFqq3GEc6oDc1dFeJtsL8TZIDx8+ePKCUc3OBbjC1K9OB0mHDLGovi/Cke3JtqYjhqXnYrKGo7b89jxUuUN5SsNXhpki3pHaIgalE2rlFvLBEbtCyGjD8Lgsnnrefyj81vHDWgSJORZAwq4/TpXteBbiEZR/ZBzXGP3bkEKR1bsKSAnHjhP6gLlRrr+pmBHqSwmeTe2WmT2xd6nlimH4wHAFyAXIunMsvuS02qdsVMJ3JE8sOV289ELYTZMOAU4iqqVm9etLLPLsnjHwf0GbTXEsLMCDbmbVyg9ahpVPdy7nELIRqAuG2aHofMaqIuyJDad2ld7OUWQovNDffORGq9WiDhGmvKSmJg1TonP6mUG+BUGuv18aHMbeNQsG9yK0+L/LoFZaYCYMkDyoIMHMiyPWn33z1i/COHDDr8Ml/5m1QF/IIiFYzvCkZ6BK7sWIWPgX4Cq/x9EJjdplK2MHoRiXrNNHABXEiR2HuGiwaRMqm+6lHSa9zucXzOae1Y+smKezRPQJqLJIHTIWz1p4TyUEyBPLwTt4Ihl8/eM2U+PogWdHxFuTItwmCX1Qbiwok7whGB1LpQn0/4Aq/A4rDd9Wnq9btCo3f7+vuDSmx6mBk6C7+XkmPpD0IK85J4vpK5Vi1muPAJ7sJ81Qs1bzr7bfEynb
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(7636003)(2906002)(316002)(186003)(356005)(6636002)(5660300002)(54906003)(40460700003)(26005)(9686003)(82740400003)(82310400005)(55016003)(40480700001)(47076005)(6862004)(83380400001)(426003)(336012)(86362001)(478600001)(4326008)(8676002)(70206006)(33716001)(70586007)(8936002)(36860700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 20:04:45.9675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c2776e-19b6-4be2-5c5d-08db02fd3c0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:50:07PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 30, 2023 at 11:27:37AM -0800, Nicolin Chen wrote:
> > On Mon, Jan 30, 2023 at 11:02:25AM -0400, Jason Gunthorpe wrote:
> > > On Sat, Jan 28, 2023 at 01:18:09PM -0800, Nicolin Chen wrote:
> > > > From: Yi Liu <yi.l.liu@intel.com>
> > > > 
> > > > Currently, hw_pagetable tracks the attached devices using a device list.
> > > > When attaching the first device to the kernel-managed hw_pagetable, it
> > > > should be linked to IOAS. When detaching the last device from this hwpt,
> > > > the link with IOAS should be removed too. And this first-or-last device
> > > > check is done with list_empty(hwpt->devices).
> > > > 
> > > > However, with a nested configuration, when a device is attached to the
> > > > user-managed stage-1 hw_pagetable, it will be added to this user-managed
> > > > hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
> > > > this breaks the logic for a kernel-managed hw_pagetable link/disconnect
> > > > to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
> > > > multiple times if multiple device is attached, but it will become empty
> > > > as soon as one device detached.
> > > 
> > > Why this seems really weird to say.
> > > 
> > > The stage 2 is linked explicitly to the IOAS that drives it's
> > > map/unmap
> > > 
> > > Why is there any implicit activity here? There should be no implicit
> > > attach of the S2 to an IOAS ever.
> > 
> > I think this is supposed to say the following use case:
> > 
> > Two stage-1 hwpts share the same parent s2_hwpt:
> > 
> > attach device1 to stage-1 hwpt1:
> > 	...
> > 	if (list_empty(s1_hwpt1->devices))		// empty; true
> > 		iopt_table_add_domain(s2_hwpt->domain); // do once
> > 	s1_hwpt1 device list cnt++;
> > 	...
> 
> No, this doesn't make sense.
> 
> The s2_hwpt should be created explicitly, not using autodomains

iopt_table_add_domain() is called in iommufd_device_do_attach(),
so it's shared by both a created hwpt or autodomain.

> When it is created it should be linked to a single IOAS and that is
> when iopt_table_add_domain() should have been called.

I recall we've discussed this that SMMU sets up domain when it
attaches the device to, so we made a compromise here...

> The S1 attach should do *nothing* to a S2.

With that compromise, a nested attach flow may be
1) create an s2 hwpt
2) create an s1 hwpt
3) attach dev to s1
    calls iopt_table_add_domain()

Thanks
Nicolin
