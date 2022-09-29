Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA315EF9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiI2P6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiI2P6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:58:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD51CFBAB;
        Thu, 29 Sep 2022 08:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVGJelugIvpnP5bn47wXpLY4MTjvhU8X1yP+uxe7Ze94tt/tc/QLouZzYfqWURhu+pYunBUakkEt16fUQo49G204gV1xf+SEdzqJR6FM93xWjVOvCYrH8Yq5lRSnGEKh/ZQLR06DF5EEmK/GXzwaoK5FLjk9Y9NfQhcn6AuUCIJE0wJHpnr6vlhhawZtaR1H9FwyRWFPgVSdHYRcq/BQ7teh+hJ3impccP4Avuay489yZfDSqA9Z5tgEth9KHG0GDmwH/gfni/aVosvSI3NC86Xr5Ajz2Ffp4APrBx04L+dDRTS2/SO90plyJyXiuIsoYc8KQXLIVELLKLRz5RWbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEfcoYdU3sj4MSz7vLANrRrFZg6c5+Uw+YyzOA5iOBw=;
 b=hrsme5FBkbaSdw9v7TQcfoEgXxlF6Ze+LLyIKXd7stTdY8obllPukumlQ2c8PSRwgVotwTTO688bu3qwCDGSgCFfFZpFpTYQ+bEDzmMPPLJgKGk1QhL8+ptetVMzy1MrPwrw/MZk2z/PQvF0nUGfSr3WMeLaeSR48gzvbrgm5U3gGL2chb12nAWxTfBWnmJ/3BPJTX0GCcKvpNJXwelUf9g2xcXDYk0T9P+G7D+gkjnTd0WhF6Bc98z2gh8dcO1cW18DWWSaCmpZlUlK/97zkQtKUplDSFPlq9u82Xvnd0o//PqNwcQNpSqvW6GPO5lYz6FSaVnc5NS9Ffcb0GeZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEfcoYdU3sj4MSz7vLANrRrFZg6c5+Uw+YyzOA5iOBw=;
 b=IHdaUqQ7bLBy0vhibm2fjaiISgT+5CtCStxvxaaMOEJ4/MsZmcIZKhFnxTxdjkqJYWX67bX8qJBpgbBblyrzuyEPIDwm1kT4vuMia7+yzUc6TLaoX7SfEb590n+QT9FvC45DpR2GON+Z7J+S6SeQWfQ6YO59ItueR15/Z6LHr8db0lrC2jf0Ab4phipvYJIBoVw7lMFijZkI1eeKgs8p7bxIO1Aw9Q9lP6r62Ep258S9EF6M/Orv5cEiQzXXyGT6udXtPcVpLOvKSQLeuh/6y2IDAjfUQNABdqnIpxeQwEFMvhuyXrZZ10tZJ8NXnQ9JBTntXaCgNF3q9J3aCHijQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 15:58:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 15:58:40 +0000
Date:   Thu, 29 Sep 2022 12:58:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iommu/s390: Fix incorrect aperture check
Message-ID: <YzXArysnUGFhywQT@nvidia.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
 <20220929153302.3195115-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929153302.3195115-5-schnelle@linux.ibm.com>
