Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8F643E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiLFI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLFI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:28:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E026D5;
        Tue,  6 Dec 2022 00:28:22 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABB606602A07;
        Tue,  6 Dec 2022 08:28:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670315300;
        bh=CJWvdWCG3UFO2zCYQg9f+JXTw5Zuom1JWkEBupeaBNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jW/2pSOn+W99aXXAsBjsNQg7P0eX9KfqAybhFWZAYfIRV8DJIR9qy+6+7wUhjsakD
         gyq60uUYayeTcJCj+a10ztt2yMiHRehATYkW8ntYzYf8iHDal5HmDfBtxKI2nr1h8Z
         Iu+8wUaaaR6/M61k2nNhio55fQmvFeGNW3AtQaCABnlCMOLXusuIyUzWC6cRlr3M2A
         ESJ0fLMcCyqCkhaFGf/PvV2EuuoJ3pnNfNhiwTXFiGoMgcgO/U57Rt77oIEKpJPoUX
         VhyZTmRmdfL6dUdDIK7FmZs1eqwOXojZQ4B0q1E77/jW/QZyLIrRq/wgQ7NrQ43x50
         UTj6qENA3OQmA==
Message-ID: <adc67800-beae-2f42-9cc7-5f041e390b61@collabora.com>
Date:   Tue, 6 Dec 2022 09:28:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] thermal: mediatek: add support for MT7986 and
 MT7981
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <Y4dYazyXF02eRGC5@makrotopia.org>
 <0b72a12c-286f-79d0-09e9-b1761530850a@collabora.com>
 <Y44tdASIQ2DpL9re@makrotopia.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y44tdASIQ2DpL9re@makrotopia.org>
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

Il 05/12/22 18:42, Daniel Golle ha scritto:
> Hi Angelo,
> 
> On Thu, Dec 01, 2022 at 02:24:17PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 30/11/22 14:19, Daniel Golle ha scritto:
>>> Add support for V3 generation thermal found in MT7986 and MT7981 SoCs.
>>> Brings code to assign values from efuse as well as new function to
>>> convert raw temperature to millidegree celsius, as found in MediaTek's
>>> SDK sources (but cleaned up and de-duplicated)
>>>
>>> [1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/baf36c7eef477aae1f8f2653b6c29e2caf48475b
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> Reviewed-by: Henry Yen <henry.yen@mediatek.com>
>>> ---
>>> Changes since v1: Drop use of adc_oe field in efuse, Henry Yen confirmed
>>> its use has been dropped intentionally in MTK SDK as well.
>>>
>>>    drivers/thermal/mtk_thermal.c | 122 +++++++++++++++++++++++++++++++++-
>>>    1 file changed, 119 insertions(+), 3 deletions(-)
>>>

...

>>
>> What about optimizing this with assigning a function pointer?
>> Like that, we wouldn't check any version in there... as in that case we'd
>> simply do something like
>>
>> temp = conf->raw_to_mcelsius(mt, conf->bank...blahblah...);
>>
>> ...and this would also mean that the snippet saying "the first read of a sensor
>> often contains very high bogus temperature value [...]" would get merged in the v2
>> of raw_to_mcelsius (as that function is used only in mtk_thermal_bank_temperature).
> 
> I found that Amjad Ouled-Ameur is taking care of converting that series
> of if-else options into a function pointer allowing to easily call the
> right raw_to_mcelsius function.
> 
> [PATCH v7 0/4] thermal: mediatek: Add support for MT8365 SoC
> https://lore.kernel.org/linux-arm-kernel/4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org/T/
> 
> Should I wait until this series is merged and then submit support
> for MT7986 thermal on top of that?
> 

Right - that may be sensible. Please coordinate with him, so that one of the two
series actually depends on the other (and they don't conflict with each other).

I've added him to the loop.

Regards,
Angelo


