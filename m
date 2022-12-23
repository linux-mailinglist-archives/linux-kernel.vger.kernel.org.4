Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A810654E47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiLWJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLWJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:24:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341336D57;
        Fri, 23 Dec 2022 01:24:34 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 658426602CE0;
        Fri, 23 Dec 2022 09:24:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671787472;
        bh=7V70gBK9OEYmEAkkBN5wXw8RnXXhhRdhdQHkoaIpKe0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e40NHzKsNV0hq7vDwiqkRViojw4UT/GWvfQZe52ysa1cvePOe18EWgepLZN4n4d6j
         1S8e/WdCUw1BK0mZRM+4BmBgLdhDbvoTHtWKuW2HnhP5jp/rUJFsnHtMkbUnP+NLu7
         brdjvrGrJf1umNrOH/uQosX8RgKB4RH68nFS2AMP4q93Ut0Nfas6um+iBWL6RXqYFo
         Suox9ULMMGlmn9L4cqq66PgFMyfxqkbPM/6Grz1JVts0XvWpDNkwIIPK2+37eLv+ta
         lKzkSeY6dfUiucvo28cW/UnhIFs1/o0/P7uWZUMVDHv3xg9Wyf8IKyWFFHgO0xG/mP
         65hpcuUzoCM8Q==
Message-ID: <bfc4c7b5-3d5b-e087-1e33-1c461e361802@collabora.com>
Date:   Fri, 23 Dec 2022 10:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Content-Language: en-US
To:     Biao Huang <biao.huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com
References: <20221223015029.24978-1-biao.huang@mediatek.com>
 <20221223015029.24978-2-biao.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223015029.24978-2-biao.huang@mediatek.com>
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

Il 23/12/22 02:50, Biao Huang ha scritto:
> In current driver, MAC will always enable 2ns delay in RGMII mode,
> but that will lead to transmission failures for "rgmii-id"/"rgmii-txid"
> cases.
> 
> Modify the implementation of fix_mac_speed() to ensure the 2ns delay
> will only take effect for "rgmii-rxid"/"rgmii" cases, then user can
> choose phy-mode freely.
> 
> Fixes: f2d356a6ab71 ("stmmac: dwmac-mediatek: add support for mt8195")
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


