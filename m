Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF866FBCE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjEICHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEICHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:07:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E412A;
        Mon,  8 May 2023 19:07:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab0c697c2bso49838375ad.1;
        Mon, 08 May 2023 19:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683598067; x=1686190067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWdXLC6ETOY0c2W6fA8rFsR/hDq8/E4z6dhUGEDMr7o=;
        b=P8cOBJSh8RIMgjYp5kMULSFbvLCMXFEeESwc4yX8s/K71W/NEptjVyNWCoDrGMARwV
         UGEyWi/NVpLKh1wdTdiSk4bOuOOUZoRo612kR/xwOHovE9dJpzmirgVstHy4cJu0IoiE
         +l/poZw1eXmMkzj5s71FVEdkMJpIOitJLzwqtgvfDV3OaDMFbvvXKGuYpL2oRMNcNgxv
         +CnMyLxlQxKjlkSk6Bxo01hls+WmB4z4LKFZNlxNOfpOey+oMHYiE0fotGbTuztD4kyQ
         CZgx3isXIUji0h6PyLfzlMGyWzfevJltIPcFrtQOuLPPNEpHs7BWy7/hQW2pvVDu9nHI
         1Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683598067; x=1686190067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWdXLC6ETOY0c2W6fA8rFsR/hDq8/E4z6dhUGEDMr7o=;
        b=aV+OL9ZVspSYZQDUgrPu4gH74ZwfuMR3XUXPqAgBsm9bDNWueIGff5kDskaN5u/Ykf
         I+CdRG1xrVIlRTETQwnN0A5R8EB+OXUubfsv7M0edMJR000cTpa4rowEoD+J8YoaBJ6w
         JcVziAYMql9DL4rUFF7TclsMtzwSL7x86aBAmA1rBCzZ82D6Gx9lwEWTe83Az84UcuAB
         7nH+/9GjpsLdSowbXWxyZTfS/6nLWGvY29fgNe77vTHMxkifXQVoyMsqKKYH6kNpoH50
         oWXFm6HuHKk50k661SDCOfu7rJuBHs6xV7/hUU4zTY3xomt8VKZxsPE+vQp8po25nnSD
         k7tw==
X-Gm-Message-State: AC+VfDwEQNbPEpjoOT5qyXiOahsw8x8+3ReGXmMsBf7yaaACGFAkxXFV
        IA1DXT2D4nA55VwJc7Q0J2w=
X-Google-Smtp-Source: ACHHUZ5ov1MWFkTimLGYY7iJ4/3pwiCCd/C8wOZ8IHQMfE/fw93gh0XgiWaK4cO2uIphN/6sDYY9QQ==
X-Received: by 2002:a17:902:e84d:b0:1ab:eee:c609 with SMTP id t13-20020a170902e84d00b001ab0eeec609mr15653688plg.40.1683598066911;
        Mon, 08 May 2023 19:07:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001a0567811fbsm163189plt.127.2023.05.08.19.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:07:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6E18910687E; Tue,  9 May 2023 09:07:43 +0700 (WIB)
Date:   Tue, 9 May 2023 09:07:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/371] 5.15.111-rc1 review
Message-ID: <ZFmq773MnSAEzJKs@debian.me>
References: <20230508094811.912279944@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9eO2jvA1Niv8Y0I3"
Content-Disposition: inline
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9eO2jvA1Niv8Y0I3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:43:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built bindeb-pkgs for my computer (Acer Aspire E15, Intel
Core i3 Haswell) and booted. No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--9eO2jvA1Niv8Y0I3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFmq6wAKCRD2uYlJVVFO
o4tjAQDBripPkSqMUmOsrdQre23VDXgOsTsH/lus9MTweGflxAD9G6RDIYHdLNZg
GSaLdMkdOqY0W2JYbcgAPJeWE6tqyAE=
=hK5p
-----END PGP SIGNATURE-----

--9eO2jvA1Niv8Y0I3--
