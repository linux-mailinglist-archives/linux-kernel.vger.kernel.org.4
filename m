Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0646330BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKUXgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKUXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:36:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0C4FF98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:36:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x102so18472060ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4d8IGjHxcauHDLJ1U2a9MfFlTytUhan5GVgIbSt3CU=;
        b=eamlurgOVvUkajwTiINGO/9cqTV1KMhu3gX5LtE0ugclPY8Wg6A2j2KS94JHWv7ZG/
         o0z9RoOE2rMr0Akbn7tSyE4IWpiy/0+AMloCm+jEiMg4vpVOhjBpdxQqlVXmvmOej9NX
         JEEX8l/S0MBFDPwVozTp8IxrTdBNrAVgkIDqBED7fuivo1FBpFWLKw7VisIq2b8lARXV
         ugqD+r7y1iCcIeg180IoTxhpO8vAXt9ZxZwVCQhuV5QxIS2BALye3WpH0wLJtKjnmWjo
         s2aDnVXQ+p4+5dUPtk3ssb2TAXcTL5CvmTJsh0xj8KI5wC9kIqIXqFeuVF3xTfniHYbJ
         9cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4d8IGjHxcauHDLJ1U2a9MfFlTytUhan5GVgIbSt3CU=;
        b=udsZvLfEaD3612Ubk6sjJcgRy6cdTF3MQ2hukz56I9GvSavI+26vOoctbXnW9ao1+U
         yE47ktRgiEmNDeRh97N/g1ZX6oZNwGLC+adWVL1Oaw6iCrA8+Afl6LT4J2lIhg8ePVrg
         zb2NIqdea/w33wISu7WeOyq1MRX2QE3WI9WT3gqHYEGhOJSXsX0VbNKmKtlaoGlPRctT
         7O6F3iU5WY2YlSesMo/hqAYP300w3SGjttZac+SUljbYuxxmt+WsiVItB8+iBzuIlO9e
         kcaLH36wWl43yXd5xizP8pf4pzNxCNQU9SLnuTaRGHd1HcytQELRb9aQxiujhHrq1UD3
         T5dg==
X-Gm-Message-State: ANoB5plo/1WDp79ORtYdAlb0YKJTzg94o1z+AqH4qFLP+5ZeDSqMwtwX
        falJ89MYNGdoMtF9UQbwe2OmXxEgks2+FEZXKC0=
X-Google-Smtp-Source: AA0mqf4kzgmgfsgXK+umGjFp7vvnxDQNH/xi5wT2faQS9NU6ZXGmHdLMnKxP/UJkd5undHhTQ1AkbHvVFkCoRoA/RQg=
X-Received: by 2002:a05:6402:389:b0:459:2515:b27b with SMTP id
 o9-20020a056402038900b004592515b27bmr18838430edv.338.1669073779598; Mon, 21
 Nov 2022 15:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic>
In-Reply-To: <Y3vSQo85ofkfD/L8@zn.tnic>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Nov 2022 15:36:08 -0800
Message-ID: <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
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

On Mon, Nov 21, 2022 at 11:32 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Nov 21, 2022 at 10:44:03AM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > The config to be able to inject error codes into any function annotated
> > with ALLOW_ERROR_INJECTION() is enabled when CONFIG_FUNCTION_ERROR_INJECTION
> > is enabled. But unfortunately, this is always enabled on x86 when KPROBES
> > is enabled, and there's no way to turn it off.
> >
> > As kprobes is useful for observability of the kernel, it is useful to have
> > it enabled in production environments. But error injection should be
> > avoided. Add a prompt to the config to allow it to be disabled even when
> > kprobes is enabled, and get rid of the "def_bool y".
> >
> > This is a kernel debug feature (it's in Kconfig.debug), and should have
> > never been something enabled by default.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 540adea3809f6 ("error-injection: Separate error-injection from kprobe")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  lib/Kconfig.debug | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
>
> As stated on another thread, debugging production kernels where folks
> have been injecting errors into functions is not something anyone would
> like to and have to do. Especially if from looking at system dumps, it
> is not even clear what has been injected and why, rendering the system
> unstable and the issue probably unreproducible.
>
> Acked-by: Borislav Petkov <bp@suse.de>

The commit log is bogus and the lack of understanding what
bpf and error injection hooks are used for expressed
in this thread is quite sad.
Disabling error injection makes the system _less_ secure.
But giving people an option to reduce security is a decision
that every distro and data center has to make on their own.
