Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B775B7C19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIMUOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIMUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:14:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A42E81;
        Tue, 13 Sep 2022 13:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0W9gcGtgouzkcYitQvelVnWUgXV+ergxt+r0hNgYqAaz5b9NV5wYHyZpBTT9JHyViMBwvCCa/eBul839emHv87ND1OAa9iQa6EDzKygyf6njrHAYv6KrLbi4DA8hsTSpddJ9uk0t5rhlmkOMZt+2oU/6Kjs0RGUXif7Rs410IiuUxn/W16gRMju7ZPhS5tE3vQLSM82AOpagiHeCAvzwXI+eI5x8doJL1+FOKAny65sm1wRY7+rrpGeuEkkGxX3HtF0l/GbBK+yHLYrXUJXqBW4N7T3R6bVW/G1C9UspVTQ3ZTJ/jtNjfgYaNqFuJ8gNIU7MnGyjRpGiJr/4yA3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaTwuI0wJ8PsgDH78M0+Kd2G+N13tGAbF0jfExwcd9Q=;
 b=JTFF9CDzl1XNd27BamnFrZlBkpWi9DwK3xvwQQr+i9tK5HRACfqrAbkJ+xiL15njtxmFMtPlmLSGxqScNQpo3a1NmOJfTAAHt4bW1LZRbKd+yIS1iKzAHkApGptPMkOt7ud4fN7LIzXl0P6OFrVAam8UTfRy6uEDx3ykVp2Wkg2JcLPeyyIAtSCpBqPg5RyZ9pzU/m8d8AjF4oFHUXs4AsykkOOv06e6QP8k6TGUOsM3Ik0jEdNQe38ifjbWMLr+biNlQBRMtTNWZUNx1Mulu0jshqhEWdUYtpBALa0YqCI2/agscXRwP9CZpaY3EnARfnSdPGI9BHS6TelGPmJEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaTwuI0wJ8PsgDH78M0+Kd2G+N13tGAbF0jfExwcd9Q=;
 b=N8v4UfDxdAxT9+evl/cLRcJtjFtXRiNIEt5Gw4RptWmafh/9ddMfzobTQnnQNvzn+9obf/KlCOORCYDBeT20IbcBQtDBxBJnby4YL6m8MKtM5msWtHyukMtSECL8k2DSz6AO0W4V8aFTsCLjGlhfvOFFPpAPLiYxAk4DpzMZXymKKhw2ytIIUfwD4o/U5LoSkva6kUXgx2CMztDuPXptn5s4fkJI94d0HwXLGS5cAOBh0sowG6STNgm9YsKXMfekPYdnJmHh0EzmmBR9TrS/jFe6edMdHIwfcv4p4GmHIocYc7ZRjzBDly1YRyyr01n1TwuN245Gpuc2IszkuTav4g==
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 20:14:29 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e6) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 20:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 13 Sep 2022 20:14:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 20:14:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 13:14:27 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 13:14:26 -0700
Date:   Tue, 13 Sep 2022 13:14:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jgg@nvidia.com>,
        <sricharan@codeaurora.org>, <yong.wu@mediatek.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Message-ID: <YyDkoIqWb8fy+vsi@Asurada-Nvidia>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
 <YyB3F/o3RfymqiFW@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyB3F/o3RfymqiFW@myrica>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 4703a67a-e720-4dfa-0d73-08da95c48ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qCaUCdCcKwNBEVKug5omqqSzwtcs5qotqWAWOdPUsiUU+b5X9b9X9FApoisW60BKxnCtCKDG3VAXmlOv3COtXpax9VfS6ssZUxaTs3ZxnyewpwIxhr6ukJtNB8Sc4ACKc3qZMEaBEANkGSyH0yh8zX5sHjs/eFFoskc1Ojc3rQPB5TKD2Enp0faQ4JgggIQfqu7hmsdCnAE2RMokjfEbBcoWxaUwDcsNK/BOroFj1VsoWzMnrtu8g6z8fZTd9Fd8Wod2zHo51tbqo9r9qxJjC2KiJgPYDGXEkVcG0tZwfUWlMIvqG2Kw27eu1775NLfTHH5RE5tEl6y5HCOvElkgPMpd6gDpGjPurJVDhmHNTOXX1khrrCDZjMPbdRpCewO8jVA0ShHR0ce/3vMtrSCHnRqWGfBoQJaJaDWd5gGrYnL9WIW533AU+4R18xYzE87QOvrVgavwvONZbvOVpD/fm7X30EaUSWNFADA6xAlcVgextO0a0bZrj2dHxcxvuYZ9X02RJEJlb8jhOwFVVNmejAi+EN3d0qvzDWx5k29GpOVWHqXWScb1VXc2OTyBKquMWloNtc0Ecs4zeMGOpk+LnRmkeFZ8qYgqPS+GHPrj/IRzPEVm2pr2OieMTADt1JivSXw8HSXhEWTaCut0hnmO8oF3wvqj5sx6qM2x+eP/g9bF4GBWVzj9gQHAngVWn1wN6ryqIkE1qlvxE5b10IOHQphUYSqw94QcHpiwjWA4RSkKaQRercgekqWF7XNkfwhzDcSt85tmv3fBwtdjoVs3pA8WkXwc3k//rKXJ+aY4MQKx1a8i8H0+Xl5TgJojjbIt8n2kcl0y4cX+OlQzkJ/Yg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(356005)(186003)(26005)(83380400001)(426003)(336012)(8936002)(7406005)(36860700001)(81166007)(41300700001)(86362001)(55016003)(478600001)(40460700003)(8676002)(2906002)(47076005)(5660300002)(54906003)(316002)(9686003)(7416002)(82740400003)(6916009)(70586007)(4326008)(82310400005)(70206006)(33716001)(40480700001)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:14:28.7041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4703a67a-e720-4dfa-0d73-08da95c48ffc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Nicolin,
> 
> On Tue, Sep 13, 2022 at 01:24:47AM -0700, Nicolin Chen wrote:
> > Following the new rules in include/linux/iommu.h kdocs, update all drivers
> > ->attach_dev callback functions to return ENODEV error code for all device
> > specific errors. It particularly excludes EINVAL from being used for such
> > error cases. For the same purpose, also replace one EINVAL with ENOMEM in
> > mtk_iommu driver.
> >
> > Note that the virtio-iommu does a viommu_domain_map_identity() call, which
> > returns either 0 or ENOMEM at this moment. Change to "return ret" directly
> > to allow it to pass an EINVAL in the future.
> [...]
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 80151176ba12..874c01634d2b 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >               if (ret) {
> >                       ida_free(&viommu->domain_ids, vdomain->id);
> >                       vdomain->viommu = NULL;
> > -                     return -EOPNOTSUPP;
> > +                     return ret;
> 
> I think in the future it will be too easy to forget about the constrained
> return value of attach() while modifying some other part of the driver,
> and let an external helper return EINVAL. So I'd rather not propagate ret
> from outside of viommu_domain_attach() and finalise().
> 
> For the same reason I do prefer this solution over EMEDIUMTYPE, because
> it's too tempting to use exotic errno when they seem appropriate instead
> of boring ENODEV and EINVAL. The alternative would be adding a special
> purpose code to linux/errno.h, similarly to EPROBE_DEFER, but that might
> be excessive.
> 
> Since we can't guarantee that APIs like virtio or ida won't ever return
> EINVAL, we should set all return values:

Thanks for the inputs. Assuming your attached patch isn't officially
sent, I will group it into my next version.

Similarly, I will also double check other drivers, to make sure all
of them have explicit return values, other than "ret".
