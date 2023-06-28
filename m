Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8059740713
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF1ANe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjF1ANc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:13:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F926BF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2JgES1M/G0iYHxjLno59+P4mJor3Vscqn8iqPzK0NaamwH7KOwRBCHk0HJ4/UUpN2vRo29ONNFVyjTEOHI19Qscv6AwD1+HUKajMFsrQWenOmHLlAYhNUkINBXT2WvDPmwA+AXl+EHZ2FhjZeRkZwK62zTbHlwvNfIoWpW27FBhQwF3PKO1re/fXZhFcQC0ZTilEF5LATfVhJrM5lxPxiwG0/YwOyQkNP4SzCm+ifXY4IJenHE2WfY15aPiBKDeRnt4Fi9+f1zqJ+hWz/6jKSLvJkOQGnrQYlIIFecb5G9uFT8X2hGC4/iOqzUXewJ2ZNEQ3pUci+keAECkyc/gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZsV2jexeu66fYNAjaKsnJUi6ErHWpEwRDjziK0ceH0=;
 b=DkrsUjeZooyyXBVRMp8/Q7F6m0WV93lWgCiwJ6ZQ2iV9H8mEYBhjQgVmtZ9phUWiP5/cxEHgMTxi/p7+cGxGvGqx95mQx4J6mRzGWt7jkRdpRi7TtNZkJqyeORs+SZp4t9eG0DThI146dVgq/sMCQOt2rMoTBQcZNYCKW9CTZGPla0Uvvkrx9Xd7x9T/E+RAa/q2i0WAi4Ydf2iWKfn/uDm9drICigmt9ljiwurOuCYCO4wUVryTcDqZSdCnMOQEtxs9V29BUWbOOaQPuMZIcPIsVDMl0HjMpaJx3+1tOvRzgcvmzmnySsy5/wd6c1SDh9X4c+Zd8csRx/uLg5lmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZsV2jexeu66fYNAjaKsnJUi6ErHWpEwRDjziK0ceH0=;
 b=jgFu3m91UNFXuUKu2Gqq01mwRTVQu5GZ/4J33z4+I3kWLJMw7AUtTTH/B6PkeQxK938nkQwKWocjTVnhWIF7zB5EexYVXEDbvezfgS3b/09gjPna5tPplerumWwUkv2gt1gQGi9nS9hwHHSHH6YT3KoOtd1MiJf8t+KQSSqih0X9moQ/gzVSf6m5sUCxy1wP6ok45io9xCMSzzCzGpB/8BC/4x9ZF0xVUUz6wBOvGlZmjYX1+VdG7yrlZ8MGgWThGdapVVUCcYBYOsNF6idMm/daMMiUyLjnGl3OtUZ3JB4nO1EeIic/+XBh1YH+2s2ONdVPBlAy/QvUC7vgSWiDzQ==
Received: from DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 00:13:26 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::5) by DM6PR17CA0021.outlook.office365.com
 (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 00:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 00:13:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 17:13:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 27 Jun
 2023 17:13:16 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 17:13:15 -0700
Date:   Tue, 27 Jun 2023 17:13:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <yangyicong@hisilicon.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZJt7GhV4IOLvRhhr@Asurada-Nvidia>
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
 <ZJsXLFtH8WkRK41w@Asurada-Nvidia>
 <1b0c9677-4e2a-6767-f8f2-23081e6af3e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b0c9677-4e2a-6767-f8f2-23081e6af3e0@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d119017-ffa9-403a-b1c7-08db776c7e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWt4R5sO1AotkOVF3ewUQj/XMcRFU0TdeaXwS1DtZPszG63Ai38p+3m0QViSbCHJilfUJTLR7Dz/WWp1on5RhCGhR5OlrgLLkRtA2ouuSnlwdKASYUtWCW3fTDP2Q24KYCN9Tckur94hU9uPJciQKX/fxPNK6ZQoLaWldwXU/0H1UAgES+ZzgFEhpBU/ri0avpzTrk+Evl+pK82LTR2Cz1F0ezgGijHwDlXpOhu1Vd4qWp7kvPXngiseIZa9gTGX0xXJeUiVACSajkFo7WCCjIQyUub4fmF9zvF6QQzh3Y3tkjdYbZkAcoBhpicDBt4mx1ddeRhbsW9SqVShrswHlL3NjUIcUO9UK1KurqzAn1NS4ADd99jo5makpSV3mt0imljdbJ2jFMxiSQdGdqHwQDJRwqoyjH2b0HQTFkBs6ahF6r5oJX8kH1QH7toXamJFjn/zGCXXZVBWrP/2T6N8d2j7nIjW2kPla+rPbvi83We6rRrZc8Ue6gbANKGpDR2UIJYPg+9UOoKkPP/LQv+fnSk71854Nqsm7AvfIczCoNwu/0gx1biMAiMWe2G9WDgQ+aJWtBw1aS/YDHTyXusxljty5JVkHjI4L5103zCalab/vzch7drWhmx9kT4lgznSfUrUADQIcxR3sf9W75tgDZWthhn/4u5cO4GVfIjghROJ4vxOLoOwI0qK2qnuAON3eDLkeplr9VXMdwdjHH4DOwvGMVnmpF1kMWrfGiBvnHMzz9bYnK/pIzvhHp/Hk75zQ5vBmz6IdA/qL6oWWi85tw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(66899021)(41300700001)(36860700001)(82310400005)(40460700003)(5660300002)(356005)(33716001)(316002)(6916009)(4326008)(8676002)(8936002)(40480700001)(86362001)(55016003)(7636003)(70586007)(82740400003)(26005)(47076005)(70206006)(186003)(9686003)(2906002)(54906003)(336012)(478600001)(426003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 00:13:26.0860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d119017-ffa9-403a-b1c7-08db776c7e52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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

Thanks for the reply.

On Wed, Jun 28, 2023 at 12:29:52AM +0100, Robin Murphy wrote:

> > > > Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
> > > > to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.
> > > 
> > > Why? The "default configuration" is that the S1 shareability attribute
> > > is determined by the S1 translation itself, so the incoming value is
> > > irrelevant.
> > 
> > That was for a consistency since the driver set the SHCFG field
> > to 0x0 (STRTAB_STE_1_SHCFG_NONSHAREABLE). I was not quite sure,
> > in a long run, if leaving an uncleared s1_cfg->shcfg potentially
> > can result in an unexpected behavior if it's passed in the STE.
> > Yet, we could be seemingly sure that the !IOMMU_DOMAIN_IDENTITY
> > means the S1 translation must be enabled and so the SHCFG would
> > be irrelevant?
> > 
> > If so, I make make it:
> > 
> > +     if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
> > +             cfg->s1dss = STRTAB_STE_1_S1DSS_BYPASS;
> > +             cfg->shcfg = STRTAB_STE_1_SHCFG_INCOMING;
> > +     } else {
> > +             cfg->s1dss = STRTAB_STE_1_S1DSS_SSID0;
> > +     }
> 
> What I mean is we don't need a cfg->shcfg field at all - without loss of
> generality it can simply be hard-coded to 1 when S1 is active, same as
> for stream bypass.

OK.
--------------------------------------------------------------------------------------------------
@@ -1350,7 +1350,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
                dst[1] = cpu_to_le64(
-                        FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
+                        FIELD_PREP(STRTAB_STE_1_S1DSS, s1_cfg->s1dss) |
+                        FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING) |
                         FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
--------------------------------------------------------------------------------------------------

> The only case where explicitly setting STE.SHCFG=0 makes some sense is
> for a stage-2-only domain if a device's incoming attribute is stronger
> than it needs to be, but even then there are multiple levels of
> IMP-DEFness around whether SHCFG actually does anything anyway.

I see. Thanks for elaborating.

> > > > @@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
> > > >        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > >        struct arm_smmu_device *smmu = smmu_domain->smmu;
> > > > 
> > > > -     if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > > > +     /*
> > > > +      * A master with a pasid capability might need a CD table, so only set
> > > > +      * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid master
> > > > +      */
> > > > +     if (domain->type == IOMMU_DOMAIN_IDENTITY && !master->ssid_bits) {
> > > >                smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> > > >                return 0;
> > > >        }
> > > 
> > > This means we'll now go on to allocate a pagetable for an identity
> > > domain, which doesn't seem ideal :/
> > 
> > Do you suggest to bypass alloc_io_pgtable_ops()? That would zero
> > out the TCR fields in the CD. Not sure if it'd work seamlessly,
> > but I can give it a try.
> 
> I think if there's a good reason to support this then it's worth

There is an unignorable perf difference that we see on a real HW.
So the reason or (I should say) the requirement is pretty strong.

> supporting properly, i.e. refactor a bit harder to separate the CD table
> parts which are common to both S1DSS bypass and S1 translation, from the
> CD/pagetable parts that are only relevant for translation. S1DSS bypass
> remains the same as Stream bypass in the sense that there is no
> structure corresponding to the identity domain itself, so not only does
> it not make sense to have a pagetable, there's also no valid place to
> put one anyway - touching the CD belonging to SSID 0 is strictly wrong.

I can try that. Yet, I think the S1DSS bypass case still belongs
to ARM_SMMU_DOMAIN_S1/arm_smmu_domain_finalise_s1, right?

I'd try keeping most of the parts intact while adding a pointer
to a structure holding pagetable stuff, to make it cleaner. Then
the S1DSS bypass case can be flagged by an empty pointer.

Thanks
Nic
