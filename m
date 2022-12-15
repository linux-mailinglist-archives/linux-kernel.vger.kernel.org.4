Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80D64D6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLOGsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:48:31 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFC845C743
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:29 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8AxSuk8w5pjpcEFAA--.10126S3;
        Thu, 15 Dec 2022 14:48:28 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxsOQ7w5pjHDIAAA--.840S3;
        Thu, 15 Dec 2022 14:48:28 +0800 (CST)
Subject: Re: [PATCH 5/6] LoongArch: Add raw_show_trace to enable guess
 unwinder default
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221215040141.18610-1-hejinyang@loongson.cn>
 <20221215040141.18610-6-hejinyang@loongson.cn>
 <CAAhV-H4QwWV+q_ROSbw10n3mj64BPsiAoErR7k_wZ4v0zG3nhw@mail.gmail.com>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <fb7740c7-1bdb-ad71-50f9-284551032568@loongson.cn>
Date:   Thu, 15 Dec 2022 14:48:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4QwWV+q_ROSbw10n3mj64BPsiAoErR7k_wZ4v0zG3nhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxsOQ7w5pjHDIAAA--.840S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUBGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0En4kS14v26r1Y6r17MxC20s02
        6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UEYLkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 14:15, Huacai Chen wrote:

> Hi, Jinyang,
>
> Is this patch really necessary?

Of course not. When I developed and tested this series, I always compile
the kernel twice, maybe more :-(, to do comparisons between the result from
guess and result from prologue to determine whether prologue is effective.
Also, the guess_unwinder might be more reliable if function_graph is
enabled, because prologue_unwinder may stop by strange code flow. If you
think it is meaningless, I'll remove it in the next version. It doesn't
affect other patches in this series.


Thanks,

Jinyang

