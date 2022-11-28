Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8F63AA08
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiK1Nty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiK1Ntu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:49:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2011EEF9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:49:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+iCGlG6B/w1fK1mWGO+Tjn0lVtipiXfBjZwF8tjBHdRYyeQ3quMM1V3QN1MX5dDlvSQ5Is2K9fnVhu2OYgQ4GY4oMKrRGNdJYreD83EcXjvWeDZMB36Nm2fSQ5UbJ+n931L2YseJxa5rNMqXt6yDcOwkWlAs30A51L6Jc917OVOi/A/DUwhmRUj8LKkHqRlm0D4e9ysYeFEG38ugxQsZQKMMiOjjNUyzdmmO47fipBPR9WsVf+8P8rOsQJia5IGmgEVRSBWPzhms1PhDhaTE06BkXyzglrTwzC5wmFfX3YnVtSw1bxui58SOua0KFPN6GMvzbTOWCEC7u5h7LK2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn8yxC0kYbzbHV0Ou10/7eXwbzN7h106kOfhuAteVZo=;
 b=iEUbZrnE1jjwZCZiMzISl2L2lLT6k6CYJChHmf0Z7OBVUpY8wZZerqoJ/3Y8Yaaq2WW/Lr4Rg7n1rzyMbcBMrGAvCCU3vUl94mKcV1ca7cTfdzU3Hnte9GxwW+ViqxZ76u+GMn1xbbnt8/+z/SoGSNIro1qtmPH+kVTS8bjarv3PJWxdxuccMT2HGFwOo6VedrxE5FBtjRTIxZc5jkU8iMDEPncvbuzWDoCVkzxikkkOV16IOqm6fT2SaWyACai6XhBZfoIfoLTaH79fP0eKpDQwZzZJyKgHXtA82h2Zug+35/CIoEsmqXVKxe1ap1ZzrqS4m8Ah0HGDHB7mey9Yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn8yxC0kYbzbHV0Ou10/7eXwbzN7h106kOfhuAteVZo=;
 b=lzT/WduRqkGNe16nbdWT1dWfTXfNaJQwouvQUHJiWCKTPIkj5c5/0UN2DUfrHDqgWmVLu3hA9T2M1KrFU5CS8eMYd7i57vFhTpKTNJNe9IY+SB0A7wYNs6u1oA9nmKdVwIfpLoTEOTzMtg2zQ1p0dWPCmy/hlWtf622hIC0b2BhGd/ueFstM625EfmAU7I9kh6mZBFZNkdEOC0t1W6IZO4vCqcPVIYNk9g9q+4oqFaCk1Vs6e/6By0+1Y4/UAaNPRGymuVMtszcrT5avQiJ9CxNG7mudsjzhb++DYamxYGyvmMlUdj37wneDhUetutUYhr/febIXsjPt/tb5JvuVTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:49:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:49:48 +0000
