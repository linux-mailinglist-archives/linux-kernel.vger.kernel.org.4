Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3E6C238A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCTVXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCTVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:23:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD7CC20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdwbX/Uu3/o0wrQk1tfoKRTRGeCtDAdC2tP3UrmLr+gFzqufPVUUCI8BCTQ+fHRUy8cYlLMTHK6rg+wMovTFhaRCZe2iizZ/jkY8AOefEnZ8y2TxFlonTtDclep0hRvg2zjqfC01jgnxNW9xqZUAggOVI7Dl6a8Gdq88OfG6shpAB1vVKogW3W+rVDsZBp6VA2xqgVKoQpGJeTR2VMP75vBl6Gp/p1vxLqU1RAJppg7/wLTqbOimLpDsQ4laAVME2b68RqcIxLIdhVVYcFKNFnNNeHPGKjk08XpTNUUsjkDyAsmRhtxWASVSaXRXj8uXVSNsJvqo2kkfTwnsyRpBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh4r40dljqdtDsNbpm4/1s08yi00IAnnbE0xXIU5+RA=;
 b=O7Z1Mt467E5A58h90CbhEpEJTGnTgDR5Gn2hVgY2Doadf8S4NBp6RyrCeuonPbC3i+blB0Q3ZHMuqxhoZaw9Scf4fyWaUP+M3rxIAe7u5LWLnwKMkXynEKkBxaTCwwdKD4i2gSrP48y80KKv4SAcwf4wrIx4YGe9beJxu6KEY2w6nFEzLplNFud9Cv0F55Plp+Ne0MKFplyEoZCVoj2SHt5G/nUKwdi8l6LHuz0Ijtb+NCDmK1wxsBr1lFajLrk4lQYiGyR7fU7XxG8HHEpelZacSDoxktY+m+uoxXf69x+wZ5oYHiID6pOIDYCpKFqJJwkXXfzgSjJC27m9cnVKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh4r40dljqdtDsNbpm4/1s08yi00IAnnbE0xXIU5+RA=;
 b=OeOxAchx9iX6OtRwpVNC4lEtEzugC9hc6qF74Ec0AzHUWJsqfpQjRvjO1rWyCFWpH1irQZGeLWSyJ6ZBD6XMkc4vbdiEqxpaXy8ef1H/RuB/olUX+6/na4U7wFfYWUHtRCPrHMoBjp1T2xNVr7sHl5yLJe8FXc8BTgi7G97duyBqkwjJQipPNE9JauXftqspXFaXsUmatCV4WldQ77+743EIj7TVHS4snPtEQuPv5U6WXgNqSc0MIq1POg0BydewZLhIyx4NWLdpDSkG11UEX0aKljrdsLTi9u04qQxmIgOP8q+IVOZ6rUEl1xv6WSSqHWGUIzgiv1o37yBdlyKiDg==
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 21:22:58 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::9b) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 21:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 21:22:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 14:22:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 20 Mar
 2023 14:22:44 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 14:22:43 -0700
