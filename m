Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C966C921
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjAPQqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjAPQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:45:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512571CAD3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMtXLrJIdvNgERhDjQajBU2k6AcAI1FNa+E5JVadYVOiW09NpZgeF1WFJ58b86GdDJwG1gnwCfvNvPc5h+FSWFCEx/lnwofA+J6hny/ISXPkU4MIh3r+ZHDDqfrjNPfcWnHjUeHsoC0IZFBisn2EmpuqzmsckefqD91nP5wWuiDUkpoosTQsATvBSIejHc6PYaYlpXDO25XesSv+ol87Yb6rcg+aIaRE8KWLiE1QpAkqv8mRvvnGnvdhETYH150SG8oUjIwO051qj2hYvAtpK6al/hq59lmTSg3oqheSA+zVikGh4SwU6f5O8L+Ui8M+SyMNfvr1KOgLvQYMCgqneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrPj7KElq32ykFQKhcA5b+LFDpEfcg0w9/9gvZ9fA/k=;
 b=D5DTu5QCN0dgH988/1O7IB1fWdDE7Pgo55oVglAzRA6A/kLM6mEZz8uHjwnu2EHo6YRVZyVrJqFpivF3/k1dSQ+vHA8vghyCRFxbu9KLshJO9XG2aLqxLWXfH5D27Jv9uVBa0ucv0jrB2z+bh4U4NYnNsn9bXLAFQIqr5m5AgOHe8d2578LDWSP6OJZa15OKUG48TT3429wuqVLxykSZzh6butZNkWTqXADOMXD6uNN9JwGZWIuoJm9szCjPG/clSDeKOIEjJmaZ2g8TJlYY4OnIFfZOnB3AeuihAOW8fgtwakpqNwGhDfslSrBv8/bBHWdxxelhOi6GxpXmk4koAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrPj7KElq32ykFQKhcA5b+LFDpEfcg0w9/9gvZ9fA/k=;
 b=MZvQQkZ5ahXDZgK3wPt80Tm4YJux6lAvFBgriowRhbxVcpNHnFWdsEHeP9NbVk9gkaxU3MJzrOq4N6sJK2znUOf0XDVkPylqUd9dXk62xsBOW1sFD8vcF5ibVhYu3TcGTdhqj5R4v/OKDQa0ketmcg8+keXjKBGwxaAoXk6d3vQ8+iWFapD2/2Q9IwZECX7006IMDMyrbCmHlPE+9Cd7PpYRYsq3ZI2HCFrcq8rEPrnmwaGZaFAwgxCiF/NHeImOeP9PBHDyZ5wMCSrYY+nLcmrb+zg3ZBOegR7MS5T9OtptDENTCf23fb6d3KuYlFCso4bLhBA+rSYY5v0TvEHF9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 16:33:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 16:33:46 +0000
Date:   Mon, 16 Jan 2023 12:33:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
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
Subject: Re: [PATCH v5 0/5] iommu: Retire detach_dev callback
Message-ID: <Y8V8aOaFb2BWx47j@nvidia.com>
References: <CGME20230110030211eucas1p10834ec4cc8c227e2cd7051dc85026dbb@eucas1p1.samsung.com>
 <20230110025408.667767-1-baolu.lu@linux.intel.com>
 <b756e833-71c5-e43a-b222-ab9bdcc4f494@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b756e833-71c5-e43a-b222-ab9bdcc4f494@samsung.com>
