Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF87401E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF0RHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0RHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:07:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866611708
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2ghFRCg9s8b5yUJUFBXVzblTTYu+l86FCr1iY5p7m4O1qmcnqBM2T7EHyuhGL9xOcy4GkKhpMZDgGF9UEUSpmldO0KWVLTa1VPN/B9Ovo8haUHyQf95XgDDYbppsF+ei0IfOS7bSXsKJwGB2YgsKlA+v1guy+qxkwcOcuGHKWQ29iEHdzRJT/Hb59cSxhs0kG/Wjq6BI3+TEfatP3yidNuwV85rWGCCvCTfHTqgEyoB0RdfwHXlcvv2pWtVrvEqMIrBxLG9aaLnXXZgncWlQeDawUgNreepM1hOU3ZvmKdSV45MHkhMr+wJPOw/yzv5JC0aOMNtLyEtiCamLkwkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf0tgViEaxHgb6zJeiOXuancmQbB3mADXlT7BhIkNq8=;
 b=BgGtMJU2koVubMxMU5DJ2SnzlDc2Nx6lRsc3s9DYtjqsHRqsIwuWn25kUa9WPwaXS6C3trcWsb1/SjTtcQ5VbVh3gq/+09V9egCdik21P+1wHge/PCe0l3ciZ3/5BTUAnUlGsAvJ2kCqMjAmL7G6LW/WEoeAi/WQ6OuMhfoRSoMvBQsIch254u8hgwKbgFDI6VuOouEcXOhDX7By2OKk2fWY5s5X0ez8VqqxBjcfp3LfkeaWYEivi2nIUimMHOaW8QL6Gt/QdhUANQOGDuziDjjaG7/g16/2yLpNeO98pVJHlz9xVT5/RbsolVn5NDTHv85KDmRUHVlfVlMjsr4tXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf0tgViEaxHgb6zJeiOXuancmQbB3mADXlT7BhIkNq8=;
 b=lDn1jAKYkIxEzf3hCO6BIO4P+B1ydnNjyHLnrS3N14W61GxhZjGS+Ze+KT5hbgnl2qAxnda57usoLbsZmbw+VCweW2OD0WWvnlgV7mk8kvgARfvg8kZVSf9F5YeYI1PB+rq/kiQNmtWhMA2wL4Qk4hxIJR8oUZgugEDg9thTfqGk81Llfsw7DML1VspDzdyxxkQFVhieHXz8iP0noXVK14v2lbZ1NOXMV0+6Hj4VQrKOwPx5JecvuwJ9TMVSXtGN4QzZxIt7YS46fEJJYH6iOxhEIaap25Kid5Kdn0VSttvL50vX4ouY1E3wsWkq91YsXHeFNA4PWxeov09naWNtMg==
