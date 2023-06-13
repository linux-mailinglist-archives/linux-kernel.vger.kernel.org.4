Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DD72E5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjFMO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbjFMO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:26:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FC187;
        Tue, 13 Jun 2023 07:26:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30fc2b44281so2053118f8f.2;
        Tue, 13 Jun 2023 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686666408; x=1689258408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=konsMZ3reRTolwDihwoeXz+ajl61Wy3hEw0nKZVPrR4=;
        b=Ft1H9IQWTXSL2y2ZrUczjSuzRl4su4gb15wZKYUOMvVxWS20PHDOlSK/8EdfQ5ZwcV
         2KI58jAhhAaHKwfh4TNbzWF+vkKXt7KI2SGHeWZloffVM7FiT9e0cqFY6wfCPgtxlMN3
         GRfM1TUcTCse+fHJdyylGho6Ahc/Y6mBLQ8wHma+0w5zqbyjQXUK+C3I/aalvyd5ceR3
         quxe1y5KEScQTbEEOVMQS7dt/LPYZuzYO0bEGnnGLEa9dK9Eph94/nZacel1F0Qqm7UU
         FhTo+QfoB6qDw0krrTZocEoWt+1E+b6RM3wDQHWH2wnABcXT3aAbSdb9JH8vJDmSf4KO
         /pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666408; x=1689258408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=konsMZ3reRTolwDihwoeXz+ajl61Wy3hEw0nKZVPrR4=;
        b=NBm9cpp7RSf7ks5ORY93/EOSu3XcJB5XVI/mmUmfj8iIPKzv8X6dvJ0HM9Waw1t4f3
         UqTJy5raUVA5crBGMpPa4T2hW9bwzLxqGT26/3IRawTlMLnkcidEoUy1kIdHyPFwoeQl
         l/Y0PXFPe4O/7wTFDa2GS075v/AVeI3WiwYazuzFfJj0lfIz6gHK5uBSHL+HjxENJRPZ
         aEGxgl3Paj3clyXukc9avzHnhgyYjZYTdStFvyox1BAEaZmWH+HJnqBeRVc8rCXngsf0
         kNLd3UsSUUUTpIR80iVu2pdFLqOkyDX5a/Uw0PFFjUhQkxENGI5TuNcGcZ55LKyKbM/j
         G+gw==
X-Gm-Message-State: AC+VfDzYy5auzaO4tZSsLxQSW5ExzzRec7X4JhkD+nb8s+QnGRN9PMLA
        aR9V0SgCM+GaPhZUmL02pctFZ+FnDl4m6nIEfcI=
X-Google-Smtp-Source: ACHHUZ6JadTTqAeCgCM5YqUsgDckUplenez8GoP0ndjnKiMQzLiT8p1oSMB4KYzTrfQB/yYZpzSQYiE/MUuE3hkQO+I=
X-Received: by 2002:adf:eece:0:b0:30f:b807:a632 with SMTP id
 a14-20020adfeece000000b0030fb807a632mr7165447wrp.60.1686666407496; Tue, 13
 Jun 2023 07:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230613002258.3535506-1-azeemshaikh38@gmail.com> <20230613023722.GA883@sol.localdomain>
In-Reply-To: <20230613023722.GA883@sol.localdomain>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 13 Jun 2023 10:26:35 -0400
Message-ID: <CADmuW3Ubgg=sE05J4q3v0un-MqhgMdBW3fPTZ=B_WXyTRjEm5g@mail.gmail.com>
Subject: Re: [PATCH] crypto: Replace strlcpy with strscpy
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hardening@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:37=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Tue, Jun 13, 2023 at 12:22:58AM +0000, Azeem Shaikh wrote:
> > diff --git a/crypto/lrw.c b/crypto/lrw.c
> > index 1b0f76ba3eb5..bb8c1575645b 100644
> > --- a/crypto/lrw.c
> > +++ b/crypto/lrw.c
> > @@ -359,8 +359,8 @@ static int lrw_create(struct crypto_template *tmpl,=
 struct rtattr **tb)
> >       if (!strncmp(cipher_name, "ecb(", 4)) {
> >               unsigned len;
> >
> > -             len =3D strlcpy(ecb_name, cipher_name + 4, sizeof(ecb_nam=
e));
> > -             if (len < 2 || len >=3D sizeof(ecb_name))
> > +             len =3D strscpy(ecb_name, cipher_name + 4, sizeof(ecb_nam=
e));
> > +             if (len < 2)
> >                       goto err_free_inst;
>
> This is wrong because 'len' is unsigned.  So the -EFBIG return value is n=
ot
> being checked for, so this patch actually removes the overflow check.
>

Thanks for catching this Eric. I can send over a v2 with "unsigned
len" -> "int len" if that works?

> It looks like you've sent over 60 strscpy conversion patches recently
> (https://lore.kernel.org/linux-hardening/?q=3Df%3Aazeemshaikh38+s%3Astrsc=
py).
> That's concerning because this is the only one that I happened to review,=
 and it
> introduces a bug.  There are 60 others that could have this same bug.  Ca=
n you
> please review all your patches for this same bug?
>

My previous patches replace strlcpy where the return value is ignored.
So this same bug could not have occurred in those. This is the first
set of patches where I'm attempting to replace strlcpy whose return
value is used by callers. For reference below are all my patches where
the return value of strlcpy is used. I have checked that none of these
have the same bug as here.

https://lore.kernel.org/all/20230613004402.3540432-1-azeemshaikh38@gmail.co=
m/
   // Uses int
https://lore.kernel.org/all/20230613004341.3540325-1-azeemshaikh38@gmail.co=
m/
   // Uses int
https://lore.kernel.org/all/20230613004125.3539934-1-azeemshaikh38@gmail.co=
m/
   // Replaces ">=3D buflen" with "=3D=3D -E2BIG"
https://lore.kernel.org/all/20230613004054.3539554-1-azeemshaikh38@gmail.co=
m/
   // Uses int
