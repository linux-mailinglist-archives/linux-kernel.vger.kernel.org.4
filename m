Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013870730B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEQUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:30:21 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982835AD;
        Wed, 17 May 2023 13:30:18 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-146-199-nat.elisa-mobile.fi [85.76.146.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QM4VF60zwzyWs;
        Wed, 17 May 2023 23:30:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1684355415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTkUMKFrciCQ4jvTUoCLaFdooSw1ob2FrpRn38lXzSc=;
        b=zFSqMzYpKIoO2u9ou920IiHgMUT6AJ4zTnOheAdfxrpUGH7C7Ms1V2Rl5w1p9jZwSR06an
        uklHtEjV39RsP+eSV3D3EhNHvJC9RzGOO9UppS7bmngSQvnv0wTIl6qEKYNPcClXqztNt0
        0TrdBA4L8eovau8osgSuF/OJ6O6RiNs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1684355415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTkUMKFrciCQ4jvTUoCLaFdooSw1ob2FrpRn38lXzSc=;
        b=MseZBiMF3JsOdjPfUiXfvsFdWJHKy/+NCnhp7jv/O/Thws6O18OalODIcnGze7eMrJGvQW
        cYy6b6gSYvMe+12PRjfTg27fJj7tSTzmqGiAc+mu6NIhoeujqB4j2pu7lD8lVALb7Dqk/e
        G612Mn780vfcocyGetTmDEo9mNt0FwE=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1684355415; a=rsa-sha256; cv=none;
        b=N0eWTuiTSlWvCqqFgNs3lGYhdcQDcTkJNp7aeODqoJNFSAu0lYRvEVO5WlYNrdEDzS1nNs
        gLvJdu8WXbtSegTRz74AKm4FlJs5LLTLz2FVTGvvCBkEWJ7s29ekpkRe98AiEye6aRXSSt
        Y1l1Z+SjdvgjCuX3c4rUCRsnZ9C68Wo=
Date:   Wed, 17 May 2023 23:30:11 +0300
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
Subject: Re: [PATCH v4 2/4] ARM/mmc: Convert old mmci-omap to GPIO descriptors
Message-ID: <20230517203011.GH271152@darkstar.musicnaut.iki.fi>
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-2-9b6dc5536b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v4-2-9b6dc5536b17@linaro.org>
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

This one has some issue as mmci-omap is unable to find the GPIOs on 770.

On Mon, May 08, 2023 at 11:20:07PM +0200, Linus Walleij wrote:
> +static struct gpiod_lookup_table nokia770_mmc_gpio_table = {
> +	.dev_id = "mmci-omap",

Changing this to "mmci-omap.1" helped, not sure if that is a correct way.
Most likely N800 and N810 are broken as well.

A.
