Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872DD74BF12
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGHUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGHUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 16:07:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D8E40
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 13:07:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso50396351fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688846834; x=1691438834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4Vp3Erq+15doC8TaKuLyM/3Ed9sN2YSA27huRqWK3E=;
        b=DdN9gbE0dmOUglBUKd1NpEKQ0KoynKPwGIP7Yxe9xRmzSTcBuG0SJzw6xM7cDxvm0i
         zOX2zG8qWnoPnU8iB1Aki0/PCf9bu/DfRAKYBE+KySAT4i/KHbyHnuwYRNqCnP/nPFTo
         dGf/1tiT1jhYkXEhytI38Q6/8RDzWLQLJyRiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688846834; x=1691438834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4Vp3Erq+15doC8TaKuLyM/3Ed9sN2YSA27huRqWK3E=;
        b=enIvlKrDTadjJevs410lxk4qb3Gxs07XzGfT6CbZOGxPXEgrX/OAUfjK0Af15QYDos
         nAx7ANgt443+GGZUvf++fpEqf20DLpWqTduoXQtnLLMevm3Z9A+WkmzFBiZvULG8yxUf
         tyhlAgq3RmXtVwEu2mhiSgCpU0lfcGCTUOgqOo1w9T4zLx3cnd5FNLeSvHDtPHD3cnJ7
         yCfORWJ8H+733z1aU9oa66RRL24Pj3jrlrO/QSaIdzycl3mv3S3GFkwa/H+Dq5nnNHGb
         sD3A9djp68gQoWVOonJlSAj0t+E2pqY0W3U2VNGcmz9PoSUyariwV4HPKAE2bpkbwdx8
         s8MQ==
X-Gm-Message-State: ABy/qLZ/JT3xYYkSbr46NRRdzGSlKg9yvY3hjm1lQgdH4MZw6SrBYH4P
        TNKu2X2dImcdEO/m6WdiQI1UEOdZo2plYR0uT4u0Dmg0
X-Google-Smtp-Source: APBJJlEvvoFQNcz3GoMSdhyg6vMbgcpo2EPxekOSMZoa4Xdqp63jZBrHMZOoUFyW8bLbfkx5CkfkOw==
X-Received: by 2002:a19:5e06:0:b0:4f9:5a61:194f with SMTP id s6-20020a195e06000000b004f95a61194fmr6110334lfb.11.1688846834478;
        Sat, 08 Jul 2023 13:07:14 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906399600b0099329b3ab67sm3883601eje.71.2023.07.08.13.07.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 13:07:13 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31441bc0092so3027495f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 13:07:13 -0700 (PDT)
X-Received: by 2002:a5d:4b8e:0:b0:313:eb4d:6a0e with SMTP id
 b14-20020a5d4b8e000000b00313eb4d6a0emr6250669wrt.9.1688846832870; Sat, 08 Jul
 2023 13:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner> <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner> <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner> <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
 <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
 <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com> <ltbgocygx4unco6ssoiszwsgjmztyuxkqja3omvvyqvpii6dac@5abamn33galn>
In-Reply-To: <ltbgocygx4unco6ssoiszwsgjmztyuxkqja3omvvyqvpii6dac@5abamn33galn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 13:06:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com>
Message-ID: <CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read side?)
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 17:30, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Same reproducer, backtrace attached:
> $ scripts/faddr2line vmlinux splice_from_pipe_next+0x6e
> splice_from_pipe_next+0x6e/0x180:
> pipe_buf_confirm at include/linux/pipe_fs_i.h:233

Bah. I should have looked more closely at your case.

This is a buffer without an 'ops' pointer. So it looks like was
already released.

And the reason is that the pipe was readable because there were no
writers, and I had put the

        if (!pipe->writers)
                return 0;

check in splice_from_pipe_next() in the wrong place. It needs to be
*before* the eat_empty_buffer() call.

Duh.

Anyway, while I think that fixes your NULL pointer thing, having
looked at my original patch I realized that keeping the pointer to the
pipe buffer in copy_splice_read() across the dropping of the pipe lock
is completely broken.

I thought (because I didn't remember the code) that pipe resizing will
just copy the pipe buffer pointers around. That would have made it ok
to remember a pipe buffer pointer. But it is not so. It will actually
create new pipe buffers and copy the buffer contents around.

So while fixing your NULL pointer check should be trivial, I think
that first patch is actually fundamentally broken wrt pipe resizing,
and I see no really sane way to fix it. We could add a new lock just
for that, but I don't think it's worth it.

> You are, but, well, that's also the case when the pipe is full.
> As it stands, the pipe is /empty/ and yet /no-one can write to it/.
> This is the crux of the issue at hand.

No, I think you are mis-representing things. The pipe isn't empty.
It's full of things that just aren't finalized yet.

> Or, rather: splice() from a non-seekable (non-mmap()pable?)

Please stop with the non-seekable nonsense.

Any time I see a patch like this:

> +               if (!(in->f_mode & FMODE_LSEEK))
> +                       return -EINVAL;

I will just go "that person is not competent".

This has absolutely nothing to do with seekability.

But it is possible that we need to just bite the bullet and say
"copy_splice_read() needs to use a non-blocking kiocb for the IO".

Of course, that then doesn't work, because while doing this is trivial:

  --- a/fs/splice.c
  +++ b/fs/splice.c
  @@ -364,6 +364,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppo=
s,
        iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
        init_sync_kiocb(&kiocb, in);
        kiocb.ki_pos =3D *ppos;
  +     kiocb.ki_flags |=3D IOCB_NOWAIT;
        ret =3D call_read_iter(in, &kiocb, &to);

        if (ret > 0) {

I suspectr you'll find that it makes no difference, because the tty
layer doesn't actually honor the IOCB_NOWAIT flag for various
historical reasons. In fact, the kiocb isn't even passed down to the
low-level routine, which only gets the 'struct file *', and instead it
looks at tty_io_nonblock(), which just does that legacy

        file->f_flags & O_NONBLOCK

test.

I guess combined with something like

        if (!(in->f_mode & FMODE_NOWAIT))
                return -EINVAL;

it might all work.

                Linus
