Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C8698A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBPCdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPCdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:33:12 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F693270C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:32:50 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8CxxtjRle1j7iUBAA--.2225S3;
        Thu, 16 Feb 2023 10:32:49 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxUuXQle1j+i40AA--.62363S3;
        Thu, 16 Feb 2023 10:32:48 +0800 (CST)
Subject: Re: [PATCH v4 2/5] LoongArch: Use la.pcrel instead of la.abs for
 exception handlers
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
 <1676018856-26520-3-git-send-email-tangyouling@loongson.cn>
 <CAAhV-H4Bs5n_ek3mq6zwxAgVw0nvER1XUA+WUA8M12eKcYVPDQ@mail.gmail.com>
 <05ef2d91-ab87-b8d9-85fa-6a90a92f8f39@loongson.cn>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin lv <lvjianmin@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <848e2985-9ba3-c14d-23ac-a7f1c218215f@loongson.cn>
Date:   Thu, 16 Feb 2023 10:32:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <05ef2d91-ab87-b8d9-85fa-6a90a92f8f39@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxUuXQle1j+i40AA--.62363S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrur13tF17uFyrKrWrJryUGFg_yoWktFb_WF
        y0g34UC34aganaqFsFyFnrCF45Ww13uF1UGr45Wa17t3s5Jr4kJFZ8tr4Fqw1kJrWxu343
        WrZrWF43G3Z2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5
        m7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E
        6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWrMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRE6wZ7
        UUUUU==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On 02/10/2023 05:18 PM, Youling Tang wrote:
>
>
> On 02/10/2023 05:09 PM, Huacai Chen wrote:
>> Hi, Youling and Ruoyao,
>>
>> Thank you very much for implementing the per-node exceptions. But I
>> want to know if the per-node solution is really worthy for a PIE
>> kernel. So, could you please test the performance? Maybe we can reduce
>> the complexity if we give up the per-node solution.

Tested on Loongson-3C5000L-LL machine, using CLFS7.3 system.

- nopernode:
   Based on the v1 patch method, and remove the else branch process in
   setup_tlb_handler().

- pernode: Based on the v4 patch method.

- pie: Enable RANDOMIZE_BASE (KASLR).

- nopie: Disable RANDOMIZE_BASE and RELOCATABLE.


The UnixBench test results are as follows:

- nopernode-nopie: 3938.7

- pernode-nopie: 4062.2

- nopernode-pie: 4009.7

- pernode-pie: 4028.7

In general, `pernode` is higher than `nopernode`, and `nopie` is higher
than `pie`. (except that nopernode-pie is higher than nopernode-nopie,
which is not as expected, which may be caused by the instability of the
machine).

Everyone is more inclined to use `pernode` or `nopernode` to implement
in the exception handling process?

Youling.

