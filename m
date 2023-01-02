Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625865B292
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjABNVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:21:17 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212362DB;
        Mon,  2 Jan 2023 05:21:16 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f3so18334110pgc.2;
        Mon, 02 Jan 2023 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSkWLDZTpnagtlRlVfYNfgcz9t18lpyMm2kr1NP8PFs=;
        b=QZ/xZHVbUbW+EUjQjZSe1C/+Aif6Wa/hyyCwiIGIiJ0IT2DSPokiKWNFFY5Vr0qoUi
         l9TS2twjCl6FsSoLe8W0BsZ+naFrE2g4rget/c+2z+CSuN9OnNUxwP5cp4O95rtenx8j
         nEPfv2k+nqKVlY/JHM9ELKcHGqCNlIute5Y4MPhZUamn2Wd4OQCx6bQi9q4mFoq+wliK
         em4m8WYX6qMs1BG5KlogmCjg+cSFr5JVZ3oRucX++XRU3EWdFs7wGQ1TXo8eMyk2fr4Q
         pFhmwZ0P5QZ6Y+eEmdt9ylXU3jJ8Ozprt5HmVm2RKbn64glFSRXsbQPx1dCCGb7fNKoU
         aoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSkWLDZTpnagtlRlVfYNfgcz9t18lpyMm2kr1NP8PFs=;
        b=XaPiWsGIj73Qcgw8UXXy+trGg/lM/HL8JUlLkV63iM6/6p7GCAm1jqt1gf0DrnH9hK
         F6zcow8Ss4P/xx9nUk6Wyf+gqK7QibVjhpsgs8JScHyg6oAlNB9RgRPFvS+l79lFk1qg
         T/Q+q7Dko3o3rqo8FxI+4Sb3TsRzk3Uf/hUBR89+KVXbwY7/A+NX7vcqB4LoMalZDnU/
         M4svCfiXIcQcppYsnCznMda8uDAIqjSuXzibtLEE+2NFbBBDO/GZPuJIogL7GqSgla9I
         f6O0rmrPUOie/YuRc/KCOW+YJ5C6LTIxbd56TO4ez5DESRlX142NDM5ZCboTNkBWuUhL
         eNLw==
X-Gm-Message-State: AFqh2kpeS5XtgriCrqRilCiFCF491zo4xHB3cFYS/VBtqdLC/yBT06pQ
        d8GzFZZmX/Lxf4mvkyma4YM=
X-Google-Smtp-Source: AMrXdXu7X4w4321RqAMqeENd1IZfT405t/lzS0zBr2+2eQ+BtgL8g0kQ4sN33qtvjKFSHRe7xqbNYw==
X-Received: by 2002:a62:65c3:0:b0:566:900d:6073 with SMTP id z186-20020a6265c3000000b00566900d6073mr38705046pfb.24.1672665675995;
        Mon, 02 Jan 2023 05:21:15 -0800 (PST)
Received: from debian.me (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id g25-20020aa796b9000000b0057627521e82sm6248544pfk.195.2023.01.02.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 05:21:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id C61C51017FB; Mon,  2 Jan 2023 20:21:11 +0700 (WIB)
Date:   Mon, 2 Jan 2023 20:21:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@redhat.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <Y7LaR1GcoQ8uVsGh@debian.me>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
 <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Je/2KglVQyb0wHc8"
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Je/2KglVQyb0wHc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 08:45:59PM +0100, Ricardo Ribalda wrote:

> +=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +-1 Unlimited calls to kexec. This is the default setting.
> +N  Number of calls left.
> +=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +kexec_load_limit_reboot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

You need to match the length of table borders and section underline:

---- >8 ----
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index a3922dffbd474b..a64b340c3ae509 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -469,13 +469,13 @@ This parameter specifies a limit to the number of tim=
es the syscalls
 image. It can only be set with a more restrictive value than the
 current one.
=20
-=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--1 Unlimited calls to kexec. This is the default setting.
-N  Number of calls left.
-=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+-1  Unlimited calls to kexec. This is the default setting.
+N   Number of calls left.
+=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 kexec_load_limit_reboot
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Similar functionality as ``kexec_load_limit_panic``, but for a crash
 image.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Je/2KglVQyb0wHc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7LaQwAKCRD2uYlJVVFO
ox6mAPwJd+dr2pYcjPBSrmh2DO+4fkJEDz4cr9YmilzKXxOD9AEAvEwnvgKAVF+2
eX+sEuilG5QdLjp0nsxuui3Xf/UYkwM=
=LOUf
-----END PGP SIGNATURE-----

--Je/2KglVQyb0wHc8--
