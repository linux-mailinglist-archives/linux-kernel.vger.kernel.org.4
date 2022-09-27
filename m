Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902655ECF67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiI0Vjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiI0Vjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:39:41 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1335CD1;
        Tue, 27 Sep 2022 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=2JMLfcmZeS6Sxey/juZszgrKjCQGK3qAWvZUg82Nalo=; b=DE817yt/jIg3i8+SdpFozjOoLX
        O9WbPIlD+89sho1SMwwgLDKgMTxPJwFlwnO2Yido0b1bzVUUsqddDjM7x7NK2I/ulnI9GjVPKYrjs
        DUlaIwgsY8rTKxQbPKyjuBWOyZw6RYW1pdR1WtXme2ayi1MXPD1OPnUbUxA2LYt1lQgiEPl4LSO5N
        VUsD4IvPYZydEbA/mjKYd1Mn+iSOKXjYct3TGTJwRQnEDuvlMWOJwsed/5pMkpdUze9Gjzs6GTanC
        uH01DAX1kp89bLWi23bY4hX07VpgzFxj4Cfm8J+LX+nrnY7sTliWjTpXAtvVk/mToI1ukf/w7uJzY
        8frYoYTw==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1odIId-00C1hi-Hs; Tue, 27 Sep 2022 23:39:31 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1odIIc-000VSP-3D;
        Tue, 27 Sep 2022 23:39:31 +0200
Date:   Tue, 27 Sep 2022 23:39:30 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFT 4/5] crypto: rockchip: support the new crypto IP for
 rk3568/rk3588
Message-ID: <YzNtkiR/dD0aEZrv@aurel32.net>
Mail-Followup-To: Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220927080048.3151911-1-clabbe@baylibre.com>
 <20220927080048.3151911-5-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927080048.3151911-5-clabbe@baylibre.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 08:00, Corentin Labbe wrote:
> Rockchip rk3568 and rk3588 have a common crypto offloader IP.
> This driver adds support for it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/rockchip/Kconfig               |  28 +
>  drivers/crypto/rockchip/Makefile              |   5 +
>  drivers/crypto/rockchip/rk3588_crypto.c       | 646 ++++++++++++++++++
>  drivers/crypto/rockchip/rk3588_crypto.h       | 221 ++++++
>  drivers/crypto/rockchip/rk3588_crypto_ahash.c | 346 ++++++++++
>  .../crypto/rockchip/rk3588_crypto_skcipher.c  | 340 +++++++++
>  6 files changed, 1586 insertions(+)
>  create mode 100644 drivers/crypto/rockchip/rk3588_crypto.c
>  create mode 100644 drivers/crypto/rockchip/rk3588_crypto.h
>  create mode 100644 drivers/crypto/rockchip/rk3588_crypto_ahash.c
>  create mode 100644 drivers/crypto/rockchip/rk3588_crypto_skcipher.c
> 
> diff --git a/drivers/crypto/rockchip/Kconfig b/drivers/crypto/rockchip/Kconfig
> index 1010d897d9ef..84ca1081fd0c 100644
> --- a/drivers/crypto/rockchip/Kconfig
> +++ b/drivers/crypto/rockchip/Kconfig
> @@ -26,3 +26,31 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
>  	  Say y to enable Rockchip crypto debug stats.
>  	  This will create /sys/kernel/debug/rk3288_crypto/stats for displaying
>  	  the number of requests per algorithm and other internal stats.
> +
> +config CRYPTO_DEV_ROCKCHIP2
> +	tristate "Rockchip's cryptographic offloader V2"
> +	depends on OF && ARCH_ROCKCHIP
> +	depends on PM
> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	select CRYPTO_MD5
> +	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SM3

That should be CRYPTO_SM3_GENERIC

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
