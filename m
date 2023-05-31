Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBF717CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjEaKES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjEaKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:04:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8237412E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:04:12 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxJvGZG3dkJ+0CAA--.6587S3;
        Wed, 31 May 2023 18:04:09 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqraYG3dkNzWCAA--.15770S3;
        Wed, 31 May 2023 18:04:09 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch: Add support to clone a time namespace
To:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
References: <1685519761-20425-1-git-send-email-yangtiezhu@loongson.cn>
 <87bki0hn4y.ffs@tglx>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d9684f7b-871a-e759-d6b8-4556719702a1@loongson.cn>
Date:   Wed, 31 May 2023 18:04:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <87bki0hn4y.ffs@tglx>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxqraYG3dkNzWCAA--.15770S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CF4rKw4kJw1fuFWfKFW8Xrb_yoW8Gry7pF
        yIgFZ3Ka1kWF1UtF9rJan3WFyrtrs3JrW5GFyYq348CayfZFyDXr18ta18XFyrtrn8ZryF
        va4rJr43X34UAaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/31/2023 05:21 PM, Thomas Gleixner wrote:
> On Wed, May 31 2023 at 15:56, Tiezhu Yang wrote:
>> When execute the following command to test clone3 on LoongArch:
>>
>>   # cd tools/testing/selftests/clone3 && make && ./clone3
>>
>> we can see the following error info:
>>
>>   # [5719] Trying clone3() with flags 0x80 (size 0)
>>   # Invalid argument - Failed to create new process
>>   # [5719] clone3() with flags says: -22 expected 0
>>   not ok 18 [5719] Result (-22) is different than expected (0)
>>
>> This is because if CONFIG_TIME_NS is not set, but the flag
>> CLONE_NEWTIME (0x80) is used to clone a time namespace, it
>> will return -EINVAL in copy_time_ns().
>
> Which means that test case is broken.
>
>> With this patch, the following failed test can be fixed too:
>
> You cannot fix a broken test case by enabling functionality which
> is not guaranteed to be available on all platforms.
>
> Adding time name spaces on loongarch is a completely separate issue and
> has absolutely nothing to do with broken test cases.
>
> They are still broken when CONFIG_TIME_NS is disabled in Kconfig, no?
>
> So this wants to be two separate things:
>
>    1) Fix the broken test cases so they handle CONFIG_TIME_NS=n
>       situations correctly
>
>    2) Add support for TIME_NS to loongarch
>


Thanks for your reply and detailed suggestions,
I will do it in the next version.

Thanks,
Tiezhu

