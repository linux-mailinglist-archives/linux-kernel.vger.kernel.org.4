Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B26BC1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjCPABj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCPABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:01:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48418B3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKUUzl9mhEQhEZIWa2zJmK6+TvTITD9Vxymx5iyAgZ4DbSXoBsP9bVbeqTLwSw00kj8IbV94V9ewU9RTCV19sI05UEgCvCQGzOSivdOOxoT3AAz+u7oDeFy34wT92wClN/orA/NDeUwRcQHQNl8uhh7OKhm2mEPU0pc9jtW8kBgx7sRqNiE+c5VmtDBltFHBj5CDWvnTFuxVUg+VXP6dJKWbd01ctDIth6ynr/woiX8SZyE1kHToz1vNuLEAyQdqJ+4/rzrM3rjvruR91VY9HbNkTn7vWyPWpa+vxy/ILMjJtUVV+sHwTW537AcF5ZozG/z/eMdbI+HHMjwkgzCFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJL13LQjAiOLQna0jM+K44WxWkGLMOHaBGVztPTCVbM=;
 b=I7nkJ9vqihDe7tTfR75KhU25J/7yv/14KzmcaVdhqL2ZIWT3AW7kTcLzrK9la8cmPMv3J4yPD/gMMVIyp+G7EXsWxfSb1sFWCLFMyLx+eIhqXSwCvXB4/iRDluzPAB/MTifri5ojcuP/zI3aQvW0xmOkRPfcmlu/J69LNXGB6s17JrhJgKA0X4YfXbdvobGjZr0IZX5IoX2oC1JNW5v5OpddByKj94adB7NN1CLOHnG1AUzPUqf9kOrlQoPOFUleF0PycZ3JasZDNXg5zwIdPjBx2AcDjSTldDse3dufQxgSMjPv8Y8bRqVcvdlBdr0kx/Bq+qF8eLS8GRpIbHdZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJL13LQjAiOLQna0jM+K44WxWkGLMOHaBGVztPTCVbM=;
 b=LdbT6UGRaX7szWscqUhMgo/7scKeK4OXMYT6s8/P+ZMO1F03CckFE8j4QAlMkBti/ETzYFOnnL61OJ1/KLKXjaA+ZPUYv9a18JGMW6biPPa74HF13nDveEkH23A2i9mDxRgnhRSqAparzsB9FlotAdkLE6yCnsAU9oL/tSfKZz/vhgVPjEIh23tmEc6SyjINpVKj2Qc/mbjIy3ds0t+fGOEejxIrpnWYqzS5BAMU//Q+uWpfxvM5zhpbvCxV7fpANTB3b9ny+Mdo6r4GD0Rspe90JptFB8bAnS6W0MldhIeB9yqz6MrRzNQjLBQo+Z1UbkM1SVTMXgR26teA9ZGR0A==
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:01:27 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::4d) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Thu, 16 Mar 2023 00:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Thu, 16 Mar 2023 00:01:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 17:01:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 15 Mar
 2023 17:01:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 17:01:17 -0700
