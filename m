Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D2679D88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjAXPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjAXPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:31:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103534B893;
        Tue, 24 Jan 2023 07:31:14 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5597C6602E26;
        Tue, 24 Jan 2023 15:31:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674574273;
        bh=XzNWMNMUfZ0GUDmKAy/1fnLOVo23adcRjRtL+79OId8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wd3alA47WJak7VwJSwj/g28hfDBPbDYB4YWhX2yIzbv1EFbkY6ZbZrfU9p8BL4kHG
         GEkU5beBUZ/ETjL+r9EfyVo++qItpQADfj4QgrVgUZ+2uEuoNNtBJ1jT0KyM7lO0Sp
         9+0LCBYKp6IdH8CAk+bkCIW7fhIHD/DR6xpkZMuao04IS9ItM4RVcBqrpnyuHQ8fQE
         MAxPgcPckoC8LuSthZNtsFdpmnc3gsFrNAIGHXan86l9DBk1GfCavwpxVWkhFES1nj
         +cu5fi0WFvmxIruSdHfV+HgCCsabSIAykerlE+LdrftpqxHNHh4kBxAauZYGi/W150
         8AwvnJnfqkj8g==
Message-ID: <5dd5c795-5e67-146d-7132-30fc90171d4c@collabora.com>
Date:   Tue, 24 Jan 2023 16:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-5-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230124131717.128660-5-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/01/23 14:17, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
> controllers contained in a thermal domain.
> 
> A thermal domains can be the MCU or the AP.
> 
> Each thermal domains contain up to seven controllers, each thermal
> controller handle up to four thermal sensors.
> 
> The LVTS has two Finite State Machines (FSM), one to handle the
> functionin temperatures range like hot or cold temperature and another
> one to handle monitoring trip point. The FSM notifies via interrupts
> when a trip point is crossed.
> 
> The interrupt is managed at the thermal controller level, so when an
> interrupt occurs, the driver has to find out which sensor triggered
> such an interrupt.
> 
> The sampling of the thermal can be filtered or immediate. For the
> former, the LVTS measures several points and applies a low pass
> filter.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On MT8195 Tomato Chromebook:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
