Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A765D407
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjADNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjADNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:19:52 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196621EEE8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:19:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB1MhuOAdomR8mvKtZ7YGk14HwkLuZgUYEDkgfYMXBoM7EpfMlErgeond4mrq3V9A5scm858buZVMhhchd/YvbbH8PySQ/Os+nI8c/yC7IfDP4wKLlg/E05oqSbMOJA20QH4Zhf3OxnD3eBhzulKXdCpJYHrG0PZvDva5LHI6LKQSTu8+yz5nvwv3mhOuPEsU3SYSTMiNjZCFFZYxKiTAoMbDo+4OoVCLvDMdEaDTXn2zImcHEyBD4Z/WXbv2H3jCFetV8Z46wEh5fRkuyFql+Zd9RLxHmL9Q5M0DW/VRpouTdVCrVH894dcRtX6ycaBNLfrYGvR75We8HBk0J3IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgnzw8ljD5jcayTKFA5nMBC8T4FFG0aVRGmzWgiDMBg=;
 b=Y7RgKTNJztmfe5Alj1DhHiOPSDNI4NiiS//7B9CNY6KWr582GwmPG0N7CD5O3nlO8Fbvb8qiaK1rQfdjqUsq8s1Gi9ylfiIga/4wzFKvzStDXXR6Ph4IQoDDM2M7k3tUSvTbzM5ByyAYuF6HRTcITOeoBmlmd9v/yqzRnkg8fyWhin3DEuf1JH1Geirzs1ozLWE6gm2p6FjWuusmwv4alRhX1U51EnFa5veXVKHDVJmbkheK4crlYRSlQg8HOBcN+xR9LkxsGTTeP7WWtN0EEcKjAWMWcyQ6eb9pOJdey2R2Gg1Y5xb0VzM1JhJWUVFeb9eArHMqTcBpRE8WpBpD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgnzw8ljD5jcayTKFA5nMBC8T4FFG0aVRGmzWgiDMBg=;
 b=H8U+xlCIRNQg4z1u+e+/Fy0ltIprMYWMBd5OZRK0yWxqe4RdcKLzo/YXyQ1lGapvfufvgRr9jsUCthmqi0hRHb/+oVEaeCyNRqtheFfXcqFFqfm5piekTpzEkqPg+EyloGrFeXqVcFrbVudP/YGZRhwh5GQ2+8D0Vy3M6anIrTXsVUNMNKg6iCEnOe+OYtL/7LK+sq4M+QPT1o5aU4VsE/uyz8nM/Z499SZLObF+gsm6hf64aT3F83fS6CmsiTxJVQvUi6kwVShnUUztUdZ2b6v4ylc249tzQrApASSQLXE5NLOXwDey9aPpDR81Phq1NNYmYzP6qbD/mgadJpWAlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:19:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:19:47 +0000
