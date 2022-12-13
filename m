Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DF64AFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiLMGmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:42:40 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15322D;
        Mon, 12 Dec 2022 22:42:36 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BD6gDld018514;
        Tue, 13 Dec 2022 15:42:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BD6gDld018514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670913734;
        bh=uof4Oi5ZlD/xu/NRlW/T86pqlgXeRWN0YTEJnxzGLus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AVSpwQNJLuaosDl98MioEZ2C3qUhLdyq9+9Me4XhbsmjbPB7aWVh0nXe6VQvIIs6h
         zSEdjPlvpk/klF3tyLYvdDRJHiEzuZWTpXxHUaqATZD4yNZiQnu96H6ggPtbivT6at
         yQ2CYLoHTyFQKuVS7PwrZiWxHna72ZERGEXtZYk9+6FLOUqd+jR5Dm90kEyvnduHYK
         CRQ+Jvyz0mtgbj99rStP6AzMIRGp3TbzIeP3boDt11iwte4aqB/GrB05t3KmYahxeZ
         wT3OYAYnur7NwmNAgLupBudz5npAt9xEOr/sECtcqeSZWB04rZ2PMq7UnxDDtsVK6L
         sE2RteoC+d/ag==
X-Nifty-SrcIP: [209.85.167.180]
Received: by mail-oi1-f180.google.com with SMTP id q186so13399546oia.9;
        Mon, 12 Dec 2022 22:42:13 -0800 (PST)
X-Gm-Message-State: ANoB5pnIExTONrsyLDE/3UgcpqkEbL9CrGglttlQyp2AChRoYJbSJZQ8
        ria0Poaw/+uWjGK/8NIP3c0TPPeFAD+qgoHkCBY=
X-Google-Smtp-Source: AA0mqf6ynR5REOf0PBjTspgI+eSKGT0FaXuNT7P+tPKp7jhMgInWEwXVviDRyA3kr2DMx8/bPvU6u9lsNmF0946ORwM=
X-Received: by 2002:a05:6808:aaf:b0:354:94a6:a721 with SMTP id
 r15-20020a0568080aaf00b0035494a6a721mr73151oij.194.1670913732802; Mon, 12 Dec
 2022 22:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20221211094919.2717594-1-masahiroy@kernel.org> <Y5f8/BCOpJAqKgcd@bergen.fjasle.eu>
In-Reply-To: <Y5f8/BCOpJAqKgcd@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 13 Dec 2022 15:41:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASE5rMVXPryqs_VYh2fy47CUeNiV=90dJVCP359p-LWdg@mail.gmail.com>
Message-ID: <CAK7LNASE5rMVXPryqs_VYh2fy47CUeNiV=90dJVCP359p-LWdg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: do not sort after reading modules.order
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 1:18 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sun 11 Dec 2022 18:49:18 GMT, Masahiro Yamada wrote:
> > modules.order lists modules in the deterministic order (that is why
> > "modules order"), and there is no duplication in the list.
>
> Isn't a subdirectory's modules.order just created by
> concatenation of $(obj-m) (w/ respect to mentioned subdirs)?

Not $(obj-m) directly.

The magic is $^, which is a deduplicated list
of prerequisites.


> Thus, "no duplication" seems to be true, as long as there is no obj-m
> containing duplicated entries.  Do we ensure unique entries in obj-m
> only?


The entries in modules.order must be unique.
Moreover, the basename of modules must be unique.

scripts/modules-check.sh is a stronger check.


You might be interested in these commits:

d724b578a1f746db6fc1fd5e4cbba554a855dc8d
3a48a91901c516a46a3406ea576798538a8d94d2




>
> Kind regards,
> Nicolas
>
> >
> > $(sort ) is pointless.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.modfinal | 2 +-
> >  scripts/Makefile.modinst  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 25bedd83644b..4705d32388f3 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
> >  include $(srctree)/scripts/Makefile.lib
> >
> >  # find all modules listed in modules.order
> > -modules :=3D $(sort $(shell cat $(MODORDER)))
> > +modules :=3D $(shell cat $(MODORDER))
> >
> >  __modfinal: $(modules)
> >       @:
> > diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> > index a4c987c23750..f4cff42069ad 100644
> > --- a/scripts/Makefile.modinst
> > +++ b/scripts/Makefile.modinst
> > @@ -9,7 +9,7 @@ __modinst:
> >  include include/config/auto.conf
> >  include $(srctree)/scripts/Kbuild.include
> >
> > -modules :=3D $(sort $(shell cat $(MODORDER)))
> > +modules :=3D $(shell cat $(MODORDER))
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> >  dst :=3D $(MODLIB)/kernel
> > --
> > 2.34.1
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
