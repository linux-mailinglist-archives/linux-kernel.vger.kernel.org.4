Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E869774C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBOHXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOHXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:23:08 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7782128222
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:23:05 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8Cxf9tXiOxjedcAAA--.2283S3;
        Wed, 15 Feb 2023 15:23:03 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC75WiOxjQawzAA--.30175S3;
        Wed, 15 Feb 2023 15:23:03 +0800 (CST)
Subject: Re: "kernel ade access" oops on LoongArch
To:     Xi Ruoyao <xry111@xry111.site>
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
 <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
 <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <9a70e89c-0f3b-0660-501e-3292e410cfd8@loongson.cn>
Date:   Wed, 15 Feb 2023 15:23:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxC75WiOxjQawzAA--.30175S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZFy7CFW8GFWDGF1DKryDJrb_yoW8CF18pr
        WayryFgFW8AFyftrW2v3yUCF1rJw4UG347Gw43JwsIvFsxXFy3tay3tFyFgw42yas5X3Wj
        grWkKFW5C3W8Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bOxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
        zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWl
        kUUUUU=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2023 01:35 PM, Xi Ruoyao wrote:
> On Wed, 2023-02-15 at 12:52 +0800, Youling Tang wrote:
>> ../stdlib/stdlib.h:141:8: error: ‘_Float32’ does not name a type
>>    141 | extern _Float32 strtof32 (const char *__restrict __nptr,
>>        |        ^~~~~~~~
>
> This is because Glibc expects GCC 13 to support _Float32, but early GCC
> 13 snapshots did not.
>
>> /usr/bin/ld: /home/loongson/build_glibc/libc.a(dl-reloc-static-pie.o):
>> in function `_dl_relocate_static_pie':
>> /home/loongson/glibc/elf/dl-reloc-static-pie.c:44: undefined reference
>> to `_DYNAMIC'
>
> Oh, this one is my fault.  The check for compiler static PIE support was
> not written correctly.  I'll fix it for Glibc later, but now you can
> update GCC to the latest git master to proceed.
>

Tested on Loongson-3C5000L-LL machine, using CLFS7.3 system.

$ gcc -v
gcc version 13.0.0 20221018 (experimental) (GCC)

# make check -j32
/home/loongson/build_glibc/math/test-tgmath3-atan2.c: 
在函数‘test_atan2_84’中:
/home/loongson/build_glibc/math/test-tgmath3-atan2.c:903:59: 
错误：conflicting types for ‘var__Float32x’; have ‘double’
   903 |   extern typeof (atan2 (vol_var__Float32x, vol_var_char)) 
var__Float32x __attribute__ ((unused));
       | 
^~~~~~~~~~~~~

There was a build error in make check, so only tst-mallocfork3-
malloc-check was tested separately.

# make test t=malloc/tst-mallocfork3-malloc-check
make[2]: 离开目录“/home/loongson/glibc/malloc”
PASS: malloc/tst-mallocfork3-malloc-check
original exit status 0
info: signals received during fork: 301
info: signals received during free: 1693
info: signals received during malloc: 119
make[1]: 离开目录“/home/loongson/glibc”

A total of five tests are PASS, and the serial port does not display
CallTrace.

Youling.

