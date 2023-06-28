Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61A1740AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjF1IJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:09:54 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52994
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233088AbjF1IFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:05:37 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E4563F266
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687937406;
        bh=2H/A8pm/xTJlyinlgGeaAVAdGnWX1hJM9NG+LfsrS7I=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=YVRMMXj+1h71+dgJVx/b9kv0/UOMsol90dZpGF6zOKb/4k12fTCbW5t4cfrV3GvSV
         tB4tcdTwVlqN60bSFI2IrNSaymZkuZ8opWkPCCeryYv5i+++XWjpFeTe0XYs/knCw5
         XygoDm9+HSaMJ7Wfmr+IMEuTrMHR/JkAh+NgTeWFNS24GilmNICNJLDVhMPSbkmNrt
         zgrgEBUtrvxujr3CmijkmNPNxJjHzDLwcKV9BHon2cd5yH7y4DcjVAyEjc7nM0LkDu
         oWXJcvM/wXzvbGtSnSojnAFZF3GyeVOwnWRyXXjo7EHCBdMSEG6rcyayNVldXPuiF1
         4G/xiosm7CX6g==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa976b8b6fso16003995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687937406; x=1690529406;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H/A8pm/xTJlyinlgGeaAVAdGnWX1hJM9NG+LfsrS7I=;
        b=ZzbsrSkL3/8h1fGDVLN1W4lIOiIsNhewOHjvQJkHOeNeLEuBjPv2hQd170MSFnuQYr
         BrIysA+AF1uqyyQA5KhyNRXtuBCgIPn/93kS7mTK9oL+cZNkAty2JJsMnGts3Yo94TPh
         nj4WtWHcXi7//aNss/4NXWn0tufDPHvOcnt5lHqODhhWWIm2654rYTgj5QV1FWtqc7yH
         43OiajiPAkPF0TEHndnLCtA6Z+pgdqGogpnbGWxeOs3Qk/27I4Z+wFQVen5dp87lmnN9
         vo/I3T3HwCLV4MI1j8uiklxPPhX+7oOBAUcJY7Vscg30DOZf4KsR+aPRq23Nv+f1roNq
         6fuQ==
X-Gm-Message-State: AC+VfDwl/fNTaK2k4uWCoekyNz2jrpE8IxYTXn0u+r19a8Ihyx0fiL6L
        aKnTIHHtytvejUzyEP+McV2YxAFfMGroYwTt+AFUMKaLIACDAMhs3N4zAshQLfvlYW4auXnRZuS
        VlapB5+hzL/F7wMD1LQ6eTCi/aiyMv9duSQE4fCNL/Q==
X-Received: by 2002:a05:600c:299:b0:3f9:ba2:5d19 with SMTP id 25-20020a05600c029900b003f90ba25d19mr23262436wmk.33.1687937406189;
        Wed, 28 Jun 2023 00:30:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7w1KT+IIiTQcXGwTespd3WObCw0fHNmgx4idP7wFhNLyiKGv/uhwZwo5x7P4xaKlLlVd6Y+g==
X-Received: by 2002:a05:600c:299:b0:3f9:ba2:5d19 with SMTP id 25-20020a05600c029900b003f90ba25d19mr23262419wmk.33.1687937405852;
        Wed, 28 Jun 2023 00:30:05 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b003f8126bcf34sm15858023wml.48.2023.06.28.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 00:30:04 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:29:46 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Message-ID: <20230628092946.00958b2c@gollum>
In-Reply-To: <2023062852-spirited-excitable-dabc@gregkh>
References: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
        <2023062852-spirited-excitable-dabc@gregkh>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eK12kAyZl1P/JjFDhv=jm04";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eK12kAyZl1P/JjFDhv=jm04
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jun 2023 08:47:12 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jun 16, 2023 at 02:20:40PM +0200, Juerg Haefliger wrote:
> > The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> > information via modinfo.
> >=20
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >  drivers/fsi/fsi-master-ast-cf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-a=
st-cf.c
> > index 5f608ef8b53c..1316bfd121fe 100644
> > --- a/drivers/fsi/fsi-master-ast-cf.c
> > +++ b/drivers/fsi/fsi-master-ast-cf.c
> > @@ -1441,3 +1441,5 @@ static struct platform_driver fsi_master_acf =3D {
> > =20
> >  module_platform_driver(fsi_master_acf);
> >  MODULE_LICENSE("GPL");
> > +
> > +MODULE_FIRMWARE(FW_FILE_NAME); =20
>=20
> No need for the extra blank line, right?

Guess not.

=20
> And what commit id does this fix?

6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire=
")

Want me to send a v2?

...Juerg


=20
> thanks,
>=20
> greg k-h


--Sig_/eK12kAyZl1P/JjFDhv=jm04
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmSb4XoACgkQD9OLCQum
QrfF/xAAgQPQlpulUegyfPVHtutQu0ENPyC6upj7Fh3qeaMacTkdkbexWytuYvYt
huxoS60/1sWnnlyxsKJ5EJcWEBIgIjlLKYKwSRnbodVbtw7nyF+DyYBtSl6K83jC
M/4FpNyTN58mHNf8id6C/TyF7EZC9M/HP2P6+kbpvXF6IgupLshis61JBeQlszB7
7NCkH+7ynvLX0p6kDLQDfssQffVsUryRzfIPkS+zC3YDuLYVqKpwrYh3l/wwOoU/
cpy/tFZ+vrN+yVyfD5Fze2gWm2G5efRPzFoPKWGkcH0/BdGlLaTs+8cUTOl+pi3x
MrP+PWtOFLBZ73ff8K1GvwyFBN01dlJ5bjA3BcD2PbnE9L0Fnoer2NnHgGbqkbpa
XiS0PEK8lCyTvMU8rU2nxJdY1HN65ZST+YDzIr9czz/39VaI9SVwPX5Wzw25tonA
Va3VoVWyZS3uTQNMvDxq8JoQRS6X7kg9+0FgvrE9V+pWsSAvBZGq7hrstIPWRKOZ
4y2WhwoDRmUL2pOSs0LeWo02RLj7ZtqeWjjgOvS1GKw7wGt34d/mQgpynSTPJETn
NB8fUQFxije50adkSz90BR1JqVho2YZaiOHwvtIAUyqaSg4uci1DPaNTUiUNY1We
/DWmqaIXThIf9yt9c5Rb6w3WWTPyFECAkfGHz0TUHg3KC4kg/w8=
=66oP
-----END PGP SIGNATURE-----

--Sig_/eK12kAyZl1P/JjFDhv=jm04--
