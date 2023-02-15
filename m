Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684B1697799
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjBOHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBOHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:52:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01DEA6E96
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:52:00 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Axbdoej+xjWdkAAA--.2256S3;
        Wed, 15 Feb 2023 15:51:58 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxqb0cj+xjgrEzAA--.30885S3;
        Wed, 15 Feb 2023 15:51:58 +0800 (CST)
Subject: Re: "kernel ade access" oops on LoongArch
To:     Youling Tang <tangyouling@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
 <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
 <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
 <9a70e89c-0f3b-0660-501e-3292e410cfd8@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <5403e5eb-5792-7d6f-df74-ca3fab82ecd5@loongson.cn>
Date:   Wed, 15 Feb 2023 15:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9a70e89c-0f3b-0660-501e-3292e410cfd8@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dxqb0cj+xjgrEzAA--.30885S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF4xCF1rZrykWrWkCryxGrg_yoW8tF1kpr
        WSy3WFgFW5JFn3ArZIvrWUCFyrA34UG34DGw45GwnxZFZIvryYqa1agF1Fg3y7trZ5W3Wa
        qrWkKay5u3W8GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1D
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
        yTuYvjxU25EfUUUUU
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15 15:23, Youling Tang wrote:

>
>
> On 02/15/2023 01:35 PM, Xi Ruoyao wrote:
>> On Wed, 2023-02-15 at 12:52 +0800, Youling Tang wrote:
>>> ../stdlib/stdlib.h:141:8: error: ‘_Float32’ does not name a type
>>>    141 | extern _Float32 strtof32 (const char *__restrict __nptr,
>>>        |        ^~~~~~~~
>>
>> This is because Glibc expects GCC 13 to support _Float32, but early GCC
>> 13 snapshots did not.
>>
>>> /usr/bin/ld: /home/loongson/build_glibc/libc.a(dl-reloc-static-pie.o):
>>> in function `_dl_relocate_static_pie':
>>> /home/loongson/glibc/elf/dl-reloc-static-pie.c:44: undefined reference
>>> to `_DYNAMIC'
>>
>> Oh, this one is my fault.  The check for compiler static PIE support was
>> not written correctly.  I'll fix it for Glibc later, but now you can
>> update GCC to the latest git master to proceed.
>>
>
> Tested on Loongson-3C5000L-LL machine, using CLFS7.3 system.
>
> $ gcc -v
> gcc version 13.0.0 20221018 (experimental) (GCC)
>
> # make check -j32
> /home/loongson/build_glibc/math/test-tgmath3-atan2.c: 
> 在函数‘test_atan2_84’中:
> /home/loongson/build_glibc/math/test-tgmath3-atan2.c:903:59: 
> 错误：conflicting types for ‘var__Float32x’; have ‘double’
>   903 |   extern typeof (atan2 (vol_var__Float32x, vol_var_char)) 
> var__Float32x __attribute__ ((unused));
>       | ^~~~~~~~~~~~~
>
> There was a build error in make check, so only tst-mallocfork3-
> malloc-check was tested separately.
>
> # make test t=malloc/tst-mallocfork3-malloc-check
> make[2]: 离开目录“/home/loongson/glibc/malloc”
> PASS: malloc/tst-mallocfork3-malloc-check
> original exit status 0
> info: signals received during fork: 301
> info: signals received during free: 1693
> info: signals received during malloc: 119
> make[1]: 离开目录“/home/loongson/glibc”
>
> A total of five tests are PASS, and the serial port does not display
> CallTrace.
>
> Youling.
>
I had test it by using the cmd "while true..." Ruoyao gave on

Loongson-3A5000, CLFS 7.1, 6.2-rc8 kernel with those patches and

6.2-rc7 kernel form loongson-next. No calltrace displayed, either.

Jinyang

