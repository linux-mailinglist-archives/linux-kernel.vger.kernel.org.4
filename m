Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347E570EB87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbjEXCtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjEXCtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA43139;
        Tue, 23 May 2023 19:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D2B36380F;
        Wed, 24 May 2023 02:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DADC433EF;
        Wed, 24 May 2023 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684896558;
        bh=kSGZ55rsr5dJiLWkpkFLBLP8jA/WSpaddfGvMXXt2cw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=oKCBjoYByiTTnC+hvePx7mbaMWltTpxzyziUztwHJ1UJsCTiSCnHkdqU/rEz+Y3BC
         c5Q7W7i6rLHlYZ0gyYgBVGsMHm++u5iIK+qnm5oG5/vM9UILu3kb+Jw02U+slBqpVg
         jzfrfXunTDDnkOcolYha/kXab3DB2vL2KUehKX5PizLM6J1aNNIJc5A3k37BVDg1hD
         RKCbKDPnrSGUE8fMG1mwyR9yeZDKijLOy0jI8wubrpSxUeq1ALEUW7pY2+shTe2s5/
         BrdRTlJioSbsr3blvg1tB7n62nTRS5EbYwKN37H1j6cNrBvzs/OrF31dPj6xlCdUk9
         vEQxe/4HD9zVQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 05:49:14 +0300
Message-Id: <CSU5ZBMDTF20.1SZ9MIKVP9L45@suppilovahvero>
Cc:     "Azeem Shaikh" <azeemshaikh38@gmail.com>,
        "David Howells" <dhowells@redhat.com>,
        <linux-hardening@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Replace all non-returning strlcpy with strscpy
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.14.0
References: <20230518041513.1669386-1-azeemshaikh38@gmail.com>
 <CSPLMMXED66E.AMJRQGTPHKIS@suppilovahvero>
 <CAHC9VhT6qfX9B=nhZNeyOsiaA-vg4bBm=rx8BGiVPCTK1g-L7g@mail.gmail.com>
 <CSU5WB51YOBW.3IYPGJ2QG8GLK@suppilovahvero>
In-Reply-To: <CSU5WB51YOBW.3IYPGJ2QG8GLK@suppilovahvero>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 24, 2023 at 5:45 AM EEST, Jarkko Sakkinen wrote:
> On Sat May 20, 2023 at 12:11 AM EEST, Paul Moore wrote:
> > On Thu, May 18, 2023 at 2:01=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > > On Thu May 18, 2023 at 7:15 AM EEST, Azeem Shaikh wrote:
> > > > strlcpy() reads the entire source buffer first.
> > > > This read may exceed the destination size limit.
> > > > This is both inefficient and can lead to linear read
> > > > overflows if a source string is not NUL-terminated [1].
> > > > In an effort to remove strlcpy() completely [2], replace
> > > > strlcpy() here with strscpy().
> > > > No return values were used, so direct replacement is safe.
> > > >
> > > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strlcpy
> > > > [2] https://github.com/KSPP/linux/issues/89
> > > >
> > > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > > ---
> > > >  security/keys/request_key_auth.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/keys/request_key_auth.c b/security/keys/reque=
st_key_auth.c
> > > > index 41e9735006d0..8f33cd170e42 100644
> > > > --- a/security/keys/request_key_auth.c
> > > > +++ b/security/keys/request_key_auth.c
> > > > @@ -178,7 +178,7 @@ struct key *request_key_auth_new(struct key *ta=
rget, const char *op,
> > > >       if (!rka->callout_info)
> > > >               goto error_free_rka;
> > > >       rka->callout_len =3D callout_len;
> > > > -     strlcpy(rka->op, op, sizeof(rka->op));
> > > > +     strscpy(rka->op, op, sizeof(rka->op));
> > > >
> > > >       /* see if the calling process is already servicing the key re=
quest of
> > > >        * another process */
> > >
> > >
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > Since you maintain this code Jarkko, are you planning to merge this
> > into your tree or would you prefer the KSPP folks merge it?
>
> I can pick it.

Applied.

BR, Jarkko