Date:   Wed, 15 Mar 2023 17:01:15 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 308dea83-f5ed-4c7b-ade1-08db25b196fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLoIuSaTXPjCYP8cT8+GG3Q38H83VWmVils/Uz0njR2Ysit/0UQ3W2SVeX07fai0+S2XLlRspMHsoPbOljSsCZh/WCejw+hp48F1nDNBF4OY8QxiRAbpmA6ORnFWM/Soxt4nUBSgd7F4+2C0LkMv/x9XubCzcaTNelppc6UFE1mBw6hPr1/3dnaPBBp1jguco3MEv+EEVNaA67CufY7aAsfuI+EPKoPsVE5fgaAsliJ5abq+2wZ+vHosiIzUr+BZpbsSb/Y3NLqIUbOr/d2PG+wVX3Po3Xul+n0PTbcNeXXiJaoLEso30wSjqdHibGfHxnCEFE0vLfxHJCMea6CoJr+87Gnnz5bdf/jpCJ4h65fsTgAYO8bD7dpcb7c7ROMZxYMDDj2MCiI2q6CCmz95rrqdYMVMOWmVt4dVefAD4JW/bROQJdXs0Sw5VDf+lbvc2B51tnUDVgfrZmwZKVmPiSSbj/pWCF3OWG8/hccEEZJwMoXG9G3c3jh3RuenYiLbkJPc+8JZ6A2+HlbKQCeIweQ9UaXxk+EhBgIfLUJk60oSR+Bj1Wu4jeZIVV9SM+p26GDELPpoRufvxgKLIlonBvLjqRMA74F88xxuYtn2EX4ZA7gN328ybgUQ3XPllQ+4/F8X5XoqsPafd9hnDYhkqbRXGdj+k1WpX9oDjEfCWKhin5It58EBetdmVwZjVdbA2JMYw7WbasQ9SYr6wwqFMq2bA2J6h794D7J+3tEeXMRqBbPmP0Cdwr57PQYlb0qx
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(426003)(47076005)(336012)(53546011)(186003)(66899018)(9686003)(54906003)(70586007)(70206006)(316002)(8676002)(6916009)(41300700001)(4326008)(36860700001)(8936002)(5660300002)(7416002)(40460700003)(26005)(7636003)(2906002)(82740400003)(356005)(55016003)(33716001)(86362001)(82310400005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:01:27.4544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308dea83-f5ed-4c7b-ade1-08db25b196fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:07:42PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-11 12:38, Nicolin Chen wrote:
> > On Fri, Mar 10, 2023 at 05:53:46PM +0000, Robin Murphy wrote:
> > 
> > > > > > +     case CMDQ_OP_TLBI_NH_VA:
> > > > > > +             cmd.tlbi.asid = inv_info->asid;
> > > > > > +             fallthrough;
> > > > > > +     case CMDQ_OP_TLBI_NH_VAA:
> > > > > > +             if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||
> > > > > 
> > > > > Non-range invalidations with TG=0 are perfectly legal, and should not be
> > > > > ignored.
> > > > 
> > > > I assume that you are talking about the pgsize_bitmap check.
> > > > 
> > > > QEMU embeds a !tg case into the granule_size [1]. So it might
> > > > not be straightforward to cover that case. Let me see how to
> > > > untangle different cases and handle them accordingly.
> > > 
> > > Oh, double-checking patch #2, that might be me misunderstanding the
> > > interface. I hadn't realised that the UAPI was apparently modelled on
> > > arm_smmu_tlb_inv_range_asid() rather than actual SMMU commands :)
> > 
> > Yea. In fact, most of the invalidation info in QEMU was packed
> > for the previously defined general cache invalidation structure,
> > and the range invalidation part is still not quite independent.
> > 
> > > I really think UAPI should reflect the hardware and encode TG and TTL
> > > directly. Especially since there's technically a flaw in the current
> > > driver where we assume TTL in cases where it isn't actually known, thus
> > > may potentially fail to invalidate level 2 block entries when removing a
> > > level 1 table, since io-pgtable passes the level 3 granule in that case.
> > 
> > Do you mean something like hw_info forwarding pgsize_bitmap/tg
> > to the guest? Or the other direction?
> 
> I mean if the interface wants to support range invalidations in a way
> which works correctly, then it should ideally carry both the TG and TTL
> fields from the guest command straight through to the host. If not, then
> at the very least the host must always assume TTL=0, because it cannot
> correctly infer otherwise once the guest command's original intent has
> been lost.

Oh, it's about hypervisor simply forwarding the entire CMD to
the host side. Jason is suggesting a fast approach by letting
host kernel read the CMDQ directly to get the raw CMD. Perhaps
that would address this comments about TG/TTL too.

I wonder if there could be other case than a WAR, where TG/TTL
fields from the guest's aren't supported by the host. And then
should the host handle it with a different CMD?

> > > When range invalidation came along, the distinction between "all leaves
> > > are definitely at the last level" and "use last-level granularity to
> > > make sure everything at at any level is hit" started to matter, but the
> > > interface never caught up. It hasn't seemed desperately urgent to fix
> > > (who does 1GB+ unmaps outside of VFIO teardown anyway?), but we must
> > > definitely not bake the same mistake into user ABI.
> > > 
> > > Of course, there might then be cases where we need to transform
> > > non-range commands into range commands for the sake of workarounds, but
> > > that's our own problem to deal with.
> > 
> > Noted it down.
> > 
> > > > > What about NSNH_ALL? That still needs to invalidate all the S1 context
> > > > > that the guest *thinks* it's invalidating.
> > > > 
> > > > NSNH_ALL is translated to NH_ALL at the guest level. But maybe
> > > > it should have been done here instead.
> > > 
> > > Yes. It seems the worst of both worlds to have an interface which takes
> > > raw opcodes rather than an enum of supported commands, but still
> > > requires userspace to know which opcodes are supported and which ones
> > > don't work as expected even though they are entirely reasonable to use
> > > in the context of the stage-1-only SMMU being emulated.
> > 
> > Maybe a list of supported TLBI commands via the hw_info uAPI?
> 
> I don't think it's all that difficult to implicitly support all commands
> that are valid for a stage-1-only SMMU, it just needs the right
> interface design to be capable of encoding them all completely and
> unambiguously. Coming back to the previous point about the address
> encoding, I think that means basing it more directly on the actual
> SMMUv3 commands, rather than on io-pgtable's abstraction of invalidation
> with SMMUv3 opcodes bolted on.

Yea, with the actual commands from the guest, the host can do
something with its supported commands, I think.

Thanks
Nicolin
