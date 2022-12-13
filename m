Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1C64AEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiLMEVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiLMEV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:21:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D81E711;
        Mon, 12 Dec 2022 20:21:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2239542pjo.3;
        Mon, 12 Dec 2022 20:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dR2fAWpK4Jduu9OnCz3aentaZielUuEwej706VgPyF0=;
        b=nQyCrClrPJ5Hys33YUwIF867NMsA1hM033Z9vVpx70fOgctVZ8RgX3sIh/buBexmvO
         0KnxERpHb/e3lqjKZOPGmmG55JG/5TijucCb/rYnSqjPI3EuA+rOyoBRsr6qpXMANdHa
         7O4A0yTpFkoUYzssH17b0TKkD8zFIhdn56K7nmE+hPvbvhJiiPEhZOq9hHysEyO+IEJm
         KYzVp3PNL6oKmkJ9wtDP48U8Ns2h8Ml4RiSNBS87bRE3+8FhwIyKTWLxpBct2n6jS+kU
         Y7cmGavwJTnZ2iBXr9EHXKwLNqD21UCKUMClNeCCtpf+HC+dKWMF5xngl2VTMU4bvd9T
         BYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR2fAWpK4Jduu9OnCz3aentaZielUuEwej706VgPyF0=;
        b=qu/+WtENs7JqRacaD6EMVgj0tKdoUy7sQ13huHZjRvMlZvLbXpG2njN5ntxT7E9c0I
         mkSqn8DChP7NaHWHlF4ZnMTU6uk7D8NzxBm4IB00vKRRzjavNfu1Ik+nB9BtgiyXTcmr
         QxBBOkugV74zmscBh9rhalOJ3o/EEDNip3j4QpaR2gXEaTCNcQD8efMaOdHKQKDlV07D
         cj2wTCjcipx78yF+6AwXovYi217RBW6Mdk7G0N6zG0uJKEfRD6vJ33Qs38ePOUGbjiUR
         b9znIWmZZwOozeygO/TXXmmB+7dIGN+rlVV7tKeZZDCU2iY5vj2Ey98tfuJHi4mlLyey
         KhSQ==
X-Gm-Message-State: ANoB5pl5TVMXa5Lgw7vjgTSu5JCW14aoA6fYlYNLe0y+/51BPTj2XXeP
        Le5ZauMIa4szvcWMjKAUU/nY9+sIxJ0=
X-Google-Smtp-Source: AA0mqf6L6a4loKroUhF9sVmk0iZK6rTjW14KOtZ9v9tOZG6m4KFJcKClqw6BGaRL80WDEGwc53ePAg==
X-Received: by 2002:a17:902:d4cb:b0:189:d0b4:52d0 with SMTP id o11-20020a170902d4cb00b00189d0b452d0mr27106679plg.46.1670905286538;
        Mon, 12 Dec 2022 20:21:26 -0800 (PST)
Received: from debian.me (subs03-180-214-233-6.three.co.id. [180.214.233.6])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b0018975488514sm7194246plx.126.2022.12.12.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 20:21:25 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 82705100E30; Tue, 13 Dec 2022 11:21:22 +0700 (WIB)
Date:   Tue, 13 Dec 2022 11:21:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jingyuan Liang <jingyliang@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Cc:     hbarnor@chromium.org, dtor@chromium.org, seobrien@chromium.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add Mapping for System Microphone Mute
Message-ID: <Y5f9wmKPQrYYFGuz@debian.me>
References: <20221123234619.91313-1-jingyliang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kM6uoharBzp3sV1P"
Content-Disposition: inline
In-Reply-To: <20221123234619.91313-1-jingyliang@chromium.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kM6uoharBzp3sV1P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 11:46:19PM +0000, Jingyuan Liang wrote:
> This patch maps the new usage code(0x01 0xa9) to keycode KEY_MICMUTE.
> Additionally hid-debug is adjusted to recognize this keycode as well.

s/This patch maps/Map/

See Documentation/process/submitting-patches.rst for why.

--=20
An old man doll... just what I always wanted! - Clara

--kM6uoharBzp3sV1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5f9tgAKCRD2uYlJVVFO
o00OAP9OulGcLefqwb3Eis9P9pUvvUA3fcC/vPlheXhUr7I5awEAlUR6oIUoghNy
BIWlvbu4P55UzUsJgyV26benwsTl7ww=
=q9FS
-----END PGP SIGNATURE-----

--kM6uoharBzp3sV1P--
