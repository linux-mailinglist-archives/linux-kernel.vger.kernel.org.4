Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8953F6EE286
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjDYNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjDYNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:12:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33567D313
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:12:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b73203e0aso35297344b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428328; x=1685020328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAMdrwEloKtNA/havf7YfFDHE9H6oI5V7/zQhrsC9UQ=;
        b=YCKoDAxNW1M251OBmJsiCTrBVP+9G4Pz0e+DFgtAzXe04NN2UPzUvwlDVW1ZQy6oq6
         DjWvR/uo4xvawQtS5dUyoFP6ADw1nTPtit4//lQW9ww+4YT5u2rNsyiEzvKO24IKrg1W
         N04VdM8Ejcp5Ko/ynvX/hWV6kn7hVdwZfArc/Jgvcn7ocHshr+VHbY/Or6//mWxHhKpQ
         r0bOmq6cOIvSTEHpCAxM95NMyPbiqLBw4KoNucP1dVz9qkN7Pn+jqfkt/dVwsoB6er8L
         Qy4EvqIRQCD+h7SdtTBBY3I2F/F3dkcL8884x1vk587B2kPgHV4hDqT4MiYjgfYPzr5J
         Quxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428328; x=1685020328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAMdrwEloKtNA/havf7YfFDHE9H6oI5V7/zQhrsC9UQ=;
        b=Fyo9I4Uz+tz5+LJfP8udFQs6nna8vjSdHLvMP5V3SVLeatvRZjwu2eO9kc6nEnm+UR
         Yhetht5rqDq0qKbq0JZtgIJVoWyO23cEi9AHL8vbHtMFZbpy9Ma2Y1Tao8VwnUD6CBUg
         yOIj/xnj9T5oBtFaHjb5hNqqnCd563bYVC+kdY1uDc5jPjItuxebKBlNMguRCwNDxTVW
         w9J4aEkZGwlvY5RD9saw3N0NaTcNzenZF4AwyU2N03ndmOakZpc4745p5xrVARORqNA4
         dUjsI6grDE71wGCsvn+zANqbQ6GP19hrjK9bk38RUg5v811Il45c3+uG6T2Coj6ORjo2
         GzAQ==
X-Gm-Message-State: AAQBX9cvJxuS1VoAUOTQ9gjqmXgXLcwY/SbREYhdnlVR4hJtWd6ntqMO
        1uJcm4Zd+QNH1TRJ24yM48A=
X-Google-Smtp-Source: AKy350bjK+QP3BjltywRoiVfbi6HR+lrIvKhdHgcYcTTEfqQ5VtMTN+RZ5YkhoRmwsra3fdBCnQTgg==
X-Received: by 2002:aa7:8896:0:b0:636:e0fb:8c45 with SMTP id z22-20020aa78896000000b00636e0fb8c45mr19935943pfe.16.1682428328477;
        Tue, 25 Apr 2023 06:12:08 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b0063b7a0b9cc5sm9252646pfv.186.2023.04.25.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:12:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 16D38106980; Tue, 25 Apr 2023 20:12:03 +0700 (WIB)
Date:   Tue, 25 Apr 2023 20:12:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Raj J Putari <jmaharaj2013@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>
Subject: Re: programming tips
Message-ID: <ZEfRozHy0Gi5H6LS@debian.me>
References: <CADXzsihkMLoWoPh+WfF99HkvVUGNtD44nEor8Fqg38z1Coi3HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8fuP71+RO6+Y4jF4"
Content-Disposition: inline
In-Reply-To: <CADXzsihkMLoWoPh+WfF99HkvVUGNtD44nEor8Fqg38z1Coi3HQ@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8fuP71+RO6+Y4jF4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 04:07:27AM -0700, Raj J Putari wrote:
> i can do
> int x =3D cpu_read(code) =3D return_value_that_you_seek;

Is it same as:

```
int x =3D cpu_read(foo)

if x =3D=3D <desired return value> {
	/* do something */
}

```
?

>=20
> additionally i feel that, with security, that there should be a local
> sql server tied to the linux kernel, so you can do stuff like easily
> share data in a lan

Implementing SQL language in the kernel? Making MySQL/PostgreSQL/SQLite
obsolete? How about prepared statements and input sanitation? Last but
not least, why is it hard for you to use wrapper libraries to SQL in
your userspace program to the point that you want kernelSQL?

I'm confused...

--=20
An old man doll... just what I always wanted! - Clara

--8fuP71+RO6+Y4jF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZEfRnQAKCRD2uYlJVVFO
o2q6AP9IE68VPz8UnqBPLAJXKzJHyT+Itg5MP6q5LqGG90EvUAD+LscZW714hlPQ
3YZaw9zYpqkAQNjhLQPIK/xcWvHacwY=
=o/FO
-----END PGP SIGNATURE-----

--8fuP71+RO6+Y4jF4--
