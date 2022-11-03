Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17768617DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKCNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKCNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:24:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EA60C53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:24:48 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx3NgfwWNjgj0EAA--.14659S3;
        Thu, 03 Nov 2022 21:24:47 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFccwWNjTA0MAA--.16617S3;
        Thu, 03 Nov 2022 21:24:44 +0800 (CST)
Subject: Re: [PATCH v3] checksyscalls: Ignore fstat to silence build warning
 on LoongArch
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn>
 <f794e452-eb04-88df-afa8-991bd40eb3d6@loongson.cn>
 <6ef6686dea98a65176af01f518d30727bde9b2b7.camel@xry111.site>
 <23cb8d88-f18c-cd6d-a0b8-6c7c8c47ad8b@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <410dcaaf-722c-50ee-9fec-6c80db068eff@loongson.cn>
Date:   Thu, 3 Nov 2022 21:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <23cb8d88-f18c-cd6d-a0b8-6c7c8c47ad8b@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxiFccwWNjTA0MAA--.16617S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJF18ArWUWFyDKrWDtr1rXrb_yoW8Aw18pa
        48Aan8Zr48JFy8Aan2k3yxZFyFv3sxA3s3Wrn8Xwn8Arn0qFn3JrySvay5urnFgr1Ykr12
        93Z7W34xZFWjyFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 10/12/2022 02:19 PM, Tiezhu Yang wrote:
>
> Cc KERNEL BUILD maintainers:
>
> Masahiro Yamada <masahiroy@kernel.org>
> Michal Marek <michal.lkml@markovi.net>
> Nick Desaulniers <ndesaulniers@google.com>
>
> On 10/09/2022 10:01 PM, Xi Ruoyao wrote:
>> On Sun, 2022-10-09 at 12:33 +0800, Tiezhu Yang wrote:
>>>
>>>
>>> On 08/30/2022 11:27 AM, Tiezhu Yang wrote:
>>>> fstat is replaced by statx on the new architecture, so an exception
>>>> is added to the checksyscalls script to silence the following build
>>>> warning on LoongArch:
>>>>
>>>>   CALL    scripts/checksyscalls.sh
>>>> <stdin>:569:2: warning: #warning syscall fstat not implemented [-
>>>> Wcpp]
>>>
>>> Hi all,
>>>
>>> The above warning still exists when build the latest loongarch-next.
>>>
>>> Do you know which tree this patch will go through?
>>>
>>> Could you please pick it up via your tree in this merge window?
>>
>> A similar change 3ef6ca4f354c ("checksyscalls: Unconditionally ignore
>> fstat{,at}64") was merged through RISC-V tree, so it should be OK to
>> merge this from loongarch-next.
>>
>> Not sure if we need to get an Ack from someone first though.
>>
>
> Since this is a kernel build warning, maybe it is proper through
> linux-kbuild.git.
>
> https://lore.kernel.org/lkml/1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn/
>
>
> Thanks,
> Tiezhu

The build warning still exists when build the latest Linux 6.1-rc3 on
LoongArch, if you are OK with this change, please apply it through your
mm tree, thank you.

"If you cannot find a maintainer for the subsystem you are working on,
Andrew Morton (akpm@linux-foundation.org) serves as a maintainer of
last resort."
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks,
Tiezhu

