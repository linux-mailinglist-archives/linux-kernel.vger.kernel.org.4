Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8998175019A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGLIdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjGLIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:32:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970863593
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:28:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a412653335so1654889b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689150519; x=1691742519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKOx3ji7cu7+toV6q7E7Pf07IRWv+R94CaV9atCugGs=;
        b=D2i/AltBrJ2Y3R+f5uguA+RuIjF61Is+SfVDW+rzzpd8C7g3O9ya76N6wPXxoEOvfZ
         3QCISdKSp05eNxYgaUSaeOovvaKpJ0q4HhJ8iGbaucOB1GgPr57cMIbRPhD13vTwE/kp
         Z7P6WbNBN5QGxl4C0pIu9cernpcXnc3U0bDUDKC7cUEyILrJCgiI4KqTZbgCl22NdsvR
         hy4qkKaCFL8lbo01ggZVZug92uAvn6N3Iphvx+mJoBTD/by1Cymv3QX76PdtFHL6NnGz
         UgPj2blF+BB81VLw/UYrWQ6yf4VXWDfweZlLUR9ZXLWI9a0R42Wr/Zm2dyIX/uC5v35q
         9Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689150519; x=1691742519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKOx3ji7cu7+toV6q7E7Pf07IRWv+R94CaV9atCugGs=;
        b=Ycid7b9aCItpqK1TF+qSqvxO59lgwf+uxbq0Im+gMnhAPZlpQdpn7YEA/cik2rADQg
         5YKNg2wFh0pG0py50x8POFM1kYXqFkwXAlOgkyo5KmV218GohQqVqpt8eHV7ZBRd2t+x
         K50uVst76X0b3L6XNWqZldeVLfLqOFc7B8eOHiVe3WSjeUFF+Jt7F+4abhWJbcxpWFEs
         Blg/jIXTXfNXVAtux6+Fmo1+nacrZYVQKtuiqzei362PKVgwAWueO3KuLdNRjR3E/8iF
         4VmFBRviGvDwfwEokUgGzHmozCMU3fo6/7ejU8ic9pWfG1o9LNEPAk4IJBjyoq8NfmTJ
         L8gg==
X-Gm-Message-State: ABy/qLZ6AS/hFxMNyJc5q0lleIUlFfHxtK1fTKqQYe4fCuU+WZfL+QPT
        vR4+tCgUbQXhIayuC6oM+D5Z/w==
X-Google-Smtp-Source: APBJJlHdDeMBH0AEIZTxQU4jpsr8m+eRG+Yg8zdddAXYZagWOIG9FfOzoEPEuUocaJfqxNtCi4hHrA==
X-Received: by 2002:a05:6808:152a:b0:3a3:ff72:14bf with SMTP id u42-20020a056808152a00b003a3ff7214bfmr9905777oiw.33.1689150518771;
        Wed, 12 Jul 2023 01:28:38 -0700 (PDT)
Received: from [10.254.22.102] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id x16-20020a056a00271000b00672ea40b8a9sm3122098pfv.170.2023.07.12.01.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:28:38 -0700 (PDT)
Message-ID: <2a16a76c-506c-f325-6792-4fb58e8da531@bytedance.com>
Date:   Wed, 12 Jul 2023 16:28:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: kfence: allocate kfence_metadata at runtime
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
 <CANpmjNOHz+dRbJsAyg29nksPMcd2P6109iPxTem_-b2qfUvXtw@mail.gmail.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <CANpmjNOHz+dRbJsAyg29nksPMcd2P6109iPxTem_-b2qfUvXtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/10 18:19, Marco Elver 写道:
> On Mon, 10 Jul 2023 at 05:27, 'Peng Zhang' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>
>> kfence_metadata is currently a static array. For the purpose of
>> allocating scalable __kfence_pool, we first change it to runtime
>> allocation of metadata. Since the size of an object of kfence_metadata
>> is 1160 bytes, we can save at least 72 pages (with default 256 objects)
>> without enabling kfence.
>>
>> Below is the numbers obtained in qemu (with default 256 objects).
>> before: Memory: 8134692K/8388080K available (3668K bss)
>> after: Memory: 8136740K/8388080K available (1620K bss)
>> More than expected, it saves 2MB memory.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> 
> Seems like a reasonable optimization, but see comments below.
> 
> Also with this patch applied on top of v6.5-rc1, KFENCE just doesn't
> init at all anymore (early init). Please fix.
I'm very sorry because I made a slight modification before sending the
patch but it has not been tested, which caused it to not work properly.
I fixed some of the issues you mentioned in v2[1].

[1] 
https://lore.kernel.org/lkml/20230712081616.45177-1-zhangpeng.00@bytedance.com/

