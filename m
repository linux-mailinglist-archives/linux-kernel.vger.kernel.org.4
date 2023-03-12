Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1766B63B9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCLHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCLHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:43:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4693A20049
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:43:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x3so36849554edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678607022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY2hX/bXPNidr53rzPJsAwgBRXUnTGPsx6iMAq55oAE=;
        b=PlmQIJBdxeQOriWHNDlIb4wjfKDKbVWvG37PmrW4JZ33dXmoS8hRuMVhgq0CsckhWq
         Sgq8iG9spmLXuF6tXmjIYi1VhyKsP1g0gZX9pgqt19HABi4nfXKoWWzY3Jpovwz0MPuo
         I9HH32DSZeajQU+aVbXuYCgtFd4W7AnEwkgo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678607022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY2hX/bXPNidr53rzPJsAwgBRXUnTGPsx6iMAq55oAE=;
        b=qYXjDFuqOSkhIwGiMA2I5XMbQTKcQFwsZNtELxyVBP72T8YbtuZsOS9UfeNUNZnJqi
         AMKiJWEmDZBNmryK5T4ci3vsvhwS66SQELuPefSLAD+I9f9eUM74kQK6hrP/4S69XAO5
         AiEFs8UBmMjbNgn74WrCFBQZ3osalsjtwGOaUu+YJCngZRUfvZHqi2CRVHxvjzgrhIqk
         F9i2N5TMSQRt1FfXnPx7+iOtGW4zLiUpXJUozz9QvmbE+objViSB+xYW/kbwEbBXKBxe
         nGR90GpnitKphE6UikAELunpxw6mo2kzwXJZ05Sc+AGZqds3bXqo8yPxkcCfRpuyVfT+
         AL4Q==
X-Gm-Message-State: AO0yUKX4b5dCP6hviaJD+N4VrADlKbzyQfbag9lkx2zlKfvN/nCMbcKl
        9YyqCerA3sLLpuJ9OJx8xz9yH4qMlSJ7pGiHrVHg0g==
X-Google-Smtp-Source: AK7set95biwJq8/sZNI+pKgYAe+vkuna1uoETaTdlbG8INXGvjn/EzvVNt5PJ8okF1IOC1a+vdwktw==
X-Received: by 2002:a17:906:9f0d:b0:8af:7b80:82c5 with SMTP id fy13-20020a1709069f0d00b008af7b8082c5mr35067683ejc.75.1678607022526;
        Sat, 11 Mar 2023 23:43:42 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id jt18-20020a170906ca1200b008c9b44b7851sm1941211ejb.182.2023.03.11.23.43.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 23:43:41 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id da10so37011532edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:43:41 -0800 (PST)
X-Received: by 2002:a17:906:b281:b0:8b8:aef3:f2a9 with SMTP id
 q1-20020a170906b28100b008b8aef3f2a9mr14172315ejz.0.1678607021168; Sat, 11 Mar
 2023 23:43:41 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004d318a05f6810a9f@google.com> <c1f4cc16-feea-b83c-82cf-1a1f007b7eb9@I-love.SAKURA.ne.jp>
In-Reply-To: <c1f4cc16-feea-b83c-82cf-1a1f007b7eb9@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Mar 2023 23:43:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMMYE+vs-ZhxnAC_7NMw601xMOZOBqL1NR4kQYDDcK_A@mail.gmail.com>
Message-ID: <CAHk-=wgMMYE+vs-ZhxnAC_7NMw601xMOZOBqL1NR4kQYDDcK_A@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in c_start (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+96cae094d90877641f32@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 6:57=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is unable to test kernels due to hitting WARN_ON_ONCE(cpu >=3D bit=
s) upon
> "cat /proc/cpuinfo" request.
>
> Since commit 596ff4a09b898179 ("cpumask: re-introduce constant-sized cpum=
ask optimizations")
> changed to pass "small_cpumask_bits" instead of "nr_cpumask_bits" to find=
_next_bit(),
> find_next_bit() returning small_cpumask_bits causes c_next() to go beyond=
 nr_cpumask_bits.
> I think that we need to make sure that cpumask_next() and friends would n=
ot return cpu id
> beyond nr_cpumask_bits.

Ahh. yes.

It's the same old "cpumask scanning should be testing >=3D nr_cpu_ids"
thing, but c_start() does

        *pos =3D cpumask_next(*pos - 1, cpu_online_mask);

and basically assumes that it is "=3D=3D nr_cpu_ids" for the end
condition, and uses the value next time around.

And if it is *exactly* nr_cpu_ids, then the next time it gets called,
the "*pos - 1" means that it's all ok.

But if it's > nr_cpu_ids, then next time the "-1" doesn't do anything
useful and the input is still larger than the number of CPU ids.

The core *works* correctly, but it triggers that warning because it is
not doing that test properly.

That c_start() function is ugly, but the simplest patch is probably
this one-liner (whitespace-damaged but hopefully really obvious):

  --- a/arch/x86/kernel/cpu/proc.c
  +++ b/arch/x86/kernel/cpu/proc.c
  @@ -156,6 +156,7 @@
        *pos =3D cpumask_next(*pos - 1, cpu_online_mask);
        if ((*pos) < nr_cpu_ids)
                return &cpu_data(*pos);
  +     *pos =3D nr_cpu_ids;
        return NULL;
   }


which just caps that ">=3D nr_cpu_ids" case down to nr_cpu_ids.

Does that fix your test-case for you?

I'm not entirely convinced we shouldn't clean stuff up with a slightly
bigger patch, though. Instead of capping the 'pos', just testing it
seems the kind of more obvious thing. This code had similar problems
before. So an alternative patch (still whitespace-damaged) would be
something like

  --- a/arch/x86/kernel/cpu/proc.c
  +++ b/arch/x86/kernel/cpu/proc.c
  @@ -153,8 +153,12 @@

   static void *c_start(struct seq_file *m, loff_t *pos)
   {
  -     *pos =3D cpumask_next(*pos - 1, cpu_online_mask);
  -     if ((*pos) < nr_cpu_ids)
  +     loff_t prev =3D *pos;
  +
  +     if (prev >=3D nr_cpu_ids)
  +             return NULL;
  +     *pos =3D cpumask_next(prev - 1, cpu_online_mask);
  +     if (*pos < nr_cpu_ids)
                return &cpu_data(*pos);
        return NULL;
   }

which is a few lines more of patch, but stops depending on that "pos
has to end up exactly at nr_cpu_ids" thing.

Either patch should result in the same thing and hopefully fix your
warning, so I guess it's just a matter of taste.

                Linus
