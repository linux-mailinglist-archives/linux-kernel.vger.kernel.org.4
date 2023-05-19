Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A6709C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjESQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjESQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:32:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E80198
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpbXxR6yddOVDTLOmaf8Cf5D7ypYNuap1c2pjBoV3HlwypMdLxBPno4xEeqVGbBE6AXgv5+R05ypIeobHgz4iFoVP8wWRSXUtKJW2tgL4ymIEURQUwRG9j/v6Pqkd9I0pxXXE9g2D0RxDQKkKgR6dQ35N7fkR+0N/J6fAw7OVwXTJX0XKc/qxYBnCUyLQH2DDnWPhVrPxBgLJgavPJQTH6lOxhddV7cIYAArfQd9qkZVyGdyrrHikAxtZk6WmEa+x4705FOWo8fjesQBelgfAgrFzV7LOUqHv/ivECxwcpJGBe1yUSRpfoIgDxBLBDcviofXk33itus2a4rha8xUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9juEMAEEnP/pacjX0P9wiBh9Cr0LNZuy+NpIHXhEwHM=;
 b=od2knOUQrAJ0pR/2/6D/0BQGEGdOGAQuj0CPmQDswrxoAeBzC8Q4+2umnbWwlpTig3qTTH4Nv7LPUUEKjhK8HcIwqQD3xwLj7OE7VvVPx2QjjKIOmKq09ZjwuVcKrNXqyHo4ypjjOgo/vavHmYLoN5XKNfNaUjosev1w5s89RVafu4LHShuKKPSTL1lvB4TPAK2ro8I1MrnTPy7fIGgYZ8X5Nyeavef55v9YFhjXHRSiulJeakjEacRlhoVHni8wP1VEzAyu1OF2EKf70MzHR2TLr+cf4qkp4nxqz7mX6npyrco6PRttNEsr5OauG7rwjQ9iAwMNUPK/FvuPgl+rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9juEMAEEnP/pacjX0P9wiBh9Cr0LNZuy+NpIHXhEwHM=;
 b=5bNvgPiq51YSkyznb2h/es6UugnOh3VScgEUri+vCdjMSXEzd1pQbaHenlwtmakaVkh2+TZK5sOURff/8XrdaVw0jLbJmPeaYSx2k4JpzNtFKxo77BRI6gFkSyUKiE2JsdeKe8S6EvwoNoWFr860kI0RUA2Z0lNLuAFl4ozEqz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 16:31:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:31:58 +0000
