Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57BD65D40B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbjADNU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbjADNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:20:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C011EEEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW1tcq4YMLHqhVYSd/lUUJSh4sGGZshhsJbjVntMi5P8DTmusrtn+xo2oEGCs3JGIIIJFOSw5W5QQVhMBA/DJZBdmb3WFcyy++95t3U5vKRczzFI6reclW8T7g3sQ9Kmcu8wG7GuAbX8csw4kCw1z+QCATXlYQpyoLf6X/HmSumZZSd4i2c4HXYaPZutFrF+xfADDYVFOjZmTUEH3DfSb8g7vkKGiH5gceyuWg8l8q1AaBO2Yw1sTaMhOEw8w66FpBm3AiCzVMoH0AOVMh4GvpjNLc1I4BaQIo9KRS+lMh1YqQJ4fjSt3PgZVmRIrKLSxAhIMYu1gkCZlyCPQ5IHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOjlrpYzqstSvdMWJwvj7e1QnVpY83Lor/zGy1CW0bM=;
 b=JpXa0j7jOD2OiGxEkrcpJNJZfQ6Stz8FrTThBk+q9TPE6Z58u17DK3ZF6sWjnafashXxqd2c9u+KlQhntt7PrHIGHL3ZvzOmJuB8YRBkdBL2lM7TX91FFrtWhaX/Wo+ewy3iquHmoVLCIv7DBtUnL4dHqClO8hpnfYRFl/P1NQKhqnwXLRNI3gdPm77YIi+pxJ7P9kslKPaQH/Rb7+MWBX78b13Gfr4g5/bC6IBO9Ad6uyUAhA0Af92J6iZ1DRqmMirwXTAEcnBWB0v53kKDJFhgFCM/Aotse0pvX4gs+r5cgF5KqM6Q2xRDS2H8RiK7BszcYic+ueZ+JGCW4TBcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOjlrpYzqstSvdMWJwvj7e1QnVpY83Lor/zGy1CW0bM=;
 b=uE6kKjp0Xaz4fsjrMnxrmtjcx6Bzz3W59rRXOeY0/iSiaaJbXh0ZNDncKSQdz3nht9BxJg45IQy7LwcOvGi/9E2QbCFooKdT2xMdiiPfGj1AxEDf1O47hlbpBk150YSBuiNoaUFuBzkaLRiICzV8kN0F+McDEgDRaU9ASf7pjwlaAzHTROA8w5Uz/9dK+PGEnbV8LmYti0nrIVhApjcL5cY9lBNGn3eSmWpnq4Kh01kCvnyvt//Wsk7KtWpOsiVYtvQBD3ZoLTZbk86I/idtzDQKrHGHXtmOejGUSZwjYnsUzdCb1RmslgIuJE8iufyH8NLFw3kw1IQxmF/m36Yf4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:20:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:20:22 +0000
