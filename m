Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120266BD721
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCPRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCPRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:31:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9CB9504
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:30:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z21so10654874edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678987853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YryrzFP9xzjyk98MIHgDswzk42M925/BWmA7MtQw0v4=;
        b=h67olO+uevKaXKTSNOLSoT4LanVp8uprOJ0ALprCpqh//3X78gBQQy00RoLDAqDx6d
         YbYnaJRoO+9vpCxBbUqNZyfDssR+OABHsRGahvLIHqpECT4cKajrMb8PpbWBbu43tA1N
         Fpnu7muihuAekZeLvXccYyjPgsQkQSXYYr6Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YryrzFP9xzjyk98MIHgDswzk42M925/BWmA7MtQw0v4=;
        b=5bHpzCEmOykpabQVmNx0/27bh4THFsk224AR1H64G5S6K4u8XGLGPYkuqTuwP0izUl
         YcTHlCt7iSANCap1OaUjLxUEmCFir6Z6VdbvJxSeBY4w5n8Ul+jjPKKtj9YebxCkjI8x
         ScLCRNJcETQxr0EaVznaicn/3hZKk7TGdXHswKjgOMK2R6V79XlOJPkhIPF6qKl/cRbd
         1L1cYHKNyW22tDSYqOMxPqxKAaa8UA/J9zHPHiSBzK24zvK0V2CK2G6y65PwfGqIIBcK
         nNmuX7+NLZOLZRhxSGnDAtDQlgFKpPr+hGZinGzIdVzMcR2bXB77Ow9gRCnLIh7owx9z
         LuKA==
X-Gm-Message-State: AO0yUKUhrvWAJZ8esWsjJc30QHmEqigxz2eOxTM7KZW7RFsiiPLpmmzW
        k4xOMjcBmqHHdJCVs5b3DTHCpqOAW66lvK3RcM5U+Q==
X-Google-Smtp-Source: AK7set8VTGDMrz1ALNJ8oxVZV14FQXVPklK/vaYxIM1XoW+uy2WqF+ZCI8kBc0eLjr10miik89ERWw==
X-Received: by 2002:a17:907:2da7:b0:8e6:bcb6:469e with SMTP id gt39-20020a1709072da700b008e6bcb6469emr12590994ejc.0.1678987852725;
        Thu, 16 Mar 2023 10:30:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906038c00b00924d38bbdc0sm4094931eja.105.2023.03.16.10.30.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:30:51 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id y4so10676948edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:30:51 -0700 (PDT)
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr5816749ejb.15.1678987850768; Thu, 16
 Mar 2023 10:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info> <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
In-Reply-To: <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2023 10:30:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
Message-ID: <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
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

On Thu, Mar 16, 2023 at 4:43=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> @Linus: in short, we would like to continue using the "Closes:" tag (or
> similar, see below) with a URL in commit messages. They are useful to
> have public bug trackers doing automated actions like closing a specific
> ticket. Any objection from your side?

As long as it's a public link, I guess that just documents what the
drm people have been doing.

I'm not convinced "Closes" is actually any better than just "Link:",
though. I would very much hope and expect that the actual closing of
any bug report is actually done separately and verified, rather than
some kind of automated "well, the commit says it closes it, so.."

So honestly, I feel like "Link:" is just a better thing, and I worry
that "Closes:" is then going to be used for random internal crap.
We've very much seen people wanting to do that - having their own
private bug trackers, and then using the commit message to refer to
them, which I am *violently* against. If it's only useful to some
closed community, it shouldn't be in the public commits.

And while the current GPU people seem to use "Closes:" the right way
(and maybe some other groups do too - but it does seem to be mostly a
freedesktop thing), I really think it is amenable to mis-use in ways
"Link:" is not.

The point of "Link:" is explicitly two-fold:

 - it makes it quite obvious that you expect an actual valid web-link,
not some internal garbage

 - random people always want random extensions, and "Link:" is
_designed_ to counter-act that creeping "let's add a random new tag"
disease. It's very explicitly "any relevant link".

and I really question the value of adding new types of tags,
particularly ones that seem almost designed to be mis-used.

So I'm not violently against it, and 99% of the existing uses seem
fine. But I do note that some of the early "Closes:" tags in the
kernel were very much complete garbage, and exactly the kind of thing
that I absolutely detest.

What does

    Closes: 10437

mean? That's crazy talk. (And yes, in that case it was a
kernel.bugzilla.org number, which is perfectly fine, but I'm using it
as a very real example of how "Closes:" ends up being very naturally
to mis-use).

End result: I don't hate our current "Closes:" uses. But I'm very wary of i=
t.

I'm not at all convinced that it really adds a lot of value over
"Link:", and I am, _very_ aware of how easily it can be then taken to
be a "let's use our own bug tracker cookies here".

So I will neither endorse nor condemn it, but if I see people using it
wrong, I will absolutely put my foot down.

                    Linus
