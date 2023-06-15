Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F49730C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjFOA4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOA4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB31BDB;
        Wed, 14 Jun 2023 17:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E19E63A1D;
        Thu, 15 Jun 2023 00:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B087C433C8;
        Thu, 15 Jun 2023 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686790604;
        bh=OKEogft+ftRPAL0ihwo9W+L1ntvp3tS05T85RJNv/Ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TB16isRpH8eDTfmvhjnt5myNDmbXdjsVb3iuxd02Rf66m14OEUXzv1/uuSxRMhQ9+
         YV3R7OzC+vUUau3qUk1PD0zMiGiCMLw0Xz1WScBGutMhaAL9/t5uk03AuWFTVcKlWQ
         fXVbahDffF21ljddbldj8G3RjGvcSAD6OgPKOfIJF9V2KBfU4Izm4QdPr/jh9PJncM
         4ki7qkwahsufDS9Aw3LlwphE5ZyY1QsBCkkXNqjhUCCeUF9T6kVRl2+WhrBvm3ICOp
         GaWNqHWLXn9xXo3qaRVDzW2tESKt0sXLs4u5DDZ1qPOIgh+st+kyj2DOtgrW6QVABA
         OEOelyRLHOjTA==
Date:   Thu, 15 Jun 2023 01:56:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     yixuanjiang <yixuanjiang@google.com>
Cc:     vkoul@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
Message-ID: <92159f51-2e17-4c6b-8fd4-0bde8b1dd38a@sirena.org.uk>
References: <20230613062350.271107-1-yixuanjiang@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yfBNAdUiVMRgFxH8"
Content-Disposition: inline
In-Reply-To: <20230613062350.271107-1-yixuanjiang@google.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfBNAdUiVMRgFxH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 02:23:50PM +0800, yixuanjiang wrote:
> Modify the error handling flow by release lock.
> The require pcm_mutex will keep holding if open fail.

> +++ b/sound/soc/soc-compress.c
> @@ -166,6 +166,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
>  	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
>  out:
>  	dpcm_path_put(&list);
> +	mutex_unlock(&fe->card->pcm_mutex);
>  be_err:

This is really hard to follow due to the lack of any mutex_lock()s in
the function, I think because this is intended to undo
snd_soc_dpcm_mutex_lock(fe) but if that's the case why is it not using
snd_soc_dpcm_mutex_unlock(fe) like the success path does?  Given the use
of classes not doing that looks like it'll create lockdep issues.

I'd expect the unlock to match the lock.

--yfBNAdUiVMRgFxH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKYcMACgkQJNaLcl1U
h9AIFAf+LLNgL9osk++AWzcSBDBByXr2ksUuFuAjK9f/R7G+Slh2/w7hotCeNbFh
UxGQu0bkilmwhLUVwBbbyQhRCcXXJMXqDGBxbsVzJwwrq2Xw9IFlZx+Q2acg/Uce
j4XoOPvrnxNXIld5kAJmoHmVLrnwppge9wT1T/Bof9a5SqhcDOqjuYYv/Vbcta2+
KgPHAe6hRQ1SGjTyoP4fwYfTyikTtiBP9S32dMDGCzcxFGTFXovVMFNeXDgMwSRf
r8WH8jz8WD+dKuU3s39Wioe4AxWqDu7AsXOkU7zynAYlWDx8TvNOI0SVknZxpLf3
7ua6T/Hcp8DPaxgdmNjAkTTvG5Ferw==
=zGKJ
-----END PGP SIGNATURE-----

--yfBNAdUiVMRgFxH8--
