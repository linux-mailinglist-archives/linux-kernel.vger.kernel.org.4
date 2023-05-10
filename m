Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF616FE207
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEJQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:02:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D737296
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPMaDWTcXGQ3oXrO14CaD3JXylYUiH+kUkqQ6vfwY2PpMhZpjJrBZXzc61kkKoYZctvFzB1dcRx/R0WFtIhb/kZPWImMRBjJEtM17F2t+rr2Ifqy9MBKYBkp/SnhQX/qUSluQaw49REMHD51TVNP4pIeZFb3Y6vAg0cZNNI/B/PYSSJFw0C5zrsmCXND9105K41UJpaK9rE4kuYlk2jAxtf129hDvCGTtgXSgR5Z/0tIUKJMO5UdHp9njU/RObDr2WXvTv4PuvXgTtPRoEC7SGIRi1WozVQmbtt9Zx/uo0wfGjGB2MgE3aa1OmipM01qDoZMUTcty74CAKALSdOaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOSAQKAt//97A5LUb1QRgwcqmdvAGZSI+De5pn0NgOs=;
 b=n9Db19vO9WAaQeK+7k7nzizZvbKBLid81i7SXcJiQKLPQTSvc4grYoBBXLIrluncQDLYsWMbQsshlwpI3EUlVlkq2eC+37n6O9eyIbuyA5KLulTMUL4eWVlW7uWaLXCKYkbow+oRe3bUIiZsuJuNOpG21idLuL+6HWXxcW9qJEtMcNyYM8pcrO65ehE0iUJdpdWFTb8lMO8tCSVo5C8IQwkr+HgJaaRXmvTWrVeOh9P+a+99X5kScBiJHhbs66auLuG8uooZ/6QlbC6yQPmrvIPnDtEdOHjavQ9DZWPG+RE8ywZjndgfP5MbAxO0I9jc26lp80s97P+lews5Ul+sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOSAQKAt//97A5LUb1QRgwcqmdvAGZSI+De5pn0NgOs=;
 b=o2GBUmQ3chYCpiY3y+AcCw240ROhq9W4+0y4ab4yl3M+7BxOyryanHgVQJdKkgd5WymgxkGYmLb5/FOlcRdi07rXFIVBxnmjqr9AipbAbuFPQRGO0urTjkonM7W3QaJh6FdHPFUzpQf9KLLf4mSnHnT3peT4izdKc4kgoweOnMV3OxEjHtqJSrrx1Seox8L+z82RVuoQ1NOiSzNa1I6g2qKMZFeH7Si8AexWwJpRuDYKXhsRidL1QtWWxM8B2LBV96YsDk4SClCJmvn4Ty/YJH1RicTLK1lxYG/bPnS+Mwn9bzd3tW6WsZXY/Ej+5mxlIhxIU+vrgANUQ8AtPdwzrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 16:02:40 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a%5]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 16:02:40 +0000
