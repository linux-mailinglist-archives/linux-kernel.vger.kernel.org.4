Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB365D409
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbjADNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjADNUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:20:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C61EEEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne6FoO/A7IDSNQWF31/7OXePzsxuliuNptQt5uxIJdOBhmx18oAslp2gB52/SEjsXqhKbxwiXDAvHF3aHexw9D82nzGtx7d3bnDnS/KRtX+0wBvMFru2xl+pYzW3SK274PTW/ub4KK55prJWZfPmmDQBZpQD+yUvJjodPrqt/wixcGGbVIDNFnOVaPbRMavbbiKqHY66SJMMfEUGlUbZQWNeDBjPIq+4A7Ln4Uc1/wN0/aU5/lcxN9OaZALHL5TEI/elwoEAd9vb4sy2oZJBgUjf/Ef4zdwIbKzicSEJVOu/uBk/zCRXHcjUrrGnAmljfdROKshAItzIWKxjYxBKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA+kDTpYARoIt9FG99uT3FfVJ6bkcvy9AJ+xKLlMFTw=;
 b=SSsEtsxadXEe7anCeus6IzyXzASbZ4MOIAmZL9Sb+gF5Ks21wk8JuQgGKq9buP74DVBcNfijvFo4Js03p7p0eQoy8cbpXsmO4nv51DaLpZzKZdCvXZhN4DZDIrR0VfWlXJcvxnVMHKsKGMPBLHWFeBHUsuP64NnwgbEooEH3T6pxFK4NyASipSFZIs/J5zD3CXQ5adg5X4TezhY/rEWMlnsUFkDTIDgzVRqIvVAs+aV1lzF/H9EbkhPA4BEQ98NPLPq1NXfhAlPQ8HaH2jYfRmisonBjKFsajS8JWu3MtMVmq+9lYHHnMTRt3gDyYWJA+tfTKpsIPi9DLVoi2kmsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA+kDTpYARoIt9FG99uT3FfVJ6bkcvy9AJ+xKLlMFTw=;
 b=oibO/YJG13DFWv8nkwgUtIrErwadZqNPm8dHSbWUoVDgO9DU63s+1ZoUsMmjamOmjmDOJoyGzm358rPITEOlP/PgHd+FrEj/nDEoTOf5BrkVm2tY0qfPZK8ebeqBzULMFgDte799+fcozi2geJJOzmxFMmn30B3xYJD4pCgBMmk6bZMGje+c8xoNEMNF4p0cHr1BWgDp9y3GlURPmYFoqAJa2RUw/+06mpblmo63l1hWwuvqR3SxMfA623gfWa05COyb3JePF0NUDBcg6CYcF6lDx3ND9aKz+lil2QJHbGbXFI2gZ1WrH6eV4zyW39vuG3aA0IrHJKideRuMFor1aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:20:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:20:09 +0000
