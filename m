Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2AD69E038
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjBUMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjBUMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8152916E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676982026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gziN/XKTmlqDV7Elwm8JhOAFtvAWBXGN7UBs14HUdfA=;
        b=PImWLZUXZei4BksOIm70S2jysagDLmqPIHGAEVIU8X3Pci3MjskGSykCeUjio3SxOWucAc
        72QZRbY9xxfJ5QZfv1DSdJcKx4vIflxi5Rff24y5Jy/BQ4qL2MVlSHUPZo0bdmY9W0E1Gn
        cF1cktn6u0nzQaDg3YlA6AwnpBIT/KE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-GPqmN6RBM6aYsKQ-Tco_Dg-1; Tue, 21 Feb 2023 07:20:24 -0500
X-MC-Unique: GPqmN6RBM6aYsKQ-Tco_Dg-1
Received: by mail-wm1-f69.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so2019154wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gziN/XKTmlqDV7Elwm8JhOAFtvAWBXGN7UBs14HUdfA=;
        b=ovXg3H+3TiQkN3cQk4xdKpJ0ywodQPEsx6tzkcy3pqK+i9F+/cHujtZNuJNWqhEGIY
         X5QOdlQ5KanJ7V/le8sMNrFL3JTAXOZpcfG0ZqJExr4VuVDPk0u142tgrvcnz/AWVY5y
         PY5ssqN38IOLDhp6GOWLV0q+ot/5+M9UzGK7Ljtg/j+Isj893nnfE8KXCmcFHUVvWivL
         MIj1zA4vzTUFccM1pcqbcnCQWaT4r6jY7U012Ct+X+S+tl8w99JgWMPhQRBgosALnHEg
         Qff1a7MXEGhCcT30SH3lh5jsYbQ7qmBXV+Gz+NqxJgyW4Yhf2OyR7NP/QEPp0QywuQeB
         8oTQ==
X-Gm-Message-State: AO0yUKVTnP9fK2Zl9ebwuIlCgPR2PgvhXbzIh1MA0KCmO2bwlZ2vyekx
        59xRcRR53jc3aqzcup3jodZOCqYNJfKjJTZlXmC5NPqb6Ml/IlIVJeu8Yv9H0MFONCecHJdodUZ
        n7NM/1AvEhPn74djlkBdqJtU3
X-Received: by 2002:a05:600c:1c9c:b0:3dc:5ae4:c13d with SMTP id k28-20020a05600c1c9c00b003dc5ae4c13dmr4846839wms.4.1676982023775;
        Tue, 21 Feb 2023 04:20:23 -0800 (PST)
X-Google-Smtp-Source: AK7set8lbV2WFcK+o7DtrFByZVT8litE+mTmB8ikeVTsesdZtnbGIUjq/rZ+QzGc2zwrHjOleTptLw==
X-Received: by 2002:a05:600c:1c9c:b0:3dc:5ae4:c13d with SMTP id k28-20020a05600c1c9c00b003dc5ae4c13dmr4846821wms.4.1676982023499;
        Tue, 21 Feb 2023 04:20:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id t23-20020a05600c2f9700b003dc521f336esm3904036wmn.14.2023.02.21.04.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:20:22 -0800 (PST)
Message-ID: <0d080cbd157fba352ea035611fa44354b8f875bd.camel@redhat.com>
Subject: Re: [PATCH 0/2] Add PTP support for sama7g5
From:   Paolo Abeni <pabeni@redhat.com>
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, claudiu.beznea@microchip.com,
        cristian.birsan@microchip.com, nicolas.ferre@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        richardcochran@gmail.com, linux@armlinux.org.uk,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 21 Feb 2023 13:20:21 +0100
In-Reply-To: <20230221092104.730504-1-durai.manickamkr@microchip.com>
References: <20230221092104.730504-1-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-21 at 14:51 +0530, Durai Manickam KR wrote:
> This patch series is intended to add PTP capability to the GEM and=20
> EMAC for sama7g5.
>=20
> Durai Manickam KR (2):
>   net: macb: Add PTP support to GEM for sama7g5
>   net: macb: Add PTP support to EMAC for sama7g5
>=20
>  drivers/net/ethernet/cadence/macb_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

# Form letter - net-next is closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Mar 6th.

RFC patches sent for review only are obviously welcome at any time.

