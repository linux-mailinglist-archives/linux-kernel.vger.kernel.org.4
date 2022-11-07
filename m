Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1C61FFE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKGU5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiKGU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:57:00 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD52A979
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:56:59 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id x13so8971085qvn.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1S/JQnMmN3DjPvkqvFQzgmskknDsfipulGwZNvds56w=;
        b=DjPZ80abs50yysr3vgzBuOIHSiisPDueDD2gradfm5Mc0WVW8bcqmtusRnHYvmQ5xU
         3Oj31BsKULnicqGaR0VWCX63nOp9Z7YjlCzML9GDNvpbnJGvYJHp3sV/g16Q5rHBuzyE
         Fu7Vrtege4aTPrIbIdQHFNkQlb3MFmnTSkDng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1S/JQnMmN3DjPvkqvFQzgmskknDsfipulGwZNvds56w=;
        b=qGNlwtfyK6DxlXcm0F4t3/5xiQ2lpGoZKgKUxOP3keEH0chCUycXXURXhLRX3ikJaI
         sMNM3pJg5mAjd3C4euqg7J3hY1ghNrBrWu2NIQoERQpq183PGkXl6M8oq8tt2zGrWGOY
         nly/YDrQEvxfCG7a5FdNe8LYctJF7umSVWDGwzfnA3gB/wjzv6nNskrnXIf+BMI98FuR
         /ge5NiGy9HboEqv94jvZDD1a6NJmmyggJ2QsKbr+CeFH8UwioutpaCOsloUdhVA87wrp
         K17UK7ysJqON86aP7unKpcVk0hOml5SyZ8QgHPKmMz9eyCoIRujDb1AsDNHrlopgFLQo
         2F4g==
X-Gm-Message-State: ACrzQf3p+uv12oza51WpBi4m7J6sph+EygDbr7mPMInUrXhgmkLvj17W
        NbPK34VAFVhxW6FzhSxjhGHuHzyPT6E05w==
X-Google-Smtp-Source: AMsMyM6hcQqYg/m9QGZtaZ9tk8EnGbwt68OmLxtjZ/IUPu4vjtWv+iRbb4N9gpB5qDDgLluzYl4Gqw==
X-Received: by 2002:ad4:5b8b:0:b0:4bb:a86e:d7b4 with SMTP id 11-20020ad45b8b000000b004bba86ed7b4mr46598926qvp.108.1667854618618;
        Mon, 07 Nov 2022 12:56:58 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bl6-20020a05620a1a8600b006b5cc25535fsm7695705qkb.99.2022.11.07.12.56.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:56:55 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-368edbc2c18so115923697b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:56:54 -0800 (PST)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr30747649ywe.401.1667854613940; Mon, 07
 Nov 2022 12:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com>
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 7 Nov 2022 12:56:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjejeg+mymJQYzjc=TeMkGkcOLTgKg4FY4tz4ueYdMsGQ@mail.gmail.com>
Message-ID: <CAHk-=wjejeg+mymJQYzjc=TeMkGkcOLTgKg4FY4tz4ueYdMsGQ@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 12:13 PM Jann Horn <jannh@google.com> wrote:
>
> I picked 10000 here to also provide safety for the ldsem code on 32-bit
> systems, but you could also argue that the real fix there is to make
> ldsem more robust, and that the limit should be something like 2^31...
>
> An alternative approach would be to always let make_task_dead() take the
> do_task_dead() path and never exit; but that would probably be a more
> disruptive change?

It might be more disruptive, but it might also be a better idea in
some respects: one of the bigger issues we've had with oopses in
inconvenient places is when they then cause even more problems in the
exit path (because the initial oops was horrid).

I'd honestly prefer something higher than 10000, but hey... I would
also prefer something where that legacy 'ldsem' was based on our
current legacy 'struct semaphore' rather than the half-way optimized
'rwsem'. The difference being that 'struct rwsem' tries to be clever
and uses atomic operations, while we long ago decided that anybody who
uses the bad old 'struct semaphore' can just use spinlocks and
non-atomic logic.

It's kind of silly how we try to stuff things into one 'sem->count'
value, when we could just have separate readers and writers counts.

And the only reason we do that is because those kinds of things *do*
matter for contended locks and the rwsem code has it, but I really
think the ldsem code could just always take the spinlock that it
already takes in the slowpath, and just skip any other atomics.

And it shouldn't have a wait_lock thing and two different wait queues
- it should have one wait queue, use that wait queues spinlock *as*
the lock for the semaphore operations, and put readers at the end, and
writers at the beginning as exclusive waiters.

So that ldesc_sem thing is just historical garbage in so many ways.
It's basically a modified copy of an old version of our rwsem, and
hasn't evern been simplified for its intended use, nor has it been
updated to improvements by the actual rwsem code.

Worst of both worlds, in other words.

Oh well. I don't think anybody really cares about the ldsem code,
which is why it is like it is, and probably will remain that way
forever.

I guess 10000 is fine - small enough to test for, big enough that if
somebody really hits it, they only have themselves to blame.

             Linus
