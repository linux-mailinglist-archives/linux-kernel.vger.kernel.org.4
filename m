Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72481660214
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjAFO0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjAFO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:26:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A913DC7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:26:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbdmquM2+EIwrb9r7xnGf2xDp+zgCcJrKyeDY9gK7XumOSdMeSG9qwXSwOPnDIJ9Fw2YcE+dDVIKIMS+NqxRDrj2zRlabqReg03Sb6t3rAX37l/ydLbqapOdD1SIvVt2Tz/6AVqZl2OKTwtY/ZCLVjDPJ15hP7NyZQC+MmlEwkF3McmNLGrKn2M1dvTwOhYO53z0r/eXwqpaoMSRgQyevT3azGOwRf92pWI9K5F5G4Sbu/m7zbvhHZF5TsSf+DoZM8rjD0/rnj47Ka+SiHWW1BVzGfpwnWcOW8pf5MZrU1hGIWhbEELHN9V1AfzzN/4DcFYKUTUIPeYzCeYslwpGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTIB/quOdVahZxCizZ54FpmdmMYp9q40BWgzW29AXfA=;
 b=Ato9iOw8R5VZr9xqO6VrnbeAFfA5X4p+Cr5prcMb0YQkWOI1efTCNoSrxJ7nkWFcN7v2iCfZacGTg6dpqKXLzMsc6evsGrhMtRmgp9QL3BTQkab0acTzaF3ICaWBCdHYdn0G2l2jCy5S8/4A6DsLf/4dhsxaMKmmvAPNYR47CAy3GTESH0Wzkrz0QZ0itd/h0Z6yNPl88JxHSI49o+k7NqoJYGVcIjGjzaESzgeMOAWXY+S57xfz984c9NPDB1e95pT20wZP0T5VPn1E3uoxAPQIVTW4xc0zBTUpCbT8524iiNUcB5d8U1R3e70/g4iCPUpjSyAJDqOYcCCIHx4HkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTIB/quOdVahZxCizZ54FpmdmMYp9q40BWgzW29AXfA=;
 b=PdlBwTSCRyxGmb5v6D46iGlAh2Xaun9bXCrUIWm5kybvWD5k8QClS47wgakAyBgJ+SiTY6V9gVDR3JkVjec+R+oW9KDsYzE7fTGmLKTtTQNNbG/OIJlxxQD0MDp1cK3klsT21hvLWImpckR62sQs0wFaMzmnlPt8sc0ByQsQ5ceZrqZBKKFF7H9KxiKWLyKsl/K1vTVGqydMQh+acCtUAOGvyDIIpMiDXK39MScPqzPVXO/xTkJzQtTEpbj6g78/YOQqMJ7OyrAsjuyfNVr8ui9rTiSj+G/3q8YxsRhkuojS0q7LtPJB3tH1lu49kSmIXCWmkEiNnvVEUyD1IWAqnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 14:26:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 14:26:01 +0000