Message-ID: <d5262105-6f55-a35f-c32f-fbc1c5d78efa@nvidia.com>
Date:   Wed, 10 May 2023 11:02:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>
References: <20230410155721.3720991-1-sdonthineni@nvidia.com>
 <20230410155721.3720991-4-sdonthineni@nvidia.com>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <20230410155721.3720991-4-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0116.namprd07.prod.outlook.com
 (2603:10b6:5:330::13) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4b850b-22b9-42b6-d0a3-08db516ffae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSi3lSLWklw9Za9Tf5gRg87cKP7b2/dwrbgPaMdiL3Za7rS3yiDf1NRDgci52rIU4VgIm9dZc8q4mkIheUehsLuhLnWOxje6yDPANBZELnQ5VVNMAK8yb0VDGaWAllKAXyv0FakUFWGuOKTMuU86vMBN/mosP52cD0j5WbJX2VrvNk+qyOKrxjqUYk7Taddv9dZXlg53DPSUXI++nrp3MadZELb85TbKMuLn0h2LprX9jL7WwVa+MBId2nf494ipAuERtsRdhPcjU8DbZgNCc+lRqYjZK9hq0FAWfpybeLVnN1Czcu1094m8iCR2M9huDwYnqvDHhSpVEqH2Yj4vbWBM2dNsgjzFcNsyhn0jvF0jcekxLc6WKCczKk8hqZHKppMqzXDb/UNyJ1RVw1+qkti/cBi/56+C46855rBkF6IwyaFE6OspHkCVP6H0xgUFObznC/GgjgKk89htkx+AlZu8reQ4ZefwX4CQO+OA7nx8URMyEGDJUFJbk0Ua13wOmxAltOYRsK6dyXhp0pAU5mZZ3EjwsS9V6oyTvJvQQjenNBwQzWmoFIxtPDmqIwAseGgBTWtYX0znhSqHvh8FjA0ktpDFdCFrxNVNPVSuI14WVq+DXbeR2skg+5i5OdWQM9ujZo5wuqVxfY6pv8pOeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(83380400001)(107886003)(31686004)(110136005)(54906003)(316002)(38100700002)(41300700001)(26005)(6506007)(6512007)(53546011)(86362001)(5660300002)(8936002)(31696002)(8676002)(66476007)(66946007)(66556008)(4326008)(478600001)(186003)(2616005)(2906002)(66899021)(36756003)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZ6VDkrQkNEVEVUZ1dYdUdNc0thc0ZEd3JKNDN0eXUvNzlLZFVQcC91OHJp?=
 =?utf-8?B?Znd3WDhnbUw2OTJyUnFlMVloZmdVd3FmMklnQzFwOHgzWllVNGg5emwyWmcw?=
 =?utf-8?B?Y3J3VUVmdmU2UlZFM2Q0VE5zU0kwTkhGdExJWU9XS3lFNXZUZmR3RG9UQmh6?=
 =?utf-8?B?dlJ4SnQ0Um9YMnNaQkhBNGQxcXNZZFRzeXRnc3dLN0Q5Q25HTFlOUDRUd1p0?=
 =?utf-8?B?ZTJsTXFtN2Z3REZzZENrRG1ZcTZQZUFFa0Y5RUpyYmcwKzNQME42MWJVbUhF?=
 =?utf-8?B?azB3VUhjd2NDTFpmWDhIYTJKTURMbFhTVVNUNFU2OEJvSkpGcW1YdXVMK0lF?=
 =?utf-8?B?VzlPSHRFVVFIeEpjK2Y5bXhrbnV4NzR4MFhGaTE0L1BrR01wS3AwcFVSZk9M?=
 =?utf-8?B?L3hEUXRJUjVmaXpXVVhreVJEWlZpYUpOeU1LN2hETzVSNWlPc1VLK2tmL2g0?=
 =?utf-8?B?bXlJZDBzL0Zrc2ZhclVEWi9wUGl2SUhiSS96L2h4NFVCcTYyMGZkSE83d2ZO?=
 =?utf-8?B?NE5XTTVFVFJhd3JXMlBVTDBTVlRaVHFHUVdmMUdna1JuekxFRmxQZ3oraE9N?=
 =?utf-8?B?eUN4Q3RaaFF2a3hvMWZyalBsMDQwUXBZUGJYVmZzdWVqNm5GSzFGaGpQN3RM?=
 =?utf-8?B?blZpNWR3aE9lR1pOaW9hdm9CZVBHc0tXRE1pcmY0U3laVitZK3daVk9STWl3?=
 =?utf-8?B?dXFiWWRKODlGbERKcXFUVXF6MytKNks2NGoybXBBWG93Z1ZHZklkOGpLZjUx?=
 =?utf-8?B?bGV3RkplZFRLaVJ3UGlUeW1ZRG5Xblk5d2JQYjRvWnRLUUlic1RFaFFRd0d1?=
 =?utf-8?B?c2VuVDJEMjU0TkRRQTRRc0U0SjVVSzF0WnRtRmNDS0tSQXpJdlRYdkYwUjcy?=
 =?utf-8?B?bjd2NmtPZGlqWDE2NjI4RW5nZEJhNCt5a0FYZ1VuY0p6RldXUENNMjY1QUwy?=
 =?utf-8?B?Z3h0Nk1RMm0zRjFkTzNCV3ZLYnNGQU1WSnk3THNrTGJ3Z0YvQ012MlBsZXA2?=
 =?utf-8?B?SFhRRlhXcXBWM2tjWEdOZ01tSGZCSXVOaVFaZW1SaDUxTmRMdDZJbll5Y2lH?=
 =?utf-8?B?bS9jb2dGcUsxNFFybkgxLzRTZUpoQSsxakNtYUNKbEI4ZFFXTmEra3JzTG5Y?=
 =?utf-8?B?QnpaMEUyQTdOZENRZjN1WFRpZStWL01rSGhjcTFIalpRbm5xNnIxK2RWakRk?=
 =?utf-8?B?L0l5TncyQXVraysrUDNwd29lVnJxeHBSeXlIZ0NsZlhXTXJhak5GR2tMMGdw?=
 =?utf-8?B?QW43b3ZXK1BiMndETlpTUTZwWjFJeTNLMCtLTExzYUFKZkduTU0vanlmRjJ4?=
 =?utf-8?B?T2tFQ29WS3VsNGd6ZXQ3MU1tcithMnRjSWtsTDNxL2xjUlFQQ0V1dUpnZnJm?=
 =?utf-8?B?YlJudDBwbU1VMERVSVJqNWdBMmpUTVRQaFFXclJ2Q2FtcURueUY1UzlDemd1?=
 =?utf-8?B?RmJaaW4xNzJIK0tHQU5Lb1pyYUlkVHNDWDg4RUkyV1VycTVWWGthYXZNVlMv?=
 =?utf-8?B?YWw3bXQva0tFYm1vdkhhL3drSm9KWk1LSTVGN00wWVlNdDRNaG0wNEx0UWZz?=
 =?utf-8?B?bXNxYXQ0NXhSL2hNNEpoTjQzMnhaWW5kdXorMVhUbXFsOWVzSTd0SFNSYVNI?=
 =?utf-8?B?YzdHMTZXcVJFRVR5YTFhK2l0NWxyd01ZRVh0bTVSSFVvSmp2VkJoZC9jd1hX?=
 =?utf-8?B?bVJjTlVpYWljclF3S2ZNb09BYmNqOVR0b3VNYTZyUkFFeFYxZStIdXkxUElj?=
 =?utf-8?B?Tms1S2NUSEg5ZFlBdHRodFhVMzNoTDl4eDZOSU04Y3N6dkY1NVk1K1ZRd05V?=
 =?utf-8?B?RTZvcGZGM3h1WXhXdE5Zc1dBRnVlZGpvYThZRXZxeEZFeEdOamduaERrd3pG?=
 =?utf-8?B?Q0dCalRxRFlLT1AzZ25LbklVb0dNUjV4dm5wSDVwZUt3MjNPaVkxaGtKRE9s?=
 =?utf-8?B?LyswVHhISFpTeFpqai8rekhUTS9BSEFET0FLUXpSeGNjajFsQkRkK1M3MHlI?=
 =?utf-8?B?dkorNU03Y3BHcWhMTjZ4WFJpQmNabUdnaE9vck4rVjJBR2RhOUFmSE9TVGlZ?=
 =?utf-8?B?SjA1NmkzeFo3c0YvYnJDa1VQM0duM1M5YjY1bWVTSUZjOE1MR2FtMy9mVkZl?=
 =?utf-8?Q?L5hbWFdkSIadVW+qxVB2EMHI/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b850b-22b9-42b6-d0a3-08db516ffae6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 16:02:39.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+NmCxXwpw1AWwq439Ebs5RG877uNlmBm2in9pp2Ja7LiRHMy+0VEIAQpcLMZptrqW9ssUI1sKTR4CuyLKubcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 4/10/23 10:57, Shanker Donthineni wrote:
> The current implementation uses a static bitmap and a radix tree
> to manage IRQ allocation and irq_desc pointer store respectively.
> However, the size of the bitmap is constrained by the build time
> macro MAX_SPARSE_IRQS, which may not be sufficient to support the
> high-end servers, particularly those with GICv4.1 hardware, which
> require a large interrupt space to cover LPIs and vSGIs.
> 
> The maple tree is a highly efficient data structure for storing
> non-overlapping ranges and can handle a large number of entries,
> up to ULONG_MAX. It can be utilized for both storing interrupt
> descriptors and identifying available free spaces.
> 
> The interrupt descriptors management can be simplified by switching
> to a maple tree data structure, which offers greater flexibility
> and scalability. To support modern servers, the maximum number of
> IRQs has been increased to INT_MAX, which provides a more adequate
> value than the previous limit of NR_IRQS+8192.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>   kernel/irq/internals.h |  2 +-
>   kernel/irq/irqdesc.c   | 54 +++++++++++++++++++++++-------------------
>   2 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index f3f2090dd2de..7bdb7507efb0 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -12,7 +12,7 @@
>   #include <linux/sched/clock.h>
>   
>   #ifdef CONFIG_SPARSE_IRQ
> -# define MAX_SPARSE_IRQS	(NR_IRQS + 8196)
> +# define MAX_SPARSE_IRQS	INT_MAX
>   #else
>   # define MAX_SPARSE_IRQS	NR_IRQS
>   #endif
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 9a71fc6f2c5f..d6d8120ffd56 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -12,8 +12,7 @@
>   #include <linux/export.h>
>   #include <linux/interrupt.h>
>   #include <linux/kernel_stat.h>
> -#include <linux/radix-tree.h>
> -#include <linux/bitmap.h>
> +#include <linux/maple_tree.h>
>   #include <linux/irqdomain.h>
>   #include <linux/sysfs.h>
>   
> @@ -131,17 +130,38 @@ int nr_irqs = NR_IRQS;
>   EXPORT_SYMBOL_GPL(nr_irqs);
>   
>   static DEFINE_MUTEX(sparse_irq_lock);
> -static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
> +static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
> +					MT_FLAGS_ALLOC_RANGE |
> +					MT_FLAGS_LOCK_EXTERN |
> +					MT_FLAGS_USE_RCU,
> +					sparse_irq_lock);
>   
>   static int irq_find_free_area(unsigned int from, unsigned int cnt)
>   {
> -	return bitmap_find_next_zero_area(allocated_irqs, MAX_SPARSE_IRQS,
> -					  from, cnt, 0);
> +	MA_STATE(mas, &sparse_irqs, 0, 0);
> +
> +	if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
> +		return -ENOSPC;
> +	return mas.index;
>   }
>   
>   static unsigned int irq_find_next_irq(unsigned int offset)
>   {
> -	return find_next_bit(allocated_irqs, nr_irqs, offset);
> +	struct irq_desc *desc = mt_next(&sparse_irqs, offset, nr_irqs);
> +
> +	return desc ? irq_desc_get_irq(desc) : nr_irqs;
> +}
> +

Based on the comments of mt_find(), seems it is the right function to
use for finding the next entry.

static unsigned int irq_find_next_irq(unsigned int offset)
{
	struct irq_desc *desc = mt_find(&sparse_irqs, offset, nr_irqs);

	return desc ? irq_desc_get_irq(desc) : nr_irqs;
}


-Shanker
