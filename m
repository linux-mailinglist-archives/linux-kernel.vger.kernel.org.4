Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9E6F9668
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 03:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjEGBEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 21:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjEGBEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 21:04:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB51A5C5
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 18:04:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-61a80fcc4c9so15659546d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 18:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683421482; x=1686013482;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8TaU10t6e1crcJD/aCOWvVye8CBgY+4/D6wMFZItto=;
        b=EyyUIDNmeK4fc5AoJBHy4YKLtvKIpmXQ6WF45bo4TXNdLMW0gg3qO1ARfP2S7WbZx5
         3EgjTyF2Yg12ee1zz+Y+4ZxDYb9vNQPaepDhbzIj0E1ZFZ6Q2Im7rybMeYKAZHgbpcDX
         ukwphnLcJAT4qJW+QBrMYWYetVChbK7yrK+LMu7H7TXJhGr6C+NYuaQoTwQFyh6B8eZy
         KZ3NfrbAaJTeXrFl47o3bsN0VY353uVG8QzrG2acIh5EYZIppj4Y/cexPRPhlxcFzPEg
         +ljgeZt9yJ1VoZCs3RM8rH3tRT2/8IT4PfHJ9C1I/W/snh55+KH3Z58nDrfuJZGlU2Vq
         34ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683421482; x=1686013482;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8TaU10t6e1crcJD/aCOWvVye8CBgY+4/D6wMFZItto=;
        b=aBFdVMpaXQzg193+m2YCyArRd9eJaZqKOywKbHH3Rov0f2S9b0yNPnnj+wTdL14k9y
         gZ5V+478bXsSEqSuzaemVeRIphTSRiBUYDLQQiA0CI7q28+QFkW3uGdpaI97o6Hed7g5
         AIsbYj67ruyUwg4BaeTEzV8szx+7R6GS1GkFOPO1HsYrcU1WV3OXfKXVY4voH+239BCg
         NGoTkSildgnCyfzMO1/7wLMkM/qh/pT4Kyl6AKViUk2dDZr2T1zewrj+nd7zJ/ZSKbYb
         mVy1Bzux4uZnS7oXQA6ph+sy/cU75T9ZNhczM+/3DFB5k6lZpGwCXSCE3wN7FX28SiHQ
         jDNw==
X-Gm-Message-State: AC+VfDypYXhAPZ6utXLydA4XvSpDUPnJvS/R1RxvmNc/FaUC+RaKaSTA
        LCzFbcixAHgUgZTdPneaRXo=
X-Google-Smtp-Source: ACHHUZ5pcm7npKtmNk5dTaA+gehpBGSniVitWjWtkfSWvWe3UV/VctURDVm/B+rviv/LROQzxyP+MQ==
X-Received: by 2002:a05:6214:5007:b0:616:56d6:cb4d with SMTP id jo7-20020a056214500700b0061656d6cb4dmr9445621qvb.8.1683421482501;
        Sat, 06 May 2023 18:04:42 -0700 (PDT)
Received: from debian ([191.96.227.48])
        by smtp.gmail.com with ESMTPSA id z9-20020ad44149000000b005f4964785b1sm1760344qvp.0.2023.05.06.18.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 18:04:42 -0700 (PDT)
Date:   Sun, 7 May 2023 06:34:34 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Debian package build from upstream source need git repo??
 Failing...
Message-ID: <ZFb5IuPkyu1l+XNs@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <ZFbY7siXjm9hhpUB@debian>
 <CAHk-=wiA=7uuzs-JEDDrPtPbFqULGDtEYiV=K+ZW9n_BftUrSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LOrR9DLJRPBUn6uQ"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiA=7uuzs-JEDDrPtPbFqULGDtEYiV=K+ZW9n_BftUrSw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LOrR9DLJRPBUn6uQ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17:54 Sat 06 May 2023, Linus Torvalds wrote:
>On Sat, May 6, 2023 at 3:47=E2=80=AFPM Bhaskar Chowdhury <unixbhaskar@gmai=
l.com> wrote:
>>>
>>   I can vividly remember that it was working fine few months back...in f=
act
>>   building the 6.2.2 kernel. I am certainly missing the updated informat=
ion of
>>   change. The damn script just untar the tarball and build.
>
>Yes, please just use git if you build packages.
>
>We've been using git for almost 20 years now, it's become the most
>widely used SCM in the world, it's time you just laid tar-balls to
>rest as a way to distribute kernel sources.
>
>                   Linus
Sure thing. Thanks for the heads up...will follow.
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--LOrR9DLJRPBUn6uQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmRW+SIACgkQsjqdtxFL
KRXnxAgAgWC7gzNOXNXFa4Od6vwyH8dauJE7de+N+Nw2/gGySBzcDJWp42OQAXXS
mOhoPD6/HDSh+kgnPKWQrFtt+E3IetuRX3BTKxdbybYU9xenQ4N3nCwqDEGtIiG9
SmkXigMC6cIQ3reflTcJW9ABYW+Ct5CM2UJWyV7KpsT0BfqzIuXrJhnS4uBDIqtn
oUTifNdb906EV+V5jBrGGDHsIKzcGY8XTxc4oZZDrE9rsZJyN2he+iBWVntZzBST
NbZKTlwzapNn8bun6F+oPeBTk55E5EKM8pog/wNhVD3F4RSStvdEJ146o1eJhM0Q
aF/tCccVjKIAW3tn2eM/mOr+sYcLkA==
=+Ywl
-----END PGP SIGNATURE-----

--LOrR9DLJRPBUn6uQ--
