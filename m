Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C72694C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBMQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBMQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:08:57 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982AF2D7D;
        Mon, 13 Feb 2023 08:08:55 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 301F8857C1;
        Mon, 13 Feb 2023 17:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676304532;
        bh=c6r6Ciaes/95syK0f/OJaS4UUuptxxv9gZQkGY6eddI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d2xgP+jD10peloT30uV3U/jgniUsS+Hs4wi7BRuTvr28xfkbuI01dj+ADCxPaz7Qh
         8drs32H3fKc5dae/F7HfsOlJfa/3Z8w4E8h6MvWhWDt/JPm8JVG4nHkc8ahOTMVzFO
         jP8Cwpf+HhGlesxEefEUdJ9sfRMJUTVPbhxinGJZbcq4Umj8EAGV0i+c1BXKeNd5lg
         ksOtNnokeBwueIXoFgvvY9P+OMxTh2AGIaDwc8hemkXhq7rk6BLz6h9cavl7wB3kNs
         g9YfRFL6kmvudEgoZm+mTKyijLjxF0v6XyUK9UbC75JvcDvGy+Sk6sYBwDbxz1fAPQ
         rswgfbesAzMAA==
Message-ID: <7b1a8b7d-2269-7ff2-d480-ae5de8c4cc4e@denx.de>
Date:   Mon, 13 Feb 2023 17:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230213155833.1644366-7-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 16:58, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This fixes the LDO5 regulator handling of the pca9450 driver by
> taking the status of the SD_VSEL into account to determine which
> configuration register is used for the voltage setting.
> 
> Even without this change there is no functional issue, as the code
> for switching the voltage in sdhci.c currently switches both, the
> VSELECT/SD_VSEL signal and the regulator voltage at the same time
> and doesn't run into an invalid corner case.
> 
> We should still make sure, that we always use the correct register
> when controlling the regulator. At least in U-Boot this fixes an
> actual bug where the wrong IO voltage is used.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

I may have a kind-of obvious request, since we removed those SD_VSEL 
very recently from other boards, could you just revert all those patches 
and only fill in the SION bit in V2 on all those boards too ? That way, 
we fix the LDO5 regulator for everyone who used it before.
