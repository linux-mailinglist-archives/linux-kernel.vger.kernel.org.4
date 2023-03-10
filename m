Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64AE6B3395
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCJBR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:17:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D7DDF22
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:17:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7U+QRUeMq38I7wD7LfcVbIpBylLA8tCxZlTuad2NW23sVK3RRA7NzYpJLhuYo8urqX2I26puEepBx2+z3xNBdye+25908AQrOB3iLSjzM/HFmUfucn1tdCUb7qyDl2smRVh05mh7s/m3YkiYPyoVzln28jdOX5NJHFBJTh6WkG9JKrH1XWvG45iPvyhR4ZoScjrR97Eh56Zwcb8hCsqsMdiISL4Y2I0R2WbO2KxSvw33Ah0nktvmSHKSZ5eE7g1veYJVtmM5yChURkrsYPRwUEn0DwEu9AbcVB7Ru2C067daizZ1H+Br+637pGnzhUN3RXXELcKKjaiOTaNx/3KEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjsGnBRe93t8CKmXp5q1jTYlpz2C0Tz6coki2mehitk=;
 b=DL4jQ9Cbr8Bta/0tMpxoXaFNpp+6V1m5iZl8949ZI6utYN7M42KFdRSNt6VCJxoiYKlWDfbwW3jOsbP7QPcPdnWh8GD/QONGDp3/mjW4ItxAjfpvz6b4LYHGFof9xXcJuJYutYNzsdoV0xKfPa1MmlmyZ1i+GK6sCMSx2C9eZYu1YsxTWE/t+BSh01BRHsvxO0wDR6YGzbOEoUt01kTu1XLVb831iesmgjHw6l5L1qggPpnyoHynThF/dIcQF8caMfzqoa0d5b/DknZBR1x8slWrKbphuugnzom5IEW3QH7IJ0Z0lusGeilnUa7xZyvRKPMqxehxlceBBXObSIVt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjsGnBRe93t8CKmXp5q1jTYlpz2C0Tz6coki2mehitk=;
 b=tiqyDGEbBNAF9FR5tU2BnHyqmVyHSzqYJ/VJI2hO9H0p4x0db5fbsb/e5ZEAyHvrQd+Qw994yqz5lMr0lr3LX3kpmtj/WA6d6uGvEqP84dTK9U/RhlvfrjyuTEmAmywNzJKL2g5tIZGUauEgcD2mpTx0pgCt0nD6a7vqzWMO26iRR3EG2AT8Y30lgF5znK/Kkkw92OEFXx9dCfDN7uw8BdMXadYyjdoTVFcFyjXG0KMREcol+B3ufFqrDNQDcPJc4ZljH04g6sL52b4i07YLy4qV4CZZHKJs4apsxOc0j1UAFqc4rslqewCticc3jsUC515VdIPThcxqvGID+IO9Fg==
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 01:17:21 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::9e) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 01:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 01:17:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 17:17:12 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 17:17:12 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 17:17:11 -0800
Date:   Thu, 9 Mar 2023 17:17:10 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Message-ID: <ZAqFFolbw5xoJDfb@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
 <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b730e2-bf9b-4b29-bce7-08db210532e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pg3l444mWR7d2jF76O/ZpgQJE+hatHls1q+h6ydbCSUBwZxrZqAhwA7L5NebSvds1weFS808v0SBwhCCdpH/SpoY/eZjRnAJiwXfXEg6f2uK6WRsVsFVY+TbXPm3JXATlrtuZOE9ME6IB9JhU3JiTMuMoQR9N91kCqwLwkigU6xMaZllElnqGZWJcDhAnw4OIGGVUv3acV8wtIOSuMxhRLR8bwcz7DkVl8OMH3zl1ayluvFgKYbk78gW4kSlT/NZG5vXIwdKBivonJbbmEK2+M2LUFlGtw0x54K4n74NIHP0smlRuU37L3f8LdntNMruPUZyDDOuUTKN07BdJsu9XtRu+v7tY7RujgOnLIToaYg/Sub92pSMfWSpRrKU3hdlPpHrcqJ/VxgOf1wDJyFrCrk4v3yfOSr+7I1oSLZL7UKi5LSAj/Q9qh9lEYY1i5B5g5FXNMg/xa7as1z9F2LJ5TNzeJtAKu6oYt+fncyZUJpXy/LBp31XnZdMKEcbgJut5Fo0zbrFrdA+L5sN/5bjIu6Tf7c0mrVldYjK4gjUHkTm05bz8CI+sEHth0geO9ZSCiLc8fpI1JjtD+Zwc4sjdxUcWxWZ1dJzGgglCM0Az9tTPDfSBEol3CQM5llTgetEqG8Sh9v8OobheHvr2VRazzbuZE6AGffiBP3mpT09gueaNauuu2I2o7Acq5OV2gdWNvYUiAOaYlvs7AqYskberdAOF28Mbs9s6opmE1CaWqbbhln7IdQ03AEsZ99YqPdA
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(316002)(7416002)(8936002)(5660300002)(426003)(336012)(41300700001)(70206006)(47076005)(55016003)(8676002)(4326008)(70586007)(40480700001)(54906003)(6916009)(86362001)(40460700003)(53546011)(186003)(26005)(33716001)(7636003)(9686003)(356005)(83380400001)(82310400005)(36860700001)(478600001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:17:21.4055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b730e2-bf9b-4b29-bce7-08db210532e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for the inputs.

On Thu, Mar 09, 2023 at 01:03:41PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-09 10:53, Nicolin Chen wrote:
> > This is used to forward the host IDR values to the user space, so the
> > hypervisor and the guest VM can learn about the underlying hardware's
> > capabilities.
> > 
> > Also, set the driver_type to IOMMU_HW_INFO_TYPE_ARM_SMMUV3 to pass the
> > corresponding type sanity in the core.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
> >   include/uapi/linux/iommufd.h                | 14 ++++++++++++
> >   3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index f2425b0f0cd6..c1aac695ae0d 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2005,6 +2005,29 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
> >       }
> >   }
> > 
> > +static void *arm_smmu_hw_info(struct device *dev, u32 *length)
> > +{
> > +     struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +     struct iommu_hw_info_smmuv3 *info;
> > +     void *base_idr;
> > +     int i;
> > +
> > +     if (!master || !master->smmu)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +     if (!info)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     base_idr = master->smmu->base + ARM_SMMU_IDR0;
> > +     for (i = 0; i <= 5; i++)
> > +             info->idr[i] = readl_relaxed(base_idr + 0x4 * i);
> 
> You need to take firmware overrides etc. into account here. In
> particular, features like BTM may need to be hidden to work around
> errata either in the system integration or the SMMU itself. It isn't
> reasonable to expect every VMM to be aware of every erratum and
> workaround, and there may even be workarounds where we need to go out of
> our way to prevent guests from trying to use certain features in order
> to maintain correctness at S2.

We can add a bit of overrides after this for errata, perhaps?

I have some trouble with finding the errata docs. Would it be
possible for you to direct me to it with a link maybe?

> In general this should probably follow the same principle as KVM, where
> we only expose sanitised feature registers representing the
> functionality the host understands. Code written today is almost
> guaranteed to be running on hardware released in 2030, at least *somewhere*.

Yes.

Thanks
Nicolin