Date:   Wed, 4 Jan 2023 09:19:46 -0400
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
Subject: Re: [PATCH v4 13/19] iommu/mtk_v1: Add set_platform_dma_ops callback
Message-ID: <Y7V88peIzotl8qbE@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-14-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-14-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af8225a-0061-47a9-a558-08daee565a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ax2FXYwuc8mWdWZA0rsmPa0oXEkcJuBENPApgjE8TrQM/lPfObQmlfzNQX8F6ndLGRJ5hSvs7R3p5Zvwhx0E8b1t5kxsVb0jaDl20zHLKncul/n7BaWHkcGIWOte6cUep2EEHiLN1d42xRkXHgxMYtw7S9aJA3b66nEoOvWiXT6y/EcgPDyAFLSTh0iHwpmaws/PsAjyvdLrmhYx17CXmcPW6KXC5ywFnzm4VbahXPgQySaxFhJhn5v/Ef8SPwj2EC2FWNTKdFNQeCmbu1GKPOC2OjqXgW2MaPfOvWvSPulj6d1Zqmw2L5tC58woigIQV2ngnTkVCG+jtepkCeAyfWFxF0CN/NG8uJOEmzboCZecSDq83czIqoq3Go92BiplWMMbxueNLw0hxUh8C6ZaC8F23f2HPQRunkkxISjJ13KyKTyqAYpmLnldZt8/4M5X/8gvSlobnN584gTizMwgsV5s31bpWS8zZyvxozSq+7RimVYI8rh/vSJkBdkDBqvO11osOu964lZ6ZoBkxCp/5IJIjfzh+x+WAbXjRHGg7HGYoLcImUEnX65PGKcO4UKFoS5+Wi91su4uKQQGeGa4NGoOfxm0ENNTQdsMHD1arINVddIla8a/3V0dPkjTwJYGL4anz9oFESPeLUwAJKEw5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(2906002)(86362001)(54906003)(316002)(6486002)(478600001)(8936002)(5660300002)(4744005)(7416002)(66946007)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upcDhnDBuHaiH5206ibzIpaGN7YeIf3R5hPLoBSVNFZwgAZeonT4fph+1l9H?=
 =?us-ascii?Q?VUtetRVLg+GLxh0QH4iAaXiQZteRAFgXBP0M8qUOxYqtifNVMuW1DQL2ylwu?=
 =?us-ascii?Q?/XTf3stHcXVjxg8zQaVZ1kX+KLAMx51uHARG1L1yyDKvVrrYJoVzAJbMZHEb?=
 =?us-ascii?Q?wVNzmeWw5+hkAPAaOL1JT8ELDmGINFwXWEKVXnqpRM/t3JXtKimD95jhcgbq?=
 =?us-ascii?Q?GGBoTFNMGVAv+lrI25hGe1F8JpZVCKK7GW3iz5e/dMP1dMZydts8mHtZh+mr?=
 =?us-ascii?Q?1YEDQjWwWJSS0d3wkJiI7MZoa2xzT+OOu34i1InCRS3mhYFZ1pcUEs8yhpmZ?=
 =?us-ascii?Q?C7ogyGecAVTWxs0uJJ4ugsBsLk4DNrbJp06JalreQ+/as6Tk3AoUVaQeB3kR?=
 =?us-ascii?Q?ELP2J3ZE3pD6wI695bR23YwglNWz91hUqXwhlvCNbhygGUNfv4zsfQLMBnqD?=
 =?us-ascii?Q?hlcb02KQSrHurWkch8zBxO1YwxkhVm2y2eInr1FNUJDsYFeOhrjc+QND5vBE?=
 =?us-ascii?Q?gxj9C6DhfZAeAlOXcqqCLogrAp4oPISjEOHAzzCR5uKiZ6AO2eluo2L5LbBc?=
 =?us-ascii?Q?Ys6CRNvAJzFtwVjUmSvumcvoeVOtRKiYtKPEVVjaWox1koW3/2t5cWy9YxCk?=
 =?us-ascii?Q?XUhmwZ6GDV+o2G0B4s3hH9NqVxVT+7ajye3f9NnGw+wn/V1yggkctc3AHeMy?=
 =?us-ascii?Q?DCLsNUxdK5EKNlLd90eRFEVzOyvwz5BG1USWDArvf5Yrh6pYZdSBzGLxW87o?=
 =?us-ascii?Q?NjCJL0NKcMSLKm8flV88Io4w5JYvj0eAHPVNj4L1/E/8E2g7/ywE5u9CzxdA?=
 =?us-ascii?Q?jSpRgvESI47/B1hGNoU9MT8b3UZ3mPzZflwll+4CpS4ahvE7J2pSiXaUJG7/?=
 =?us-ascii?Q?fJnb6X8HvYglc8hO0HMsPXAwuzSzmXkUI2snm6dh2ojK5ecMR6ltkkaVack9?=
 =?us-ascii?Q?oczzMRKPDZ/JpE/wdVwD3Yz2cZtt7QEmf+bri1Br/TEG/yW+3Vh4ITOwQspb?=
 =?us-ascii?Q?+BsF+jgxBjx/f5UVN2dcGNGa+82OXEnRuGskIFxqa1u8DaQbQv8sPu2FnWy3?=
 =?us-ascii?Q?+Kfe44JTgyL7uFI8Koj+ZiWe3HpylYfTaIQIOo+zX/MSQnswO3yx59k0tuEu?=
 =?us-ascii?Q?VDCg+YCz9yx4HmbeUVQXnMr2KeWeOCZrI+Wo+H99pbB+mHJtqOC/9rur4B5m?=
 =?us-ascii?Q?1XH6pBPfC9lLs+Nyn9VIH2xCwSd1gqwHHvMGwSyhRkPfWaHPPK5q/K+pup/z?=
 =?us-ascii?Q?9jogziAs5NG91tI1Vpw1TH00FyzAXuc+jjqgfw/dZTZlzbrFhAb0aOj+fcBN?=
 =?us-ascii?Q?RHnngbsjiwO3Ko3S3yzMl3SNocxbZPW2LhPIZCoknQ0vThYckHI6cLHpTbNV?=
 =?us-ascii?Q?Ar6p3BKqz+p7YqPM+bU+5C+NiT3WK8GtlwQFj6H1qxdv9aH8SWm9seZ+deUk?=
 =?us-ascii?Q?QTsoGszImR6k2gM2NolDWpa4ewjEWwcTSaZaaA6CIiHE+AJHHExNj/XrbVal?=
 =?us-ascii?Q?JehTAGbwOvk4b3scESNW2QjirR1RYS8Wf8h1RSj7hQ8NvL4AfjwFX2Mpo4I1?=
 =?us-ascii?Q?J4f013A7N4ArDoLIoVegudhyi5G4pJbDjdWfXuCg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af8225a-0061-47a9-a558-08daee565a06
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:19:47.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BL5upPMC98yJZnxQxFGJuOlLmcc/Vy3osdbPbnub9a/0LNdfOurOwkn5L1eHrXr
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

On Wed, Jan 04, 2023 at 08:57:19PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With the set_platform_dma_ops implemented, there's no need
> for detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
