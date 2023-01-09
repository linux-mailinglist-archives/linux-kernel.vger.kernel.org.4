Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4181F66254A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjAIMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjAIMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:17:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A911A19E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEczsKskiIj2Wp7t2MBGOnAF+bKr85vCA4Meesn1gWxb3aiMnZFhcbwn6gcbrmZxYnzXdpyUwC0hNhZZkYQcHGpdp0Q2yE/Ew3vTL7mQVvShAOrKnSwdpeXz43+XUqMinq9XSeir5TuwGBLAApUnJdxuaBCIiLhpkxN7+ORuO3sI1tCK5qddOEymzVHiFi/IeBHaDTNjC9YVLmJr/89EKuCrWa9nisGRxLWanhQJslgGbbWDax6YXIKpSnhxxNZHv+Qd+am8sV0qB4eGv2cC6KwOYW8TabxcqiyDUitBm6/yYmeOjeOYv5v5cGl5rqyGyYiW1d32RaNDFO2xq2xaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FJopymV9+TDoVSTx6Fhd290GwGZVjnwROcgIe/Vl00=;
 b=nY84wua5QOl4Mr1oOm9HkozC+baoxU6UYamokti/JLYrzO5IvYLyL5nPkAeazsQNag+lsKjM2275FZMQycE0ZPzlLH97nhdPA1r6EzPpEmqWrQaZ4qb53dHsPgKknU2OYuvStGm280aRwMXqtIJ0esxvjRCkUfdOx/mwoEcCbsfm5fCAM4zy+egqq08Ax4p256wVeHTji/BAe8ICCf/ed5cSggotrbyGoY4ZjZsYPwV0sz7y0EwospbIJWnRWPbasQ3s/MqTWr2fxjQUYrT++l0d6XXpbK3YZgLmx0pl0okjZVtFzd1LC408v6PwmObryG4YjU/KiSafLcu153NVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FJopymV9+TDoVSTx6Fhd290GwGZVjnwROcgIe/Vl00=;
 b=Qv1JDU2Mq/5tFhxj7u1gIzKxHxRLIznAD3/K0wSpzbmZWS8jUmUufmFAIfkVKYlAaxlLH244qXR0EccJNtSFzbyQ+AuwYhTtEF+ZSdwv1tFgJ5D+S1Apq+SOG2Hv23cTWtCtyMR0XvowYAGEgLpHQwM6MRFGuWY+FqVkoUzq3PY+ubklj0KZwEsyNZDg56Rd5lSSPQrp+L3nhozwMLVStCl1Y9m4Szc+NO2f+5bW8CVm/iQZ9LtxyAMw//8BH7E46JilmkPAjZ8rIe7BbhJRWyteHWkS1d+fIJrfGYDRutRXz055hVS0z50gVgJvueCcEH+HZRo42wDvw9lADAZJnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 12:17:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 12:17:08 +0000
