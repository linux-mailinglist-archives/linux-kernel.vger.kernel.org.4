Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7659E7072A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjEQT7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:59:21 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E47E67;
        Wed, 17 May 2023 12:59:20 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-146-199-nat.elisa-mobile.fi [85.76.146.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QM3pT6zgSzyWs;
        Wed, 17 May 2023 22:59:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1684353557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uT4QeccEOPKkK7gGYPYPm3Y9FH1yk/CYJCXvyI1gFcg=;
        b=WZFEpJpuxHgdL66a5PaD1yNk7SpgMp9G9guhbNAaUh3HEUxnbuFWcPk8rHcB/dQQJaayMK
        upe+8t3l5YMswlkboqSxW1TMcS8P/5RX1nVRVXD5ExA19T8y7uQqsCZL1U0nsnp5cTTAW4
        WqLdFf44BWpW+Gcb+Kix2JvPsvJMOEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1684353557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uT4QeccEOPKkK7gGYPYPm3Y9FH1yk/CYJCXvyI1gFcg=;
        b=uqZALiO1J2n/ZSQ1Zg25g0VKOhsOJ/6Qt1tM/2HyGw+suNSH0P3c0GzRaRzizaWMSFNnCo
        kXUNe5mMx5fBj+8WBcmDkoSMxVBjAarDMIXN1vF1ZIB9LxTfhPvbYuxL0RtKrJA9x3X5j+
        m2hOXBKV8p6FLsSV8qUVN62sMFztjCM=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1684353557; a=rsa-sha256; cv=none;
        b=RKAECBWDBO58k84XgosU1UrhQq2r0jPWNipNo3Gi0fMRoUGJZblm+3P1vXugNvU+LqaNyh
        c2O6jMu7dk5j7DzRa8mJccrAhHhiOFueDQPGfrq0HfU5IqmE4NrXeiRgdWhUIROwa4xfNf
        00KimNUa/R4AbP591nbysQnVZMJjE/A=
Date:   Wed, 17 May 2023 22:59:11 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Input: ads7846 - Convert to use software nodes
Message-ID: <20230517195911.GG271152@darkstar.musicnaut.iki.fi>
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does not compile as nokia770_ads7846_props is declared twice,
and nokia770_cbus_props and nokia770_mpuio_gpiochip_swnode are missing.

On Mon, May 08, 2023 at 11:20:06PM +0200, Linus Walleij wrote:
> +static const struct software_node_ref_args nokia770_cbus_gpio_refs[] = {
> +	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_swnode, 9, 0),
> +	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_swnode, 10, 0),
> +	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_swnode, 11, 0),
> +};

These should be nokia770_mpuio_gpiochip_node.

> +static const struct property_entry nokia770_ads7846_props[] = {
> +	PROPERTY_ENTRY_REF_ARRAY("gpios", nokia770_cbus_gpio_refs),
> +	{ }
>  };

This should be nokia770_cbus_props.

A.
