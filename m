Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A04708949
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjERUQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjERUQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FA910D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684440958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w4dbLnrsFQB/dr671yZZ2BqBWyzHNhCNJDMFDOMVwd8=;
        b=JIcF5J66vj1g+e4MQ1QDj5/r7t86NpvG3t9vLcOKpoEG0TZRmOd9pDOfoTo413kA8fe/aV
        t4AbkX328SCR91Yk5WvQFVrGxg/du/scRiXjbdu+QcqPlbKLIu14v+zmVkSc7XrytKle1q
        Qxt4cPDR3cj9s+V+5jtprRNfB4BS1LM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-CkUu0q-bPcCc_jYQkxjaTw-1; Thu, 18 May 2023 16:15:56 -0400
X-MC-Unique: CkUu0q-bPcCc_jYQkxjaTw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f426ffdbc6so14330045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440955; x=1687032955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4dbLnrsFQB/dr671yZZ2BqBWyzHNhCNJDMFDOMVwd8=;
        b=AsxQWdVhYMI17MpPrPRzy3hEWxlmZIwjflxQDGUrlAWyivEeIW+sPMkD5/ThMNdRsN
         SgSMwmAIIGevBDxFDHlG5XvTuDzxqTy0i73Zo7nSkAqVoaPIdTKRXclKGkWcux+afKPS
         ogvaEZbeYBIeusq0ycDFphkzoPUr9nTJXriqmHXjUOEskNf9C0f9UDBIniVnknn3fmAz
         TA/lWv1R7bqcE3s6QWVYsPpMYmYPnfl9aSgGiraE5ko2+GoM1fi0IwOYuXs6/EufkTF8
         RZVlwTsqLNV1yS9y/F4gGsw87dJya5qLHaEYxoAezkR6T3By66BAZ9SCX+lUuS0PrhDD
         UCwA==
X-Gm-Message-State: AC+VfDywcjnTtqN88wklh7csROSbOFxgjFRSTStY6HvxQgbAsWwbQHAg
        TfVV3++pYtpou9NrJXGrQ6gXocAp3WqzRaoPaPjc7zlVdQYRhksEI0uQw54EYPQVxMBQ9h0fUmq
        BURS3XhYroEV0WMJWrJiyEm9j
X-Received: by 2002:a05:600c:220b:b0:3f5:d0b8:4a53 with SMTP id z11-20020a05600c220b00b003f5d0b84a53mr2745161wml.34.1684440955178;
        Thu, 18 May 2023 13:15:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WP++3qbUh8cNx179wrEne1e7LJ/VwBZbAfv/N3saw6OGNrRF6VR6aLIxDd9u6/v/KiCG58A==
X-Received: by 2002:a05:600c:220b:b0:3f5:d0b8:4a53 with SMTP id z11-20020a05600c220b00b003f5d0b84a53mr2745148wml.34.1684440954854;
        Thu, 18 May 2023 13:15:54 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003f0ad8d1c69sm240917wmc.25.2023.05.18.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:15:54 -0700 (PDT)
Date:   Thu, 18 May 2023 22:15:52 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     wei.fang@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-imx@nxp.com,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: fec: turn on XDP features
Message-ID: <ZGaHeGUwFdWDthh4@lore-desk>
References: <20230518143236.1638914-1-wei.fang@nxp.com>
 <ZGZkmvX0OLI+4fqY@corigine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Abo9Bduke0Fad34+"
Content-Disposition: inline
In-Reply-To: <ZGZkmvX0OLI+4fqY@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Abo9Bduke0Fad34+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +Lorenzo
>=20
> On Thu, May 18, 2023 at 10:32:36PM +0800, wei.fang@nxp.com wrote:
> > From: Wei Fang <wei.fang@nxp.com>
> >=20
> > The XDP features are supported since the commit 66c0e13ad236
> > ("drivers: net: turn on XDP features"). Currently, the fec
> > driver supports NETDEV_XDP_ACT_BASIC, NETDEV_XDP_ACT_REDIRECT
> > and NETDEV_XDP_ACT_NDO_XMIT. So turn on these XDP features
> > for fec driver.
> >=20
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/et=
hernet/freescale/fec_main.c
> > index cd215ab20ff9..577affda6efa 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -4030,6 +4030,8 @@ static int fec_enet_init(struct net_device *ndev)
> >  	}
> > =20
> >  	ndev->hw_features =3D ndev->features;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;

should we check FEC_QUIRK_SWAP_FRAME here? something like:

	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME)
		ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
				     NETDEV_XDP_ACT_REDIRECT |
				     NETDEV_XDP_ACT_NDO_XMIT;

Regards,
Lorenzo

> > =20
> >  	fec_restart(ndev);
> > =20
> > --=20
> > 2.25.1
> >=20
> >=20
>=20

--Abo9Bduke0Fad34+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZGaHeAAKCRA6cBh0uS2t
rN7NAP4ry0vKmj20KLCmHhYLXOte8cDr0k+KWUnGqFqYLjqttAEAng3fDLIBqD5r
3OEjWoQ6Ut7Sm/4irqcTIw++8nfprws=
=mLbT
-----END PGP SIGNATURE-----

--Abo9Bduke0Fad34+--

