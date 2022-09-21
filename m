Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06695BF2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIUBbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIUBbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185C61D50;
        Tue, 20 Sep 2022 18:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22F762EF7;
        Wed, 21 Sep 2022 01:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF888C43142;
        Wed, 21 Sep 2022 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663723862;
        bh=AaMF3Lx8O+Q/o+XRTddc8AE/gxx/VpCCpwfiOhyRXIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T10zN9TgDWRzwNKs6FevPidFV06xeq7p0bUAQJni0ifUrB8vUhS6MTdBHNoclXnG+
         G9rjUqpoERoi/DJ2MCx5mUiKX0t970zl4q9/RnZ0A4kSZc3N2UO4AMwPZbecHJ/YrV
         mEVL/yZbQqPEwDc8Zz42Kh4N+m6Dgp3FTQAkMy/Cv2M3xxhBtdu67U/jk+AQWi7U++
         vUPqHUu9wKyEbT07pm2Z8EBaf/9HNugHrOW/SXAOQ8BGVW2lWOjI0QkAMv+YPAxVCn
         gXhHxV42mXasDAnvNXx5ZhoVi/CvQt+1xmB1kEJ/71wn+He9Mk0ZeoWgK/gCtAxFbP
         XFRDHCLVGLCiw==
Received: by mail-oi1-f170.google.com with SMTP id d64so3160920oia.9;
        Tue, 20 Sep 2022 18:31:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ESEMDdAq9tSQewBpNMvxKIAEog7phwujVptIEIMG4fHD5NQ54
        K7QzE+8z1K9SSkMqXFLcErlpAbW+4sFQJMzUJcE=
X-Google-Smtp-Source: AMsMyM6BZP9fw/VOE/mLMznHGL1+UHO0GnlrsPd4CDoYWfDhSlt430cnnqjnNSmcyHmtZU4RnBHUkNkUgyj1gA3IjQE=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr2937565oiw.112.1663723860952; Tue, 20
 Sep 2022 18:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220920151202.180057-1-chenzhongjin@huawei.com> <20220920151202.180057-5-chenzhongjin@huawei.com>
In-Reply-To: <20220920151202.180057-5-chenzhongjin@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 09:30:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ8QjUiRhQiM67SET=bCpppG2opcN3_ch7GEqdAkBnBUA@mail.gmail.com>
Message-ID: <CAJF2gTQ8QjUiRhQiM67SET=bCpppG2opcN3_ch7GEqdAkBnBUA@mail.gmail.com>
Subject: Re: [PATCH -next 4/7] riscv: syscall: Don't clobber s0 when syscall
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, nsaenzju@redhat.com, frederic@kernel.org,
        changbin.du@intel.com, vincent.chen@sifive.com, ardb@kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, keescook@chromium.org,
        catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 11:15 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> syscall uses s0 to load address of sys_call_table.
>
> Since now we uses s0 to save pt_regs for unwinding, clobber
> s0 can make unwinder treat s0 as pt_regs address. Use s1 for
> this job.
This patch does not make sense. Why couldn't we use s1 for pt_regs?

No need to modify the entry.S here.

>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/riscv/kernel/entry.S | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index ecb15c7430b4..a3b14a649782 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -205,33 +205,33 @@ handle_syscall:
>  check_syscall_nr:
>         /* Check to make sure we don't jump to a bogus syscall number. */
>         li t0, __NR_syscalls
> -       la s0, sys_ni_syscall
> +       la s1, sys_ni_syscall
>         /*
>          * Syscall number held in a7.
>          * If syscall number is above allowed value, redirect to ni_syscall.
>          */
>         bgeu a7, t0, 3f
>  #ifdef CONFIG_COMPAT
> -       REG_L s0, PT_STATUS(sp)
> -       srli s0, s0, SR_UXL_SHIFT
> -       andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
> +       REG_L s1, PT_STATUS(sp)
> +       srli s1, s1, SR_UXL_SHIFT
> +       andi s1, s1, (SR_UXL >> SR_UXL_SHIFT)
>         li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
> -       sub t0, s0, t0
> +       sub t0, s1, t0
>         bnez t0, 1f
>
>         /* Call compat_syscall */
> -       la s0, compat_sys_call_table
> +       la s1, compat_sys_call_table
>         j 2f
>  1:
>  #endif
>         /* Call syscall */
> -       la s0, sys_call_table
> +       la s1, sys_call_table
>  2:
>         slli t0, a7, RISCV_LGPTR
> -       add s0, s0, t0
> -       REG_L s0, 0(s0)
> +       add s1, s1, t0
> +       REG_L s1, 0(s1)
>  3:
> -       jalr s0
> +       jalr s1
>
>  ret_from_syscall:
>         /* Set user a0 to kernel a0 */
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren
