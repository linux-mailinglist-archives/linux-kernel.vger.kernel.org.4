Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E25FC5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJLMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJLMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:55:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D8C354D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:55:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j21so8136004qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NykrHH5gGzZDG/0TkAsC81A7G9ja1/v69DTLp124N0A=;
        b=kVm+MZ4kgwUUmzvVYwV9rmiJNq5uz6+zJ9wVZ+Us2BKadF2Zv2QkIIjlF5U9py+KqX
         uOJV+cYGG4EuRfH7M7qiTnWg5qyUCBSJiZEjjINym37WwAecgc2eCvqZrviS3GU9ml3M
         vkgF9Ng0bohPEuygOzRNKCEp5w53znYsl7RBEF1ZS36tS2mtjKhCG/YcCuKv3mTm11OQ
         R3vj7pifmeB5ol/BhdJOv9fOYpCxd2httfqPM8CoR0AJg9wVJ1WCCNsP2x2RLjT1qkDC
         leNbb3+kSswCJVRmtHdQhMjI17d63CmKKzo2w5uDhcX1SfjM7TuzvpVt607iPZ8acdB2
         Vm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NykrHH5gGzZDG/0TkAsC81A7G9ja1/v69DTLp124N0A=;
        b=yzpsvtAoDyWglxPgf5IsghyZmbzpMI7tjsPfdXuDRYpn8nqnaqlTSWunpLMZroDgA+
         rgPFeBvAM9lYSKswUlO0vZi47LaZ9lNY+61lMJcG7RC9sE6t7iXa0Vfyu5EBbqAiSWAw
         VWkQOSBtWszxuM7e1EIcKNmIwbQxi7tpeiIhRLhYnwFkMc9Lgi9tl8xehM0c6uibx/ev
         Jsh+4P8aP1ANRtq1jpK3V2MKYFe+tfqE1k05Ydkk54N3H7/ly1vxs10bhNXrm/eSXGVO
         f5g5jvA7I9+FuA2KJ2MdNqO4pfReYX5TPlc4YNydQ1ZeaR8JJEZwqBVUsvNSP3MqF3j+
         yK+g==
X-Gm-Message-State: ACrzQf3/brIVoKdCuEmJEsrLqxY3az+k18MzInM7s2LNZXBt/Zu5Dbe4
        oxmCUFnHki0zWNEkHQCNVmA97hPUdB8=
X-Google-Smtp-Source: AMsMyM69O4fIUv1aXMHjdjQZ/fYZolbB5HWb2IerIhd/VpZTfLLC3edt7+vZwU7xsOakHxVWIrEWCg==
X-Received: by 2002:a37:5e41:0:b0:6ce:79e2:68af with SMTP id s62-20020a375e41000000b006ce79e268afmr20132324qkb.239.1665579330011;
        Wed, 12 Oct 2022 05:55:30 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:e933:ff1b:52b1:c383])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a0b9300b006ecb9dfdd15sm8087460qkh.92.2022.10.12.05.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:55:29 -0700 (PDT)
Date:   Wed, 12 Oct 2022 05:55:29 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2] RISC-V: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y0a5QYWzEwRlGtxf@yury-laptop>
References: <20221012082949.1801222-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012082949.1801222-1-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:29:49AM +0200, Andrew Jones wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
> 
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }

Can you instead of sudo-code print show the real control flow? What
function hosts the infinite loop?

> which will issue the warning when reading /proc/cpuinfo. Ensure no
> warning is generated by validating the cpu index before calling
> cpumask_next().
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
> v2:
>   - Got comments on the x86 equivalent patch and made the same
>     changes to this one
>     - Added all the information I should have in the first place
>       to the commit message [Boris]
>     - Changed style of fix [Boris]
> 
> 
>  arch/riscv/kernel/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 4aa8cd749441..63138b880b92 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -166,6 +166,9 @@ static void print_mmu(struct seq_file *f)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> +	if (*pos >= nr_cpu_ids)
> +		return NULL;
> +
>  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
>  	if ((*pos) < nr_cpu_ids)
>  		return (void *)(uintptr_t)(1 + *pos);

OK, as far as I understood your explanations, *pos == nr_cpu_ids
is a valid index because it's used as stop-code for traversing.

However, you're completely silencing cpumask_check(), including
those cases where *pos > nr_cpu_ids. I suspect there's no valid
cases for it. If so, the patch should look like:

 +	if (*pos == nr_cpu_ids)
 +		return NULL;
 +

The same for x86 patch. 

If it comes to v3, can you send both as a series?

Thanks,
Yury
