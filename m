Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3217B6B33AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCJBeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:34:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E91E0633
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:34:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjRLgdBN/5juouuqY7qN6KfcGBT5Dfj/79zT3KqdjHMCNfVrF6DCILuW655avknQatPg2wRgpVFIofzhWAXfyqE8vA1/fT+wuziQDLsusiAs9esx1iAonF+NgnqomctyhGDj70pUBYvztSuosETo7+rvfnggUnAX0Xm41hLwH6HD4guUPYW7AUtngETwmVit+zdVMnL+t6HA2ljwI+G/qi/Xw3YT40We2trZ2dv2nwY+wghdR9Z0U9WBi6lk0q2tXi/BszMmp4Q+wJNprC0yOSgSufZYnZLPL4yH9vsXYg9+HyJFVqMeT7hPrcoKpl3VwNFnEVYdTaltqAPPqutX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU46cL6gXjbstDP6l/Aiv1VL8flKL3Ae2bSqeZMUH4k=;
 b=kKyDU+m0FhyZXLPwalI1+9hmZrOUxMf8iADTYSrCR8emF1DGXdzZdFI/fr36np07FWxIp89nP/5Ado8BLwoia0EWr4JrW11wXJO2QPC2hKXtIQmzhbvV+SdJdhRV5irEG2rryFEq7gVs7+3H7DsFwEUbDr2o2gJsalCAJnLeyj4ij6FCjFAX8A0o1v3HSt1rLN7jZufDM4CMAEF2aJAnQCWXBG7qsf4uOxjRTM7gZigRXc06kslYzzt6nKMr8E/6NgzkZ3A1uHRwCpGjk//aqTS07m/Ks2vTKQzsS090sEwWI64GaQsd+9dYDhnzDGXc6VSyea1OKAKNPkYQpAig7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU46cL6gXjbstDP6l/Aiv1VL8flKL3Ae2bSqeZMUH4k=;
 b=Bvnxv7VU2kcMfmvPoqn/e1rHduXxWydZYZM3MluU7V1b9MAmIepFDbYQt9MUVvZUiYpRZcemvBh02/KWk4F0EcWVY5AGOOG02UnLLv+3sdbmGK2Z5Lb48r5N8lxktlaRVpKZqfvdSRrnK5rx+b1GpqvxtWL+9BeZJDxPWP4OZ1VuouUVzyeorU8aOr8VPBdvOTesKjPQR+I0mNDMkHugp5N/4KIzgbDmVOfzzcM+GZ6igLO+YzlDwVR8ARChPYgYSultvq2H9BMP1Bg8pTHlG2teY6ARzeTDP4zyxO8gXk7jU2YoZga9lBTEVPSTh+5qxPdudzADrnHTG/Sp0tMULg==
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:34:29 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::df) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 01:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 01:34:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 17:34:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 17:34:16 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 17:34:16 -0800
Date:   Thu, 9 Mar 2023 17:34:14 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Message-ID: <ZAqJFhwxx7y9Avwn@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
 <b8660bcf-7b12-fd49-7b5b-58909ac8746d@arm.com>
 <20fb0697-fc0d-daab-2517-7bee7415e695@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20fb0697-fc0d-daab-2517-7bee7415e695@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eeb6f3-8530-4988-4f3a-08db2107972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aSAcVPZdVpQQLCbpiuehZh0txs1bRXC63TRvPFl1JJs+LsR2oOk2Pla+olExJz3mA2RvzHHgxs4hbvefwcInTLeK0eH+TfhQKGV/FQS5tvMtxgwVgVCGEC1EkughukofgfKCL/HwYFeneEZF8fZ3U5/Cq4iwh6+s6yKL3RRtscPYD968gMUn8O53dSuZYdumvChjZpmtdV7Nt1WhlkGDZ6s6vbAk74auij9iCMfhvwg2AS9c2/mnP7FJac4Eo/nuxz8vMp4eAJZI3j+db4OqWz4kiqMJjyf36n+HAFc+1HPhSAxfxF5WJPQe2iH3HF+/pbGPnVxd/lz1LQYajYWdD+g/1nnkKl8HBDS0kcC0p6EXm9m8PmH9/1UaHJ50BrAYHWhYNrpxJLuLUK45Bel9ISE3kKQkljwuXI43jXeLwoE1yafnshA35T/brtdv0/TA9pzwDMAT2yaRJRbGjeS3gpmkW9wXug98TftyLmLRuSWMuzUNri5rpPnzvlWnx+X77yUCpJS5s0WVCM+Gwog+yDcAqjhKEllyxtFpj2+38FqMqTbp7TQMgbMxapUkJ4uLMgmhWItN9xTiXkJm2svHlEXwAGfd6Wrtz7tnGzy6XyiCyH9F+25/RQsxdoh1ujklWNO39r3vvoJXWcDOxqpBSe2OWpYwbKFDoDyZ7pyAguXkvPO8ojFTS5RYOHx8iUoPREcpV5ki44uH13v2z9WUz4QIqb7HFrKWhGVCQPHSffK6KNuliVK7McCvflzBbUZY+6LEKT27jXr10+AVagjLA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(356005)(54906003)(478600001)(316002)(5660300002)(7416002)(8936002)(2906002)(70586007)(70206006)(8676002)(4326008)(6916009)(41300700001)(82740400003)(7636003)(36860700001)(40480700001)(55016003)(86362001)(9686003)(33716001)(186003)(53546011)(26005)(83380400001)(82310400005)(336012)(426003)(47076005)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:34:28.5933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eeb6f3-8530-4988-4f3a-08db2107972c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:28:09PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-09 13:20, Robin Murphy wrote:
