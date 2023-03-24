Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6BE6C8403
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjCXR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjCXR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:57:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3781CF6B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6Oe2S8FoI6bTmVQXjgRKj+AbVG+C5/KOr7HH4XgjPoBqoZdtqa4yQKsRwOqd6SJcQdGFcqunxOko6s2Hq2jddLVP7W8X4Jqixp2LgE5Ywe5dUoDlK+GF/L/1Awbd9ZfjLGRhJVUpN8AVqbon4duieqbM3EYeHGcLFAJUsNuljIG1j3G7V8URnGiNWu+XoEDHYUSTS8tLKn0LqWDAgBawgHxptIQFXdObB/7oS3JjHwBTGUmQhMI27up84nFjTi7sgx++g8q//1bevd5Z9AJGagI/5ucYmiUfeXYTgpOJswTJqOSkYZENYPwlkY4BfcPwAvLBdtohP69KtSJd0F0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKpVwj0GCYlG+krAa5Brt8JnHB9XjRp9le+tjEGnQhw=;
 b=IY4rF3Ug7/WZpd1W7bV/nMJaRmut4JN8Kyb1VVsIbkMfJo8AZkmeR4ixZDmEBoiVi2jkrEVIfSEdZPpISu19zs/vRNrzzeHQMkZ2ObGyvQTGyt4YJdkAXXXpjXmWTXLZ/8YlV/+zjBJx7MVfx0YLxTn818AU8AQEIh26MHO/uxRDTuJqMk8AD5uwYJjWFk8L7fuH6L/jHniGXfMNGLiRsMx3mM/T0g6sf3IkCiTg4I8nvu3g9Bh5pYPgvY8pOp2d9A07hZLKZSDVK8nQaI0WBi3q0EN8pBP57pWKImaZanR56G++By4KjhLMrDAYyD3N3pGlATikTenqkhTDr4yhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKpVwj0GCYlG+krAa5Brt8JnHB9XjRp9le+tjEGnQhw=;
 b=ZWvfw0JVRGxtaL0H+TaChcNIJiU+tesH1C4M1B+LuM7ySSFUaSis3xsEUFRwV+9yJWCltHRw+ssUqLdKUM3rs+7knUm9Heo55iRxyvrUY5GxoNofpanN3m3+j75P3gv35HzqflAhRgN1cRlExCrtvi4TuJlVWpCGeFJhTWCeZG+xwh+u5cadzav4XhrMnzcTtdb98ChQeP+55VtnK6E8I3K4HfhRAOwKz4WLY0I4DrqqWCRcum0COVl340ZU8lwhbou2XYzB8MSNac+IwtkjahKFEMpefJGv1v+7U9Qla3pYsQPrSUpOeMWn68176kMvXIJ8+cF4lXa/2PsIGb+I+Q==
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:55:42 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::fa) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 17:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Fri, 24 Mar 2023 17:55:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 10:55:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 24 Mar
 2023 10:55:30 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 24 Mar 2023 10:55:29 -0700
Date:   Fri, 24 Mar 2023 10:55:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Eric Auger <eric.auger@redhat.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Message-ID: <ZB3kD//ugNBy4En7@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
 <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
 <ZB3i6r7QD4NVBXkK@Asurada-Nvidia>
 <ZB3jMSOL5A+E5D82@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZB3jMSOL5A+E5D82@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|CH0PR12MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2eeeb9-9030-4a29-547f-08db2c90fc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxKSiEK/gPm0kpZM0nDYRkH+/I+lvzkDhk7YYQesDzVw9iIMXSQyaxQJS9H5ea10YmIXxaB8YKnfhvDFVnUSi7cZFxXkUtJYTn/J/roiEFChiFUji9+1kbvLS9Eiy663NlShuXpjv0dRimxKYZXo1baGznzQ6uH6ckZq8/lolQW9twieZX+qoDJE/Umwik9WAKTHUvYFtSg62DNnZla+sOA6UlbmckOjvMT47wjA3hg02fpA65jEI1aU+Qs9+v5c8zLHgjkysWxIceWJAnK++dNxDBnOrOXhIxioBFgyrdzrV2QNeWqHQ+LMlZh59PA7Wk0TuG/FndKAPKGw0WB0ME0gywn219WE1fOKh6Gk8Gpi5c738G/VMmGeiquxCXeAegfpWBL7eZJvdRhZbOoEhiCPSoQ5ue8/Y2av7gCLYhsle3WaVW5358+6+mfTDa04ByHvLFMS5J4H3M5hv1KwWHTYWwtwpE0rBG0k0/RmQafj6wS551RvAWL+IPxfZwfnb1TLCNp/oJwDoizpAjchLMxacaOjx3KWo+nMXXSBKCO/UyOd0BPAiDsUe5gvtfT5Tc7t4hxDm8WoGZGLJcWTGdVvYzvA8oJ+e7RsLxXxIO6/ifdTQ5BElQ6cOBJD/lBKNAyC/DtZm9o36n3d6L9FIVkejv4fqO2chi3OSvAgObhbd4TcTKSX9C7TBldKSEfNg7NrKxjsPbWCI0wtghZxMHs6A3M643dkbeEkDW3QTbkbeh2UTTw7ux791UTeFJxy
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(8676002)(41300700001)(33716001)(6862004)(70206006)(26005)(82310400005)(40480700001)(47076005)(55016003)(8936002)(316002)(478600001)(70586007)(6636002)(336012)(186003)(9686003)(426003)(54906003)(356005)(86362001)(7636003)(2906002)(40460700003)(36860700001)(82740400003)(4326008)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:55:42.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2eeeb9-9030-4a29-547f-08db2c90fc84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:51:45PM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 24, 2023 at 10:50:34AM -0700, Nicolin Chen wrote:
> > On Fri, Mar 24, 2023 at 04:44:58PM +0100, Eric Auger wrote:
> > > > @@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
> > > >       const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
> > > >       struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > >       unsigned type = IOMMU_DOMAIN_UNMANAGED;
> > > > +     struct arm_smmu_domain *s2 = NULL;
> > > > +
> > > > +     if (parent) {
> > > > +             if (parent->ops != arm_smmu_ops.default_domain_ops)
> > > > +                     return NULL;
> > > > +             type = IOMMU_DOMAIN_NESTED;
> > > > +             s2 = to_smmu_domain(parent);
> > > > +     }
> > > Please can you explain the (use) case where !parent. This creates an
> > > unmanaged S1?
> > 
> > It creates an unmanaged type of a domain. The decision to mark
> > it as an unmanaged S1 or an unmanaged S2 domain, is done in the
> > finalise() function that it checks the S2 flag and set a stage
> > accordingly.
> 
> This also needs to be fixed up, the alloc_user should not return
> incompletely initialized domains.

The finalise() is called at the end of __arm_smmu_domain_alloc()
so alloc_user passing a dev pointer completes the initialization
actually.

Thanks
Nicolin