Date:   Mon, 28 Nov 2022 09:49:46 -0400
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
Subject: Re: [PATCH v3 06/20] iommu/mtk: Remove detach_dev callback
Message-ID: <Y4S8elzfzdTJGtyK@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1acae1-ed09-46df-0151-08dad14769b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggIdeETfW1yyLrhVqG14UUL0sl5DfqKxDb92teUeM9V8vRnFgfYAdS2T9AaojfcFSN/WmuDRItvGBiiGQcG98DEtaKGlj/74AIZREwCEFQawjvlKUv7nSbUFHWnZy8LaO8pBdUwKGoa9XAP4D7QJWbhS2MCYSoLOVCgg7uV0bwQcz+KtJV2yI2B+iiyVhT4rtxqkcR1arOAF8gHrKI6dwG0rP+8fLTPXLyGxXbb8Ia0/lc7pp0QyE7c9YyNKXd8VN+1JH+oD7uPrG4x+EARHAdfWSiY5Ekb3g1Fc4ANefDgW7TBiAqarg5+yxS5zG845PIXAFAnZuEOQrTdRgw1s5vsiidbn0cUa6zeJuItkzaqdpNLczkEaPRMVnRzCg6C1Z8Sgq9T6rybwumcjxHB0asIMUynHb1holw4KL2r6183IAv+uZJQJUrclTWd9nFgYaDnnFDIBFFZrBNvSItg/Fb0X6nG94zCI5tozYAA9usRxwPBz721dGO2yrZYUghwDz73mTfwc30VB0pHNX8pcL4c1WuI3Nx32C9VUm/dk0at3Kb419JHo+LfXf5FbdNqjAwJXGaysKXCUifnsH7E+4op8+DsU+fJQPvlzhh3gFg7p/cnxHaUvhyb96i7ozBDJIwamvlKGI8ip7kzp0KqFk3WISfMMh/dH4yrahoCQlWmtK1YjqGcdpwKFmgHxCUjcZOHk2iQgrwTEhkMtGP2nng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(8676002)(2616005)(4326008)(5660300002)(36756003)(186003)(6512007)(26005)(8936002)(316002)(66556008)(41300700001)(66476007)(54906003)(4744005)(6916009)(2906002)(7416002)(38100700002)(86362001)(83380400001)(478600001)(966005)(66946007)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2uv/GOMBkX3FiYppm8ZOdJCrsR0Ty61CslK7ef0xGCTXRdy0Fw6HMx5WlX2?=
 =?us-ascii?Q?uvD1xoYsEGFqxdePBaXRicDOmu+gICxylNdRwozMqZrsMaB+vqqcYZI89Z/i?=
 =?us-ascii?Q?OcFSsrDdyWam7QhnWSKu99Fb0UKKw9M4ZNan3wyDKEPB26LZHpiQTwQWE8cU?=
 =?us-ascii?Q?rx1CYIO6we47brfit6G3lBmQBBz+3zf85VnLqDGzvpvwI9ucLtS3hIVGG6SY?=
 =?us-ascii?Q?xtM9/RWuQ80HocPoF+AyLsN739QlCnTEAiFI6xZ9et6hGZGi4ZinHbBmvevB?=
 =?us-ascii?Q?L2Ei+kBYbNhrzbfa6loMfW+5DOi2qEZVwheweU543WQyvjXVH1fNkZqN2DvU?=
 =?us-ascii?Q?7q9xFAMq/8VIpaEeqoWbb2G77mlwt+6mHdTPqml/tBxjWGPAsOnLczdgBdvg?=
 =?us-ascii?Q?x1pyPsdJRnHeewMkyPScMrIvGwca5MooB+032//m3FKcAa0go/kqYgBtstcs?=
 =?us-ascii?Q?vGNVDIoplsMuunWJ8Ch0fEUovelLE4m5rMAPhP44CBnsgTyfaR7uueTmuxLo?=
 =?us-ascii?Q?t85EFwY6HEovre89tqjCEnR9TBAHguqzWL9A8JxsOaG245CN7TONtoF2FA6T?=
 =?us-ascii?Q?fqIvH+8MDvwao9CDJHiOndZgP8F8zkXO4Ymam2ez+TNkp/ZJ+HeqzkjCP4I9?=
 =?us-ascii?Q?HWYVUXTvdL1yrNzjx44Txv8Q8t7CJgWOqmpemVc9jtS5LH3geCg3BZURAngX?=
 =?us-ascii?Q?NbM2MAwcgWowvKzO7Q0mEcmyL21Iq1DxnJENnXih9ZznIy4hb/hK4Y5yEfmI?=
 =?us-ascii?Q?mxX0gJ5qDvbUJ8W4wWV9W5qo0ReidOOQI05iolERrLfJZpc8u37V+CkglZP5?=
 =?us-ascii?Q?aO4GsUCW8tMYQth7FzmyMnbcp/boXYqh9C/9rVuFYszc4dGVsU8eiXR8QcRS?=
 =?us-ascii?Q?3vrOH+67DYRWKmpblA/6TiWgX17fUKkahrhje2K/8hxQdHFtgyvx/Yva9Ieh?=
 =?us-ascii?Q?y0CH0RtnYvZnO5Jw+eHnXX26yE9ZEoZsEGIst7Vxge+qNMtWCdSt1CGl27UH?=
 =?us-ascii?Q?xFPx8e8dfMPcggjhgh0YpZPE3FDUPWrWV2DzirbRj9tfAWmscb2WSwlhco5j?=
 =?us-ascii?Q?LYVxfvpT27byB0eZfj8PtEBJFoAeMb+e2WxQe2MfPIc4uTNvF9fLDv57vXgH?=
 =?us-ascii?Q?cpbggS+nx0euNZ4n3fE5ozzVvtmUWkot+OsuRWK/gl6FC3LMBDJvzCqYsxPg?=
 =?us-ascii?Q?8/xFyEvVq8wS4Nvm8SHonioWfsW24buv8PcbkHwUu65tC+je3Obps/Ry1gDi?=
 =?us-ascii?Q?slvqwQsVidHCeoHvFhInWDiydR+cP9v6/Nv642Jb+OGO5h4jaGnSBGw87MAQ?=
 =?us-ascii?Q?eb10OcV0tAS7Pqqh6agsSVaoyOI96q0dw27Iu4i6dGiQ9fruHbbPLDYs1dNG?=
 =?us-ascii?Q?78ikSdMDoIuRzVLTa6AsU7XfxOohsDVjTEbrlX6X5Oe4SX0nmWxGJZKO6iPj?=
 =?us-ascii?Q?nqzHypim1LiosJajff9enz+IDCt0knDgf+r5UkwE8DFdbTpg5sGceyNjDfNI?=
 =?us-ascii?Q?oUDX+z9MZBu91cBHlNWpy8QTBr4IbIkdA0LwqFBXaV1q8ym3nGghnmItE5k1?=
 =?us-ascii?Q?MQr1+WBCzpC+FFz3Toc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1acae1-ed09-46df-0151-08dad14769b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:49:48.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eODklD147EqE+bhmjthJJv1zFczsZWzpy9faTc2Jue0ybYVM6xFvVDSFCygryUmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:34PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/mtk_iommu.c | 9 ---------
>  1 file changed, 9 deletions(-)

I listed this driver as not supporting default domains:

https://lore.kernel.org/linux-iommu/20220516135741.GV1343366@nvidia.com/

?

Has something changed? Did I get it wrong?

Jason