X-ClientProxiedBy: MN2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:208:178::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: f503e590-bd78-46fb-4e42-08daf7df702e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1g1cnLl5PWgZlzJNVnmw1Cx1E0QnM2xEPhVGQTts1ZvR672oQ5IcvLXXM2Uipm+nEPjgwhQAKR/ZOJ1+Oj/3/AFH73fNq//Czw6IG6PWTCQneGVipDwn/IZEY1ts10suOd97+jUIPipZXKpsg1pad3IBtqMMQvxvHjiRMom1XKtJQMnArKdk7XMX8L7W7ywfumgHCQ2bn55EYvUy/eTGhnHB/DBtLIY0KW2kNgxRZ6gmMjt3AoiQ37mkHHCtGCz3Iw8o1n8RSdj9RFuvFstS1HEc484SpD8U9NDVF6LsoDwksrxUT6l+3yZy58dU9N8SCI+uMJx7lUdqvfVdWS0PKMCFH5x25Lui8YgqzFdCcioaVAvgP2EeuypuivZJk7iYFlw4rQKwdA3r5kx4Nxz2nnFeazGDir+Fog7U69jSUkG442ZvTxj77g5E/oCaxzGkiXD5g/JAkEXdAMD1aEouQ0g9U80da7310RDwE9HNYYbPfz7cyDYc+gjzN92x/6xuv4U7Y40YIcK6leLj4ED5LjvEAY+3Nt7YBgayV7B+epJufFn89+k0cP6lQm7RaKjb5DER/39rEtoIQpyym2WzNf7fu+jHfenLffqnimUzwg8wuMncfi2SGbLjIChcOJKaz90WcfPEPCam/lEMYZAvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(84040400005)(451199015)(83380400001)(86362001)(8676002)(38100700002)(5660300002)(7416002)(2906002)(8936002)(6916009)(66476007)(66946007)(66556008)(4326008)(41300700001)(6512007)(186003)(6506007)(26005)(2616005)(54906003)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IC5k/Nm5tFOlE5nMg2mQcrNXM2S+9PwXPo4ztsIB8XNCLMLNfXXGJqWTSugr?=
 =?us-ascii?Q?MsSRhz6OEPWxcVpXgRst8VDgmngh3kwJPS+epeTOZ4VkwKL3XAD8VRvlm509?=
 =?us-ascii?Q?uT617pazZbB/IJYLU1ISQMy+HvnnHZGIjC7OVnz6/XgA4okgHCDdEHQSahR6?=
 =?us-ascii?Q?lZCfa09Qa86eVcPesEfL/gh7HRWoSK4z+QuieYUCeaf+V5GMNzcoaNia+hri?=
 =?us-ascii?Q?1qjohYmfJ/c1y98DAy0XYo+re8uqRplr3hjroQobCO4EJADHSFLq5JoJ8xso?=
 =?us-ascii?Q?KfOtXqnLkJ5S7uyHNCs2+GVd3X6KYsrFinjobHxXZmSXhDxHHqWBY8w+Dptz?=
 =?us-ascii?Q?aWW30UqZSA83clSNw4EAHIahnHLnh1UZv1LxM3mZFVk3Ra9WaVloZMwLR3zM?=
 =?us-ascii?Q?X8yQT98vdG50pEBXryHEUOSwNKxUOVZvI55qQt0rci88F6tA9EFPIK6zyyOl?=
 =?us-ascii?Q?3MTqiMR+v8qNV4Srmp+cLy46frSzk8npP61pHdhPI+Xugv8JVIpS5cG6H54Z?=
 =?us-ascii?Q?ma6k6ofYRuWbxMvm/8MVPE2+xf6NsCDPAKtXU1ZndSAfVyuf067cFiQvuzc6?=
 =?us-ascii?Q?hxZPfgfyZIzEhKhJi11UxpwopZ3Smyf5A1dFLAP8CFGVYoez4b5baA72pZY0?=
 =?us-ascii?Q?4/G0eH14smUVBSLQe58cVTRTfEdY5nKRgl/bYFzqBqZjG5OShgC4zEYK9HF4?=
 =?us-ascii?Q?ory4UZq0kfWGhKAQOjXY9/hLJcAwiMbrdCb2M8KCi5JKgntAYUXGNAkSRU2d?=
 =?us-ascii?Q?mqSnc7VdwrSxhh5I3L1xNG8EY7cSikOL9VaeVYMEZI6DhpF4ePkgnJJwCl3C?=
 =?us-ascii?Q?EWo2/iZ4Lt//jSYWPU4ujsYOaztJLYsBjj3A+vY13Od4ja7ZZGiDdFc/YQm7?=
 =?us-ascii?Q?7xZrBpKe363APgDogNsnVkbUzQ4fpaXGO7bttGBWT572tbaOI1ZKGDjQOKwy?=
 =?us-ascii?Q?a3ETNR1Iq/FA0lKDahXMaYbKr9WB7iX/sMTGs6R+J/epZ1LtK1xFijERgdo7?=
 =?us-ascii?Q?P8Gf5t8VFHmICN5a0vWQuzxYuTyugJMihG5wUsxB8Q6iL/P9nX96hm9zHl6C?=
 =?us-ascii?Q?pCDiAFdNUQC7dRxrow9QfXKjNZj/pfWrsTQcd15RIPRSzKqqctw6bFM3glbx?=
 =?us-ascii?Q?Ge+mnLl0maPo4R7kLy/jxuuF6d0aUpYeRqwhmDvDnpXAT7d253RPJYIqfVJY?=
 =?us-ascii?Q?SqTd7HPsqcO6oXn6Tk7MM89Z2EdOCsA1IXRwmQqZ7BoXbLdwAu7MEjYcDNRj?=
 =?us-ascii?Q?EbgkJ+LRjwFSYj37HILEM8u9Rox9aog7Lo4ug40PyXv6f4axaBNur+rNGPlY?=
 =?us-ascii?Q?I220pRnk2pPNfG7BsYCsp70JP2NGeabuFOkngQgkORtSlqEPnXsNKBZvDZoB?=
 =?us-ascii?Q?4pwTE6JpdbOTFnCDYD/FrxvqdvcvDGwPQS5Rulu+9toQJnK/LgHv6Jh6J6No?=
 =?us-ascii?Q?5Cx9a91s8xlocvxkVqwdbEqYQ4ZI18dG3OsnXstTdxY75y7p+fNdTGJCrRzc?=
 =?us-ascii?Q?QNopznhe0Bv/PiLiS+rTQHmzGopfM2h2wGFB++bdsltrG9uADNtSwoUif90y?=
 =?us-ascii?Q?rXfUnPiT56Bjuexgtp0P33A/CHxM6dgsbltMdIAR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f503e590-bd78-46fb-4e42-08daf7df702e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 16:33:45.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkipyX3cRk6xeeV6eJCRrCu8xMh2UuJfR4jvS9l+Rjlh3WIa8QzRh7iQErVwcog3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 05:24:56PM +0100, Marek Szyprowski wrote:

