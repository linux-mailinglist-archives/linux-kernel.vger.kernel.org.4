Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44369A2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBPX6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjBPX6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:58:49 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE1F58285
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeiZIXRMjaoiUVk8GYg4xU7WyRHh0j0AHkn1Iw8C93aCkthLso9krEUsqKQ2aPeeGg7TxknCGNNV37Ri9qR7Jvil3Ek9+LYPMvaJ+Hgs6BcTMarUJajBYdhQi4hmyZ8qEw/qbKLvXxaawynZW9SDakkdJwyMXWA0d2kGwiL9NJ/0/XZaxAE14LW+CIG16vmPwe77nAR3SLgXctjlmElTq8tWnJr+Uq6bdjpeW2vki0mA25COP8WdzgcU/wC6rNXEni0P1F3De6JY2IfM5wLEZRkXNfJwOe3qCozleKQD+uanEplANJmNi9rOX1+pk3fZa95dQWSFT6lw/S93afaubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfB9SgNmbUZ8H2mkBm6GWKUxLRrgC8cUTiLeWBNp/is=;
 b=KO2KhG5uWufU+SipsZlR+jTFpBv+Lzi2WqtZHo/ezFOXhfK/X0xtcgbmucStvS3U+oWXGamzD527y0SSDA2BCOe5V8ZCCi1YqSV6OHNaicgS7B4uIysnRAxJ2w0RRJ6LQqP6GnI7dfuv+mPc1tdFkA7wPI9bKTtrhqrzgn4IoZO+xvEa37Iie7GkwcLs4zGslH/Zs71lRHH5/KopQnSGKB+yn16PAeXUi2AB9Q25owRJYPXu27YeAdZ9RnQcX+MiAIbBUtfpiJxl1RbAN8UhZ0cEoJo6hmzMOFU5fLzLE3HR1X6cQOto1dRub2Lo3H6y4kRWCRo2XhcvaaOw12rUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfB9SgNmbUZ8H2mkBm6GWKUxLRrgC8cUTiLeWBNp/is=;
 b=hfabKD1qJwlnrnLM4pVqeFisVKyoyHcInJY8TdapsN0uBNZAvsfLp+vFNc2yP9/xajXwRPe2KwHel/8/8Qgw4cv3BURbQK4jXgzWxxjbXXDFrropaowcbajKJn5rFlhthi3tSufkaIdOWfqapOwRCVA/HMP1BFsCo7Fmfo2DZm706KaLtdYl7F7fGpw0u0ECdkcoWaI5ikKWyTxOa8qjfAsnrVtBSxzP0emnm+B93L7FnXTVq3TuIOgyJhAQ4RmXULDBljJymMC7EvebgiA7xHQ4Dy0jATg0H/RWY2xPrqiK3TuObJhzzqnxbI+wDSbrzLZv2jSgvCRS5+uGSbfGpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 23:58:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 23:58:36 +0000
