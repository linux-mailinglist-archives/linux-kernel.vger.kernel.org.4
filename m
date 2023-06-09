Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED2729688
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbjFIKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjFIKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:13:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3064490;
        Fri,  9 Jun 2023 03:03:16 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B39A26606F2A;
        Fri,  9 Jun 2023 11:03:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686304995;
        bh=Wgiw9IDIUgq3grTnCDHIQrPGKksKz/AqHv9EJoBFhRQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DxclosCgyQHuEe1lK16qHh+kHD7U5qtLaVKsJpkQ9i4QyqE7toKpA0fMGHbTBj7n1
         Uk53Ul4OOn0Q6MUaur1cZWmX6OKy8p7Gck/4dolYZCgtztNWEF6zZILGnSklYjrpVu
         J3duoaGgdCxiOdnQQxiSNUoOjc/H+/6aqDPh7hpRI9ZR2c2fvuCd2x1mLWq9sxrls0
         k6NEBW7ZVbakWhR3iD9R0TLhv7+ozV0pcvteAJ1xF/vObld42lTN7vKHhJw/X/tni9
         bMLHFjFDsvlB3q05u1MaE3sGcrbl88xcnUTA/NdIoOLa/rhfQ8U0b4VaBoLKImy9bv
         6S7hqsc7Q+Aww==
Message-ID: <33c2f13a-294c-fc69-55a3-2a7aef26f954@collabora.com>
Date:   Fri, 9 Jun 2023 12:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 8/9] regulator: mt6358: Add output voltage fine tuning to
 variable LDOs
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-9-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609083009.2822259-9-wenst@chromium.org>
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

Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
> Some of the LDO regulators in the MT6358/MT6366 have sparsely populated
> voltage tables, supported by custom get/set operators. While it works,
> it requires more code and an extra field to store the lookup table.
> These LDOs also have fine voltage calibration settings that can slightly
> boost the output voltage from 0 mV to 100 mV, in 10 mV increments.
> 
> These combined could be modeled as a pickable set of linear ranges. The
> coarse voltage setting is modeled as the range selector, while each
> range has 11 selectors, starting from the range's base voltage, up to
> +100 mV, in 10mV increments.
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