> > On 2023-03-09 10:53, Nicolin Chen wrote:
> > > Add domain allocation support for IOMMU_DOMAIN_NESTED type. This includes
> > > the "finalise" part to log in the user space Stream Table Entry info.
> > > 
> > > Co-developed-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++--
> > >   1 file changed, 36 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 5ff74edfbd68..1f318b5e0921 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2214,6 +2214,19 @@ static int arm_smmu_domain_finalise(struct
> > > iommu_domain *domain,
> > >           return 0;
> > >       }
> > > +    if (domain->type == IOMMU_DOMAIN_NESTED) {
> > > +        if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
> > > +            !(smmu->features & ARM_SMMU_FEAT_TRANS_S2)) {
> > > +            dev_dbg(smmu->dev, "does not implement two stages\n");
> > > +            return -EINVAL;
> > > +        }
> > > +        smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> > > +        smmu_domain->s1_cfg.s1fmt = user_cfg->s1fmt;
> > > +        smmu_domain->s1_cfg.s1cdmax = user_cfg->s1cdmax;
> > > +        smmu_domain->s1_cfg.cdcfg.cdtab_dma = user_cfg->s1ctxptr;
> > > +        return 0;
> > 
> > How's that going to work? If the caller's asked for something we can't
> > provide, returning something else and hoping it fails later is not
> > sensible, we should just fail right here. It's even more worrying if
> > there's a chance it *won't* fail later, and a guest ends up with
> > "nested" translation giving it full access to host PA space :/
> 
> Oops, apologies - in part thanks to the confusing indentation, I managed
> to miss the early return and misread this all being under the if
> condition for nesting not being supported. Sorry for the confusion :(

Perhaps this can help readability, considering that we have
multiple places checking the TRANS_S1 and TRANS_S2 features:

	bool feat_has_s1 smmu->features & ARM_SMMU_FEAT_TRANS_S1;
	bool feat_has_s2 smmu->features & ARM_SMMU_FEAT_TRANS_S2;

	if (domain->type == IOMMU_DOMAIN_NESTED) {
		if (!feat_has_s1 || !feat_has_s2) {
			dev_dbg(smmu->dev, "does not implement two stages\n");
			return -EINVAL;
		}
		...
		return 0;
	}

	if (user_cfg_s2 && !feat_has_s2)
		return -EINVAL;
	...
	if (!feat_has_s1)
		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
	if (!feat_has_s2)
		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;

Would you like this?

Thanks
Nic
