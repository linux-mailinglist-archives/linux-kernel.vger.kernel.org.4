Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6756BDA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCPVJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPVJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:09:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31414C6F6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMzFXQVaWGZ5WIwgIKd6CYyW8MYlHRJddLdtU5QTeljn/Ydf4KdSweJy4dRRp1j09H6RlehJDF/6UJ44vQrMuINO45LzkTp5GLePVVs6aVFR2PpbBY8Mh6KZDCF2qunofHaOvepvlVkwxOw3aMunF3aVJE2dnJ5YCM+jJRE4daiTXzEm3K7P2WzkUWVjbw2UoXuRvUDAjLgwQcRwHzwx787RGJHBls/GGjODRShNT68RFqaTAbW5CKPBNMAasp66oNHFKzUQoY66hoxcunIiWDG+41QTku+SiQG2Na8ZQaVxvG2yF3xme/LVVvIGXnqAEtkVFWjlTwnq0cjtnLTCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MaHUDW1VWp22oU5rmXGmPLmIguo2zzmTgU3hj53Tnw=;
 b=Djiha5+PvZ29jtUQwClZVytjtaTiEaQJTqlBVRW36EGMKaOc+nexptXgoSp3GSSDxFyq8+G86QXUvWDAgaFwXnQZEkNC2vE1R+k3ZW6qFzwEVFC30EGtC5MqiQ15350rJbB6xi1M75S7QrlL1a3KOy9KSg86bnxKyy9mhrhKdBFMMR9urt310GK62tH6hfL32DdCVcOYqekB2XfVBlR9rkKy3IJBIHoKvK7oj+fSBhrrf8vCsmzKeOTxurrjqdWF11NDhc1EvH9Pikj405bnWIkYFURH3mBlOmgrf7t709FpeHX9JD0DAfpn0uJZscFLPQnyTK6vRXPVuyajYJqjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MaHUDW1VWp22oU5rmXGmPLmIguo2zzmTgU3hj53Tnw=;
 b=Lhse83MifUh9H8lL0RmdehT37ZvYe0ndDrp+8FawqB+cw2X2bTOe7D40kN3sQYfREX6unI1WqcNdlHJM2fiznnRMMyHNj2eesWsHPepKBwyQJaV14B6u0IPgTKuIIM186vPDTOou1ChtzcidLrC41Fa+oWGuNRApAcIoThY7rdSl+M3/QhhwkxYqlU0vALrIyWGQjyfZqIiRG9AK4MbTxFvV9MfWq8lrrKQnUiaeiQsR+a8aGM8tBosfN+B6rfw4NNnClJG8N24R9aEYwLOUPInG7ITJnmklU2hw+8C978fQQsdrGwSRgQgdc6m9dX2/MUslu0hdv1tl7WhhsuygdA==
Received: from DM6PR21CA0024.namprd21.prod.outlook.com (2603:10b6:5:174::34)
 by DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 21:09:15 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::48) by DM6PR21CA0024.outlook.office365.com
 (2603:10b6:5:174::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8 via Frontend
 Transport; Thu, 16 Mar 2023 21:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Thu, 16 Mar 2023 21:09:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 16 Mar 2023
 14:09:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 16 Mar
 2023 14:09:08 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 16 Mar 2023 14:09:07 -0700
Date:   Thu, 16 Mar 2023 14:09:05 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBOFcenanpRsGFzF@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 6994e20c-ed99-410f-8c55-08db2662b325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4o/CTQRQYbblKqAPTv52N9PBSvkhAl5yZTqaBIQolIn09mMu8wfxLJEFQSRAUBu4n53GviVgdMMNAWsx4otydSQ3oQvfiC6Tu6sMp48SWDWFG5NSCHy3APL1W0n1JnJF/zQAitx86v+plf4yNAOfTDEdGsSBRWB/1Wr//91oE1oBiGpjjckC49I5xWrsxoCbo4woJUl4fk5uWJqYvuYSvYabiDEhF+qxLPAKHDgLmfPDH79PCsao5CxZRxAPc/AlNKo+PxgKUpu+vtEuUgBDzG1yR+8wJrYFUkw4Q9/+AyAr56kSqFCrcHhEFimHmVSlwLTRExY6LkrOnbPfvi7tFNXknCU94YHMNTe1ast6hdOmHx6sljC9wCi0oQKpiKsKe4kei38Tu6XwFXohy9Nm1OBBGoKYMIqWbBm704aJX0WCqJ1RLJJD7niMYAr4BrgurotMJB/ZVf/DRFR+WQ4THI0Nz5mIXNYeIWsyn4ByEuVg3kxrNUibVSyAoxOrz5ZbgIyin+PmWqP6jSfjzeUjFOWPQ6Q+KSZZmSSm7WJWPmS1PRhJzKxqYg6/woXimszrEHO82Ywkz3+0qn8cWRFKgTypa0SumDVvIO0xWngYw31JLJrjdDyeShC6FBdZRFPFaGDD5ZgPZR9JfeUCYjEs04pjlRLlhYZ51HwD0jKan/VDQWQ7ogVwa8/K0+ZA0RvxZwnQoQYILdgsRwpbjrxr9L19v7rpEPi7AtMcbYbw+c/1i39LVaT1csTshQoPNA9
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(40470700004)(36840700001)(46966006)(33716001)(70206006)(70586007)(336012)(186003)(9686003)(4326008)(8676002)(6916009)(41300700001)(47076005)(316002)(426003)(478600001)(54906003)(26005)(2906002)(356005)(40460700003)(5660300002)(86362001)(83380400001)(7416002)(82310400005)(40480700001)(8936002)(82740400003)(55016003)(7636003)(36860700001)(66899018);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:09:15.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6994e20c-ed99-410f-8c55-08db2662b325
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:58:39PM +0000, Robin Murphy wrote:

> > > > > I really think UAPI should reflect the hardware and encode TG and TTL
> > > > > directly. Especially since there's technically a flaw in the current
> > > > > driver where we assume TTL in cases where it isn't actually known, thus
> > > > > may potentially fail to invalidate level 2 block entries when removing a
> > > > > level 1 table, since io-pgtable passes the level 3 granule in that case.
> > > > 
> > > > Do you mean something like hw_info forwarding pgsize_bitmap/tg
> > > > to the guest? Or the other direction?
> > > 
> > > I mean if the interface wants to support range invalidations in a way
> > > which works correctly, then it should ideally carry both the TG and TTL
> > > fields from the guest command straight through to the host. If not, then
> > > at the very least the host must always assume TTL=0, because it cannot
> > > correctly infer otherwise once the guest command's original intent has
> > > been lost.
> > 
> > Oh, it's about hypervisor simply forwarding the entire CMD to
> > the host side. Jason is suggesting a fast approach by letting
> > host kernel read the CMDQ directly to get the raw CMD. Perhaps
> > that would address this comments about TG/TTL too.
> 
> That did cross my mind, but given the usage model, having host userspace
> give guest memory whose contents it can't control (unless it pauses the
> whole VM on all CPUs) directly to the host kernel just seems to invite
> more potential problems than necessary. Commands aren't big, so I think
> it's fair to expect the VMM to marshal them into host memory, and save
> the host kernel from ever having to reason about any races or other
> emulation details which may exist between a VM and its VMM.