> > The iommu core calls the driver's detach_dev domain op callback only when
> > a device is finished assigning to user space and
> > iommu_group_release_dma_owner() is called to return the device to the
> > kernel, where iommu core wants to set the default domain to the device but
> > the driver didn't provide one. The code looks like:
> >
> >          /*
> >           * New drivers should support default domains and so the detach_dev() op
> >           * will never be called. Otherwise the NULL domain represents some
> >           * platform specific behavior.
> >           */
> >          if (!new_domain) {
> >                  if (WARN_ON(!group->domain->ops->detach_dev))
> >                          return -EINVAL;
> >                  __iommu_group_for_each_dev(group, group->domain,
> >                                             iommu_group_do_detach_device);
> >                  group->domain = NULL;
> >                  return 0;
> >          }
> >
> > In other words, if the iommu driver provides default domains, the
> > .detach_dev callback will never be called; Otherwise, the .detach_dev
> > callback is actually called to return control back to the platform DMA
> > ops, other than detaching the domain from device.
> >
> > This series cleanups this by:
> >
> > - If the IOMMU driver provides default domains, remove .detach_dev
> >    callback.
> > - Adds a new set_platform_dma iommu op. Any IOMMU driver that doesn't
> >    provide default domain should implement set_platform_dma callback
> >    instead.
> > - Retire .detach_dev callback.
> >
> > This series originates from various discussion in the community. Thanks
> > to Jason, Robin and all others for their ideas.
> 
> I wonder how to handle the ARM 32bit case, which doesn't use the default 
> domain solution. Today, once this patchset has been merged to 
> linux-next, I've noticed that it broke booting of ARM 32bit Exynos based 
> boards.

It is supposed to work, can you help debug what went wrong?

Jason
