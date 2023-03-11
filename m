Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBBD6B5BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCKMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCKMiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:38:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392817CE3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:38:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTG3eGNtTjRhmO/6h3MVvL/wVG9P0k7ZZAbXKwI+ptjnoOmLpQidDeo1Z7h3LK5xs7Ejr1ioPSUJAHThlFkhbB/g4ZN3QDiggQYJoTBxao3ug4TuAYg9SKo0WBelzpPs3onCN5Cf9ghiTqXosD6q/3nbRxpbHgemDUQD3UYJyy1D9zo6x1vY+OPQBM8ToPLwsVHVKfHzP23ilEW5x00j2hxXsfLWEuqibrInhi4zpUNMMSek+EMEOuNIyyZh7L0g3d74XqbsszCT/on2Xi3xF7SSIBb+zq8S3gk3R+ruVjNtiwSkiTSGwvdLfWU2u3u0x0rxz2ub9+Ro1MTJjHZE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv05Hp3tb1qfAJje9jpG0EX+ahNzopfCZF58bS6kGBA=;
 b=BHFPjeIZemq+Ybk7pzwpSQ7LXwIps3w+dZ42SkuRWLDpEPH5rxjc6RodXpKCtH6724bQ54mIUhJpdYIbCAGJDDrNVQ/4R9abw4X7vWBvGMsfUOXh2ocrF/mWfRwoHLJrXhGEjeU1purvgUjzZ+iZBQa5fpEKOiqXAAXorMIsGtzCjlQnaGQWyLq9OTQS8D1HEtWRR0cbXFa7tydbOeGGn5T7bFP9aPxF27tEUfPsUtwQc9r4InGFqGdu+vBNHoNfPO8sLLhz2MaES23SOzzcLN9R1GPn2pGWDVaUgotkm1wxWlcr1+XMuqHaAPvfYBNGrIBitEjN9704dE0nOEl3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv05Hp3tb1qfAJje9jpG0EX+ahNzopfCZF58bS6kGBA=;
 b=foeQKbh9i1AfXs+7zYikDKJl0gflBR39/QhjnRvHc1EQVNnxl9JQPuJ4RB8tVFy4+XZXBTqr/6XbMrZhIMO9iBhl7NY+Vxxf2+rcaa4mu30bHIodCSMbW61PI+wckbd6yifLeRK21fLtgs/5MXP4T82OggXIH9U3Tuq6IIhjl9DV4CnpLF6oVw8KpuvMG3mDWHP9blMb7yC97gb4pTnvZ0BB6bg5zvTzgPVgHL6ZHQSKdk3N/BlP29UNr4vXEhoYsfPpy+PAhvS8jLQh3fHwu3wUs/unopwY2RHfnQ9m5BO3frxvhiqL46SXsuU7qOl80E7PxPugBA6f6shA1biDfg==
