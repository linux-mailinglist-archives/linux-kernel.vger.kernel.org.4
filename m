Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC674B9C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGGW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGW6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:58:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB726A3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:58:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so312325766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688770679; x=1691362679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aiyrN/NLbtRtJ2Eno6WAqJSwgD+9i9p80n4AP4hY4BU=;
        b=A7o9wo2yJuJBZ5Mse5kTmtRKGM7/TAHejTN+89va5tKJutwu5Amq/mmvphhGfr6okE
         JLQZ+ZRuKXm6kHTjFFZ4+BrzZ3Z2u5Qer/c5NkGB4/ZFzyJYCe6DWHgqfW5x2QeX2G6e
         e86nWv3y1/+t3WQrRbnFg19yRBkYZYhwRTo40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688770679; x=1691362679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiyrN/NLbtRtJ2Eno6WAqJSwgD+9i9p80n4AP4hY4BU=;
        b=Y1ZJeRUDYpjhgt7dzQz3pgNe7jH69QsOU6bZds/pPHdOFBFS0K6RMN/rMew07cr/A4
         2qsQvHD8OdAPwZJaBRijwJFW/vaILEb1Nl7SWaoPTL5FCjJnuZBj5ZJDhXn9Vp8Pb8hF
         QvuaMpUJHcXx4eN2ziFwVXzNWCAjsufpaJ/l2gnNP5io1u4WMcxj5Y6n81+xIYAxGc14
         Ug2RDxgEEPhs5tpUUzZP4WI2IKGg2YFrmz6aBEOM7DPDGjKj9LTAtX7dBT4dWrQjDOWI
         13Q0DjazS8qTOnEFX6VEdYGiOJQXa+hiZcdmSIPIgxxR+t4UhcITdSxm2yIJLPSNnOf/
         41Dg==
X-Gm-Message-State: ABy/qLYOgEY/b5LdRlt/hgQLBCt16OcvUEM4JL1418VCnUMQMEbYliRI
        crdfX9+NXehn/KlxksuuRhU1aRLeV/V3nxqBJdRyJ+eh
X-Google-Smtp-Source: APBJJlFqvd2z1dOkJZoyOm2sK7e0QhMSPyOlq1/OUgAniTbB5qB9Wv+d60QvpUR6jfgTVPEDqpCkzQ==
X-Received: by 2002:a17:906:10dd:b0:993:e752:1a6a with SMTP id v29-20020a17090610dd00b00993e7521a6amr366436ejv.21.1688770678872;
        Fri, 07 Jul 2023 15:57:58 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id z27-20020a170906715b00b00993150e5325sm2699927ejj.60.2023.07.07.15.57.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 15:57:57 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51e292cf214so3064751a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 15:57:57 -0700 (PDT)
X-Received: by 2002:a50:fc13:0:b0:51e:251d:5cab with SMTP id
 i19-20020a50fc13000000b0051e251d5cabmr4203390edr.39.1688770677279; Fri, 07
 Jul 2023 15:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner> <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner> <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner> <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
 <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
In-Reply-To: <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jul 2023 15:57:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
Message-ID: <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read side?)
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000053b4c805ffed902d"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000053b4c805ffed902d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jul 2023 at 15:41, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> (inlined by) eat_empty_buffer at fs/splice.c:594

Ahh, eat_empty_buffer() ends up releasing the buffer without waiting for it=
.

And the reason for that is actually somewhat interesting: we do have that

        while (!pipe_readable(pipe)) {
             ..

above it, but the logic for this all is that pipes with pipe buffers
are by *default* considered readable until they try to actually
confirm the buffer, and at that point they might say "oh, I have to
return -EAGAIN and set 'not_ready'".

And that splice_from_pipe_next() doesn't do that.

End result: it will happily free that pipe buffer that is still in the
process of being filled.

The good news is that I think the fix is probably trivial. Something
like the attached?

Again - NOT TESTED.

> Besides that, this doesn't solve the original issue, inasmuch as
>   ./v > fifo &
>   head fifo &
>   echo zupa > fifo
> (where ./v splices from an empty pty to stdout; v.c attached)
> echo still sleeps until ./v dies, though it also succumbs to ^C now.

Yeah, I concentrated on just making everything interruptible,

But the fact that the echo has to wait for the previous write to
finish is kind of fundamental. We can't just magically do writes out
of order. 'v' is busy writing to the fifo, we can't let some other
write just come in.

(We *could* make the splice in ./v not fill the whole pipe buffer, and
allow some other writes to fill in buffers afterwards, but at _some_
point you'll hit the "pipe buffers are full and busy, can't add any
more without waiting for them to empty").

One thing we could possibly do is to say that we just don't accept any
new writes if there are old busy splices in process. So we could make
new writes return -EBUSY or something, I guess.

             Linus

--00000000000053b4c805ffed902d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljt6c8rj0>
X-Attachment-Id: f_ljt6c8rj0

IGZzL3NwbGljZS5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZnMvc3BsaWNlLmMgYi9mcy9zcGxpY2UuYwppbmRleCA0OTEzOTQxMzQ1
N2QuLmRmNmQzNGRiZjExNiAxMDA2NDQKLS0tIGEvZnMvc3BsaWNlLmMKKysrIGIvZnMvc3BsaWNl
LmMKQEAgLTU5MCw2ICs1OTAsMTMgQEAgc3RhdGljIGlubGluZSBib29sIGVhdF9lbXB0eV9idWZm
ZXIoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSkKIAl1bnNpZ25lZCBpbnQgbWFzayA9IHBp
cGUtPnJpbmdfc2l6ZSAtIDE7CiAJc3RydWN0IHBpcGVfYnVmZmVyICpidWYgPSAmcGlwZS0+YnVm
c1t0YWlsICYgbWFza107CiAKKwkvKgorCSAqIERvIGEgbm9uLWJsb2NraW5nIGJ1ZmZlciBjb25m
aXJtLiBXZSBtYXkgbmVlZAorCSAqIHRvIGdvIGJhY2sgdG8gd2FpdGluZyBmb3IgdGhlIHBpcGUg
dG8gYmUgcmVhZGFibGUuCisJICovCisJaWYgKHBpcGVfYnVmX2NvbmZpcm0ocGlwZSwgYnVmLCB0
cnVlKSA9PSAtRUFHQUlOKQorCQlyZXR1cm4gdHJ1ZTsKKwogCWlmICh1bmxpa2VseSghYnVmLT5s
ZW4pKSB7CiAJCXBpcGVfYnVmX3JlbGVhc2UocGlwZSwgYnVmKTsKIAkJcGlwZS0+dGFpbCA9IHRh
aWwrMTsK
--00000000000053b4c805ffed902d--
