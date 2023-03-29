Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7F6CF702
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjC2XZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjC2XYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68FB44B4;
        Wed, 29 Mar 2023 16:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8457B61E40;
        Wed, 29 Mar 2023 23:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B6C433D2;
        Wed, 29 Mar 2023 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680132277;
        bh=D2GwH8XifzDhAblLuWcOauF2qJOnjSoJvfWklDnAo0o=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=oZjXTsm9Wf/QCaR2kj8aHdl3T+Uub65oUdYjjwzdK+X2fKyBqS1D9xIcq0dXLBdCe
         4H+H9efBBtTacXIJSI2PGiaVXeAnd6xyYobML+8niqimPlWw6rSyk/lGGGecGDp62l
         EQFF/Zg/HhD9lfMPlWK1gQ/Oa5aUgPKiw+PPt7Twu4+0BfbFCdM4crtKclozBQuX+w
         3WdKIKNcRfVqgbFeuEmOajb3fRjfHXAo81ZDmgYyG54NNxCUA7epSnz3SpuV3WC8xR
         YEtW/JgajaeX1SnnGEHzgsjpwQ1ONaBJIWcOzATpVah7fsa9iR47myAhuH56/i8huE
         Aes14GY1kbqkQ==
Received: by mercury (Postfix, from userid 1000)
        id 0B0EF10624AF; Thu, 30 Mar 2023 01:24:35 +0200 (CEST)
Date:   Thu, 30 Mar 2023 01:24:35 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv3 02/14] power: supply: core: auto-exposure of
 simple-battery data
Message-ID: <20230329232435.rjdzoluxagwy4tvu@mercury.elektranox.org>
References: <20230317225707.1552512-1-sre@kernel.org>
 <20230317225707.1552512-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uv7vcc4lwuwob7hz"
Content-Disposition: inline
In-Reply-To: <20230317225707.1552512-3-sre@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uv7vcc4lwuwob7hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Mar 17, 2023 at 11:56:55PM +0100, Sebastian Reichel wrote:
> [...]
> +	/*
> +	 * Expose constant battery info, if it is available. While there are
> +	 * some chargers accessing constant battery data, we only want to
> +	 * expose battery data to userspace for battery devices.
> +	 */
> +	if (desc->type == POWER_SUPPLY_TYPE_BATTERY) {
> +		rc = power_supply_get_battery_info(psy, &psy->battery_info);
> +		if (rc && rc != -ENODEV)
> +			goto check_supplies_failed;

I merged this a few days ago and got a bug report from KernelCI,
that -ENOENT also needs to be handled. I fixed this in place.

-- Sebastian

--uv7vcc4lwuwob7hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQkyKgACgkQ2O7X88g7
+pouzBAAjZh4e+txg6+30IosEQnaNrcWMB1IY/DYmXJA6cMCfSAyuUEY6j/bwcUM
3qXIHRtm4qrWN3IX2CWLu/28F4BiXUjSmTLlzWqzptLhCRRbJijzqrgzGkLo1jCl
ZBG4gYYdYo+sDVsIPSDLyosqVghCrclnRLjsEYF6lTtDmPNmwB1z/euqLC/lgndy
nvVusMVW3DB2G3tsxtXyfEY68GGZOpZgTnuZrle6zjnRYAD5ZQVJhsFoEsIT/dgJ
oRY1aX7jZy7Ha/vzdzypKiZM8V1UAWPnu+45LcTjy2NgQRp5mj6ERFJ9m3/Myv/r
leVbdGiWi5HIQiPZvF7h1QQDN7fZ4wU3abVis6iBnnHuOzdOFVF8BvaGGgPvRFn/
HcgdtK2notxCbONYo5moKDAjCGoxqJMY4J5ZLt5Caweg+oZ5u7IKtLd6f975DrSt
4949HmPXaDFdZMdWn8/fF6AcVsVNx5pM70Va52sIkVTF0WyFlOk3BEAypRllc3Dq
dWSqZwSLkF0T6GAC1eScuaTp6xhMxmct3qhG7893+AzXy2Lu3LW10tOhoiBXsQPQ
dalfxb217mhM50ld6VEkm6Bnge5X4vBz1aGjxGeT0FsDRbI718+tJV2cUZRMdgSE
vy9rimB4KUdMDT5LYCXd4vdN/wTHIkQ0Tkbg9ObU6VccVnXTw2I=
=kyq1
-----END PGP SIGNATURE-----

--uv7vcc4lwuwob7hz--
