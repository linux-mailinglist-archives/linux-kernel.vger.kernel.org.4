Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8869A6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBQINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBQINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:13:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A53730B03
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:13:43 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8Cxxtg2N+9jM7IBAA--.3297S3;
        Fri, 17 Feb 2023 16:13:42 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxyr02N+9jnyo1AA--.32871S3;
        Fri, 17 Feb 2023 16:13:42 +0800 (CST)
Subject: Re: [PATCH v5 4/5] LoongArch: Add support for kernel relocation
To:     Xi Ruoyao <xry111@xry111.site>
References: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
 <1676618789-20485-5-git-send-email-tangyouling@loongson.cn>
 <5ac82f53aeb6a040be90eac2be7c64055e62f0ef.camel@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <fc5b0403-ed2f-2dcf-11b9-e3be4642ddda@loongson.cn>
Date:   Fri, 17 Feb 2023 16:13:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <5ac82f53aeb6a040be90eac2be7c64055e62f0ef.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bxyr02N+9jnyo1AA--.32871S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtr1UZFW3Cr4kuF1rWFW5trb_yoWDXwb_uF
        WFgr1qk3W5CrZ7K3Z2va13Xrs293yrJF4UWrn3X3yIva4ayanxJas8trnF9F45Xrn8Cr13
        Zan7ur1Fkry2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5
        Q7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E
        6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWrMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWl
        kUUUUU=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/17/2023 04:02 PM, Xi Ruoyao wrote:
> On Fri, 2023-02-17 at 15:26 +0800, Youling Tang wrote:
>
>> This config allows to compile kernel as PIE and to relocate it at
>> any virtual address at runtime: this paves the way to KASLR.
>> Runtime relocation is possible since relocation metadata are embedded
>> into the kernel.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Use arch_initcall
>> Signed-off-by: Jinyang He <hejinyang@loongson.cn> # Provide la_abs idea
>
> Use Suggested-by if only "idea" is provided.
In addition to the idea, the first draft code of la_abs is also
provided.

Maybe change it to the following,
   Signed-off-by: Jinyang He <hejinyang@loongson.cn> # Provide la_abs 
relocation draft code

>
>> +struct rela_la_abs {
>> +               long offset;
>> +               long symvalue;
>> +};
>
> Use one tab instead of two for the indent.
My mistake.

Also the missing do_kaslr declaration will be added.

Youling.
> Otherwise LGTM.
>

