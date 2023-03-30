Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F466CF902
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjC3CGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC3CGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:06:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 629F81BC;
        Wed, 29 Mar 2023 19:06:06 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxrtqM7iRkTykUAA--.19332S3;
        Thu, 30 Mar 2023 10:06:04 +0800 (CST)
Received: from [10.130.0.102] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHL6I7iRkjugQAA--.13156S3;
        Thu, 30 Mar 2023 10:06:03 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
References: <20230328111714.2056-1-zhangqing@loongson.cn>
 <CA+fCnZevgYh7CzJ9gOWJ80SwY4Y9w8UO2ZiFAXEnAhQhFgrffA@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <dccfbff3-7bad-de33-4d96-248bdff44a8b@loongson.cn>
Date:   Thu, 30 Mar 2023 10:06:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CA+fCnZevgYh7CzJ9gOWJ80SwY4Y9w8UO2ZiFAXEnAhQhFgrffA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHL6I7iRkjugQAA--.13156S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gw4rZr1UJF48tw1rtF1UJrb_yoW7WF4fpF
        yDGFy8AF4IqF1qga9rAr1Uur1UJwnak3WxKFs09r4rCa4UWrykJFyDWF9Iyrn3urW7AFya
        yws3Wa9xAw4jq3DanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrey
On 2023/3/30 上午3:02, Andrey Konovalov wrote:
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index f7ef70661ce2..3b91b941873d 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -54,11 +54,13 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>>   int kasan_populate_early_shadow(const void *shadow_start,
>>                                  const void *shadow_end);
>>
>> +#ifndef __HAVE_ARCH_SHADOW_MAP
>>   static inline void *kasan_mem_to_shadow(const void *addr)
>>   {
>>          return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>>                  + KASAN_SHADOW_OFFSET;
>>   }
>> +#endif
>>
>>   int kasan_add_zero_shadow(void *start, unsigned long size);
>>   void kasan_remove_zero_shadow(void *start, unsigned long size);
>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>> index e5eef670735e..f86194750df5 100644
>> --- a/mm/kasan/generic.c
>> +++ b/mm/kasan/generic.c
>> @@ -175,6 +175,11 @@ static __always_inline bool check_region_inline(unsigned long addr,
>>          if (unlikely(!addr_has_metadata((void *)addr)))
>>                  return !kasan_report(addr, size, write, ret_ip);
>>
>> +#ifndef __HAVE_ARCH_SHADOW_MAP
>> +       if (unlikely(kasan_mem_to_shadow((unsigned long *)addr) == NULL))
>> +               return !kasan_report(addr, size, write, ret_ip);
>> +#endif
> 
> This should have been ifdef, right?
> 
Sorry, it was a clerical error,
Here it is
#ifndef __HAVE_ARCH_SHADOW_MAP
if (unlikely(! addr_has_metadata((void *)addr)))
return ! kasan_report(addr, size, write, ret_ip);
#else
if (unlikely(kasan_mem_to_shadow((void *)addr) == NULL)) {
kasan_report(addr, size, write, ret_ip);
return;
}
#endif
> But I don't think you need this check here at all: addr_has_metadata
> already checks that shadow exists.
> 
On LongArch, there's a lot of holes between different segments, so kasan
shadow area is some different type of memory that we concatenate, we
can't use if (unlikely((void *)addr <
kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) to determine the
validity, and in arch/loongarch/include/asm/kasan.h I construct invalid
NULL.
>> +
>>          if (likely(!memory_is_poisoned(addr, size)))
>>                  return true;
>>
>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>> index cc64ed6858c6..860061a22ca9 100644
>> --- a/mm/kasan/init.c
>> +++ b/mm/kasan/init.c
>> @@ -166,8 +166,9 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
>>                                  if (!p)
>>                                          return -ENOMEM;
>>                          } else {
>> -                               pud_populate(&init_mm, pud,
>> -                                       early_alloc(PAGE_SIZE, NUMA_NO_NODE));
>> +                               p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>> +                               pmd_init(p);
>> +                               pud_populate(&init_mm, pud, p);
>>                          }
>>                  }
>>                  zero_pmd_populate(pud, addr, next);
>> @@ -207,8 +208,9 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>>                                  if (!p)
>>                                          return -ENOMEM;
>>                          } else {
>> -                               p4d_populate(&init_mm, p4d,
>> -                                       early_alloc(PAGE_SIZE, NUMA_NO_NODE));
>> +                               p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>> +                               pud_init(p);
>> +                               p4d_populate(&init_mm, p4d, p);
> 
> Please explain why these changes are needed in the patch description.

This is because in pagetable_init on loongarch/mips, we populate pmd/pud
with invalid_pmd_table/invalid_pud_table,
So pmd_init/pud_init(p) is required, perhaps we define them as __weak in
mm/kasan/init.c, like mm/sparse-vmemmap.c.

diff --git a/include/linux/mm.h  b/include/linux/mm.h
...
+void pmd_init(void *addr);
+void pud_init(void *addr);
...
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
...
+void __weak __meminit pmd_init(void *addr)
+ {
+}
+
@@-203,11 +207,16 @@pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, 
unsigned long addr, int node)
void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
if (! p)
return NULL;
+               pmd_init(p);
pud_populate(&init_mm, pud, p);
}
return pud;
}
+void __weak __meminit pud_init(void *addr)
+ {
+}
+
p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, 
int node)
{
p4d_t *p4d = p4d_offset(pgd, addr);
@@-215,6 +224,7 @@p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, 
unsigned long addr, int node)
void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
if (! p)
return NULL;
+               pud_init(p);
p4d_populate(&init_mm, p4d, p);
}
return p4d;

Thanks,
- Qing
> 
>>                          }
>>                  }
>>                  zero_pud_populate(p4d, addr, next);
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index a61eeee3095a..033335c13b25 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -291,16 +291,22 @@ struct kasan_stack_ring {
>>
>>   #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>>
>> +#ifndef __HAVE_ARCH_SHADOW_MAP
>>   static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>>   {
>>          return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
>>                  << KASAN_SHADOW_SCALE_SHIFT);
>>   }
>> +#endif
>>
>>   static __always_inline bool addr_has_metadata(const void *addr)
>>   {
>> +#ifdef __HAVE_ARCH_SHADOW_MAP
>> +       return (kasan_mem_to_shadow((void *)addr) != NULL);
>> +#else
>>          return (kasan_reset_tag(addr) >=
>>                  kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
>> +#endif
>>   }
>>
>>   /**
>> --
>> 2.20.1
>>