Date:   Thu, 16 Feb 2023 19:58:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 2/5] iommu/sva: Move PASID helpers to sva code
Message-ID: <Y+7DJXWKI+qh1bg4@nvidia.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
 <20230216235951.3573059-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216235951.3573059-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:208:32d::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 46563c6b-9b5c-46ab-cfd5-08db1079b7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvFqs9R0l0vSPqcB5sfJmntkEkcEIhbGeCyW5dsllm3Hie2BHtzJVcg2aDIFz3EoGBhgA9spWWt6VUHK2scOlP7XOyYR59rWZDyEKjID9xHs6cmaCIXwprVTBBaXlCLJEyBJYwW5jqaLW7cVtK5rZj3HKZaPel+4FuOIUTj5MazeXRR+r0Kbl19Jp8idQwq1ExQUeE1KOryTMilNdilunudFKpp6ATpxo9qeG/g498BAfs5zDAoJ7XqWOu5QT09ZgFDRTjMCsmE1FvS22U7XjOq9f2EiaEAk6WHco2lxl6oGkib6FoGkaQ+b7XSJnvgzEM3/YHEsBTwrQ2PRPrV5XDzRZi7ksIjiKehkD9HcZ5A7F/nZKZ1CHlx1CGRE3CFetvTw9IcDTZA5CkDwzfwNiNnJUUuDC19dWUrtGkMSWf/qQ7fiw/gG/fnZVIA+AWeTbeHSoCrIicesJAcCCa7hET+rZFSdXdKw4A2AEe6k06IgKWP/nEtNmQpud/BCc/DUjSNDXGmmv5bkii3dc9yJe2bAGftRibZEo58SV7lclgtt4QBn0F8PUr5ayYLV3TTXyJ13JpeyvU2ua3NPoNXLen92nJRJpRTphjo/aG9YzDZKfwe2cDnmTbmKPf381FfvV6mNecvynF7MvDNVYpMf7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199018)(6916009)(4326008)(66476007)(316002)(54906003)(8936002)(2906002)(66556008)(6486002)(478600001)(41300700001)(8676002)(66946007)(6512007)(6666004)(26005)(186003)(2616005)(6506007)(86362001)(38100700002)(83380400001)(7416002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5e4hsuUglF1SLs2XDmp0eRz/R9qFjDMSsvurLe9u0C/t4rtZuEF2zyoUv82t?=
 =?us-ascii?Q?APgBfexBg/hFk5Q3+JPUHo0hv7j/HbIYokm6/72UDQ8uJ54aPZNH3yfGxaoy?=
 =?us-ascii?Q?qiSNRLhSXJkkaG2hk88O+6wP57K1j9Dk0fG5UXWpQKx+96ooN2puryZIjV7D?=
 =?us-ascii?Q?Q8VHg/nWiVq4+YvC08Tycnsl458Awcs/bQtGdw3sjglUT7MFDmGFZfLvmZom?=
 =?us-ascii?Q?oZZ1aJz4aKsYhUHHF6pYjP9tRvb7GPalJxDaytUSPV8VhxcjLtoP1KD/6wNd?=
 =?us-ascii?Q?U3a7SBL1s5R2TkxI2pbunKmeTFGYUj2GoKZTooXviQomO4TjFA8WjZG7+/l1?=
 =?us-ascii?Q?mOhD1hoQjt5pSaSuuX68uQZzuDmdQjq2/Z0opYEbFzj9LlwPioeaIFWUUt2q?=
 =?us-ascii?Q?cD28QLse0s7p2Mf3j1/fKVKe1Bp+LML5MMHXXvkcYp3aUwkVqiE4CnXuUGLy?=
 =?us-ascii?Q?dlImw7qbqOrwpgKd3cNks8ZjpjRz3kz2sUDFFfX7lhDeqDIMk12X2V4ODucr?=
 =?us-ascii?Q?cRdKf/+71hEriDYVkb7oKW6FN66U0dmTB5eeubHmEdPPvHFvUaSFSWQwrHTY?=
 =?us-ascii?Q?3Dz1lKlZkmUNlSdvIxhQz2YJHvLTQs9R2qVFF+k/jaF20FU4FyrooDf5awzK?=
 =?us-ascii?Q?qTWN5OTSedgVqGXRhemAiCmIVkmy6TpgmGonys+lOlXnfhW3HXy56jalX1rO?=
 =?us-ascii?Q?NfGzbrJ+hpacSCWbEE+5qDNBDDsWTeJRo1t7P98mV/dUkKvI4L+fkzBXATOB?=
 =?us-ascii?Q?g0iIbqDgAYoTYHtA1C/YqydZygz0NmqhwBvsmn4t17pe0EuoU+VexHeaMPMB?=
 =?us-ascii?Q?gArvWDiEXM17wBiQZn2zVSAn0bjTGu5s9DaSlho/ae4cWzOTe24wgGD4y0YD?=
 =?us-ascii?Q?Ln8/BPdw6c1a7rgbFA+qw55IzPmzuRVbhwQGAB+RgJTeGI6FcVMeWglCY4WU?=
 =?us-ascii?Q?BTtJMT66sCKzwCSusIV1aKHspFcmmMxie5ushudQC0m6dfVaRIjVS66PFQuF?=
 =?us-ascii?Q?PKG5UOJOxxtmWLtb89zWH8BaPNhJX/SoCuJwcLpJ0PrpTL9A0mYLqFNXhk0j?=
 =?us-ascii?Q?/ZJx1KboCW8SZyyxbo2n+GVzkBkUBKqVpaJdmFaCOTt1a0z3Vr9J2djrEJ9V?=
 =?us-ascii?Q?g/Ss1eHNlosKIopvQrRa5+2gkdKuiJyjDrTsVlEmMnBW8vGFWna8tsS51hEY?=
 =?us-ascii?Q?KrS6nIwTDAaGZ+zXdFx9hpRA/cAi+FJNxAP1S6i97HDCXQJxErKP+t/oGkS4?=
 =?us-ascii?Q?jcp7z0aI4uT1HWWpvH2MOXfQ4D1G59Nkv4dSmLBemz8lfH+8B30rc4sWvTp2?=
 =?us-ascii?Q?m51NTmFKbavE6vuIor6cJu3/E3ojKhPl8VwQM0MG0yIqrNvwA6h8LjHr6k+2?=
 =?us-ascii?Q?7HrXbUbnychMVd/ZHShFd0VaBvgQMDwd49VZ4tWOWurNsanp3dAzYmquBHpg?=
 =?us-ascii?Q?H1YyyyKcIqn/1pk/Eik5OgsxtW6vsChuPm7F8hJKO06l0elYJ8V4mW2nNfdJ?=
 =?us-ascii?Q?bDObDcSE9cldYhkGds8yzOrguVQgMOHkGL5/wLdpCB2X9nq0MWZpdgSxHWq0?=
 =?us-ascii?Q?Q4CzgFRNssJVLEFLBB/4NzXFCpzsBqEoG9g11ede?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46563c6b-9b5c-46ab-cfd5-08db1079b7b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 23:58:36.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg7bPzMwO1knD9/XedWnJ0LSblmrw+U1M187NKIfwcxdBmVTB7WW15/AcwAm/Ld/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:59:48PM -0800, Jacob Pan wrote:
> Preparing to remove IOASID infrastructure, PASID management will be
> under SVA code.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
>  include/linux/sched/mm.h  | 22 +++-------------------
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 24bf9b2b58aa..a3ee258936f0 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -71,6 +71,25 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
>  
> +void mm_pasid_init(struct mm_struct *mm)
> +{
> +	mm->pasid = INVALID_IOASID;
> +}
> +
> +/* Associate a PASID with an mm_struct: */
> +void mm_pasid_set(struct mm_struct *mm, u32 pasid)
> +{
> +	mm->pasid = pasid;
> +}

This is only called from this file, just get rid of it

It would be better if the other two could remain as inlines given
their impact on the fork path..

Jason
