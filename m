Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74470A158
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjESVLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:11:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A100E49
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:11:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba865ac594bso4994109276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684530685; x=1687122685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+uaRp35edSG069t4QPppFZtHmznzJV890/JpydoWIU=;
        b=BoAQWGg0fziT/zVOVPWH8PYtpVitBPaeeLVUk6R+L4oeMGFKwW6WTKJ2ZDypPIE3bt
         J4WVeUN5h4QgL2ors+1VSujBWlV+PnUarViclLLYozjpkzUGoTsnJvL380CWK8Y/L+N3
         DLCbDZg/BiXn9VdPtJFsDPyXubDjRGGde3mKYPr5jvA+vdJrcLjl/G78IoSpk4DCBEnw
         KLh+wxbi0evsny8MySXRD4wMDEdsvSFHaRNU9BBBXzSOnyHXajoATGr8RDIRXzKKPfq4
         1J7K73sdoKIEAQvsUPGqkR5o32uS6Zs0n9mblErc+1+fUQeTVGixsnaoxna613FD86ls
         WBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530685; x=1687122685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+uaRp35edSG069t4QPppFZtHmznzJV890/JpydoWIU=;
        b=P15HI6nnbzNLhBk/jMiNX+RsmNc7PYvkUFG/8zZ+W72q715eXY0SGCdfsmhXEYO9vL
         gPO1xnw1XZg7CZ1dy1dNGn4UWwrtf6QJQaI+45mTch+Ru5MlRkh0gWqyIqpCK1dzFm2s
         W0tdg1EtI12mQ96DkdQQOJzQeizuG91A5Q+AmhB6JmF85bi+wIVGA7Jhji3xsgktoAfd
         iYORv3n60NY0JV5LYU8gWyf6ytxNM2IhkZwDscwpFgL2czUbGtanls+Z2oFN7pqOM/Iz
         SSuVpUTuD4no+ZPAHtQ2Oayn78XToBLVzrP13LrSqUNNo1R6HcYw0kjCB8V8bBAahNq/
         xkfw==
X-Gm-Message-State: AC+VfDzbU1kYHTLQ6WPvgN7vrwnVKOSSiS4LqelVaqCzYz9kjghzEp/A
        KQ/aqQT1t3f4fBPfsBXAIYKqMQxdWVr0JH2yg2Of
X-Google-Smtp-Source: ACHHUZ4f7bhfrf+CH5u40Igxst9OQUQGConCJcAscKSMQL/ATBnkacZF2ihDM40uCMIzetmJwXGL548xnpiUd+tsV7E=
X-Received: by 2002:a25:da91:0:b0:ba7:ddd2:9909 with SMTP id
 n139-20020a25da91000000b00ba7ddd29909mr3054255ybf.33.1684530685318; Fri, 19
 May 2023 14:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230518041513.1669386-1-azeemshaikh38@gmail.com> <CSPLMMXED66E.AMJRQGTPHKIS@suppilovahvero>
In-Reply-To: <CSPLMMXED66E.AMJRQGTPHKIS@suppilovahvero>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 17:11:14 -0400
Message-ID: <CAHC9VhT6qfX9B=nhZNeyOsiaA-vg4bBm=rx8BGiVPCTK1g-L7g@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Replace all non-returning strlcpy with strscpy
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 2:01=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Thu May 18, 2023 at 7:15 AM EEST, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> >  security/keys/request_key_auth.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/keys/request_key_auth.c b/security/keys/request_k=
ey_auth.c
> > index 41e9735006d0..8f33cd170e42 100644
> > --- a/security/keys/request_key_auth.c
> > +++ b/security/keys/request_key_auth.c
> > @@ -178,7 +178,7 @@ struct key *request_key_auth_new(struct key *target=
, const char *op,
> >       if (!rka->callout_info)
> >               goto error_free_rka;
> >       rka->callout_len =3D callout_len;
> > -     strlcpy(rka->op, op, sizeof(rka->op));
> > +     strscpy(rka->op, op, sizeof(rka->op));
> >
> >       /* see if the calling process is already servicing the key reques=
t of
> >        * another process */
>
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Since you maintain this code Jarkko, are you planning to merge this
into your tree or would you prefer the KSPP folks merge it?

--=20
paul-moore.com
