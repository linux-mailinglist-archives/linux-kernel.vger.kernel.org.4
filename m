Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919965EEB08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiI2Bf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiI2BfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:35:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840472BE02
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:35:09 -0700 (PDT)
Received: from [10.136.12.12] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWtF9jRj+o0jAA--.5455S3;
        Thu, 29 Sep 2022 09:35:03 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Remove some save operations in SAVE_SOME and
 handle_syscall
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1664409543-31214-1-git-send-email-yangtiezhu@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <7fdca9ee-919b-2730-9574-5a1cf8b6b628@loongson.cn>
Date:   Thu, 29 Sep 2022 09:35:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1664409543-31214-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxXWtF9jRj+o0jAA--.5455S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kZrWrAFyxCw15trWxXrb_yoW5JFyxpF
        nrCrs7KF409r1xZFyDA34Fgry5Aan7ua10q3W7ArW8trnxX34Yvw10yryDGF90g3yrWw4I
        93WfAwnaqF4kJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaU
        UUUUU==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/29 上午7:59, Tiezhu Yang wrote:

> No need to save the control and status registers CRMD, EUEN, ECFG
> and ESTAT in SAVE_SOME and handle_syscall as they are not restored
> later in RESTORE_SOME.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/include/asm/stackframe.h | 9 ---------
>   arch/loongarch/kernel/entry.S           | 8 --------
>   2 files changed, 17 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 4ca9530..733dc9e 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -114,14 +114,6 @@
>   	LONG_S	zero, sp, PT_R0
>   	csrrd	t0, LOONGARCH_CSR_PRMD
>   	LONG_S	t0, sp, PT_PRMD
> -	csrrd	t0, LOONGARCH_CSR_CRMD
> -	LONG_S	t0, sp, PT_CRMD
> -	csrrd	t0, LOONGARCH_CSR_EUEN
> -	LONG_S  t0, sp, PT_EUEN
> -	csrrd	t0, LOONGARCH_CSR_ECFG
> -	LONG_S	t0, sp, PT_ECFG
> -	csrrd	t0, LOONGARCH_CSR_ESTAT
> -	PTR_S	t0, sp, PT_ESTAT
>   	cfi_st	ra, PT_R1, \docfi
>   	cfi_st	a0, PT_R4, \docfi
>   	cfi_st	a1, PT_R5, \docfi
> @@ -140,7 +132,6 @@
>   	cfi_st	fp, PT_R22, \docfi
>   
>   	/* Set thread_info if we're coming from user mode */
> -	csrrd	t0, LOONGARCH_CSR_PRMD
>   	andi	t0, t0, 0x3	/* extract pplv bit */
>   	beqz	t0, 9f

Hi, Tiezhu,


Have u tested debug functions like __show_regs? We discussed offline
about which registers should be saved in kretprobe lately. And I think
users use kprobe should not care about exception infos, because the old
way of kretprobe is the fixed break-insn-trigger. Then I suggested only
save the CSR.PLV and CSR.PIE. But this is not similar to exception
handler. Each exception occur we should save the current status in case
exception nest. We may unwind and debug the previous exception. If we
hadn't saved status at that time exception occured, we lost them.


Thanks,

Jinyang

>   
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> index d53b631..893e632 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -31,14 +31,6 @@ SYM_FUNC_START(handle_syscall)
>   	st.d	zero, sp, PT_R0
>   	csrrd	t2, LOONGARCH_CSR_PRMD
>   	st.d	t2, sp, PT_PRMD
> -	csrrd	t2, LOONGARCH_CSR_CRMD
> -	st.d	t2, sp, PT_CRMD
> -	csrrd	t2, LOONGARCH_CSR_EUEN
> -	st.d	t2, sp, PT_EUEN
> -	csrrd	t2, LOONGARCH_CSR_ECFG
> -	st.d	t2, sp, PT_ECFG
> -	csrrd	t2, LOONGARCH_CSR_ESTAT
> -	st.d	t2, sp, PT_ESTAT
>   	cfi_st	ra, PT_R1
>   	cfi_st	a0, PT_R4
>   	cfi_st	a1, PT_R5