Date:   Mon, 20 Mar 2023 14:22:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBjOooJZcUf182ES@Asurada-Nvidia>
References: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
 <ZBiEE+QLjPpxBjkQ@nvidia.com>
 <ZBiRAVROma5/Os2S@Asurada-Nvidia>
 <ZBip4sbxUQo8RjGv@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBip4sbxUQo8RjGv@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: f24dd966-76ee-446f-6444-08db29894685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYwqKxcDTPXUJXOfr0UcL1hnoH46soOckbqLQq12OFUhMjaUmsONIZPMZ8nEGtNkhVKTCsCQKecy5vJzbapjtEK+cOtQh6hMXI4Zwc02EL/DpK8QwVpiZsaLl9W0PgHUU5AgPKYOXRT0LEsNVv01Ep2YhbZm320sATJDWjMirtCUYhPvaVMvHZKuLXpPGp0nI55LdAUYKWdq+UV9upxIW1i6wHh/jPmcckoMXIbMoyFhngiaf9mYdmR7npv/13y1/cwvUmOKv8HCPqJzuMw6xqdZBcLdIFZwHuvUFn1ZH3sLGFMQBNlUskg5UYSqxpHRD0dJuKDPsaNAbks2Q25d8xZ66ZfLvLXm0O0bq8WX4DgOfwFTEypaC8QIqHR6h52rAo3eUZUvuaHDKohProuk6XaMDnDd6c1ozzwzuI4xAty8HAbYTaKuU7bhwl39xwL49eFuc8SvdG1D1EfgJzvxMKInKp5fh7WUEce5MZ7QN4T3X4Z3+NIcd0bpukQeC9QeNNmASogomgWBVExf1DXyOnZN2fB83bkeGvmD59VMMzWYVCzy/tVNT5hNXV/GIlFjjZn/+p7Y9nlbj6h4loHCNP84+NrHOLj+gfKLk+9GBANWmkV+zO1Oc3sQ3TEvXCQMDNgsznC2QNo9MiyqJZJMP+IkvVH7vtqUnwNwfcNqAGSjtx8yMkxL9MobBzYResEPxZ2wy0kX4j27lSdxboajAP/9PqsUhHlZacISw2fyvTPZSpGBfynKaUx04hAHbUYU0ZIR4/1KGB9PrxgKb7unq9KtC8pQRJzF/a/b/p+KwlrVqoQA/gOKglFc8UuNU/JZ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(356005)(82740400003)(2906002)(7636003)(55016003)(426003)(82310400005)(478600001)(40460700003)(186003)(9686003)(83380400001)(86362001)(33716001)(40480700001)(54906003)(316002)(47076005)(6636002)(70586007)(4326008)(8676002)(41300700001)(5660300002)(70206006)(336012)(26005)(6862004)(8936002)(7416002)(36860700001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 21:22:56.4869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24dd966-76ee-446f-6444-08db29894685
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:45:54PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 20, 2023 at 09:59:45AM -0700, Nicolin Chen wrote:
> > On Mon, Mar 20, 2023 at 01:04:35PM -0300, Jason Gunthorpe wrote:
> > 
> > > > > We need an ioctl for this, I think. To load a map of vSID to dev_id
> > > > > into the driver. Kernel will convert dev_id to pSID. Driver will
> > > > > program the map into HW.
> > > > 
> > > > Can we just pass a vSID via the alloc ioctl like this?
> > > > 
> > > > -----------------------------------------------------------
> > > > @@ -429,7 +429,7 @@ struct iommu_hwpt_arm_smmuv3 {
> > > >  #define IOMMU_SMMUV3_FLAG_VMID (1 << 1) /* vmid override */
> > > >         __u64 flags;
> > > >         __u32 s2vmid;
> > > > -       __u32 __reserved;
> > > > +       __u32 sid;
> > > >         __u64 s1ctxptr;
> > > >         __u64 s1cdmax;
> > > >         __u64 s1fmt;
> > > > -----------------------------------------------------------
> > > > 
> > > > An alloc is initiated by an SMMU_CMD_CFGI_STE command that has
> > > > an SID filed anyway.
> > > 
> > > No, a HWPT is not a device or a SID. a HWPT is an ASID in the ARM
> > > model.
> > > 
> > > dev_id is the SID.
> > > 
> > > The cfgi_ste will carry the vSID which is mapped to a iommufd dev_id.
> > > 
> > > The kernel has to translate the vSID to the dev_id to the pSID to
> > > issue an ATC invalidation for the correct entity.
> > 
> > OK. This narrative makes sense. I think our solution (the entire
> > stack) here mixes these two terms between HWPT/ASID and STE/SID.
> 
> HWPT is an "ASID/DID" on Intel and a CD table on SMMUv3
> 
> > What QEMU does is trapping an SMMU_CMD_CFGI_STE command to send
> > the host an HWPT alloc ioctl. The former one is based on an SID
> > or a device, while the latter one is based on ASID.
> > 
> > So the correct way should be for QEMU to maintain an ASID-based
> > list, corresponding to the s1ctxptr from STEs, and only send an
> > alloc ioctl upon a new s1ctxptr/ASID. Meanwhile, at every trap
> > of SMMU_CMD_CFGI_STE, it calls a separate ioctl to tie a vSID to
> > a dev_id (and pSID accordingly).
> 
> It is not ASID, it just s1ctxptr's - de-duplicate them.

SMMU has "ASID" too. And it's one per CD table. It can be also
seen as one per iommu_domain.

The following are lines from arm_smmu_domain_finalise_s1():
	...
	ret = xa_alloc(&arm_smmu_asid_xa, &asid, &cfg->cd,
		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
	...
	cfg->cd.asid    = (u16)asid;
	...

> Do something about SMMUv3 not being able to interwork iommu_domains
> across instances

I don't follow this one. Device instances?

> > In another word, an SMMU_CMD_CFGI_STE should do a mandatory SID
> > ioctl and an optional HWPT alloc ioctl (only allocates a HWPT if
> > the s1ctxptr in the STE is new).
> 
> No, there is no SID ioctl at the STE stage.
> 
> The vSID was decided by qemu before the VM booted. It created it when
> it built the vRID and the vPCI device. The vSID is tied to the vfio
> device FD.
> 
> Somehow the VM knows the relationship between vSID and vPCI/vRID. IIRC
> this is passed in through ACPI from qemu.

Yes.

> So vSID is an alais for the dev_id in iommfd language, and quemu
> always has a translation table for it.

I see.

> So CFGI_STE maps to allocating a de-duplicated HWPT for the CD table,
> and then a replace operation on the device FD represented by the vSID
> to change the pSTE to point to the HWPT.
> 
> The HWPT is effectively the "shadow STE".

IIUIC, the ioctl for the link of vSID/dev_id should happen at
the stage when boot boots, while the HWPT alloc ioctl happens
at CFGI_STE.

> > What could be a good prototype of the ioctl? Would it be a VFIO
> > device one or IOMMUFD one?
> 
> If we load the vSID table it should be a iommufd one, linked to the
> ARM SMMUv3 driver and probably take in a pointer to an array of
> vSID/dev_id pairs. Maybe an add/remove type of operation.

Will try some solution.

> > > I would expect that if invalidation can fail that we have a way to
> > > signal that failure back to the guest.
> > 
> > That's plausible to me, and it could apply to a translation
> > fault too. So, should we add back the iommufd infrastructure
> > for the fault injection (without PRI), in v2?
> 
> It would be nice if things were not so big, I don't think we need to
> tackle translation fault at this time, but we should be thinking about
> what invalidation cmd fault converts into.

Will see if we can add a compact one, or some other solution
for invalidation fault only.

Thanks
Nic
