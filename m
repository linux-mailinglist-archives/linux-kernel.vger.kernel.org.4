Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C0620488
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiKHAPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiKHAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:15:05 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CE273C;
        Mon,  7 Nov 2022 16:15:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7T9m5eCCkMF1JiU8YIs+mgovLnWwzz88lLlR5R/SrCprXK/ZDh7sU2NFh4k9EWNfSMhRKnrnPaUkjUCnrmBCAz75rh4+6VE06R/KKBBnaEzDalLw+EXA7uX32MP3NTn7mPEHIiIINmD6x8ZxqUoTIu7Wdqtc+fdBX1h/jezzbxdZJs5QizU3IYVZ70qPJBzv3dj0H54hVi2/bcqAlS2hH9o+HRZRQnxORtt+jOFQEKvGzyfXVKL2jBWr76W1isgWgR8dDsd/KDW07RnfJC2+qs5vlMDJIHPzMCeYwNuUaSCYguzMMXsGO5W+2LgXJfpevnHd4OeKE4lmdwlWmnqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weGhFE/NPYqsu3+oQ3+Gc2/85Dt0v2jOoXlR66OrBHw=;
 b=kx7IfdEOtqt2KHzYWuGL3ZqCYAVthb7LZTE5D99w3Vp+06kf0rhjqFAJ0bX6ysKXuVJABprwelzRTRme8RuZwU2+bhNmMKnsXZ10EziheSNFzzwVLnv7hg1PPmnzx08Rx2clKBkNRUh0N21G84quHsnUqoY+OWHRBkbOOZXi8fT3HQ6j5mIxy9YfhblWPY0mZarwLeXbmS80YBCxCokxiNrtVi12ScyGk5EnmHZz92sjl/Ekeuh0Apy/nJGuoaIaKZTHQZSahc4ltOFzRyiocj3xK8myMkMyDojbIgmFSpwxWspWMAItLgTD0E+gause4qUbTnXphFJMAwIeHMFnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weGhFE/NPYqsu3+oQ3+Gc2/85Dt0v2jOoXlR66OrBHw=;
 b=Hm/1W6/aw4Wz3PVVK2TxDawAuSSC47ovyTL3RQ+Jvq7LvI8Wrc9bhEjkLVWdsqVb6g0LNQIjwYOgJo+S8btjUICCUnG/mjvX5B0eWz6TyGelAUJQzrr+zPGYM7eJA0VlVT8HaMKsz0o8Htkfg2fg1gQIQXcIa1yfxK5FUYITJFvLx6f6kt6Chi91JLmVmkP8SXrA4QbD5v+ULjcKOuvNUMJo+nFWUcmI0KbSszkcgciF1iUSD6u7npCYS+19Syl0GRYU6kSxa7chi4Qq2DYMfbIe0hDnIrbNlckMmMvkr1l7oHqtexEIjExBLdRQERKKDNHStvuNE3vxiXZgibuhVQ==
Received: from MN2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:208:e8::27)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:15:00 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::f) by MN2PR20CA0014.outlook.office365.com
 (2603:10b6:208:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Tue, 8 Nov 2022 00:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Tue, 8 Nov 2022 00:14:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 16:14:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 16:14:36 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 16:14:34 -0800
Date:   Mon, 7 Nov 2022 16:14:32 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <quic_jjohnson@quicinc.com>,
        <suravee.suthikulpanit@amd.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <jean-philippe@linaro.org>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <yangyicong@hisilicon.com>,
        <yangyingliang@huawei.com>, <quic_saipraka@quicinc.com>,
        <jon@solid-run.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <Y2mfaG1/6hd1qykW@Asurada-Nvidia>
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
 <20221107152645.GD21002@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107152645.GD21002@willie-the-truck>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5808e1ce-f844-4895-f7a2-08dac11e4645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RU24JXB3AVpAykJgZNiyB3QHnmFS+aLLRoamB/d0r3zRn8a/2egcnaBTglj+4BNErN9mte5MVKMKM4Yxyxgwgz5sehyBUjHTrMEQeFFmxn7Btkl8XS1rklD3NNWVLTcMi5ayNeV1hWnIoqchFg65GgZqaubfP6eFAREAIzAOdGi5ryeiBukr5zfyzFpue5gZUxQqiKCuwt6/RNBzE8eH/u+xfAjXGF+gs/SHAgMwRncZF/iGKBwqeXVpC91hJWnhC830ozySpnTDs318VEVGkUZPSyK3sVs+39mNMiFiYtYAl3dLjyiKukH1j1+gnsXMB/b9DCq/scM56Uo2nPkyVowrQT9qKDHEIH4+OST988u/RuxNk4yUETdsd5nhds2NuO/A5DJEcDCU2zDrWUF7f//rzXfkniEOa02yik+5IP2WguwggJexPf3GjwYnYKwHrKZsEVbYEhW2eXxFz0Z6xzr0akkdSN/IxGuRuipblRntFU5KMzr981xONqiTjuecTCm1NpOb3hMmH9K+Vm3B5GQsjlCHOznfH6rj+TP5tI99FSbrXOH6+ftyVklI9Ja+P6896QvJ7unisz0fyzvtCHUVF5zoMZm1YATBq+4gIIDtT/1tYF+MPA0r7SBsE/anmABGSKRWch0wN960R0b/Paqb8j90kGfif4uAmSEl2598y8OvmqvMSST9n9cJckjYFxJwF3bqKTQdg9npOGBNrlaJpioZ6dSRPtCMmXrg3rnFC8MUBXBymSJrwTVWGDP9PDHJuI/vherWrVYPsufQpmP/Po6R3OjUS7y6uy3jPM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(356005)(7636003)(82740400003)(83380400001)(55016003)(40460700003)(40480700001)(2906002)(9686003)(26005)(186003)(336012)(47076005)(426003)(36860700001)(70206006)(8676002)(4326008)(7406005)(6916009)(316002)(478600001)(82310400005)(33716001)(7416002)(54906003)(70586007)(8936002)(5660300002)(41300700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:14:59.6329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5808e1ce-f844-4895-f7a2-08dac11e4645
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:26:45PM +0000, Will Deacon wrote:

> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index ba47c73f5b8c..01fd7df16cb9 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >                       goto out_unlock;
> >               }
> >       } else if (smmu_domain->smmu != smmu) {
> > -             dev_err(dev,
> > -                     "cannot attach to SMMU %s (upstream of %s)\n",
> > -                     dev_name(smmu_domain->smmu->dev),
> > -                     dev_name(smmu->dev));
> > -             ret = -ENXIO;
> > +             ret = -EINVAL;
> >               goto out_unlock;
> >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> >                  master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> > -             dev_err(dev,
> > -                     "cannot attach to incompatible domain (%u SSID bits != %u)\n",
> > -                     smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
> >               ret = -EINVAL;
> >               goto out_unlock;
> >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> >                  smmu_domain->stall_enabled != master->stall_enabled) {
> > -             dev_err(dev, "cannot attach to stall-%s domain\n",
> > -                     smmu_domain->stall_enabled ? "enabled" : "disabled");
> >               ret = -EINVAL;
> >               goto out_unlock;
> >       }

> I think it would be helpful to preserve these messages using
> dev_err_ratelimited() so that attach failure can be diagnosed without
> having to hack the messages back into the driver.

Thank you for the review.

The change is already picked up last week. Yet, I can add prints
back with a followup patch, if no one has a problem with that.

Also, I am not quite sure what the use case would be to have an
error print. Perhaps dev_dbg() would be more fitting if it is
just for diagnosis?

Thanks
Nic