Received: from BL0PR02CA0103.namprd02.prod.outlook.com (2603:10b6:208:51::44)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 12:38:08 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::90) by BL0PR02CA0103.outlook.office365.com
 (2603:10b6:208:51::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sat, 11 Mar 2023 12:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Sat, 11 Mar 2023 12:38:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 11 Mar 2023
 04:38:06 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 11 Mar 2023 04:38:05 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Sat, 11 Mar 2023 04:38:05 -0800
Date:   Sat, 11 Mar 2023 04:38:03 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a89348f-c3d1-47f1-31b1-08db222d7754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjXp/sRiwfUKdWTcMhKKUvfA6gT71l+LMIXnivxE1Czl+k4E+1iTVKd2011Dpkp4qQEgIbNcmC9Ohrsm7BAIfaKn84rFlDfGodfI4RwKPzfJsjaUDlvvpkwYpwK0URNKLWXfihEZguL/SmY2BjekC8ccLOfYT5Pl3pEZHaqf5vcIIiYXfpvwkoWxFiiA8dNXfyR0PmOPZgHiWntTl4THAbXd2kRBAFTF4JcIE5jDZFtkH/vlxwqrVFAR7Ovfa5EzU0n3C+J4GLvk+2jd3N/tupScRq18yQ57tB9WnmeO+QprFiF/XgywDOTcDTME459vSyQX3BdoVwEB7vIY9KqFib6LjKSkDJhqONpXRgS/rtrMyMBlSKdaQjf9VcdDh0FOxArnrGtZ6ZQQuJWQyVy+jY/KZbJ9HT3j9ddFvlrkKja+k6eYLXEPJTLU5GM+fgIgH8naCvxcvQeB29+5mbLvoy3XgVLBHOazJJx28xIxUVP1WIOxx6dsiC9uUuF6KFKuhenztQQLB0ABZXn+VYfR3uT4+mL5Hq7mRiJ+aPhAjQluO2/OAF27h30mTc8epY2XFwuZUxn7Ov0xQ/jHyOQ8pr+R4gyurIMRRDGUEUfX4xl0SbABfHSev/MHBBRW35MwdHIaVVeUCcp/JokVsxEKlPyBBC8wXYfUKSsZGo5d1PcJ9ZimkWRw3DloefSRTLvudCMVFuQalBurSwMzbv38/RnXtoMipHlpQ7teIFN8hFhHDFrB5WWUkyHoSVNId1QD
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(70586007)(70206006)(4326008)(36860700001)(6916009)(83380400001)(47076005)(426003)(33716001)(82740400003)(7636003)(336012)(41300700001)(66899018)(82310400005)(316002)(8936002)(186003)(9686003)(54906003)(26005)(356005)(8676002)(40480700001)(55016003)(478600001)(7416002)(40460700003)(2906002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 12:38:07.1904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a89348f-c3d1-47f1-31b1-08db222d7754
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:53:46PM +0000, Robin Murphy wrote:

> > > > +     case CMDQ_OP_TLBI_NH_VA:
> > > > +             cmd.tlbi.asid = inv_info->asid;
> > > > +             fallthrough;
> > > > +     case CMDQ_OP_TLBI_NH_VAA:
> > > > +             if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||
> > > 
> > > Non-range invalidations with TG=0 are perfectly legal, and should not be
> > > ignored.
> > 
> > I assume that you are talking about the pgsize_bitmap check.
> > 
> > QEMU embeds a !tg case into the granule_size [1]. So it might
> > not be straightforward to cover that case. Let me see how to
> > untangle different cases and handle them accordingly.
> 
> Oh, double-checking patch #2, that might be me misunderstanding the
> interface. I hadn't realised that the UAPI was apparently modelled on
> arm_smmu_tlb_inv_range_asid() rather than actual SMMU commands :)

Yea. In fact, most of the invalidation info in QEMU was packed
for the previously defined general cache invalidation structure,
and the range invalidation part is still not quite independent.

> I really think UAPI should reflect the hardware and encode TG and TTL
> directly. Especially since there's technically a flaw in the current
> driver where we assume TTL in cases where it isn't actually known, thus
> may potentially fail to invalidate level 2 block entries when removing a
> level 1 table, since io-pgtable passes the level 3 granule in that case.

Do you mean something like hw_info forwarding pgsize_bitmap/tg
to the guest? Or the other direction?

> When range invalidation came along, the distinction between "all leaves
> are definitely at the last level" and "use last-level granularity to
> make sure everything at at any level is hit" started to matter, but the
> interface never caught up. It hasn't seemed desperately urgent to fix
> (who does 1GB+ unmaps outside of VFIO teardown anyway?), but we must
> definitely not bake the same mistake into user ABI.
> 
> Of course, there might then be cases where we need to transform
> non-range commands into range commands for the sake of workarounds, but
> that's our own problem to deal with.

Noted it down.

> > > What about NSNH_ALL? That still needs to invalidate all the S1 context
> > > that the guest *thinks* it's invalidating.
> > 
> > NSNH_ALL is translated to NH_ALL at the guest level. But maybe
> > it should have been done here instead.
> 
> Yes. It seems the worst of both worlds to have an interface which takes
> raw opcodes rather than an enum of supported commands, but still
> requires userspace to know which opcodes are supported and which ones
> don't work as expected even though they are entirely reasonable to use
> in the context of the stage-1-only SMMU being emulated.

Maybe a list of supported TLBI commands via the hw_info uAPI?

Thanks
Nic
