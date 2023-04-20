Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D06E9A83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjDTRUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDTRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F2449A;
        Thu, 20 Apr 2023 10:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B374264A89;
        Thu, 20 Apr 2023 17:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E8FC433D2;
        Thu, 20 Apr 2023 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682011159;
        bh=OWzPbivqRUEkhrItNBGzj3uBQBlq9cqwvTC3adE53q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQkPpxk0F41RWEvt9mZlhml/5Ue2gMvM3/0Y+EGA9DRDe3CHJA6Q3ZmfLz58rRkIr
         gG2bFuwUZyJKO/HZhWbKYX4rASVX1W01ccvAva2p1Cc+jTgA4XHn0WpdgSFi4HL8kg
         +k4E1/XIkd85hm3iCThlryDuaE2QGxRNpnvh25uNusC5NhamQrl5nR+a4BnN3BRl/E
         czd7vpZLtLzhQ8V4MSKCwf9jRpnbUFedXZwJ6wiQ0eFkgoQkrJePOtTYXSjWe6tVzJ
         teQIcXV9cbGXlieQm0MiU5eiwO2D7xXptKXHSZoUriqXnV/XXq5Oz78JgtOXgi0aqp
         vPrh3brRNy3OQ==
Date:   Thu, 20 Apr 2023 18:19:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH 3/6] ASoC: codecs: wcd938x: Check for enumeration before
 using TX device
Message-ID: <3147a427-f6db-45cd-967b-dba1b9ff8bd5@sirena.org.uk>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-4-krzysztof.kozlowski@linaro.org>
 <dfe88b94-215b-a86f-60b4-25d2f9ea0e5f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlUxRv2aKVH/fZyf"
Content-Disposition: inline
In-Reply-To: <dfe88b94-215b-a86f-60b4-25d2f9ea0e5f@linux.intel.com>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlUxRv2aKVH/fZyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 09:18:15AM -0500, Pierre-Louis Bossart wrote:
> On 4/20/23 05:16, Krzysztof Kozlowski wrote:

> > +	/*
> > +	 * Before any TX slave regmap usage, be sure the TX slave is actually
> > +	 * enumerated.
> > +	 */

> the alternative is to move regmap to be cache-only in the probe and
> remove the cache-only property when the device is enumerated.

Right, it's generally a better approach unless you need the hardware to
actually do something immediately - if you're just setting up what's
needed whenver things actually get started then using cache only mode is
much less complicated.

--UlUxRv2aKVH/fZyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBdA0ACgkQJNaLcl1U
h9DeLwf+PvFmR3k+omskMKofJfXaRqx9gNhO1EIxPyysnIvGc8wp1CjH0rSUBHDa
/AurDZBZQ2WDs5jx9E0QumJHVU+EG+Jr8n2hVCCdEv/QkRSEPV5A2ozhxHG7JhBy
+WqEZ1CdQE7b8L0PiKqEcsJrRoWSnA6UN15mWBpxlztInIDkmqSKTd6u6JyylH75
wcLspRhFTeT4HA4aQC6adaQNa4OgI5x7uDFL9eHVSrqUnug4KPRI2aGkafizjdtd
F2bMA+NTrX9oVu4FhDWyMTUzGtRPJA1A4SKUqVFe5oIY5f5UXaBdLeBq2ew7ToQT
tmufOOhU+U1jpP1CoA5QDQMaTRkjnw==
=o6u7
-----END PGP SIGNATURE-----

--UlUxRv2aKVH/fZyf--
