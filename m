Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93B36C089E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCTBh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCTBhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:37:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F94241DF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R12/OxuTkAKUerYWbbQoTK2ZUWv3Si23ER8IQ3v6/Hs56mNP59c5To+WrL6K5zayEzMwG/2VyMzTvBYBDpOd3YbmKQMAfFV5dEA84nuCsvPqEzXqjT18cFr3Yn6voXrKDJt0F6/9drn/M75dfyzFhaeaLAp7/nAI4u5C87cfd366ZLuHlXd+kKydMKNc2KXaEB8vwY3ANK+ZFMm58PGbmN+2wkWir7dDTm6wpbrFSmvR15k+MEvc+7NOWp+bHDdh5LUxErwSQe4XyUgtbcDMMEyqHsJ8EnVqEl3tWSHqE3hQwcGRpMdmKXT2WeXnKhD4ef9EkZq/uGD1o6yiqlYi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59+w5sOrVoeY9p4fkjepTQfAwFyBY1xNZpYMXWbHAfE=;
 b=RKzsH44MVrT1Yu0ZtEt5Iz3JNTmGK2hCteXXb88kzAqLVT0gReo2602n3VBx7MYZR6MFt9igraLYNHPX7i1v3k5Zc0fuGbOT+wltZCHzXpKmQoVXlYIrX3V8nOYwSCBSCDhwCNp/ufv5+2KM7n1XJIpOvCzPhCOqx/Ll+iE0hBQnUDBlsUlP1+QtvHZgFbjtLXKjjNPgXPzDgTMmrdFzi6zxcWggaBz57W/B5TfdaY7iKO7xqSCgvXqu2gLFQ0emOGI7VOC7nh63SY4sepS0/J410eyloFj03Pt+dyIc/vcCrQ8ucKv93D0UgtXP/15ZK4V2rlkMrMVBb7N/N1+7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59+w5sOrVoeY9p4fkjepTQfAwFyBY1xNZpYMXWbHAfE=;
 b=h7CDfF8XYqsIIku2r1S76go2nDc6qj3XIvdudEeaxznpAV6tqb4aPNGulDiS74n8ZSD2nV8LPn+79YuyovHYQNIlXQ6GmakYHOe21/5l/iRBgMQnUqHvZdIoIyxVBEp2rVv3QlJyliEyO4XkWhBnvxe7KzbQYGIPRlOJG3sb0ypINRS2imIV6QzZ7dwM+jFsbsHHQd2ne0p+6PrgPfJC1+OEQZh0cOsPN7yhTay7Rrs1IPxiR8jxjgOTSJ9JSP/xS9FmUAyogp0mISc7liTtf+msZVKxRmwQsgfkMvqPGtDyYy4wl1UqkNKsR1k+iXPlNoEhNYG6cQbqbOLGCriBig==
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by CH2PR12MB4938.namprd12.prod.outlook.com (2603:10b6:610:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 01:32:10 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::dc) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 01:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 01:32:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 19 Mar 2023
 18:32:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 19 Mar 2023 18:32:05 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 19 Mar 2023 18:32:04 -0700
