Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34165D3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbjADNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239366AbjADNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:17:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248A115
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxaCwXzvNCGnAIvPfYtXRT59hJ1RQIcXMMxUok3ko6kHiGPbjZW0cFpqOarvfGHrSMLcJHkdXRaAGA1zpngLspMsNjsltWlEFwyC/ppIcwNsJG82fTHzA+fFggsE5nn+XOtb54elUb/DiHHb+x0DXr1VIV+Z4KM4s2I3sfjnq/87BtBBdR5mvIdos0t13AAJ/XkrvElr+G9FLO2Uoy+MRT6PZSGMI4jIqiVYl1Qav7TCSUpcfhzXO9AqiLxnNp8DPXevEknzaCj5PBwhNgbK0M9IPpaFZBwuOPZzt8E3ynf7/rVZMcr/3DnPOFTSuevjpXa8lqbNRqtbK/SnYfkqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cufeh3OtrcSCZdovhoOclFWO4trKPDf+qBOzzJqxwTU=;
 b=INjqTriK2SBrmfCrzHHJhnmo7zK3zUp6U4DXSPhLnBcFaqC6uExdzCsYUf+69QKet1X7ZG+CqARP16T+zIWrUv2PaMj1nFL1VnyQ/F9UH7HnYUcTj7SO+6a2ZTcZ1RFBn9FF04ceHxgiMcGKC1ZN2ScuMD6TBnTsdtUDFcTUojYDywggbuCP2Ym00SqfPgctoIENHbWrlD9ou5hnnxNciTvU2JAO+PDT3ZZL0o54wL7lphfoxH3ngclsHp1FvSeLr0frD/sevnlR7WRvTyt1YQkBlzjja39J7hZ+zC57XeBAFQAvhbaGZi5sLiTdrp8uixkxX6xIDe42ESPuc6RqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cufeh3OtrcSCZdovhoOclFWO4trKPDf+qBOzzJqxwTU=;
 b=YSFLEenOjsW2yiFkX1WFsiBjMd3C9zmCiAvDN9gob5dOkBSENEOF1ClUVF7VKCC/h62dx01dN1LuHjmuxg2kUTz2rpypT9JZ9HNLSZXx3dXMfyBJNsas+k7ank0qJPA5hGZx0RAGRPj2RJ6vzx8PcPZW5SMOw6e1SWFy2mRqUfZs9qtHcQEK2tmW/YSHTBki7M8ua6aQ+KrsT/+M3CQkN4HzPgkrze0ArItxV1yx47t+C8raCz93gX/xiqPalZpIqvzye69AWJyZUaVrRh+R85ylyz2L1VO6AVakxGvwawB++PsKSnE4Beze1QzoeJhSMmQaDlFhbmgjoNTVhU6J5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:17:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:17:34 +0000
