Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6041068A897
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjBDG1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 01:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDG1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 01:27:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4142F885F0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 22:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7nzow32rldzNRE37/7gZLZ0DJPZ4skYJN8/BZlQpFHk=; b=2YwQZp4mtMaTi6AM43p5TdTgtO
        8J0TesrZJTOBzm7aN91x/naDVgRRjh48UwOwfHeBTI3n5C2I0fWIA68N09Ba1K4Jd06s3hYG8XoPE
        hPY53X1MBuOUKpHEUXfabdD/nMFHMYOO/fKPcfImJQfASBkJg1swSQsiAk3X6ehtB9433TMtnxW6M
        4ca/FY7SUkAjLnbr0hvoL/1n9FOKTEn7PQyk78FM/4t9+phXP6Sl6fhVyjaBVLKKh7PfAQGNJbr/r
        Lk3GybijmUv7VogKD0lkUWRhDupXzi+TvYDgNuPUnvtbguJ1ziyyJNHOvg35NGM+Q1yzolAzwLlRE
        2UVQKaoQ==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOC12-004ZAV-3y; Sat, 04 Feb 2023 06:27:12 +0000
Message-ID: <be4dace1-f546-1b4e-f33f-c757c100d0f2@infradead.org>
Date:   Fri, 3 Feb 2023 22:27:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] kasan: use %zd format for printing size_t
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230201071312.2224452-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230201071312.2224452-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 23:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The size_t type depends on the architecture, so %lu does not work
> on most 32-bit ones:
> 
> In file included from include/kunit/assert.h:13,
>                  from include/kunit/test.h:12,
>                  from mm/kasan/report.c:12:
> mm/kasan/report.c: In function 'describe_object_addr':
> include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> mm/kasan/report.c:270:9: note: in expansion of macro 'pr_err'
>   270 |         pr_err("The buggy address is located %d bytes %s of\n"
>       |         ^~~~~~
> 
> Fixes: 0e301731f558 ("kasan: infer allocation size by scanning metadata")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index e0492124e90a..89078f912827 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -268,7 +268,7 @@ static void describe_object_addr(const void *addr, struct kasan_report_info *inf
>  	}
>  
>  	pr_err("The buggy address is located %d bytes %s of\n"
> -	       " %s%lu-byte region [%px, %px)\n",
> +	       " %s%zu-byte region [%px, %px)\n",
>  	       rel_bytes, rel_type, region_state, info->alloc_size,
>  	       (void *)object_addr, (void *)(object_addr + info->alloc_size));
>  }

-- 
~Randy
