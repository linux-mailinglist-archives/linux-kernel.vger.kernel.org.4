Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35596E9386
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjDTL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjDTL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109649EB;
        Thu, 20 Apr 2023 04:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D907648B4;
        Thu, 20 Apr 2023 11:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF67C433EF;
        Thu, 20 Apr 2023 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681991895;
        bh=8QMlE5Zx8DCMIClYMX9SMYQfx5Q3HK4Ce3RNNDoqSKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uusm797cmi4abghVByv4IJFJJr2wT6e9ov88XGGFZ16V3lQaePswCkfdBGoerBi54
         SfhQ8A9xeSYLDzbTcpjN0d01pnJxAPWWLP6FbHUzihAaHsijc5NbnXkuaNrScqpgNn
         6zRwGT3xy1jglp8I7yuSy9lpihbE/xSh0O8BoHLf6Nz0MkrHLdTQmbwcgngMr5XJ3r
         54lW4dRiqrtHU6KDpdTAfC8JJN2aSQwi4v7yS2E0oa3SLbiJggxBcX/8HioP+0k1rG
         YtWmxoPCOcX1ehOHP4ikMPLDQJXWSWqo6M16PadCHZow7i4lo5NaM57xVI+p3GHRzQ
         PS+P3I4oMJnvg==
Date:   Thu, 20 Apr 2023 12:58:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
Message-ID: <6b355201-a957-4fca-a513-d5fa0742fb40@sirena.org.uk>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vqfNoi3NLhep8mlT"
Content-Disposition: inline
In-Reply-To: <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vqfNoi3NLhep8mlT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 12:16:12PM +0200, Krzysztof Kozlowski wrote:

> -	gpio_direction_output(wcd938x->reset_gpio, 0);
> -	/* 20us sleep required after pulling the reset gpio to LOW */
> +	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
> +	/* 20us sleep required after asserting the reset gpio */

This is inverting the sense of the GPIO in the API from active low to
active high which will mean we're introducing a new reliance on having
the signal described as active low in DT.  That's an ABI concern.

I remain deeply unconvinced that remapping active low outputs like this
in the GPIO API is helping.

--vqfNoi3NLhep8mlT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBKM8ACgkQJNaLcl1U
h9CEewf/XEC8aLgWsBDB68psO5wv1ThhV486/JVRhSBnT8ZjXhUzNDx256WlTY2F
SBX+O79Y3aZNZF+SB8XXyVaR816sBKuOd5+XedRI3hrjr2cagr1xnVc3d4JW1X55
+hEVZgyzuqgeq+69p8z9mUxuf3loD9migmJ2m/1IqST8ZjVszErvkCxFeSgewWCz
2WedShr3yGyFmmkqT6BDyjFkPwfKfGbBzpT6yZy9L+C0pt7+rG5VNOSs/J8DWkPq
9S+NBJ0lsY7nlWIEOFS8FtkO2iRxNzVZOzoHDdge4IILLRS9r+9aX2xRmMpHqh2p
uG6xvVDD7fZaOvgTy6XpO3HQfHdy8A==
=ERq/
-----END PGP SIGNATURE-----

--vqfNoi3NLhep8mlT--
