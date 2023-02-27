Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C866A3E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjB0JdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjB0JdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:33:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9118C6E84;
        Mon, 27 Feb 2023 01:33:19 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B652F6602216;
        Mon, 27 Feb 2023 09:33:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677490398;
        bh=Mn5+1GgbIcs3gF0vqo4gwK7PU4+vkjmffmOubBKLC94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bT4q2jbHljX0TDVeC31IiMe8mnWd0j6aWGmcXxSQ7XZGogkNc8jg6h0KZ4GzGi4a/
         BbAm73kSZAjjQ23bkJpYY/JvtL9I0dw5LLGjAC7RsddM+YXP2fzCgqKM4WC+J00jFb
         iwGejyiK4C256l0YArmFdm1lmzn8iLuPF57tIZZT4Pi7F1LpAEJStO4vVBDfIDo+nD
         V7sBkf2Ro5TAgkY4UjA8izMaITw8EWfpmTzY1PQ2F28WexKstQops2MD2TZPHq5GVK
         tnF04Ute0eLEBNN8JH4IcEOdE2LhtWJK+xXPzCaUmLYqKW117WomsAYKsgA3zXIf0x
         K9KH0w8KtzQGA==
Message-ID: <45a8757b-68b0-a79f-7ea3-426825493140@collabora.com>
Date:   Mon, 27 Feb 2023 10:33:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] soc: mediatek: scpsys: Add support for MT6735
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230225101629.264206-1-y.oudjana@protonmail.com>
 <20230225101629.264206-4-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230225101629.264206-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/02/23 11:16, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add support for SCPSYS power domains of MT6735. All non-CPU power domains
> are added except for MD2 (C2K modem), which is left out due to issues
> with powering it on.
> 

This is a legacy driver and I'm convinced that we should do something to
actually *drop it forever*.

Please add support for power domains in mtk-pm-domains.c instead: if you need
a nice example about differences between the two, look at MT8173's implementation,
as that is present in both scpsys and mtk-pm-domains.

Summarizing, your MT6735 support will be about:
  - Adding soc/mediatek/mt6735-pm-domains.h
  - Adding support in mtk-pm-domains:

static const struct of_device_id scpsys_of_match[] = {
	........
	{
		.compatible = "mediatek,mt6735-power-controller",
		.data = &mt6735_scpsys_data,
	},
	.........
};

Cheers,
Angelo

> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---

