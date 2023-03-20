Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0E6C229A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCTUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCTUZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:25:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813082BF3B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so4791142eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679343910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crb5gaca3LAL3QSUXcVibd0Ph4xO6N/3m0QFmJdNuPA=;
        b=BLRXv6G1ID56F82XpWEhsLLXGi6naVJ5iSbdkQA7SE/Atqr0psA60I1mjhCS3ExRmt
         kO7EB0NChmWHwqiRx7d86y1GMB4mdZiKi4Ci8uHv8ZAi7MT/jE9/gM7ABk3rBXSbr1Rd
         RSrIKRwSr296G/Su9ZKl0smQU9mGe8tS6BCT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679343910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crb5gaca3LAL3QSUXcVibd0Ph4xO6N/3m0QFmJdNuPA=;
        b=u2E9K8SYPfclpRs+KNTA9tuBVCCPdTQZQaKSORDd4lTp7GYHHCQG9UluVhXxS8PXZT
         VzdgxnDcp1RJ6z1cyER92cJfy4ZL9Kw383uaR3BwaUlcuxGuFzAQHBxT6D3M7LXwhpRQ
         RcaW7HSsq9NbkaYgel91SilY/Y+Bc20eqThXnFSoIJqRYFLXC3kJyx7jq/ioI0n2PjNQ
         VjDUypYHnALxIXpCjVk64wguOWZ2/YqBjX7b2t/R2ma+F/g9Ht6h54YqKl65jjEf9nfZ
         RH1KQ7aH1MjlJqMtObQgYxyv8qN6AFAIEZqCF9wjrmmO0TYvEufHxJF0V8UlEC3g7B85
         4MTw==
X-Gm-Message-State: AO0yUKWAntIzk1/yIhfsSYmSTFjSdT5PqHaA3P8hd3M/KSvT0oaMsN/a
        t/Cn5UO88qBthH7DjtE/9PKAeD7b7Eh0Hd8+52dMJ8tS
X-Google-Smtp-Source: AK7set/fAftRZY1rONnK0McfDovGkSsXzhpIRPTmgTmFC3xi//VX0nvkgYcKgxgVbSv0r4iSEiSHgg==
X-Received: by 2002:a17:906:538e:b0:932:177a:12a5 with SMTP id g14-20020a170906538e00b00932177a12a5mr349824ejo.66.1679343910644;
        Mon, 20 Mar 2023 13:25:10 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090610cc00b008f767c69421sm4812026ejv.44.2023.03.20.13.25.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:25:10 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id cy23so51591930edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:09 -0700 (PDT)
X-Received: by 2002:a17:906:2c04:b0:931:6e39:3d0b with SMTP id
 e4-20020a1709062c0400b009316e393d0bmr142412ejh.15.1679343909563; Mon, 20 Mar
 2023 13:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
In-Reply-To: <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 13:24:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
Message-ID: <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:27=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> 1) Pre v5.7 Linux did the open-dir-if-exists-else-create-regular-file
> we all know and """love""".

So I think we should fall back to this as a last resort, as a "well,
it's our historical behavior".

> 2) Post 5.7, we started returning this buggy -ENOTDIR error, even when
> successfully creating a file.

Yeah, I think this is the worst of the bunch and has no excuse (unless
some crazy program has started depending on it, which sounds really
*really* unlikely).

> 3) NetBSD just straight up returns EINVAL on open(O_DIRECTORY | O_CREAT)
> 4) FreeBSD's open(O_CREAT | O_DIRECTORY) succeeds if the file exists
> and is a directory. Fails with -ENOENT if it falls onto the "O_CREAT"
> path (i.e it doesn't try to create the file at all, just ENOENT's;
> this changed relatively recently, in 2015)

Either of these sound sensible to me.

I suspect (3) is the clearest case.

And (4) might be warranted just because it's closer to what we used to
do, and it's *possible* that somebody happens to use O_DIRECTORY |
O_CREAT on directories that exist, and never noticed how broken that
was.

And (4) has another special case: O_EXCL. Because I'm really hoping
that O_DIRECTORY | O_EXCL will always fail.

Is the proper patch something along the lines of this?

   --- a/fs/open.c
   +++ b/fs/open.c
   @@ -1186,6 +1186,8 @@ inline int build_open_flags(const struct
open_how *how, struct open_flags *op)

        /* Deal with the mode. */
        if (WILL_CREATE(flags)) {
   +            if (flags & O_DIRECTORY)
   +                    return -EINVAL;
                if (how->mode & ~S_IALLUGO)
                        return -EINVAL;
                op->mode =3D how->mode | S_IFREG;

I dunno. Not tested, not thought about very much.

What about O_PATH? I guess it's fine to create a file and only get a
path fd to the result?

             Linus
