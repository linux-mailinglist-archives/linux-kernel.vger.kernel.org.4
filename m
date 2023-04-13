Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937AA6E03ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDMB7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDMB7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:59:00 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F6D65FC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:58:56 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJITfYTdkppEbAA--.42883S3;
        Thu, 13 Apr 2023 09:58:55 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxsOTdYTdk9bkhAA--.9170S3;
        Thu, 13 Apr 2023 09:58:53 +0800 (CST)
Subject: Re: [PATCH v1 3/4] LoongArch: Use larch_insn_gen_break() for kprobes
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <1681293901-24918-1-git-send-email-yangtiezhu@loongson.cn>
 <1681293901-24918-4-git-send-email-yangtiezhu@loongson.cn>
 <bf4bda7a88bd5f33bd3bdc7fc715bc24fa4add8f.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3249ca98-6293-a83d-d49b-d1d52827a062@loongson.cn>
Date:   Thu, 13 Apr 2023 09:58:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <bf4bda7a88bd5f33bd3bdc7fc715bc24fa4add8f.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxsOTdYTdk9bkhAA--.9170S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw4rGr1rZw45tFWUWryxuFg_yoW3Awc_ur
        18ZryUCF98Za9xZw4UKa13ZFykGayxX3WUArykZw47Cwn8Xa4UArZIkr1kZa1jgryfXrnI
        kFnIqFWFkry7ujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xOz3UUUUU==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2023 07:08 PM, Xi Ruoyao wrote:
> On Wed, 2023-04-12 at 18:05 +0800, Tiezhu Yang wrote:
>> -static inline bool insns_not_supported(union loongarch_instruction insn)
>> +static inline bool insns_not_supported(u32 code)
>>  {
>> +       union loongarch_instruction insn;
>> +
>> +       insn.word = code;
>> +
>
> I remember Xuerui disliked this change.  Maybe we can add
> __attribute__ (__transparent_union__) [1] for union
> loongarch_instruction instead?
>
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-transparent_005funion-type-attribute
>

OK, let me pass union parameter, then define a local variable
to do type conversion for callers, the changes are small and
then the code may be more readable, thank you.

Thanks,
Tiezhu

