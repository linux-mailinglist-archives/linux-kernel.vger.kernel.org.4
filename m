Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD476ECB88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjDXLrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:47:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 772C335BE;
        Mon, 24 Apr 2023 04:47:15 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxV+lCbEZkZAYAAA--.48S3;
        Mon, 24 Apr 2023 19:47:14 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxurJBbEZkAbc4AA--.11472S3;
        Mon, 24 Apr 2023 19:47:13 +0800 (CST)
Subject: Re: [PATCH] csky: uprobes: Restore thread.trap_no
Reply-To: loongson-kernel@lists.loongnix.cn
References: <1682213987-3708-1-git-send-email-yangtiezhu@loongson.cn>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <cdacf9d8-cf59-bf4e-5379-0b5bfc03a4e2@loongson.cn>
Date:   Mon, 24 Apr 2023 19:47:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1682213987-3708-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxurJBbEZkAbc4AA--.11472S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw1Utr47WFyrGryfJFWxtFb_yoW8Xr4kpa
        1DAay5t3WDGr13tFWUJa95ZryFva4kJrsrWry7uayfJ3yDKrW5Xr40grWqvF4YvrsYkw40
        qFy0qryqya9rAF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

On 04/23/2023 09:39 AM, Tiezhu Yang wrote:
> thread.trap_no is saved in arch_uprobe_pre_xol(), it should be restored
> in arch_uprobe_{post,abort}_xol() accordingly, otherwise the save operation
> is meaningless, this change is similar with x86 and powerpc.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/csky/kernel/probes/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
> index 2d31a12..6277f2b 100644
> --- a/arch/csky/kernel/probes/uprobes.c
> +++ b/arch/csky/kernel/probes/uprobes.c
> @@ -64,6 +64,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  	struct uprobe_task *utask = current->utask;
>
>  	WARN_ON_ONCE(current->thread.trap_no != UPROBE_TRAP_NR);
> +	current->thread.trap_no = utask->autask.saved_trap_no;
>
>  	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
>
> @@ -101,6 +102,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  {
>  	struct uprobe_task *utask = current->utask;
>
> +	current->thread.trap_no = utask->autask.saved_trap_no;
>  	/*
>  	 * Task has received a fatal signal, so reset back to probed
>  	 * address.
>

Hi Oleg and Srikar,

Could you please review this patch, thank you.

Thanks,
Tiezhu

