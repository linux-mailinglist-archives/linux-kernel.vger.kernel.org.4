Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E049268787A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBBJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:13:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47486A302
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:12:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb+i8/wVxVWXw+DRorhKaQVGZuKZxwEf2lByZ8aO/gZyv7IjlyXsOetamF4Qigss6RnpIS3Ty+xWKtsdfzfSecSMNSkAGvbQVg8/BUtci75k8ZBbjjQsXquGU/nnfzsbIWzDIu2NA7prRvpKcoj4NyU/zxvmwI/9bizx0a17Esptp6zb6o2F6E/nJp9tPw8dSBrMSM+NqM88zv0l3JpOi3Y6FIskZ3dzeSZVrIHhUapPFwq2Awv4gt4GSOj3Ymge6c6vzlaHCUNi9IrtT1kvz9nwkoCNWgY0liepfTJgjilfwyRNlLq01Uvneuj0iNkHqKcqeQlj4coFUGv7TWjfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BoJeiXDh8VyLeak4L9Hv8q5BYHkZCOzGeqdFr2ks5s=;
 b=Y+GgSHnWaF7lp9yG+Znh4L7ym9yqrhaSVxrefB1leQp+eQIUkyh5kNPiYl7lYRWQgmM056h/nYDI4iPeJrQefCdqjYjDw3xm1DtxhL3UXJHIZlPzsd+jMEgZGTE26O6VmjjZw4VhCpllazuNeFI0cDbYMmsiC3KUx7gy7isMrtX/7tJJjQAJCLDSaVU9R2fYYjWmZ8U4nF2u5WFeUvAjg8gdxLWyxqe1zQ9DKLpVq5FKlKXVb7QBFbb9vwR21vgMS6oiHdlopGowI+JXwD3oT1xZ23rOXUeROaLRdOc9+/jOdEtRWRhvu+stYHh+eJmY8Lv+JsF93ws8eM+H38dP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BoJeiXDh8VyLeak4L9Hv8q5BYHkZCOzGeqdFr2ks5s=;
 b=nufU93LL5qjoHCyqObPjHLTmLXVFJgBidMOvlbNikCs+CbJ0xSnsgJLpEfhGFksrmW6/eSJADByY5GG5D5S6Gn7LVzl8p2y66FbJizAVJshIxnoj/Cx5TC5eMYQcNexJ7hzhsh/Bz0LA8kqrkBzHmawVF52ls8PAr/j2wd0HomRjEpT/gG/KLdrrVNobkctypzDqvlB2/5phVYfGfQ/TMoV/jcj/ZntVi33iAgtgY7t7homEBWltQTwT+qoNZtRC7BnByKTxfGxjpTJCbMveyTJRcPZvTJ08KEZZJSBQ8mxmIZY9k79gMvihnmN3Aex0oKBJ9XNRoQsGIEFKV4Plxw==
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 09:12:18 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::c2) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 09:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 09:12:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 01:12:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 01:12:07 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 01:12:07 -0800
Date:   Thu, 2 Feb 2023 01:12:06 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <yi.l.liu@intel.com>
CC:     <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9t+ZtnphowLFwr1@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9guZhNve8A1DGL6@Asurada-Nvidia>
 <Y9oZMTMRG4mL5FT1@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9oZMTMRG4mL5FT1@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b8e10a-3cea-4981-0ab7-08db04fd9531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgbtVhnhUYjS4B+5ycaU17Pa7dzCyaLcn0fogJ9KZcofhr6iH48L0geOsZCIp+omMWpy+Nt0mLQOYzQECe00kaVMUoyUQs4cd8XqOS9WQXIA4OfT1HhjPURg0hHKGoa5hEWXG7V6QCQHOvBV4VOYfnxtORYwZ9pz1zUnL/E5gsMdgJAaPmkltadBKrujq6uFw1gKulGFXKcWRb41WlGA+yzPc097G2fGNwCG5+TEZ3UP+zcCuK2K78Y9tTHnXotw5b/Jt6ofkizmPSmhMnPLUOoTlGH80Mug5641jLsLvDY108tuMwtuRnwQMtyT2pa8dUyrMjcPB4wPEsw+VAGd9CPxny7b8twr86+KMaOCPLh8cLX/YAMf1g/LVF/Ogm/xypQcZ17mDFGc5G61B/77c7GQ8LRgc/47bwHd26WTbrZtjywWN95EUDymapbeGeebhlxPfvryFCpnQTXQcctl+IaYjTDGmC1J5GYqdirpQ5i169trUBsdr4O8DATS2hK9yEvTLDZ4FAomY1+NHO/1YliVqUVkCFGXJ5nNbNQwgLhteIuVYtz5C777aiFbVkIiVNzu3fgaoQwH4C3z4fzBRMEBhg98zD6XO69yhRHxEH3zXM8ddJ/QnsE+harGWELrQYQwGiv7BQeja3cj4DIlGiVxSHjCXjAvqGiqUw6Fkc9jDMaR2doX6AmniBJITinZodoGuzcKfp6tYhiZ9vZ8LbnN9p8wk2Y2T+tSGHSNVgGi7q/E15/81yE1D9/WUVeR4kFwUyeiAod51ai6gO7+xLJPHj2pld4THFRSD0AciqoPM7Xy3nYdsJ3T0amCrydmzIUCzuLTiy60J3u1Ahm9sJzvj+4qOOkpjU2KF2zbXAI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(966005)(336012)(186003)(26005)(9686003)(36860700001)(478600001)(54906003)(426003)(47076005)(107886003)(316002)(83380400001)(70586007)(70206006)(8676002)(6916009)(4326008)(8936002)(41300700001)(2906002)(40460700003)(55016003)(5660300002)(82740400003)(7636003)(86362001)(82310400005)(33716001)(356005)(40480700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 09:12:17.7907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b8e10a-3cea-4981-0ab7-08db04fd9531
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:48:04PM -0800, Nicolin Chen wrote:
> On Mon, Jan 30, 2023 at 12:54:01PM -0800, Nicolin Chen wrote:
> > On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Jan 30, 2023 at 12:04:33PM -0800, Nicolin Chen wrote:
> > > 
> > > > I recall we've discussed this that SMMU sets up domain when it
> > > > attaches the device to, so we made a compromise here...
> > > 
> > > The ARM driver has a problem that it doesn't know what SMMU instance
> > > will host the domain when it is allocated so it doesn't know if it
> > > should select a S1 or S2 page table format - which is determined by
> > > the capabilities of the specific SMMU HW block.
> > > 
> > > However, we don't have this problem when creating the S2. The S2
> > > should be created by a special alloc_domain_iommufd() asking for the
> > > S2 format. Not only does the new alloc_domain_iommufd API directly
> > > request a S2 format table, but it also specifies the struct device so
> > > any residual details can be determined directly.
> > > 
> > > Thus there is no need to do the two stage process when working with
> > > the S2.
> > 
> > Ah, right! Taking a quick look, we should be able to call that
> > arm_smmu_domain_finalise when handling alloc_domain_iommufd().
> > 
> > > So fixup the driver to create fully configured iommu_domain's
> > > immediately and get rid of this problem.
> > 
> > OK. I will draft a patch today.
> 
> @Yi
> Do you recall doing iopt_table_add_domain() in hwpt_alloc()?
> 
> Jason has a great point above. So even SMMU should be able to
> call the iopt_table_add_domain() after a kernel-manged hwpt
> allocation rather than after an iommu_attach_group(), except
> an auto_domain or a selftest mock_domain that still needs to
> attach the device first, otherwise the SMMU driver (currently)
> cannot finalize the domain aperture.

Some update today: I found ops->domain_alloc_user() is used
for all domain allocations inside IOMMUFD. So, without any
special case, we could entirely do iopt_table_add_domain()
in the __iommufd_hw_pagetable_alloc() and accordingly do
iopt_table_remove_domain() in the hw_pagetable_destroy():
https://github.com/nicolinc/iommufd/commit/85248e1c5f645e1eb701562eb078cf586af617fe
(We can also skip that "symmetric" patch for the list_add,
 moving the list_add/del calls directly to alloc/destroy.)

Without the complication of the add/remove_domain() calls
in the do_attach/detach() functions, there is no need for
the device_users counter any more.

I am not 100% sure if we still need the shared device lock,
though so far the sanity that I run doesn't show a problem.
We may discuss about it later when we converge our branches.
As before, I am also okay to do in the way with incremental
changes on top of your tree and to ask you to integrate,
once you have your branch ready.

My full wip branch:
https://github.com/nicolinc/iommufd/commits/wip/iommufd-v6.2-rc5-nesting

Thanks
Nic
