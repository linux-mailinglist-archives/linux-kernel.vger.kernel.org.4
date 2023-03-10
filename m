Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E66B33D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCJBy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJBym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:54:42 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3AFCF9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1r3i8ieJlvTAQvcxKoTJKY8omhX1N2ambpNbjsqi7DnloyY3Z9mvcN9+la6NDHPvl8Evo7/tlFKbjzpAmRC7R+7UFhX7N+E4I9+32D3Sgf7bgmjFBJGQqaEyZTZidEp+5KKMVIhbQr7tTNxG8TTwEWiThARmppe76FasIzbXjPZ4RTVsHqhfJ4vQopgoa+EU4WrD3hS40stR53Fe5255uTO8gkUVH3W5X0PHbk473IrBcQqJpd9ALegCn73JreYR75aQ7wl3+hPxlh204fNvJ9wErOI0/s/9SDzTt0TqGQUu4zd3f5XeXCINtXxJ4nSgSA2zEIc5U3lnnSw5sxtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxtKAhbbf3kAnBMI5Y7rnHIJ/IKKT16LcK+usb4nmIs=;
 b=mkZTbCiBBfimVfNpvS8cnqMGgL33eoaehpgy2tY4L2wNOtC5O0H00RxY+XjaFGrFqTMaHEk8DkKaEby29vV9Kv+PnwXuuJepBSSAJndQLMC9VAt8aZe/2cSLVPB/ukqgch471fBqNxkiulngxcjrE1j8I2rZ4q5lyENMFMs/NruwLgrVuVI+9docA+fklLOVippoYJ5K+WZPc2rG8xamYDT6QCRgEIpD17Vr0F5ZphiMHDD9N6ZMZRNUA9ksJ3Ul67POYqQYJlmjJbnHRbSWhmt1sxIrtYODmgDJ5oG7SwzKXsICLnpf/oWqvKrLeHXQiLvJU2mlkNvXS7Bf+mD8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxtKAhbbf3kAnBMI5Y7rnHIJ/IKKT16LcK+usb4nmIs=;
 b=MH2U6Rt0FVEtVvhjFYSnMrduxfCeTINpSbOSm420q/nS3QYywaNBN2Qei3+zG7G16eNkcchauAxeNZdrLfQ2IVCI+UEoj46x2u7Hdl9rUN21qL3yu0YbV+6phLvsWswjZmeWrX9P+ym0P88ndZ5QP2LKP0oJu1qZhuAzqUehIpb7LiIQ/mGEfwMRRLFfeGc2F6QFXynIAug6AfarnszDmtFbkSREwuuPDFFKi4P0LXbLyPbrUz0ekkoRj1OOQgvud717Ei6K3lFGRbQtdNHm1KRNONT0kiLzsl2qadq4SIgeivklU/0lRLYefSKh12qqnHVuA2RdN77CZmB72ccX/w==
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:54:34 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::76) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 01:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.14 via Frontend Transport; Fri, 10 Mar 2023 01:54:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 17:54:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 17:54:17 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 17:54:16 -0800
Date:   Thu, 9 Mar 2023 17:54:15 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 06/14] iommu/arm-smmu-v3: Unset corresponding STE
 fields when s2_cfg is NULL
