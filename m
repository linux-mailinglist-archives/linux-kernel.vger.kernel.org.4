Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB2D63AA22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiK1NyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiK1Nx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:53:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF1B7C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZMADT/UVGkXCxchjSr5cmtNhE4Zv8DcY9SPDZPkGndMQ5cuR/GepRWRPj6juZd7QAv/KpPzdWlK0Wj5b1CXECMVlq4mMIybllKgTknGNxODQ9hVlevt9yvH6QQD4jq+GXGofMiSTeO+VWJ+7i8tiXMVDEbFa8ZFsWYrFS9/uYIDTprfoVMarORxns12g8LZh3/+IZYsZ4pJ9A9kRVpSO46TZ1AD7DvTW5LPG822K/pZlgzfeMmGQIZdeEzBESAEwIyutWa1dA/oCJuisEujIyVapvk8JmkCbaO/hu+CiARKtJK5DMW5TdRtgPBW48hwwcw+4ZJucKG2Sm/X1Hd/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlVoQATNK7kj+v0R63+mKvPKg0Sz3AzWbUH0JgdUlrQ=;
 b=JfoE37BF4oygZUGoUp9Fp8uGPu7dycTp6hc+cz/r+snGso2VqFjrRS+10yPqDxH7gyiJAlPpDIGFvJijj0yTQlbTPu09u8IUQKqCmAq/B49mN2mZCDhze8VAjXdkGWoL4seMFNlXCzIKfaKVK3ca12MbLs9D4K0/oXftSs2c3r2UVkiEYFeuWUAvyPNshJSRdcBBrxoqMtUwfjKGSajBDQcnZF+yJVtfKmvyYwlaYgli5jBWtSBd3c0oL4D5Jyc26nG/KXZCPyws3vN6U4XLCvWizDE2D0PUowHvqjdeagYIgUgwglv31vSAXmc16V7aDWUOwchUZPDN67NNS6zqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlVoQATNK7kj+v0R63+mKvPKg0Sz3AzWbUH0JgdUlrQ=;
 b=XTaELbVIYSRJ8Eshtw6wQu9Sfzp/s4e4gdeXIFnEw0fUEqLFWn3wEdSQCVHiV18ox+3o268C4CwOsTq4VKBk3wFo8DDMWFpofOMEpPXnwougwZ5cH3N0tgg+oPY86LSfEQnpsspdaYgmDLJZM2N37wYwsQ5uU2yRfjyY6y6Et1suNuB0Mxkhre4qqH0yxS/rFZ8fTUVmP7lelxGonXpeUahz8I3UnQZjC/3ZD6V+5x3p0AG2wkvYTRv1QmAV2Yu5i0C8iL3QoJXJGeod97DdI63odVx+wnOm9uvazw9iByuyG4Fq5Mdg05eh+bIw4yezq0jMyhmd8G0Ywvol6FSDzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:53:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:53:55 +0000
