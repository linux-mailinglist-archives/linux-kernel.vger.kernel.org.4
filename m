Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C60696FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjBNV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjBNV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:27:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83757302B1;
        Tue, 14 Feb 2023 13:27:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 505E8618FA;
        Tue, 14 Feb 2023 21:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2360C4339E;
        Tue, 14 Feb 2023 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409970;
        bh=hSX2Tgc6oAfWUXYYtLCPZp7+VDxvI+TUXbWFtIES6zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qV6SMHcZtnxTTa6QqmyBbQ3ANvvAhnVOXyOlGY7Z5GOevT3CdpCQPCLKCU5K1/MFm
         HLI3WGS+cIJhWgKHaW3wB+MRcRRIeZX4DvUbjpqK2eZ0ZnfXF1hgZdGrkb9DUWRkMH
         MrOHsckBzns+ucbjPlbirYyEL4m3S6+Cq1ZAfV8FDu/Y4gygsM93JzYvmmVcbHxisL
         t1WOeEspo8SL3f3wLxch4HA1RHXngmmm5YnVCNu/M3WEAKQw9/Y0ZYmATb6vhvNU99
         upLXhqHAjvQjxjDZXmXjIQNrWLDWhRYBN2MfSzgII3uwtWJm3udXq3vtBGhBGGhUee
         JZyyuDt6ZP34g==
Date:   Tue, 14 Feb 2023 21:26:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start
 DMA after DAI
Message-ID: <Y+v8bbr4cNSOA1SF@sirena.org.uk>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-2-claudiu.beznea@microchip.com>
 <b065e2bb-1f11-067a-b085-45d47626927e@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R54liaYzL9gFIZzm"
Content-Disposition: inline
In-Reply-To: <b065e2bb-1f11-067a-b085-45d47626927e@metafoo.de>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R54liaYzL9gFIZzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2023 at 10:14:28AM -0800, Lars-Peter Clausen wrote:
> On 2/14/23 08:14, Claudiu Beznea wrote:

> > @@ -450,6 +450,8 @@ int snd_dmaengine_pcm_register(struct device *dev,
> >   	else
> >   		driver = &dmaengine_pcm_component;
> > +	driver->start_dma_last = config->start_dma_last;

> This will break if you have multiple sound cards in the system.
> dmaengine_pcm_component must stay const.

Right, if we need to modify it we either need to select which of
multiple const structs to register or to take a copy and modify
that.  I've not looked at the actual changes yet.

--R54liaYzL9gFIZzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPr/GwACgkQJNaLcl1U
h9DDgQgAhYXy5TF+7Mg2IjWNd041kJVc1YKqear/ET167ZstAJ9vPrvD2rhlh0R/
U+aSgJDd4qoFQ4WHBIW2U2xGAbHgjiXbiCfyxdCRChBtS+gKfKEOjxyKxNHh5ImM
1WJyZfgnvXg7Sb8wRTSaALBuDok7YreQAsTkqOSkYIxzH+LTcRYu0XXEaykGCY+E
kpqZUbeNlOhpzu0ljyWHl6zqkDY98+hVpn8kIaMbjTTx979/lR82pDe1CcyyaFXO
M9p3TdQNJnf49mHrQf77Zyk4/Jf4268r/9xjtT5OtMYGEY0xdiPrMZuX6KgDE+l9
2QEnZ6cey67U3HBu12P48htN0LhEmg==
=ALoi
-----END PGP SIGNATURE-----

--R54liaYzL9gFIZzm--
