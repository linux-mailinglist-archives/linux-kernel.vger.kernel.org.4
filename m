Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE8697E57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBOO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBOO3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:29:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D43431D;
        Wed, 15 Feb 2023 06:29:54 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D0E966020E0;
        Wed, 15 Feb 2023 14:29:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676471393;
        bh=7q+8dNYL/2VORRV49y6U9IKXin8dzr+DqWZ4K1xflFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d2TOQnXU3I/RFS5jqXtPVt5fMugZiiKfs0qaBwzNvTsQSRY8PiWKwVK5/1CM3R2Or
         6OWLEgVcRtuIdGWOZdn0eV7qjB+h+oLs9M2KG2P/3d1HabS9hodgqbDDMCUkOvXpwi
         /z8ROm7vcXhjhJyh/Poj9AFABj2f9OsZCfF4ctrtOqCP4PID8jGbEAD2o4uYtwGlIr
         yqpS5hZLOrVIuQpIQ++j+TrcJSaoNnX7GLFvHfWJCPt8xkPWWT6v92jLCIKzPM5C/N
         HimyhpY4TqA3qNNZZRa762rqfRtExa+ktT2o/L0JcXYFIkUe+QITjG5XHvk8Y3DpOr
         tfRlQvxukAtFA==
Message-ID: <deefed32-f675-5f71-3eae-6ef3f07ed5f2@collabora.com>
Date:   Wed, 15 Feb 2023 15:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/3] rtc: mt6397: select IRQ_DOMAIN instead of depending
 on it
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>
References: <20230213041535.12083-1-rdunlap@infradead.org>
 <20230213041535.12083-4-rdunlap@infradead.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230213041535.12083-4-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/02/23 05:15, Randy Dunlap ha scritto:
> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
> it directly thru "make *config", so drivers should select it instead
> of depending on it if they need it.
> Relying on it being set for a dependency is risky.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> Therefore, change the use of "depends on" for IRQ_DOMAIN to
> "select" for RTC_DRV_MT6397.
> 
> Fixes: 04d3ba70a3c9 ("rtc: mt6397: add IRQ domain dependency")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eddie Huang <eddie.huang@mediatek.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-rtc@vger.kernel.org
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Rosin <peda@axentia.se>
> ---
> I have a similar patch (should be a series) for REGMAP.
> 
>   drivers/rtc/Kconfig |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

