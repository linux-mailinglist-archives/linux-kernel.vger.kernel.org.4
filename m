Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1C746E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGDK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGDK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:27:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421FE47;
        Tue,  4 Jul 2023 03:27:12 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 433636606FA4;
        Tue,  4 Jul 2023 11:27:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688466431;
        bh=xo231CNcuC2FkqsWHh5xD0ZSPl+ptrgtwj19pWAl14k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iV8K8cjG+hZqKPxJguIYnxx6N9xe35IrMtEK/fGD9AiZWnEaWeeB+fS9VusNO/TwI
         eeXnGulI6rbQKBJ2UIv3zhgMrrIHNP7OCFNQ/FeIOgWOStqWke1fBAoWOKjcn3oaGY
         ll4FnTPyczknABlgg/HamhAUqd5bJwyt4MlSzigY7wfG+g/v2uhOz72UwYUD0Z15g/
         r3NeQ37idJ8StDKXxciT/7LhPQlLfo5qtgyxOr1DStTszYEvTSFWcqqxo8nOQAq7Fz
         bpa2G8Bn+1QWGjq/wyiyOa0NKoGa6cqHlQGDIaNdFuizm8W6D8rZ4iPx8eP6qP2LVm
         hkwWXlcFOSbnw==
Message-ID: <8f1136b6-7c93-73eb-545d-bbdb0ff6f0b1@collabora.com>
Date:   Tue, 4 Jul 2023 12:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 6/8] soc: mediatek: Add support for WAY_EN operations
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-7-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230627131040.3418538-7-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/23 15:10, Markus Schneider-Pargmann ha scritto:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This updates the power domain to support WAY_EN operations. WAY_EN
> operations on mt8365 are using a different component to check for the
> acknowledgment, namely the infracfg-nao component. Also to enable a way
> it the bit needs to be cleared while disabling a way needs a bit to be
> set. To support these two operations two flags are added,
> BUS_PROT_INVERTED and BUS_PROT_STA_COMPONENT_INFRA_NAO. Additionally
> another regmap is created if the INFRA_NAO capability is set.
> 
> This operation is required by the mt8365 for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


