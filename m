Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFECE5BEEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiITUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiITUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:39:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911A18398
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPJYcocHD6bz5W0gO80lzniCRBpJL8aGGyzIlzdadzDvcu0BSjMSFOfN9eZUu6KjPrh3sL2qaPOPTB/o+OORaSEsHdWGC1mnURPztAazPgRGcsYAzvuUHg7y7sDj1ic2rDMaR7hP/9AfqzN9oQkYe3EMtOc7Cry8teGStbgwOye7e4QLsf3h/wenH2HXJV1LO7yB6C1X+9CazYkicd0RQMape70bASrkWDdMHbe13+ETtlXFsT7K4XnPgkUnaawJgVYFUBZFvhk9Fo5jbq7AuCGUA9c/6EFMedxk60nBAFx1exICGb+aNO5PuuvE8UfwfSsn/IVPl/NQkHPzfXbZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yCrwZBJJR/NJ5NPf3n6q+lur4LJfcV6pyOY6FL9pHc=;
 b=EKZYZeL0LJZVtmodIlTjE/CnHMiIwMQdfLwcDsM+pIg3K06PAPMmUKPZzt8RZaax0HLiY5ahCq7ZkODwrC1zJwfOdPdpZBWrkEwKIEwILi56swPF+iHufAcg5FOFmg/uUgfXDC/0mHi/a31/0f3YFCQdME67sC9Gf22kLTQHPMeszBT2VvjEBwmKniYXXEKt8UNPxrJqYfo1pwVWEDst65R4pQlO0knMICBBmMe3hj0JyRZ9k5Ci1J3WBRgDqg8iKWx9kgJnA17v2i45RYfNACfGz7wS+4mfuUAL7ZCS8hL7fIJ/UPBBhvic9H9/bvtJt+1bSk4LpSfuefCdNI+8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yCrwZBJJR/NJ5NPf3n6q+lur4LJfcV6pyOY6FL9pHc=;
 b=doregZUYJmjqVMfoXpqkG9IyU8dD+Tq9B5OnagACgb8Iv0oFRLpoWQo5REhJ91QVxVT4CBQ8sHe2ibAFTUpdyuC3i9J7GqYVw3GsDJEEPzkiFAVpFNB9YI5pzkYxlcBl384yOv5pvm1GGjhJvW3Tnmd4IBEY4R3tXJXedNRq+vs1OFTl0kixb4RiZFz79n53/ubwq8vnjCk+xQuSPUEY4DjSdzlDOBBgovkpODYgc9LuvWFPlg0OG/44ddQpXqt71M39mzt3Tq3EH4ah19oh8qZOT1+0iDEB6go/tInnUd568hDvCOVmsqm5/WqHj4F5TW8AKR7gXDwKSCQq62LLaA==
Received: from DM6PR05CA0044.namprd05.prod.outlook.com (2603:10b6:5:335::13)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 20 Sep
 2022 20:39:48 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::7c) by DM6PR05CA0044.outlook.office365.com
 (2603:10b6:5:335::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.6 via Frontend
 Transport; Tue, 20 Sep 2022 20:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 20:39:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 13:39:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 13:39:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 13:39:31 -0700
Date:   Tue, 20 Sep 2022 13:39:30 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 6/6] iommu: Propagate ret for a potential soft failure
 EINVAL
Message-ID: <YyolAgYPPH7Pnap6@Asurada-Nvidia>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <cd613152e5175b5ffac643ee017b1d800e766d99.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A69368B6E06E2C86EA058C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A69368B6E06E2C86EA058C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 696130d2-88e6-4309-b89f-08da9b484251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KgJU9LF9J1BKZ+ME6XfYNtvKlLhhyG1eUIcyQpzeiTkJoNN7W6qw5u9V+5V9vB0I+QHXTxkySVoa/lHj7Qvj2v77lRFmdDO30RlOJsAJt2FX2leT03Gi0Sxb0+mOatSJLmQOLCPw/OfOMmcTWJMvdl9rUC3DIHuG4ZDoRqa5vRmFDfZ/zhRhZPGxW5h38uXYhXrLJUFm8KbGeKyNqVTBF3KN26DFC4j56j58cIjRYQGPBWKDCuAJuqzqA621rDTNayP+5LHFro2ucFvncPeqHbPfAj9eI0j6B7ZSYQkVmlZ23pMKRrG39gOVPi8MYBShWafkqODSjYEqgtEdtx1AzMnlCueuOkQ6xZqQx0fQEcGBU2roCobjZ44JqqHhYMAUM0L5JM4ygCLv5UO7SfzjLFHJP5SdfO9a/YVAYqAuz7hBjHxPbU/vfpZ/R2VUgICYs2Vsu+FHDdBR/aHcQjZxatH8ozCzCwFuoDnq8ep22lM3MuSIsX2Lfw/BjKj3nBHt8fZHZdeRxJ7sSiR8NdbZ0ycXepATsB2mcnLWh5pjnT2sggomPgpqeeJVTiYymBnXmUnh4IiTcnadVqr4i98KDFOJDugrv7TC1kBsNpnp8YJ/ivYFKt2RoqMLwWcSjHVyLK13xXwTCn2bLNJZXucPpAgkJyB/jF5Z/rZYV3kOQM8FfCCaVLueZYue/9E1e3THMdK+WkalmV8oAQ+ZBWOJLs7OLgEKqSlVj+xGiKbXGhoxAu0mbzfqgjRUcBwwQD1ZqvsyXcvFMVyKqNDUjjaXg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(83380400001)(356005)(336012)(478600001)(70206006)(36860700001)(86362001)(70586007)(7636003)(4326008)(316002)(33716001)(55016003)(8936002)(82310400005)(186003)(9686003)(7416002)(5660300002)(40480700001)(2906002)(54906003)(40460700003)(47076005)(426003)(6916009)(8676002)(41300700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 20:39:47.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696130d2-88e6-4309-b89f-08da9b484251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:50:22AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, September 15, 2022 3:59 PM
> >
> > Following the new rules in include/linux/iommu.h kdocs, EINVAL now can be
> > used to indicate that domain and device are incompatible by a caller that
> > treats it as a soft failure and tries attaching to another domain.
> >
> > Either mtk_iommu or virtio driver has a place that returns a hard failure
> > instead of the return value from the function call, where an incompatible
> > errno EINVAL could potentially occur.
> 
> in both cases there is no EINVAL returned from the calling stack
> 
> IMHO error propagation is the right way even w/o talking about EINVAL
> otherwise we may miss ENOMEM etc.

OK. I changed to:

The mtk_iommu and virtio drivers have places in the ->attach_dev callback
functions that return hardcode errnos instead of the returned values, but
callers of these ->attach_dv callback functions may care. Propagate them
directly without the extra conversions.

> > Propagate the real return value to not miss a potential soft failure.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Apart from that comment,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Added this too. Thanks!
