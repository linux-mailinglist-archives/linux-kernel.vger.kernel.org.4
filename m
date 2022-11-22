Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25562633D64
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiKVNSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiKVNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:18:22 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A4D1B1ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:18:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f27so35809876eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atk8igXXo4V9ysQD6RMyJLcoXsSbbYE9K+eLHZ+lxUM=;
        b=cGQFx+9zlehgAqcO0VOr4G49JjZ/jzv9EVxyBKm4tJ1Ne2WlJ04vF6j1s9zXfkV1NC
         SfzWc4d9YyUAJIyjxCTyhqv0aNjsr6zCef7+62LpETr++/APc3wshQp6dn6PcCdfLKAx
         +M2fwLrKd166E/xsDykOrTYAAxe2MGWffzvvI7MmOHAoafPyxVk/1y7Dma4DDHmNhDAu
         n1GmktyY+X8/TyOHAghmiQI6cK5rjWTNPl586JoYyDSw8ZdNzjh8mlcLHbSMZUZga2Uf
         xSP4JSvSzhHFk/QXAmuhMyLMDlnDG7yTGuCeA/NMv0NsNj4sO9XyLGSOQVaDyAxcF/RE
         jb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atk8igXXo4V9ysQD6RMyJLcoXsSbbYE9K+eLHZ+lxUM=;
        b=ff+kNJSgyHasq4ggotP2yIV4s+6xaVOWlE2BOGUfi58BZ1XAaaiHJYr+oMwERS92Tm
         o/YHsRvnMZ0p+C2d+6hMmDqba0QVcOfLweQOvc9WNLD5N45krWYDqWbSzbLabtg52k+i
         nLeX6uNCOosMgdtmW5VhXTlREQTN3gXgb98HlULyNOPCGKYiNDzNuVCLm3T/zypQBZwy
         oyTBrFcM907Q/upP5RhkunEe1gGvpM77dVuJ5iQLwVWdZQ7WxybHnd+rfAkMNRslfZvM
         01BwD8ZsArncLQxI1RMQMINWc6Sd5HP14oTTpNf1N7WmjizryNSkD70X3I1YJzPcp5NE
         16xA==
X-Gm-Message-State: ANoB5pkNPhBtHzIrEW9k8LGLjs6PvxA3pgC4Lpbap1Ku+kI1w7PMzf9E
        N7zoF9v7StvvfgGlXUQx3Zt92Y/hVwq5uw==
X-Google-Smtp-Source: AA0mqf5Lj8F4A/sUeODEkxD04Sl1E5m48V8x9P/OqZhrgR7rPUwK6twTamHK7hwL0g3anJJhUmIdVg==
X-Received: by 2002:a17:906:1244:b0:78d:d4ca:21f7 with SMTP id u4-20020a170906124400b0078dd4ca21f7mr20041032eja.128.1669123097934;
        Tue, 22 Nov 2022 05:18:17 -0800 (PST)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906805400b007919ba4295esm6099034ejw.216.2022.11.22.05.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:18:17 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:18:14 +0000
From:   Quentin Perret <qperret@google.com>
To:     wangbiao3@xiaomi.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, brauner@kernel.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, wenjieli@qti.qualcomm.com,
        chenguanyou@xiaomi.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Subject: Re: [PATCH 1/1] sched: fix user_mask double free
Message-ID: <Y3zLnLXRzty+bkan@google.com>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC the missing people from get_maintainers.pl

On Monday 21 Nov 2022 at 18:04:20 (+0800), wangbiao3@xiaomi.com wrote:
> From: wangbiao3 <wangbiao3@xiaomi.com>
> 
> Clone/Fork a new task,call dup_task_struct->arch_dup_task_struct(tsk,orig)
> which copy the data of parent/sibling task inclding p->user_cpus_ptr,so
> the user_cpus_ptr of newtask is the same with orig task's.When
> dup_task_struct call dup_user_cpus_ptr(tsk, orig, node),it return 0
> dircetly if src->user_cpus_ptris free by other task,in this case ,
> the newtask's address of user_cpus_ptr is not changed. Finally,
> wakup newtask to execute, call task_cpu_possible_mask-->
> do_set_cpus_allowed to set new task's user_cpus_ptr(user_mask) which
> call kfree user_mask at the end. So cause a slub double free panic.
> 
> Use pi_lock to protect content of user_cpus_ptr in dup_user_cpus_ptr and
> clear dst->user_cpus_ptr when found src->user_cpus_ptr is null
> 
> kernel BUG at mm/slub.c:363!
> Call trace:
>  __slab_free+0x230/0x28c
>  kfree+0x220/0x2cc
>  do_set_cpus_allowed+0x74/0xa4
>  select_fallback_rq+0x12c/0x200
>  wake_up_new_task+0x26c/0x304
>  kernel_clone+0x2c0/0x470
>  __arm64_sys_clone+0x5c/0x8c
>  invoke_syscall+0x60/0x150
>  el0_svc_common.llvm.13030543509303927816+0x98/0x114
>  do_el0_svc_compat+0x20/0x30
>  el0_svc_compat+0x28/0x90
>  el0t_32_sync_handler+0x7c/0xbc
>  el0t_32_sync+0x1b8/0x1bc
> 
> Signed-off-by: wangbiao3 <wangbiao3@xiaomi.com>
> ---
>  kernel/sched/core.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..b013d8b777b4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2584,29 +2584,38 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>         __do_set_cpus_allowed(p, new_mask, 0);
>  }
> 
> +static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
> +{
> +       struct cpumask *user_mask = NULL;
> +
> +       swap(p->user_cpus_ptr, user_mask);
> +
> +       return user_mask;
> +}
> +
>  int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>                       int node)
>  {
> -       if (!src->user_cpus_ptr)
> -               return 0;

Removing this puts the kmalloc_node() (and kfree()) below on the fast
path for everyone. It wouldn't be surprising if this causes regressions
for some people ...

Can we optimize that?

> +       unsigned long flags;
> +       struct cpumask *user_mask = NULL;
> 
>         dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
>         if (!dst->user_cpus_ptr)
>                 return -ENOMEM;
> 
> +       /* Use pi_lock to protect content of user_cpus_ptr */
> +       raw_spin_lock_irqsave(&src->pi_lock, flags);
> +       if (!src->user_cpus_ptr) {
> +               user_mask = clear_user_cpus_ptr(dst);
> +               raw_spin_unlock_irqrestore(&src->pi_lock, flags);
> +               kfree(user_mask);
> +               return 0;
> +       }
>         cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> +       raw_spin_unlock_irqrestore(&src->pi_lock, flags);
>         return 0;
>  }
> 
> -static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
> -{
> -       struct cpumask *user_mask = NULL;
> -
> -       swap(p->user_cpus_ptr, user_mask);
> -
> -       return user_mask;
> -}
> -
>  void release_user_cpus_ptr(struct task_struct *p)
>  {
>         kfree(clear_user_cpus_ptr(p));
> --
> 2.38.1
> 
> #/******?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#

Note that this legalese must be removed from your email before anybody
can apply this patch, please see
Documentation/process/submitting-patches.rst.

Thanks,
Quentin
