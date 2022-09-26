Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2F5EB49C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIZWem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiIZWeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:34:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7ABB4B3;
        Mon, 26 Sep 2022 15:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1AiWTIHozduWTgnTyl0OQsAYPBqhv7JjzE/i13I1fF0oPUm3XsD1Su4XQIVAHsdh+EGRKG5zMACuyDSdB3F+bGEcpCWD7G6yXMhJG4qUG73BZgO/Zc1+cpqlPD+vphnUP6tRH0GH9IfFmpZWSiM5YDWwBVaHPXh5Khq5FvjIR4UoZGIsZbMxwusV1McOSww/7kmGX+fR4yNQ+Kp/Fl5Kz4YdiPfMM5A7u/+qazYqBkpeWsg4lYZzRd0FFAfdWp46PpimboJOy9XHaGWehJ2mJEiohTH5bLmugv9/VGOOIFPNBISwL9gowA3dy8it9o5au1XsFgBMMBclZ1kfVvlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Dt5eDy1Vf+pnnjXuwjyNi5ezBxl2IO9s1ix0DcVWkI=;
 b=oMEnSB+EKpGHnYO5dal138fAwifxZzIPVy+YZbqhF4AVZ62QwEe37k2OMvWEX8BLbTPdvo/DAsAaDpNMIDqE3dCExtdChm7JPs6yY/mxZjU9aPhrtSe+u2lIhJWSxE7GoHGSSmWjj9q3+XGlrVACd3wfGA949vl9hT333WrlirEGc5QFaalGUvl/55hID79VoBdTpu8cYppTQ84KjErabxHRKrEY1oU/QLtHsDpWL1dIKoAM7ebjHP6XGBjuEIAHuxRRKQXN4WBJyLAl7YZawLlwp344KO1qV6CdjJOara3iMfBJlEHXnvRAo1LYXybwyP+w5mqHvC6hrUFKxgyfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dt5eDy1Vf+pnnjXuwjyNi5ezBxl2IO9s1ix0DcVWkI=;
 b=ni+tJvLwqMfY3obfZncTN6pUsCEXICmZYCRWEt2lPKVmjlHWjAdzb8bjxn3O5aHkAj4XfwmQGnBzPV3ZAzGjqy+wFCYzZmm5VbUKY8frNTpmbeKAO4mXDh3+ng/eFSfYgiX9kaSAASjgpFDLAlRigEzS+JG5qTFHowwqpr88L+HBKrmkvGLLoJyBxWwQwvrocG8wE+BGqO7sH75H9eYzyuyW5UH10FVDxkpZfTNoKnZik4e5srxXBOJqXdcV/iC2O3vXNoEG40aGMDU7cWE5skFvFyoW4AZex+HE+svsXZEpBVgQWAKQhhKe2PCgDLUlz7c5X3yf98mAnZlgKQarKQ==
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Mon, 26 Sep
 2022 22:34:32 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::d6) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 22:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 22:34:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 15:34:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 15:34:21 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 15:34:20 -0700
Date:   Mon, 26 Sep 2022 15:34:19 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <quic_jjohnson@quicinc.com>,
        <suravee.suthikulpanit@amd.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <jean-philippe@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
        <tglx@linutronix.de>, <christophe.jaillet@wanadoo.fr>,
        <thunder.leizhen@huawei.com>, <yangyingliang@huawei.com>,
        <quic_saipraka@quicinc.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v6 0/5] Define EINVAL as device/domain incompatibility
Message-ID: <YzIo67x8Ap6Eiruz@Asurada-Nvidia>
References: <cover.1663899032.git.nicolinc@nvidia.com>
 <YzGZqXCuw6yoXBla@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YzGZqXCuw6yoXBla@8bytes.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: b97de20c-8ccf-4db4-1433-08daa00f4829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFN/Nzc9km+I0zwIlIYMcMx61lV9ByRELvkn0aSypBFeeQMlvSwcDLwWIY12oA7rz4S6tKf4MGIbpujtOZwTvpNlsu9f9oJel3KgmmatuAc8S/r1yxek9RfJofsMjus7Pwy5B3EgzkInNlnjDTLt4wKJRwxR9sWJ7Hp+Mbd0/FysY/wocDaQZJtZqJ3PxK90t3+HBeWs5Db9KTItuq7KdDTMnQ59MgJmfBq6pr25n6tzpt/u1GGbQb0U0tAGMrkMZHhKHyCO+mPHGzWmFU7IDTidwtScOamiVwO5fVvRBw0/6mh9y19Tp4nOF4ynFqWVO/zdlKW5jbEbGw9XLlDs2pVvaqsrh4HZuprvdgwyPjfzVe3D5+T/Pwx68SHErer3gpCBIxf2p5CRCX2Vgc2YSeoCxhJer9yEt8yUxdcZolXaEIjlaKkLRk+UA6vwC5/3w3TMI0kBu/xPldlUyuOA5Xv2h2bCpPKg7iUSuHvL/wAn7389/8ChqPKNfNnsYszoZgAXrsdR9+woyDZ0e1/VNU3qG/+FawPb6g4fC+GVh2BQVLdyFRcFEUxhE9a1h0DQYAAOXUNPOkIqXF7GOh8QVyiykX3u0xToMA0bgmIalkNDeBoE81V6cSILFUPH//kyyR4y6eF5t5FWQ501MiTiEp41hv1hVwoiM68qOIHinxzupFTyFrslWVtgAcaVYpO9zc6Or5Vb3YRfaIU833tnPunnHcpu6WbWu8iMMskELfa7aXNigrWCk2WBo8D7bRmUxJyE62X2ZvXpgfko0EeOPGn0AMmBgdFkfErgbBc1jJfKfU6dsmdldgz7S36/z//VWdOircmlZjCJ+mToyVFpk2YvKsTfl0zIBtC6Vv/wlGc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(40480700001)(70586007)(26005)(33716001)(70206006)(186003)(54906003)(47076005)(36860700001)(6916009)(426003)(336012)(82310400005)(8676002)(478600001)(316002)(5660300002)(55016003)(966005)(7406005)(7416002)(356005)(8936002)(82740400003)(2906002)(41300700001)(40460700003)(86362001)(9686003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 22:34:32.0858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97de20c-8ccf-4db4-1433-08daa00f4829
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:23:05PM +0200, Joerg Roedel wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Nicolin,
> 
> On Fri, Sep 23, 2022 at 12:16:29AM -0700, Nicolin Chen wrote:
> > This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
> > https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/
> 
> \o/
> 
> > Nicolin Chen (5):
> >   iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
> >   iommu: Add return value rules to attach_dev op and APIs
> >   iommu: Regulate EINVAL in ->attach_dev callback functions
> >   iommu: Use EINVAL for incompatible device/domain in ->attach_dev
> >   iommu: Propagate return value in ->attach_dev callback functions
> 
> This looks good to me, but I'd like to have the SMMU people have a look
> at patch 4. And I think it is too late for this to make it into 6.1, so
> please re-send after 6.1-rc1 is out.

Robin has given review comments against the similar patch in the
EMEDIUMTYPE series, though it'd be nicer to have a Reviewed-by.

I will re-send them rebasing on v6.1rc1.

Thanks!
Nic
