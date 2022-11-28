Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610263A9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiK1NmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiK1NmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:42:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B36B4A8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:42:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJhK6/Y6PwPvSd+ZgZQsnbt4s/AnO/AStQvc5PSgKWcrKSPPW0j7VoJ7e4OlTcUC2XL9ANXxJx4HcOE/nf1UylUW8bcMRCyn64Ld6/3yo+I3G5hgDd2+Rl8+lDlt2Sokoxmr7QvN1t+7YnkRPsu3kUKTlnmUjDsz277ylE3K2/UPVoPjEj0S0z8yL8/yCK7l7uKzBUWnupIvDAnxH7Ng583d5LWeySY3yGDvjq6q3X28qU7U4nQNEE4HQB63MRcnv3rJuSMpsr3Mq7rm7VtSSZihgaMkkjC0S+X7kC0NY52B2ezT0vQub+nwLdFt0gsqDVqrhYzwVjRzcNxnUZuolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cs/XAb7uK4LG8cHKYjfwoKCohhHAnbvEzq41eFGym8=;
 b=IkBDb+mnx1Yfj0QaAugYGgVk3h6Q2wqJEhgMi3One6YA5goLaGbBL67PkZZ4OajnU8m5yk16evOxBUJ5Gmf105T/yPRIowown7KY6b63bfKv43Zn0v4sZTUzmku+2xWy3Qk4wLNREfnM1UZsBOO0mohRzQ2nWwZ/BGWGBH9bXFHWU888cEEdPobQBIa7jLUB5GwDs0NCnPQL4cAfDNkGmhp2wND8fS9oF5WFQuCMz8SRAptm40wgSs4YfXvQ3C3Qrxr8LI6elCgqjfJGaRA6IsvvKSgX6jKCw4yv/h7x+veCrIgRI6EH38NydWbttwQv1EFwlamZdI0gFzIr5rYGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cs/XAb7uK4LG8cHKYjfwoKCohhHAnbvEzq41eFGym8=;
 b=eIIT4+Q7HioIPLGd9tr+vU8VJJ2sIPQURD0nXQVcPLCsxi6kGNuLeqEXPdr1JgsnSpzN+ed9RN+v7pSV4jQDgQ05YZI3TtkJ+ofa1SeukCU76V3M46TcgOvJc2XF/VMPnBQWVE443VaPGI4PV91l+s7r21UYb4r8SP4V/O01xOVvJRWEs2rLtdKG/vLAykQ3+EhuizkFp2QsWs2VxTFfjoPrn4G3vCMeGfGpAufklwSsbyQVIA9HfNV2jjZpgMiI62ON7IfpgRjG96/DmUVGkexZAH/yWSrtq9NJO1qOCjttXdSXaJFldI6yeWwVLnzcYn+gdxK1TZMQ8+kABf30dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:42:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:42:07 +0000
