Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FD5E5A71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIVFJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:09:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A864BD1D;
        Wed, 21 Sep 2022 22:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex+dlabUwhamq52SBeSuYuzbSsVz3VteM/tj7W3vlln6af99FeqrWZv5vomGws8CVOx4f54i64vKbdUlD2UNKk6uVx0e8xm7jHwViiKJcwSzD/QL/espVuD6xwtWjhVq9mJxIlXj8S/qQp1GBe3hrd+tQhxwgCQ86eHGiqwvWFt7eIkO7nPFFrbncA8gpBwnxUPZkjjjVrbd5xKNEeLIkEIX8hp2Fyow/rd6RN7T5+QAGWUukakJus8FHhBeEVQDjKkfxON+LFSJ0o8oZUA0hZemBxFnONN/QxQ6w8hpoawyGYRfsuF//YptVTOtxZ7y0Vue8DzUhLMRxCX9AE30aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/E2F+s4llk4R5foJ3S+CieZPXBn01PAOjAZ2oSgyIc=;
 b=i4cMBzUIdc0rXsTOGn5Imqi7TDp0myUhl0HVn1V87MyqIAN/Nbd7X5Poryb0PbJz5g+YnHg4fi2KkrFlRhR+yDKh07ESPMBumzOk/rxq0ZJnOY9O+3Onc/beQuO33kpx+wFDRUMInEVOn1lfdlIGqYtkONzAvThQiuJyXhPir/XV5UGVjjTxybC1S6DgRsfkmhrimk7ZOmpf/u+gR3/dsXlKbT66TIcgziLftomOB5UryCjKkTf8ThlBVzco2WKmSnQ2M84cZZbrxWXmtG97KAhmmuTIB1+ALmGVLFT+nKwiELPEqQYvaezbUpzLh+oIiatYLjQ2U4lP9ic1zqAQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/E2F+s4llk4R5foJ3S+CieZPXBn01PAOjAZ2oSgyIc=;
 b=jlV3ioyN1zHQAacDoxTk74B3BaHkJX+dQmNw07atLKb0Nt/Psg88/k/aKyxjlHvTxZ4C5DQZCiil71iL2fP1tZGtx0l7vPANXEO9M4z8scAz2aa0g5Zv41WSKM34xrxS8Mcs1vADrrpxh6549taTL9sKKR+o1Erhs0CtDy3fOIU8FmhAS6CxJdPjZ58JEMXqJtOvNcIQZ6kC58ws4+FPZ/Y/N3VrNIak4mA9Dd15MsipgPEZCu1pbueY06JBRYrdWDcc7ReltP5odo6RqN3cvLFyP27yIZB12ZkglyapLBBFtdlZnz+T38kDOh8P4h13zVaeAzMez6+m1pev/u8b3w==
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 05:09:19 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::11) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Thu, 22 Sep 2022 05:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 05:09:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 22:09:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 21 Sep 2022 22:09:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 21 Sep 2022 22:09:06 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 22:09:04 -0700
Date:   Wed, 21 Sep 2022 22:09:02 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <matthias.bgg@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>, <jean-philippe@linaro.org>,
        <sricharan@codeaurora.org>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <konrad.dybcio@somainline.org>,
        <yong.wu@mediatek.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <thunder.leizhen@huawei.com>,
        <quic_saipraka@quicinc.com>, <jon@solid-run.com>,
        <yangyingliang@huawei.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 3/6] iommu: Add return value rules to attach_dev op
 and APIs
Message-ID: <Yyvt7kBng3iKl56l@Asurada-Nvidia>
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
 <73008702-87e1-688f-b194-c259c9c03caa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73008702-87e1-688f-b194-c259c9c03caa@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: be866fd3-fa31-4a7b-1049-08da9c589aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCs/FevZDzoabU9muvAYs0+8+1yzVMDmtAcqDXsi7G9eXDcaM8Aj/BhE7LcXYn3NeuTDZk02keQ6GPHj8HrNgsggqbZCEzWNaYPMP6yWsE3EvlC0F9dnaL8jaOQJlsdLGRDMkCJY4FWOn5Yzm1V6T0tMWeXtyYjRHgjriGFo1ZRBi9otkzEB4MFwA/0TbxCCj5+qj99+sCzC6uWV6z0vmAilloR6nEXR/jfh0Yhtu2FpP+nt4ygQG6ubsf2P8+u7xOquDxxulf2F7URH53lcog/NCeXl5j/+CwVnWh8EcYNeIAwmDgR0KVtat9oC5pxoXJxIEKmEnw02ZjcTfMX8QMHmJ/uVm5W6IL+ERZ9xhvtGnNIj5RpAKQR4L7mckl0015iQT7q1Ao/epxbdakRO6J3XXV89N/jL0ii+OG1fQa2Ud+odZsOEmqzDTM7yqFDVpXCyIRy47KdbIhBpyh0lQ1HfUvhXTM1zpSM8TrxJQBrxXVGGcDNsudG63O8XGC+CgKqwJVhR2AePysnWa9DtrAHLRDjn3Jmwvk1OSIkQads0Y0YhRo49KdyIsZ0Dm7LqF2OppmWCmo4nxjpX7f1QHnHklpE9Z+NMbWVC4JcbekwDqFE/ZyF+3tY35ZkIlRm5Bxwp1GoN+ONpnS8bLj1AcIgn/5uaaqicv+yioKoed2OnJAiKXV+zNj/nRMzCYQYGI/u64ZaSg/Y5jTO6pCurpvntwnlklAB4qiJ+tP2Bh+6wMnj+Y8HQYi6pKgQTSXFQhLO2wAFzNup6YoHhJM1XTQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(356005)(316002)(6916009)(54906003)(478600001)(26005)(40460700003)(36860700001)(426003)(86362001)(7636003)(40480700001)(55016003)(47076005)(186003)(336012)(82740400003)(9686003)(33716001)(4744005)(5660300002)(7406005)(8936002)(2906002)(7416002)(8676002)(4326008)(41300700001)(70206006)(70586007)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 05:09:18.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be866fd3-fa31-4a7b-1049-08da9c589aa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:02:42AM +0800, Baolu Lu wrote:
> > +/**
> > + * iommu_attach_device - Attach a device to an IOMMU domain
> 
> Normally we say "attach an iommu domain to a device/group ...".

OK. I can fix it in the next respin.

And I'll add your Reviewed-by in the other two patches too.

Thanks!
Nic
