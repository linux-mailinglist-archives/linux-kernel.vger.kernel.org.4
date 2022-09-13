Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F525B6A31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiIMJAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiIMJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:00:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A835282E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:00:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BDAA1063;
        Tue, 13 Sep 2022 02:00:40 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E31C3F73B;
        Tue, 13 Sep 2022 02:00:31 -0700 (PDT)
Message-ID: <8b115b79-f21b-645f-f1d2-faa493003b8a@arm.com>
Date:   Tue, 13 Sep 2022 14:30:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/16] mm/page_alloc: make boot_nodestats static
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-12-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-12-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 14:54, Miaohe Lin wrote:
> It's only used in mm/page_alloc.c now. Make it static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/internal.h   | 2 --
>  mm/page_alloc.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 2424fcde6538..43a441d35baf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -864,8 +864,6 @@ int migrate_device_coherent_page(struct page *page);
>   */
>  struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>  
> -DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> -
>  extern bool mirrored_kernelcore;
>  
>  static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3417232afa45..7a8a6bb08a15 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6571,7 +6571,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
>  #define BOOT_PAGESET_BATCH	1
>  static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
> -DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> +static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
>  static void __build_all_zonelists(void *data)
>  {
