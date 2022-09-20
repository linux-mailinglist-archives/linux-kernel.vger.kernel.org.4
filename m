Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E31B5BEDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiITT1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiITT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:27:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71354662;
        Tue, 20 Sep 2022 12:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3IJIPEqWTp0Ie+Sykac9lk46MtRSM1hTgO0Dr60R71nbHzjm/H28+1HD+gqPtMN4uzUpRFHUUflAJ0XPF7oN/rfAtNo0ZVkPHIpNJypWlmysL46rXjMAOm2lT8dSlzSfiNmZFilkcuyWgVu5YAQU2XtrzOI9/gbOuzRMRzoIu/hmIT+eR0UlOb9l20ArUD8BiXV8w1IRueRqr2UpG5gHLYnfXhf4u4yLScCNTIo3mxZCaNc3NyCjZqhzalq0YMIaZv9lixIHjD8mUTPMKlWNAAquuDXn2SYphkWSc6B5l8wEaCEJg4xr5OInz2KKozSaSNCRbZOQqXEo6UYv4jjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKvltysaOkCLhqhpp3fFnvUoK05/NX+HZYBwHJw+qTo=;
 b=FYkf9xuQa0pvFAKAY2thbWUMIr4qZ4AO2jWJKpaSAJAR8KmyaIS6XNjqdqJyK+Kh1677F/TY1CG43AO4JLDU1AJqfVgeZLdMSHX3InOaOEDzgv10WKuPAWkLBmy4tRAqlhsPEZKheEdh/sl2l8QORbLaNKwnnCFgZ16E9JBpmdSpRZNWG89wFNGiylH4SBSv0NY/UwzsE9IkV1Cb2KHDct1M/fRJDrK3MlQeBvWv7YM0zasrCaIAvwdOhBzRGH4Tpx7QNgjzwCJ4C/WaTYQkbp9pWMP1vXHlncGVSprcG3lS/IEK1Dt23wdQUnrxWvFxPgoQ0aqUJHo5lvtiFYPlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKvltysaOkCLhqhpp3fFnvUoK05/NX+HZYBwHJw+qTo=;
 b=MYvRcPPdUMmNTMpHrg+VMuCouFqxOmnVce5s4qydslTmm5W8jWw33rmxyGQj+jiz/+Y8xT+w0niE5QtdDlt4Qxyqft/oJXJYj2sgbB1J4pDvpXQZR/deboSES2I8hArA4+5LOUp3x98iOHmN1dclrWkyvCsdiYwBGf9t9X7cGh8Yj4UFMFvGfhtdD4LJsCdcZzdwoLSFIx0ip3vQgmtdmJ4DZOG/ZZgu8C0jCVw0xEdURmRBxGX3ko5SCHHb78Lu1WWXXKVkRTuO7DRF4mPI6cSPn98rwh5CgtVlPcEjBksWA5UdhLye+4yZyQC488k72kkoOvDlPVyoIR+7z9fa5Q==
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 19:27:16 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::3e) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 19:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 19:27:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 12:26:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 12:26:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 12:26:54 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 12:26:53 -0700
Date:   Tue, 20 Sep 2022 12:26:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 3/6] iommu: Add return value rules to attach_dev op
 and APIs
Message-ID: <YyoT/M+mFVqI5Y1T@Asurada-Nvidia>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <822a983febf7e259aa2aca70dddd382810b96117.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB527658C31268EB4A8411EDE88C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527658C31268EB4A8411EDE88C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|DM4PR12MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1255a2f9-6ba5-480b-dcb5-08da9b3e1ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCZ+rSVHqItHhErAyo+crGBKBDipIo57d3MzGefy6NRiPLH50bQguOM3e4goWiQsEwbJutH+bkcq4ntEdhXgJMD2jZgQd53Kny71h19GVCSOAS77yapEQjWoxS+okvIsQSkMsHXbXdN2R1pRRKDlaP3OiMRu5IXY9zPhYWvrUh/UEKCOPD9T5+3X+i5zErZq9b6TqYAuyF/wYADGop5WxUBbxvofoRSUutIPZPkdu3f0zxgI3Ii0sJwFWF+3H2WscSc9ER3LlwX4c73uXsl0ESUWNlaJyZ2sH54AB+N5vWyUvz1lJf8P9rAf6NLm+HdR2JqcbKw5gTLgl6j+5/VM4OWmm57ljvEcafAtqlU0sq/rO1E6MFd+56wKza3I0Q3Lga2+8j/gpJEhQz6hhQGR3ZWidoUdvnGPZM2DrlNoXfK0gD462NSoh3DeLMqY+qdE4O7Zr993GXGPWjs0YvUpRdAtaXYtqPG2cmVYxIEvM0JZeY3GYiVkZ1m2cJD5/D9AH0k48sZN4nh0dMO1atwoDzbio/XvzM/3OQWC3hMkMel+a9eNFKgVjsTZ+bv+++qHlApxb7terdfUn9B6AyuAzjiAtlzoONp3egerOQuPMYYeiq4THuSCO5fyvshxosaBVexWbLAVAAIkjuwUtbs3NHjv/2GKIwbGTZLqxMN/+RPwABYZdnbGcBDCju/lHjSCw8BnyBIm51jCHnSX5pLTBhRwG4WIiZm3FG/2LqNPrGAvY5bNT2rtpimE2EL6X7lHshAZ9OmOtajI902iLrz3xg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(4326008)(8676002)(41300700001)(8936002)(356005)(82310400005)(7636003)(26005)(55016003)(478600001)(40460700003)(70206006)(70586007)(6916009)(54906003)(186003)(316002)(2906002)(426003)(47076005)(336012)(40480700001)(33716001)(7406005)(7416002)(9686003)(82740400003)(5660300002)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 19:27:15.0668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1255a2f9-6ba5-480b-dcb5-08da9b3e1ff3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:24:58AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, September 15, 2022 3:54 PM
> >
> > +/**
> > + * iommu_attach_device - Attach a device to an IOMMU domain
> > + * @domain: IOMMU domain to attach
> > + * @dev: Device that will be attached
> > + *
> > + * Returns 0 on success and error code on failure
> > + *
> > + * Note that EINVAL may be returned as a soft failure if the domain and
> > device
> > + * are incompatible: if the domain has already been used or configured in
> > some
> 
> I didn't get the meaning of the 'if' part.

It means that the failure of attaching the device to the domain is
due to the domain configuration.

> > + * way, attaching the same device to a different domain may succeed.
> > Otherwise,
> > + * it may still represent some fundamental problem.
> 
> I'm not sure what the sentence after 'otherwise' actually adds to the
> caller. There is no way to differentiate incompatibility vs. fundamental
> problem, hence pointless for the caller to know this fact.
> 
> IMHO just state that the caller can treat -EINVAL as soft failure indicating
> incompatibility issue between domain and device.

OK. I changed to:
+ * Note that EINVAL may be returned as a soft failure if the domain and device
+ * are incompatible due to some previous configuration of the domain, in which
+ * case attaching the same device to a different domain may succeed.

> Later for @attach_dev you can add that driver may return (but not
> recommend) -EINVAL for some fundamental problems.

OK.
