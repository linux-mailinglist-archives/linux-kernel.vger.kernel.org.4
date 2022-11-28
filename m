Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D663AA93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiK1OLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiK1OLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:11:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E91084
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWBj/k0D0vrkfyeWL18MmBXx/6wHKvBRlQVPUXbhdrdtzgjI+maDWtu9Z421Q66FacBlFpw7e69dIPHEx9AB5uaX8z1pvIeQuLNtcEs/NNxUSxMMr3EKZ1QKPFGVhwRSins6xmVnLKiyr8q072pBno3YrfXBcBlRUszARho1sow7B5fZr0yF639qW6vyzwfEqWhfP5c9GB148IRZ380NI9Nn+CcBJApcg8/d+pgzt+WHcZygn9tulOMTiTY4StKGf34zgG7rNWY9bR6TWQcJ2KWSbORRENmp7MfTYIHlTPy1NygCHVvri4pLx92licznBUL5ar+l9WN4qGOcal8GwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5ADMEX1NPd9HW7WUGI5mTqM/wGeFDk4r4Y+Y0n2V4g=;
 b=QRWFlaW2Ojni4mT25qhT3g//HIMpmGW+k3fr0tbfc60WV2qT2bmJ4VWSPBx72lJu8/FqUmPNwCbcmn10j2emsR1qJvbhvA8QAvZbpQRR7ar0rz3DrmSDGFPFIQYFZfXur+yFtLY92Or2F/hm4wPouBunf15UF7/yoIHaIAd0DkFmo5k1TkbUAaXNyLpi+d8FQ+VsS0ePbVeXvBhVHjmr8TRFExypKIvBkScS53Td9I7MuXjihy8YMvWGk5trsK7hP6O6CuyiK0RnP1FsQl+Jz/mSD7zs1e89rFtfzqUbEgP1Uc43y+toDwAdJAK5I9puAVvQ4Q18q/r+qgcJr98Nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5ADMEX1NPd9HW7WUGI5mTqM/wGeFDk4r4Y+Y0n2V4g=;
 b=i7BCifDp9299jAk9pwoB3hgs0axWPc7NOuFUKMJm07HqUXA2GUleed8gONtds93KPCTsea0t4kfmQj/ZM4CJkbQKWomQ8LdxbTe46UVWJxG9alczFa/KjoniGxkxeXlglmXVRttoiLw9yA8pjyJRYsGIRSoibTnsBITb8NDgvve9DM0EkUgbmM0zbjIcm3OW/7j3LfHMwKql/LqJwLRQ2M9KP5D88QWsP06MptqReLlhLfg33XpbGrucuIvmijnpGAIhSXd2kJrTO/z/1g9BkCmxAUQFWY39QT/z/2y+qK2xFuioo9drhix6BbCbCTzOsCsCBdsLKAA3YqGBGfjPVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:11:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 14:11:49 +0000
