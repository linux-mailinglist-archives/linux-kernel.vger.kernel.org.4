Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC26BC33F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCPBWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCPBWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:22:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910460427
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdsOc9lAUDbevp4pcHFlhv9X0bg8/I08A9lhVc3fdSqkKkFXjWv2MjzmCmjNCcZKc4hUU9V2OqjnA76jcPxTX/uB7P9yKITLaljI1hDUX2Z73dCDuTgSXsfyk5+6kS9/hfk+1OtJObXPvxCDzI2sPsj8JThen5fMAI/veTQLoUqhH1Qfd3bzfMD+FAMhncAZCwfrusEeGsIOWA2tOhcHer//8MLMDDUYPG3IKMcAHdYLt9VPnuQUDI9UGoNsrdQjQTkdJrbSmt1oddmPkEhED+iicmpRM3+g5VqzwdviDB/rF/J3nMAhcbpE2V3/MhQM5toYbRz7ytmPSDjC3k04OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwB6YnOKASOV4v38BP7805qFvMCJOpR6ef2nU015n5U=;
 b=gygN+/rc4ApWllCShMeu5tqDlOcfK65KzhzTahP6gY2S7wFippLJxZ5wc2W8fneZBcswk658aVrThftxMgkXBqXiH9nrdyKW8hR0/+4Pna4JKVk//dUXZZ2Y6wwCm86WU2/u7fsZd8J5KTjulvAfNQno4Tnr5XSvzdtg5H5DSfHDt+8pzIUxDCGAIKs/w6ZYBtxXpXQSE2ShS0+anwcyu6/gTNwLSdtZXI1cCNlowYV2ql460CKTsgWOuogkEKrKKzbImeOYZHr5C+/0UTD1bqlKEPiJDt4vXSmhAygcl9HcYNR2f5BILBxKHE/i+hU39Mw1c0bF8CyU8lbH/pqEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwB6YnOKASOV4v38BP7805qFvMCJOpR6ef2nU015n5U=;
 b=sFdwrfctGRFbo35pwLViszh3saP5JgEXRnTfFZzS7pSQ5rpW0kmPmsRFXkKjuOb+v864JEmWNk9FJr+JnQqhH9h66KuroOP3QB3LNNZwBgIHVfy9XAX1AUtPKfdzau6/xZuV2Yj1ZolIbPjZ7z0cstVsXn9Vv9LARy+YO34ON15L7LAIX2GyL8yrID+8+pl7DJWAJgBvg8Sj9uLJfy5oI/XBsx7d2T6kpfllmc0CHMCBGqM9C5DebrSLczQUs7r+HlUAHTw71v68e8sG2nXuPRLT0ueUGGz4E7dR6Lra6qY8l68KYQATrTaABuEc5mewtVD/9cMDvTQNdHUr/H6y8g==
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 01:21:57 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::9e) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Thu, 16 Mar 2023 01:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Thu, 16 Mar 2023 01:21:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 18:21:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 15 Mar 2023 18:21:52 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 18:21:51 -0700
Date:   Wed, 15 Mar 2023 18:21:50 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Eric Auger <eric.auger@redhat.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZBJvLsfeIRhV6cME@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
 <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
 <ZAtS21vqhp7LqA+B@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAtS21vqhp7LqA+B@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c334826-2b96-4bf3-090e-08db25bcd57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZew6Zii2Dq2p0x/W7c1YP+VCzM1PupaWgxMerVZXWLTOjOlNf9Botd/U0uuUnMcXtrQsCVwQXnSNdT1Z8QMOkg0q8FGRFfjUqVGKWeMdJwozJ0LvC8lHdQHtgjEvoUBu4k4xSaSepe7H0qiJOfNGkxH2LlnPIfUDnyrlyWz/hD4V6kIspw9cA1HhmidJx2DPXLIW3/UaOTrNaTxbq0NPLoM69T4Fu4yIlIxGc8rnPpOlYQKuG3A0lI0+hoI18eIH/iDF2zM4umZYmysO/Co2L3SpD8jP9Se5nkZYiZM7n/VY6I8rD2PwNl3TCvg+Oi+7uJ2ucqwagnifPB5gCFqfFwQwfjX1e81+9Y5ToktjHdzD8MOMm7eEC441Etu8sRmHKlCmnZCI12x2gw9dLes0GsLMmIJNQJyWdSsSWO2dL8zdMEqNi69nbdXpsMyzvBs5vUhx26U/tUqnBn//OpzycX+2rnxR0yGCYDroHPDxP7HUEdZDt534W8/NFGcuegI2xz3fCsJggUi+4F1WSMDezbdAoUrzFJSlH40G6XJcY6QQKmTjrvRBTedCaivB+Sna6jKMuDS1gR20d7NLGu6w1P7qUHcOMB8KnNMvRk9y8X0Z0BZ3/sWHlSdq6nlGRvzGWQZJJgd0FCmlbo45GigZ9XmfzYEVQ9lorbFh5UtI/JRcMA4ZE9e60zpEmez/sqB6XBV+wuTKqSqpdNHAvNZED7ONbPrw0fyfAssJwblrpNa75wwbz5j4zc8/g6ngQBTmanKlruXhExe6c5s7BsLzlnCcpw/15Ng0nsp25Nq+uWo/Sm0NZavJBGlSOGxXSFKpa8JRttLLy1qnB3KBK2BVw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(356005)(36860700001)(7636003)(82740400003)(41300700001)(2906002)(7416002)(8936002)(5660300002)(4326008)(33716001)(47076005)(40480700001)(40460700003)(82310400005)(55016003)(54906003)(26005)(336012)(186003)(426003)(83380400001)(316002)(6636002)(9686003)(70586007)(70206006)(478600001)(8676002)(110136005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 01:21:56.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c334826-2b96-4bf3-090e-08db25bcd57c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

