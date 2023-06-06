Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F96724E76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjFFVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFFVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:07:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12B1720;
        Tue,  6 Jun 2023 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8h2wUeDvnp3Fch8Oa8+slI7py/Nq++3cO7nSIOkvMXk=;
        t=1686085661; x=1687295261; b=cK7jGkz8aVA6JL5+3CqLENz+cjeEEGdMeCrRUF3nxZacPF4
        C5j7CQHnOM3szVCvqrLQ1aXcuGVuYDGZVz+d+mf5v8AMq2ds/UyaLic/NJmKDrGeQ+dagvyUKeaxf
        FnYYIr3xl8h1TFXrbMbraD9uzsr20vVZGiV2gP63Gmc7ALID6dud83mofT3xD6UJJ+NWBqTAUEsgP
        pt8z8VETij7bnV5isT6dVATGx1ffPyGo87s9fFtrXRGWDtiS7DGZfZh5Pg36MRUcZ7qSUYfkiJK7F
        k1/26tvHhr3IaYzHk00Liouz4HxnLCmWeGchRm/IqLn6nSkbMGMuGDfqVNWTyw0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6dtz-00Fl1n-0j;
        Tue, 06 Jun 2023 23:07:39 +0200
Message-ID: <2017a6dba12cc7cd05aec33e8066cb7038a89a31.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] kernel-doc: don't let V=1 change outcome
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 06 Jun 2023 23:07:38 +0200
In-Reply-To: <CAK7LNASe+HWuufyANGJJ0dajzSC4LFy=x2N6erGis0+ZQkAAXA@mail.gmail.com>
References: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
         <CAK7LNASe+HWuufyANGJJ0dajzSC4LFy=x2N6erGis0+ZQkAAXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-06 at 20:15 +0900, Masahiro Yamada wrote:
> >=20
> >  ifneq ($(KBUILD_EXTRA_WARN),)
> > -  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none $<
> > +  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
> > +        $(if $(KDOC_WALL), -Wall) \
> > +        $(if $(KDOC_WRETURN), -Wreturn) \
> > +        $(if $(KDOC_WSHORT_DESC), -Wshort-desc) \
> > +        $(if $(KDOC_WSHORT_DESC), -Wcontents-before-sections) \
>=20
>=20
>=20
> Sorry, I misunderstood your intention.
> (I just thought existing env variables would be moved to Makefile)
>=20
>=20
> I do not want to proliferate env variables any more.

Oh, ok, sure.

> If you need per-flag control, maybe we can do like this?

Well honestly, I myself just want to pass -Wall, but not necessarily W=3D2
since that adds more stuff from the C compiler.

> cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
>               $(KDOCFLAGS)
>=20
>=20
> Then, users can do
>=20
>   $ make KDOCFLAGS=3D-Wall
>   $ make KDOCFLAGS=3D-Wreturn

I'd rather call it KDOC_FLAGS if you don't mind to align with
KDOC_WERROR which we have already, but sure, can do.

johannes
