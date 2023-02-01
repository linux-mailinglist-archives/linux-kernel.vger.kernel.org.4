Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766966860F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjBAHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjBAHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:48:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6F5D931
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvtNnzR49NJL/Cih6Li68ySWEwJlwMoDGKQZQTpkK4B3U1ly6heNcAJL+S4hxWqgF3slHIVWOSGF6NtpUjurTLc1xI27tI8W5swrJ7VCnnhKqWD72lZ/DKYNwkscTi8KLbr7LKY+FFNbHeLXWgjxd667vg8wzdGXo5WhPiAA5Shm2kjYrPlWIPK6deSD2xc8gg5LWaicrgJRhYWXYNt/nsyhd09ut6rV9rXPn/iAahYyxIO9pQhjSQeOXDMNMEK6R6OOrdHHtevUypT83L6wg8a3zOa2cyA+PhPlITcJa3/HojF5BTPPUQWen9Ddg5/HxSM50xRhvH/fa2HxC61sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txv+m/RxcUhyo/PrnTTKYlAHByfjbkYvB4CYHiqDjPk=;
 b=DRLdA3x6D2JemolECQQDCLW6VosvV3YKqeAwv740WCwCxS78x+as9mJAeS1RsG2B+HJeQ+MWabiUYBWbXF2yg6wcvAbGEGfLZQmgJv1UMnf3FaioBh7NJbiYuucQ8oF7bx/saJSKrNylY/dhtNwuyOoX5urHi/dXrv9xKsSX24kVtAKRNZ5m+hV4MuS2SesjPHnFACH8phuazFwF6gfx1qaK9B/jj0Hxx/okjSRKsh1+8ASC6K8jTSTInXtdN+QHchflFwJYb4ejI+ixcu+5qfCrfiZHpZrJUGAE656j++sqeEz1BiVKCB1ETAQ+wafPXNYIntZ3Eq4LNhY1jDbebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txv+m/RxcUhyo/PrnTTKYlAHByfjbkYvB4CYHiqDjPk=;
 b=sY+lH5ySeBtRb/KeqIrcm6JTzDiAU7ixmmpGXaApL/I1dvMd7xPK+pLsphQJJWjKfmKUzXcaMmo32k36e/eji6x8GfRLXtpX05xnfpl/7Y9RnziJD403V5eitvMG2ZJFIOMyxq8eJd54Is0hBqNs/W+gYjXnBNy6jurpcQbZlGxEwCrDRIfqJm/HRzkqOxmlvxv3xfBs7xoW3p2TFyLI3gOQTPtGABt+uHLIp4/OSlEjiuNPtD5jtftzCVYbfVtKBxVdCgn3nq/GO35atS34nmI+QRmC6b6oXE8Mp3bq7NKgAAf6D5xjPDBqRfg+Nz3YMpH2U3uPqJs3/1trk5Aqyw==
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 07:48:13 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::b1) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 07:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Wed, 1 Feb 2023 07:48:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:48:04 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:48:03 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 23:48:03 -0800
Date:   Tue, 31 Jan 2023 23:48:01 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <yi.l.liu@intel.com>
CC:     <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9oZMTMRG4mL5FT1@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9guZhNve8A1DGL6@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9guZhNve8A1DGL6@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 964d0612-61c9-4c63-d6d8-08db0428ac17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIQw8MPiHRBsBqn9OYk8+lOFBe0zkkgh8sze0r+iD+LWGm9bFkxYAHgcSur77r5FZrN+k1o0BldfP8GWAr4XCBxHiGc8pywypjC7yFe42++UCtAIiZ0s4cfVfFTxqeeGKZQjH5zWd0s0jr+Hm4Le6NRWFCri4UqEhbMMqaB5wb1IImo/sABT0bE01fhG7GlkSGwgL3np83MqeYhMS7QqS2qkwmc13IxsDFLWjtY7sfetT2puJfggC2uRYoWrJ3tPwmlHSpFZzCk6/6sS7OXcMahEpo6DpDr2llQUzmQNCmOwaSfZIgaykFdEzNy+YxyK0xKHtfJClAvoRibhLPZ+9ldavlrQdRAJdM10pgqfM3Ufsjp32saApmVKAOsXV2X7+pgIIDcw+D5wNe6o/lRzVE9B2tvEZMj991cX/W22PyTQo8Frt3OLpv23am+2d6BNyGLx6LZ1DlqziJJuNc+j5hcw7VGPAPAXZB/dwATsGYJYyrA0JRzjXDeZF1JYrsqDxtLtFOv5kMAXcE9EFmkSkW7iCba5w13qdVzLQS7nmWKltQHmr3PLjM9dkTZLZNgywFmYyr3hB3t833LwnW+or4CgIVZPSO1YlO3nkYk7HVHbs/prKTJoAPX+YzcB7uC4vwN/n50M7ydc2woIjMC5zp6JmlFU+U10qmLxWoiNDf2B7z/Gdd27FdbDKWrxPkq6rmMiZxFthvzu0QHvrHzJNyOeT+l5wVNr2Q6O4/B8RQlalhPvD/7AQGHSarEs3yt/JPxbOdC9Q1tRyD9IoINdlfBlbcYgb3Eo6jcwkRMwGIacAQqZ1l4VzuJTofE+PGZk/NP5m//P8rbw98exTWzZJQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(70206006)(70586007)(8936002)(4326008)(316002)(8676002)(6916009)(54906003)(5660300002)(2906002)(41300700001)(478600001)(966005)(336012)(40460700003)(107886003)(186003)(26005)(9686003)(83380400001)(82310400005)(36860700001)(426003)(33716001)(55016003)(86362001)(7636003)(40480700001)(356005)(47076005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:48:13.4097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964d0612-61c9-4c63-d6d8-08db0428ac17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 12:54:01PM -0800, Nicolin Chen wrote:
> On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 30, 2023 at 12:04:33PM -0800, Nicolin Chen wrote:
> > 
> > > I recall we've discussed this that SMMU sets up domain when it
> > > attaches the device to, so we made a compromise here...
> > 
> > The ARM driver has a problem that it doesn't know what SMMU instance
> > will host the domain when it is allocated so it doesn't know if it
> > should select a S1 or S2 page table format - which is determined by
> > the capabilities of the specific SMMU HW block.
> > 
> > However, we don't have this problem when creating the S2. The S2
> > should be created by a special alloc_domain_iommufd() asking for the
> > S2 format. Not only does the new alloc_domain_iommufd API directly
> > request a S2 format table, but it also specifies the struct device so
> > any residual details can be determined directly.
> > 
> > Thus there is no need to do the two stage process when working with
> > the S2.
> 
> Ah, right! Taking a quick look, we should be able to call that
> arm_smmu_domain_finalise when handling alloc_domain_iommufd().
> 
> > So fixup the driver to create fully configured iommu_domain's
> > immediately and get rid of this problem.
> 
> OK. I will draft a patch today.

@Yi
Do you recall doing iopt_table_add_domain() in hwpt_alloc()?

Jason has a great point above. So even SMMU should be able to
call the iopt_table_add_domain() after a kernel-manged hwpt
allocation rather than after an iommu_attach_group(), except
an auto_domain or a selftest mock_domain that still needs to
attach the device first, otherwise the SMMU driver (currently)
cannot finalize the domain aperture.

I made a draft today, and ran some sanity with SMMUv3:
  "iommufd: Attach/detach hwpt to IOAS at alloc/destroy"
  https://github.com/nicolinc/iommufd/commit/5ae54f360495aae35b5967d1eb00149912145639

The change basically: moves iopt_table_add/remove_domain()
next to hwpt_alloc/destroy(); an auto_domain or a mock_domain
needs to attach_dev first, before calling the add_domain().

With this change, following patches of attach_ioas() and new
selftest should be also updated. I have them in a wip branch:
https://github.com/nicolinc/iommufd/commits/wip/iommufd-v6.2-rc4-nesting-01312023

Can you check if there's anything wrong with this approach?
And would it be possible for you to integrate this into the
nesting series?

I can also help cleanup and polish the changes with a proper
commit message.

Thanks
Nic
