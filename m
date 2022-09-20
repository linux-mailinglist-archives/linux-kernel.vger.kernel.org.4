Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C95BEACE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiITQJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiITQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:08:57 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5963F29
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX8h5f8N30JIYUeqE+XMSVRWInHzdK08QCmk8sR9aBMHk8AinLy4Z+gF7jEoQYGLac+GAWZvMAtuaCWD7mvJcShDCvt43EHbaNosJYj4yaOceSP9XXiEPctz7UdI7F6Cpg+2AoKxrtzLF4aLZVpFBAV8g9A1KC/mLYjVxbL1J5Qj0jAkwdXbw52G4/CM7lIOIzp4omtQ0tCcjEOYTms39lOJ1ISWF9ss+307ea91sF1Ux4h22X4HVZnO+8myknQNFoSgXf0Sbtx8Ik4tViTC6LPAidd/o2Z1Ik9TRxYmZavfXjUxLoZwrEmLOzg4aGxh02XqKp9HDD++sgFUTDWJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCJs0Ez8XRGvVxWXV0IiFWq6SxmnIM6tM2AiML/jJU4=;
 b=P/5Fs7Hig/j7mR0KuXU05S8DHt7MDXJT2RDnL8M3h02l6WFYg4Ps4+qQhEXVEKEZy0b6DiJnqae0MfJ4wuHBYJe9YbSJ4GSF4GKl+dDRD/XUoxMK4QJWUMY/qv/p9cpKaebjBnQOfkHa1wZpqGb8FeZJu5wzuqtxH3p1UmCxUg+2nfVvS4sZrKae8I4ZZBowE7k6Qp0vc4DSmcv/uEV1jyF9vyfdvprrYk2Gqh9NW7re4iYEUSnFhCy/KDEgII8udd046GEB678NOMjMGoV9iGyzAVpe5KzDz2chPXb/8Qsm03t/Zpd+CTgy1ZwSgfE8MNnfchF0M8uVsFLHCmVpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCJs0Ez8XRGvVxWXV0IiFWq6SxmnIM6tM2AiML/jJU4=;
 b=poUJZ5SNFmFzD/y6/v+hMdH3xCCQ6477U8gTPkx88MOKiJDcM0dzbSZecY8VufvEfjstfp6HT/D0qMMMbawgoWL8iZXfvzPEKT71dQlA9jfFlBX5DP08Lrq6YuQCVDdltCuUKmNg4imnV1Vhh6r4UCBzGg0QhNaaUBsETlzETJG6829L1SOWg/vvAopa8q1QwJ+MCheMaCcD3RwAVpGTHETj+iIbhEktugrR3hHxy1Ws+vomIOyqxYAPwZtXQ63wXmsyDAE3eGiW0zZlasmuX+SW9MQLWmOJZCHsGATzLT4OlNmF+u8Xfeug7mcJwc3EJjzg+HpCrD4FTEKu7I7JsQ==
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 16:08:53 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::3c) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 16:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 16:08:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 09:08:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 09:08:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 09:08:36 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 09:08:35 -0700
Date:   Tue, 20 Sep 2022 09:08:33 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/6] iommu: Regulate EINVAL in ->attach_dev callback
 functions
Message-ID: <YynlgZgmv26dc3GB@Asurada-Nvidia>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <253f8098664f78f5b5a8a7deb816af8ad7d37122.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB52768A3239F75290F7842D0E8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768A3239F75290F7842D0E8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a532ae-2bf8-4f21-e6ef-08da9b2269e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NsBA/oMzTtKlqYf/Igfb+KQC2SFR6h1VOFTAjMHv9D8p+gKCbbI6z6SZd8kSEmbIG/SOgvhZnqNFypTJLqlzlmoCMB234wTVPXQo2806FzxM5KcbvnHGjVCRCHRBny1gVV1KdygsLYUU+pKCS6KW6OicMhr6AtcySFHuXhiiMM2eob3ofxKhiaqxedR/0xzm5W8efWspXa35LHCYvh6bZtSlbG8tqcoEvPh/bleOY2PEHk9RIwnJk+EVrranb5eNWQbxnVxi9q6VPmNs/TYanCASk+P6YqVc7LQ56lxo9L9sQ2pSw8qWZXTzNXUbZ+J//oSBGn9kG378Jq97BzcoC2MG+AAYimgpqtKzU22UGTTekolJpnADYGVlB6xavocTLiGMX3lx3l2EvU/DY3So/+1EQRQuy+XYUJXR2Yj9gDNgsV2q0kQG7qyeh/f+DGKqXwk/rlUmoPsdzdA4Sryph4Wo4rjfpvzuaevVqtvU10e8WNwQ94Slvu19Glt3diiqn+6+JDv8Y3sEKWyE75tujyrILiS/ZXUHc6Oz7GVQZwNtXDAbq6RAy0Ob4OeWjcwqst5Q5YVfzi8IT84lh/G+whzcREJPILpJ+HOQ2W+zzZZgLPT0RPxv9DYBvqNo8Tbuj/2ZoOhn+qEzZegtFryLa1BcQaOWZcqEGC+z0C7yE5RmF5jieXxfr8m6n+lLbeHBoQfeZOyTjeLMyYK7uVIxWHBg8055OBXFdlzKx8o1natyOIk6VBkQFGk+20rr6QMZZkMM7G3t/cN0/d5zMw7oA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(55016003)(86362001)(82740400003)(7636003)(6916009)(40480700001)(356005)(316002)(8676002)(54906003)(40460700003)(8936002)(2906002)(4326008)(7416002)(70206006)(5660300002)(41300700001)(70586007)(426003)(336012)(82310400005)(186003)(47076005)(478600001)(33716001)(9686003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:08:53.2092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a532ae-2bf8-4f21-e6ef-08da9b2269e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:29:28AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, September 15, 2022 3:59 PM
> >
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index c5e7e8b020a5..4cadbd744b7f 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -101,8 +101,10 @@ int intel_pasid_alloc_table(struct device *dev)
> >
> >       might_sleep();
> >       info = dev_iommu_priv_get(dev);
> > -     if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
> > -             return -EINVAL;
> > +     if (WARN_ON(!info || !dev_is_pci(dev)))
> > +             return -ENODEV;
> > +     if (WARN_ON(info->pasid_table))
> > +             return -EBUSY;
> 
> -EEXIST. It's not a busy condition which might change sometime after.
> 
> btw below -EVINAL in viommu should be converted to -ENODEV too
> since it's a check purely on device side:
> 
> viommu_domain_finalise()
>         viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
>         if (viommu_page_size > PAGE_SIZE) {
>                 dev_err(vdev->dev,
>                         "granule 0x%lx larger than system page size 0x%lx\n",
>                         viommu_page_size, PAGE_SIZE);
>                 return -EINVAL;
>         }

Fixed both places. Thanks!

