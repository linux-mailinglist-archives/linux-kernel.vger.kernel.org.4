Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D36EBEA3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDWKjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:39:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BE10E67;
        Sun, 23 Apr 2023 03:39:43 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJ_DuCkVkkAohAA--.51665S3;
        Sun, 23 Apr 2023 18:39:42 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxmrLqCkVkAcE2AA--.8595S3;
        Sun, 23 Apr 2023 18:39:38 +0800 (CST)
Subject: Re: [PATCH] MIPS: uprobes: Restore thread.trap_nr
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1682213883-3654-1-git-send-email-yangtiezhu@loongson.cn>
 <ZEShNUil0gsVlrDo@debian.me>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f99fe71d-cd97-e641-d637-5e7efbcad5f5@loongson.cn>
Date:   Sun, 23 Apr 2023 18:39:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <ZEShNUil0gsVlrDo@debian.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxmrLqCkVkAcE2AA--.8595S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw1Utr1fCryxtFW7urWkXrb_yoW8GFyrpa
        1DAws8KaykAa4UJayUJa18ZayYvrs5JrsxC3W7Ja4xZ3yqgFyqqFs29r42g3ZxWr1xtr1S
        q3W7ZFy2yayDA37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc:
Oleg Nesterov <oleg@redhat.com>
Srikar Dronamraju <srikar@linux.vnet.ibm.com>

On 04/23/2023 11:08 AM, Bagas Sanjaya wrote:
> On Sun, Apr 23, 2023 at 09:38:03AM +0800, Tiezhu Yang wrote:
>> thread.trap_nr is saved in arch_uprobe_pre_xol(), it should be restored
>> in arch_uprobe_{post,abort}_xol() accordingly, actually it was only done
>> in the post function, just do it in the abort function too, this change
>> is similar with x86 and powerpc.
>
> I'm confused (please fix up grammar, spelling, and punctuation). Can you
> explain why thread.trap_nr should be restored somewhere else? Also, what
> x86/powerpc changes as reference?
>

Here is the related first commit for x86 in 2012:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0326f5a94dde

When xol insn itself triggers the signal, restart the original insn,
in this case, UTASK_SSTEP_TRAPPED is set [1], it does *abort_xol()
instead of *post_xol() [2], then should do the restore operations.

Maybe Oleg and Srikar could give more detailed backgrounds, thank you.
https://lore.kernel.org/lkml/1682213883-3654-1-git-send-email-yangtiezhu@loongson.cn/

[1] 
https://elixir.bootlin.com/linux/latest/source/kernel/events/uprobes.c#L1980
[2] 
https://elixir.bootlin.com/linux/latest/source/kernel/events/uprobes.c#L2268

Thanks,
Tiezhu

