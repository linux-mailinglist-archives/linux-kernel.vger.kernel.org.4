Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500286B56BB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjCKA0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCKA0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:26:01 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2F147749
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:24:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWVX1FFQ49hjC3jN3IxIFUmcqo9MPe9tGKrAa4kROd/ymS7VmyrAwqJp2/AwNt2ZJrbyr/aWSHiMJMYGwaWPpUMSPH/nGjKPvfrq8N54W3wr5ApQRJ2fhbzlqMUxPGZgCsiKEkp55K9KC9jD+n39jAJzozI+3NEUaalXwdg8IkYjo7clC7LUjBXd5RvMmbUWLATPZ/sXorcyIkYdJDrbXGZJSHC01bIzO+jzAAeyW8wNSTWZ0a3T9mkI1FtLaXWVI0kfO9UhgYaEQog5J0fqz/zBZ31rN52UG/Pg6wPpvWLX4+sw95iXUSN6GtAGTYMGxR7Y90AJehVLnJsCMbgOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIZnbyoiO+81AffYjOx+iIIwG6aSRwK+TS95M3QlhkI=;
 b=O0lm20JK2bZIoEqlJ74DQY47ZEZUYspHYx2egh2MFMV2atWkbuQlwnECi8oZAcAyGxhl9AFlOEJZiFjIJKHXc5SQYNLTEyjM/l7YIKx82GCMq9mkM164BF/dV5ZXjLbSARSn/S/CCRPSc8VRM77vX6MyaMI4J+m8NDft5+6lIGbPsCnIye1qsBG6SePOXYGdLpyPOjEdKvWcxdtUjrnZfiV7vGct/gNZhbtE0aD5YLLOZtngxVRLFNEBeFO8bxPzY/SSDYmCvFv4EPGhxx4jvoB7q2oJV0QRhSn2ZeXHKslkXLCBTdoaVmznsAhgFYwkhz2q6DcF4pomN0Z8gzhmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIZnbyoiO+81AffYjOx+iIIwG6aSRwK+TS95M3QlhkI=;
 b=p1F+vyuT+cU0lDWTgo8zXJ6He8BaYwbCJk95CWaOfZxD392qcjKvmydRLNYRmsmtIWcjXMNNpi3gsEfU8Zs/+TF3Il+kkWJ/K7SpfzdBneVdcme6Isuoofso/b3vHfz4e+oRsxzkX4szG2Pq7WknzdlF5M48SKx6hKQK7ACFHPC+zsRDH4QPAvc2SHiLPfr+fbPGB+zPdbatNa749LzcCxCBRCiFKZjPyw95UlRn0qoBmZ5LUPnIs8ikMMjhZxu5TCpSvamNqpLH0EvNedNl9knKw7eKhYisqx0GJ3IJJ1/Xm86Q5HPgWwgcGouFPHoB6qnTx72hSyG+gDSJ9TczRA==
Received: from DM6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:40::32) by
 MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 00:23:40 +0000
Received: from DS1PEPF0000E646.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::4b) by DM6PR03CA0019.outlook.office365.com
 (2603:10b6:5:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22 via Frontend
 Transport; Sat, 11 Mar 2023 00:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E646.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Sat, 11 Mar 2023 00:23:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 16:23:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 16:23:27 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 16:23:27 -0800
Date:   Fri, 10 Mar 2023 16:23:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 05/14] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Message-ID: <ZAvJ/d1X7vMq3j65@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <c62c9405ff31ab3c97a9165ff710dce68217fe22.1678348754.git.nicolinc@nvidia.com>
 <1c18d68c-a20d-0f6d-4bf7-56f40557d151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c18d68c-a20d-0f6d-4bf7-56f40557d151@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E646:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d1f930-4084-4816-a496-08db21c6dd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0Gdqz2/dNIj+hv2cgg0T5i8YsHZ0UExJo0iyLpgEkHXBRFGujVCS/bMPixf5M4ddiutAlFI4KMtCzjSmH/4i4+0StHh7EWfBSmhODaF3YbmSUz7eQ+6OLA8NdONMxy/vELytKns55wuTo+iHRwDbwD25ZOACbxF4vUe+NWPoth/XohfUl9MLGsX1MDEWSsQG1fRN8luq5XjRZmXYC0ldEYUaMVzyQpf4zMYuRJZuBsuGx+0GZujDe1n2wd4lz299DrjTvn2jyuBPlbDyBgrpl/GZ6H/nIFH/iSPUza52g2yX0WdFLPDfvjiQrG3OG20zaHhZeS3ug6hHhP5b7xdaRz1wP2JDC3Xe3NGs+jBQalIcrZhlEghahUA8q0bD1VCgUdQPm9cpRimxXYnkqBI4jzTOOpc6CrMpHovZRyojDYQDBK+IJzOgdlOZQ73PbtG6yFuPlf0f7nC9ljbYrH1wnyvx9wjE8nbmb89f7MW1unBlfw1S9UBqQ4eblz0IffAmutiWw9pMmTzq5szak9H5oORFIcCMriDQrOm/FoWPhVc3UQUEbEvnncR9i0M9UWUCtc7pQK6u0ovUPhQ50kcECsA22/gfbPCSmH583W3W6vJXmpSvTw/MxO2cpGoPCckTDkkO8uZd3qBB1NtWt7//JLx+oTuQ8++PtXK1fFXg9xjcUkNZxf6ZgnKFkUqUb4BoVUDGoz5qADqCI1fr0lMl6Cfv5uwhWn5hFxdqwKdR69w44wnmpANi33Z8O7RKsKp
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(47076005)(426003)(336012)(54906003)(40460700003)(356005)(55016003)(86362001)(26005)(7636003)(36860700001)(82310400005)(53546011)(186003)(9686003)(33716001)(82740400003)(7416002)(316002)(5660300002)(478600001)(6916009)(40480700001)(4326008)(2906002)(8936002)(70206006)(8676002)(41300700001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 00:23:40.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d1f930-4084-4816-a496-08db21c6dd86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E646.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:39:22PM +0100, Eric Auger wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Nicolin,
> 
> On 3/9/23 11:53, Nicolin Chen wrote:
> > IOMMUFD designs two iommu_domain pointers to represent two stages. The S1
> s/designs/uses?
> > iommu_domain (IOMMU_DOMAIN_NESTED type) represents the Context Descriptor
> > table in the user space. The S2 iommu_domain (IOMMU_DOMAIN_UNMANAGED type)
> > represents the translation table in the kernel, owned by a hypervisor.
> >
> > So there comes to no use case of the ARM_SMMU_DOMAIN_NESTED. Drop it, and
> > use the type IOMMU_DOMAIN_NESTED instead.
> last sentence may be rephrased as this patch does not use
> IOMMU_DOMAIN_NESTED anywhere:
> Generic IOMMU_DOMAIN_NESTED type will be used in nested SMMU
> implementation instead.
> >
> > Also drop the unused arm_smmu_enable_nesting(). One following patche will
> > configure the correct smmu_domain->stage.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ------------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
> If you go this way you may also remove it from arm/arm-smmu/arm-smmu.c.
> Then if I am not wrong no other driver does implement enable_nesting cb.
> Shouldn't we also remove it and fellow iommu_enable_nesting()?

We had a small discussion before this community version, where
Robin mentioned that we can remove that too after the nesting
series gets merged. Yet, I didn't want to touch the v2 driver
with this series since there's no nesting change adding to it.

And a few month ago, Jason had a patch removing everything of
that API from the top. Perhaps that one can be resent after
all?

Thanks
Nic
