Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7A36A50DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjB1B6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjB1B6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:58:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893F7EEE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:58:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h16so33761183edz.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677549510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5kj/tOIuYssE3nfGvgZJGSzN2o3Am/0V2s7h/8HaHc=;
        b=BsUAShZ8pW0HHowCbX3WiXBRR36o5wnDHxqee+ebCqVym9PUvnjfKqLkgU29H/SxIU
         x6NtZCJbyVRSGj+wjr7IYfiaqsLyOpc09vexbdcerpUP2Sq7HmMQKqjUPbtnfQKucKtE
         XHpLkj48IMYRmlhg1OumlalykVOLMtcndTTb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677549510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5kj/tOIuYssE3nfGvgZJGSzN2o3Am/0V2s7h/8HaHc=;
        b=Kwn2YinIef6JT8qYyFwxKPsg8gNmL9F+WwZ6CJCr+rSXosYapZorxtjU2XT9StDy2h
         VysLEHZirl1VFQ31bIZZKL5jv+4HUVp5x5qWKPhRIZmHr1ENhF/ClSgqxWON30Gab41q
         yfgJvEPMl38jFeacU6AFWi9VLvWcAQXQWbxeCFSzSP3qz6L/6HM2GrGqgimG3jbWg1IA
         ciOHzFo/edjHD/AFHeT70WZhZ2SCS60JX/n4fAlmlK7ig2eQUJorOzExRidEklPAmLLC
         MSAS/OgrG8E4W8CqEKsvbUU59/e7MArvipLHaIx9vvYnHkCO0h+GTC3Gfg7TxmDE5E8q
         J3CQ==
X-Gm-Message-State: AO0yUKUHyudtDIoM90gv440Nj+prHWn4QpaXiqHQQYF+Ut37wQr30GJG
        IGcGSDMBpbhl0RzUIHKz/BVeoQkFjXcJA8r1hyc=
X-Google-Smtp-Source: AK7set9dBVnZtG0RlaC3DXYofdBNqchtDzMOqrwfbnZ26G0AAzjATJVJplWMZIo0iNIbQolpyigw/A==
X-Received: by 2002:a17:906:5a56:b0:8af:2191:89a6 with SMTP id my22-20020a1709065a5600b008af219189a6mr784931ejc.72.1677549509988;
        Mon, 27 Feb 2023 17:58:29 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id v13-20020a1709064e8d00b008e3bf17fb2asm3958389eju.19.2023.02.27.17.58.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:58:29 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id eg37so33647783edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:58:29 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr368063eji.0.1677549508810; Mon, 27 Feb
 2023 17:58:28 -0800 (PST)
MIME-Version: 1.0
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com> <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de>
In-Reply-To: <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 17:58:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
Message-ID: <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
To:     linux@weissschuh.net
Cc:     George Kennedy <george.kennedy@oracle.com>, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
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

On Mon, Feb 27, 2023 at 5:46=E2=80=AFPM <linux@weissschuh.net> wrote:
>
> This still seems to be broken for me.

Looks that way.

> I still need the patch from
>
> https://lore.kernel.org/lkml/20230220064612.1783-1-linux@weissschuh.net/

.. and that has the same problem with "what if the error happens
during an iteration that wasn't the first, and we already succeeded
partially".

The "goto unlock_out" is bogus, since it jumps over all the "update
pos and check if we read something".

It was the correct thing to do *above* the loop, but not inside the loop.

IOW, I think the proper patch is to also turn the "goto unlock_out"
into a "break". Mind testing something like this (whitespace-damaged,
but you get the idea):

    --- a/drivers/tty/vt/vc_screen.c
    +++ b/drivers/tty/vt/vc_screen.c
    @@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user
*buf, size_t count, loff_t *ppos)
                unsigned int this_round, skip =3D 0;
                int size;

    -           ret =3D -ENXIO;
                vc =3D vcs_vc(inode, &viewed);
    -           if (!vc)
    -                   goto unlock_out;
    +           if (!vc) {
    +                   ret =3D -ENXIO;
    +                   break;
    +           }

                /* Check whether we are above size each round,
                 * as copy_to_user at the end of this loop

which hopefully really fixes this (at least I don't see any other
"goto unlock_out" cases).

              Linus