Date:   Wed, 4 Jan 2023 09:17:33 -0400
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
Subject: Re: [PATCH v4 10/19] iommu: Add set_platform_dma_ops iommu ops
Message-ID: <Y7V8bcUF5zvGvCAP@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-11-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:208:120::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 9679b0af-c3cf-4deb-f15b-08daee560b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HADP2HmZgCgvZR4rnojkN7u2F2yEZgwUSVeLSHhrD7QA6cdOrk5+uA4nj8fKSG27PRhYKhW+70PIhPUg54V5Bw3CS+eYIHR2dpd1ukE1ajlCqds3vXJsCwuh7odSAKpHS8eybULklwutUDxFcIook84zlRtjRa5zcy74Ytpc4oS3MtXe52zj91lftvlJKl/ZawlcTiN5AIyMoEVRVMhmmJG0UGO/bNdmZqj5f2nNYaxzyl7D9D0dpZProdAOWw1RvfSjrC4Lrv/GkY75y2+3aHVVv0YBcct2g7rkAfl5JQWM6srnHn5DSWRGRGyn4qtGP0MF+R8tbJd2zDEJKSypWyTVWg6nqwDobxkxiAW+WaJvls8RuzETw65h2hVWfjEkuKqW3R8FWD1XSMgypAJ2AbJT7ZspT+oR0RWMBN9PiTDafNUQU4+2zEVkdtuEty7Ee4uEYbUku+yV57cq2aGlmgvv/RI84qHUNSRTXCCSD1Ho//pfPpjlfBuzNCTe8u6TAyGvZ2qjnFkUVUDBZ8OnP+aVDAaiutTOHXvDNrSg1onm8E0bW1a2IF3uKfQ1dZSkHL1cfJ0BlgdK45wtvylNYvnVAMpKpecOiPsNSmogAnBWGgEQHwgNk0trtpS70nB0vQsG+NNjVC3/7b/obhck0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(66946007)(4326008)(66476007)(8676002)(5660300002)(66556008)(8936002)(316002)(6916009)(2906002)(7416002)(6506007)(6486002)(478600001)(54906003)(41300700001)(6512007)(186003)(26005)(2616005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVmOkE6nYpMwirj/EyLsNrN4QmxV4HXM6N3hp3v+VkP6mLI4m5/9sMSlv/Rl?=
 =?us-ascii?Q?cKc7QxYuNgBCn++YTItLxAxXXkFMBuVQ9Q9LTKvchVztjJraV7u2VSirJqV+?=
 =?us-ascii?Q?onKH4cRuhYZ11dQ50h02qWEO6aMdsIgJbT5CKtr0Bwt0lZShRRvwyijSlCtS?=
 =?us-ascii?Q?aCPq4cZLMhEpVYH+PfaObVqreP2uUoHV8/1Oq/Ly3lsKzcFtxqR5GND7MskP?=
 =?us-ascii?Q?i9MwgE4M9XgIupBr5Cnnx/M2+PWtLezlZWXsuRWo9VYI0I3xUdTTy8Fb7p6+?=
 =?us-ascii?Q?flBh4khmh6JQwPK6Dr4zlA1awp+fnAeSEDveqDpSGQh1VTHtdNs4fZxlf53S?=
 =?us-ascii?Q?6i2/yCFu8jCpRnPfxU2zwdWyMg3P5Nw0Yzez0owjILlaK/lYyG0+PgV3Fumb?=
 =?us-ascii?Q?MmSjJEtQHmTTsqo793kVRqztzmHsUYnfVS2Ue9FSaftLu3Z9/qfSxA8ueHWl?=
 =?us-ascii?Q?cpz3od7xEjB0UyVqrd+v+HqeflJnZxt2hFjoAPQZq/UbffB6IRWFwTpyIsON?=
 =?us-ascii?Q?mbeNkUqKKEhmvKvwGqgVuRfO6lIv6AmcoS9FToBxQ3ZR3PtMcdylWxnFzvBM?=
 =?us-ascii?Q?2SD5WyIyckj7E4BxNIp+UbuhDni1aBoX8U7g3UXbe0kQX6t5cf154HsZvEdo?=
 =?us-ascii?Q?wSNpT2fwBiejqkVvbKdjYSKqXduKsvUIc073LbNhmzv0Ac74gI97ZlEkKr/2?=
 =?us-ascii?Q?lOutPVksvfyr41YgWxriSRgzJHUEYY5EoTd41ybH4jfNzeA+ILX5ir6/veI+?=
 =?us-ascii?Q?3jcxmuMkWPjplX/v9lJO9k1N3ISHVPvvrVi+w/OSViETonBRSrF38dIbyqCq?=
 =?us-ascii?Q?iodedp6BGaLX66zWwnPpJ9jZph8U8znpwbaLv9mgDM3000hyTfjIT7xXf8jx?=
 =?us-ascii?Q?RCMLrkU/KpdZ6xkssCZFkVAgWnWvccxhcyW1bk+UaFZCwgQg+HUXxFUP4G4d?=
 =?us-ascii?Q?3x3/NqSbq3/ltoAvPxz3O8obvkkkjLitEh5PgD959O1YUK5amcHUICCJhv7W?=
 =?us-ascii?Q?4OG+Mu0MrcfnRhUEuyp9u4CwaxEDumssDGAZlFcUGyLZjMTx4yp8cF98VedQ?=
 =?us-ascii?Q?FHfax4Ko5Qyx8XCS4llI4S8+bW/2GISiy5PDZzBEmNWYbv9+JPb9mlc4krC0?=
 =?us-ascii?Q?3eE3/RvjiH1kC3PSAURg3vxG3Ws3sGi105x/TtXokBFqdkrB6MHz0Ge6MA7h?=
 =?us-ascii?Q?/15JV8HKH3FY4LgtnHcGeEzQa/5x5gtmR4Jaxq+Qy9Wc2bAefwxMRUWeGqD0?=
 =?us-ascii?Q?2Tu3O6RZPL742S2LE2lvbDgz5VpkJtKdmSRWEIuOmtzo6pCMj90AYMWOE3Gy?=
 =?us-ascii?Q?yRmsE9zyIT4u4jt4Nuh1xZ1CBz3k4n3pIULGGQe2+lXp1+fd+ucFBC88dZpu?=
 =?us-ascii?Q?dspDJeJXNu42K9RTW6c/O650hcgrLXkxLBKHXV5irgKwqgacFnmY72rYQLgf?=
 =?us-ascii?Q?ANo+oPY6zEx8t9JRtp7hN3+BodKu/kSlkHlnJa9oZD0E64DH5fs4Y7ceb0i3?=
 =?us-ascii?Q?VU9XJc4Ec50oPAV2lJq5WCYWHIeFybS5rwslXBgpaawiitw5h1TU8oMgN5Ms?=
 =?us-ascii?Q?OWflhVKGg5DH5vIpsGwvYxy3IYLlBwrB7VtgyqRQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9679b0af-c3cf-4deb-f15b-08daee560b0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:17:34.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvLic/2QDoLQPsN72hzD6LFNl44JBfnEJKN2uy9L9736lyBWwCGm7B3k1+rlLszg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:16PM +0800, Lu Baolu wrote:

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..4e35a9f94873 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2163,6 +2163,17 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +
> +	if (!ops->set_platform_dma_ops)
> +		return -EINVAL;
> +
> +	ops->set_platform_dma_ops(dev);
> +	return 0;
> +}
> +
>  static int __iommu_group_set_domain(struct iommu_group *group,
>  				    struct iommu_domain *new_domain)
>  {
> @@ -2177,10 +2188,14 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>  	 * platform specific behavior.
>  	 */
>  	if (!new_domain) {
> -		if (WARN_ON(!group->domain->ops->detach_dev))
> -			return -EINVAL;

This should still have the WARN_ON..

if (WARN_ON(!group->domain->ops->detach_dev && !dev_iommu_ops(dev)->set_platform_dma_ops)

Jason
