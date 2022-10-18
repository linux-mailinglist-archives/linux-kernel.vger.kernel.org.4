Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16618602F80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJRPT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJRPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:19:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BAD18C4;
        Tue, 18 Oct 2022 08:19:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v11so939240wmd.1;
        Tue, 18 Oct 2022 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBaIo106NnMu5MVYhnHg1HZlVjv/pqWACQc2/Rh9K70=;
        b=ZyQ2qR+lYrjCwN9BuntaHYeFKcS9E/1mIQOxeSq/41Kn02oMdiB953Ms78+IMAYSJp
         ZfxQKkzrrhkm6ARLmfc4Rah+N60I0gZ42dQ9SR9U/ToB1jyTfzwN+KLimMRU++f0YduA
         RyQVfvjrtEensuaJSFfCC8pZGmNkRPiflUZajJHxks6lqXQM6UhZXU/8PQvvlfbSFsX1
         dIt/GBT8diP3m9pH1ADEx6pBd6cGgFdUoVGzcdXi5kJKyHzmGaCbk1HEp9muB+wWCYHX
         B/0crnU41A7VR4lFD0OzHMVlIFCi0gya7RPgS3szh8LTieYz1z9hzqooL2xdalq7GBXU
         R8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBaIo106NnMu5MVYhnHg1HZlVjv/pqWACQc2/Rh9K70=;
        b=cCJ8ZGURjoBvwZX/DA6tjTZ0MyZDZmvvcJaAgC3Vwc7BZzfZ2MIQMHbGKdw8wBdlFF
         UcDKYChbnDeUQuWm7xp0Ul1o/Iq8tjEcSm548zLW13VQiDbQNpK1CW4DXl3cqGtpey3g
         PmSvBgOqv0WAjNIuYaD5ZeU2Vafxsu3ceb8PNVD0goaCUmx1s9dJXlP6N2PHNJMWSpX+
         A4FEm07eNVUX9fNfR1VbmxbaQSACGHBabuwlJ6TA90fCKH6cYX0AFO+PerkT3ra1wxL3
         CftMrHFoDC/vcfac5p60Gfu/GUx4Jm9WHzTsvmNUcilHptADL7FjdE23myc64FKq30qU
         QVRA==
X-Gm-Message-State: ACrzQf2OG8QLKCcXewStxJaq0pKzvWlsflF8jNXtwPYULQ/7eMaNP4e1
        NyGYK8n8L5SmpZxZV4M/J1A=
X-Google-Smtp-Source: AMsMyM5iYn3fIXe/RenMqtxk3UKsm1373VHjP5tMTGXKlsjnmWhE6jeKDRj03288fCIB0xvq0V9dlQ==
X-Received: by 2002:a05:600c:1f16:b0:3c6:b6f7:d224 with SMTP id bd22-20020a05600c1f1600b003c6b6f7d224mr2464464wmb.46.1666106357383;
        Tue, 18 Oct 2022 08:19:17 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c2d8800b003c64c186206sm13179153wmg.16.2022.10.18.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:19:16 -0700 (PDT)
Date:   Tue, 18 Oct 2022 17:19:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     ldewangan@nvidia.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jonathanh@nvidia.com, alan@linux.intel.com,
        swarren@nvidia.com, akhilrajeev@nvidia.com,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: tegra: Read DMA status before terminating
Message-ID: <Y07D8qIPJYrwqWPM@orome>
References: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IHuIGTSViub8/3Tu"
Content-Disposition: inline
In-Reply-To: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
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


--IHuIGTSViub8/3Tu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 08:28:06PM +0530, Kartik wrote:
> Read the DMA status before terminating the DMA, as doing so deletes
> the DMA desc.
>=20
> Also, to get the correct transfer status information, pause the DMA
> using dmaengine_pause() before reading the DMA status.
>=20
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
> v1->v2:
>  * Pause the DMA before reading the DMA status.
>  * Updated commit message.
>=20
>  drivers/tty/serial/serial-tegra.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Seems fine:

Acked-by: Thierry Reding <treding@nvidia.com>

--IHuIGTSViub8/3Tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNOw/IACgkQ3SOs138+
s6GgFA//fpcMpjiCNE0bjI9gIWfKnoaHklq0pIKH3JzHH4bXoIEXDzpa4lRECS+O
Vaof0L0kUKBQwjPn87YmWoTc0QGO4YqFSV8OO4eyORk1H7affyY4IxpdcEdKg18y
dUGRLj0mjMNDs/ZZRIkNK6nJMoplMbjBBaDeBiuhQ1ijBJWwm9AuuNzdEzPTXu8p
uF8U9jM7dWBJ82JuasuJXnanT+qhyvPGnda4ABTV3fKgBN5XfwnzKLx1ik5mbGti
LGU65Vm7vokMTrCvWjrnDnMZEGPn8BMJPfrjMhNYWzjnXYM1+vWr1XtpVhOLQoCv
CxQ4A0eEbKb8E28DhUcJn2VFVIhpAEgL+kcDKB0LtrkRSAwwKKgaZKW8chUEl1kN
EuHKlfTnuEYIde0U6jUv9cw1Z3tnmVmcca7Iu9w5tXB8au1LqhxscO5XNotlTnJF
lRuHcGEkjThMET2s9iNrJqhC/fLXidPPuA3lHL8Z6Vp+Bp81cSwKFXbAcp6SEc/H
jent0tT879mWh5cbsHs6oGRP51CRyiNj7q0YddOsEXPgSEu2V447uPTltZlWk6Jl
JP+q1ERq48b7zBkt3jTXxeMYzdcxjWW02QWWtODS+nfANoM+aTy8W6X6NVWAZXY+
prx2rH+b5vL1evw6GamwxFE808z+uXmYBVctt5TH8EUdsOTD410=
=AAlD
-----END PGP SIGNATURE-----

--IHuIGTSViub8/3Tu--
