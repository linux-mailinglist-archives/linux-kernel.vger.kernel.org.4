Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C86AD03E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCFV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCFV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:28:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A4738005
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:28:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw28so44522473edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678138090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnU/mYFnIpIVbVKmwpGVODBByhS5NBpJ4/YhOb762T4=;
        b=ca9E5pAYbNQMFjtLDOlFGhQyGD7Pxy6Zg7gsEj6PGawBYVWiJuWcwUgAj0L+BRVNEv
         MxDViH+zhHgTghFy1LHQYJ0CUOHMDKxyR7BpmA262bBG/4hhNJQR7GeuIQr4eIl33C0h
         crhulB/L7AehpDEeB9CbInJHS8FKy1ZSydC30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678138090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnU/mYFnIpIVbVKmwpGVODBByhS5NBpJ4/YhOb762T4=;
        b=CuiRwW1meYgAMlP+RqWQdbPLOlaDO4/nz7caUiQH7zCP1nvWB8rhNVXOpljGggT4my
         BJqUCMcYFiOishoRZ4ysflQQj4DBjeqX1eal/aRuay6YN0sA1iNqwLVnfLgaWKmkykSE
         qvNUrq0wOk9AeBNt1b70/y6+Oc/ceN5GjmNdDs0nlCWhHjLkbhhDi8cJviC61uRfQOEG
         SB9yf3Pm2h6YdNSECwa1rirTYaQRoChdzYR+vEy85RQvnCmhu8eP/m3Tf+RUQV12WvT+
         qs3NyJZuQa7cmBKsygF+0JHZra5qZ3m7VMT6Sp4Je4x2Alopo7Qfgj71hfYHqPgTl8Ei
         eTzA==
X-Gm-Message-State: AO0yUKXEAtS9Ujhe2rTsDi+y0UmRsfcqpjL5SC5GzlKCEK2Qlxxh6rWT
        FipmUlUv167qqqep+1DY3TanXQbf0/Qs4Xf4Goq1+oWZ
X-Google-Smtp-Source: AK7set+Um9oFQaQQezBH2Iu5Bbg2pFLl/OSZ1tsvKmRvFNly2/erQWqrR9oQIJM9uAZvEL1mcdcWkQ==
X-Received: by 2002:a50:fb85:0:b0:4be:b39b:ea8f with SMTP id e5-20020a50fb85000000b004beb39bea8fmr11770547edq.2.1678138090094;
        Mon, 06 Mar 2023 13:28:10 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a25-20020a509b59000000b004c0eac41829sm5629754edj.63.2023.03.06.13.28.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 13:28:09 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id g3so44622203eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:28:08 -0800 (PST)
X-Received: by 2002:a50:9fa9:0:b0:4ac:b616:4ba9 with SMTP id
 c38-20020a509fa9000000b004acb6164ba9mr6739970edf.5.1678138088582; Mon, 06 Mar
 2023 13:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20230306160651.2016767-1-vernon2gm@gmail.com> <20230306160651.2016767-6-vernon2gm@gmail.com>
 <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com>
 <CAHk-=witXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNdaPwngMVEg@mail.gmail.com>
 <CAHmME9qN1EcfzE2ONA-B+F=8xaqZhqkEY=_npYHgtBpUFCj4Lw@mail.gmail.com> <CAHk-=wjR6SGJhhHT6NzHcZHBJ3p5Y_JPvpQPjkeNQE+emivS6Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjR6SGJhhHT6NzHcZHBJ3p5Y_JPvpQPjkeNQE+emivS6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 13:27:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsQuc-S4vuYpvi013-81UNvNc8CoTMC5AKOMT-uq_7Og@mail.gmail.com>
Message-ID: <CAHk-=whsQuc-S4vuYpvi013-81UNvNc8CoTMC5AKOMT-uq_7Og@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpumask: fix comment of cpumask_xxx
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 6, 2023 at 12:43=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And when I say "all", I might be missing some others that don't match
> that exact pattern, of course.

Indeed.

I'm looking at wg_cpumask_next_online(), and this:

        while (unlikely(!cpumask_test_cpu(cpu, cpu_online_mask)))
                cpu =3D cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bit=
s;

seems very dodgy indeed. I'm not convinced it might not cause an endless lo=
op.

The code does seem to expect that the modulus ends up being zero, and
thus starting from the beginning. But that's not necessarily at all
true.

For example, maybe you have CONFIG_NR_CPUS set to some odd value like
6, because who knows, you decided that you are on some mobile platform
that has a BIG.little setup with 4 little cores and 2 big ones.

But your're then running that on a machine that only has 4 cores.

And to make matters worse, you have decided to offline all but one of
those cores, for whatever reason. So only bit #0 is actually set in
'cpu_online_mask'.

End result:

 - nr_cpumask_bits is 4, because that's how many CPU cores you have.

 - cpumask_next(cpu, cpu_online_mask) will return 6 if 'cpu' >=3D0,
because it's looking for the next online CPU, doesn't find it, and it
uses that optimized version that uses the compile-time constant of
maximum CPU's rather than bothering with some run-time constant.

 - cpumask_test_cpu(2, cpu_online_mask) returns false, because CPU#2
is not online. It *could* be, but it's not.

now that loop is:

        while (unlikely(cpu2 is offline))
                cpu =3D 6 % 4;

and it will just loop forever on trying to get the "next" cpu, but
that will always remain that offline CPU #2.

I *think* what you want is just that same "find next wrapping CPU",
but I find it very odd that you use a potentially horrendously slow
modulus operation for it, and a while loop.

IOW, the more obvious code would have been just

        cpu =3D cpumask_next(cpu-1, cpu_online_mask);
        if (cpu >=3D nr_cpu_ids)
                cpu =3D cpumask_first(cpu_online_mask);

which seems much more straigthforward, and avoids both a pointless
while loop and a potentially expensive modulus.

And yes, I think that "cpumask_next -> cpumask_first" wrapping search
pattern should probably have a better helper, but even without the
helper the above code seems simpler and more logical than the odd code
that it has now.

Now, I suspect you have to hit a few fairly odd situations to actually
get the above endless loop, but I don't think they have to necessarily
be quite as made-up as my example above.

And I suspect you wrote it that odd way because you expect that the
first "cpumask_test_cpu()" always succeeds, so the whole while-loop
was then a complete afterthought, and any oddity there was just
"nobody cares". Except for the fact that it does seem to be possibly
an endless loop.

[ Adding back lkml to the participants, just because I think this was
an interesting case of cpumask operation mis-use. Even if it probably
doesn't cause issues in practice, it's the kind of code that *can*
cause problems ]

               Linus