How do you think about Jason's proposal below? I'd like to see
us come to an agreement on an acceptable solution...

Thanks
Nic

On Fri, Mar 10, 2023 at 11:55:07AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 10, 2023 at 09:41:01AM +0100, Eric Auger wrote:
> 
> > I tend to agree with Robin here. This was first introduced by
> > 
> > [PATCH v7 21/22] iommu/dma: Add support for mapping MSIs <https://lore.kernel.org/all/2273af20d844bd618c6a90b57e639700328ebf7f.1473695704.git.robin.murphy@arm.com/#r>
> > https://lore.kernel.org/all/2273af20d844bd618c6a90b57e639700328ebf7f.1473695704.git.robin.murphy@arm.com/
> 
> Presumably it had to use the iommu_get_domain_for_dev() instead of
> iommu_get_dma_domain() to support ARM 32 arm-iommu. Ie it is poking
> into the arm-iommu owned domain as well. VFIO just ended being the
> same flow
> 
> > even before the support un VFIO use case which came later on. So
> > using the "unmanaged" terminology sounds improper to me, at least.
> > Couldn't we use a parent/child terminology as used in the past in
> 
> No objection to a better name...
> 
> Actually how about if we write it like this? Robin would you be
> happier? I think it much more clearly explains why this function is
> special within our single domain attachment model.
> 
> "get_unmanaged_msi_domain" seems like a much more narrowly specific to
> the purpose name.
> 
> int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> {
> 	struct device *dev = msi_desc_to_dev(desc);
> 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> 	struct iommu_dma_msi_page *msi_page;
> 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
> 
> 	desc->iommu_cookie = NULL;
> 
> 	/*
> 	 * This probably shouldn't happen as the ARM32 systems should only have
> 	 * NULL if arm-iommu has been disconnected during setup/destruction.
> 	 * Assume it is an identity domain.
> 	 */
> 	if (!domain)
> 		return 0;
> 
> 	/* Caller is expected to use msi_addr for the page */
> 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> 		return 0;
> 
> 	/*
> 	 * The current domain is some driver opaque thing. We assume the
> 	 * driver/user knows what it is doing regarding ARM ITS MSI pages and we
> 	 * want to try to install the page into some kind of kernel owned
> 	 * unmanaged domain. Eg for nesting this will install the ITS page into
> 	 * the S2 domain and then we assume that the S1 domain has independently
> 	 * made it mapped at the same address.
> 	 */
> 	// FIXME wrap in a function
> 	if (domain->type != IOMMU_DOMAIN_UNMANAGED &&
> 	    domain->ops->get_unmanged_msi_domain)
> 		domain = domain->ops->get_unmanged_msi_domain(domain);
> 
> 	if (!domain || domain->type != IOMMU_DOMAIN_UNMANAGED)
> 		return -EINVAL;
> 
> 	// ???
> 	if (!domain->iova_cookie)
> 		return 0;
> 
> 	/*
> 	 * In fact the whole prepare operation should already be serialised by
> 	 * irq_domain_mutex further up the callchain, but that's pretty subtle
> 	 * on its own, so consider this locking as failsafe documentation...
> 	 */
> 	mutex_lock(&msi_prepare_lock);
> 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
> 	mutex_unlock(&msi_prepare_lock);
> 
> 	msi_desc_set_iommu_cookie(desc, msi_page);
> 
> 	if (!msi_page)
> 		return -ENOMEM;
> 	return 0;
> }
> 
> Jason
