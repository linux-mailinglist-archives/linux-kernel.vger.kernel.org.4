Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA1972A435
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjFIUP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFIUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:15:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82C30C0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:15:52 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 43C393F36B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686341750;
        bh=j0obZYvF5npFEANWqiJVq0rgTcDAftz4pIbks69KDts=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=h5fw4jEv17k092SY0FfBAPabV1qhDegVvjJoQlszVbm1VvK/eM4qEtZehCGrLNg4C
         jcwGfvjECEeuQtt6174Fweu92NEc+9iauMuVfriDYTIMJjRy68JR1xFeTMNPQO5KwV
         7qjtI6zzvO4SesljoV3mwU1+qYlxzjbKtPTC47thdOUDceGJXdRIPDQPgfppaP3BEr
         /RmmBHA5TVWqJplOJiBkSDaAJETW8z1jv4aCNBYMVmyc8LM9G39QR3fMrxNe2ve853
         8ALrEbPT2Z3ncEBLXTN7nYvSLF/LKrhPW+vcOyPbRUmN0FHCnLrsJRyVdx/YLs4mSu
         9SJ+JvMYwUe/A==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9715654aba1so257614366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341749; x=1688933749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0obZYvF5npFEANWqiJVq0rgTcDAftz4pIbks69KDts=;
        b=SpWq9MMO56FpgI/4FRL1WBxwQ/B9Dhrp1G3TPhWuUEPuxnNnUV8MeNhxYgRV3wZpav
         xz1tdIaULNpfVN2VBq1oRCssGxTnBaeJuy7DgYnFifMBNGYNP28MuaQEtvjn96cvOwSx
         FPyLSw+Omo7CUf3ul3J83q6aTQ+eiIYOMIMxPcWhlUAdYcn2RPdRwyPwXTkODgMCA2BB
         jlidhYQxcmN/l8i4bPNxkZlOkKmGG34KKy4A/XUHRAjNBQ42wZdSHv2XyqO8LyDFC3vt
         9Cyx2mBYeq4xGQL1hck2Ot6IWErPXXCMZ1IlLRBrjN9V+kgWTOmGOUfnVHpMcoU6lgJM
         wzuA==
X-Gm-Message-State: AC+VfDxunrbp0Y5mp/j6+ubFShTgO7DXr3VRzbmoZ1POKY3ALTK7z+V1
        tXH5ApnrAKiYySIDJ8HS2nP8okEA4fRcWQvb0fi+KSrUyJAaxbu4cgOCYbyFZn3EZYKt9uKlbgV
        /cYXfMq9ibdcTy6ALsTR505yesUi6O5tibmOpsfuOPrZ5sqK47tQ4aUq47g==
X-Received: by 2002:a17:907:2d25:b0:978:8685:71d5 with SMTP id gs37-20020a1709072d2500b00978868571d5mr3453874ejc.30.1686341749598;
        Fri, 09 Jun 2023 13:15:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7voUPKBcau3WbBBCC3ecETNfAN9X7oKja2XDW+v2aCad+ilWsGH2OpuP96F3DEC902VAO+n3N1GLBO5MWkRNE=
X-Received: by 2002:a17:907:2d25:b0:978:8685:71d5 with SMTP id
 gs37-20020a1709072d2500b00978868571d5mr3453861ejc.30.1686341749377; Fri, 09
 Jun 2023 13:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230609164324.497813-1-magali.lemes@canonical.com>
 <20230609164324.497813-2-magali.lemes@canonical.com> <20230609105307.492cd1f2@kernel.org>
In-Reply-To: <20230609105307.492cd1f2@kernel.org>
From:   Magali Lemes do Sacramento <magali.lemes@canonical.com>
Date:   Fri, 9 Jun 2023 17:15:38 -0300
Message-ID: <CAO9q4O1SctX1323-8JDO0=ovsLfNpv4EjOSdP_PwYDJ76tAQiQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] selftests: net: tls: check if FIPS mode is enabled
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jakub.

On Fri, Jun 9, 2023 at 2:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  9 Jun 2023 13:43:22 -0300 Magali Lemes wrote:
> > diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftest=
s/net/tls.c
> > index e699548d4247..0725c60f227c 100644
> > --- a/tools/testing/selftests/net/tls.c
> > +++ b/tools/testing/selftests/net/tls.c
> > @@ -25,6 +25,8 @@
> >  #define TLS_PAYLOAD_MAX_LEN 16384
> >  #define SOL_TLS 282
> >
> > +static int fips_enabled =3D 0;
>
> No need to zero init static variables, but really instead of doing
> the main() hack you should init this to a return value of a function.
> And have that function read the value.
>
> >  struct tls_crypto_info_keys {
> >       union {
> >               struct tls12_crypto_info_aes_gcm_128 aes128;
>
> > @@ -311,6 +317,9 @@ FIXTURE_SETUP(tls)
> >       int one =3D 1;
> >       int ret;
> >
> > +     if (fips_enabled && variant->fips_non_compliant)
> > +             return;
>
> Eh, let me help you, this should really be part of the SETUP() function
> but SETUP() doesn't currently handle SKIP(). So you'll need to add this
> to your series:

May I add your Suggested-by tag to this upcoming patch in this patchset v3?
