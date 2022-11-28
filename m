Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390E463AA87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiK1OJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiK1OJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:09:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6E0AE51
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:09:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ8btUvPbdja5/tiXZDwbiwA8VJoUUo2u4mEP7H3+AP0uxlavNqMVKSjfyrC2Zai3rcvVw+J/HqfZ28Kl0/bCtVQQd7GsXYgETeO6OKRL8Ga/dUSQKQISPPbmHPqIvmJ4ETkYFhPsWbLQTjTkdsjMNj4HO/VlqfOqWyNcUyipejMyeX/a7ETW6MAgf0wNRgNSTbxDWHPi7I61D9tLZ2fCGVj5yjVD/JJuaW9OaDGv8/t2nNvg5eLJQUoqp+WQxeruyjerOTmZvDWkULN0VuceqPi708ZQXQWwDiYm2fAwt8npSEcom9tudy/vBUZeAIRCYKPrUovyuVbeH5nhpIQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO7E9wfyCXRkdOdWTZraE9GEmWU0dc1E4kPF1hhvsvw=;
 b=iF43UQ6Mu7Iuo3Z/wQQvB1Gw4/XZNXkL79v3w3VeYvlIJRj09bVhcXYhvhjI4Woy4mrYaJc8N6MGHsXRKNASnY5AY7dB/h5ZAh7K1C9ihhPGdwtbnsnQNVfOVqx7P+B2P17QB0xaPEjB58YqcPjkRqvPwbHxaa6aIv+CILzMN9Ff16lINNwhftMutz/0jVVuk3o2kWjskmhuSzW/hsdaZyMLjgyq1NwI39iMLsE59r19bBPJ0Uz61zv/uwLFoz3T8raQDYHK3APPL6YecIDoRMe30diBaqZO5LpISBSnvm68/mTrpBxYCkrET47GzdB36xMzFzanEqkSxnmsp8WVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO7E9wfyCXRkdOdWTZraE9GEmWU0dc1E4kPF1hhvsvw=;
 b=IRHn5QLUqFGAGDMeWcT90PWnp7GiNgRBgEM86jxH4+4GI6qDn3KRy2NLo2XC6u3rf8MJMgIHBfyn7nvxhCVNu5Z6kO/zObTglx9rICeIp7cnN2t/awQnwX+YlsxHU7gTHMtXWTHNxWslNCepvJ9WtYm7Qk2A+yIVYkcUXs8qPTOd6SZ3EmoH8M5g/ejUrvu7zmPIvzcVRrgq7k8+dDhYqmELlnIsAn9duoAa+bn4fUE0gHoe6gpImpVb5gvetmWJJJMadJw0N9ccrmoQSw0otbdXB0rtLBx2JlYBx5HZ1y5zBLk3lqVY7WGKqQ2jKsS2vPkDlbivNnd4knHnXAMQrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:09:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 14:09:19 +0000