Date:   Mon, 28 Nov 2022 09:53:54 -0400
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
Subject: Re: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
Message-ID: <Y4S9cp0LYmjdz0mu@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:208:35::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb056d9-7e69-44d5-6108-08dad147fd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ir7GHac9hdAMJWlw/XIs9yCZdv3nDTdfIUbWiH8++8lLGFWxV3CDprhxdfCJgHzZxcm606WaMS00tUWx/kyNlrlzEBZm0d1pZODB0u1ugvKJSeTwGMyqdZyjuT2tpKNhlSyjvH9NrbLMJbdYqbwPNJg6tjxenwxG6IAVLsPln0iuRTC+gdks7+Be6Tr3xrSPOB61IkyuqggWpvm4wKvkib/m59tj7bykal/pHzcStWgx4IqTKEtKg4F5WQzxB3Jw9Xmt3xWqTA7Qa9ojX4JB0RMD6FuK6W7IamgvtVwyYTRr64rZ3pcZTMrS1iAY3YYd2MoZbnO1DH56oe2+yqfKxp40u8wXRkhxV++CKu7mC5hAiOV3KPi4fYfqPqC3G3DAizd+ixuti9U5KXm74kYvfVsVA9GH81V+ypDUrXrDWdCDJTLDs2M33pbB77ghfZ0acVAnR9tEynb5bK6yqr1NrYOvf6SGwyL7OwUckjDXK9Dhngx0lu2xRTxOjEvL10KuTUFDO6MfQ7W5KuUmi1HzPjjmK1dP1xJLVT+ZYu8jRG6Jk0XtPgGZd4AUXmcMn8e9YzfgGIEwekeBXEXmEtg8paW3s5L8ueSEqCtG8lowDFwGdtfGKDM6T+Wc4/+33BXRs9Dn7Lh/py5olfDqSKNuaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(83380400001)(86362001)(6916009)(54906003)(6506007)(6486002)(6512007)(36756003)(38100700002)(26005)(186003)(2616005)(7416002)(4744005)(8936002)(5660300002)(478600001)(8676002)(66946007)(66476007)(4326008)(41300700001)(316002)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFT7/xaD00SCn5X/BYCgkfs0g7uuXjKjOxsvhGBI3wf4DUeEA/ljIsxhLJ3Z?=
 =?us-ascii?Q?Yd05wzDxddbDYkHjb+zgFX04ZJ+/MffYgNim1/xcWJpuBnMoI7TMmxagFovY?=
 =?us-ascii?Q?CTfTSag5XTF1PjXEjuRacZnjyIGhg/ObwR7piVd7v7EPrCnAnjavEUKBQ4DH?=
 =?us-ascii?Q?SJ9LU4wnqXSwqgtCC5w2huhIqfwI4KPSjqtUg94NkP+kZlueGIOYmN+1qgad?=
 =?us-ascii?Q?FOM/j4W6hPJTbzLcEH1/pWqVExPQ2geSA4zLEhlwzHuwh0ytudVVbZRLhwdx?=
 =?us-ascii?Q?ffE7TltSa8gOvnoT1M2UnDdd4aNiiYBId2O4JwgUfzhf3iQA55XdaqbMG/dw?=
 =?us-ascii?Q?DcqI1Ui/t+Lw5StFOCccGmQA275nv2PXmj5flnRZjTpx4dVT+YCfQ1bvc6AT?=
 =?us-ascii?Q?NercaGfJDQ2tGlMaQnXwcYECOeVLqaPwiTgmNcBLXE4vwfhI9ZytMLH2w7bW?=
 =?us-ascii?Q?1EmfPZu2tHRRiUvzhEAE3TFq4/xGTa9rnKVGTlfYpKX33syzZrubCv44Pj8q?=
 =?us-ascii?Q?J3gQsINDza+98k93bvd7lHPcyW3EyWweLU0KPAlgay/6UCGxQwvAdopZsJ0x?=
 =?us-ascii?Q?KxoDDHTbo85++UVKz6XJOuTfc0gyF7LMy4leOfIGsY8W6sav1A/iLMy2uJvq?=
 =?us-ascii?Q?rWQSJv3o1gDPUJRhh7oEXruYpOBpGAWwxXKIZRtkkzqu1x/bItFbgGieqF2+?=
 =?us-ascii?Q?OgvWO/hA/R9l20yCMpNj7SfqsZCw5rdoFg2exwOoj3R1jdgXGme4DMor+uwq?=
 =?us-ascii?Q?Kn45lETMgJXIA0oschXpIhYzdxgX9obQzPq2Dg9gc9p2uUFh80a7qrpPkUoa?=
 =?us-ascii?Q?wixs3HzOQwqY1SKo8ticVcKRVmw6LIrUHtBqd5lMFSOtqNoGR5jM0hi/lPLw?=
 =?us-ascii?Q?rhcLkzyiYguZ/FWr3mX2X6+AE9ycHJAxaIwHQJysZnotmX8knERImSOWu5gg?=
 =?us-ascii?Q?tbZJ6935lqoaDcrDlu8Nrn0INfWs2BFG0c32vWMgTxBJTUvq8JajAmkdVeYa?=
 =?us-ascii?Q?xGXF4kZkWc14q70FYZieba/8+YFbs4tVGyZSI+zef2QfCE2LOdQpETTMIBpr?=
 =?us-ascii?Q?sjFdnR9Fc3z8bUa6M4qWPy6D63OYUN2uwkvjrI4hmVqotY7gOIAxs+Bog3sK?=
 =?us-ascii?Q?W3A/yBD6Nb5ufok2tt0d9JK1gKUsznpRnxNd7En1XRKUlq2TX6eeClHwF++e?=
 =?us-ascii?Q?hxlulQ86H5k+TahEePhHfDhxYBHQUW/QLKTi3o/UQaJ/FqI2lXzqvhGZmHv+?=
 =?us-ascii?Q?OZckSf7ybVqqwGx+EmUWR/Ic6C1O9Qz+tH9WjEB8XuSvbWhKaiSKoa51Y+KX?=
 =?us-ascii?Q?mp1HE2cIDomiypz0ZIS31atMvEn/t9BBgfEmWgzl7eAaYOjf31EMWx4MsrOc?=
 =?us-ascii?Q?4KehOKA/g/Tza62ahyEMWus6kCC+rOqrQAFM5hp+alVw4AYMbYqMwNkELlbO?=
 =?us-ascii?Q?C3fdwc80EpxqpHOgnYeUHsQiN5OKVh4zjb6VzgvmCQVyEROY3ilDql1d7uLq?=
 =?us-ascii?Q?3AZtVW8zfS2iMTX1o/uTzNfJ4Z+kJHLOqpTnMIqmnjWurknvAeK2usjeFUOC?=
 =?us-ascii?Q?n8ia5XiC5qFopAvkWNU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb056d9-7e69-44d5-6108-08dad147fd8e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:53:55.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlGm/a7AF0M+bLYz9ik1+fnbmHHqA8DRuWZ39TKF+ve6nZqfIssX2t5QH+0exvvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:36PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/sprd-iommu.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
