Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED872D44A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbjFLWR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFLWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF310E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686608197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTZtyuUlXixxMxO/No1lfJ4jfgIlGKSKtZpjkWwouX4=;
        b=hMpmd6uHKMQbDRYkXImXWFjupWgj7+cglTubxGi63yWGSKVxOk2TT5x7hIoAiECQ3ZtzK3
        EXJ99kJ4UWVRrBBoN0Rt6ToEsmPJ2Ed4BDhrXTXT1AcqDp7FPK/wkepDVUz1UZaQ2byT+O
        L62d322Pbe+DaWWX2+CKFD9e4Q160nk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-n14GwbynORuOchIalOVn9Q-1; Mon, 12 Jun 2023 18:16:34 -0400
X-MC-Unique: n14GwbynORuOchIalOVn9Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7e835ce65so21312475e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608193; x=1689200193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTZtyuUlXixxMxO/No1lfJ4jfgIlGKSKtZpjkWwouX4=;
        b=Plb0pU1/zmqoRvKGusPMeXyJ3ysYd+UBvTWPKQmgSV9ONqVVRoFjCfFl3jqxAxeBEB
         dhmjq5nRbbQ3jhM9aNcCIDKwNvZ3dkxfjwWHUpUGO0owNpg1x3hvq8Wcqi6Ux+ToTwRn
         tXxx+hhjMRb0aqngjnJwdMB3TJj1gLrH+KshIYYa06WaxM450UwhdSyqUjI+VbMGjpIX
         vaWnAx7H9HlYrVNWETM621gV8Asc3y67NqaVctVs5kq4sKVrPkio54/BCgUYM+QHZOnk
         hs6gaXHIWtoyJuBhXlblgWh+nWPK0Jdl3wELxb8PeV4yN9c+7MLU1/sTWrtqrbShSfpA
         pjgw==
X-Gm-Message-State: AC+VfDzvjxudKBf7RapElRzEaEN/jl7g7KldmOz850NDnyejcbK2r3hb
        W0z0G36fjrG15nsP8ylNfm2MDpofd3+Xnq5MbmanbDIoj6FlAJ/1j3QHvga7H2Od0UaEOA6SVBn
        5MUSbMGT+ioPQVOsPuuzewCFV
X-Received: by 2002:a5d:4c88:0:b0:30f:bb0c:a2c0 with SMTP id z8-20020a5d4c88000000b0030fbb0ca2c0mr3763720wrs.5.1686608193383;
        Mon, 12 Jun 2023 15:16:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vhzxAZAyN5mFmZdbyQbsrTmXIEJTazMrYY97aHI+UWILU1SiUfJAeHgaq8ps1Vzz+ZOsSqw==
X-Received: by 2002:a5d:4c88:0:b0:30f:bb0c:a2c0 with SMTP id z8-20020a5d4c88000000b0030fbb0ca2c0mr3763713wrs.5.1686608193039;
        Mon, 12 Jun 2023 15:16:33 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id e4-20020adfdbc4000000b0030ada01ca78sm13512230wrj.10.2023.06.12.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:16:32 -0700 (PDT)
Date:   Tue, 13 Jun 2023 00:16:30 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: Re: [PATCH net-next 5/8] net: ethernet: mtk_eth_soc: add
 MTK_NETSYS_V3 capability bit
Message-ID: <ZIeZPqFJqdf928f4@lore-desk>
References: <ZIUXf9APDFCNaUG1@makrotopia.org>
 <ZIb/WKKNlzjTIu2h@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MZEWyw36ZZKq14wi"
Content-Disposition: inline
In-Reply-To: <ZIb/WKKNlzjTIu2h@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MZEWyw36ZZKq14wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 11, 2023 at 01:38:23AM +0100, Daniel Golle wrote:
> > @@ -1333,8 +1354,13 @@ static int mtk_tx_map(struct sk_buff *skb, struc=
t net_device *dev,
> >  	mtk_tx_set_dma_desc(dev, itxd, &txd_info);
> > =20
> >  	itx_buf->flags |=3D MTK_TX_FLAGS_SINGLE0;
> > -	itx_buf->flags |=3D (!mac->id) ? MTK_TX_FLAGS_FPORT0 :
> > -			  MTK_TX_FLAGS_FPORT1;
> > +	if (mac->id =3D=3D MTK_GMAC1_ID)
> > +		itx_buf->flags |=3D MTK_TX_FLAGS_FPORT0;
> > +	else if (mac->id =3D=3D MTK_GMAC2_ID)
> > +		itx_buf->flags |=3D MTK_TX_FLAGS_FPORT1;
> > +	else
> > +		itx_buf->flags |=3D MTK_TX_FLAGS_FPORT2;
>=20
> There appears to be two places that this code structure appears, and
> this is in the path for packet transmission. I wonder if it would be
> more efficient to instead do:
>=20
> 	itx_buf->flags |=3D MTK_TX_FLAGS_SINGLE0 | mac->tx_flags;
>=20
> with mac->tx_flags appropriately initialised?
>=20
> > @@ -2170,7 +2214,9 @@ static int mtk_poll_tx_qdma(struct mtk_eth *eth, =
int budget,
> >  		tx_buf =3D mtk_desc_to_tx_buf(ring, desc,
> >  					    eth->soc->txrx.txd_size);
> >  		if (tx_buf->flags & MTK_TX_FLAGS_FPORT1)
> > -			mac =3D 1;
> > +			mac =3D MTK_GMAC2_ID;
> > +		else if (tx_buf->flags & MTK_TX_FLAGS_FPORT2)
> > +			mac =3D MTK_GMAC3_ID;
>=20
> This has me wondering whether the flags are used for hardware or just
> for the driver's purposes. If it's the latter, can we instead store the
> MAC index in tx_buf, rather than having to decode a bitfield?
>=20
> I suspect these are just for the driver given that the addition of
> MTK_TX_FLAGS_FPORT2 changes all subsequent bit numbers in this struct
> member.

ack, I agree. I will rework it.

Regards,
Lorenzo

>=20
> > =20
> >  		if (!tx_buf->data)
> >  			break;
> > @@ -3783,7 +3829,26 @@ static int mtk_hw_init(struct mtk_eth *eth, bool=
 reset)
> >  	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->qdma.int_grp +=
 4);
> >  	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
> > =20
> > -	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
> > +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V3)) {
> > +		/* PSE should not drop port1, port8 and port9 packets */
> > +		mtk_w32(eth, 0x00000302, PSE_DROP_CFG);
> > +
> > +		/* GDM and CDM Threshold */
> > +		mtk_w32(eth, 0x00000707, MTK_CDMW0_THRES);
> > +		mtk_w32(eth, 0x00000077, MTK_CDMW1_THRES);
> > +
> > +		/* Disable GDM1 RX CRC stripping */
> > +		val =3D mtk_r32(eth, MTK_GDMA_FWD_CFG(0));
> > +		val &=3D ~MTK_GDMA_STRP_CRC;
> > +		mtk_w32(eth, val, MTK_GDMA_FWD_CFG(0));
>=20
> mtk_m32() ?
>=20
> Thanks!
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

--MZEWyw36ZZKq14wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZIeZPgAKCRA6cBh0uS2t
rOWZAP93LCOL1i0nkHkj6wrpRzOraRpEoqEK3GPo84WYL1nFzQEAs2hJgVY3XzfF
KF3PwyoYttShSk1kgjn4c0xzXmKqKgU=
=Fpo3
-----END PGP SIGNATURE-----

--MZEWyw36ZZKq14wi--

