Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987E72D3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjFLVyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbjFLVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424B199B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686606771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lig8bfKofULub0rdesjmJTGhCjl+c+cZITPDTaTBD/c=;
        b=SK3t2i4HWkvOs0bA/+lNwejEFm32sd9+9kUGrSglII7LdTwJVXLY8Vt1ezKiCOjniIEVYE
        v/YNfVH+OOZ9x29fBM6AiMyMKf+1Tmqx+wDnji0jqxFhj4Dupsexkb6XiXl8TfBPIF/I/5
        w/o/QyE2TTEtQr6HNGjeU0jVL9lW1nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-dS3E9yAhMxq60o4q5UfoDw-1; Mon, 12 Jun 2023 17:52:50 -0400
X-MC-Unique: dS3E9yAhMxq60o4q5UfoDw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30fb891c5e3so3613906f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686606769; x=1689198769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lig8bfKofULub0rdesjmJTGhCjl+c+cZITPDTaTBD/c=;
        b=NDTsCuhwWtTeKwA4TZ4N8U9vKl4X6lgroL8kM9mz5Q7SclWvFxSEAPUsEuGN2zs0jz
         croCk1iNHtcX2zmb2lto7/i1omxGMgn+1xgFJ7uXRVVbPgylJa92xR+nclze+BlvDkpC
         JXmCzdAeshYLo57yANO/mL3yfwgpgAuLPW8OzCVRDPj4QXy84kzGQa/z6WrJ6A29yTS1
         ycc02gFhnK2EhQrVnZC7NxQgqZUMURBqG1pTPABs3QmoRTkeGQdyE1SYDmFLVBdcPuTz
         JLnGQXZ4K77W6fB1rB1xpshpZoR/yl5IyuWoOGs3aONRrrmpEJk0FWG4CIzUqtrnDqIa
         O5QA==
X-Gm-Message-State: AC+VfDwMn5ILBU54IgMmTIrRwAmrgHv2UD1WWOhUu5lSw9cU165FZMD0
        4DsU5SwdUFfzClstW5B3Cm8nI97v29TGm8x+NQE7qMTea6Urv2bsDRAaObVOw3h/tXV53M8HSGQ
        ybwb4sNbmo/fFLR/ePBdUsZBA
X-Received: by 2002:a5d:4e85:0:b0:30a:d2e6:6a78 with SMTP id e5-20020a5d4e85000000b0030ad2e66a78mr5644108wru.24.1686606769103;
        Mon, 12 Jun 2023 14:52:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ533dy2vongGwe/ijXoDrZL6tuCydkYrtVs8jx5yk/Ac46ZodmFGImZx55e7jFjVeMCqkk2YQ==
X-Received: by 2002:a5d:4e85:0:b0:30a:d2e6:6a78 with SMTP id e5-20020a5d4e85000000b0030ad2e66a78mr5644097wru.24.1686606768769;
        Mon, 12 Jun 2023 14:52:48 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c224b00b003f8126bcf34sm8119367wmm.48.2023.06.12.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:52:48 -0700 (PDT)
Date:   Mon, 12 Jun 2023 23:52:46 +0200
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
Subject: Re: [PATCH net-next 3/8] net: ethernet: mtk_eth_soc: move MAX_DEVS
 in mtk_soc_data
Message-ID: <ZIeTrjCsyQSiCnsr@lore-desk>
References: <ZIUWxQ9H7hNSd6rJ@makrotopia.org>
 <ZIb6604WRJsevaWN@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jV/BeWnWuWrIw8B"
Content-Disposition: inline
In-Reply-To: <ZIb6604WRJsevaWN@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+jV/BeWnWuWrIw8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 11, 2023 at 01:35:17AM +0100, Daniel Golle wrote:
> > @@ -1106,14 +1105,14 @@ struct mtk_eth {
> >  	spinlock_t			tx_irq_lock;
> >  	spinlock_t			rx_irq_lock;
> >  	struct net_device		dummy_dev;
> > -	struct net_device		*netdev[MTK_MAX_DEVS];
> > -	struct mtk_mac			*mac[MTK_MAX_DEVS];
> > +	struct net_device		**netdev;
> > +	struct mtk_mac			**mac;
> >  	int				irq[3];
> >  	u32				msg_enable;
> >  	unsigned long			sysclk;
> >  	struct regmap			*ethsys;
> >  	struct regmap			*infra;
> > -	struct phylink_pcs		*sgmii_pcs[MTK_MAX_DEVS];
> > +	struct phylink_pcs		**sgmii_pcs;
> >  	struct regmap			*pctl;
> >  	bool				hwlro;
> >  	refcount_t			dma_refcnt;
>=20
> Is it really worth the extra allocations?
>=20
> There's three pointers here per device. Let's talk about modern systems,
> so that's 8 bytes each, and if MTK_MAX_DEVS was two, that's 48 bytes in
> all. If we expanded the array to allow three, that would be 72 bytes.
>=20
> If we allocate separately, then we're allocating 16 or 24 bytes three
> times depending on whether we want two or three of them.
>=20
> On arm64, I'm seeing the minimum slab size as 128 bytes, which means
> that's the minimum memory allocation. So, allocating three arrays will
> be 384 bytes in all, irrespective of whether we want two or three
> entries.
>=20
> That's a waste of about 5x the memory over just expanding the arrays!

ack, I agree. I will fix it.

Regards,
Lorenzo

>=20
> If you want to go down the route of dynamically allocating these, it
> would make better sense to combine them into a single structure that
> itself is an array, and thus requiring only one allocation. That
> reduces the wastage to about 56 bytes for three ports or 80 bytes
> for two.
>=20
> Thanks.
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

--+jV/BeWnWuWrIw8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZIeTrgAKCRA6cBh0uS2t
rNj4AP9deO0Gr7/2QBPFl0zwa5owkvBsU7Fw1f3Xo0VOcoEEOQEApfOn/gVjmHQW
s9GY/xg59Fhdvwhh8lfHmXEvgidsqAg=
=V5g1
-----END PGP SIGNATURE-----

--+jV/BeWnWuWrIw8B--

