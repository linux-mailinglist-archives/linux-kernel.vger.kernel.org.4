Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D5698FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBPJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBPJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:26:18 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E387F1C7C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:26:15 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Axu5e29u1jPkUBAA--.104S3;
        Thu, 16 Feb 2023 17:26:14 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD7+19u1j6nY0AA--.60001S3;
        Thu, 16 Feb 2023 17:26:13 +0800 (CST)
Message-ID: <ff1ede2c-8289-a833-3997-48f8a30dc606@loongson.cn>
Date:   Thu, 16 Feb 2023 17:26:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
 <0d591c10-e897-d00a-dbf0-a069389ef196@loongson.cn>
 <8bc06b0ef9c243b087e944e0611b54b5@AcuMS.aculab.com>
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <8bc06b0ef9c243b087e944e0611b54b5@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxD7+19u1j6nY0AA--.60001S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr43XFyfGFy7KF4UZr1fWFg_yoW8KF1DpF
        WrKwn0kFWSvrWxGrn3Zw4UWFy7CFs3Aw45AFnrt34xCay5GFyFqFWIy395ZFWkA3sYga12
        vFWjy34UuF92y3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/16 17:03, David Laight 写道:
> From: maobibo
>> Sent: 14 February 2023 14:19
> ...
>> Got it. It makes use of pipeline better, rather than number of ALUs for
>> different micro-architectures. I will try this method, thanks again for
>> kindly help and explanation with patience.
> 
> It is also worth pointing out that if the cpu does 'out of order'
> execution it may be just as good to just repeat blocks of:
> 	load	v0, addr, 0*8
> 	add	sum0, v0
> 	sltu	v0, sum0, v0
> 	add	carry0, v0
> 
It is strange that there is no performance improvement on my loongarch
machine when interleaving ALU instructions before load; however on x86
box the performance improvement is huge compared to uint128 function.

Here is the piece of of the code:
        while (len > 48) {
                len -= 48;
                tmp4 = *(unsigned long *)ptr;
                if (tmp1 < tmp2)
                        tmp1 += 1;
                tmp3 += tmp4;

                tmp0 = *(unsigned long *)(ptr + 1);
                if (tmp3 < tmp4)
                        tmp3 += 1;
                sum64 += tmp0;

                tmp2 = *(unsigned long *)(ptr + 2);
                if (sum64 < tmp0)
                        sum64 += 1;
                tmp1 += tmp2;

                tmp4 = *(unsigned long *)(ptr + 3);
                if (tmp1 < tmp2)
                        tmp1 +=1;
                tmp3 += tmp4;

                tmp0 = *(unsigned long *)(ptr + 4);
                if (tmp3 < tmp4)
                        tmp3 +=1;
                sum64 += tmp0;

                tmp2 = *(unsigned long *)(ptr + 5);
                if (sum64 < tmp0)
                        sum64 += 1;
                tmp1 += tmp2;
                ptr += 6;
        }

Regards
Bibo, Mao
> Assuming the prefetch/decode logic can predict the loop
> and generate enough decoded instruction for all the alu units.
> 
> The add/sltu/add will be queued until the load completes
> and then execute in the next three clocks.
> The load for the next block will be scheduled as soon as
> the load/store unit has finished processing the previous load.
> So all the alu instructions just wait for the required input
> to be available and a memory load executes every clock.
> 
> Multiple sum0 and carry0 registers aren't actually needed.
> But having 2 of each (even if the loop is unrolled 4 times)
> might help a bit.
> 
> If the cpu does 'register renaming' (as most x86 do) you
> can use the same register name for 'v0' in all the blocks
> (even though it is alive with multiple values).
> 
> But a simpler in-order multi-issue cpu will need you to
> correctly interleave the instructions for maximum throughput.
> It also does no hard for a very simple cpu that has delays
> before a read value can be used.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

