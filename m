Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52365D404
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbjADNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbjADNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:19:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659F13E08
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogu9A6qkepo6TNuOV7E9nWCtdeRoJc7rIi0e5AGIuasJSk1ydeiPu+ATZbMOW3aKn/uZsatlR6B9wTGB+tkmhPfa52sQOjqsiPNhvQSWpT+TJpDBWuBu4LOqNI8WTdrIFtaNScPrAP0vlew95FnIxFEZeNTaJcmvnvzwLufo4YC/OwsfuxsyT7VMr+6dgfKksu3T8rrwnrrD81y/sL9AcmXjJe0aw2eusQXBqWGsBWcqhCTKIV1edh9zf8frYanQ74TgSjy1nxYcn9c/DMfMg17EBNFD8IVPRhg1btR06yKH5fOGOEn44FXU1P/UFkHmDh5gnwmnFr6T80qFj9qDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDwrxOl+Z1EVS8hayC/l223n9UZTPdezX50ILlzoDHg=;
 b=fOAI1YA1qc7QgIo0qN+2w57hcPFlmlJAdo+M0+SyJS3z+g8Uv7r0XWgqmqOFMtY4eKuy5/O6U1plLK8DcNI8lSqKUvS6tngXIpBnxiOjjENOkMMCKwhoTMe1Jq+JSnJYRsA6w6Dwoiu9SjvEx3djugq2lw7o1mQOKOBbn8oaYgO7E5797THz9Mzg0nHQAF9i3VGqJTPN+127rX1IvcfrF7E4L+xmBwZpi2gi/UphKPDp9UFxUrpLU4NlPbUYMHpsMDJOGrZIM5KabJn6lfxlnc/sviprUoz/FqIOcUZPHSybgbtinKfFjXURURlyUf9NyuVq0/DgsY2MKNmqKr1Ojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDwrxOl+Z1EVS8hayC/l223n9UZTPdezX50ILlzoDHg=;
 b=MGIgKON1J7UpUQRWURVY6e3jhoYeNQ/V1CaB/gzT1dYLUWdeSBjjb6Td+5XOReK6/rPRTkF/wyhUGLGaHsJ+2RcYBoXL73MhxejbxhLcS6+uK3h3IxizLBEe0LAdlQEpitlU59zsV2wpfosWluSGWoC89vC/HQ9eIBHsDRpPZSW0n+lkqUrmRziaeUXX3/lBSRvRb2STjgc+tm9OaCGbAPF8nC8OrcPaLi/DviMoXvfbj9l6Z/Tt/2/IGqP9rZ6odxtvH5Yy7plJiPy74ICCmL3zxEgnzIa+L79MOsL5TVFHmyilmyUVCDGtkYAx6h4jFJFvriXMxUClgh8q7nFjIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:19:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:19:37 +0000