Date:   Fri, 6 Jan 2023 10:26:00 -0400
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
Message-ID: <Y7gveMpxJWmpYkk2@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
 <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
 <Y7bNidP/px0NmvR+@nvidia.com>
 <0f6426c9-71bb-826a-78f0-bc8851b6468e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6426c9-71bb-826a-78f0-bc8851b6468e@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 512104f2-db62-41bb-ae86-08daeff1ef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XdnoekoV4bfK2vlf+nWt9K2Q0Q97HiSJKLTxlVPfDPbM8qAV/8eoCu0UacOoCO06jK8ZTU++eLHa0jd4eqX3qBlRVz2RbjQhln2LF2ZulliyowQXL7Asok/YJaEehHPR16zFFq+4eIr5kTeI/qa5mdZGaYVRadqG61FNfh/z0nuwgPf0Zn4+PF4bapuUWEuL2UlkmnI6gjlTI1Ouvc0h41/JF7S/EqS4AP1jBd4sn+0nI8FR5v9EOmKnzdTl/PID8D0s+DA1k7Txi+OPEf0J7X9oEsR5EYMKXlI9lbQSTjGjRbBDr3E25yTjpwQzgcuvR60dBdgTHpunTU+Vbm3Pk2peBjX/OcGxcP4ZoY7/BoOmK/bdxNExI3RBtQom0NpoHtc2gjOEHGg35LSzU4+MGH+WdpTWuU/6p77Q2qmmDhFiomxJOiHYwXsGw0uWJ9uR4JcaINcljkgfCNUi5gSJqTD+QI51NGGOIzUFl89C8rOwG1uCxf1/9Md2q4O2hes0TFZcFZ1L+O98hEwrc5OsvanvPh/QSQDX5nFJ+VKuTKlVqQaHeJebS+hfAeiHqNPGlDmZTAryhcpBrCOqdoQOt7H6aGGSL8EimdzhLeMiHHA9UufwLDZpbGjh4pb3EQx9K1X8V1huSbgjYxkiDVEwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(36756003)(41300700001)(66946007)(66476007)(6916009)(4326008)(86362001)(8676002)(54906003)(66556008)(8936002)(38100700002)(2616005)(26005)(6512007)(6486002)(478600001)(6506007)(5660300002)(316002)(83380400001)(7416002)(2906002)(186003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DhPBYgQXKsbg3CLfzuYUWs5mAwZkqpZAFDT+HPrUJTDG1iwy8So5gEF2FnhE?=
 =?us-ascii?Q?o/ekgzlJgCEgbHbVRdJqZQg2OrSaIxsBrAwFyWCiIyJTKzOLF6GEaCXHvwaq?=
 =?us-ascii?Q?3GOsGcpaUNNXnSFqWLKaG+Wq8UWUWHT82PezuDqQe7CMODfBzfvAth3uvRk7?=
 =?us-ascii?Q?kVtTmR7YzfGaxSbvobT6XF1TPP+tFO9478hCqjSSfm7IWJwUgc22WBHXuYFR?=
 =?us-ascii?Q?x8V7IglsUzG/DfQ9JkESXC5H0e/2ayc7w/HzLBrFvUMMR+8LEq9ZIfoPf+0H?=
 =?us-ascii?Q?dj0z5b8qA7kdTw6W+eNms4qYB2Hdb6hZFlsxRT9v1orhYiSyc+4ikL1pFoTi?=
 =?us-ascii?Q?c2qRy0eFRfFoShw2bK/+f4VH9ufCrAz+whyQCKR8fazOQkB5W5tTxHXEFA2W?=
 =?us-ascii?Q?y3sEX7CNSk/ZFAi2ByYVLA2b8/efjc1zoHd9vvmwCaeqoqfl/SMKmBUDF0Ib?=
 =?us-ascii?Q?W5pqDuIe3kFNGpRDIg4aKx0wc2uF6risySYUHtk4SeIfFEJJIFZVTm5CRJEt?=
 =?us-ascii?Q?ZJaoZYQzm7HbpyP8BB38rpCJLYgidfAihXM97q8848fgDbNsLU3tRtu37Ag1?=
 =?us-ascii?Q?/y7No7lLZmp5k91XLqdaQef20ESIYRG4TCuA0aOVR1ygGOSa1bImHojiG8BZ?=
 =?us-ascii?Q?sgtBmPoKmwPVreDCQ3l37z20C2zUGmXASNQsY9oG7dfDg/t9heq3eYJUxdbj?=
 =?us-ascii?Q?IbSMD05eea/xtrOx6PwgaUvRTLODLGJz9sRhwZbUZJiiRZFWa7hzlrqOQv2T?=
 =?us-ascii?Q?UrWpdWJE6uVoSiWu5tu0gMw6q6FnH21I0HxnMykxg8IM6SzvFrJIuI6AWicR?=
 =?us-ascii?Q?cd6KLGL2fX1Mi762OxR6MkKOhFTbpbhEZ7NGrPEsNOm3MxnrMI2NAhnVXIZf?=
 =?us-ascii?Q?e7itHTqUcJ6+e2XZq7akdQ10E57Yh5aUsE9wK8G0y6ivXLx6hUq/dNJrsi+K?=
 =?us-ascii?Q?s5CiAGfAhsRUCiE3zebg4LcnEuAqajS43N8dqHQumqCCeaGJwqpn4jBjZ/lL?=
 =?us-ascii?Q?zDskzmS2uF7Izf6oLGB+s+NBozNUHNnVUl0LihLztgSKNRGQl8U/8VCFcla/?=
 =?us-ascii?Q?TQIYBwdllI8i1C+yrx4WNeD6GRLZkwbInK1rEJVWqfFks+E5Gv10lSY0mbmX?=
 =?us-ascii?Q?ypx/cVQ69+XwrJyquwC6C+iPGFbTb2y8OpuEPapUK+vjDJIcJqvmqBG5ZK9s?=
 =?us-ascii?Q?47o0oRFl45Q1L10V/e7LyoggVoTN9FLJjKELhI/KH3bfxiQ2tYtLzmiU/1VE?=
 =?us-ascii?Q?SS+eulXRqyE+GoL2c21uBnGtqzw9MmqTX0PoAlWq53ydP5MlKaasawbZryDJ?=
 =?us-ascii?Q?Ki3sGTQMt4tOWXp+H/V8VQsmPWYS1aw6sizpszsz79GnjqQapO9Plt4Q9hwW?=
 =?us-ascii?Q?aDn0r/2tHq3AMIfzHtQtGdf8hzP9/dw/1/boSMouGaOtGmLDLeMqYcvCbscH?=
 =?us-ascii?Q?o4akbMuD07zZ5UaRoC8majvzrP8Vq1XtXHbHStCAq9SRJhdKNFJvsnRXvKvt?=
 =?us-ascii?Q?eE1xgExQ7YPizYCNV+sYlrrmml1qqLyOmiO0bapmeBlUwaPNdXreoxH1Y+wi?=
 =?us-ascii?Q?vBWwmvlOUUElrcsmLmwThUr+Kf3mLQ8/AIlF1wKl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512104f2-db62-41bb-ae86-08daeff1ef8b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 14:26:01.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0gMTsd/cDAvyiYcHv9BRZbeF+7RPTaGbYfLPAN53Wi184apu/1Lbf8fB8JParoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:07:32PM +0800, Baolu Lu wrote:

> Above looks good to me. Thanks! I have updated this part of code like
> below:
> 
> @@ -2177,10 +2188,20 @@ static int __iommu_group_set_domain(struct
> iommu_group *group,
>          * platform specific behavior.
>          */
>         if (!new_domain) {
> -               if (WARN_ON(!group->domain->ops->detach_dev))
> -                       return -EINVAL;
> -               __iommu_group_for_each_dev(group, group->domain,
> -                                          iommu_group_do_detach_device);
> +               struct group_device *grp_dev;
> +
> +               grp_dev = list_first_entry(&group->devices,
> +                                          struct group_device, list);

It seems OK - I hope we naturally can't ever get in a situation where
a group has disjoint iommu drivers.

Jason
