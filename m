Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6C6BEB14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCQOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCQOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:24:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131691D930
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL02CWKux8qgkPdy9wDLJYbpFse6iWUmn/gKLkjLCWeeKq1W5TMVA7+0iMD8+jXoYSxlVtJz470hwlQ383OfP0qQCnNPw0NLx/YXSIh7ve33e609aCKV/k6JvWNLFeixG8eutYX+bgEXXSyxbFTs6y1Ew2cV/TL1tEvp6iT4FEnZNgyOavzO+U02uq8it/KgdLkHzBlseGYtZ/R6DwR4YZWTbYFDrfaFDFIYPwGWCzq82D5g5ElfRZUFVSxJOoA9eD5cWhjoVrz0t6C/uOcXP6GwJGhtKEyTofYsl1v6h45NkcoCMXlHydWa+tHivitgM3WeLknCox0FoEIWnTmxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NefcJvgfkP/vMcdZvRV9/tZyNyu5GhX7ODKoQjc4CVg=;
 b=eErlqSIGhsco3rwKa24yeBsjCRLQeJBZrDA1UQekKxjSbYXulcOXgBILDifEvdlZ8w8g2mxbUhDqUYLYWtbXD95S2yIku3ol7MXBQKZT5gBODhIWj+PsBCTfnOJyXKEvkUL8cFxO0j+Qid05qE8kNDnpUQIcBRMCFndty87WHP87v+3pqc3a4u3t0MY2z9tIrErNyNwCw7NdrmqzIYC8h+Qb+pTfxrRWF5FXBtiApnyCHH5bfvHu3LdbUcGdlzG1Pkj9U8dqyJaN5ltk8jhfFKTbe3H4rAbDKRAKx6IshLTktgLYsLtfzMY6t/+JvuqMGEgv1PiuFaFAPLhtZtm54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NefcJvgfkP/vMcdZvRV9/tZyNyu5GhX7ODKoQjc4CVg=;
 b=CVfdQ8e7NjBGc5696+1ijmFcm5V6QsySkWCRIZ7vwXCKZKAgjtHBLdbnaxxilRIrQML8jPtBT26WtzhTDmaN/7iBj1qiDuJUSr/ALe3oKHNVmOeZbvxa98QXfVWtik7QfGmR7296mvsWlu2WwLvgXU58DyZrhoZ9Xya/d9WOuenQPd5zNo3wYr7PaX/ogK793cjFPYM0cdQFpqoP5I5nZ+woJNaWtKc4hqPuQwzlBAay2Q7rxPg55kYiKIrVOB2uDNrdURrosmGnxCZJiKFjz95yR8Szf+EiCZ2WlPCD9xnSPT5rEwawBLWcTk6VDrbgtYkCw2ysC7WRuTQfY7Jhew==
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 14:24:14 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ba) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 14:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 14:24:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 17 Mar 2023
 07:24:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 17 Mar
 2023 07:24:08 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 17 Mar 2023 07:24:07 -0700
Date:   Fri, 17 Mar 2023 07:24:06 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <ZBR4BkVAgQeVEART@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c00783-0d81-44b5-ae40-08db26f348db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQtpSrQovBzL+aFgQvLCITH87p4RjFuQOyfXeEZo35g9oVeRJdWrh2M6+wzIUR5O2PpjSaNnXonzA2wV3JYSzb4DC5pW5BXKa+EGBPS9dOBsLUNlGCsVg7QzOLzgMGM0t5AuCz+XkycZwXUFjPBrc7Czjxm6PkmzRQ5/vx6Oe34OPEBKcVtvktA4fDnVCpwd0Z25dBofPxHy+bz8P/XwEM9IaTLqMf7JjGspTA94yRNZeaT0MfcAC0jag81o3Qr0Q7gUYp/dq8t7DqTCj+19h1603XcDIjSTw6PAWD8Y+Ak2RCMN8hR4LlkOiE1On1hPE7BinTbzMb6a0KoWiIY0XMfN4eRbQFifBuudGEXQtT5nrIBX3OZfGUIomKUA24qWI0RR2kMwibMknAIz3vz/xM8loJirTfRVwLKQ0UugbMj8cUFaAp2DgtkavrXhIJ4JBYurLbDHzfOHF7SAF1RSFTIyzIA52GFxb16kflXIef2psUsrSxL7feKR+sI/0TlVSGhZeVnJ02cp10z2YpAtI6oHYYexy8ivof1cTCgMgnq/cOOiyq/OXkSyjv3UBNYpcV8G76ize6qdI4pNjio1zQb0G5chp0ckRnyI0LTwO9puLnGtf0IoRjHV9VkClel3CT/XrDn2oXQCE1oYIIT6Rc+5atgugM8Ae/sPG0uQhEHFwmBZL80AMRY93zD8/KlbzYqCbOcYcxcb0QE7kH8lil/wh06Lya7HzmbCHWD9n4lI+M9LmBrzKKYcUgVGbtH0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(8936002)(7416002)(356005)(5660300002)(41300700001)(36860700001)(55016003)(86362001)(33716001)(82310400005)(40480700001)(40460700003)(82740400003)(2906002)(7636003)(26005)(478600001)(83380400001)(426003)(4326008)(47076005)(336012)(6916009)(70586007)(8676002)(70206006)(54906003)(66899018)(186003)(316002)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:24:14.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c00783-0d81-44b5-ae40-08db26f348db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:41:34AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, March 11, 2023 12:20 AM
> >
> > What I'm broadly thinking is if we have to make the infrastructure for
> > VCMDQ HW accelerated invalidation then it is not a big step to also
> > have the kernel SW path use the same infrastructure just with a CPU
> > wake up instead of a MMIO poke.
> >
> > Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
> > support.
> >
> 
> I thought about this in VT-d context. Looks there are some difficulties.
> 
> The most prominent one is that head/tail of the VT-d invalidation queue
> are in MMIO registers. Handling it in kernel iommu driver suggests
> reading virtual tail register and updating virtual head register. Kind of
> moving some vIOMMU awareness into the kernel which, iirc, is not
> a welcomed model.

I had a similar question in another email:
"Firstly, the consumer and producer indexes might need
 to be synced between the host and kernel?"
And Jason replied me with this:
"No, qemu would handles this. The kernel would just read the command
 entries it is told by qemu to read which qemu has already sorted out."

Maybe there is no need of a concern for the head/tail readings?

> vhost doesn't have this problem as its vring structure fully resides in
> memory including ring tail/head. As long as kernel vhost driver understands
> the structure and can send/receive notification to/from kvm then the
> in-kernel acceleration works seamlessly.
> 
> Not sure whether SMMU has similar obstacle as VT-d. But this is my
> impression why vhost-iommu is preferred when talking about such
> optimization before.

SMMU has a similar pair of head/tail pointers to the invalidation
queue (consumer/producer indexes and command queue in SMMU term).

Thanks
Nic
