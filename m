Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C44C727154
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFGWNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFGWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:13:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C3F2118
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:13:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-655fce0f354so2695163b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686176008; x=1688768008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVOwXBe+gi9U6MELpPhRwwMitOlIbz1D83FR4yFNyP8=;
        b=S9fpjN7YodN2+IBus8fJhXHiiVEQ1SHuADo3yFRDKlHBgTqHWAdz40R5mJXOedC3Gh
         z3/JafZ4X3ESPwC4WZpGSxByZ9loZZF5oLTkv9v8MEMnWf737vB766X2YKBdgTLaRFvN
         ApTzOtMsyIn8NnRszwmegGGfkC2ahGCNulfmm8IV/7H2MamCZjr+ZDRCzFBPeOJP0rDX
         YXrRoqE5Yshv98UsRj6GGzZrrQNL9iw1veBMjdu86DAp4TmOegvF5IcyrKpDz8w3i+Z2
         I4PMtEweX4jkmLeC0BKtiq5Bi8lUN+lyjybZHJFeCmxQdqi5GzM/5oyukGScqQaeGvJr
         XmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176008; x=1688768008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVOwXBe+gi9U6MELpPhRwwMitOlIbz1D83FR4yFNyP8=;
        b=jI7gBPNroYDDmRHGBYAx342g5iUjkpudHthDN3RnDidbG3XD4mk+TKl2+uLphljaA6
         +pQz2L1heH9qFPca7/UuOUG+XKlFNMeE+ce0GSeL+F3pMuE9rGxHnr5jnGCrCd2Jhyft
         QIbHBi2nS+8O82iTfklMSItwp6D3596M/ptkFVKplWeMn6gFfgEkSTGwhZZbEFIRt6wP
         3/fhdDoNLL/+0jxQBFsZRN7dPUgVU4na+XtPxc5yCna+9u9VHrkdZoFs+F6bOmvHs1/b
         8lmOPMNgRj48gm5ihTA6rMhOV0iP334VRb0hBR8QXv6kQnJQbI8wMdNPBL8X6jJZM/DV
         FpgA==
X-Gm-Message-State: AC+VfDzNoC/OKxeCULuTzlSppqpE0Se8oKyMoTmCy19VfumXpdJ6hDtA
        SqsYdk+k4IR1ESkfwIgk/LZHrslcI5fqrQ==
X-Google-Smtp-Source: ACHHUZ7WZDiSk5w9oSk3cVw3c5L6ruMpara4N0ITOhCKKAIwNoPwOhuMPfF52imjZuI1RH0aA8+Imw==
X-Received: by 2002:a05:6a20:9596:b0:117:d81d:f170 with SMTP id iu22-20020a056a20959600b00117d81df170mr2525214pzb.28.1686176007418;
        Wed, 07 Jun 2023 15:13:27 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id q14-20020a65494e000000b00530914c3bc1sm8607463pgs.21.2023.06.07.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:13:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Jun 2023 12:13:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZIEBB-A1arYKSK2P@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, May 31, 2023 at 05:44:57PM +0530, K Prateek Nayak wrote:
...
> The RIP points to dereferencing sd_llc_shared->has_idle_cores
> 
>     $ scripts/faddr2line vmlinux select_task_rq_fair+0x9bd
>     select_task_rq_fair+0x9bd/0x2570:
>     test_idle_cores at kernel/sched/fair.c:6830
>     (inlined by) select_idle_sibling at kernel/sched/fair.c:7189
>     (inlined by) select_task_rq_fair at kernel/sched/fair.c:7710

Hmm... the only thing I can think of is workqueue setting ->wake_cpu to
something invalid.

> My kernel is somewhat stable (I have not seen a panic for ~45min but I
> was not stress testing the system either during that time) with the
> following changes:
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index b2e914655f05..a279cc9c2248 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2247,7 +2247,7 @@ static void unbind_worker(struct worker *worker)
>         if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
>                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
>         else
> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> +               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
>  }

I'm not sure why changing the cpus_allowed_ptr would make a difference here.
Maybe the chain of events involves CPUs going offline and the above migrate
the tasks resetting their ->wake_cpu.

Can you please try the following branch and see if any of the warnings
triggers?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-dbg-invalid-cpu

Thanks.

-- 
tejun
