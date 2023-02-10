Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736B7691C43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBJKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBJKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:06:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A39430FC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:06:26 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxmOkgF+ZjPMYQAA--.29302S3;
        Fri, 10 Feb 2023 18:06:24 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWL0fF+ZjGVIwAA--.25311S3;
        Fri, 10 Feb 2023 18:06:23 +0800 (CST)
Message-ID: <0fe7ed7c-7161-65d5-a09f-12db6ccda05a@loongson.cn>
Date:   Fri, 10 Feb 2023 18:06:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230209035839.2610277-1-maobibo@loongson.cn>
 <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
 <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
 <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
 <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWL0fF+ZjGVIwAA--.25311S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ww4kCry8Wr4rJF48JrW8JFb_yoW7Ww1xpr
        WxtayUtFs8XF13CF42ga4UZFWYqryfJF15Xry0qr10v3saqrnrtFWkJrW2ka47Jr4rGFyj
        q3Wvv3sIgFnrJ3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8CksDUUUUU==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the test cases
  https://github.com/bibo-mao/bench/tree/master/csum

Tested with different buffer size 4096/1472/250/40, here is the output on my
loongarch machine. Loops times is 0x100000, and time cost unit is milliseconds,
and the smaller value will be better.

 
buf size[4096] loops[0x100000] times[us]: csum uint128 344473 asm method 373391 uint64 741412 
buf size[1472] loops[0x100000] times[us]: csum uint128 131849 asm method 138533 uint64 271317 
buf size[ 250] loops[0x100000] times[us]: csum uint128 34512 asm method 36294 uint64 51576 
buf size[  40] loops[0x100000] times[us]: csum uint128 12182 asm method 23874 uint64 15769 


Regards
Bibo, Mao

在 2023/2/10 11:21, Huacai Chen 写道:
> This commit comes from the old internal kernel, I want to know which
> one has better performance.
> 
> https://github.com/loongson/linux/commit/92a6df48ccb73dd2c3dc1799add08adf0e0b0deb
> 
> On Thu, Feb 9, 2023 at 8:39 PM David Laight <David.Laight@aculab.com> wrote:
>>
>> From: maobibo
>>> Sent: 09 February 2023 11:55
>>>
>>>
>>> 在 2023/2/9 17:35, David Laight 写道:
>>>> From: Bibo Mao
>>>>> Sent: 09 February 2023 03:59
>>>>>
>>>>> loongArch platform is 64-bit system, which supports 8 bytes memory
>>>>> accessing, generic checksum function uses 4 byte memory access.
>>>>> This patch adds 8-bytes memory access optimization for checksum
>>>>> function on loongArch. And the code comes from arm64 system.
>>>>
>>>> How fast do these functions actually run (in bytes/clock)?
>>> With uint128 method, there will unrolled loop, instruction
>>> can execute in parallel. It gets the best result on loongarch
>>> system where there is no neither carry flag nor post-index
>>> addressing modes.
>>
>> We're probably almost agreeing...
>>
>>> Here is the piece of disassemble code with uint128 method:
>>
>> Load 8 values:
>>
>>>    120000a40:   28c0222f        ld.d    $r15,$r17,8(0x8)
>>>    120000a44:   28c0622a        ld.d    $r10,$r17,24(0x18)
>>>    120000a48:   28c0a230        ld.d    $r16,$r17,40(0x28)
>>>    120000a4c:   28c0e232        ld.d    $r18,$r17,56(0x38)
>>>    120000a50:   28c0022e        ld.d    $r14,$r17,0
>>>    120000a54:   28c0422d        ld.d    $r13,$r17,16(0x10)
>>>    120000a58:   28c0822b        ld.d    $r11,$r17,32(0x20)
>>>    120000a5c:   28c0c22c        ld.d    $r12,$r17,48(0x30)
>>
>> Pairwise add them
>>
>>>    120000a60:   0010b9f7        add.d   $r23,$r15,$r14
>>>    120000a64:   0010b54d        add.d   $r13,$r10,$r13
>>>    120000a68:   0010b24c        add.d   $r12,$r18,$r12
>>>    120000a6c:   0010ae0b        add.d   $r11,$r16,$r11
>>
>> Generate 4 'carry' bits
>>
>>>    120000a70:   0012c992        sltu    $r18,$r12,$r18
>>>    120000a74:   0012beee        sltu    $r14,$r23,$r15
>>>    120000a78:   0012c170        sltu    $r16,$r11,$r16
>>>    120000a7c:   0012a9aa        sltu    $r10,$r13,$r10
>>
>> Add the carry bits onto the sums.
>> I've not quite worked out which add is which!
>> But I think you've missed a few adds here.
>>
>>>    120000a80:   0010ae0f        add.d   $r15,$r16,$r11
>>>    120000a84:   0010ddce        add.d   $r14,$r14,$r23
>>>    120000a88:   0010b250        add.d   $r16,$r18,$r12
>>>    120000a8c:   0010b54d        add.d   $r13,$r10,$r13
>>>    120000a90:   0010b5d2        add.d   $r18,$r14,$r13
>>>    120000a94:   0010c1f0        add.d   $r16,$r15,$r16
>>
>> Somewhere each value needs an add, an sltu to generate the 'carry',
>> and an add for the carry itself.
>> If you sum the carry bits into a separate register it is
>> possible to get a both adds and the sltu (for different values)
>> to run in the same clock (on a suitable cpu).
>> If there are 4 integer units you can also get the loop instructions
>> 'for free' and unrolling 8 times may not be needed at all.
>>
>> ...
>>> There is no post-index addressing modes on loongarch,
>>>       val = *mem;  // 64bit read
>>>         mem++;
>>>       sum += val;
>>>       carry = sum < val;
>>>       carry_sum += carry;
>>> it takes 5 instruction and these 5 instructions depends on previous instr.
>>
>> I'd assume the loop was unrolled enough so the address
>> increment doesn't matter.
>>
>>> There is the piece of disassemble code:
>>>    120000d90:   28c001f0        ld.d    $r16,$r15,0
>>>    120000d94:   0010c58c        add.d   $r12,$r12,$r17
>>>    120000d98:   02c021ef        addi.d  $r15,$r15,8(0x8)
>>
>> Those three instructions are independent.
>>
>>>    120000d9c:   0010b20c        add.d   $r12,$r16,$r12
>>
>> that one depends on the ld.d
>>
>>>    120000da0:   0012c191        sltu    $r17,$r12,$r16
>>
>> that depends on the add.d
>> but it could be execute after the 'bne' in parallel with the ld.d
>>
>>>    120000da4:   5fffedf2        bne     $r15,$r18,-20(0x3ffec) # 120000d90 <do_csum_64+0x90>
>>
>> If you tweak the code it is possible to get down to just
>> the addi.d and bne constraining the dependency chain.
>> (Assuming there is no delay on the read and there are an infinite
>> number of execution units.)
>> Unroll once and do:
>>         ld.d r,addr,0
>>         addi.d addr,16
>>         ld.d r,addr,-8
>>         bne addr,limit,loop_top
>> and you might get a loop that does a memory read every clock.
>>
>> So you end up worrying about how the memory read delays affect
>> the instruction pipeline.
>> The Intel x86 cpu I've got just pile up the arithmetic instructions
>> waiting for the data to be read.
>> If you get a memory read requested every clock everything else
>> follows - provided you don't try to execute too many instrcutions
>> at once.
>>
>>         David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>> Registration No: 1397386 (Wales)

