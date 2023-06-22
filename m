Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2073A098
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFVMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F33171C;
        Thu, 22 Jun 2023 05:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3C386181E;
        Thu, 22 Jun 2023 12:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C498C433C9;
        Thu, 22 Jun 2023 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687435937;
        bh=6Xu2wCENStSvaqj43E0Q17bFqGPg6/KNIkyezGCjmnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEijQyi4tSvUQdLQTfvjGyAXE13WFLKTiKn9tymotGyj9MrpyhZSM7jxUtoXTnhlQ
         9Rs2WrifoUxDkLoN3Fxsjh2/03rA2HwHIx1OtFENRQSVl1GvQS4O7DG7eKMi2b4D1n
         ct6UCFzsprZqVyfmn3PV4zP0GnVHHOuEnbLc0FJbz5N6ZEZ0k75dnBEUQ90EraDg+4
         MY6Gu13FmEtBPGDk5io18V5/rCYIY1DJEkptOvU49XuUJmy77lu+11XUmHDauCkYox
         JdTnd30ahs5uhB5/0lVwaC0BWzyLUSWO1axZxwSEXj0JiTDyb08V5Kvo7EV9xip3YU
         i4SUA21+MSwzQ==
Date:   Thu, 22 Jun 2023 13:12:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH 4/8] ASoC: rt5640: Fix sleep in atomic context
Message-ID: <f7414eb4-71f8-486b-81d3-6f467521c013@sirena.org.uk>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-5-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmZf6YixTAJnTWBR"
Content-Disposition: inline
In-Reply-To: <1687433656-7892-5-git-send-email-spujar@nvidia.com>
X-Cookie: Please ignore previous fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmZf6YixTAJnTWBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2023 at 05:04:12PM +0530, Sameer Pujar wrote:

> The IRQ handler rt5640_irq() runs in interrupt context and can sleep
> during cancel_delayed_work_sync().

> Fix this by running IRQ handler, rt5640_irq(), in thread context.
> Hence replace request_irq() calls with devm_request_threaded_irq().

> -		ret = request_irq(rt5640->jd_gpio_irq, rt5640_jd_gpio_irq,
> -				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -				  "rt5640-jd-gpio", rt5640);
> +		ret = devm_request_threaded_irq(component->dev,
> +				rt5640->jd_gpio_irq,
> +				NULL, rt5640_jd_gpio_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"rt5640-jd-gpio", rt5640);

This is rt5640_jd_gpio_irq() which just does a queue_delayed_work() not
a cancel.  Why is it being changed?

--PmZf6YixTAJnTWBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUOpkACgkQJNaLcl1U
h9Cs8wf/UEwbtTdAHWhK0Uu6tv5x19scLqiFmt/RTXgMBciw2qZ3rUJ4O1QUQPlX
U7c0gneOB6DTzi+Hu3kfRdDvBjssXw962tweKWabtHgAN0KtJPjpPS65N2H43QeB
N1GtXkNBhQuHfCebmyvMch0Q4lptS4VZP05IRwMnOk85w0qCg4q+FbIZR0IF8V6D
5nzYgpoNaG02mha0jX6Wh7+10Ln3qPEFmTaoEUAYxBh+xpMC0TGUfuCkQOp4eSD/
uskCAVoBstJpyWtqalSm7Z9HUjX58qwk8hro8IRWPdg7T+FPcZUgW8dnhJ5Srs4+
UGV61KEklv6gSCJI63L0jH5dtFly7Q==
=erIT
-----END PGP SIGNATURE-----

--PmZf6YixTAJnTWBR--
