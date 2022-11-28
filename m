Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6963A9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiK1NpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiK1No4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:44:56 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB313FBA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:44:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2Yvgjlcu02RhXy8aPjer5dehoiugkXrjd99/jsxdmy1TDV3Vq3usHx3rJvBB6d71wMMpxunshCAp95wfdLKLjD/rkJPPuv33SYzFSaNM/GIj7AUCvJqgoU8K2IHiwNwrYiQIJqFEoX1yj2zBBr4vgNFeZvVXJbpKZHs1RtoucCeJmFCaolZ1PIvFyaMWtgo4+LfFLXoLggNIkhuIHRkH7ADSnlXU3oDcRHVESigYxxVBxtUJSr00Ek+D79Po7fgbW7MydKDInhnjAg3/ZiDnwJAIiaJXiJqI2Gy4cwUmGYgaySKChf+g9xUAveiD7hTG5fkMuJEQRWlfNI6J+BeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVnhlhe0m+LhBFD0kDkC8/2JfFh7MHX9zEXAXyIBaTg=;
 b=Eu/mgJhLUV7Ho3vY7AyWCz+QC1VNxWRQkTzk8+h7GyDyhvmuMToxGO4ayRhtffET9z8CCgut9J9uBgTbrbs7hNGWKiiRo648yVdVGBrzLO8OvOtMkfQZC8KmiVU18ULwsajEemZ72yxGNvaFTQsslndHI6b8fJ08jG/f0dCW3zAtyst8IC9x3PJaF16xmdXF9kWKBFbqtVK5zcD2jpHaqt3om5L3RV/aX70d5515asjy7airQNOWxDEjoG9Wnt2CEzk+WfRLcsoxRkWLf91XgX3W/wGxl4dF9KZUXAxO0HK2ItwEBX29ZOqibRyrWH3rovttkO4X2TuZBn75brdjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVnhlhe0m+LhBFD0kDkC8/2JfFh7MHX9zEXAXyIBaTg=;
 b=uoSdiWiZ/of8iULU2xAlpqAggg/bpdp6K5zwdEq+9+Uxin7RdiAi0ZyDWRUBTx6xcWL+FXP5puou5TLtNPSWpuKo8bUlpckt6FPeWyYbV8oIdG1g9sc6orD0aWTTMSnwf4865ksnoZ17Ap1lXdRuW4SPPVG9b4vOS46IK0pjinmu+9ytrumrto4Q9+Jxf0Eg91zt8B979G2HjXEN3gXk30Dp8ej38LWv8EP1BR/kF992NCHekbElwvgcIhgjq/Lk0OyyvpZ4kQhGcWYA1ewY1yK+/Tfpn5fF5o2j5KP58gVO31j//4m4JHcMQsbiYYRBTzYTncHAZqGCiUPNY715ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:44:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:44:54 +0000
