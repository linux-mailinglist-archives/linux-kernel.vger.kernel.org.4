Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FC96ED4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjDXSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjDXSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:51:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5F9751
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCWn4Id/mE+fmWCkhGt40iptiPhCvi7CUdaS3HMU5ipD7JXghf6Tt2tP4FuNRb9NerfbpMZPLQoBqK4B6isZiV9WS4pOoVpP2/GcCdSfNFVv7sS4/go4DL88ayBPiCSiXPYgu7pucUfEMZXo/VBn+svnvrZZs5Mtss3UJaEArIWMv+hnRFKWSOqrbkYYL9QHFYN7QFGS0S2b6x8vRObXpF2bGABA2xDpCQ6IZkH7cU1u5/FWXhn+1X2fFEtoJSlRImQxg3v0aCZLIcnrRvfx4oJvBCETuaNa9/WchueTIvzMGBuKZruQlcx/4cxgyaoOxNxzSsm3WOlCgkxwTGnt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+/9YD/u97ILZX9tFWlFp9zdxOY9jfuPNpZEbacO1uA=;
 b=XcFNPrcMCiOhufXh3r1MUqlhLUmkDOvLqt+4DS9FSR+yk28xyXcIY8eK6uiO4ZNH8LEu2Zc0RiZkoV5LbYzgfTtouXJYSzkva4fq/jEE2jP8LwP93gCGRUHbpJ0ymDJAe/F0je4gc7h0i0nYlwSgN/cSj/FT5flHFoqJy/lbgEQ2QT3WspJ0IcTdnhihD2WgDQZnqKPa8n9gfaLdw+OaaCIsxkHXmfWejZpxh3MwIptaWnxGrhpkO5AjoTKuf+2EAI7GmThpR37d0bKm/pCqtkE4MPyACW0SeBpLH2wNEDy23urrtP/ZbJnGHjUhVJZSj66Ee2XNb4NoL+BhCo2I8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+/9YD/u97ILZX9tFWlFp9zdxOY9jfuPNpZEbacO1uA=;
 b=EATFsUbBFgJnboHI2XUkz/OvRZT4spgEoBOQbQHnVakQFktNFJObXoWTyrC7h2TU+Ne2ugAno/Mv46Q7GXJ9o9jAEPtXM+OpqT8uq/O2wzrn1p+qphAu+vdyTh+/Bj0vh+D3ou1tHyD7RTKfuTnEEvPrh38Fk4NB0ssIRNriKykG/4Fz225d98njr7eYWtORsmGb97KUnmtGaiz6Y/rn7iorqS+VueUgC2rTJ/R10mgHr42cepfvg23AnVrclfJGbU0gO0QbImGEfJqZDSCr8lQ66Lf3mfA9aQkSaA4yKMbv8Z5tbPjKpBp8nCatgYHvNeZ6n++L3gjFCFdOZNXDBQ==
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 24 Apr
 2023 18:50:53 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::aa) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 18:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 18:50:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 11:50:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Apr 2023 11:50:48 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 11:50:47 -0700
Date:   Mon, 24 Apr 2023 11:50:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <eric.auger@redhat.com>, <yi.l.liu@intel.com>, <will@kernel.org>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3 2/4] iommufd: Add IOMMUFD_CMD_DEVICE_SET_DATA and
 IOMMUFD_CMD_DEVICE_UNSET_DATA
Message-ID: <ZEbPhorHgaaY0HkP@Asurada-Nvidia>
References: <cover.1682234302.git.nicolinc@nvidia.com>
 <08604f9f4835d5a6b0d2d75de69722194abf7747.1682234302.git.nicolinc@nvidia.com>
 <17342260-0795-9636-8408-0ca0d6c50403@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <17342260-0795-9636-8408-0ca0d6c50403@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: dddf313c-f244-4549-e79e-08db44f4d489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcWykKSRSlg1MhBr2uSEMEizHihovrj1ChRL6j8MzqKxcz3KwnGfWUBqR2UcSeA9gK6ld9JnCyuK7ryZOwio5OLibj87Y9jOMJtsHFrkTM886VJcHg+/mJ61DFlAro4BGGe2xog3j+dKFXbYlTUj2VTFtCLZ+tSLwnt+nbSQJjaEJrAvr6WHnFy/Il142DqXNsPf+jQY+hpV9JBS4OVu31lvEWqNIYEiuolZvM18PSVlEdPaKz/FjEkAv2dxFweRogkCbEDxmmoNvbRQck7w0dQR3/ayq8aDFQRprYAb5nRq28vuMXArdKwtxuKU1h8CZGXX8+8GxG8sOw3NfLFKtslo/rClwPwk3cGde8gkDgyV5r95QW5xX1z3rT6GkY++1ipDDx+IFb0jNUw1jLKXYMBYOVTvcaNbdbi5Iu6E9I/yOcppqC000cD851OJBXL5tyU//pQFANi+BrdodrD+HABgI5EVYZZ21p5k395hLNCJFLFYSvzupQBN0vOSWCYyRlCSkIAB6irrlDjVBaeUVBxO4fNal0xXSwj8XuUh64TApq2IEE+SxXjbEqvYsjsPm6/wl8iZGFgyQK+oBV/atCiPyatY+w14F3YWGgWQmKT1iAXE65bVLRV4FrMKdbM37meW4+bpH/dFdYIPJ6epdTooWQwWEOEeNyZmPAcPeKNJ80Cl1PpfX6uR3ATPWieBxKdHVbYbXY8opUGmDmnCAVzkml+34H8sJofHnmOvigA=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(54906003)(86362001)(34020700004)(186003)(53546011)(26005)(82310400005)(9686003)(33716001)(40480700001)(55016003)(4326008)(6916009)(316002)(82740400003)(83380400001)(70206006)(70586007)(36860700001)(2906002)(336012)(356005)(7636003)(426003)(41300700001)(8676002)(5660300002)(8936002)(47076005)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 18:50:53.0479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddf313c-f244-4549-e79e-08db44f4d489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Mon, Apr 24, 2023 at 10:44:08AM +0800, Baolu Lu wrote:

> On 4/23/23 3:40 PM, Nicolin Chen wrote:
> > Add a new pair of ioctls to allow user space to set and unset its iommu-
> > specific device data for a passthrough device that's behind the iommu.
> > 
> > On platforms with SMMUv3, this new uAPIs will be used to forward a user
> > space virtual Stream ID of a passthrough device to link to its physical
> > Stream ID and log into a lookup table, in order for the host kernel to
> > later run sanity on ATC invalidation requests from the user space, with
> > ATC_INV commands that have SID fields (virtual Stream IDs).
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   drivers/iommu/iommufd/device.c          | 81 +++++++++++++++++++++++++
> >   drivers/iommu/iommufd/iommufd_private.h |  3 +
> >   drivers/iommu/iommufd/main.c            |  4 ++
> >   include/uapi/linux/iommufd.h            | 32 ++++++++++
> >   4 files changed, 120 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index c649a3403797..9480cd36a8bd 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -136,6 +136,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
> >       struct iommufd_device *idev =
> >               container_of(obj, struct iommufd_device, obj);
> > 
> > +     if (WARN_ON(idev->has_user_data))
> > +             dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
> 
> Do you really need this WARN_ON()? The user space application can easily
> trigger this kernel WARN() by setting the user data and forgetting to
> unset it.

I can drop that, since it's a user triggerable one.

Thanks
Nic