Date:   Mon, 28 Nov 2022 10:11:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/20] iommu: Add set_platform_dma iommu ops
Message-ID: <Y4TBng2SY0eGE7wx@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-11-baolu.lu@linux.intel.com>
X-ClientProxiedBy: RO2P152CA0016.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:10:2c::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c10372-b29c-4a76-6627-08dad14a7dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3AlM4dwSVRpRhb4ia+H2QiCuy1V6k6Pam5HG1PxAmc9Jw09jOsIop1ZBxCQToPWTpL4WzcsaGlQAUz1DBz0+LfyNYWk6sP87Sd4Z2xyaWm9KMFgufOCs3xS2GeiOowPsfVSNJM4GHyU0tGzF6S27UrSpE+g+sCZyAA4cRIdZlSQqC9RfhBf3MJEB5yJ1mygY+Wiutdl6riH49jmiJZZADnSbBTVGbbfLnTQB/p/hEi2ZNxn6XoMZqAotgYvsPe2ui8RhUlFBRBPbJtcq6SWrwZvv5fSi45fneOU+b69C9dNZ0Y6a7svBiYNS33YzGR3eJqhQP7Q0bD6NJO1MflQ8PUS2n2dVO2ANTNKsJ1IXsle3IF0KCrnM0OijRK5TDjK91GbQ783omR1ELF/LXh1QM9Nioj/syGGCGaAtTZRdpwBPelqX9GcSM8/ztFoh7MZm2k21LgxaC5y7sOiLbNU0EUe3l6BM15bWdMP3/Sr2vz+GMHWwXU3ocFIRAJ+Ccld6rx1rbmhNVwge3zqhEOZHtdBbSAi5VlplyItns+yw+8MFJ2R2onulBevntfyOGwFZdFEtsffqO640n+nVt027MYF8tJinEG+2+gS1CQ49f62R5iNYWXA6PQWxwYb9fIub3ZuY5u7RAvdlpq9yi2QEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(2906002)(41300700001)(7416002)(86362001)(83380400001)(66946007)(66556008)(66476007)(6916009)(2616005)(6486002)(8676002)(54906003)(316002)(36756003)(478600001)(38100700002)(4326008)(8936002)(5660300002)(6512007)(186003)(26005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPzMdBg2rrIlwRYCG74w/EtLzcU6gumHvF4Rtn6HvfzfZ0qGFAp0xT8RThrR?=
 =?us-ascii?Q?mr92fQ+Og2ltom0yleLNUTygN709Lhtah8NG6DNmftzi4OfwfSxKJbQ3wgss?=
 =?us-ascii?Q?1tFXZJbIanE3ExCzt4cMblrSDpAVY11PkIq3qZ+fVfJ9S9Rp4bzylxwIpIFQ?=
 =?us-ascii?Q?JLlnD0FxMQT7/MRl4ZRmnLBhLSfpnYANXf8OvXvJ2kzJTTVVvFn3/ltQ47O6?=
 =?us-ascii?Q?mwq+DHdAirLlQo04g6+tQnNkttn0M7JUA5O3u8hAQlY4XjPKaW4lX/bNPHXW?=
 =?us-ascii?Q?Dx41k/62DwQrXkjWNSHWEfPkNi7jQmeInlCNzMAXo2ZIKzLjXs0TlIdsuA9H?=
 =?us-ascii?Q?eoTFZ8zXNFb2QZfNPe4gRwKFJxkV+Ixc30IKYEZaB2lBrUCfej8yQeVmM1VT?=
 =?us-ascii?Q?ko7lrXZfNhn9BnaflTA6Rw29bIiitZg5WkgJxCf3p02ngu48dvnc2j+IUuvG?=
 =?us-ascii?Q?kZQGTvc05kuYEzx2TZL4GmG8c3NyxjOzLHjQusFenMWNreNCI86jHjToejWs?=
 =?us-ascii?Q?VrH253bQTU4R667dw7T4sd/UR1C1YOw3OwNO6OikC/szElQmg4OKsDtdOfXq?=
 =?us-ascii?Q?NB05w34CgD/g7Ex8MCxAn7K5AIuEXrUvfPeVF2sqyS56sMd02Ii41+yKb94O?=
 =?us-ascii?Q?jX187QEmbkiqMD/gQTW0lwnNrJlBh9Wt7TENvyI3Ff/J4vnMnxh5F8YsB7z/?=
 =?us-ascii?Q?TaxGYdw9Y0vfB7K78OhCgjkiDQg6Dvg+Hmqoo7lERmdHnzlybF25tLD3jCs3?=
 =?us-ascii?Q?B16nFg96tl5kP0u5ARkMd43AFvikC2UtifRHCzjsBENtKwZAjiBFB49K0IKR?=
 =?us-ascii?Q?QSuoOguV+RErwdfvqBAxya3qDQl3peAvR70SCswqdbhT7Sh9+5kYv4nhOqSx?=
 =?us-ascii?Q?USK21kxDmurRfGv6MHn0puM8bEypvQtPpNJWeCOe6OzjiMx2GHlduwdu2rNF?=
 =?us-ascii?Q?JYiisQlBQXzvZbJtGguIlPrIx+a6WQBfXqi5yYExQqqFGtNL8MQoOl93Q9p0?=
 =?us-ascii?Q?JxTcCqQIdtWcngtHoyeGxzz7aNgdFMgLDKHiv1TFn11UvX1FTTFvY4LeRkDV?=
 =?us-ascii?Q?0yt/Q1Fb54hUTyLkC35Hnk/bvrJKSpSuS8UNTN01TVBhuSbIJRCdtnXN6OBA?=
 =?us-ascii?Q?cPhN1xIW/rjfpQ0ClZxblQAqf6phlf2JAk/RbcUlwjf+zWsuDgW09li+IIhx?=
 =?us-ascii?Q?jF4I8WohvcUfi6zqG7w7OKTGfnldZyQpgJU4LIoy4czL6waH5QZarADEKodj?=
 =?us-ascii?Q?kxwSanpytpyylKdsAELWw+Rtrbheq1qgr5XPj3u8o2IZdjMmdOvt6WWQlTAP?=
 =?us-ascii?Q?SxW3ndxB1qBfuf1QZ8q8nrGzUT3G6f+9Iitxr+5BFdSdmIoM+uycTqjRp05L?=
 =?us-ascii?Q?HjK3OEekV940S9zzGdWA+jhbohrLw2/M0XzqZCIZx69fooQKAwP+UFBM8odI?=
 =?us-ascii?Q?cRiA/vo6hDw2KKgkZ87Bnmr1dkQmrYCvh2wQp2BFP84e5nXVwNhyatppcJTe?=
 =?us-ascii?Q?ZWNBqr0JgDblSwH0UU0ZTrQrTs2Stmv/xDNdqTZnowQVxn8ny7X8LNVkVLK0?=
 =?us-ascii?Q?VZDb+Z3eSpQvTKTUbxM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c10372-b29c-4a76-6627-08dad14a7dca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:11:49.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiKoWXKbjTaPlqS8/SZzqSDmeJEPsuHpnnMZ+ce0difNqkPk7QXgakSBQXbQhP6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:38PM +0800, Lu Baolu wrote:
> When VFIO finishes assigning a device to user space and calls
> iommu_group_release_dma_owner() to return the device to kernel, the IOMMU
> core will attach the default domain to the device. Unfortunately, some
> IOMMU drivers don't support default domain, hence in the end, the core
> calls .detach_dev instead.
> 
> This adds set_platform_dma iommu ops to make it clear that what it does
> is returning control back to the platform DMA ops.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> + * @set_platform_dma: Returning control back to the platform DMA ops. Only
> + *                    valid for IOMMU drivers which don't support default
> + *                    domain.

I would add:

  This op is to support old IOMMU drivers, new drivers should use
  default domains, and the common IOMMU DMA ops.

Jason
