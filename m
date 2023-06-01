Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DED3719841
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjFAKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjFAKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:04:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D8188
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:02:36 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6E326602242;
        Thu,  1 Jun 2023 11:02:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685613755;
        bh=c9/JGj6n9dQavUzDKtvwfUUsDE5SYT/ikxE7N8P47Gc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eCSKJqgTXeHjGfxPPBH7NmCGLB7aQXG2i+QZ7NQPEk90733Fxr/8IrwTvYjDwg/3n
         A6I9v3o+KtI0ezHRvI5edsGItxp7nqX/pNLsNuHUsHZn2wKYvTeDniTiMDIGwmtnO/
         T2N6LOBB7SQXhBHubU8KC606oyVJMiqZdfFsDNkXdCIzBzfnT4bAtzm3uhxZgRqMe6
         SJ6xdxuj851PTiA92EoeLkrSGtA81q7k4Uo7lK5R/ddO88Gv3Aev1nj1foQspVv16Z
         b9w56KfyRH6Rbmld0pnivpFT91rwnBvCecFVrrn29eo3q0OTHKrH0tS7Rlbjmskhe4
         EWuWe7HyQ0/Kw==
Message-ID: <86e1ee74-72b7-fc89-08ee-562980f2a4e9@collabora.com>
Date:   Thu, 1 Jun 2023 12:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt8188: fix use-after-free in
 driver remove path
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     dianders@chromium.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230601033318.10408-1-trevor.wu@mediatek.com>
 <20230601033318.10408-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601033318.10408-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 05:33, Trevor Wu ha scritto:
> During mt8188_afe_init_clock(), mt8188_audsys_clk_register() was called
> followed by several other devm functions. The caller of
> mt8188_afe_init_clock() utilized devm_add_action_or_reset() to call
> mt8188_afe_deinit_clock(). However, the order was incorrect, causing a
> use-after-free issue during remove time.
> 
> At probe time, the order of calls was:
> 1. mt8188_audsys_clk_register
> 2. afe_priv->clk = devm_kcalloc
> 3. afe_priv->clk[i] = devm_clk_get
> 
> At remove time, the order of calls was:
> 1. mt8188_audsys_clk_unregister
> 3. free afe_priv->clk[i]
> 2. free afe_priv->clk
> 
> To resolve the problem, it's necessary to move devm_add_action_or_reset()
> to the appropriate position so that the remove order can be 3->2->1.
> 
> Fixes: f6b026479b13 ("ASoC: mediatek: mt8188: support audio clock control")
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