Date:   Wed, 4 Jan 2023 09:20:20 -0400
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
Subject: Re: [PATCH v4 16/19] iommu/gart: Add set_platform_dma_ops callback
Message-ID: <Y7V9FEkTwdowufdi@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-17-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-17-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 435301cb-6a8c-4a02-80c3-08daee566edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYpinxczBh6NTmrTYF8bM8RrbTzc/bKW1fXKW3rNrkxioopW9Pus3d2gT11fG1TAagZJ3fG3x6xzEQ8kMC+UxN3tGE/MljVYiRvEkP482yqTK4X7e/6Muiu7XuMNqSdVop9+Ev1WVEpAEWxttK614WEZZ5NNt7llaJj/XNTkQsI7rKN00/3XX245JAdg9bWlEKV6CjcxQMC/TlCTt1wo+xxLXmr3F3lR/GHoB4FoROILUbvUjGw0sQ4aAri1rb9p8Y8E3UGbKALdzLVGnw09cJYA4J5YSoS5+c4Ts8CAqtpcsnBkuXG26sL/fazHr6DC2NFBvbPa4S0F8TDdUdXTUb+V8//zevf26IiQQZi9rBA495zSsgroPBbXE/FMMMNudm4P3ktS/PfA0+C9Atlgps2Sg12Hgis1Lip2dnIQ/uvgxaKssuHsW6CzWjo4qfowwa3HAGCo8mlFyJrMlPBKYqpm9s//mkSLj/tlJ95YWfIRp2PQRLsjNYDEuweS+jWd5a8DhsG10ukucyyw9japeZEw/poFwBadPfySMf3TAikqvfSrwDswukDPPz/ZFt3x2nWdCG2KCJteGQ5RJPuDWq1xi3m9k+uWtsKcLrHzpqtGw7ZJHiKsK+hMbL/nuAci3lOr1jqag4KRgoSoKqAp0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(2906002)(86362001)(54906003)(316002)(6486002)(478600001)(8936002)(5660300002)(4744005)(7416002)(66946007)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HX2ZHC1J1X5WaWXBtOEsYUT5+HUfKY7mrLvw6E0PUuGpS3i7BKKUExvLcuM?=
 =?us-ascii?Q?fNpljqsTTy4bhxRjQ0pBFS2lMv2N8EPkfpVdGQxaZpR+00p34Ffeo3NBFZ7A?=
 =?us-ascii?Q?zQwb5PZLv5JxuHFQcMK+gN1ufSwXQXFJKH7WH+Tv4wePZVB5sfQPFeMKsF9T?=
 =?us-ascii?Q?O6D4ilnUCSPg0D2t/H1NlPGuZ6XyjnbFznB7Yl6N2xCa6qEqOqi0gRXeDpg3?=
 =?us-ascii?Q?5nlYoTtuivybj4I/nrF85Q8i60EgWfIlOdZT8YdWbwLOEM210UF4fMXW8MFY?=
 =?us-ascii?Q?2wWSBVMZ9+QOm/eRSqoIU2VxZEoF7mZsfvxh1aubm/Ez5rLs+G3GHXjTU+oZ?=
 =?us-ascii?Q?0uFhLehbkT4+CDyJKJeHIDI/UPkFm2sisvT+yVLo7VLvP1L+uZ45j7TBX9eX?=
 =?us-ascii?Q?vbYHho/n5Dde2GziFPtS3tjtFu7xewR3+QYR+MT+FxJ9PnngkSS/UIerlWWF?=
 =?us-ascii?Q?vE1P5oPHPX1ofTXI8JVMzE0HpOYGlmg7YSx+X9tPVhq74JjxWIUjmYyPu3sg?=
 =?us-ascii?Q?pEBuWxhZGlFyBeXTgBSorhkDgJDgiyIQ0gwFolQp7WhUlqJ+OS14KFTHtw/B?=
 =?us-ascii?Q?zx2F05ZfI70CECmqt7Bz5UujdVUI/9hawUPccbkAzydcs6nfpZOLcmtQctnz?=
 =?us-ascii?Q?YhlGuuGMhcfhV2JUs76TN0dtP5d/FOy9XcOIJc7vDJkXztLyQHi33Ret5gsL?=
 =?us-ascii?Q?8ubUNDfr2l2ZjAVWb+c/iJIsZVs0KBUOzq0vYVVlzkcAoFA8tQi2WP6yHQWw?=
 =?us-ascii?Q?5Mm9iC7Vqp/9yVQXClN8fMNTNKkA8uztuP1CJIpwT0vnAiAybDF88GbajQaa?=
 =?us-ascii?Q?SMZ8kN+R91wB5h/7d+ymaOH4lCZraLnrL4Fo613+Edo0B3JDyN3O4+jyVBkI?=
 =?us-ascii?Q?3hq77R7iuRqzFurkFWDX+/hMnAm83QAjYlqX0fv7FjLr1g3YH0/SvH7+SmLs?=
 =?us-ascii?Q?0q7T7K2kFnEK+ajFzBs/zzVjAx4dvwCJ0iPJeI0XtosAA3RrOjDTTVu8y5FT?=
 =?us-ascii?Q?dx9/S2CL4N2nIcJjm5GMIqJYbjMrBNj/zOG8+jKBSC7gCRil8JFVS6WgNySz?=
 =?us-ascii?Q?1m6V9BHjtEW35nkfgbJExThfMlHo1tZUxTpWawjE5Wk7/YOaU9Xaz0iMt/hm?=
 =?us-ascii?Q?qnb9HUevD6+mHLsjIOPC989i/4YU+ZL6wMESPjnfUSJ21QFdBeUIsOgwi6y9?=
 =?us-ascii?Q?WvD5LgxnqRSwLFC8LrZOEAf6b7/LkBhIHKp9gJssEp1l/3PV/r1Mf79IT0ku?=
 =?us-ascii?Q?AGmJNnnRN874T2vlnkCaeee7eF8egs82gLgFZCCe4m477Lhbw6ao5oSfYZgD?=
 =?us-ascii?Q?0tsCJjH8BK9pUSnWQ5lIKTYeUQoMt+/Er679sA1JZYaowlGEwy3yUcoGh5eF?=
 =?us-ascii?Q?mFiltINyH/kDPqkT4k38rYJalzsf17UCWgTHER4HYH1dni6bw9hqz7BDTfmh?=
 =?us-ascii?Q?db45qG3mGOU56Qr+u/WsxSaPQ6ArEhqcg7nwipWR3COWm7831/jy7JbIsUlP?=
 =?us-ascii?Q?dpzgVA/mOKA00tVpnR5HnIQyEe3p7sMGUhWS22Vy3boJHJJqyrvyoHjzKBGI?=
 =?us-ascii?Q?y2awM785QZnOR7oAslGCh2qRZTXTSMZcUnDEhhfK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435301cb-6a8c-4a02-80c3-08daee566edf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:20:22.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P78xkGiPoTKvNsg0VgUMfQt5FWTFqIFriUk2q44w/WCQloCFqLAbWs+7WtxhHZSt
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

On Wed, Jan 04, 2023 at 08:57:22PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With set_platform_dma_ops implemented, there's no need for
> detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/tegra-gart.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
