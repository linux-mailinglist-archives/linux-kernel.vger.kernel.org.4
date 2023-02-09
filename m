Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B116869082B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBIMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBIMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:05:03 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8572F47402
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:55:29 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxqOkw3+Rj_2wQAA--.28682S3;
        Thu, 09 Feb 2023 19:55:28 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbL4v3+Rjr3YvAA--.24066S3;
        Thu, 09 Feb 2023 19:55:27 +0800 (CST)
Message-ID: <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn>
Date:   Thu, 9 Feb 2023 19:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230209035839.2610277-1-maobibo@loongson.cn>
 <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbL4v3+Rjr3YvAA--.24066S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFyDJry5Zw4xWr48Zw45trb_yoW5KFWUpr
        Wft398JF1kXFWxua17Ka4UAF4rJa4fJr15ZrWIvF1qv34fXrnrCF95Gry2ya45Jw4rAryU
        tan2v3sFgFnxA3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/9 17:35, David Laight 写道:
> From: Bibo Mao
>> Sent: 09 February 2023 03:59
>>
>> loongArch platform is 64-bit system, which supports 8 bytes memory
>> accessing, generic checksum function uses 4 byte memory access.
>> This patch adds 8-bytes memory access optimization for checksum
>> function on loongArch. And the code comes from arm64 system.
> 
> How fast do these functions actually run (in bytes/clock)?
With uint128 method, there will unrolled loop, instruction
can execute in parallel. It gets the best result on loongarch
system where there is no neither carry flag nor post-index
addressing modes.

Here is the piece of disassemble code with uint128 method:
   120000a40:   28c0222f        ld.d    $r15,$r17,8(0x8)
   120000a44:   28c0622a        ld.d    $r10,$r17,24(0x18)
   120000a48:   28c0a230        ld.d    $r16,$r17,40(0x28)
   120000a4c:   28c0e232        ld.d    $r18,$r17,56(0x38)
   120000a50:   28c0022e        ld.d    $r14,$r17,0
   120000a54:   28c0422d        ld.d    $r13,$r17,16(0x10)
   120000a58:   28c0822b        ld.d    $r11,$r17,32(0x20)
   120000a5c:   28c0c22c        ld.d    $r12,$r17,48(0x30)
   120000a60:   0010b9f7        add.d   $r23,$r15,$r14
   120000a64:   0010b54d        add.d   $r13,$r10,$r13
   120000a68:   0010b24c        add.d   $r12,$r18,$r12
   120000a6c:   0010ae0b        add.d   $r11,$r16,$r11
   120000a70:   0012c992        sltu    $r18,$r12,$r18
   120000a74:   0012beee        sltu    $r14,$r23,$r15
   120000a78:   0012c170        sltu    $r16,$r11,$r16
   120000a7c:   0012a9aa        sltu    $r10,$r13,$r10
   120000a80:   0010ae0f        add.d   $r15,$r16,$r11
   120000a84:   0010ddce        add.d   $r14,$r14,$r23
   120000a88:   0010b250        add.d   $r16,$r18,$r12
   120000a8c:   0010b54d        add.d   $r13,$r10,$r13
   120000a90:   0010b5d2        add.d   $r18,$r14,$r13
   120000a94:   0010c1f0        add.d   $r16,$r15,$r16

> 
> It is quite possible that just adding 32bit values to a
> 64bit register is faster.
> Any non-trivial cpu will run that at 4 bytes/clock
> (for suitably unrolled and pipelined code).
> On a more complex cpu adding to two registers will
> give 8 bytes/clock (needs two memory loads/clock).
> 
> The fastest 64bit sum you'll get on anything mips-like
> (no carry flag) is probably from something like:
> 	val = *mem++;  // 64bit read
> 	sum += val;
> 	carry = sum < val;
> 	carry_sum += carry;
> which is 2 bytes/instruction again.
> To get to 8 bytes/clock you need to execute all 4 instructions
> every clock - so 1 read and 3 arithmetic.
There is no post-index addressing modes on loongarch, 
 	val = *mem;  // 64bit read
        mem++;
 	sum += val;
 	carry = sum < val;
 	carry_sum += carry;
it takes 5 instruction and these 5 instructions depends on previous instr.
There is the piece of disassemble code:
   120000d90:   28c001f0        ld.d    $r16,$r15,0
   120000d94:   0010c58c        add.d   $r12,$r12,$r17
   120000d98:   02c021ef        addi.d  $r15,$r15,8(0x8)
   120000d9c:   0010b20c        add.d   $r12,$r16,$r12
   120000da0:   0012c191        sltu    $r17,$r12,$r16
   120000da4:   5fffedf2        bne     $r15,$r18,-20(0x3ffec) # 120000d90 <do_csum_64+0x90>

regards
bibo, mao
          

> (c/f 2 read and 2 arithmetic for 32bit adds.)
> 
> Arm has a carry flag so the code is:
> 	val = *mem++;
> 	temp,carry = sum + val;
> 	sum = sum + val + carry;
> There are still two dependant arithmetic instructions for
> each 8-byte word.
> The dependencies on the flags register also make it harder
> to get any benefit from interleaving adds to two registers.
> 
> x86-64 uses 64bit 'add with carry' chains.
> No one ever noticed that they take two clocks each on
> Intel cpu until (about) Haswell.
> It is possible to get 12 bytes/clock with some strange
> loops that use (IIRC) adxo and adxc.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