Date:   Mon, 9 Jan 2023 08:17:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <Y7wFw27mjDrztWYp@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
 <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
 <Y7bNidP/px0NmvR+@nvidia.com>
 <0f6426c9-71bb-826a-78f0-bc8851b6468e@linux.intel.com>
 <Y7gveMpxJWmpYkk2@nvidia.com>
 <5ce5a6a4-9397-9665-7352-862d89b3f228@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce5a6a4-9397-9665-7352-862d89b3f228@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:208:32a::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: ea719149-291e-4ebd-5216-08daf23b6da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFUy7noPIGk3fINXsqRLGlW48qS5DSdH5fuyBdbjRYQaT/zJobWHYa2mIUeVSeFowGOwdz+XvD62C3uWIG393GCJc04tju0bAHRSbhZtg20leK0+SpUmS3UTHS7w9BnP5EEp9NKtJVIBdvUfs1tE/EMFBpqC3GACQjZenLk5/yah9qHsPXzkQ+Xh/o0MFGTAlbJvWMRTMFEv0BZwm20qmlzs/jClH1FPejGhjaP7vbuGFAFhAkIcSGBnYfj3zh2oZ/wrPzMaufUC0J5jdRd2DgIJuOZYuOxcsZXmvLZNyZSViy9BPY3xFBzG6Og1pjQYZ/0fc3hkczmAyV9bEqUPUcpoETTNUkhWB9dnncY6T5K7KlMSIm1q341gLnX0hF9P/sn0v8v4XhJpKIEyQgR/pOiIoVupSUjY4Td56eXCQs2AmFUjg1Uk4pJ1RW0zwyn+LCm9togRe9WHWYqGRBK99bF6i/CvvaF53URR9nT3efMXCAKECZk0Q6YOmeKS7o1iVHkJXawuO8IbNcWTrGO9DmlJ6rc1okmnr+MVsdMksItbXciwOUJi/cwOtytlObHAB4jl4gEBHeKgkOUB3xrRTi5pQ/CmUzD15WR4/cDf4MHk/q0mA7rFl7uAlw52yWL3RWfbbIibZMtTCSN3q79TgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39850400004)(376002)(451199015)(36756003)(8936002)(5660300002)(2906002)(7416002)(41300700001)(316002)(4326008)(66556008)(66476007)(66946007)(8676002)(6916009)(54906003)(186003)(6512007)(38100700002)(26005)(2616005)(83380400001)(86362001)(478600001)(6506007)(53546011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WM5UVQkJj/ZImt7Xb+7hwRFyz8l2WSrpXrzaTlFSnMtBQR8BKuGnojz9ydXY?=
 =?us-ascii?Q?f0vbNErt17FhQNevfRXnmZIOeSaim50cpbVco5pLVQh9nSlnwjqVMnZgO1UB?=
 =?us-ascii?Q?OUEmi00uV8LuIkoqkWXRfDISrznejRdoKO3kcr7zcorV4HFX9VyUF1fkm/hc?=
 =?us-ascii?Q?vHyyvVA52j+XJVl2wutWOd+TnxJyL+KCbcKTLl4EQFPGOLmP/lbrPS8H317a?=
 =?us-ascii?Q?2FmaQC+3hDgsLgh7yg7pNxJeOHONnlPFiVraSqxF8SZ6gXD+wynAwfKFw9XT?=
 =?us-ascii?Q?fimCU58xv9cI/CHHZ/dIt7PTcLmrU8ovQbalR2i1u1aRO/9swanCG+fs6PWx?=
 =?us-ascii?Q?V+bxDh96biqqzLucLTsFqN0EsOP6h/SsnWb8LqofBee1vrYItC96ijG8Rt9O?=
 =?us-ascii?Q?LpIMPOxjiZZkjUrcqQ60djKAgO+KIkl8fjgpQnoESvwOZJDbTsaQCZNk0iZq?=
 =?us-ascii?Q?Olk8FoyRMGbEBuElt/2qljGJC68+SrBmFwE0GyJOwtg7Dvzk5bKQztQ4LgGV?=
 =?us-ascii?Q?IAPCz4CPHBYI9hP9/8wR5Y1PqCmsTkC3Aw5lHHPnm0/qU3BHzY9uZPwA98lE?=
 =?us-ascii?Q?1cOqpB1A0wN2HELVETMABmNpM6BHYMjqvcNWicWATONU90uJiyRtI7ggkPYB?=
 =?us-ascii?Q?1VoL3ijL0m9iX+/QLpYg/78CNLVnWHX13P7AwyaGpPYA+hi7Y53tcIeH3cd5?=
 =?us-ascii?Q?RAMn6oKMt68kL9dSH3JqtvuPPCD1XepGF62ZuyWwIucAgiYYkX3GsquabpHT?=
 =?us-ascii?Q?E0hjVZWBISoeNLPyPLQ05DhkZ9LW1dTBH0cz/5t73j1Avk0yOPdSkaGGp3WU?=
 =?us-ascii?Q?O6Z0zNkJWq20lDnbAz3JfM5xB02Bef+YnrvoHqquejVL9z006WBHDZ+fHGln?=
 =?us-ascii?Q?wd9FVFNUTd7xFHDmBHFrGMAMnHok8SUZ7Vs6BzlY+KEBocKOM+PqhyEhBbbw?=
 =?us-ascii?Q?85zT0wDyiLG66MnPO5wIpB4xGX5wSwD0erThhXkOQAWpokhQhLRl7LWN49NE?=
 =?us-ascii?Q?Gwj7Nvt/Qz93T9s7XMeE/CkfPpQN/xF4xe1wctQ3AVeoW3EUOz18b8mqFNOS?=
 =?us-ascii?Q?Pd0v49n0gCmyhFbqo1HczigespMfwBmebSru1sgYLMH8d2jMcq5ro8jiel1Q?=
 =?us-ascii?Q?3OsZBz559juDfUQNJ6ThD/DjagzROQEyHf2mbYM9xEYLSV69X2br4WMByLL7?=
 =?us-ascii?Q?3Qdgfb0Nbxhz4eBOL8haOsNYEUY4OibeUD6bhXIPE3g3wOCjXmJDD0YyOFxk?=
 =?us-ascii?Q?TB3U4ksWgNO7HR8ywhnLEZTbpsU6JgWxGpKj0m5Ag25eoyK2rA++NWpBW9jr?=
 =?us-ascii?Q?Fo9b576fdg2Qv4sqNc71Iz/o6BihUnWNJZK/HrcNLeS/SkRwtw/+F2trm1ws?=
 =?us-ascii?Q?G3CRm43f7liGm+dxOAYVfLCQ+7TGfAayx+QSE9Rg98V1z+upajqXBesTYoB1?=
 =?us-ascii?Q?ndOgubScegvWG0NRfpN3GfKE6CUfTVoAAxaJ5TsrW7RqRMxtFn9TxFzbW22M?=
 =?us-ascii?Q?ZHGOeNDe+oyvg4I9wSKOOESUNpd1xLsRTv8zmpHXvF9A0FB8QzH6Eb6qJswW?=
 =?us-ascii?Q?yH/or0tZkfiSaGtaUfE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea719149-291e-4ebd-5216-08daf23b6da3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 12:17:08.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7WmVckc6WjPEK94KxNXf0n04bZsBMqKNacQJqHdT6vz9B/drR/czbd+vT+ii1Yc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 10:48:31AM +0800, Baolu Lu wrote:
> On 1/6/2023 10:26 PM, Jason Gunthorpe wrote:
> > On Fri, Jan 06, 2023 at 02:07:32PM +0800, Baolu Lu wrote:
> > 
> > > Above looks good to me. Thanks! I have updated this part of code like
> > > below:
> > > 
> > > @@ -2177,10 +2188,20 @@ static int __iommu_group_set_domain(struct
> > > iommu_group *group,
> > >           * platform specific behavior.
> > >           */
> > >          if (!new_domain) {
> > > -               if (WARN_ON(!group->domain->ops->detach_dev))
> > > -                       return -EINVAL;
> > > -               __iommu_group_for_each_dev(group, group->domain,
> > > -                                          iommu_group_do_detach_device);
> > > +               struct group_device *grp_dev;
> > > +
> > > +               grp_dev = list_first_entry(&group->devices,
> > > +                                          struct group_device, list);
> > It seems OK - I hope we naturally can't ever get in a situation where
> > a group has disjoint iommu drivers.
> 
> The final code after cleanup looks like below. We will WARN_ON the lack
> of callback in the iommu_group_do_set_platform_dma() helper.

Yeah OK

Jason
