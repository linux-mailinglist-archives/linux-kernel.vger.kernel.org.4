Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D06E5B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDRIBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDRIBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:01:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA55448C;
        Tue, 18 Apr 2023 01:01:02 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 742AE66031F1;
        Tue, 18 Apr 2023 09:01:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681804861;
        bh=P44nwNTaTh4la/amu8IeDe814GXL+1rjHBN5zd5Piwk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q62tPvH7xp+V1Kgdk2oTay47f1wbeVxcbCVGuUWM2rIvKQm8n4pC5+k2ONaLAFDPO
         jklV4hKn7FBsFmIzUurIV10TMSbUlCXw0lkMGN21ButMt9Dfzdykiq5H4V+qu66iWq
         81taUlhzMrI+fiL9jteTkYVknmiYY/jB0toqvTkVEnFbsZkCcXV9QtntYsWSBIAIkQ
         hVfG7MX4CcmHzKmcIn5pfldKoLmebDjwjwfgnw5ofVuDsrUjIshmfy0bvloO1Ez6Y3
         4wKz9FngXsWVGnp0vX31xDj+ea4hsFD41Z2B1W82Utnp6DTORpoG7D8Nsu0DO3TqbF
         ic1Poall/QVaw==
Message-ID: <393e77b5-38f4-98ef-9cc8-003436d58ddc@collabora.com>
Date:   Tue, 18 Apr 2023 10:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] irqchip/gic-v3: Add Rockchip 3588001 errata
 workaround
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Marc Zyngier <maz@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230417214035.101190-1-sebastian.reichel@collabora.com>
 <20230417214035.101190-2-sebastian.reichel@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417214035.101190-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 23:40, Sebastian Reichel ha scritto:
> Rockchip RK3588/RK3588s GIC600 integration does not support the
> sharability feature. Rockchip assigned Errata ID #3588001 for this
> issue.
> 
> Note, that the 0x0201743b ID is not Rockchip specific and thus
> there is an extra of_machine_is_compatible() check.
> 
> The flag are named BROKEN_SHAREABILITY to be vendor agnostic,
> since apparently similar integration design errors exist in other
> platforms and they can reuse the same flag.
> 
> Co-developed-by: XiaoDong Huang <derrick.huang@rock-chips.com>
> Signed-off-by: XiaoDong Huang <derrick.huang@rock-chips.com>
> Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Co-developed-by: Lucas Tanure <lucas.tanure@collabora.com>
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