Date:   Sun, 19 Mar 2023 18:32:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBOFcenanpRsGFzF@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|CH2PR12MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: b436d344-0e4f-4144-b062-08db28e2ece9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0JYfezy4J5x//tL2Dmr9/KmQe2D7F4muhj53cJDI7/ZkhFXSLY4lQIqr0Gesr4Ahhou7ikVzpsqJb4d4f9tEiumlcGsghWfBBV3Niw9iIzrxXCjXnu1zFgrOi7ZShYIPKJqWhw6TCTDptnmBjWly3WwwFyOtLePvybHmGqSr/Q/rgcuTtPXSXQRdDIhp+YHueZmyZkv/IJIOEon6BpRoX+SRoIlVJ2zE5bmpERNyOMaxWb8Cz7+H6ugocdAtfce9mMnePil+ELZ2oNuPxxtf9KMOV5trGxHVd/C0xGX2XWkzoR39xaxim/zWJPPAx9vNZ4BArqiB6KIts9gvjwF9xVe1/Xmj+bqfu1qkU/zxKk3PzySyBTw3/jAXlR92fnKZLlCHkih89ln5RlgrlaLst+9yQg9C6Avv4iPFaJ7CHalYa6tmgYhe1IMdu7eSIgNn00T7r2s87cgIHuZQg3e2q/CX9V6JLkSDrLmji9EXdLZAb1AO/gqlQM3D1eq6l0Lh8Ok8OjGcU8Yc/B71H3g1u38PLzNjm6nrbWrHIpv+cmpQVgw714TmDBck8HzLe7e6EWpLKvpvu/KbKYsMwxdr7bZvLK8iLxV2ohTIePrugy5qJKtcvHMEkww95fmig4C5qdZwVm02T3QdJOMpKVxRaKblOTsqvi4d9OV9OJrMR6+Er8ivSl3/IH0d5vzoUuIq1H+O/MbXGGfM1476f4j4DoTMsqb+lXo+Hm7nafeoyimJ8/fUHFp1Si7WrCPUbEw
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(33716001)(66899018)(426003)(47076005)(83380400001)(82310400005)(316002)(478600001)(54906003)(9686003)(7416002)(26005)(186003)(356005)(55016003)(7636003)(36860700001)(40460700003)(336012)(86362001)(2906002)(70586007)(8936002)(70206006)(5660300002)(6916009)(4326008)(40480700001)(82740400003)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 01:32:10.3483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b436d344-0e4f-4144-b062-08db28e2ece9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:09:08PM -0700, Nicolin Chen wrote:
> On Thu, Mar 16, 2023 at 02:58:39PM +0000, Robin Murphy wrote:
> 
> > > > > > I really think UAPI should reflect the hardware and encode TG and TTL
> > > > > > directly. Especially since there's technically a flaw in the current
> > > > > > driver where we assume TTL in cases where it isn't actually known, thus
> > > > > > may potentially fail to invalidate level 2 block entries when removing a
> > > > > > level 1 table, since io-pgtable passes the level 3 granule in that case.
> > > > > 
> > > > > Do you mean something like hw_info forwarding pgsize_bitmap/tg
> > > > > to the guest? Or the other direction?
> > > > 
> > > > I mean if the interface wants to support range invalidations in a way
> > > > which works correctly, then it should ideally carry both the TG and TTL
> > > > fields from the guest command straight through to the host. If not, then
> > > > at the very least the host must always assume TTL=0, because it cannot
> > > > correctly infer otherwise once the guest command's original intent has
> > > > been lost.
> > > 
> > > Oh, it's about hypervisor simply forwarding the entire CMD to
> > > the host side. Jason is suggesting a fast approach by letting
> > > host kernel read the CMDQ directly to get the raw CMD. Perhaps
> > > that would address this comments about TG/TTL too.
> > 
> > That did cross my mind, but given the usage model, having host userspace
> > give guest memory whose contents it can't control (unless it pauses the
> > whole VM on all CPUs) directly to the host kernel just seems to invite
> > more potential problems than necessary. Commands aren't big, so I think
> > it's fair to expect the VMM to marshal them into host memory, and save
> > the host kernel from ever having to reason about any races or other
> > emulation details which may exist between a VM and its VMM.
> 
> An invalidation ioctl is synchronously executed from the top
> level in QEMU when it traps any CMDQ_PROD write. So, either
> packing the fields of a command into a data structure or just
> forwarding the command directly, it seems to be the same for
> the matter of worrying about race conditions?

I think I misread your reply here :)

What you suggested is exactly forwarding the command v.s. host
reading guest's command queue memory.

Although I haven't fully got what Jason's "sorting" approach,
this could already simplify the data structure holding all the
fields, by passing a "__u64 cmds[2]" alone. A sample code:

+struct iommu_hwpt_invalidate_arm_smmuv3 {
+       struct iommu_iova_range range;
+       __u64 cmd[2];
+};

then...

+       cmd[0] = inv_info->cmd[0];
+       cmd[1] = inv_info->cmd[1];
+       switch (cmd[0] & 0xff) {
+       case CMDQ_OP_TLBI_NSNH_ALL:
+               cmd[0] &= ~0xffULL;
+               cmd[0] |= CMDQ_OP_TLBI_NH_ALL;
+               fallthrough;
+       case CMDQ_OP_TLBI_NH_VA:
+       case CMDQ_OP_TLBI_NH_VAA:
+       case CMDQ_OP_TLBI_NH_ALL:
+       case CMDQ_OP_TLBI_NH_ASID:
+               cmd[0] &= ~CMDQ_TLBI_0_VMID;
+               cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, smmu_domain->s2->s2_cfg.vmid);
+               arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
+               break;
+       case CMDQ_OP_CFGI_CD:
+       case CMDQ_OP_CFGI_CD_ALL:
+               arm_smmu_sync_cd(smmu_domain,
+                                FIELD_GET(CMDQ_CFGI_0_SSID, cmd[0]), false);
+               break;
+       default:
+               return;
+       }

We could probably do a batch forwarding to if it's worthy?

Thanks
Nic
