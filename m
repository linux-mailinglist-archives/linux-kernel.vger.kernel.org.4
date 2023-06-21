Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5011737A29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFUEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUEgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:36:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16DCA171C;
        Tue, 20 Jun 2023 21:36:36 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxZPBPfpJkpwAAAA--.10S3;
        Wed, 21 Jun 2023 12:36:31 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx33fqZ5JkIOoAAA--.446S3;
        Wed, 21 Jun 2023 11:00:59 +0800 (CST)
Subject: Re: [PATCH v2] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <1684835873-15956-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4Es7qs54zr_hNPwn5MfgeLiKr3sgoTUP5iNj3JrH-1Uw@mail.gmail.com>
 <7a085947-9011-ebc9-a97d-7a62c755a978@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1c3c95c7-54e9-a65a-2f63-3a16af0fc2bf@loongson.cn>
Date:   Wed, 21 Jun 2023 11:00:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7a085947-9011-ebc9-a97d-7a62c755a978@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx33fqZ5JkIOoAAA--.446S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv262kKe7AKxVWUtVW8ZwCF54CYxVCY
        1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtV
        W8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jOdb8UUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2023 03:01 PM, Tiezhu Yang wrote:
> Hi Arnaldo,
>
> On 05/23/2023 06:26 PM, Huacai Chen wrote:
>> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>>
>> On Tue, May 23, 2023 at 5:57 PM Tiezhu Yang <yangtiezhu@loongson.cn>
>> wrote:
>>>
>>> We can see the following definitions in bfd/elfnn-loongarch.c:

...

>
> Are you OK with this change?
> Could you please pick it up in your tree?

Ping. What is the status of this patch? Any more comments?
Is there a chance to merge it for this coming merge window?

Thanks,
Tiezhu

