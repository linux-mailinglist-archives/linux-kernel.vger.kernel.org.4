Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1D697819
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjBOI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjBOI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:26:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F3C367D3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:26:00 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8Dx1tgTl+xjmdsAAA--.1508S3;
        Wed, 15 Feb 2023 16:25:55 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbL4Sl+xjNrczAA--.30625S3;
        Wed, 15 Feb 2023 16:25:55 +0800 (CST)
Subject: Re: "kernel ade access" oops on LoongArch
To:     Xi Ruoyao <xry111@xry111.site>
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
 <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
 <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
 <9a70e89c-0f3b-0660-501e-3292e410cfd8@loongson.cn>
 <5403e5eb-5792-7d6f-df74-ca3fab82ecd5@loongson.cn>
 <818419c03037bda833a5b281588a4b331c34ae8c.camel@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <74fb1e24-36c0-c642-5bab-3646ba7790df@loongson.cn>
Date:   Wed, 15 Feb 2023 16:25:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <818419c03037bda833a5b281588a4b331c34ae8c.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbL4Sl+xjNrczAA--.30625S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFy8Xw4UKF4rtr48JrWDurg_yoW8WFW3pr
        Wjka40krs8JF9xtayq9w4UCF1rta93Gay5GwnxXay8ZF90yF1YgwsrKF18uw1Iyrn5Wa4S
        9Fykt3ya9F4UAw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bz8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
        zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxV
        AFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvj4RC_MaUUUUU
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2023 04:07 PM, Xi Ruoyao wrote:
> On Wed, 2023-02-15 at 15:51 +0800, Jinyang He wrote:
>
>>> There was a build error in make check, so only tst-mallocfork3-
>>> malloc-check was tested separately.
>>>
>>> # make test t=malloc/tst-mallocfork3-malloc-check
>>> make[2]: 离开目录“/home/loongson/glibc/malloc”
>>> PASS: malloc/tst-mallocfork3-malloc-check
>>> original exit status 0
>>> info: signals received during fork: 301
>>> info: signals received during free: 1693
>>> info: signals received during malloc: 119
>>> make[1]: 离开目录“/home/loongson/glibc”
>>>
>>> A total of five tests are PASS, and the serial port does not display
>>> CallTrace.
>>>
>>> Youling.
>>>
>> I had test it by using the cmd "while true..." Ruoyao gave on
>>
>> Loongson-3A5000, CLFS 7.1, 6.2-rc8 kernel with those patches and
>>
>> 6.2-rc7 kernel form loongson-next. No calltrace displayed, either.
>
> Hmm... I've read the code for a while and I couldn't see how it could
> end up accessing a bad address too.  Maybe my hardware or compiler is
> really faulty?

Can you modify the kernel as follows and test it, so as to avoid
possible relationship with the exception table data link position and
alignment rules (or use EXCEPTION_TABLE(12))?

--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -4,7 +4,6 @@
  #include <asm/thread_info.h>

  #define PAGE_SIZE _PAGE_SIZE
-#define RO_EXCEPTION_TABLE_ALIGN       4

  /*
   * Put .bss..swapper_pg_dir as the first thing in .bss. This will
@@ -54,6 +53,8 @@ SECTIONS
         . = ALIGN(PECOFF_SEGMENT_ALIGN);
         _etext = .;

+       EXCEPTION_TABLE(16)
+

Youling.