An invalidation ioctl is synchronously executed from the top
level in QEMU when it traps any CMDQ_PROD write. So, either
packing the fields of a command into a data structure or just
forwarding the command directly, it seems to be the same for
the matter of worrying about race conditions?

> > I wonder if there could be other case than a WAR, where TG/TTL
> > fields from the guest's aren't supported by the host. And then
> > should the host handle it with a different CMD?
> 
> As Eric found previously, there's a clear benefit in emulating range
> invalidation for guests even if the underlying hardware doesn't support
> it, to minimise trapping. But that's not hard, and the patch as-is is
> already achieving it. All we need to be careful to avoid is issuing
> hardware commands with *less* scope than guest originally asked for - if
> the guest asks for a nonsense TG/TTL which doesn't match its current
> context, that's fine. The interface just has to ensure that a VMM's SMMU
> emulation *is* able to make a nested S1 context behave as expected by
> the architecture; we don't need to care if a guest uses the architecture
> wrong, since it's only hurting itself.

Agreed. Yet, similar to moving the emulation of TLBI_NSNH_ALL,
from QEMU to the kernel, we could move the emulations of other
TLBI commands to the kernel too? So that a hyperviosr doesn't
need to know the underlying supported TLBI commands by a host,
and then simply relies on the host to emulate the command with
whatever the actual commands that the host can do, addressing
one of your comments mentioned in the conversation below?

> > > > > > > What about NSNH_ALL? That still needs to invalidate all the S1 context
> > > > > > > that the guest *thinks* it's invalidating.
> > > > > > 
> > > > > > NSNH_ALL is translated to NH_ALL at the guest level. But maybe
> > > > > > it should have been done here instead.
> > > > > 
> > > > > Yes. It seems the worst of both worlds to have an interface which takes
> > > > > raw opcodes rather than an enum of supported commands, but still
> > > > > requires userspace to know which opcodes are supported and which ones
> > > > > don't work as expected even though they are entirely reasonable to use
> > > > > in the context of the stage-1-only SMMU being emulated.
> > > > 
> > > > Maybe a list of supported TLBI commands via the hw_info uAPI?
> > > 
> > > I don't think it's all that difficult to implicitly support all commands
> > > that are valid for a stage-1-only SMMU, it just needs the right
> > > interface design to be capable of encoding them all completely and
> > > unambiguously. Coming back to the previous point about the address
> > > encoding, I think that means basing it more directly on the actual
> > > SMMUv3 commands, rather than on io-pgtable's abstraction of invalidation
> > > with SMMUv3 opcodes bolted on.
> > 
> > Yea, with the actual commands from the guest, the host can do
> > something with its supported commands, I think.
> 
> The one slightly fiddly case, of course, is CMD_SYNC, but I think that's
> just a matter for clear documentation of the expectations and behaviour.

What could be odd about CMD_SYNC?

Actually with QEMU, an ioctl for a CMD execution is initiated
by a CMD_PROD write trapped by the QEMU, then a CMD_SYNC only
triggers an IRQ in this setup.

Thanks
Nic
