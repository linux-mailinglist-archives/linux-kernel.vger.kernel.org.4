Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62744681781
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbjA3RWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbjA3RWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:22:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D434C15;
        Mon, 30 Jan 2023 09:22:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AF14B815CC;
        Mon, 30 Jan 2023 17:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F310CC4339C;
        Mon, 30 Jan 2023 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675099335;
        bh=03hSL6acGWc0Byt9YYZSo2iTHRm7bOfdYaaKNojuozo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bJdjq/Iqt8KuT+RD0iDH/Oyahjfy5w8RxkYBX4s17uO0tmB2m+90k2TkG3nTj81gq
         iVvvpVB9V9swAyoF0PhJq9JUJlWl7Yrg93aNwGkEXwCT7BfkTUwY06SRwDtzbUXZsf
         bdWnlr3uWz0UeEiRWAEmUMqR2L6/c7XFZ4GcQE7kkWDdkU24gMz6CDyV2yAUTyG+VP
         Ryf9pYRb+HOebrO6it7WrMdJtdVcgSzA9aL9nsABJA/H10OX9HJgT8vTBjWzUZGKfD
         XxPKHNgd/TRYEL+prrGJvJ1c8YU4M+VvLIW3ZlW0zUU6Y6UcOBW01uiQoeznwBu631
         MNpep+xdHnTKw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15fe106c7c7so15912374fac.8;
        Mon, 30 Jan 2023 09:22:14 -0800 (PST)
X-Gm-Message-State: AO0yUKVc3m1qKJI8lAPVvz7NZHjkp3/+2co2uhCB0euGz4GjTHI/Lp8j
        vTuiY//vsMwHwL5NChQDUP3qW5RJ79psEV+ypHg=
X-Google-Smtp-Source: AK7set/fOymBqDlqF808yExuXiQ1MXOc/8RuMw5/irGSyjWkwyxyZu30ome2C0UCd2NPabNyQ6vshdtvUa+Kvz7S6FA=
X-Received: by 2002:a05:6870:330b:b0:163:a45a:9e41 with SMTP id
 x11-20020a056870330b00b00163a45a9e41mr393587oae.194.1675099334181; Mon, 30
 Jan 2023 09:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20230130141553.3825449-1-jlu@pengutronix.de> <20230130141553.3825449-2-jlu@pengutronix.de>
 <CAK7LNAReD_97qWRT8f47VKx9cScTWUJcHNkUyhXQoMAYPwAPUQ@mail.gmail.com> <faf0b767d910f11c0e9b458614e002534880e12a.camel@pengutronix.de>
In-Reply-To: <faf0b767d910f11c0e9b458614e002534880e12a.camel@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 02:21:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATa8jxRzbf7Wec3WYtBW7-DF2c+uMi+wjJddHziWquQ3g@mail.gmail.com>
Message-ID: <CAK7LNATa8jxRzbf7Wec3WYtBW7-DF2c+uMi+wjJddHziWquQ3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] certs: Fix build error when PKCS#11 URI contains semicolon
To:     =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 1:43 AM Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:
>
> On Tue, 2023-01-31 at 00:18 +0900, Masahiro Yamada wrote:
> > On Mon, Jan 30, 2023 at 11:16 PM Jan Luebbe <jlu@pengutronix.de> wrote:
> > >
> > > When CONFIG_MODULE_SIG_KEY is PKCS#11 URI (pkcs11:*) and contains a
> > > semicolon, signing_key.x509 fails to build:
> > >
> > >   certs/extract-cert pkcs11:token=3Dfoo;object=3Dbar;pin-value=3D1111=
 certs/signing_key.x509
> > >   Usage: extract-cert <source> <dest>
> > >
> > > Add quotes to the PKCS11_URI variable to avoid splitting by the shell=
.
> > >
> > > Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/c=
onfig/auto.conf")
> > > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> > > ---
> > >  certs/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/certs/Makefile b/certs/Makefile
> > > index 9486ed924731..cda21811ed88 100644
> > > --- a/certs/Makefile
> > > +++ b/certs/Makefile
> > > @@ -67,7 +67,7 @@ $(obj)/system_certificates.o: $(obj)/signing_key.x5=
09
> > >
> > >  PKCS11_URI :=3D $(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY))
> > >  ifdef PKCS11_URI
> > > -$(obj)/signing_key.x509: extract-cert-in :=3D $(PKCS11_URI)
> > > +$(obj)/signing_key.x509: extract-cert-in :=3D "$(PKCS11_URI)"
> > >  endif
> > >
> > >  $(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_=
SIG_KEY)) $(obj)/extract-cert FORCE
> > > --
> > > 2.30.2
> > >
> >
> > Instead, how about this?
> >
> >
> >
> >
> > diff --git a/certs/Makefile b/certs/Makefile
> > index 9486ed924731..799ad7b9e68a 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -23,8 +23,8 @@ $(obj)/blacklist_hash_list:
> > $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> >  targets +=3D blacklist_hash_list
> >
> >  quiet_cmd_extract_certs  =3D CERT    $@
> > -      cmd_extract_certs  =3D $(obj)/extract-cert $(extract-cert-in) $@
> > -extract-cert-in =3D $(or $(filter-out $(obj)/extract-cert, $(real-prer=
eqs)),"")
> > +      cmd_extract_certs  =3D $(obj)/extract-cert "$(extract-cert-in)" =
$@
> > +extract-cert-in =3D $(filter-out $(obj)/extract-cert, $(real-prereqs))
> >
> >  $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>
> Thanks, this works im my tests, too.



Can you send v2, please?

I do not come up with a cleaner way for 2/2,
so I am fine with it.







>
> Regards,
> Jan
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|



--=20
Best Regards
Masahiro Yamada
