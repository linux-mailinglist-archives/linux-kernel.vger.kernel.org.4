Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66AA72DEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbjFMKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFMKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1A188
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686651021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQ8qG3I5WaG3P52JxI3Wd7lusGu6FrfknhfgsuNOgLo=;
        b=JNIb6L+LuDPMItWpxwSOP7WcwiPIwgg+qPSuIqXHE7zpSDKZOkXHdLz3krIXU6OqkQNQbc
        Dtz4TDJqrC8pla9A4sbwT6ORCJg8+1WvsLXdXrlwtsIwKi+INWU34URORolh49znffId7V
        r73kgzSm3WSHuE9AUmbPwvJyNg75EAU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Zi8bs2RoOcagb6CIc834ug-1; Tue, 13 Jun 2023 06:10:19 -0400
X-MC-Unique: Zi8bs2RoOcagb6CIc834ug-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-982180ac15cso236099666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651018; x=1689243018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ8qG3I5WaG3P52JxI3Wd7lusGu6FrfknhfgsuNOgLo=;
        b=Pz18mE4o2QrOzHHgJ9VlimBphHcWMAWAF+7kO+VuDAGkT8h8rrblUd5CmwGSfHKKZ2
         V8sG/F+prZ4pdsztxLSUKMM69Z3wzClWse+9Yb0dZ1MJY7DhX7otmtO03CO57xOFcnZW
         yxAP43NygSS9LQ+3K0yh8iheD5O1JmS5t3B4PNrvArD7ZexkERuwODLguUI5RhRzZcbE
         znSaVAjxTgdmDTwcQZMScYk2JR1sMIASjIEluqxG4CDAYKrDM+sFZON04AqhgY2EH+1M
         WXQ1s8t8aTmbWqiX4mCx6tQ7bhwC2G1+5bcwiW+9eIVdyesCPRLGd0H/pLGs37cfe4A4
         cl+Q==
X-Gm-Message-State: AC+VfDyXwUrqpIwOReS8K3B98wE9lmSuV80GWFAgZUOGxHBtp6Gollq2
        Az7q2PEUyNJBrBghnEHBzkm3zoE1iHaNgBT4gnYmWfBSOZh7tDDVXgX4RuDiTlYN7wyalvOefvu
        0gGWiVcNLxcCRpDQgFs2EKnzQ
X-Received: by 2002:a17:907:9306:b0:974:1e85:6a69 with SMTP id bu6-20020a170907930600b009741e856a69mr12573591ejc.16.1686651018073;
        Tue, 13 Jun 2023 03:10:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4x+CLF7oh9OSNrlseseUZsRMaCbeVralIJHlINtpA+bhMhcdCKdtmrONK76OG4HPKF+L9oAg==
X-Received: by 2002:a17:907:9306:b0:974:1e85:6a69 with SMTP id bu6-20020a170907930600b009741e856a69mr12573565ejc.16.1686651017718;
        Tue, 13 Jun 2023 03:10:17 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906471500b00974564fa7easm6492031ejq.5.2023.06.13.03.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:10:17 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:10:15 +0200
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
Subject: Re: [PATCH net-next 6/8] net: ethernet: mtk_eth_soc: convert caps in
 mtk_soc_data struct to u64
Message-ID: <ZIhAh2mzrYHOq2v1@lore-desk>
References: <ZIUX1AkjbSHdiMUc@makrotopia.org>
 <ZIcBQCqeMc424mv6@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cszZz60J0MnGgC6u"
Content-Disposition: inline
In-Reply-To: <ZIcBQCqeMc424mv6@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cszZz60J0MnGgC6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 11, 2023 at 01:39:48AM +0100, Daniel Golle wrote:
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > This is a preliminary patch to introduce support for MT7988 SoC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>=20
> At some point, I'd really like to unpick this and see whether there's a
> better structure to it - so that mac_config() doesn't have to save the
> syscfg0 value, and restore it in mac_finish(). Given that syscfg0 is a
> shared register, are we sure the code that updates this register is safe
> from races caused by two MACs going through the config progress in two
> separate CPUs at the same time?

Agree, this seems a bit racy. However it does not seem related to this patc=
h.
I would say we can address it with a follow-up patch.

Regards,
Lorenzo

>=20
> Is there anything which prevents two or more MACs wanting to mess with
> the contents of the SYSCFG0_SGMII_MASK bits? It's difficult to tell with
> the current code.
>=20
> Thanks.
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

--cszZz60J0MnGgC6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZIhAhwAKCRA6cBh0uS2t
rKWRAQD8bHaqtDus4I0VAesGyVWRDufLK3pPr+pM1DFTIDlkHQEA/9/+RWG7ZPoC
FpXYqhMD3z7v/+rNvWTD2rV8IbnfLg8=
=Cfik
-----END PGP SIGNATURE-----

--cszZz60J0MnGgC6u--

