Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828745EE959
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiI1W1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiI1W1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:27:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522FF684C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:26:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso9050861otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xaZJP7weXVSlht4vpUznwn4iF5uD2DMip9O5AR8FVBE=;
        b=izBWtxhamD5wBt2tuzijqlpJmRJ/AfoAkwJjGdO68dYAkNpgP8NSmuvDxPIsPupTxU
         O9vsaRxY//fQX+QC2ZTpE3sQes4UAjwGLVcteDLpOKCTQZQmISX9g66ALhjChIB6Ev2a
         3J2lFgeqaysA2mEtHAuNsSR0LofNNxq0ksHMFBbBzG/1XN4GxIYlXms1rTU3hE30ffnA
         /Am5Rw+SCWyaPues9/CFqP4oGhXakWOfh0S1ZXbTljNcsEnLOMSPMzv2M8UKgRpPkmcT
         OB1w6NJOMMtZAxMtPeHolUF98Hit6fvsawYrZO9JgxUi6eFsaul+2+9l69NlTDGZnj4x
         Eb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xaZJP7weXVSlht4vpUznwn4iF5uD2DMip9O5AR8FVBE=;
        b=FbatSKcAoX/Md2H0NgDieJP6ZT+amiHIgLXYZ4KxTfojfd6Oh2dEuFGrjkh6UOU5Ed
         KEmb50jc6XhpTJJSOmWEUt/hAKW1NFLSam7YClLgmlMzkt4JceIp68EjKY9ABLoDorQE
         HhWXS7GfYqH8y7YZEF2hbUSTL28rXdFxqALY/T1mfW7yfgs56h/FxunSMjOLUoSY8s6Y
         9y3PUQ/9y/t8v+utnXLnRFlaIO5wD6K7irTZTtxnmIxJw2A8L07VqQmEnkDvBbfzrJoy
         w5rehEe1PYU2EFMKGfpC7A+eQjctRfSGW33ZusGRpwPtAFizlokayIQgQQdBokW783zR
         yncQ==
X-Gm-Message-State: ACrzQf1g/Skp/jLht//h2X5vh2rckC3ipSyMKxU8IbUFnL/OY4Kj1W4Q
        9ZSnQnk6J117RVd7+NAKdQITy1IMpffxcU2fXpLk
X-Google-Smtp-Source: AMsMyM4KE36RDim/kqbdXE95Iq/XtjEefUdiaERF0BlzKs6V6J6lw+wCFYBC7mpFi0DwVUGXHIAKg0DVeeznFUREvFY=
X-Received: by 2002:a9d:1b70:0:b0:658:cfeb:d221 with SMTP id
 l103-20020a9d1b70000000b00658cfebd221mr29313otl.34.1664404018771; Wed, 28 Sep
 2022 15:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com> <20220927225944.2254360-3-ankur.a.arora@oracle.com>
In-Reply-To: <20220927225944.2254360-3-ankur.a.arora@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Sep 2022 18:26:47 -0400
Message-ID: <CAHC9VhRBuBiuf6917fpP7n+Sy5fFTpzzEqRXfMGPCbnNU4jswg@mail.gmail.com>
Subject: Re: [PATCH 2/3] audit: annotate branch direction for audit_in_mask()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 7:00 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> With sane audit rules, audit logging would only be triggered
> infrequently. Keeping this in mind, annotate audit_in_mask() as
> unlikely() to allow the compiler to pessimize the call to
> audit_filter_rules().
>
> This allows GCC to invert the branch direction for the audit_filter_rules()
> basic block in this loop:
>
>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
>                 if (audit_in_mask(&e->rule, major) &&
>                     audit_filter_rules(tsk, &e->rule, ctx, NULL,
>                                        &state, false)) {
>                         ...
>
> such that it executes the common case in a straight line fashion.
>
> On a Skylakex system change in getpid() latency (all results
> aggregated across 12 boot cycles):
>
>          Min     Mean    Median   Max      pstdev
>          (ns)    (ns)    (ns)     (ns)
>
>  -    196.63   207.86  206.60  230.98      (+- 3.92%)
>  +    173.11   182.51  179.65  202.09      (+- 4.34%)
>
> Performance counter stats for 'bin/getpid' (3 runs) go from:
>     cycles               805.58  (  +-  4.11% )
>     instructions        1654.11  (  +-   .05% )
>     IPC                    2.06  (  +-  3.39% )
>     branches             430.02  (  +-   .05% )
>     branch-misses          1.55  (  +-  7.09% )
>     L1-dcache-loads      440.01  (  +-   .09% )
>     L1-dcache-load-misses  9.05  (  +- 74.03% )
>
>  to:
>     cycles               706.13  (  +-  4.13% )
>     instructions        1654.70  (  +-   .06% )
>     IPC                    2.35  (  +-  4.25% )
>     branches             430.99  (  +-   .06% )
>     branch-misses          0.50  (  +-  2.00% )
>     L1-dcache-loads      440.02  (  +-   .07% )
>     L1-dcache-load-misses  5.22  (  +- 82.75% )
>
> (Both aggregated over 12 boot cycles.)
>
> cycles: performance improves on average by ~100 cycles/call. IPC
> improves commensurately. Two reasons for this improvement:
>
>   * one fewer branch mispred: no obvious reason for this
>     branch-miss reduction. There is no significant change in
>     basic-block structure (apart from the branch inversion.)
>
>   * the direction of the branch for the call is now inverted, so it
>     chooses the not-taken direction more often. The issue-latency
>     for not-taken branches is often cheaper.
>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/auditsc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

I generally dislike merging likely()/unlikely() additions to code
paths that can have varying levels of performance depending on runtime
configuration.  While I appreciate the work you are doing to improve
audit performance, I don't think this is something I want to merge,
I'm sorry.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 533b087c3c02..bf26f47b5226 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -789,7 +789,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
>         return AUDIT_STATE_BUILD;
>  }
>
> -static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
> +static bool audit_in_mask(const struct audit_krule *rule, unsigned long val)
>  {
>         int word, bit;
>
> @@ -850,12 +850,13 @@ static void audit_filter_syscall(struct task_struct *tsk,
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
> -               if (audit_in_mask(&e->rule, major) &&
> -                   audit_filter_rules(tsk, &e->rule, ctx, NULL,
> -                                      &state, false)) {
> -                       rcu_read_unlock();
> -                       ctx->current_state = state;
> -                       return;
> +               if (unlikely(audit_in_mask(&e->rule, major))) {
> +                       if (audit_filter_rules(tsk, &e->rule, ctx, NULL,
> +                                              &state, false)) {
> +                               rcu_read_unlock();
> +                               ctx->current_state = state;
> +                               return;
> +                       }
>                 }
>         }
>         rcu_read_unlock();
> --
> 2.31.1

-- 
paul-moore.com
