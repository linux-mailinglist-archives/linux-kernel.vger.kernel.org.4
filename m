Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61F5B571D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiILJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiILJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:23:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD924F2E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B93DB802BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E247C433D6;
        Mon, 12 Sep 2022 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662974595;
        bh=UnBOhXfenvWbDybP985OVBjApcnoKO9fDkCSbi1tltY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDv1416ZzSErNeJeEkWCV4fsAkh6JQrFlh57PL0pJCsquswQKX5jfpceE3VvIxN9c
         fWucNJqbbG/pvTHU8atIXQlAorOlZme2/yMUUYKIsKcFhJaDHaGcvxTnJxH5W/gMEx
         7DbcDaLl1/P3mK8alwcrouWobNxx0zebkGo9Br3+mGvz9VUOImZ5dFc1qylVyTVO2K
         D70EX6pmxnpWYMhqFlg2Z0bD/6LzIfCa9xXuocuGFAaBkJwVPrwf3fLDgSZhuz9ohR
         DgEAVPHJHkyRL2UvDnATq7vHCU+7048938zAxDL76kjL/tZAKqrwwQnoIz+rng1gd9
         SSeOY8Rkjb2yQ==
Date:   Mon, 12 Sep 2022 10:23:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mengchen Li <mengchenli64@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, steve@sk2.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8978: Support the recording function of codec
Message-ID: <Yx76gpaq0wbuek72@sirena.org.uk>
References: <1662970985-2909-1-git-send-email-mengchenli64@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z7sRByif36EoE65Y"
Content-Disposition: inline
In-Reply-To: <1662970985-2909-1-git-send-email-mengchenli64@gmail.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z7sRByif36EoE65Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2022 at 04:23:05PM +0800, Mengchen Li wrote:

> @@ -822,7 +822,9 @@ static int wm8978_hw_params(struct snd_pcm_substream =
*substream,
> =20
>  	snd_soc_component_write(component, WM8978_AUDIO_INTERFACE, iface_ctl);
>  	snd_soc_component_write(component, WM8978_ADDITIONAL_CONTROL, add_ctl);
> -
> +	/* Enable MICBEN */
> +	snd_soc_component_write(component, WM8978_POWER_MANAGEMENT_1,
> +		snd_soc_component_read(component, WM8978_POWER_MANAGEMENT_1) | 0x10);

This should be done by creating a supply widget for the MICBIAS
which will be connected by the machine driver to the microphone
widget.  This will mean that the MICBIAS is only enabled when
it's actively being used which saves power.  Look for MICBIAS
widgets in other CODEC drivers for examples.

--Z7sRByif36EoE65Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMe+n4ACgkQJNaLcl1U
h9A23wf/VKQ3FSmdQjFDDJEEUs0HNfY4P0YenSN4PDN5HFlbSLOVniXhlqDgO0E+
mHeFGhUtaTllmz8Y2FnKZmqXnbmqB+s4idpwoN0yKMvgqJQsVdg6ShFjUvezbNUj
g87/GpTbXwoHwDN44FTPbiEvxv5JP1X6OeCpxwE4PV2W5I8gPD4egyONTX/8lN66
wPJkBUkbz0V42TyGix/MFLgWF+V4UHRNU2I5GbLdXclNzQ9hWgDVXXxvmTc6cFSJ
v4ZJx+T4WOIdHxiFzUCmjl5WuUuCBPsyQGAt6+ewD+68G9NKvzImTmXHORelsTqo
vex12eXjTBGKiWAOqQVPHd4no1r9fg==
=O00c
-----END PGP SIGNATURE-----

--Z7sRByif36EoE65Y--