Message-ID: <ZAqNxxSQHE+MN/Sp@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <995e48fe6eb9e31c71dbe8bb80d445aa34a51819.1678348754.git.nicolinc@nvidia.com>
 <4e426dc4-6852-336f-7321-5b4df69fd430@arm.com>
 <e923418a99e44cd38483ea24e4c1d373@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e923418a99e44cd38483ea24e4c1d373@huawei.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: b0966e49-cb1a-47d2-dd9c-08db210a6474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5kpdqviCm8PIZyLV+ug9Ubleoea1AQI4sIO97BJ4MwTC6oftxyhUZVEsl8qwaGcEwyfY0s3OIKDoTgaKUq5l5H3zRDrDOHzGsL28elE+RPyxfpY1b2blENxxhMMbZRxJpLSC5Ib/mNBY9k3oDgZGzmsub6sXGpCrbzpBOe3xxjNL4QV7+lR1d5csQ1LsLxzA3y4iJuSRQXc7ym1WR186+zga2DzxUcDvjmGge/aGND/MbSX31el7rIKA6xHaWxHCbYbK3VWFnikeDDrG10jTdXI+JhDwriTaYZGtpwSqC1AMADDRvmGrU3cxwh0TX+Z8QMcTL7bECevjTy68Lgn23eLHs3jUGU6UzilFqU9vnIwy2zUGVwO54n1PIZsMt5j67upQ/vjMwCczlyQD84z2ThVAWRSkSaqgsxq2W99SYGjLskAcsBZ2w0tb379Z3GLigBqTI+JJAVN++a3qheA6vV1JIysX9xrr+wQWeuZQiZHGw6Yrgfai7sjzOz0wFz9lvswrQp597RrUJtJHkDhcPITmhGc0Hz/UWfw8hDVWKrRlGE4D8TZ29Tadt4UG2wC2D4wz7qDwrSsUt7QBI+G5XFmfhSJUM1iWtE3ApDWzVxXAEfiiWlMeLsefx+2Hn7EEJ1C3sXKdTE/u/yJqQaE4XrmFXF9syms8YRMP/VCRPHH1stlGdrN0NqhvcwyofCoG6KSRkFesjeT5bTeHwz3BbcD+BTkTpMhQhJtP6FOH+Xu/udCbA+hSuEiCn0Onu1jRLAkhqHLPBT9J0F7C3icNbCqAwKKdGd9d1Ola3EgIHU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(33716001)(82740400003)(36860700001)(83380400001)(47076005)(426003)(478600001)(40480700001)(55016003)(54906003)(7636003)(356005)(316002)(336012)(966005)(40460700003)(9686003)(186003)(26005)(53546011)(7416002)(2906002)(5660300002)(8676002)(70206006)(70586007)(41300700001)(8936002)(4326008)(6916009)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:54:32.0264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0966e49-cb1a-47d2-dd9c-08db210a6474
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:24:29PM +0000, Shameerali Kolothum Thodi wrote:
> External email: Use caution opening links or attachments
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: 09 March 2023 13:13
> > To: Nicolin Chen <nicolinc@nvidia.com>; jgg@nvidia.com; will@kernel.org
> > Cc: eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> > joro@8bytes.org; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; jean-philippe@linaro.org;
> > linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 06/14] iommu/arm-smmu-v3: Unset corresponding
> > STE fields when s2_cfg is NULL
> >
> > On 2023-03-09 10:53, Nicolin Chen wrote:
> > > From: Eric Auger <eric.auger@redhat.com>
> > >
> > > Despite the spec does not seem to mention this, on some implementations,
> > > when the STE configuration switches from an S1+S2 cfg to an S1 only one,
> > > a C_BAD_STE error would happen if dst[3] (S2TTB) is not reset.
> >
> > Can you provide more details, since it's not clear whether this is a
> > hardware erratum workaround or a bodge around the driver itself doing
> > something wrong like not doing a proper break-before-make transition of
> > the STE. The architecture explicitly states that all the STE.S2* fields
> > except S2VMID and potentially S2S are ignored when Stage 2 is bypassed.
> 
> Took a while to locate the email thread where this was discussed,
> https://patchwork.kernel.org/cover/11449895/#23244457
> 
> This was observed on a HiSilicon implementation where, if the SMMUv3 is configured with
> both Stage 1 and Stage 2 (nested) mode once, then it is not possible to configure it back
> for Stage 1 mode for the same device(stream id).
> 
> IIRC, the SMMUv3 implementation on these boards expects to set the S2TTB field in STE to zero
> when using S1, otherwise it reports C_BAD_STE error. :(
> 
> You are right that the specification doesn't demand this and I am not sure there are any other
> Hardware that requires this.
> 
> Could we please have this with a comment added in the code?

Yes, I can add that, and put that link in the commit message too.

Thanks
Nicolin