> 
>> ---
>>   mm/kfence/core.c   | 102 ++++++++++++++++++++++++++++++++-------------
>>   mm/kfence/kfence.h |   5 ++-
>>   2 files changed, 78 insertions(+), 29 deletions(-)
>>
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index dad3c0eb70a0..b9fec1c46e3d 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -116,7 +116,7 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>>    * backing pages (in __kfence_pool).
>>    */
>>   static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
>> -struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
>> +struct kfence_metadata *kfence_metadata;
>>
>>   /* Freelist with available objects. */
>>   static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
>> @@ -643,13 +643,56 @@ static unsigned long kfence_init_pool(void)
>>          return addr;
>>   }
>>
>> +static int kfence_alloc_metadata(void)
>> +{
>> +       unsigned long nr_pages = KFENCE_METADATA_SIZE / PAGE_SIZE;
>> +
>> +#ifdef CONFIG_CONTIG_ALLOC
>> +       struct page *pages;
>> +
>> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node,
>> +                                  NULL);
>> +       if (pages)
>> +               kfence_metadata = page_to_virt(pages);
>> +#else
>> +       if (nr_pages > MAX_ORDER_NR_PAGES) {
>> +               pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
> 
> Does this mean that KFENCE won't work at all if we can't allocate the
> metadata? I.e. it won't work either in early nor late init modes?
> 
> I know we already have this limitation for _late init_ of the KFENCE pool.
> 
> So I have one major question: when doing _early init_, what is the
> maximum size of the KFENCE pool (#objects) with this change?
It will be limited to 2^10/sizeof(struct kfence_metadata) by buddy
system, so I used memblock to allocate kfence_metadata in v2.
> 
>> +               return -EINVAL;
>> +       }
>> +       kfence_metadata = alloc_pages_exact(KFENCE_METADATA_SIZE,
>> +                                           GFP_KERNEL);
>> +#endif
>> +
>> +       if (!kfence_metadata)
>> +               return -ENOMEM;
>> +
>> +       memset(kfence_metadata, 0, KFENCE_METADATA_SIZE);
> 
> memzero_explicit, or pass __GFP_ZERO to alloc_pages?
Unfortunately, __GFP_ZERO does not work successfully in
alloc_contig_pages(), so I used memzero_explicit() in v2.
Even though I don't know if memzero_explicit() is necessary
(it just uses the barrier).
> 
>> +       return 0;
>> +}
>> +
>> +static void kfence_free_metadata(void)
>> +{
>> +       if (WARN_ON(!kfence_metadata))
>> +               return;
>> +#ifdef CONFIG_CONTIG_ALLOC
>> +       free_contig_range(page_to_pfn(virt_to_page((void *)kfence_metadata)),
>> +                         KFENCE_METADATA_SIZE / PAGE_SIZE);
>> +#else
>> +       free_pages_exact((void *)kfence_metadata, KFENCE_METADATA_SIZE);
>> +#endif
>> +       kfence_metadata = NULL;
>> +}
>> +
>>   static bool __init kfence_init_pool_early(void)
>>   {
>> -       unsigned long addr;
>> +       unsigned long addr = (unsigned long)__kfence_pool;
>>
>>          if (!__kfence_pool)
>>                  return false;
>>
>> +       if (!kfence_alloc_metadata())
>> +               goto free_pool;
>> +
>>          addr = kfence_init_pool();
>>
>>          if (!addr) {
>> @@ -663,6 +706,7 @@ static bool __init kfence_init_pool_early(void)
>>                  return true;
>>          }
>>
>> +       kfence_free_metadata();
>>          /*
>>           * Only release unprotected pages, and do not try to go back and change
>>           * page attributes due to risk of failing to do so as well. If changing
>> @@ -670,31 +714,12 @@ static bool __init kfence_init_pool_early(void)
>>           * fails for the first page, and therefore expect addr==__kfence_pool in
>>           * most failure cases.
>>           */
>> +free_pool:
>>          memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>>          __kfence_pool = NULL;
>>          return false;
>>   }
>>
>> -static bool kfence_init_pool_late(void)
>> -{
>> -       unsigned long addr, free_size;
>> -
>> -       addr = kfence_init_pool();
>> -
>> -       if (!addr)
>> -               return true;
>> -
>> -       /* Same as above. */
>> -       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
>> -#ifdef CONFIG_CONTIG_ALLOC
>> -       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
>> -#else
>> -       free_pages_exact((void *)addr, free_size);
>> -#endif
>> -       __kfence_pool = NULL;
>> -       return false;
>> -}
>> -
>>   /* === DebugFS Interface ==================================================== */
>>
>>   static int stats_show(struct seq_file *seq, void *v)
>> @@ -896,6 +921,10 @@ void __init kfence_init(void)
>>   static int kfence_init_late(void)
>>   {
>>          const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
>> +       unsigned long addr = (unsigned long)__kfence_pool;
>> +       unsigned long free_size = KFENCE_POOL_SIZE;
>> +       int ret;
>> +
>>   #ifdef CONFIG_CONTIG_ALLOC
>>          struct page *pages;
>>
>> @@ -913,15 +942,29 @@ static int kfence_init_late(void)
>>                  return -ENOMEM;
>>   #endif
>>
>> -       if (!kfence_init_pool_late()) {
>> -               pr_err("%s failed\n", __func__);
>> -               return -EBUSY;
>> +       ret = kfence_alloc_metadata();
>> +       if (!ret)
>> +               goto free_pool;
>> +
>> +       addr = kfence_init_pool();
>> +       if (!addr) {
>> +               kfence_init_enable();
>> +               kfence_debugfs_init();
>> +               return 0;
>>          }
>>
>> -       kfence_init_enable();
>> -       kfence_debugfs_init();
>> +       pr_err("%s failed\n", __func__);
>> +       kfence_free_metadata();
>> +       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
>> +       ret = -EBUSY;
>>
>> -       return 0;
>> +free_pool:
>> +#ifdef CONFIG_CONTIG_ALLOC
>> +       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
>> +#else
>> +       free_pages_exact((void *)addr, free_size);
>> +#endif
> 
> You moved this from kfence_init_pool_late - that did "__kfence_pool =
> NULL" which is missing now.
Thanks for spotting this, I added it in v2.
