Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB45B68FC8B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBIBQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBIBQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:16:32 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA11224C85
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:16:11 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxmOlaSeRjLToQAA--.28070S3;
        Thu, 09 Feb 2023 09:16:10 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxQuVZSeRjCOQuAA--.54035S3;
        Thu, 09 Feb 2023 09:16:09 +0800 (CST)
Message-ID: <aea24370-2526-7f43-ca5f-55d1d8b8c4bb@loongson.cn>
Date:   Thu, 9 Feb 2023 09:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] LoongArch: add checksum optimization for 64-bit system
To:     David Laight <David.Laight@ACULAB.COM>,
        'WANG Xuerui' <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230207040148.1801169-1-maobibo@loongson.cn>
 <8fa91bca5e624861b190917933951c7e@AcuMS.aculab.com>
 <5b3c9b61-7fd5-f50c-32ba-e857090b71bc@xen0n.name>
 <7636a7bebfd44e378c5b16d6fd355232@AcuMS.aculab.com>
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <7636a7bebfd44e378c5b16d6fd355232@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxQuVZSeRjCOQuAA--.54035S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFWktw18uF1UGw45WryfZwb_yoW8Gr1Upr
        1DWay3Ga10q347uwn2yF48Jw15ur43AF45Ja4Yvr1rAFy5XryDJaykGrWjga4Ivr45C3W8
        uFWUtayayr4F9aDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/8 22:19, David Laight 写道:
> From: WANG Xuerui
>> Sent: 08 February 2023 13:48
> ...
>> Yeah LoongArch can do rotates, and your suggestion can indeed reduce one
>> insn from every invocation of csum_fold.
>>
>>  From this:
>>
>> 000000000000096c <csum_fold>:
>>          sum += (sum >> 16) | (sum << 16);
>>   96c:   004cc08c        rotri.w         $t0, $a0, 0x10
>>   970:   00101184        add.w           $a0, $t0, $a0
>>          return ~(__force __sum16)(sum >> 16);
>>   974:   0044c084        srli.w          $a0, $a0, 0x10
>>   978:   00141004        nor             $a0, $zero, $a0
>> }
>>   97c:   006f8084        bstrpick.w      $a0, $a0, 0xf, 0x0
>>   980:   4c000020        jirl            $zero, $ra, 0
>>
>> To:
>>
>> 0000000000000984 <csum_fold2>:
>>          return (~sum - rol32(sum, 16)) >> 16;
>>   984:   0014100c        nor             $t0, $zero, $a0
>>          return (x << amt) | (x >> (32 - amt));
>>   988:   004cc084        rotri.w         $a0, $a0, 0x10
>>          return (~sum - rol32(sum, 16)) >> 16;
>>   98c:   00111184        sub.w           $a0, $t0, $a0
>> }
>>   990:   00df4084        bstrpick.d      $a0, $a0, 0x1f, 0x10
>>   994:   4c000020        jirl            $zero, $ra, 0
> 
> It is actually slightly better than that.
> In the csum_fold2 version the first two instructions
> are independent - so can execute in parallel on some cpu.
> 
> 	David
>

Thanks for the good suggestion.
Will send the second version soon.

regards
bibo,mao
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