Date:   Mon, 28 Nov 2022 10:09:18 -0400
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
Subject: Re: [PATCH v3 09/20] iommu/sun50i: Remove detach_dev callback
Message-ID: <Y4TBDh5mxToQcn23@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR01CA0009.prod.exchangelabs.com (2603:10b6:208:71::22)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: f622ed8f-ed00-459a-7464-08dad14a245a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0K8MqEdADQEiU/kAafS8u0E2l0Ppxu1AypgKhKZG9Gyb0Gev9vXE12dDh89j0/pQp7hmGAsIJbvNGUQbY67nVuG+dWzrgTiIsEM3kEVPRHZ3hghcI6GvF7BLRl30NWNokvKhlk5LAHlAiIegAOTVAauflWQEtMwnuTr+PIFnXG0XtH2knLF6F47O7+yoHQCxUL9l7ZzV2bQBb0rRy8kPWqc+gUhhfRI2vApAX3eH2dDzOdNQx73FwkS4DV9CAk8+ZK6HNLDyCuBJOVH2m8e1vfNX5LvIiuarV88cHe2u5b1RN9UpVoVZOTP4v3BAEAZ0/pup+G33F8AwOnWhEwOt+HH6Po5skhVt+ijdmGs/00xNNeVm3wCo/8CIs4FYY0MPbcy9DNX9WnUrjIyYftX4+CciWY10ZvHbqK73BzJIDGtVPDx9nkauzQskH5AWTWUew91oER3EG2ISeh5MFg186gp6N0VzmzA5O6NksIiv8/cskZHnaSdjPm5IUw0/SkV3KLgfhJI7qtDaYMQ7//W8Xj2AyLT5BWfUJK4gUhf7wAmyt5Eise5zoipl71NXLrsfoyl1ceM2bHL7a612XI8IfogEnkfduZJmbYsxUB2LNcLlPuAcVkC8rIR5EEmg5UHLphbkG4qw4TZeZL6P6YujA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(2906002)(36756003)(86362001)(186003)(6506007)(26005)(6512007)(2616005)(38100700002)(83380400001)(66556008)(66476007)(66946007)(8936002)(7416002)(4744005)(4326008)(41300700001)(8676002)(5660300002)(6486002)(478600001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OX+9qlnuhBQdI4LFMrK1vgXo3C+rOG22/iMojaST78AwEbbQRSh2mIxy9oNN?=
 =?us-ascii?Q?IQaQX1i3E6/zJFXCe+W/i5ZXI9txR3BNYVJ2U+He+3Xqc4/tzp48N1ITQmyk?=
 =?us-ascii?Q?+olQ6d42Ji9JCqf0f9NcupoNHt3JHFTG7zWE3X5Zv9QK2aU3aBl6nIOes9ts?=
 =?us-ascii?Q?c78vVm4D3duC76QxC+V0ewt2kk6tshTfSBBtribu+Ksr68bYrWruhCdx4Gpf?=
 =?us-ascii?Q?/qGXL6JtdbM5XYi3qEXNPHpeOlyETYffkwuJs0z5yqTuR7wQ6X7ppBmcqV8v?=
 =?us-ascii?Q?LuROHH04aQ4eY6K7++IUxfn4pSvdvHg/nYDpD0EE45s4aB+M6fj4NHljO3hc?=
 =?us-ascii?Q?kHWOadHyI256cvvSL8YRX/FvNNFczKK71eeVM7+4mXJzrSQ60gyuiDrPuCtr?=
 =?us-ascii?Q?FIVcMPnpndTvHOC1DN5wWf1eOv98dXI7VToNu5QdFOQS/vcIUhPAIvaYTLV5?=
 =?us-ascii?Q?WtZnqXRn/fOXeROZjNKFVLyxRGcNoBokh15FgSsmyZcQaWF8zsepIbRwxIMs?=
 =?us-ascii?Q?Ay+yJH5igkkKlhkIrl4+zqJTdH3aNUjtR2Xp4J7A38QPCkO63SfnxEsdWqC1?=
 =?us-ascii?Q?yvzrsjcgvi18H68SDUgHVj2WG65Bbstal9DA6EKJs3YhRzqS+BgqEW0aUeVo?=
 =?us-ascii?Q?jmq7sMnsfJ96/Y4cf/rUEMFJfer9ZT7cEjHoY8wSL9KKcpeuliUpYJ9mO+BV?=
 =?us-ascii?Q?jzWyHP7GECzW3s/HtEC9MNuYJwrSIqMDGD85Nc2/pkvUKJ071tYyiw6xHlSx?=
 =?us-ascii?Q?p7evhIi0Chm/kITNNYRfzIBWRHDTPVty5qbY8A/Ti+73pnYIxCYA7VMt16CM?=
 =?us-ascii?Q?lo80//shQ1tUcI8gaXbctdJRG1K6sLHbHGDpi5NAlpdJoaRMCawMMjDDfyUM?=
 =?us-ascii?Q?B1+NXIqJ5fTpp6RYu2fxa5PFi5hGBzQ0OT6DdEkvMSnJuLh7opnlJLZ/eNIi?=
 =?us-ascii?Q?tdXeVDxB7YSFGBXkgSum0z1I8vIYIC/6SQPPu9JVAXhYQvCbF1Idy9QmUwMr?=
 =?us-ascii?Q?GyiWZ0zfelWv/xiUABUd6NSJIIxjmHW4h64sthtXLeDsjvc1R9SPxQOcoHsm?=
 =?us-ascii?Q?G1XFxGuNuVK7mJf35N7C4RFAUcCJF6xte5UpTYLdlDlqJloaEXKa1R5mXDdd?=
 =?us-ascii?Q?Uxpk90TfUsx37Hx7RpN/UHtW++P4XbdmlWCrr10tDmSyTJkOgnTSJ/KSiBEb?=
 =?us-ascii?Q?AUDKIGZ/q+S/G/KzwSSu3Ltl3w2XLhNBEvjxiDGRwY5zVG41wx3smNd6y+UC?=
 =?us-ascii?Q?FY1QkL16OCfGsRVwqcFIwGn8s/prQlIwCgQjU8AKwoJdjdpv+X5edaHCpWiZ?=
 =?us-ascii?Q?2XqWdy7LZ0jhc2W937C6iEhT+xxrQ2LVLzLoHo8ER/5d2zhp1z0KmkZUnI6/?=
 =?us-ascii?Q?ATwFLpdYnyLUNl+xe8uZV1rrSfGVWtzlC/k6M7SBl7edHj2C8RJvTcu4acFM?=
 =?us-ascii?Q?IYcktiD/KjoNZG8cPw9xJZcNAX14Bw58bFTayvvJ4GqF90zUDYKAmnSTQ1bb?=
 =?us-ascii?Q?oikNfibWJZxeU7UaYF3seueRsFZram/q11UlPS4AgRlCatpsvbdCvPx+iTWA?=
 =?us-ascii?Q?mo3ZOayySqjGZElGEvw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f622ed8f-ed00-459a-7464-08dad14a245a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:09:19.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9P7LCKn096uk6r1ki2Vi6YYKMulOuW9iD/YTKrOI+ZGGldj22+wwZJXVgzyhRbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:37PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/sun50i-iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
