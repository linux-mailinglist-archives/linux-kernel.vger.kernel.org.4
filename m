Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86885B8E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiINR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiINR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:58:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8983BC8;
        Wed, 14 Sep 2022 10:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmNdax0qEWkAxfcr/I8C+sjwFrnbTeqp9W7ighHJIcPx5YgsRq4NDXfU2IPw7uBwWRBI8Hno6xlKqiN7AtYnjJPZHMArUGExHdtqk6Xr4PiAFRMHqTY4hfOmUonYCvrvqFEx9zVf+KL83HEzxInjAD5FESyHR5wi9HSBpH1BJqDaSnXYaoxFjqBSvY6seootFu73v9eP/4rmo0J7NbAN+n2ikDMqSMVLr+t1/Os/p0o444MNu7ydpjLOkFg7sehO8BbohYNXBdjhDvPUZdBY4rYHSL/Q6SGeJRx9V9lkHcFq6HF9w2QIw3Cl9BSKAs4w9AvZoVBMiyCuyhWUP/QfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhEDLnyAed1XbDWQZvuwYdpfPEqiEn+SuWCDdfZC7Bo=;
 b=RMIhmXJBcp3ZLtZ0AFePnCbKqQIX+LwS7XEomk/DRkSiYHQTwP4iztb8R1tiick2PgQVT+yx10JaEvRfIvzmEOkq8aBKKd+VgErhbQE2mV55Pxx/kRU3MEgrWD1Jo7gGErRf5lWlKhQBwaLk+WdisvOhpJj2EqKIivesQxAibLI7I04T49M0w2al0IKfATENpkBsu1RrrBj+z6lujC0qOIrb5Pyc2VpH53gmQuK3ulyBm5wH/epm/gP4FjH6E383tDaQYXacr143cUQa20ZvaU2c1GVQYdLr73+g18c5LXY8j3JwmNUGpIgIUxz6dsDdXtF5hYJEbRyZMKVHZa1OrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhEDLnyAed1XbDWQZvuwYdpfPEqiEn+SuWCDdfZC7Bo=;
 b=knLEzMLNTbpBNjFGBsc9QdsMPC5wGfDv1f87L23XytJFf97rnOgQqrdOXayXg0omfUg4J6ryrE7qsRgjWCZp3zvpv0dBuMd1FwoEmYN1j9oMU0jcJ7Zj9ijrr+MEt2OenXEmm2A7csijTdhqyLGapC/gADK7imd/EQev9cKbuzvUiCkXrDWq1QxwrZ9WTWl/T/xwE92t4PPQMh/IT+mJ90kEk42raQ5n+EIaYiuUrCzzF1rYe9nQ93iARjXcY2jXgBNOysXdhRweCk7gpASjaruHZgtPOR+dnckaFGdRE07Q2cvVOhekXfRM/Y2abXYKLjN4+o2hkbtGh4KG0rCpfw==
Received: from BN0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:e8::23)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:58:52 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::76) by BN0PR04CA0048.outlook.office365.com
 (2603:10b6:408:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 17:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 17:58:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 10:58:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 10:58:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 10:58:30 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 10:58:28 -0700
Date:   Wed, 14 Sep 2022 10:58:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <sricharan@codeaurora.org>,
        <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
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
Message-ID: <YyIWQ6rX6AR9KX5E@Asurada-Nvidia>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
 <YyB3F/o3RfymqiFW@myrica>
 <YyGaqsXSDMn8R12R@nvidia.com>
 <YyGjtsB2Yq4fQICS@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyGjtsB2Yq4fQICS@myrica>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c649da3-c755-4818-22ab-08da967ac7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u1Gd2VASnQoiNDd/j4N1JkMz4Zq6CkhssDo7b8L8D5IeSfUyoXVzPddWGghC1lw60liB1SahMCBP2NYAY6IiTP7ms18KbqH3lIqupnkM8Imgci5hw5ZYV2BNsOzRbERD9eTxU1IFNzwPPGpNPa2yYFPpMSLDBWS6tqDII00boRmhI3PIkgT0YRtpwwupHnXYQTmLDE+VBC9zOmO2RtrMGdE26o8JsFKJyFmbV8jxmI4xO7RCT19gs5Cpl3rihGdciF0uhj+hvprG4jT13L2Gj4UaoPC2rA7QCb19FOvpo9mMQDUAsw0tGHj8BCbOvcFP1Z9yvJeDEQtr3jwlCfvCEelrByiZ7iBw1VY/p2RcsmB99WS76mhNe0SRBSz2YBIc8XG2CokyVQ8JXSKcifr5+JEUMpWvO1k89Qt2lPZRgdDzoZ3Bb7lvqO/mxEjIa0izB+NEmy4uCsLwnfZdPcGAx+iPMBp3HV1Sa8b23xQbiBYfOC9Er4xd6C7UhKR+N6/s7PrrigMLR20ctYtJ+bOhk1RhddEoypJah1A4KMcIcutm4qfknJjIxMbu/kpO+FAa2ddAs8iGM45DV5WPIWorssHXgurO0us+jnzSkWMsdVClySorgIk2Hfa4TtHKmVY95359LRbNQwR3/Hl4XXWXfwE6jo4wSu2ZDEuYGB80y9MRP5VhN5cPq3JJhxr1JPp/kAWPdPV3OgRVMvYmFKc9nj6exkwNF32/TbXY5ZDwQKSwQn2t//3vEuonp0XKf8yrI64SnOb/CrZ3PMg2TWJig==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(54906003)(55016003)(7416002)(356005)(82310400005)(70206006)(7636003)(40480700001)(7406005)(8676002)(186003)(478600001)(5660300002)(47076005)(83380400001)(316002)(4326008)(9686003)(70586007)(8936002)(36860700001)(336012)(40460700003)(86362001)(110136005)(41300700001)(2906002)(26005)(33716001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 17:58:50.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c649da3-c755-4818-22ab-08da967ac7ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:49:42AM +0100, Jean-Philippe Brucker wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Sep 14, 2022 at 06:11:06AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
> > > I think in the future it will be too easy to forget about the constrained
> > > return value of attach() while modifying some other part of the driver,
> > > and let an external helper return EINVAL. So I'd rather not propagate ret
> > > from outside of viommu_domain_attach() and finalise().
> >
> > Fortunately, if -EINVAL is wrongly returned it only creates an
> > inefficiency, not a functional problem. So we do not need to be
> > precise here.
> 
> Ah fair. In that case the attach_dev() documentation should indicate that
> EINVAL is a hint, so that callers don't rely on it (currently words "must"
> and "exclusively" indicate that returning EINVAL for anything other than
> device-domain incompatibility is unacceptable). The virtio-iommu
> implementation may well return EINVAL from the virtio stack or from the
> host response.

How about this?

+ * * EINVAL    - mainly, device and domain are incompatible, or something went
+ *               wrong with the domain. It's suggested to avoid kernel prints
+ *               along with this errno. And it's better to convert any EINVAL
+ *               returned from kAPIs to ENODEV if it is device-specific, or to
+ *               some other reasonable errno being listed below

> > > Since we can't guarantee that APIs like virtio or ida won't ever return
> > > EINVAL, we should set all return values:
> >
> > I dislike this alot, it squashes all return codes to try to optimize
> > an obscure failure path :(

Hmm...should I revert all the driver changes back to this version?
