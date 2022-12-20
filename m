Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF99F651B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiLTHQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiLTHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:16:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE72DE4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:14:10 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b12so7760946pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X0KQlryzQSZ+A4CVvWMh3bk/BYXb4lDOcSFPf4dERI=;
        b=O3jU0vIb6ea9nh+Bgjte/SdIn9p0YWtJsbkYgoyRZB/22pbybFOkDM/zjfkZK95NS8
         hlc12iVfjGojWYDDiSEmqHHoPwnW6m/yvEnnBWZWMR55rroMxtTZCH6L9bY9iEgsFC3y
         cRuyvzWp+IDKXiMTE8uAIEF9RomYRULP5ZWAOIUJIrSo3cgeuxQJxAWT+5RntNVNBTtH
         CC96FzoISDrbY8/auKGNA5P2ewYertaxz13PBcXPO+xpEyi9d4Am+syiGmLFBfIZhhLg
         0pXJBgEK8VGK2oFrkVcwj/uTdsIqvNQQ4xy5jQTZagXwqkqvdsikJtp12i7pQEAst+hJ
         Nr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4X0KQlryzQSZ+A4CVvWMh3bk/BYXb4lDOcSFPf4dERI=;
        b=kzU09RHyCzUVtoZ691uzHWOP0rxeFVjXRnYZqAiM8Y7ldiGzhtr4FK/UVcD1IullO7
         44ovGU2fjFWm9+aZnbZTfvP1LqtFJY1uzK4RsErHpNInlMkMMyBKAn4esff1TS978Kfh
         JhGJJAarpqS5zEqwWkPbolBlEVnkW+HRS4PfolWItQ7ob+HelduDQ2n69aADOobo8t5g
         EnMUiT6TI32p2cv0jO8q4N8erqlsqEQDkd8RaTbvJGOFEu5NCvi0OFlnHzEtM8ksvbh/
         u7PZDmhEnAAWl5XsHmSSqbULpnYk9oTKLGETJmnJg9/IN52WyILtaihHsFvAX6RGqNxc
         9zdg==
X-Gm-Message-State: AFqh2kp/DtN7SLarQLJ5LTtrlhJk9QI2k8PxNY5sgqysBac2GvRCT5W2
        2Zqe0Kwb12P+YX0iQVBGhKE=
X-Google-Smtp-Source: AMrXdXvslA2U0jhUAUr74lSlPSD7waWGk26xbpwKt9BGBFbVdBVYRvEU4Gp/ZyI+fHKYLBVgfLQfTA==
X-Received: by 2002:aa7:870f:0:b0:57e:c08b:b7b9 with SMTP id b15-20020aa7870f000000b0057ec08bb7b9mr18824159pfo.10.1671520450031;
        Mon, 19 Dec 2022 23:14:10 -0800 (PST)
Received: from localhost (203-219-149-28.tpgi.com.au. [203.219.149.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a62830a000000b00574ffc5976fsm7869168pfe.159.2022.12.19.23.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 23:14:09 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Dec 2022 17:14:05 +1000
Message-Id: <CP6GJNNB62LY.N38DBL6D2S79@bobo>
Cc:     <linux-kernel@vger.kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Subject: Re: [PATCH] exit: Detect and fix irq disabled state in oops
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: aerc 0.13.0
References: <20221004094401.708299-1-npiggin@gmail.com>
In-Reply-To: <20221004094401.708299-1-npiggin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 4, 2022 at 7:44 PM AEST, Nicholas Piggin wrote:
> If a task oopses with irqs disabled, this can cause various cascading
> problems in the oops path such as sleep-from-invalid warnings, and
> potentially worse.
>
> Since commit 0258b5fd7c712 ("coredump: Limit coredumps to a single
> thread group"), the unconditional irq enable in coredump_task_exit()
> will "fix" the irq state to be enabled early in do_exit(), so currently
> this may not be triggerable, but that is coincidental and fragile.
>
> Detect and fix the irqs_disabled() condition in the oops path before
> calling do_exit(), similarly to the way in_atomic() is handled.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Hey Eric, did you have any thoughts on this?

Thanks,
Nick

> ---
>  kernel/exit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 84021b24f79e..fa696765f694 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -738,6 +738,7 @@ void __noreturn do_exit(long code)
>  	struct task_struct *tsk =3D current;
>  	int group_dead;
> =20
> +	WARN_ON(irqs_disabled());
>  	WARN_ON(tsk->plug);
> =20
>  	kcov_task_exit(tsk);
> @@ -865,6 +866,11 @@ void __noreturn make_task_dead(int signr)
>  	if (unlikely(!tsk->pid))
>  		panic("Attempted to kill the idle task!");
> =20
> +	if (unlikely(irqs_disabled())) {
> +		pr_info("note: %s[%d] exited with irqs disabled\n",
> +			current->comm, task_pid_nr(current));
> +		local_irq_enable();
> +	}
>  	if (unlikely(in_atomic())) {
>  		pr_info("note: %s[%d] exited with preempt_count %d\n",
>  			current->comm, task_pid_nr(current),
> --=20
> 2.37.2

