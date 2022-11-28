Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDE63AA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiK1OOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiK1OOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:14:32 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1EB1FF9A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4mnsA3/2GW1IBq2B0/mfoXNKQ3m7jJQMoQEcrA3hO+4tHvw5KpsdxyMqLJOUUBTaW0MUCitRABIWvuHy+svKdt6ukHid/hOutSqkbZVUOLEYEvoEZ6hotx8mqRc66xWwKQwGMI5MSyiGJj7l5hxrv/J0AeevI8yT1Q8etj4y7Z0sYgEFZrOQfl3HohaP83JqqJ2SE5AoKOSWiezEXd0/iRjFero9YHxxDWP/8/f3JA32Q4dE+78g7KuKsqM7/M6bTqhjdYaKoTYg2qTE8EQeeDds8CJ1ki1xNk9QbkvUmWstqDFO7XhoFzcm9QRgYmbg1LANsjkHaQOMmh/E5UJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aT8pfCmAcg3BW2LqT1JrwgC9EiLgLAHXmXjzq8fw3w=;
 b=h383UONWdgh0VhGt3k7mRHoilfnhNAV2TBtQndnvQYkvobv1cXs2Qcn2ptyS3C5fP37YKQPYcDRLYDHns4V6OThSJWD+3jgqsYdLQz7XgJBaUApqCKpbfjuppCfP71LF10tjUz6Vf6k5/UDZxy0rFWGc9bKecGsGNDwhcIeLMIloRp+8d3etNiR8YGk0bgDENxzT0ZZyJfFmLvTuD/XJ1bfi3WZa5i7Q4Bk1C24a6ubzZYD0K4kCRNmVsj8XmNxkYPCbv85iJT/g3RwBsphTe1cn0KY/km/3darC1e0EEYLNXInKiVKXVZW+sFZeSpeLtX04V1G4bkubRJQdyU5V5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aT8pfCmAcg3BW2LqT1JrwgC9EiLgLAHXmXjzq8fw3w=;
 b=gIOs7PZZOX5tfdSdVmki9PIMxvrlZK/L0AjfkIG5dxgnhipjWvr1Beoz5oCX9T+Fqxw+VphIHtvPTbhiHKfMK8RVDX1s6tPT1quivEew1Hd7CDCub77BetAzG9wueN2kA7YYeAt/xi8jj3uUQvRUZHQm7EDfetZIpYdSRx1sbn3CJxIVzZvM31T1i+9ktXYeVKtqUi4Ymyi8oSfZ7rsFf1bejrdEmgNylG6/PX5dMQjt6ig8lg45kCYRylYrSaGzwW0BPgsR8vspHPBneaBKD5MiyyPNaV+8bKE6KPsYfyvrU4P2abbwywYRMh95naK3aPK9tqGGDFyLIcTRplq8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 14:14:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 14:14:28 +0000