Received: from BN8PR16CA0009.namprd16.prod.outlook.com (2603:10b6:408:4c::22)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 17:07:06 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::34) by BN8PR16CA0009.outlook.office365.com
 (2603:10b6:408:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 17:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 17:07:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 10:06:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 27 Jun
 2023 10:06:54 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 10:06:53 -0700
Date:   Tue, 27 Jun 2023 10:06:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <yangyicong@hisilicon.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZJsXLFtH8WkRK41w@Asurada-Nvidia>
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c8e8b3-f14b-40c3-1025-08db7730ef9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYt2KLgYIazjKzBo3QnbQhsAg2JIjJ94zpTAkceyQsvl9gwYiqTzPSc965o5LAnBFpqSpm1bOwov7fvJGbZczDtydIMnfmTwsGz5w5hobrgu5LqyqazR1BmGAK1cjIIpTFFOEDy9/cmyphB4KwUHYKqIjyqU50v4e+7Ft8oLYQGEvSoEHoVjzU2HE8KIH+phD+aHzPhc7IbsNww9GKRdRsqvseH87zzoC7HB8yFTynkgRCnJwbi9znMqs5yqbHKXKdx8s8Qr+iGSzluhw/e8ZywVQ8pGPcYc9UOp5a293YK7A1iBVJBWy0DpzCzT7thJzBsCBATWAu/JBsaqhE8WtVu1kbl6q3PxNiGBKSbP08KXTyuw8lLe/x7zIu5Voek8OJfBCHuRpoNM6i35Et+94iLNU0KzyNlrgg69oN5uF7qUpa23vZ8/tu+yOZDZHq1xvB5D/fTCihRa06S3btXL2X7M75ixZ+0tW2XIi12xsZzICi+++gHwFKQ2QKEROF9ZgGIjfh544NCSqsd4P+1z4WWy1vdYj5lbGWt+zJ+fOi3a9+DQELAP1ci6gfD/uHzgQXSIvMjZ6zSnWmbdosPLJampdu/2nmCxRjCxReb0r/9nqLJp3HThRk1ibrSEkzOpkUHPrTyLkxInvB+y3xMaUsUFAP0fCP6be+R6HYssZa42oKsNfRW4bUhuZRZobtz3YxcTfhJPqtyWpX/sWLi8XkPaNdtlNCNHxUej4XnDGfY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(451199021)(46966006)(36840700001)(66899021)(82310400005)(53546011)(36860700001)(70206006)(5660300002)(356005)(33716001)(8936002)(8676002)(86362001)(6916009)(316002)(70586007)(7636003)(4326008)(55016003)(47076005)(9686003)(2906002)(26005)(186003)(426003)(508600001)(83380400001)(54906003)(336012)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:07:06.3209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c8e8b3-f14b-40c3-1025-08db7730ef9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Jun 27, 2023 at 10:00:18AM +0100, Robin Murphy wrote:
> On 2023-06-27 04:33, Nicolin Chen wrote:
> > When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver would
> > skip the allocation of a CD table and set the CONFIG field of the STE
> > to STRTAB_STE_0_CFG_BYPASS. This works well for devices that only have
> > one substream, i.e. PASID disabled.
> > 
> > However, there could be a use case, for a pasid capable device, that
> > allows bypassing the translation at the default substream while still
> > enabling the pasid feature, which means the driver should not skip the
> > allocation of a CD table nor simply bypass the CONFIG field. Instead,
> > the S1DSS field should be set to STRTAB_STE_1_S1DSS_BYPASS and the
> > SHCFG field should be set to STRTAB_STE_1_SHCFG_INCOMING.
> > 
> > Add s1dss and shcfg in struct arm_smmu_s1_cfg, to allow configurations
> > in the finalise() to support that use case. Then, set them accordingly
> > depending on the iommu_domain->type and the master->ssid_bits.
> > 
> > Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
> > to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.
> 
> Why? The "default configuration" is that the S1 shareability attribute
> is determined by the S1 translation itself, so the incoming value is
> irrelevant.

That was for a consistency since the driver set the SHCFG field
to 0x0 (STRTAB_STE_1_SHCFG_NONSHAREABLE). I was not quite sure,
in a long run, if leaving an uncleared s1_cfg->shcfg potentially
can result in an unexpected behavior if it's passed in the STE.
Yet, we could be seemingly sure that the !IOMMU_DOMAIN_IDENTITY
means the S1 translation must be enabled and so the SHCFG would
be irrelevant?

If so, I make make it:

+	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
+		cfg->s1dss = STRTAB_STE_1_S1DSS_BYPASS;
+		cfg->shcfg = STRTAB_STE_1_SHCFG_INCOMING;
+	} else {
+		cfg->s1dss = STRTAB_STE_1_S1DSS_SSID0;
+	}

> > @@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > 
> > -     if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +     /*
> > +      * A master with a pasid capability might need a CD table, so only set
> > +      * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid master
> > +      */
> > +     if (domain->type == IOMMU_DOMAIN_IDENTITY && !master->ssid_bits) {
> >               smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> >               return 0;
> >       }
> 
> This means we'll now go on to allocate a pagetable for an identity
> domain, which doesn't seem ideal :/

Do you suggest to bypass alloc_io_pgtable_ops()? That would zero
out the TCR fields in the CD. Not sure if it'd work seamlessly,
but I can give it a try.

Thanks
Nic
