Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B16955F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBNBbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjBNBbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:31:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D7E518AB6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:31:10 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8CxSNld5OpjyFEAAA--.772S3;
        Tue, 14 Feb 2023 09:31:09 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxib1b5OpjgJQyAA--.28695S3;
        Tue, 14 Feb 2023 09:31:07 +0800 (CST)
Message-ID: <ec49593a-60a4-be91-0fb2-af517eaf6d6a@loongson.cn>
Date:   Tue, 14 Feb 2023 09:31:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230209035839.2610277-1-maobibo@loongson.cn>
 <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
 <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
 <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
 <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
 <0fe7ed7c-7161-65d5-a09f-12db6ccda05a@loongson.cn>
 <b17430342e9e4c39b53004d842ea9c55@AcuMS.aculab.com>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <b17430342e9e4c39b53004d842ea9c55@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxib1b5OpjgJQyAA--.28695S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFWUWry3Zr1UAw15Cw4xtFb_yoWrZryrpF
        W5GF1rG3ZrZFn5Jrn7tF47u395Zws5GryUGF45JrWYv3s8CF4ftayDKrZ0vanFkr4SkFya
        v3Wqvw1xWF1DAw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/10 19:08, David Laight 写道:
> From: maobibo
>> Sent: 10 February 2023 10:06
>>
>> With the test cases
>>   https://github.com/bibo-mao/bench/tree/master/csum
>>
>> Tested with different buffer size 4096/1472/250/40, here is the output on my
>> loongarch machine. Loops times is 0x100000, and time cost unit is milliseconds,
>> and the smaller value will be better.
>>
>>
>> buf size[4096] loops[0x100000] times[us]: csum uint128 344473 asm method 373391 uint64 741412
>> buf size[1472] loops[0x100000] times[us]: csum uint128 131849 asm method 138533 uint64 271317
>> buf size[ 250] loops[0x100000] times[us]: csum uint128 34512 asm method 36294 uint64 51576
>> buf size[  40] loops[0x100000] times[us]: csum uint128 12182 asm method 23874 uint64 15769
> 
> What do those work out as in bytes/clock?
> 
> Rather than run 1000s of iterations (and be hit by interrupts etc)
> I sometimes just use an accurate cycle counter and measure the
> time for a single buffer (or varying length).
> Save and print the values of 10 calls and you'll get pretty
> consistent values after the first couple (cold cache).
> Then you can work out how long each iteration of the main loop costs.
> 
> I think you have to execute 4 instructions for each 64bit word.
> One memory read, the main add, a setle and the add of the carry.
> 
> For a simple cpu that is always going to be 4 clocks.
> But if there are delay slots after the memory read you can
> fill them with the alu instructions for an earlier read.
> You also need an add and bne for the address for each iteration.
> So unrolling the loop further will help.
> 
> OTOH if your cpu can execute multiple instructions in one clock
> you can expect to do a lot better.
> With 3 ALU instructions (and one read) you should be able to
> find a code sequence that will run at 8 bytes/clock.
> With 4 ALU it is likely that the loop instructions can also
> execute in parallel - so you don't need massive loop unrolling.
> 
> Unless the cpu is massively 'out of order' (like some x86)
> I'd expect the best code to interleave the reads and alu
> operations for earlier values - rather than having all
> the reads at the top of the loop.
> So the loop would be a repeating pattern of instructions
> with some values being carried between iterations.
Part of asm code depends on previous intr in website
https://github.com/loongson/linux/commit/92a6df48ccb73dd2c3dc1799add08adf0e0b0deb,
such as macro ADDC
#define ADDC(sum,reg)                                           \
        ADD     sum, sum, reg;                                  \
        sltu    t8, sum, reg;                                   \
        ADD     sum, sum, t8;                                   \
these three instructions depends on each other, and can not execute
in parallel. 

The original of main loop about Lmove_128bytes is:
#define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)     \
        LOAD    _t0, src, (offset + UNIT(0));                   \
        LOAD    _t1, src, (offset + UNIT(1));                   \
        LOAD    _t2, src, (offset + UNIT(2));                   \
        LOAD    _t3, src, (offset + UNIT(3));                   \
        ADDC(_t0, _t1);                                         \
        ADDC(_t2, _t3);                                         \
        ADDC(sum, _t0);                                         \
        ADDC(sum, _t2)

.Lmove_128bytes:
        CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
        CSUM_BIGCHUNK(src, 0x20, sum, t0, t1, t3, t4)
        CSUM_BIGCHUNK(src, 0x40, sum, t0, t1, t3, t4)
        CSUM_BIGCHUNK(src, 0x60, sum, t0, t1, t3, t4)
        addi.d  t5, t5, -1
        addi.d  src, src, 0x80
        bnez    t5, .Lmove_128bytes

I modified the main loop with label .Lmove_128bytes to reduce
dependency between instructions like this, it can improve the
performance.
can improve the performance.
.Lmove_128bytes:
        LOAD    t0, src, 0
        LOAD    t1, src, 8
        LOAD    t3, src, 16
        LOAD    t4, src, 24
        LOAD    a3, src, 0 + 0x20
        LOAD    a4, src, 8 + 0x20
        LOAD    a5, src, 16 + 0x20
        LOAD    a6, src, 24 + 0x20
        ADD     t0, t0,  t1
        ADD     t3, t3,  t4
        ADD     a3, a3,  a4
        ADD     a5, a5,  a6
        sltu    t8, t0,  t1
        sltu    a7, t3,  t4
        ADD     t0, t0,  t8
        ADD     t3, t3,  a7
        sltu    t1, a3,  a4
        sltu    t4, a5,  a6
        ADD     a3, a3,  t1
        ADD     a5, a5,  t4
        ADD     t0, t0, t3
        ADD     a3, a3, a5
        sltu    t1, t0, t3
        sltu    t4, a3, a5
        ADD     t0, t0, t1
        ADD     a3, a3, t4
        ADD     sum, sum, t0
        sltu    t8,  sum, t0
        ADD     sum, sum,  t8
        ADD     sum, sum, a3
        sltu    t8,  sum, a3
        addi.d  t5, t5, -1
        ADD     sum, sum, t8

However the result and principle is almost the similar with
uint128 c code. And there is no performance impact interleaving
the reads and alu operations.

Regards
Bibo, Mao

> 
> I doubt you'll get a loop to execute every clock, but
> a two clock loop is entirely possible.
> It rather depends how fast the instruction decoder
> handles the (predicted) branch.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