Date:   Mon, 28 Nov 2022 10:14:27 -0400
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
Subject: Re: [PATCH v3 11/20] iommu/fsl_pamu: Add set_platform_dma callback
Message-ID: <Y4TCQysTwDqTv/Cz@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-12-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:160::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd9b1d3-ee6d-43b6-52b7-08dad14adc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdXtZQnlPkDsqb22yAf6i7oNKP9M1eFxtdFInW7E5t3Jrw+oEgv2ojPYximatXks4zUWklmCVgID2znlsa46EW51+y3WVmgRKlsLAck2FgM4gCQCePCcugSCBXU+3cn8VrKAJFUlNv6aQVxRrQ4m25cz7K677J8+kOEeE4F0aMRF4pTEKvqD/wel8FKpugiMSgVbcvkz2bnJvQGnaorliDjIw/cAHZXtieuJmr73E0Nu5TOYUaFWebBFhOoOqnWYaSkdNkM8R7tNcmc15hZjwJugzmp1/N4Z2okDSH2aZfEMlddRQ+sV8+Xax6AWL+SKCosAam2pTPV90mr0Us/cHn198hNGWEYw99rJ/RoVURtV68AzX8NxBuYiw1D0dofhpOPp8YVhQeTTJeMSuWR37ymqnY0Y3vfOic6JuTk8yh1VrAOIOxmCZ/Z40ny5OgpxWg6IGMJjI1hcfPs45qZybfcPAV+CEm+r+vnrE6vGCoiY6Wjs5WuzALHFPFuT0KfGLErksUeW8iQm8WSk6QusmDwD0IIlRWq8ZeasoCoVObksM/Cxa1tBFcXZkpmNRGWBz34DRAFxSB3U7vp1S7gBjsSXNWeEMRNrGKIGdq+aFJPUh0mNvKOKSlP69ImE+xKxsoMOf1+Y08av5I2MCIHAQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(36756003)(2906002)(41300700001)(38100700002)(83380400001)(7416002)(86362001)(66946007)(66556008)(8676002)(316002)(54906003)(6486002)(6916009)(2616005)(478600001)(8936002)(66476007)(5660300002)(26005)(186003)(6512007)(6506007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/kbPHtBF878B6G/JpYJxe06NHdVU6zmHuXsKuaAWevE83FvmNJM7chFLxxe?=
 =?us-ascii?Q?PVarvLJT8x7SgxdHOpM6YB8FMhMC6mIpqrR/RJ8jgqtS47K68Yr5rKOAJDa7?=
 =?us-ascii?Q?L3JMb/F+lzNvHvBTMMoCrwAFZuJMnFeyT+Mm7UWG1SmIfM3Ra9eeIzMwqX1s?=
 =?us-ascii?Q?ipgfTD/HCHc0voujtEyUDShHyor5mXETt6HO0jhKgQ/Tv/i9VgmxyxHtZkiV?=
 =?us-ascii?Q?yRL+bVKP0qBDOj6cSHpdMjjGLBD3bBGisEwWFpbnsR/pDd2rIy0kovMvlwc+?=
 =?us-ascii?Q?Qr5L1Q8U+PYP4s1dH2Zk9OfmQwPoSWToq1hI8NrdTvtwjBtuk8WjwwbvwvP2?=
 =?us-ascii?Q?J6/w0DWRKKl2eVW9RZpmAyCYyf+Ze1/QPRM9BzOPT4em/hpMrcUsviUp1xYd?=
 =?us-ascii?Q?1MnHZOallj26GF3VbL34a/8sGG67QdpPGAKVBUZphYm7nOIcPCwsQdmsr5Tz?=
 =?us-ascii?Q?fvsPVcRognCIcV8tvkic7e7fOnbJk2zZiGeeo17JYG055B8+JrZP8PnpjJsI?=
 =?us-ascii?Q?BprM76+hkQzHSBTNcR2FV92FKvQnRD/53m9HW4zN8C5y2XpqSWWD05usTv61?=
 =?us-ascii?Q?Xx+wX4xY1ex305Kp2B8C8sICa/zMuTuLSPPyKIx0dM2vBR4cusjwMXSpZkYx?=
 =?us-ascii?Q?4UVGoaw+Do9ZDu1khjSEwxZk9izTNvWjxaXM/eBeXdKL+B6mEN8Yjrbn7AX7?=
 =?us-ascii?Q?OSO42F0o3UQqDkTzGRph56CGpxf2XoTdDp99orrh85bvWYE0V8nyeVxrvLGI?=
 =?us-ascii?Q?zqTdIE+SR9i2ZMxh1RKyW4uAJZHE6lgpdgjpgEBLoftG+McdYYTdizdWv2pF?=
 =?us-ascii?Q?5Z7enn7iMxvXS1u/sYXVRq6kos0Lfut7Y2zZUmGgHHbjJSJ6KqiiJkNrflm9?=
 =?us-ascii?Q?J3goZ4b5a2y75vEYX0doYaM1LtSZlg5+mI0ynZAZZjs85TSPCpkU/0pru29g?=
 =?us-ascii?Q?/LzeXKqgKBJVXCtzJpikPNX4QdvLtxMiLfmSVH84EXzNtGCdL43KFWOSwQWy?=
 =?us-ascii?Q?rfBKcPvxkHAX/Cexq85KZFLN8YADsddnMB/z9npnp+0e4mZ21OxxnmL5/kFm?=
 =?us-ascii?Q?R/DikXfJIqTrxakSH7dCVN81SFfKvJgAZrZvnj34LYcgHqKcY9KvkAJqB9Go?=
 =?us-ascii?Q?wyr8Ig7RxR4edch3f3CVLSoklGz76MlLSPHYfU3Bg5glHKEKffGyAA4CFXDX?=
 =?us-ascii?Q?MJVlTLFL8HSr17SAvpmOXgmB9lhvCUkyNTl4HYLf7lgrvVlA/LXh6Ic5u5y+?=
 =?us-ascii?Q?KgzVm9oVccF8Ac1ZOCPsvhRFNpuh+QBJ+1pk8C9Dq38Io9ZkYDULlo86Bty6?=
 =?us-ascii?Q?0Ebue9hrODyxRTYm9IF7BpsOfXsc9nhBeoKXIyhFWryC9i0FIGQcF5Qwg+mA?=
 =?us-ascii?Q?N3asQT+/1BWXn3TCgUAFgHwchBq7FrHF1YhwtFvy28/xTiMFbZTLvMH1km1o?=
 =?us-ascii?Q?d6rpjmOEJdm52Sq20sH487bleGZExdH9jWQRG51WVztr/GD/4l4e0s0axqho?=
 =?us-ascii?Q?9EUYe5A1JZ/9oumqBh3KwFZK910XNMms8WAgF73Z60wy0ae7ioeET5PQjskm?=
 =?us-ascii?Q?gBfQAEU4N3UDxih/JYY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd9b1d3-ee6d-43b6-52b7-08dad14adc51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:14:28.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trurtUyoaduePlfkTd5uste0ZLBiUxdIqZ4hljoaNHywK0pDMabG9401ijH36lat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:39PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma callback so that the IOMMU core could return the
> DMA control.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 4408ac3c49b6..b8c716e7c424 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -314,6 +314,14 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
>  		pr_debug("missing fsl,liodn property at %pOF\n", dev->of_node);
>  }
>  
> +static void fsl_pamu_set_platform_dma(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	if (domain)
> +		fsl_pamu_detach_device(domain, dev);
> +}

This is a bit ugly, it would be better to make the previous patch call
set_platform_dma if it is set instead of detach_dev and then these
patches should just rename the driver's fsl_pamu_detach_device to
fsl_pamu_set_platform_dma

Then the last patch just deletes the op and the core code

Jason