Date:   Wed, 4 Jan 2023 09:19:36 -0400
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
Subject: Re: [PATCH v4 12/19] iommu/msm: Add set_platform_dma_ops callback
Message-ID: <Y7V86Nz1o8ehlzQT@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-13-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-13-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 033ef659-8ab2-43ba-ea7a-08daee565449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vMSHJCvW3H/HOx3Wk63YjjdnZCICye5jmhNOOoPGvt5mgLiet48FEhqD8bX6X5fFy1WgiPBhn5+igTnM5WSJYn6Ojn+pgQ1fyoU4uSswHto03W4TgPiRfbOXT/5bG8KtzHeQaX2CbP36SSudk957m3xmWf8rLge0uNRc17oeoHBphvtMvWn+lgnwZ6Y6Ho4D2j8+YNXeZ8wcqLbV9eSnasrItK0oV6Rkhgnav7+TnvbebtcGwMrhKDLTpRkhg87WGCP+GHT4+pgvTue5inkszjyfvefBAitXP0+lwBrkoLaw0/XQAyPl/nrzsuH5YZqmnWy9cXFLg3eU3d6rHAV88G4goCoLPel3d+8yMIeSRUoqsLeeT+HuiWtCnWarLFznGyFDjtjyV6A4teerKjbaj6k8Z2aUB/R6P8KiFk5HxYE/S//6z6iGZsoF5u0/eZcEiSpENmHnNLkWBnrnfVfMdjX6pzudXMpRbp0BHIMPA/a4kcbL7BC/+i+vYNPxhr8p11zOP6Fb/bh/z0LaRgFsjWEqZzJ1AUqzo3Jd0gSzbi+LrFh4zcF+eDBmrGfv5Flb7Oo7uTl5guCh2Hvlq/n1iIuaXURsC18UN3wj6h2+6Sjq8pZg5eddaDJY67Ex5VzDS/w5VpIeuYj/1XCpMcteQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(2906002)(86362001)(54906003)(316002)(6486002)(478600001)(8936002)(5660300002)(4744005)(7416002)(66946007)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AE3Grd9EP8qc4UTx08T086rxjSi8wsyGUOFDW/qlY/ZM9uPi8iwhyTQKfLny?=
 =?us-ascii?Q?dXBswXz+iFbfqQY0N0UzDDvQLfeIn5PSUrgtbTakMd9wPaTImixX5OlsGQet?=
 =?us-ascii?Q?PTySgKLQvtqrIxhc+ME9fh7xd6/VyRDO27MomfxyB/FssHcNCganc2Fhnpxn?=
 =?us-ascii?Q?5zPlybX4hcYHNQD74JjWMzpfpe6NFpfTGMKg/3fIYkQfx9o+OirLSCxKbG1V?=
 =?us-ascii?Q?y6585EK9EiKy8CaPXsJxqrdJpnisS/EUJ+BfO/HnEHGvEIQE3AHGUgqe2nVs?=
 =?us-ascii?Q?DJIYeCZ8Bk1D3K/qd7XmORux9PrKxpp+1/ehwstXUUGRhHq8aFaAOtjOkeMu?=
 =?us-ascii?Q?ptUh+Rnu3xslPge1x5yCJlipf/5MS836lTCdemOfMtJEvgimcEangWLuQz8+?=
 =?us-ascii?Q?mdGgNNGomqmv3mkqqnwV9KA7OrfhjN0M0i9EGw0rai+M69XUbSKM6XOAhfca?=
 =?us-ascii?Q?5Vh7xEQ+YQZnXiI2V+TpfhYf5agx2gSBYjmGkvsdqjDE4y9WI/g1RWcQHGR+?=
 =?us-ascii?Q?ULFAQ2zJqLR9KrHzmUgO/NhLFqVoEaOUueZamDKYngJZ6NE1gLXAFkzpCvMB?=
 =?us-ascii?Q?ilmwcG6/GR2GUIFI4j4m1I1uTc+hNJk8oegfdwILE9rlu8mtCmDABHYn4igH?=
 =?us-ascii?Q?lIfQBny57i/2fN7VlkyuaBiGSyilUr6IgkGZxZpEXaBg6hoN41qMH/5jIL+D?=
 =?us-ascii?Q?J6n7vwrWl+vM71+Z6NVf6s3Pmm2zdI5J/Urkv5ShdClTkKM1siALftmSvx2H?=
 =?us-ascii?Q?UKOU8XlCg28wWTD79fb0sGG2iUPxwmBoyAulijl7Hz+1eb/gbVHJoNnFbHHI?=
 =?us-ascii?Q?6IfkozW3qseAdE637Qm+noQIddOnBlOyhLO6dUinrzBQN/PzlQk3dxhszC4O?=
 =?us-ascii?Q?oH6RSkTFKnvtZqxIjVR30H6o+R0tMmBbf1eAyw8o7+cmAYhGsphk2xbcVTL+?=
 =?us-ascii?Q?oLDVAI9lyCvEEsGoL2fTcoJWtVlmori3lvlREPlKFXCg2NbhclUCoNIpwaay?=
 =?us-ascii?Q?K5DJXbeMnzMeCRzOu27jkbKNwisbjZRmWt0DFNe8a5JharKuyXuIsydK5dUF?=
 =?us-ascii?Q?R32vYx3AYAPlCWSxAZ7jgndtECaDPWT7VsnkKI5df3RTZUzwYz2rwx3ISloU?=
 =?us-ascii?Q?+t2KDUtGCAY57bOo3oOEX/hrJ5q3n3hPaLIZb9cDs59JQfrW858CgyTR0IF1?=
 =?us-ascii?Q?z1ueeRPL41+LMyBcVwP1RIlgImI29YJLnZjD5N5wuPfFx+jKmtBMjnaKipfa?=
 =?us-ascii?Q?zEyAGb8uxBzoCyA2LYGnWPOuAnETBQiQwRCGRepKxNWLnbj4mvNOHrracrIF?=
 =?us-ascii?Q?F+BvkDlPEmTBBhJmBfAXRtYIlsMcCdiNwxuapP/CJSh4Vjlhd23r24a0919K?=
 =?us-ascii?Q?XEIRbZuyRrxJzOatkvMNSnvwcCzM7bAj2/VICk3HkmVAtBqDYOEanR0ECU0j?=
 =?us-ascii?Q?AYIibM+/hixOmPVFZmnqOwyuyVDNpp/DQ54HX7EKoW3Xm5euWi9bqGF2L9+L?=
 =?us-ascii?Q?JimFcWmQ86PAQ+x+4Aptrpe+VFvmYoqQEuKYjdyitNFrD8U2ACTNIIxEi8GU?=
 =?us-ascii?Q?GyK/Vpe7JJ3r+UdYb3YaH6kfAGUPbmBVo36efjPW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033ef659-8ab2-43ba-ea7a-08daee565449
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:19:37.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/14GmpKqJG3LD0v4uLZB80xhqBC0vVgVhT3Pz3ssHjwni318tRi2MsYusv+KVsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:18PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With the set_platform_dma_ops implemented, there's no need
> for detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/msm_iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
