Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F55B9964
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIOLOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIOLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:14:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31B99268;
        Thu, 15 Sep 2022 04:14:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id cc5so20484702wrb.6;
        Thu, 15 Sep 2022 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3pcreFA2o+ApXwGD5SR6DwKfZo5EwI/JcS2Afc+r5So=;
        b=kzvYmYwSlbw0kzncpF3crUIaykleKNYFwdLvjWUNsB0q0p8qZOmpStbhw+UaBSocHB
         w4dkwmjaeO7nHtpSvPqeCZG7qVP0rvBTSaUwK7mDabXgHUX5yZGmyZGaRyQGEXF2mrTW
         YP/Q+ZQh4NPHsC28tcEc2BnXakCmcCRxOgS2iHR/Pz+46+94pn9q2CO5qUkipGlOiN8s
         k+WZYrbwdyPkqPfxgAl+jILOU+JRX1//WjjSAloRQidMSHofW7upnI3zwAJLpgBktyQd
         vJn/UrtiT4v9NKXMSCKsCkcPSZAt5fV5iI+LvGRLEVfchgO5Vrz4x+TS2OSLAOHsOv8X
         dW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3pcreFA2o+ApXwGD5SR6DwKfZo5EwI/JcS2Afc+r5So=;
        b=DCEXUYJol1WxTtf35B6BiNNt238AFRLc4bMUWiXy1jVI5qjjEP+u38oomye3gIv+ZC
         AXfwLvmvPM/DvePGsDn0RG/I8QecY8VoI0h/21lIyd2lXEVG7I5hmBqFe4tTecZlzokw
         AbGBua2IKsBFbv9/Xpg9NkMcyiSNamtvTwot4Jtx+H9gjSLL9vmsmAK52nvlviOdKERt
         wQM8yHf0cyt2zmHzKwqjeu7Q5JbDmH8ZtBLrXxJ/Dzqye6jULOcD1bGBvvTJyr0J04Qr
         px5jzOuuxIgPGZLu2sYKEA8vAIuD6wxbS70VQ4VtyoD0VubvzQtGnCVEwGsqW1WSdhLA
         0jlw==
X-Gm-Message-State: ACrzQf0bbZ/ab6oR2rWf45QG2kGhayaOs3y9kib4Ne6iPey/tUpT+ehw
        ocbJsw6xLHiIdgPF+ERi3zqM5EmwvFo=
X-Google-Smtp-Source: AMsMyM6qW6CS49SacNHsTm1hvZFGQSGgo2r7rzRwo4cr3zDMyLsIUHB+aoBtZM79MFxLuAWGCn4Ecg==
X-Received: by 2002:adf:e849:0:b0:22a:cd2d:33bd with SMTP id d9-20020adfe849000000b0022acd2d33bdmr2915659wrn.548.1663240449965;
        Thu, 15 Sep 2022 04:14:09 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003a342933727sm2577005wml.3.2022.09.15.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 04:14:08 -0700 (PDT)
Date:   Thu, 15 Sep 2022 13:14:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: pmc: Use devm_clk_get_optional()
Message-ID: <YyMI/6L+YWgCtcEp@orome>
References: <4d2e518fc75dd3053ec4afcc36e13a0a6f75884e.1659905735.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pV6cwMKbUn7CKnNV"
Content-Disposition: inline
In-Reply-To: <4d2e518fc75dd3053ec4afcc36e13a0a6f75884e.1659905735.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pV6cwMKbUn7CKnNV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2022 at 10:55:59PM +0200, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
>=20
> While at it, use dev_err_probe() to further simplify the code. This is al=
so
> less verbose if clk_get() returns -EPROBE_DEFER.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/soc/tegra/pmc.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Applied, thanks.

Thierry

--pV6cwMKbUn7CKnNV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjCP4ACgkQ3SOs138+
s6GC7xAAtmI8w9gFIjPA9sZUGMdow1BHER7HNnuzr817NlR6rw9onUc+8Py6yDOU
hpBSCYh60UiW2oPhVLp3PSxtRKwIiqT3ZBhL2J1sooK6SBDUzQ1TPKzRCzIye/O1
6dyuYBMp/B+faFpQ0intZednC/gqdZ2tzCjRhW5GLlbqsRZ7mjmIzQ2j7Dl5WfH5
HbN4QmyAeAaFkJMEnXtvbYCK+ex8/Hpn7o3S64aeC38ruzEmqycn08NOPU6QoWJQ
RmRB2MuROBn1xLzN0zDVXL5AZdpCZkm/7NZnM1ZijAeTLzxBtaVGm6IZnFf/FoW1
atwfXho2Lht/lxnfPuH9+b5wRDmx5C3SduKCD76K6sT0Gfd6RIgAa8FXzzXTBnHs
ni+u0pdeazFN6Y+xx8wMA6S47HUC8ktInG8wsKe7E5sdSJPP/Lz8bSeaYP98xftM
DQbWJ9CjFHazP9ZQEk1rISTjAhE4MwWbzLTnbXyYM0/8kOsklH30dhILt2aBI1Xe
7UT0zJmZNNCBSlY21oiT+s34hK7f4Iq0XOARgz1rAM3B2PVr7TfvynWte+surq6R
l2mVUQrK/SUDDUr9m8lZ9uT31Vy2YvaaK+9Ji5SPRISXPuMtHJzE3gf6Kk9668aJ
U8FlZbnyOjvLf+a06zCIhRuKXCBD2iP6ghiwDLitE42oSaZGSeo=
=Cpzu
-----END PGP SIGNATURE-----

--pV6cwMKbUn7CKnNV--
