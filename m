Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD986753CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjATLtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjATLsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:48:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E721917D3;
        Fri, 20 Jan 2023 03:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DEE61F22;
        Fri, 20 Jan 2023 11:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DA1C433EF;
        Fri, 20 Jan 2023 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674215270;
        bh=KAjnNhah3ll/grP437CAe+fwigJLFCx/dyaLEnnMBho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slnuebzPClnyIgvR+p4EomxUjtfjiNpXEAPWoIIXVvb8g7ApNKm8wUaDHFQWp/PhW
         V+x93bFijdAdbbj0LdlBPQ+HzcDe59Ei2xb/bucc+w7cLQqVmkKQK7SApZQRFWZH9T
         0PZFuAkpRbTitDIgYdWmMRicGuQopgwA1+M0d9retbqPGprHKsklV5tjpNAwptpegv
         MWnv5Le1PGXTCTmMhbVGKtDuSB5UyTRSspd14k5AjzTOGF8jDYG6sMQaINC4PQR9aK
         cRQAb/1Sg5nYGXhau6QgfdkSCxGjVQRgopVHxdSOPVdAxT7w0jUTy9ZKyO3wxyRR8E
         5DhM2lXENT7IA==
Date:   Fri, 20 Jan 2023 11:47:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] regulator: Introduce Maxim MAX20411 Step-Down
 converter
Message-ID: <Y8p/ZOj+wUf5os5o@sirena.org.uk>
References: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
 <20230119214749.4048933-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9FC1blPi5kbjWuhg"
Content-Disposition: inline
In-Reply-To: <20230119214749.4048933-3-quic_bjorande@quicinc.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9FC1blPi5kbjWuhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2023 at 01:47:47PM -0800, Bjorn Andersson wrote:

> +	desc->ops = &max20411_ops;
> +	desc->owner = THIS_MODULE;
> +	desc->type = REGULATOR_VOLTAGE;
> +	desc->supply_name = "vin";
> +	desc->name = "max20411";
> +
> +	/*
> +	 * voltage = 0.24375V + selector * 6.25mV
> +	 * with valid selector between 41 to 165 (0.5V to 1.275V)
> +	 */
> +	desc->min_uV = MAX20411_BASE_UV;
> +	desc->uV_step = MAX20411_UV_STEP;
> +	desc->linear_min_sel = MAX20411_MIN_SEL;
> +	desc->n_voltages = MAX20411_MAX_SEL;

Doesn't really matter either way but the more normal way to write
this is to have a static struct with all the fixed values in it
rather than dynamically initialising one at runtime.  Otherwise
this looks good.

--9FC1blPi5kbjWuhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPKf2MACgkQJNaLcl1U
h9BpIgf/W/fEuYxxoY3giQ6LSCmi8VJrGiDaNHHWNkWJ5MuxP1G6Jc05uv5yUm1j
8YN7VZeeKNyZBKuXfk6dh/03hLMoWq5EX/MN4AP433tWR2lepJkSACbBnl2tsOOi
6yfpqqzvKyXyjbstSbxQNjUHh7vpxY1uyWFKZMaHf30JltgXJBoUp1YQK15927Wh
ibVGsLnXz/JXooBwgxSpnSQQZv5KLQD+e1Lmi3jZ4Oot8o8fLSHJkKDUskTGtpX5
clYf4rU6jolwBiKmeflK198Iv1rnX5Pybcw2sVrtiE/G2BGf0Ej/EqrcKm52D4ok
lWyaIv04d0tTTR0OEubdaSJeIn7P7g==
=LbwF
-----END PGP SIGNATURE-----

--9FC1blPi5kbjWuhg--
