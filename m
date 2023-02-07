Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6168E17B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBGTuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBGTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:49:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5733E634
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:49:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z11so686792wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEXUUXABVU5CpTmI5+WPS3SAiFl2iysjHXRNiSK+RSc=;
        b=NAsrX48xgJfvmnA63/xN8z3ZNZj9KxhAXx9sVPZSipkeGUbQZK47jEZLSxQAZsoKtm
         uQ+0JBwWNuQtqirsFeDAtYVMB9CkREBLzlQqNmAHL0HRnjhjNe2yZnNWhsT7bMRWJVeU
         +5n5j4hE+CqIu6Y+15dkIxcIqIZBV5aROnWdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEXUUXABVU5CpTmI5+WPS3SAiFl2iysjHXRNiSK+RSc=;
        b=UCYhlACzKSAhti3vaPnMG8yRv0lyl71xCJww5KD3D2uGyOcA/LgijarthOdNkE8mW1
         iOGkoJItQcsl1TLEuDiKX41nHFugCyxywGnULfwQFk4ussUjkmB0qi49xxMw0YSZFx2j
         FtLTYkt4665OtkInJh2qmczInPeEaiix44VP9yoIU9rHjMvY7AoDEydiWlwyEdJVUDC9
         MQj+R/n4NIG7mQDtATUSPZiGkGOdy9zQFOvprrEuAByX8/OlHZifOJBFAW4Z4VN5mPPm
         YFAwbY32ydpN/neYJFy0FocnxXPA1xVB2hITNfOjoRlJvQ/hAfoTe1tRrCIaEEue7N3+
         GAjg==
X-Gm-Message-State: AO0yUKWvXg0SAl1oCC0ya2CQ/9q98G33vHYd71ehJ3O2YX56w1ruVCtr
        BdiZC8VrBQSPk68C0l0J7IvDedn5sSk+9ETlmOB7rQ==
X-Google-Smtp-Source: AK7set/ynvWEbOt3XSvszpceV2wE7SSv0hZf97uwlYOX9efwV31y/cdP9zNB/jlbk8mj+t10mEof4A==
X-Received: by 2002:a05:6000:c8:b0:2c3:db98:3e87 with SMTP id q8-20020a05600000c800b002c3db983e87mr3674624wrx.20.1675799374285;
        Tue, 07 Feb 2023 11:49:34 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm11833009wrs.40.2023.02.07.11.49.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 11:49:33 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id dr8so45421718ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:49:32 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr1026268ejw.78.1675799372087; Tue, 07 Feb
 2023 11:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com> <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com> <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
 <Y+KoGikLhfhDoMWv@gmail.com>
In-Reply-To: <Y+KoGikLhfhDoMWv@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 11:49:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdCBPH0WYK-D5q60u1hvwTabKETWTsEKYXNRgx4tGOPA@mail.gmail.com>
Message-ID: <CAHk-=whdCBPH0WYK-D5q60u1hvwTabKETWTsEKYXNRgx4tGOPA@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 11:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> The point of the "test_dummy_encryption" mount option is that you can just add
> it to the mount options and run existing tests, such as a full run of xfstests,
> and test all the encrypted I/O paths that way.  Which is extremely useful; it
> wouldn't really be possible to properly test the encryption feature without it.

Yes, I see how useful that is, but:

> Now, it's possible that "the kernel automatically adds the key for
> test_dummy_encryption" could be implemented a bit differently.  It maybe could
> be done at the last minute, when the key is being looked for due to a user
> filesystem operation, instead of during the mount itself.

Yeah, that sounds like it would be the right solution, and get rid of
the fscrypt_destroy_keyring() case in __put_super().

Hmm.

I guess the filesystem only ever sees the '->get_tree()' call, and
then never gets any "this mount succeeded" callback.

And we do have at least that

        error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
        if (unlikely(error)) {
                fc_drop_locked(fc);
                return error;
        }

error case that does fc_drop_locked() -> deactivate_locked_super() ->
put_super().

Hmm. It does get "kill_sb()", if that happens, so if

 (a) the filesystem registers the keys late only in the success case

and

 (b) ->kill_sb() does the fscrypt_destroy_keyring(s)

then I *think* everything would be fine, and put_super() doesn't need to do it.

Or am I missing some case?

                Linus
