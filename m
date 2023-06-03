Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD80A720D1B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbjFCCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCCHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:07:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B10DE4D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:07:52 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.100.1])
        by gateway (Coremail) with SMTP id _____8Dx9fB3oHpkQNMDAA--.8409S3;
        Sat, 03 Jun 2023 10:07:51 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.100.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxXrN2oHpkEbyGAA--.22083S3;
        Sat, 03 Jun 2023 10:07:50 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch: Add support to clone a time namespace
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1685519761-20425-1-git-send-email-yangtiezhu@loongson.cn>
 <87bki0hn4y.ffs@tglx> <d9684f7b-871a-e759-d6b8-4556719702a1@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <cc45475e-3d87-efa5-1c3a-c2c70d6aca94@loongson.cn>
Date:   Sat, 3 Jun 2023 10:07:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d9684f7b-871a-e759-d6b8-4556719702a1@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxXrN2oHpkEbyGAA--.22083S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr1UCFWfAryUuFWxJF4UXFb_yoW8Cw47pF
        97Wan8Kw4kWF15tF9rt3WDXFyrKws3ZFWUWryYv348CasY9wn5Jr48t3y8uFyrJr1kJ34I
        v348trWa934UAaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU89iSPUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu

On 05/31/2023 06:04 PM, Tiezhu Yang wrote:
>
>
> On 05/31/2023 05:21 PM, Thomas Gleixner wrote:
>> On Wed, May 31 2023 at 15:56, Tiezhu Yang wrote:
>>> When execute the following command to test clone3 on LoongArch:
>>>
>>>   # cd tools/testing/selftests/clone3 && make && ./clone3
>>>
>>> we can see the following error info:
>>>
>>>   # [5719] Trying clone3() with flags 0x80 (size 0)
>>>   # Invalid argument - Failed to create new process
>>>   # [5719] clone3() with flags says: -22 expected 0
>>>   not ok 18 [5719] Result (-22) is different than expected (0)
>>>
>>> This is because if CONFIG_TIME_NS is not set, but the flag
>>> CLONE_NEWTIME (0x80) is used to clone a time namespace, it
>>> will return -EINVAL in copy_time_ns().
>>
>> Which means that test case is broken.
>>
>>> With this patch, the following failed test can be fixed too:
>>
>> You cannot fix a broken test case by enabling functionality which
>> is not guaranteed to be available on all platforms.
>>
>> Adding time name spaces on loongarch is a completely separate issue and
>> has absolutely nothing to do with broken test cases.
>>
>> They are still broken when CONFIG_TIME_NS is disabled in Kconfig, no?
>>
>> So this wants to be two separate things:
>>
>>    1) Fix the broken test cases so they handle CONFIG_TIME_NS=n
>>       situations correctly
>>
>>    2) Add support for TIME_NS to loongarch
>>

With this patch, we should also modify the stack_top() implementation,
because the vvar size is not PAGE_SIZE at this time.

'maps' before the patch,
  # sudo cat /proc/1/maps
  ...
  7ffffbec8000-7ffffbeec000 rw-p 00000000 00:00 0 
   [stack]
  7ffffc7d8000-7ffffc7dc000 r--p 00000000 00:00 0 
   [vvar]
  7ffffc7dc000-7ffffc7e0000 r-xp 00000000 00:00 0 
   [vdso]

STACK_TOP = TASK_SIZE - PAGE_ALIGN(current->thread.vdso->size) - VVAR_SIZE

Thanks,
Youling.

>
>
> Thanks for your reply and detailed suggestions,
> I will do it in the next version.
>
> Thanks,
> Tiezhu
>

