Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8405B69F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiIMI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiIMI5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:57:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9E1F3DF1F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:57:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB281063;
        Tue, 13 Sep 2022 01:57:48 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C5903F73B;
        Tue, 13 Sep 2022 01:57:39 -0700 (PDT)
Message-ID: <87e3cb9c-c401-f18b-8d6a-dd63ed6c9e17@arm.com>
Date:   Tue, 13 Sep 2022 14:27:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/16] mm, memory_hotplug: remove obsolete
 generic_free_nodedata()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-11-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-11-linmiaohe@huawei.com>
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
> Commit 390511e1476e ("mm, memory_hotplug: drop arch_free_nodedata")
> drops the last caller of generic_free_nodedata(). Remove it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/memory_hotplug.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 51052969dbfe..9fcbf5706595 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -43,11 +43,6 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
>  ({								\
>  	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
>  })
> -/*
> - * This definition is just for error path in node hotadd.
> - * For node hotremove, we have to replace this.
> - */
> -#define generic_free_nodedata(pgdat)	kfree(pgdat)
>  
>  extern pg_data_t *node_data[];
>  static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> @@ -63,9 +58,6 @@ static inline pg_data_t *generic_alloc_nodedata(int nid)
>  	BUG();
>  	return NULL;
>  }
> -static inline void generic_free_nodedata(pg_data_t *pgdat)
> -{
> -}
>  static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
>  {
>  }
