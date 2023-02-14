Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B369666E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjBNOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjBNOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:19:38 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3580923C44
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:19:16 -0800 (PST)
Received: from loongson.cn (unknown [106.39.149.70])
        by gateway (Coremail) with SMTP id _____8BxddhfmOtjpY4AAA--.831S3;
        Tue, 14 Feb 2023 22:19:11 +0800 (CST)
Received: from [192.168.3.5] (unknown [106.39.149.70])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxg+VdmOtjJ+IyAA--.60883S3;
        Tue, 14 Feb 2023 22:19:09 +0800 (CST)
Message-ID: <0d591c10-e897-d00a-dbf0-a069389ef196@loongson.cn>
Date:   Tue, 14 Feb 2023 22:19:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
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
 <ec49593a-60a4-be91-0fb2-af517eaf6d6a@loongson.cn>
 <5dc1c39bbaf149f78c132f4467cdb365@AcuMS.aculab.com>
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <5dc1c39bbaf149f78c132f4467cdb365@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxg+VdmOtjJ+IyAA--.60883S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr1DJw45Ar13XFWDWFykXwb_yoW5KFWkpr
        yUGwn5Aa1vyFn3Ar17AF4jkrWF93Z8GrWDCFy3trW2kFy8GF1rtFZrKFn0yas7ur1FkFn8
        Z34j9wn3uryDAF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 17:47, David Laight wrote:
> From: maobibo
>> Sent: 14 February 2023 01:31
> ...
>> Part of asm code depends on previous intr in website
>> https://github.com/loongson/linux/commit/92a6df48ccb73dd2c3dc1799add08adf0e0b0deb,
>> such as macro ADDC
>> #define ADDC(sum,reg)                                           \
>>          ADD     sum, sum, reg;                                  \
>>          sltu    t8, sum, reg;                                   \
>>          ADD     sum, sum, t8;                                   \
>> these three instructions depends on each other, and can not execute
>> in parallel.
> 
> Right, but you can add the carry bits into a different register.
> Since the aim is 8 bytes/clock limited by 1 memory read/clock
> you can (probably) manage with all the word adds going to one
> register and all the carry adds to a second. So:
> #define ADDC(carry, sum, reg) \
> 	add	sum, sum, reg	\
> 	sltu	reg, sum, reg	\
> 	add	carry, carry, reg
> 
>>
>> The original of main loop about Lmove_128bytes is:
>> #define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)     \
>>          LOAD    _t0, src, (offset + UNIT(0));                   \
>>          LOAD    _t1, src, (offset + UNIT(1));                   \
>>          LOAD    _t2, src, (offset + UNIT(2));                   \
>>          LOAD    _t3, src, (offset + UNIT(3));                   \
>>          ADDC(_t0, _t1);                                         \
>>          ADDC(_t2, _t3);                                         \
>>          ADDC(sum, _t0);                                         \
>>          ADDC(sum, _t2)
>>
>> .Lmove_128bytes:
>>          CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
>>          CSUM_BIGCHUNK(src, 0x20, sum, t0, t1, t3, t4)
>>          CSUM_BIGCHUNK(src, 0x40, sum, t0, t1, t3, t4)
>>          CSUM_BIGCHUNK(src, 0x60, sum, t0, t1, t3, t4)
>>          addi.d  t5, t5, -1
>>          addi.d  src, src, 0x80
>>          bnez    t5, .Lmove_128bytes
>>
>> I modified the main loop with label .Lmove_128bytes to reduce
>> dependency between instructions like this, it can improve the
>> performance.
>> can improve the performance.
>> .Lmove_128bytes:
>>          LOAD    t0, src, 0
>>          LOAD    t1, src, 8
>>          LOAD    t3, src, 16
>>          LOAD    t4, src, 24
>>          LOAD    a3, src, 0 + 0x20
>>          LOAD    a4, src, 8 + 0x20
>>          LOAD    a5, src, 16 + 0x20
>>          LOAD    a6, src, 24 + 0x20
>>          ADD     t0, t0,  t1
>>          ADD     t3, t3,  t4
>>          ADD     a3, a3,  a4
>>          ADD     a5, a5,  a6
>>          sltu    t8, t0,  t1
>>          sltu    a7, t3,  t4
>>          ADD     t0, t0,  t8
>>          ADD     t3, t3,  a7
>>          sltu    t1, a3,  a4
>>          sltu    t4, a5,  a6
>>          ADD     a3, a3,  t1
>>          ADD     a5, a5,  t4
>>          ADD     t0, t0, t3
>>          ADD     a3, a3, a5
>>          sltu    t1, t0, t3
>>          sltu    t4, a3, a5
>>          ADD     t0, t0, t1
>>          ADD     a3, a3, t4
>>          ADD     sum, sum, t0
>>          sltu    t8,  sum, t0
>>          ADD     sum, sum,  t8
>>          ADD     sum, sum, a3
>>          sltu    t8,  sum, a3
>>          addi.d  t5, t5, -1
>>          ADD     sum, sum, t8
>>
>> However the result and principle is almost the similar with
>> uint128 c code. And there is no performance impact interleaving
>> the reads and alu operations.
> 
> You are still relying on the 'out of order' logic to execute
> ALU instructions while the memory reads are going on.
> Try something like:
> 	complex setup :-)
> loop:
> 	sltu	c0, sum, v0
> 	load	v0, src, 0
> 	add	sum, v1
> 	add	carry, c3
> 
> 	sltu	c1, sum, v1
> 	load	v1, src, 8
> 	add	sum, v2
> 	add	carry, c0
> 
> 	sltu	c2, sum, v2
> 	load	v2, src, 16
> 	addi	src, 32
> 	add	sum, v3
> 	add	carry, c1
> 
> 	sltu	c3, sum, v3
> 	load	v3, src, 24
> 	add	sum, v0
> 	add	carry, c2
> 	bne	src, limit, loop
> 
> 	complex finalise
> 
> The idea being that each group of instructions executes
> in one clock - so the loop is 4 clocks.
> The above code allows for 2 delay clocks on reads.
> They may not be needed, in that case the above may run
> at 8 bytes/clock with just 2 blocks of instructions.
> 
> You'd give the cpu a bit more leeway by using two sum and
> carry registers.
Got it. It makes use of pipeline better, rather than number of ALUs for 
different micro-architectures. I will try this method, thanks again for 
kindly help and explanation with patience.

Regards
Bibo, mao

> 
> I'd time the loop without worrying about the setup/finalise
> code.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