Date:   Wed, 4 Jan 2023 09:20:07 -0400
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
Subject: Re: [PATCH v4 15/19] iommu/s390: Add set_platform_dma_ops callback
Message-ID: <Y7V9B9+VIHbnnIV+@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-16-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-16-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:208:32f::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c49169d-c708-4c8e-8bb7-08daee5666f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zg4/+GYkugNxxvMwr9yg58Ge49Td/BYIkfe3gNtdpME3iQdBe/wk03TI8A5kKLyAgV7uh5O00dAqz7OI32btaebvKEBFTNpbqbWtsJVQrM2tgQ2sw0+z+9zLZKIZGKYQhFNk5gWrcOiVtEWvtFEBOHp5OOTeGSSZzAl0fSylr/xFGyelA4Jvn0Z35XqHNBBvbt5DeyJpIrFjGRFeNV+ExAZu4D7jjWr3IHEIvpTsFzptFCGJxaA+/tPIe3etBi1c3NpSP3nMv3cpvmmhuW8nMppCXEBD1WCGCXnvHCKfJopUJgQXB6lVeYmFdpvjmHtRabrdwLhBmnkDP2FoO+HiOcq+scEZXNMXPvvSN7rbmVffMaCGiCZFDbthvDUAtDDc6dFfqbQf9fyn588Z14vBZBS0dUdaTUiS8vaTR92mrvcoJDXWQhlcN8al3wKFxitUhhNWPKfbvnDxzkdxbH5f+Wlio9WRX2o8svpg12okYlddUekC1yjRfsQ/QCzM7l58rCxgo9RHHT1xbQCoxvDu+EExb97ROA4M6C5Tn4PbpIGLF//sESwBxjjRXKHWmOydrES5P2HLk0au0yNfk+/3SmnndQJliYR4HvzoNnIEzHiFAc8Jt0ds/P4+C5GzwshtrsBWWfXoxftz7k+DQ27q4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(2906002)(86362001)(54906003)(316002)(6486002)(478600001)(8936002)(5660300002)(4744005)(7416002)(66946007)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdN/9qHkhHNBDnbuDA4RtogV1fRQ6UI6t1R0/0Cv6SlP0EeHFwk0HmP3Ie2F?=
 =?us-ascii?Q?v4MUVXbUtgr0W2BqZ+v8pyR0GLDpvabeOnAjDvIWbgWb4ujOAiMmdKl8u4Mi?=
 =?us-ascii?Q?26zeC6EGZGsgiRs8kN9d4UmcZJ4wfk7reWoKCPf+plsjz2wWidVmW+TgqXhR?=
 =?us-ascii?Q?yu/yiH35Yb3UYVfRmTOKvNccIm1RCYInsFiMd6MH3Tc9BWMd7wMvKgIEiE6k?=
 =?us-ascii?Q?hirBGT74R3T9DbbSM+0aC9UXb0h6IAoy18/QCmKR7Fu+5sbNjQnOCckaGrq+?=
 =?us-ascii?Q?mByrLydlP/15//o8EEwUnX1F7SA0FmWrfPV3uIHgfVR/p9djV3mj/tdbi97v?=
 =?us-ascii?Q?f/9TDWPacZU4obKQS98DQr8M+v/PKe1e7f0a2jrHfCKOaq/gBK9Pz+3DLIWl?=
 =?us-ascii?Q?mPGGLg5/L6hRJuN3uM3nzqU72RhL3kQqj9lOUgbQxCeV+5m5Ybx/Qs9GKctz?=
 =?us-ascii?Q?ZmduH/FCGnN7wKImEis4e+UlOVCVMLZtOT44yCl2eaBPrhpH7fo+MzpVbXas?=
 =?us-ascii?Q?9OPX03SoUIIzIK0aWo4XaDI7Fpd5qLqZx7/rkA6fn5AuvDprryLFnQ/Y+kIn?=
 =?us-ascii?Q?7PDdKRIBn/A5DVlVz5TfFAJ5Fe1oi+OXKNhTId/gXt+gEirAmvCWql+05JQQ?=
 =?us-ascii?Q?u1iUENWt13yP/ceCqdPYxSF2V6/LZ+vA4TQHlk30LK6FG16KJqwnwWGx6/9d?=
 =?us-ascii?Q?T3P0Ff9fEEsJ1humMkEtR3xlAAfav7WLb+lIk+sChNlfzziWV5mFWVLx1ILp?=
 =?us-ascii?Q?IVfhL/YTpiGtWS7h+NfdJP70jTsylR5ndQQyKkJfSZEv4xomiZtc/0v18miY?=
 =?us-ascii?Q?JAf05WgStmDd49tukojbfUxmwaWOIy4S2eGDJ9iGaql3jY7RLlXw6MSDoGRB?=
 =?us-ascii?Q?SDFu5lvvy0BVCgPbgIhSHAHO2jnlTDSf7Pl5nQHRT6OimfN83exd0bJo20bv?=
 =?us-ascii?Q?BksKrKtfLUfpOPHc5NZgg1AjQixbKMUt8G4qJdKiX9RcW4d8Slb0+RsMbBvX?=
 =?us-ascii?Q?pU7fC0btxXtfnYRldNHmqI4TZMVOt+kH+JMufgYHo5kmrB6a3SwKOXymVzSC?=
 =?us-ascii?Q?aCFdLSgCr01DbThOkn5g18GmN0ZkpjyaFEgp5GXXN2+Jiu9tMGKdbzx6A8hH?=
 =?us-ascii?Q?t+RPbXheNWD8P4DCHW+VXE4kzEmz775Nn1I0GwakZpOKc2z8O6gRlc427H3j?=
 =?us-ascii?Q?fVYa4vNeSy/ePvopbBj846kDjj7IqCsHbCh+5yZXF0TKNcbol5OPq3h2HVK2?=
 =?us-ascii?Q?TjgpbQRDOY20hdXAx3whj7D4F8sKy83OW+XNWo43D9U1VFCaezH5kzOReX0u?=
 =?us-ascii?Q?GaV4sEe0SqJDV99VBxm4B6aLayHHQt6AkBogDF+I/tzn18+TIFkbTeGznKDD?=
 =?us-ascii?Q?9/OqEbORyFv8qHlbNyiiQyIOieISfrgK6NVa+tB9f6xeEz2S3VNIV3NTs5PO?=
 =?us-ascii?Q?Y7G4IER9fyJQh7Wqd0lnFt/8E2wOb6nujTIfphoSCU3jJfmpRu8yzLyr0bfH?=
 =?us-ascii?Q?tXJAhRbKi/MI3/VXr3V4qlsy0ptY5WWO/XN6i6ZoNUK6+U9DUMQs5d7TwT8o?=
 =?us-ascii?Q?7skIirkaKX6pbOkSIGMWKVS0+gho1vkKrgmH4569?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c49169d-c708-4c8e-8bb7-08daee5666f9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:20:09.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzIPsSuq3fiSBz/H+dKJEZjxHhBBDuRRnmn7L71fWuoJi8vC0IWn3ddNiJmauPTC
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

On Wed, Jan 04, 2023 at 08:57:21PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With the set_platform_dma implemented, there's no need for
> detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/s390-iommu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
