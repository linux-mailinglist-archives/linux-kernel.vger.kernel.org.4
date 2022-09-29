Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587135EF0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiI2InI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiI2InE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:43:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B249133C9B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:43:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s26so853486pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zRUXeBGrdm+W4SozoFQNagGMSf3AZ/P7iSchvgplql8=;
        b=WVSWeyA4RyAyY7N4y8z+HOXHabqc29GlkKtm8nzDDXhhAbO9RcSn+Xs797/9MpRpjD
         KSchlx/85Bub0vCnBfZkQQgHzMPqnl1/syYuSeJhaNyL3HVZ2PbRajFKP1m1vxFvnqwg
         93UCGCHRJfYcBXwzNJkRZ6JQ3o4RONDVcfpIIrXbXYZmNEOKN+vlLoAw7tn/QX0NQpWH
         +C6HOuaXSUMwZvMe5AZzO8ABmJ2H/a7ewr7FrziWSzJQTt1J9CngE4gtVpadXsNMVKoC
         4eEcyl/UNcD8fN/W8r3AuYYAfxivOVHEirkQ3dbI1ba0WDg/xDKQhz2AI59it07rJGb7
         /7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zRUXeBGrdm+W4SozoFQNagGMSf3AZ/P7iSchvgplql8=;
        b=x6SvA8/+FC5G/tm23OBrTYfWc8N4kj3oM3DZgtiWdvJvhsxJb6srvhspnPVoOaR2Cu
         xTq4bgmW+QsBYWc4splkPLdWYyd14C/y4A0yw1zofH0eVFEVKMUYgmJk0xrY8gsRVDZu
         6Lyhp50b5YjaaeLlWWRAlBxBe0iiK2vy0Z9I7WjhAnTu81jRlap6dhlkeYcZgFYYox5D
         ZSuuqJzY+m4l3KZ2/Hh0QIshqtqV/WTMtPAOp+q+I8/iEpGWVhDqAuTWeFi2oC7eP6LI
         deWEl3pDWggD0mpHOP1qOEEL1cWw5BliS1tREinn05mOWtCNM/dzkgTif+ZWNwwqacLT
         kasQ==
X-Gm-Message-State: ACrzQf3Wf8pAzS7F6RmofRMNWurzfYj43Ire3m2N8rjB7TloTStySCsl
        iyGM3InRf1O8w+fuxQ4+cAw9zg==
X-Google-Smtp-Source: AMsMyM428aLUyX58p1hylfJa6MI23IYq3BQcDLSeiUXL5KM503hGet371RV08RU2bQdN1g7OukD0xQ==
X-Received: by 2002:a63:8a43:0:b0:440:34f2:c3c4 with SMTP id y64-20020a638a43000000b0044034f2c3c4mr1962285pgd.408.1664440982814;
        Thu, 29 Sep 2022 01:43:02 -0700 (PDT)
Received: from [10.4.189.225] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id c11-20020a17090a558b00b001fd76f7a0d1sm2872982pji.54.2022.09.29.01.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:43:02 -0700 (PDT)
Message-ID: <9f1d5ffe-840b-f332-559f-81899faf242c@bytedance.com>
Date:   Thu, 29 Sep 2022 16:42:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
Content-Language: en-US
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        maobibo <maobibo@loongson.cn>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, muchun.song@linux.dev, chris@zankel.net,
        jcmvbkbc@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
 <b5823e18-6139-c16e-a2df-1aa3e88927fa@redhat.com>
 <c41a3cb6-aef9-d8a9-ab0b-b9c8013ee1d8@bytedance.com>
 <e5cd4c46-71fd-8edb-098c-2ac839d5c5d2@loongson.cn>
 <d4e4a362-fbf2-7eea-e021-16ae7782e06e@bytedance.com>
 <24f6df23-82cc-1290-e015-cba2a284e060@loongson.cn>
 <b702cc9.d17c.1838865fb5c.Coremail.chenhuacai@loongson.cn>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b702cc9.d17c.1838865fb5c.Coremail.chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 16:38, 陈华才 wrote:
> Hi, all,
> 
> 
>> -----原始邮件-----
>> 发件人: maobibo <maobibo@loongson.cn>
>> 发送时间:2022-09-29 12:05:33 (星期四)
>> 收件人: "Qi Zheng" <zhengqi.arch@bytedance.com>, "David Hildenbrand" <david@redhat.com>, akpm@linux-foundation.org, muchun.song@linux.dev, "陈华才" <chenhuacai@loongson.cn>
>> 抄送: chris@zankel.net, jcmvbkbc@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Muchun Song" <songmuchun@bytedance.com>
>> 主题: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
>>
>>
>>
>> 在 2022/9/29 11:47, Qi Zheng 写道:
>>>
>>>
>>> On 2022/9/29 11:27, maobibo wrote:
>>>> 在 2022/9/29 11:07, Qi Zheng 写道:
>>>>>
>>>>>
>>>>> On 2022/9/26 22:34, David Hildenbrand wrote:
>>>>>> On 26.09.22 13:56, Qi Zheng wrote:
>>>>>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>>>>>> if PTE entry exists") said, we should update local TLB only on the
>>>>>>> second thread. So in the do_anonymous_page() here, we should use
>>>>>>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>>>>>>
>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>>>>> ---
>>>>>>> v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
>>>>>>>
>>>>>>> Changelog in v1 -> v2:
>>>>>>>     - change the subject and commit message (David)
>>>>>>>
>>>>>>>     mm/memory.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index 118e5f023597..9e11c783ba0e 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>> @@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>>>>         vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>>>>>                 &vmf->ptl);
>>>>>>>         if (!pte_none(*vmf->pte)) {
>>>>>>> -        update_mmu_cache(vma, vmf->address, vmf->pte);
>>>>>>> +        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>>>>             goto release;
>>>>>>>         }
>>>>>>
>>>>>>
>>>>>> Staring at 7df676974359, it indeed looks like an accidental use [nothing else in that patch uses update_mmu_cache].
>>>>>>
>>>>>> So it looks good to me, but a confirmation from Bibo Mao might be good.
>>>>>
>>>>> Thanks, and Hi Bibo, any comments here? :)
>>>>
>>>> update_mmu_tlb is defined as empty on loongarch, maybe some lines should
>>>> be added in file arch/loongarch/include/asm/pgtable.h like this:
>>>
>>> Seems like a bug? Because there are many other places where
>>> update_mmu_tlb() is called.
>>>
>>>>
>>>> +#define __HAVE_ARCH_UPDATE_MMU_TLB
>>>> +#define update_mmu_tlb  update_mmu_cache
>>>
>>> If so, I can make the above as a separate fix patch.
>> It sounds good to me.
>>
>> Huacai, do you have any comments?
>  From my point of view, LoongArch need a fix for this.

OK, will do it in the next version. Thanks. :)

> 
> Huacai
>>
>> regards
>> bibo, mao
>>>
>>> Thanks,
>>> Qi
>>>
>>>>
>>>> regards
>>>> bibo mao
>>>>>
>>>>>>
>>>>>
>>>>
>>>
> 
> 
> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it.

-- 
Thanks,
Qi
