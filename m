Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C315FC6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJLNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJLNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:41:29 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAD3C5888
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:41:28 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id p7so14145897vsr.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNaONkodKU8wuhjhY6olb/IOl+q0m7F2XRj580RmVHU=;
        b=MhofUUXYT3tMT7oMQ+a5cs30JJ4oxfDawPPGaNHs4RrO+MqfLXIzE6Vb5DKawierXs
         kBBWD3mF1Svm6j9Bk5Efo8SKBS5fj6LsDKyEmMxd5p0ScJj20zY+wLFWDFX1sZXmYeJ/
         yWckjMTjg1kGb4YuR9giH8xD/PNg8MUWv2eYl9tOaB5OfqGP2zi7LJBFBubdEXhp/HV+
         j+5m0uu7Q1SsV6RdzOqsXmbDVQflTXfn91nd0Mdh0lhhC7P6rLZL9otgU9vIRf6PgSsf
         z0Qnd9DGQkDU0625sqluJJofMfWEk7nI+eWAuHsOJE75dWE7ddsUzxYpTiub0k/WZSKE
         iotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNaONkodKU8wuhjhY6olb/IOl+q0m7F2XRj580RmVHU=;
        b=nl2JSjZa1CbCJYBQilVofumh0E2XWjEYxqQgHMJenX7efvN/l1QZs+OIGzBgYhEY9U
         onnJEBCHA/9uuu8FXNQVt3QjukKfMqGLgaA3Iw4nrdxP0sHT9+7MsmZxDqPQC1rGyaWM
         sAdqRL59Ezg7j9JauRrMFbTNWcVQXGs2q2ONEiUdMo+iZOJtvGBxUTugY7dEqyRLsAqQ
         hme2xJg2aTEsc47ildInIebBeg6SwlF6TH3wyw75dcrMaK7BWpwZ0wn6OwRr78IsS7Lw
         JPODbY5ktCRWIYAolquq8GB7SsxaE1Tf+yS++YC5nqRlVNvtjhiifqo01tE9LyjIxeXJ
         dL/Q==
X-Gm-Message-State: ACrzQf0tTTR9QysFpYVeXc39yAJgggV+KXZ8T4EVDy8zOO/nGMVcYv4x
        aZ1vpYZ5DrGMowkpfyPUPHgeMZQAIxIzZGChcUo=
X-Google-Smtp-Source: AMsMyM5+q5LtrcFWQspxCt566WeBlBUnLhzlSoIIWh3N2hJAuyYFmaM4pCXOCmY1Vj++tYwP0S9AlrvwQVCWofodsZI=
X-Received: by 2002:a05:6102:31b6:b0:3a6:eeec:a566 with SMTP id
 d22-20020a05610231b600b003a6eeeca566mr14831683vsh.28.1665582087089; Wed, 12
 Oct 2022 06:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221012082949.1801222-1-ajones@ventanamicro.com>
 <Y0a5QYWzEwRlGtxf@yury-laptop> <20221012131325.oc7onxqo7t46wxq5@kamzik>
In-Reply-To: <20221012131325.oc7onxqo7t46wxq5@kamzik>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 12 Oct 2022 06:41:16 -0700
Message-ID: <CAAH8bW9z6D_DRCAvQi5BUN9dh82LBZwGd-GWa8r+MFc=xs6xVw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Fix /proc/cpuinfo cpumask warning
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 6:13 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Wed, Oct 12, 2022 at 05:55:29AM -0700, Yury Norov wrote:
> > On Wed, Oct 12, 2022 at 10:29:49AM +0200, Andrew Jones wrote:
> > > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > > started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> > > are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> > > start and next seq operations implement a pattern like
> > >
> > >   n = cpumask_next(n - 1, mask);
> > >   show(n);
> > >   while (1) {
> > >       ++n;
> > >       n = cpumask_next(n - 1, mask);
> > >       if (n >= nr_cpu_ids)
> > >           break;
> > >       show(n);
> > >   }
> >
> > Can you instead of sudo-code print show the real control flow? What
> > function hosts the infinite loop?
>
> The function is seq_read_iter(), which is pointed out above. I'd rather
> not reproduce / describe more than what I've done here, as the function
> is large. I'd be happy for reviewers to double check my pseudocode to
> make sure I got it and the analysis right, though.
>
> >
> > > which will issue the warning when reading /proc/cpuinfo. Ensure no
> > > warning is generated by validating the cpu index before calling
> > > cpumask_next().
> > >
> > > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > >
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > ---
> > > v2:
> > >   - Got comments on the x86 equivalent patch and made the same
> > >     changes to this one
> > >     - Added all the information I should have in the first place
> > >       to the commit message [Boris]
> > >     - Changed style of fix [Boris]
> > >
> > >
> > >  arch/riscv/kernel/cpu.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > index 4aa8cd749441..63138b880b92 100644
> > > --- a/arch/riscv/kernel/cpu.c
> > > +++ b/arch/riscv/kernel/cpu.c
> > > @@ -166,6 +166,9 @@ static void print_mmu(struct seq_file *f)
> > >
> > >  static void *c_start(struct seq_file *m, loff_t *pos)
> > >  {
> > > +   if (*pos >= nr_cpu_ids)
> > > +           return NULL;
> > > +
> > >     *pos = cpumask_next(*pos - 1, cpu_online_mask);
> > >     if ((*pos) < nr_cpu_ids)
> > >             return (void *)(uintptr_t)(1 + *pos);
> >
> > OK, as far as I understood your explanations, *pos == nr_cpu_ids
> > is a valid index because it's used as stop-code for traversing.
> >
> > However, you're completely silencing cpumask_check(), including
> > those cases where *pos > nr_cpu_ids. I suspect there's no valid
> > cases for it. If so, the patch should look like:
> >
> >  +    if (*pos == nr_cpu_ids)
> >  +            return NULL;
> >  +
>
> That makes sense and it's probably worth a v3. I'll wait and see if more
> comments roll in before sending though.
>
> >
> > The same for x86 patch.
> >
> > If it comes to v3, can you send both as a series?
>
> OK. I'll write a cover letter trying to explain that I don't expect them
> to both go through the same tree.

I can take it in my tree, if it helps.
