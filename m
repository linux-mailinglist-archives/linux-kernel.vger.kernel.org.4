Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB4727EBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjFHLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:30:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C44530C2;
        Thu,  8 Jun 2023 04:30:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b065154b79so12389825ad.1;
        Thu, 08 Jun 2023 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686223809; x=1688815809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQpBGT9U0xk8ceOcBXPqmShJrbITkq5sMpW+csFBGQY=;
        b=hlXxBLnEnFDNUflMdn5jr+gLWr+60M8EzsIaGh6M295trLDPEJBVKtIGQG3Tu332Ur
         nbZEidukoIhBfjOKqokq26paOZHdSOkeEwEGNDYp1WL1HyQlf2FAasBc/Y6Wfq14TJpp
         rmo+nv2KppjXllUY2GJg6hgi58cS2IRushwVUTChj1TQlTLCs95YYqjdoYPeE4L6WaKM
         VyJ+/ylNVw+hySkuQouv9oJGMnOMtT8lbO8+UA72+V5eDCl0iGQx9yoQ/WNysFMZPwbG
         iQWDzV93ViBrQAngLCuzi6c/umzVqO7nNNGCnKOwd5CfT/MmnWnzetyJdqhsg2vRZKzk
         Q+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686223809; x=1688815809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQpBGT9U0xk8ceOcBXPqmShJrbITkq5sMpW+csFBGQY=;
        b=bK+E+MUr/KuaeAqx9ZMQXubJEiWgbUsWqawQZblxCTMRRWGQZD0Wb1fZ2INBp+QmBP
         CE+3mKKw63IffoYVJoiCYj66TFovQAA8rgmP1cJtVyYjTsGGdoASuoOwwiU6L8j0l54o
         YUePIIA5yLsULLRXzVQNRK/b81aoAOplzHoDtpxvf2NQ7vTAsx1Mn+aHeRdSGH0svnj4
         cmD6d3sVhcjsNSgCviBFi84EbxEOukJIuP9hpaJvcFrGlzYqOvGN7bWx+ixpZuXAHhb8
         aTOeMkzLY65534l/cYmk97MDyPrVFnhY1a0TJ86uJWABZgNlEd3b8B0IanA1BXdhheYP
         aBdw==
X-Gm-Message-State: AC+VfDzui13w7WVuIHb2sTvFHfoRFU+DQ33Mkw3hwmEbEdEguzJnVCko
        bZARVMA6XaTPbjBqkaXXCHU=
X-Google-Smtp-Source: ACHHUZ7OiXr7qHhfDSAnv44x1I5fxNmN2hHourGMao2/pPl4DNJYgnLOXyteMkZ+/GfOuBL5YIBOFA==
X-Received: by 2002:a17:902:dac4:b0:1a1:cb18:7f99 with SMTP id q4-20020a170902dac400b001a1cb187f99mr2069933plx.30.1686223809358;
        Thu, 08 Jun 2023 04:30:09 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709028f9800b001b016313b1esm1233913plo.82.2023.06.08.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 04:30:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 88222106A0E; Thu,  8 Jun 2023 18:30:06 +0700 (WIB)
Date:   Thu, 8 Jun 2023 18:30:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
Message-ID: <ZIG7vqctqmK3r1RO@debian.me>
References: <20230607200913.334991024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HPOmJrhShDyJTZTh"
Content-Disposition: inline
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HPOmJrhShDyJTZTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 10:13:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--HPOmJrhShDyJTZTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIG7vgAKCRD2uYlJVVFO
o4a0AQCqKU5FlNDVavEFwm/2q6G4JMaislj6oe9n37O7lZwilAEA5Ks2L+Rvp4IO
tC3edwHvYKs3fNv4qtD4nA+o2suisQQ=
=w3eK
-----END PGP SIGNATURE-----

--HPOmJrhShDyJTZTh--
