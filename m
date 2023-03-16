Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891016BD7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCPSPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCPSPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:15:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E81DC0A1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:15:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so11040269edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678990525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYJvSwnafB2wDXhWUCUmFLPcfcBAINnaKZL/WPJOmlo=;
        b=GwhkNWs+P8270v2sRhIVqFsRKXW4lkuZcMkbXMEJeIye3i5srrv3nVlohl2NAlFpEK
         kcR/Vt6f48k1Us8Lk7zZDq6yn4+LUci/edDH1l7IJvyAJGQxtIU7ZNnJzfK7CSxhUIRt
         Z4A1ZjasnmP8+BqhJ/vl20UzxwzEafCs23Bi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYJvSwnafB2wDXhWUCUmFLPcfcBAINnaKZL/WPJOmlo=;
        b=M9dOa9YyddCLgoU8HPqIbV16hkQ+8kSZfUtKT+LDzaiz4j1mrhaCqRF3EnMbeMxiD3
         CBTgEfEPsyXV9zrm+SyUUJXApwzD1x12MYVIjwnnbUbrYhVNXTCgYThL2vYrZ0aFaT4M
         mKkp+vam4mB8CXihIvDrAC9rqqWisiRO1HG08J4vZ43FynoXutrJCYk/Y3LSiueGGtnJ
         zpKW22AqTSlkeStaTC2iojhVqm7suKeLRzyN8I4tT2g4lwuBvUwlrSLXApvrA5u50Q+O
         pYQ12Wf26Ey8APoJXuZGscIxC+1Q78S2K3kJzb3bX4GZP/cF8+EGcSPD0yqHs+9BjxFh
         OUlg==
X-Gm-Message-State: AO0yUKVqpEmPX6Ni9CkX5iMo1BZm73ZMB25F6vl9zyZ5YwwNnmxzgs+4
        jzEWrxSSgCYasDHVHT9fTI4ZwrWjkJSBZ3rC1tUJfQ==
X-Google-Smtp-Source: AK7set/aFYxgldOP7RQIydn3RPJT4+6k+rTABjTX1yNLUN1YrxKoyagtSID/RzhMQYfyP2Szjhuwtg==
X-Received: by 2002:a17:907:c386:b0:92f:a00c:ee52 with SMTP id tm6-20020a170907c38600b0092fa00cee52mr5703140ejc.18.1678990524848;
        Thu, 16 Mar 2023 11:15:24 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id m18-20020a17090679d200b008e204a57e70sm4080896ejo.214.2023.03.16.11.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:15:24 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id o12so11052202edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:15:23 -0700 (PDT)
X-Received: by 2002:a17:906:7d98:b0:92b:f118:ef31 with SMTP id
 v24-20020a1709067d9800b0092bf118ef31mr5672967ejo.15.1678990523434; Thu, 16
 Mar 2023 11:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
In-Reply-To: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2023 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0foAi-kPgNOq6qSHPgsfekT8N9_--usjiTynpQbqvRA@mail.gmail.com>
Message-ID: <CAHk-=wh0foAi-kPgNOq6qSHPgsfekT8N9_--usjiTynpQbqvRA@mail.gmail.com>
Subject: Re: Question about select and poll system call
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     linux-kernel@vger.kernel.org
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

On Mon, Mar 13, 2023 at 7:28=E2=80=AFPM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> There're two questions about these system calls:
> 1. According to https://pubs.opengroup.org/onlinepubs/7908799/xsh/select.=
html:
> ERRORS
> [EINVAL]
>       The nfds argument is less than 0 or greater than FD_SETSIZE.
> But the current implementation in Linux like:
>        if (nfds > FD_SETSIZE)
>                nfds =3D FD_SETSIZE
> What's the rationale behind this?

Basically, the value of FD_SETSIZE has changed, and different pieces
of the system have used different values over the years.

The exact value of FD_SETSIZE ends up actually depending on the
compile-time size of the "fd_set" variable, and both the kernel and
glibc (and presumably other C library implementations) have changed
over time.

Just to give you a flavor of that history, 'select()' was implemented
back in early '92 in linux-0.12 (one of the greatest Linux releases of
all time - 0.12 was when Linux actually became *useful* to some
people).

And back then, we had this:

  typedef unsigned long fd_set;

which may seem a bit limiting today ("Only 32 bits??!?"), but to put
that in perspective, back then we also had this:

  #define NR_OPEN 20

and Linux-0.12 also did the *radical* change of changing NR_INODE from
32 to 64. Whee..

It was a very different time, in other words.

Now, imagine what happens when you increase those kinds of limits (as
we obviously did), and you do the library and kernel maintenance
separately. Some people might use a newer library with an older
kernel, and vice versa.

Doing that

         if (nfds > FD_SETSIZE)
                 nfds =3D FD_SETSIZE;

basically allows you to at least limp along in that situation, where
maybe the library uses a 'fd_set' with thousands of bits, but the
kernel has a smaller limit.

Because you *will* find user programs that basically do

          select(FD_SETSIZE, ...)

even if they don't actually use all those bits. Returning an error
because the C library had a different idea of how big the fdset was
compared to the kernel would be bad.

Now, the above is the *historical* reason for this all. The kernel
hasn't actually changed FD_SETSIZE in decades. We could say "by now,
if you use FD_SETSIZE larger than 1024, we'll return an error instead
of just truncating it".

But at the same time, while time has passed and we could do those
kinds of decisions, by now the POSIX spec is almost immaterial, and
compatibility with older versions of Linux is more important than
POSIX paper compatibility.

So there just isn't any reason to change any more.

> 2. Can we unify the two different system calls? For example, using
> poll(...) to implement the frontend select call(...), is there
> something I'm missing for current implementation?

No. select() and poll() are completely different animals. Trying to
unify them means having to convert from an array of fd descriptors to
several arrays of bits. They are just very different interfaces.

Inside the kernel, the low-level implementation as far as individual
file descriptors is concerned is all unified already. Once you just
deal with one single file descriptor, we internally use a "->poll()"
thing. But to *get* to that individual file descriptor, select() and
poll() walk very different data structures.

                  Linus