Message-ID: <0cce2c41-bd61-122c-05a9-89ed78fbdaaa@amd.com>
Date:   Fri, 19 May 2023 11:31:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] x86/sev: Fix calculation of end address based on
 number of pages
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <b5671e1d6d7b1b9e6ed9f5bde15cdd06aca2671b.1684513457.git.thomas.lendacky@amd.com>
In-Reply-To: <b5671e1d6d7b1b9e6ed9f5bde15cdd06aca2671b.1684513457.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0100.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0f2722-ef08-452b-5080-08db588690a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gFZf2hyKvdERpMDD2fp0q4tmEsFc4j6Re5pG1GcXS7SCDW6kXnYXMlqZdeP7oVbyd5XeDDLKCzNrm6LVGGUp2okTvAUcHVxvwKB4T4lui51WfH8kOLFNdtUz4G2BGbkAKwbS2XssLGlByiXj/RVTf0lgSRiCATRogPWpD5VNI6AO4CXZzBgiMnhIq8a4kh4KjcZQzDYTQfmyT+s2HAQjQ3ofnhf1Y/+tx4ZKH1EKwgahNsx9CbHjycE3TD27D/ylebYyph5TL/IxxpnOhLfCczZt3GjbvvYt0ldLjlCc7rK3smX2aMC7t2OG00HjgwgVWi4aNChhCkFyuhNc8NFYYtOoS8NfU1hbH3IgZUPrp8XepWQnzfSVoCq2vpDyBLoh3Ta1yt6hpMkwvVkrvbzUbA7O3tY9eMUxsNURTjw1nLVGgUrSBESsK4ZUvWUuKIxYpZ3UghQZ9zH+Ix1xFBDVoJkiIg+wAb1g6hc/wnEzrlKdOC6qMEDYOIpBMP6zTS3FkAF2VJpOIi+a8ivWeZ2pYBkkQyMuqpkbRhjN2Jdq3yOw83BgI8SQtC+/SxaQhH+rBpee1AeAzeS3Z9Za2+pHz/x8TzftXvd8ydKTZ7a+GyMHRZ8aNLmKWInGXQrk2pggYrImqpp1sZvJpUuitCBqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(31696002)(86362001)(36756003)(54906003)(316002)(66556008)(66946007)(478600001)(4326008)(66476007)(6486002)(6666004)(8676002)(8936002)(41300700001)(5660300002)(2906002)(7416002)(38100700002)(2616005)(186003)(6506007)(6512007)(26005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjFiejRGczB4NzE4RGdvamwvMGtRb0ZtT2pGRVRTK0RXUHM4a09Ga05kL05S?=
 =?utf-8?B?UmVRUm5BTzB3ZUFwMXNFNFRjVndHQXRVRU1JQjF1ZmlYQVhBay9td1ZEaG5k?=
 =?utf-8?B?N2hjb1VyZDZ3eEpHZHNaclhMYVpqTXNlMnRINm1xeE9PRXJNSW5QSUtOelNr?=
 =?utf-8?B?ZzRaUENiZXBxbWZWUk1IUExiem5CSldFYXRGRHF6c2dVckY2RzZibnJNR3Zu?=
 =?utf-8?B?SVYybGhLRG1xL3hQbjEwTFFBbDM5WnJFNEhYdDAzM1MydDNKWkgxTEUraTdM?=
 =?utf-8?B?Ym10ZTBGZG5MQWxqVGNvdEtCUTVvSWdqMXhiZVM3dFEwVVQzZDV0R3lZMFBW?=
 =?utf-8?B?SnZzUk5wd1QrQ0NUeWdzNGZzT1kzQ3g0bU0vQUxZazBkbzQ1TUxHYmxpUzcy?=
 =?utf-8?B?SWc1MFRKOWN6MDdHV1B1clJpUDNEaTY0V0E0ZzFLYXlNRmZ1bERyYllGU0Yw?=
 =?utf-8?B?RktvSUYyWjlkemhIdHZTSmJqeWZGLzlIZlBWTzdkOE5QMU1lN1BxcXVOZXNV?=
 =?utf-8?B?dVNad1BqOGd2d0crZjVJdUxjUnBMWDRxY1JvVXRtMEt0dFlQMXErUGg3K3NB?=
 =?utf-8?B?SU9VUXYzMHdHcUd0LzMyZmpsUXJUdXlOQ0E2T0JIdUtjRGdnNWdQeHEwQnpq?=
 =?utf-8?B?YzdQSm5jZzF1VnlxYnZMQURMM3pzOEJZaEs0R3Q2Uk96bENtVUhUWHE3enY5?=
 =?utf-8?B?VjJmdzFMRWpJKzJpWVBpVkhFRDA4M3FJUWxzRnB0RmhFa1dPcUovZXlpajAv?=
 =?utf-8?B?RnB3NE54TFA5WjRHWnhTY0J5bHZQSGtCc09EQU1zSkthMUN0aHBTZU9KS2cz?=
 =?utf-8?B?U3dUcHRGMnplT0YwUVYzQ2tHdW14d052M2hyaWFSWTlhdGxrd2NwNzl5eDBW?=
 =?utf-8?B?cEFCdUxtUlJNbitzemw2UGZLUmNCdm1zTGFkWXFJL0prYUVVMGNBQllmRnJ1?=
 =?utf-8?B?S25RUjVaWlB2SiszNmZQWTFReDgvRWVMeWRrN2hiVnBLRWZ3Wlk0Q2J5WmJ6?=
 =?utf-8?B?YTVlN2xpdlQxWnkyaFpnT3NaS3hZSUt1NWVlbGtxeGtVb2pmMkt2V21HSXNQ?=
 =?utf-8?B?dEtoNVRuclU2d0ZoK0ZkZTVoZnhvNjRUNHNYNHF0ZFlZRE91NEVQVmY1NmQ4?=
 =?utf-8?B?MUtkV0dhSDlUaHV3TTl4TEc0K3FSbXFRUnljQnFrbTRlaHh1RnFGYTRSQ2FM?=
 =?utf-8?B?cmpqUHo4empxWVQ3MFlNcVdjT0t5eE5yellIZjk2Yzg4RzRTK1AwRTVEVkdw?=
 =?utf-8?B?cnVLbmlNbXlLc2ZnYTR6Q3UxaUlzbEdlUTJnc0ZIZ05RZDhxbXVmdlBxTFZr?=
 =?utf-8?B?dXByS1dWZnFlVlhUZEhoRXVxaEgvWXNhRG14Qi8vOWh1MGtlWXFKbHYwY2xr?=
 =?utf-8?B?NjhJeWZtUnM0VlRVdnBqRGlYcnQyMmFyZy9mMlByS3hlbEoyRU56ZGRIK1pT?=
 =?utf-8?B?ZVZJTkVSbytPN1dEWmVLTEFFOVdLYW1IK244eFdYMEd0NW5PTzZvZkFzYmpU?=
 =?utf-8?B?T0pvNWZCMEdtVkViWlFrZFpTMjdHMXZ0ZURGcGhsZlROaUI5UXV1c2Z2cytH?=
 =?utf-8?B?THJ4cnpaa2M2TXBlZnpjU2RYME9waXlGekpIRzdnNGhFSTVuRk1WSFVjTGkr?=
 =?utf-8?B?cDRKcmJYbEJnNmFaVjR6NEdKQmNDZ0liVnc4Q21NVjc5SEJ0UWhDSDBSUFYr?=
 =?utf-8?B?MTEyK051ZUlzTVBTekxlUTkyUGZSSjZtSDFUYjlYWDVlbVB3UFViVkVUVEg4?=
 =?utf-8?B?OEY2OHJRRXhtdjkzcGozOWFpNGNrZEZxa1BGcDNuNENJeFFBUkt3OXAwTEYw?=
 =?utf-8?B?bXJEcnh1Ris0YzV3bGxSMFpmcVZvU2lFQ2E1SVNqYXlyYlFTcXU0SElZT080?=
 =?utf-8?B?d0pQd3pBNGoyakpWUW1ldEpRYVczV1ByMjJHeDU1SGpMejh3OXhUSnd3Njgz?=
 =?utf-8?B?bGdDMEdlRE5UekpsOWdIeWRycHo0S0FlV1dMVzVBdGtaOUpwaUxBV1phUWJ6?=
 =?utf-8?B?RzdJc3lnNGN3QytHcEdjNCtWUGNZbHZxbHZVbnJqdW5kN3lnWGY0a0JRTFJq?=
 =?utf-8?B?NUVoS0hlQzRxKzdncWVCWkg4TWNsUjQyMllHMHZvTE5tOW1mMTkzOGZsQlFW?=
 =?utf-8?Q?fxREzS5hzuKUmC4Gdq4BEeXPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0f2722-ef08-452b-5080-08db588690a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:31:58.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f4zB5R/+E0q9MeQro5xiiUz9hZoW2D2k1HKiE4tOEbxZDq8/eN1lLzXzrm025dTyRgW+QqSpk+hWZR7ZBbENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit send by mistake so I missed adding the cover letter and version 
update. Resending...

Thanks,
Tom

On 5/19/23 11:24, Tom Lendacky wrote:
> When calculating an end address based on an unsigned int number of pages,
> any value greater than or equal to 0x100000 that is shift PAGE_SHIFT bits
> results in a 0 value, resulting in an invalid end address. Change the
> number of pages variable in various routines from an unsigned int to an
> unsigned long to calculate the end address correctly.
> 
> Fixes: 5e5ccff60a29 ("x86/sev: Add helper for validating pages in early enc attribute changes")
> Fixes: dc3f3d2474b8 ("x86/mm: Validate memory when changing the C-bit")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/x86/include/asm/sev.h | 16 ++++++++--------
>   arch/x86/kernel/sev.c      | 14 +++++++-------
>   2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 13dc2a9d23c1..7ca5c9ec8b52 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -192,12 +192,12 @@ struct snp_guest_request_ioctl;
>   
>   void setup_ghcb(void);
>   void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
> -					 unsigned int npages);
> +					 unsigned long npages);
>   void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> -					unsigned int npages);
> +					unsigned long npages);
>   void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
> -void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
> -void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
> +void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
> +void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
>   void snp_set_wakeup_secondary_cpu(void);
>   bool snp_init(struct boot_params *bp);
>   void __init __noreturn snp_abort(void);
> @@ -212,12 +212,12 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
>   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
>   static inline void setup_ghcb(void) { }
>   static inline void __init
> -early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
> +early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
>   static inline void __init
> -early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
> +early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
>   static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
> -static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
> -static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
> +static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
> +static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
>   static inline void snp_set_wakeup_secondary_cpu(void) { }
>   static inline bool snp_init(struct boot_params *bp) { return false; }
>   static inline void snp_abort(void) { }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b031244d6d2d..108bbae59c35 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -645,7 +645,7 @@ static u64 __init get_jump_table_addr(void)
>   	return ret;
>   }
>   
> -static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
> +static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool validate)
>   {
>   	unsigned long vaddr_end;
>   	int rc;
> @@ -662,7 +662,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>   	}
>   }
>   
> -static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
> +static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
>   {
>   	unsigned long paddr_end;
>   	u64 val;
> @@ -701,7 +701,7 @@ static void __init early_set_pages_state(unsigned long paddr, unsigned int npage
>   }
>   
>   void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
> -					 unsigned int npages)
> +					 unsigned long npages)
>   {
>   	/*
>   	 * This can be invoked in early boot while running identity mapped, so
> @@ -723,7 +723,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
>   }
>   
>   void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> -					unsigned int npages)
> +					unsigned long npages)
>   {
>   	/*
>   	 * This can be invoked in early boot while running identity mapped, so
> @@ -879,7 +879,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
>   		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>   }
>   
> -static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
> +static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
>   {
>   	unsigned long vaddr_end, next_vaddr;
>   	struct snp_psc_desc *desc;
> @@ -904,7 +904,7 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>   	kfree(desc);
>   }
>   
> -void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
> +void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
>   {
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return;
> @@ -914,7 +914,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
>   	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
>   }
>   
> -void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
> +void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
>   {
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return;
