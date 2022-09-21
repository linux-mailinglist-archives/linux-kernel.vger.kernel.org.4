Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADB5BF87E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiIUIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIUIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:00:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECC82847;
        Wed, 21 Sep 2022 01:00:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A2926601F3F;
        Wed, 21 Sep 2022 09:00:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663747248;
        bh=+67XwHwwwVr9Zy9Tqbi6F11v6db9RC2DSdJJb+2KAFg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dpDnNOEO+DMIu1yXKQmnHpntygMwx1e12LaxutdYdaimetWWIwy7foz7wDU40z3vM
         Nd3lG58+67iMOvxcchRHkDSstgnRgy1JPghhFsNNCP5XWH0YLwJZ/NJrJcM5wln0KE
         Fwqf9Hyx8WX0301IWn670STkn+waoXjhec1qNgnKimhxbTwOAIMcdkjkRRpex1wSbh
         qr4/n7LWVig9ZommdUMWzieQGpzMJQLgCDbNinI34cuS4kKZTRzQ2jWXtea+zokkrx
         3EcQCYKBwOjZ6/VR9LALPixyXTfon+fXR28vkjdGGIjqBusyOXjREvBdgralwVQfJi
         W59s+B3omIdaw==
Message-ID: <66aa53cf-25ed-fc08-f92f-6a0aae48f2e7@collabora.com>
Date:   Wed, 21 Sep 2022 10:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 2/4] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
 <20220920-i350-thermal-up-v5-2-123bc852d199@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220920-i350-thermal-up-v5-2-123bc852d199@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/22 17:03, Amjad Ouled-Ameur ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Add logic in order to be able to turn on the control buffer on MT8365.
> This change now allows to have control buffer support for MTK_THERMAL_V1,
> and it allows to define the register offset, and mask used to enable it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


