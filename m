Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9A5B8FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiINUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:55:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD972ED3;
        Wed, 14 Sep 2022 13:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NseF4qWINJNbdOFlXYdlMnc2n9rlnQsoDjb0pDuR1ZYdt3z/gSe9bjY6Zj5mc8p4rotUvphHKVMCuZq0nOOHlZ8AVBuG76jr0JfRKPnk/Y3HQuUWwu2uaNVv7hwfNXbBqv3kr224xOQinzTxSdxPxgDvBa0LFULCfW9JVzBpcDFtxa/GlER4S7F0X4GqvRiGezSgT9Lxr7sb3GT1CF3cLLPefMUr3knGefWoI40yG8MfddJPkheAvPhR1A3k5zsfBeLSw1n9pChWr46y2PJ5ggK+r3SyK48AZYPPhsqWSCQSfrTp7nCexip+iRtyAXMbFt+ulroTP0TePeefKYvGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MrNWONtzhKXiENWB2WK+9D25r0wj9sBSpYtVTAguhQ=;
 b=NgVB47fh4hIJlBqIiXRmItbS7PBvCqrzkgQ4kn5cia9MBz3A4BleWwgb87d+UUayY/KU3jOmMA6E3dWbsMl+SvefjgosQEnshWyGkLMotdtSGVlMe3PrFr/EquqUb2jbEUoU73bqUo226133D4ckQNDzOZwi1U+zRQ79Qq/P53SLwcmQLKZX+rnWJzswgQQWQ3UP4zahxsaSwUX5wcYNzH/AKnkyhzDmut68bbBWky0fNUtZUf9L0n39mkhqrwzyHqixxk4+jd7IBEfTEYB2k8DSheYYRMv7IhExw8nNCV5M4EeYGTOvBMWe4mIAV7Z2o1tuy+3uPwFtlsOZDkWO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MrNWONtzhKXiENWB2WK+9D25r0wj9sBSpYtVTAguhQ=;
 b=TGOCK9MfpOtplPaGLkYrnE3UybAsIuwEuXQ9tXRq7kzFfYO+DFaCf+QRCIoWyAZxv9qFuB5WdfbE2pLQQQadnJQ5Yo3km9KK01ihxwVQ0okGUMm4rl3fd1W35740WTLoH63EZ59d3WIiEdCCOl7ntiNaR/XmldSxBkup7Jw1uTylimdK+1NepwdJFi/2dUi4c60rH4yzVsXpoY/NUXPPnhlSn8A2BBjPtiSuNEruUkwWeFtjaIDNy/pQaq4pjwCw9/rxzBpWAVTLICqvm58hRSrE1N/UY1fQa5wYv1z3PusIaZJO6NgpvryldSVbj7bGTI9i6AYIO4LxdSvdJDxIqA==
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 20:55:26 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::68) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 20:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 20:55:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 13:55:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 13:55:12 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 13:55:10 -0700
Date:   Wed, 14 Sep 2022 13:55:08 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robdclark@gmail.com>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <matthias.bgg@gmail.com>, <heiko@sntech.de>, <orsonzhai@gmail.com>,
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
Message-ID: <YyI/rLRu1qQ57LM0@Asurada-Nvidia>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
 <YyB3F/o3RfymqiFW@myrica>
 <YyGaqsXSDMn8R12R@nvidia.com>
 <YyGjtsB2Yq4fQICS@myrica>
 <YyIWQ6rX6AR9KX5E@Asurada-Nvidia>
 <5f049bb8-76e6-901a-9f8e-b48d270bc4a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f049bb8-76e6-901a-9f8e-b48d270bc4a0@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 37464c23-4ea2-44f6-a788-08da96937336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFYiVF9rjky36BTr9CulQLvdOrhn2kFapkMMigQNjatMhqAQXKQ7doria7++uAD5b5WQSpGSBNSfxUPtSYNB5Tt1tRzmoFx3s10Lz0ylhXkhJiNdBT/FHcGCAYUAxj8DxClzaXzuon+1vHOeWP/l0yuVyGaipCrVGJTfO8ctDdee2idUB/bf3NuuaSEFKs0uVir6GW4Vx/sUDkSHSY5FEQahB9P4JvnBZqDoj+o3fW1IhLgSstsIqqbD92gB4X8AvLtfy9bd0eWd/a66TdZyVbKF1fz5njtWhs7MK2++N4hq4cJHyCbU1WqQDhbT7sNxQNDHvKTxiKuiQQ2zrw2yp47B23zfrgX5FjkdFJLp2CDyhc5nCCEGmyn18MVB0bTX4H49r2qVHYV9e7VilTZrslgoEeVtohAhW4TMCc+Bu4NDymNDXXo0B91+4j3NrRD9q6KtIOMDaAtDuwBgezQd2MwAISPePm2nRYCD7ro6jjpIE0nHSdTvqs13+21YgGv8ryN8zYx1Ij2esD3ovs8QBlwF2hW6XGFhS5E+s2FNDMv7A11IJB4VxLsk4V+KD12/z3r+bc5OYKOFhtiw9HJ1LCMPzvk0semrXGB6Aaz+4bkdvcQkdkreAWBO/j+DtT4yNU+koBB+qECjnjnGFyhBYpWMUr2ac5MQJNjtxXakTd5jVrFYKGwpIqNxi7yiKHeN5WIuDUkt0ZfUQ/DA3GIuqu+4WeQE/XBuP9gRpTBpuR1AL91vOkjAvJMWRWdZULq3xB6gqWwICvJ0zL2N8t8E1g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(7636003)(40460700003)(336012)(2906002)(86362001)(33716001)(70586007)(82310400005)(316002)(53546011)(47076005)(54906003)(36860700001)(83380400001)(9686003)(7416002)(426003)(26005)(478600001)(186003)(5660300002)(7406005)(70206006)(8676002)(356005)(8936002)(82740400003)(41300700001)(4326008)(40480700001)(55016003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 20:55:26.2104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37464c23-4ea2-44f6-a788-08da96937336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Sep 14, 2022 at 08:53:07PM +0100, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-09-14 18:58, Nicolin Chen wrote:
> > On Wed, Sep 14, 2022 at 10:49:42AM +0100, Jean-Philippe Brucker wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Wed, Sep 14, 2022 at 06:11:06AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
> > > > > I think in the future it will be too easy to forget about the constrained
> > > > > return value of attach() while modifying some other part of the driver,
> > > > > and let an external helper return EINVAL. So I'd rather not propagate ret
> > > > > from outside of viommu_domain_attach() and finalise().
> > > > 
> > > > Fortunately, if -EINVAL is wrongly returned it only creates an
> > > > inefficiency, not a functional problem. So we do not need to be
> > > > precise here.
> > > 
> > > Ah fair. In that case the attach_dev() documentation should indicate that
> > > EINVAL is a hint, so that callers don't rely on it (currently words "must"
> > > and "exclusively" indicate that returning EINVAL for anything other than
> > > device-domain incompatibility is unacceptable). The virtio-iommu
> > > implementation may well return EINVAL from the virtio stack or from the
> > > host response.
> > 
> > How about this?
> > 
> > + * * EINVAL    - mainly, device and domain are incompatible, or something went
> > + *               wrong with the domain. It's suggested to avoid kernel prints
> > + *               along with this errno. And it's better to convert any EINVAL
> > + *               returned from kAPIs to ENODEV if it is device-specific, or to
> > + *               some other reasonable errno being listed below
> 
> FWIW, I'd say something like:
> 
> "The device and domain are incompatible. If this is due to some previous
> configuration of the domain, drivers should not log an error, since it
> is legitimate for callers to test reuse of an existing domain.
> Otherwise, it may still represent some fundamental problem."

