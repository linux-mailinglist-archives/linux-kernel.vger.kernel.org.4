Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EA6990A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBPKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:04:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E55E3A84D;
        Thu, 16 Feb 2023 02:04:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6A99660219B;
        Thu, 16 Feb 2023 10:04:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676541841;
        bh=dtOc+ZZc2I4hPdN4XFqAP28l1JSPbCkDmYJF5WgaDoI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TQ9IdzWUsFTqwnTox4KdvD3IMxJsZNshsfb6VkT8iXkrIAmYXqwclrICzx0/s8Wov
         MO08Wo0DXh73HxcZC5k0IC/u8Ehx39eEYM1KHKNAqqYErEba9ZYncaIaLy4RnSs62g
         hYrzresK+58n3oWCOADtWZdb0ljKm6hfUwXpYKJtUaBMIxvlPwB0JYOdMXR1nWgHWL
         g+YNWQpNS5Ue5IHCxJpiJRv+jdHnD6pErIc0RZg5LYyYYnsPs2BaOQrh1Wu99cuSIS
         hFr0dE0bF2nN8WvscdxT4fj9V2MEyMlXIxv/9IG8GYxj6XAF0DExw5AMVlXOhj6bEx
         CZUyVJ35VrFFA==
Message-ID: <84de90f5-da77-d3f2-c14a-d2e5c53bbf1c@collabora.com>
Date:   Thu, 16 Feb 2023 11:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] hwrng: add driver for MediaTek TRNG SMC
To:     Daniel Golle <daniel@makrotopia.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mingming Su <Mingming.Su@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <89865515728cb937b6591160ad9c30b4bcc8dd41.1676467500.git.daniel@makrotopia.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <89865515728cb937b6591160ad9c30b4bcc8dd41.1676467500.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/23 14:27, Daniel Golle ha scritto:
> Add driver providing kernel-side support for the Random Number
> Generator hardware found on Mediatek SoCs which have a driver in ARM
> TrustedFirmware-A allowing Linux to read random numbers using a
> non-standard vendor-defined Secure Monitor Call.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Hello Daniel,

incidentally, I've also done some research on this one some months ago, when
I was deep in adding support for the Helio X10 SoC (MT6795) on Xperia M5.

The rng-v2 is simply the same rng but hypervised by the TF-A... and the only
difference is, well, as you're also pointing out, that we're using secure
monitor calls instead of direct MMIO handling.

There's also not much more than what you've implemented here and the only kind
of addition that we will ever see on this one will be about changing the SIP
command (as some older SoCs use a different one)... so...

...I don't think that adding an entirely new driver is worth the noise, hence
I propose to simply add handling for the Secure RNG to mtk-rng.c instead: it's
shorter and we would only need to address one if branch on that probe function
to set a different callback.

The clock should then be optional for *some* of those "v2 handling" devices,
as if I recall correctly, some do need the clock to be handled from Linux
anyway... otherwise this v2 driver will be "soon" looking bloody similar to
the "v1", adding a bit of code duplication around.

What do you think?

Regards,
Angelo

> ---
>   MAINTAINERS                         |  1 +
>   drivers/char/hw_random/Kconfig      | 16 +++++++
>   drivers/char/hw_random/Makefile     |  1 +
>   drivers/char/hw_random/mtk-rng-v2.c | 74 +++++++++++++++++++++++++++++
>   4 files changed, 92 insertions(+)
>   create mode 100644 drivers/char/hw_random/mtk-rng-v2.c
> 

