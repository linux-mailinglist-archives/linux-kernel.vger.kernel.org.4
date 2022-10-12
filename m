Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4C5FC089
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJLGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJLGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:20:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CCEE604A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:20:19 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+CNXEZj5a8rAA--.27100S3;
        Wed, 12 Oct 2022 14:19:59 +0800 (CST)
Subject: Re: [PATCH v3] checksyscalls: Ignore fstat to silence build warning
 on LoongArch
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>
References: <1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn>
 <f794e452-eb04-88df-afa8-991bd40eb3d6@loongson.cn>
 <6ef6686dea98a65176af01f518d30727bde9b2b7.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <23cb8d88-f18c-cd6d-a0b8-6c7c8c47ad8b@loongson.cn>
Date:   Wed, 12 Oct 2022 14:19:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <6ef6686dea98a65176af01f518d30727bde9b2b7.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxX+CNXEZj5a8rAA--.27100S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4DtF1xKF4UCrW7Gr1xZrb_yoW8JF1fpa
        48ua1kuFs5CFy8AanF93yxuF9Yy3sxAr93WFn8Xws8Arn0vFs5tr1Fqay5uF129rW3KF1j
        9F4vg34IvF1jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8N18PUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc KERNEL BUILD maintainers:

Masahiro Yamada <masahiroy@kernel.org>
Michal Marek <michal.lkml@markovi.net>
Nick Desaulniers <ndesaulniers@google.com>

On 10/09/2022 10:01 PM, Xi Ruoyao wrote:
> On Sun, 2022-10-09 at 12:33 +0800, Tiezhu Yang wrote:
>>
>>
>> On 08/30/2022 11:27 AM, Tiezhu Yang wrote:
>>> fstat is replaced by statx on the new architecture, so an exception
>>> is added to the checksyscalls script to silence the following build
>>> warning on LoongArch:
>>>
>>>   CALL    scripts/checksyscalls.sh
>>> <stdin>:569:2: warning: #warning syscall fstat not implemented [-
>>> Wcpp]
>>
>> Hi all,
>>
>> The above warning still exists when build the latest loongarch-next.
>>
>> Do you know which tree this patch will go through?
>>
>> Could you please pick it up via your tree in this merge window?
>
> A similar change 3ef6ca4f354c ("checksyscalls: Unconditionally ignore
> fstat{,at}64") was merged through RISC-V tree, so it should be OK to
> merge this from loongarch-next.
>
> Not sure if we need to get an Ack from someone first though.
>

Since this is a kernel build warning, maybe it is proper through
linux-kbuild.git.

https://lore.kernel.org/lkml/1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn/

Thanks,
Tiezhu