OK. I will use this narrative.

> And then at the public interfaces state it from other angle:
> 
> "The device and domain are incompatible. If the domain has already been
> used or configured in some way, attaching the same device to a different
> domain may be expected to succeed. Otherwise, it may still represent
> some fundamental problem."

I assume this should go to kdocs of iommu_attach_device/group().

> [ and to save another mail, I'm not sure copying the default comment for
> ENOSPC is all that helpful either - what is "space" for something that
> isn't a storage device? I'd guess limited hardware resources in some
> form, but in the IOMMU context, potential confusion with address space
> is maybe a little too close for comfort? ]

How about "non-ENOMEM type of resource allocation failure"?

> > > > > Since we can't guarantee that APIs like virtio or ida won't ever return
> > > > > EINVAL, we should set all return values:
> > > > 
> > > > I dislike this alot, it squashes all return codes to try to optimize
> > > > an obscure failure path :(
> > 
> > Hmm...should I revert all the driver changes back to this version?
> 
> Yeah, I don't think we need to go too mad here. Drivers shouldn't emit
> their *own* -EINVAL unless appropriate, but if it comes back from some
> external API then that implies something's gone unexpectedly wrong
> anyway - maybe it's a transient condition and a subsequent different
> attach might actually work out OK? We can't really say in general.

OK. Then there's even no need to convert EINVAL to ENODEV.

> Besides, if the driver sees an error which implies it's done something
> wrong itself, it probably shouldn't be trusted to try to reason about it
> further. The caller can handle any error as long as we set their
> expectations correctly.

Yea. As Jason remarked, a wrongly returned EINVAL would make things
a bit inefficient: VFIO/IOMMUFD would keep trying attach_dev() with
its existing domain list and a new domain but fail all of them.

I will change things in v2 back to this 2-patch version, and maybe
limit a bit further the changes in the first NODEV patch.

Thanks!
Nic
