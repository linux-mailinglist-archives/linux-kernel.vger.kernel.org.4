Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B971FE9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjFBKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjFBKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:09:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F81B6;
        Fri,  2 Jun 2023 03:08:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256712d65ceso869457a91.1;
        Fri, 02 Jun 2023 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685700535; x=1688292535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJXA2dF12j4Fb3Ta+K6rkvK8zj4+C8MbngTwWrfwo10=;
        b=pKozTKg8bkqoQRAw4Or1/2O3jhNTORXzV0T2l2OubLw3KGl5/I6zCtOTsidD9yC5ZN
         kynmkimoC6akMvLQ7qppsxXl9hUbACdXysk4pUXwE8mvIMLOefP7b6G/w1eY5dgCXSJ9
         gOzN/3y8qFFgzT5xx3v8Zkm1YN5YqH5s2OEPxQuBYFrwsXb8lzoEeEeO6Hou7xwCYYAh
         JrilTMh66/iRuPtRJIWL0+X/jZmsUtj8muQHWh5m4rrBLE0TU8UMRAFifbNXJVdx+mjp
         EJyYdBASIrnkttxOgDlgjYSJWsEYyEgLFx+M8XYPxai2fAKsIonHyE9TOkvPxAAb11pQ
         nxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700535; x=1688292535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJXA2dF12j4Fb3Ta+K6rkvK8zj4+C8MbngTwWrfwo10=;
        b=aOLFrn0YoMWAGf1HJMCXjpCBUf8e5cehsNPotgQ/d1tILgv0VPwOrVlhncPh4+j/6H
         MF3V5fdIxkizLJQ2z/hlnwLHboZG4+9qjjVKULYiDmbgmiBfVVh+CULny/dVFKEUB7JS
         ifVjh3Sbb5QnCrSKRHZSINZ3LzhtisCJ8cja+63rmM0wKWTkPNJT2WMtZpBxfBgZfW6S
         1xxZ94f8RHfIEOVWNDpsIUout1hk5u4Ol8kCSfwEisvA69V1SAWPvo4DlvluZVB+yAc3
         yzrshaJZE+nNC7DfavDCh/WeHyC/wbTiURz8CgNQ9n/tLmeHYFStMFPTbiJbUkjhi+MI
         2ajQ==
X-Gm-Message-State: AC+VfDxjYQYcovHbhR81ZF3EubXVmrKUIcTdPSD+RalcAjMLmeXVshVr
        9yU7hpsYHhL7HJ7oXG9QexVtaGxNtmU=
X-Google-Smtp-Source: ACHHUZ5NMghrvOYiQcrgDDURUUe2m+/zTpIzGsO5lBtXx5es280eqgOGpqaD3QSBm4mosQoHfp0YSg==
X-Received: by 2002:a17:902:bb10:b0:1ab:63e:67b0 with SMTP id im16-20020a170902bb1000b001ab063e67b0mr899784plb.54.1685700534901;
        Fri, 02 Jun 2023 03:08:54 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b001b19d14a3d5sm992095plb.68.2023.06.02.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:08:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 93BBC106A05; Fri,  2 Jun 2023 17:08:51 +0700 (WIB)
Date:   Fri, 2 Jun 2023 17:08:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] Documentation: subsystem-apis: Categorize remaining
 subsystems
Message-ID: <ZHm_s7kQP6kilBtO@debian.me>
References: <ZHgM0qKWP3OusjUW@debian.me>
 <20230601145556.3927838-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rQ+siVK50HQ8TR+2"
Content-Disposition: inline
In-Reply-To: <20230601145556.3927838-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ+siVK50HQ8TR+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 05:55:55PM +0300, Costa Shulyupin wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> Add classes:
> * Core subsystems
> * Storage
> * Networking
> * Peripherals and devices
> * Embedded systems
> * Integrity
> * Virtualization
> * Miscellaneous

Above list is unnecessary, because the diff should clearly show those
categories.

>=20
> There is a FIXME that says to organize subsystems listed in
> subsystem-apis.rst. Fulfill it by categorize remaining subsytems
> by purpose/themes, while sorting entries in each category.
>=20
> HID devices are already categorized in 3c591cc954d56e ("docs:
> consolidate human interface subsystems").
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Thanks for picking my version from v2 [1]. However, From: address in the
patch message doesn't match one from message header nor your Signed-off-by
address. Conversely, if you handle someone else's patch (in this case mine),
you need to also add SoB from him/her.

As you're still newbie here, I'd recommend you to try contributing to
drivers/staging/ first in order to gain experience on kernel developement
workflow. Also, you use your RedHat address, so I expect you have been
given kernel development training from your company (and doesn't make
trivial errors like these ones).

Anyway, I'd like to send my own version instead (incorporating feedback
=66rom this version) if you still reroll with trivial sending mistakes.

Thanks.

[1]: https://lore.kernel.org/linux-doc/ZHgM0qKWP3OusjUW@debian.me/
=20
--=20
An old man doll... just what I always wanted! - Clara

--rQ+siVK50HQ8TR+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHm/rwAKCRD2uYlJVVFO
o/ZUAQCtuYTGyPA8AC22WDnO5aWuZ+KGuo0KtrmJ+gIcaexwRgD9HOoqQ0SMGUaV
mZzZ+Di26FcMIUJgp8EMYc0VwvrZXw4=
=vBk8
-----END PGP SIGNATURE-----

--rQ+siVK50HQ8TR+2--