Date:   Mon, 28 Nov 2022 09:42:06 -0400
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
Subject: Re: [PATCH v3 01/20] iommu/amd: Remove detach_dev callback
Message-ID: <Y4S6rjcBHRY3oia1@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0979c4-9437-4a78-6dcd-08dad146578a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ekW2lV9LN0494gE9b3nGcyjRxoF0LSGJTSbpGqUOpT3SuU68f/7zMM/bzeGU+LDI26o4MCxwk8RPwDkUaw9pfkjLYhEygnnjLGeM5xvpg/ZMbVfmwEf/xm/rl0gtnHQXn12NKIq5SacYcllszAuxtZkKXeoWhU1P/UfPLqV2iXJTjpSXyLz+D+r62VgA8h9gHA6jjMN8OlXL40G812SD9wg6TOhyVzDkvst5pSjmYVCI+12aExA7TDto0pzDM7562UmU5qWEZg9ODy74Of8DPpuo/3f8QUBP81ZD9d3ukZsfjXV0GnZGKrBPlJFui/XzNo6jQJ/CBAnVrX2l2/KiLU3IlFQOOls+jBbMBwD54kH5Se4bMcvMyzKYSbx8lUS3LWGkL2tKnUIz8i68gGoQ/l2GmrchWPj215pJdwrjSD6fJPBzUd3pNFQsb8GM3RSGxryVBfVUQk+SzM88JianfIRyPVFnzyI3Bxb52J93YuXj58Q0wfy5jyoxacgruLBWnMrqEomxaDlZ/oeU1EFeLvHfPIxfca2Z6zeI02RFOLQRIUUUdwiKlZ4izvFwMh7x0FdJTF6kVJLRQWv4nkGsfd/QWjmpeeXzvJiFVGL6K6a2tFWlCB/85rywoM/zPa+rQ8UEMw3jm0yBvheurAwXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(6486002)(6506007)(83380400001)(86362001)(478600001)(26005)(2616005)(6512007)(6916009)(316002)(54906003)(41300700001)(4744005)(5660300002)(7416002)(38100700002)(2906002)(36756003)(186003)(8936002)(8676002)(66556008)(66476007)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AH191gH3PKGB8o3eL8xxoEiaHriGl4FPFXHX61TQ6rvGe1fEQfY8D7Pr+6j?=
 =?us-ascii?Q?ztTJ/MN1PrBpueGuMAsexJW3fvlOl/RolSdByohLfIyFvhiF2Oow+2LAOXfV?=
 =?us-ascii?Q?kUWpuwB/UXe+xARO6ecpyf2SPWwl3Brub9rw3IPsnLT8t4cA7qaXxbuSPBjj?=
 =?us-ascii?Q?X3CJBipQgsF5GyvzIwdV/rT25dsv18BVEJ/9MEzGSOUx60UgMUrLP5J65Y0e?=
 =?us-ascii?Q?i2uTWLnAQtzKWtHUjEpen5bYGT0urjlP4ADsazJHqweggRm4X0trEKPjPPCY?=
 =?us-ascii?Q?3V6iWgGwl6LOWKz1PH3i565K8jdUPpVIz/IL7bok+rygfPwQeoXSvm7a+63c?=
 =?us-ascii?Q?iHmis4qmvS4glqNoEfVAbIONl3YFIxd6i/W7D8v2uMmeHjzBSrVg/bIyz2zx?=
 =?us-ascii?Q?ddjb6+aa2PjgmWofyOiaktwJfsjk021ln2sP4D5Ery2gOT03DvKF2lBVpo+x?=
 =?us-ascii?Q?7/tO237TVJKbwKMy4pRLpmBw5o3Pi2LyWw+GPlqvD6TVo++b+ksp72sWnJGd?=
 =?us-ascii?Q?tWYTR/dG7KAnMLTI5+uzYWxIEVW37PdQ0JxJ5TC1Zq0QgcYGvYXHJ392M1WV?=
 =?us-ascii?Q?zBKoprs1yuenVE4MdW83DieuPYas7SgpJbN+LdCnwh3alwkb+5jBUei5BSF3?=
 =?us-ascii?Q?tvQZ9dc+h+SN8h9R5NOpaR8M0MqT9nvMGdgBB8oXAJ12rNj51sIyTOTj77cW?=
 =?us-ascii?Q?wyKKpSZ9EbJgrRTLgfgupKc6NoLpL+rq/KlYB4gfpa1tOHw92AWkd7w6Ln8h?=
 =?us-ascii?Q?+KomuOyTOwC/C2dHiRuYTgVRi3RnBXjzss2nvQBOxwg5vVSsIFCk3TtTKCfF?=
 =?us-ascii?Q?U6eknyHQuF/ySEU9uL71RoGxSq4PPFwvpbzzEvCwnftsvVbIEeANQAqiQE8c?=
 =?us-ascii?Q?xTiE3rJeteZhJCos3eLKsPsRkPRDf790YFY0OWWO1g7JWvEIFIzk1gSUJsgM?=
 =?us-ascii?Q?sKL6mCTeXxpwnGge2sqnp0rBLCkHdTBEehABAHDAzJ5yMGeLIUzP0iSsQZI+?=
 =?us-ascii?Q?fkt/Kjv5/v5Fza+YihSrPj8TXO17cXgVE+mGuJ3WM3GHaIu0sO2jhF0Jc6m+?=
 =?us-ascii?Q?8/AuLHXICzDDlzKH1qOTPryB2P6ofAdOqj5BPw4OEu8HYKwWlimm/6hse5+1?=
 =?us-ascii?Q?Zx8Cu0wBRUOT/9VExANcw2Z8tr2jwaut+28xCuZ0sHULcUaeTR7RhRxOhwoj?=
 =?us-ascii?Q?rJBHEMhaNR/IhEQK6blZNaSOL3UG680sBLCg/KUX47keGeF4wM0QF22vfdeT?=
 =?us-ascii?Q?iE0ii+hGLDuhDWen2JcesUdFlsKX74YaxssguHRLYsEwwfiYxjr6N7/9krcg?=
 =?us-ascii?Q?380Jq6H2fVw7FpdCKLDjWzLgB4RxUsaxrp+DA2C+fQSpyGwT1sLpyk8P55G3?=
 =?us-ascii?Q?pTorvGwN9gANMEVi45XTJPq1sl3jys/Ruv6QrLjSGnJSjnpuKbFlDrbiEHHH?=
 =?us-ascii?Q?7OxUDhdcmNjIIIenDT2Lk/hrre8CJXecKJzw82xDeIxCTD2cZLuVzcYVvKri?=
 =?us-ascii?Q?Jw0LbKnW3OiG2IjoVdYKHF4QMKo3ST51kRWKeU9mkIrFdGs5Re+yJr0rpixH?=
 =?us-ascii?Q?fgmRvNnJNcryYjiLcdM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0979c4-9437-4a78-6dcd-08dad146578a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:42:07.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqaAXM6okX2S6XyUvauIu4c3wg0yrpUzK1BphiYOOrXTSz2i+GU0MMLxsAWEsimD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:29PM +0800, Lu Baolu wrote:
> The AMD IOMMU supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/amd/iommu.c | 26 --------------------------
>  1 file changed, 26 deletions(-)

Driver oweners should look at what their detach_dev does and comment
in this series - eg if this is actually blocking DMA then it would be
great to convert it into a blocking domain.

But there is no issue with deleting it, and the blocking domain is an
optimization.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