X-ClientProxiedBy: MN2PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:208:234::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: e66a1be0-da14-45fa-7d28-08daa2337a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLk2H7SDrhYcXvjzgthcxoCLtEfTxZCSQ0+jLbb8H8XFTI2+NGS2Sc0aB0bz6Woniaai5Ol0hlmqhHV3U7Np7H34nMaJGYO92ITl8dxKgBuBGsF1EuOYnW+z+4W+DrBBsLacCUEXaoFJf0auRp+DKkuWo0QuPSMv9cICRMXu6XG2RC6nihKPOUfjJMnVzZJfKQeBn/mPtIozSzArtLdmtgJY98qeO4+1K35rPvnthH3L9lSRAOC9HFGqKD3Qa2p3LtPMsQvqBez/mZgJIWPCR72NckG2KA7Et9NNwoWeBp6vRC/AiglvQtvuJk1frOHbzZKupixCWpO0FtasfUzoi0av368hxjKagO1Jz5/5tAOvOJGis1ZVzoNHx3csQFUeR972eeyNBgdedlT2sOBra0+DCHMveM3GyuqKX9umkYy8DI9EmViabKCqNfpiWcZuLRuY9ty0isuKEEyqgLboUzBaSQGiXMXQRUZcRlLMbEG4h1NCcud6jPWmesp3fiyzBnlydapQVv1J7hWI5zlCitouFsdBllS2mDwX3+igjjObDQ3zboAmIfrK+ky8uT9WkcdL+LV8IKaKdk62+MRb5Owyrsqcval7fU9u/bsYOe2b6wgvcGqIqIdig96kpvO2Jezqz/m5VMwf/6wpJN14x9pxlADf3C8NZWfjFgqWrWjTEkPZi8k+VDI5aqHTB7EgJfOGLbnm6aqHqz+E/NYetA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36756003)(6916009)(316002)(54906003)(86362001)(7416002)(186003)(2616005)(38100700002)(83380400001)(6486002)(6512007)(26005)(478600001)(66946007)(66556008)(8676002)(4326008)(66476007)(2906002)(41300700001)(6506007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h59yMyG2xq4Dnuzbd2vTWXf2QfvbArBYkaHRW3DzWxcdMbXs6Le8TtsqvaIj?=
 =?us-ascii?Q?l5/A3qESl44StobAR+x1I1mQOhjAxfdKsmf065tpVVZNz63y/nNR7tQ/qq5d?=
 =?us-ascii?Q?zh5o15ty13csiIYGX0jbzKL5PNCHZYGWDRJE8ZO3fDofxlrDcwki0fZ0YCF0?=
 =?us-ascii?Q?Cr+3BJgWPEQ+WXQNPIU43bioGnMjfHn0jIct0SjHN1Hi5j0P06Mn1e2CjiXh?=
 =?us-ascii?Q?eIrHYwuIaARjIkogntewuAmuhI2EfS/KYkiZAQnHDvy1cWRBAXVQS5lj8TgB?=
 =?us-ascii?Q?35uwTD2pbvLxBBgzEfXMIt93miCH1PJE2jk4cZBbBNjGB/LgG6ZhhayTzSiP?=
 =?us-ascii?Q?B1dlvIloZuZ1L3fAj1xgoFGDDFnYAWAdYdSIGlualczQU7hkLFqSGOL2zemJ?=
 =?us-ascii?Q?fZVk9CG3BKFj3mDqoRH6LDgn1dEw5cMFwiuCbHSXiwUGvbsHg3Y80GDrBNE5?=
 =?us-ascii?Q?k849xSaCjPvUPrllkc9+soDmcS8JCCZvICpofcLHb0K7XkOMSQ07AZFfwFPS?=
 =?us-ascii?Q?dyTAuAgdr0WUPdjHsczf21cTzI2i58pjpYbqgi8i8VyEmK7mkUS2iWI+O051?=
 =?us-ascii?Q?GG7tBwxaWnT0VLsqX4yDL6mrg8mL3q0Faq3/SwQFOLSBhvYwyHtPYMuKgzzV?=
 =?us-ascii?Q?rxah14neEzP/BKZs9cue7BkBiD+KwhLBJSfyv8tjLnOhAnglSJsXNR8O6G1v?=
 =?us-ascii?Q?spAm4EwyZNzDhmJT7nc/foaO3iM+d1Tf3UV8pUELO8lM5IKmx0qd6bjY3tLL?=
 =?us-ascii?Q?/N1c3HYcrTqUlacFbsPbQEuOOoZ4V6OYb1Du0Ab+8lAV53butQ8gF/WgX9JK?=
 =?us-ascii?Q?6CqV3CV1eEl1nyYoczEt9V9/C1xgqrKY5ena20RoaJTa5noL414w6xVh0wSX?=
 =?us-ascii?Q?QB8pIfmzaYUmlxrG5zEM9IKp43Xm3Fl/+pPT0IqQowMdLMEbPCmzJlbpYTSE?=
 =?us-ascii?Q?NM4iPunyi1aXE7Vir6Mt44U52f5iKCj15KxxKyx3gWf3l64yGzAzl/hTkijd?=
 =?us-ascii?Q?Cswbd+Tc0ejxn+1tkNp3hePwKoE7AJTxHWawmbVG5hvgc47CviEdU13i9b44?=
 =?us-ascii?Q?2d3jGzPU6PHTUUcq+FTmZpGeoLT6Qi1cxBTGTvoWTpwXflKfkngudNpGY6nG?=
 =?us-ascii?Q?R+2OC0phgutJX5I+yoc80KxsgQgqePfAFVnBMygBOE2uXgZZgOrzj1ddaVTA?=
 =?us-ascii?Q?0m7CphJuobQ9PWkHP+ve7liD6tE51v5ufw+iGEHSVm0zsezgnEzXi/ooTS++?=
 =?us-ascii?Q?VKTaw3T6Hgdm0S72wQ8UYNP7KbkjNboLXyqNeC0Ai7oyz18WFXCLGy7562tR?=
 =?us-ascii?Q?4/dLTPZnxTvHZAZ5hbuKF6XhE7rIShokZ0IVyLROuC6oB6GfFDJcSi9+8Op1?=
 =?us-ascii?Q?p/rsre1XmhgLLyxOYTBkiNCSuM9v4c6p38fVaVY9GK+QIJEnLkul8ZK/twg3?=
 =?us-ascii?Q?W7ZWqMWriuSQi98KtE8kDgIPPU0nXef3iBmoFu2wSTyULmTWDMBST28w75+Y?=
 =?us-ascii?Q?ODEwrB1nzXCHeEnCA5CCi6siloPYSqUb8lqJmMi0YNw9nqOzy/lmUL6nbSqR?=
 =?us-ascii?Q?mhdCrHG+wPbXVq7xPO0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66a1be0-da14-45fa-7d28-08daa2337a65
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:58:40.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEQ/eTyv75QtvXO1TMWRT6t9AmwoeXNAa0So52KF1j5QwVkEPCKPjfKfc+E2tMrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:33:01PM +0200, Niklas Schnelle wrote:
> The domain->geometry.aperture_end specifies the last valid address treat
> it as such when checking if a DMA address is valid.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index ed0e64f478cf..6d4a9c7db32c 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -210,7 +210,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>  	int rc = 0;
>  
>  	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
> -	    dma_addr + size > s390_domain->domain.geometry.aperture_end)
> +	    dma_addr + size > s390_domain->domain.geometry.aperture_end + 1)

The reason the iommu layer uses 'last' (= start + size - 1) not 'end'
is to allow for the very last byte of the range to be used.

Meaning (start + size) == 0 in some cases due to the overflow.

Generally when working with lasts's I prefer people write code in a
way that doesn't trigger the overflow, because there are some
complicated C rules about integer promotion that can mean the desired
overflow silently doesn't happen in obscure cases - especially if
unsigned long != u64

So, I'd write this as:

  (dma_addr + size - 1) > s390_domain->domain.geometry.aperture_end

Jason