Date:   Mon, 28 Nov 2022 09:44:52 -0400
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
Subject: Re: [PATCH v3 05/20] iommu/ipmmu: Remove detach_dev callback
Message-ID: <Y4S7VFwEmYONjRwn@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR0102CA0047.prod.exchangelabs.com
 (2603:10b6:208:25::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 005da6d7-b1ed-4fbf-d22d-08dad146badb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHq1bqkDiYCwsudFyr1J9aJbo+lImTZlP4T6RpX+JGL6Yy8vpDAziwrk3hr9LDwFYCe6RvkWGCCS/jV0VNbhnkdo6m5B3Y6/XxCstJBaydL580wU1haB7tzyV6q2uySRYq018hA+Z/3A62KO1mEGFifWd2/1JcXitkUet5u0J5ch0KUBaZzU3RcoXcHDjhHcLdhIv4gWtPmZ4h+shoAAvvVH0JzwD0Sc8a7uH7n93qukYuP8q6zeqQY797cdmdhDJhKrrpDNvsFIt8oemgSDuCxFfMcyXkGidbno1L6+fRRSOwzNeHn3J+9BtuDvuKhxKBL/8MU8eRdTpOLj0M/YTM1MFei34hqU31gVaIHWbl8uJ3QV2CUnTis14dRynQxLAVEdc9TyF0L/wvL2NKIDUrm4zxI2lrfB/E+ujaz7qwRRxy1t53Au6M3iVLzqbnLz5Yxxw5EbzWQocnnMU7fC184MnKtLj0Yq2b+Zhi7HeaHgNWqpPCVlHVK4njJFMDVjAjUeJxuYHWbbVotIUepFOCyqNRGsZD7i6MFaO7ACBTkCNhRqkVB2qxMy0bHbADj+9T+ot6Hufbe9ClBeqx/ML/hHVt0CeJIf4KnETMVOwVXG9hQALtNRIH7RqSburL7NGZYV+BvFPPv5MXQDeNEI2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(66946007)(66556008)(66476007)(4744005)(7416002)(8936002)(5660300002)(41300700001)(36756003)(4326008)(86362001)(6506007)(26005)(6512007)(83380400001)(2616005)(186003)(54906003)(6916009)(316002)(6486002)(38100700002)(8676002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clBovU2sKmFDjyfJ2xYLrt4kNqntLmbwpg+z1hlOwa/aDAMk4JB/Ah2y5td+?=
 =?us-ascii?Q?Ujt9uiEijUhPXMUlyaT3mdnvPfKVKO+R/4GQEeKeKVyAywzV9RQimncSuuoZ?=
 =?us-ascii?Q?PGlUdBXL+VV+Qx5iJkuZkz/6TQzDq5emSMOgzo4I9L8WwpZX60vw7QM78Scy?=
 =?us-ascii?Q?3gJEBAEAwddaS+AGPbNSmfrqZUhAEWfaWdtf9rgyscUcxwS2Rpwy/8j9Dr32?=
 =?us-ascii?Q?TzWRvaGpngUYIEiBVMWi2djx6tvcU16nO5kenIsc4yz2jm/NMW0ir83+DfFu?=
 =?us-ascii?Q?OVQKYk8I+nlSOAyWxHe6xf09BR4umXLOLkQUlsPYhkFYHhO2T/LHT67oswVf?=
 =?us-ascii?Q?mY0Fb5IJO8POOt47aDx23uLOikYSiPRcq1yQGaAWXDWJ4XEFI0b8mxnIdGPC?=
 =?us-ascii?Q?RXbZicjlbo3wg6fljBUgNTTdf8wJuWUiouw5WRwnujdxR8JQGcwU7SZg/AwZ?=
 =?us-ascii?Q?67z4Xm20kr7RnLAYrJrriQNWzEWTxpwGD/pJZKX1sJo+n9ea8LeJnbiWnP/H?=
 =?us-ascii?Q?63sOcHTtjZ4KSCS0jY9qynkELPPKcW9YksqNXj6noDESbkix227aXroUXlFT?=
 =?us-ascii?Q?/5G51JVC13lUb4fN93D11CpNmrhvjBA00hXma1EzDoIEfkUXIo2pyncmxade?=
 =?us-ascii?Q?yx0DQiWm7CD3P/cMVU+OZZ+jBgUHJa2IQu3PhhBQqLlpkz7GiLd92qYvMt2F?=
 =?us-ascii?Q?bDklZ1V+/1r7n7UnSqcei+oDu4imrJxHNnvbRUKB6CavmfBVUYssK/o8JV7h?=
 =?us-ascii?Q?KWjbzpbDM51DusnuRJW09UtE+UzC5c1jBfcrT1cDkUwyndP6eBqKoLALNlSe?=
 =?us-ascii?Q?64wY+j6/r99GSmUyqgVocPa9948Gx167LulWSzw6PPjE5wH1FbnxJpWBAaAy?=
 =?us-ascii?Q?++uy0DrPVDCADnIzV1CLKvnKcbhB+V5hqSk3JQiIHyqSU0+Z9JeFE8sQWaXi?=
 =?us-ascii?Q?+sPye3mK0q74t2r6kMwO4X6EDIuTCgn+bQImmdYxXWo1i1fQ8Nz/lF1q2wh4?=
 =?us-ascii?Q?0+URQscUafOvDBVnNKihDubpuo2RrZZvSTHRcd++UStGT88l0lX2dk/XqmNd?=
 =?us-ascii?Q?VrWy2uHUtl+38Ty90g55bQWDPGXPNTOXI/249nu0xHjq4BIcHOZ1Jle3nZr6?=
 =?us-ascii?Q?90ZPqc+ETvr45iLgRZHOvi3Pke5MgxZpYCV3W6Y/NIPdvqF3YdGKFKoZ47pp?=
 =?us-ascii?Q?jQH/gI1ZGMJTQc67yLzM92FBHmtyqkbxhssU0Qq3SbyOT96M63LmXHeRtJJW?=
 =?us-ascii?Q?R61G0viPjaz08zxHRy0Leu45GJ99Qk6EbBN045gq0JeoPuUPKFg0Kmwm22hQ?=
 =?us-ascii?Q?cMzJwumKUBs4uATb9Dn6T+g3m4Act5Oxch4CCB/U37lTpiVgESZfG8Hls9q3?=
 =?us-ascii?Q?eat81cR2IcbE/9w6hd+BJe1DqTDV6ejDPcHLeY5r+lHU1lkjH3q20PBAWIG1?=
 =?us-ascii?Q?x2yBSVDA4qBMUy5P3UuJQRnskRWG7YrSqfPvz3XtB4CbcjRIyl+2FkYRS9+x?=
 =?us-ascii?Q?GRLkBye7+xJV46Qq3/4phBZVlQzSjJ7OCXXN7zlert2FyrWAAUcywaxGhEoO?=
 =?us-ascii?Q?CFfqsdSMMzp9TSuvonk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005da6d7-b1ed-4fbf-d22d-08dad146badb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:44:54.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcLTTjGo0n/cUfmfcAtN23ghtTObm1ct9TNXbUMZzmOmdOxcEBWAA5TxYkv88508
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:33PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
