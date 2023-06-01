Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A7719847
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFAKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjFAKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:04:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6910F1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:02:47 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 25F406606EBC;
        Thu,  1 Jun 2023 11:02:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685613765;
        bh=huazch6Zt+IHAcq/GNSQQgxY8jrr5NELWOKD4q8xUaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ATNpvjzQe4zTjY8d+Fe0GtJpH9aKZB1O4xYWet9M9Aac9H/m1JsBYANT35Jj4/hJX
         xPXttlFd17NVY1zYfVfqGFK8tkPuRwPXODazZXmQcClMXv10XPaC9/oYk153Mr4WBf
         YquoYvs7smmxUFZCgF9VI//ro5f6tjFwMmsuqS11nIHEDwx2dfY3WGJopj+Jn8c6/c
         UOJtK3QqiLw57xYQgdI/RPYHfEaSv8MNJtamhWyJD2UanyWHwJ4+cYeITE4CwcQ6/T
         N4PhIjjuDa2sTYfSRg8LnDhTZsSalqwleac5w/vadk3wlQWIJe1M1dRGewqW5+weFZ
         NM3BfJeiJC06w==
Message-ID: <b7864c7d-172e-9903-278c-63df45f6a0ff@collabora.com>
Date:   Thu, 1 Jun 2023 12:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] ASoC: mediatek: mt8195: fix use-after-free in
 driver remove path
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     dianders@chromium.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230601033318.10408-1-trevor.wu@mediatek.com>
 <20230601033318.10408-3-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601033318.10408-3-trevor.wu@mediatek.com>
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
> During mt8195_afe_init_clock(), mt8195_audsys_clk_register() was called
> followed by several other devm functions. At mt8195_afe_deinit_clock()
> located at mt8195_afe_pcm_dev_remove(), mt8195_audsys_clk_unregister()
> was called.
> 
> However, there was an issue with the order in which these functions were
> called. Specifically, the remove callback of platform_driver was called
> before devres released the resource, resulting in a use-after-free issue
> during remove time.
> 
> At probe time, the order of calls was:
> 1. mt8195_audsys_clk_register
> 2. afe_priv->clk = devm_kcalloc
> 3. afe_priv->clk[i] = devm_clk_get
> 
> At remove time, the order of calls was:
> 1. mt8195_audsys_clk_unregister
> 3. free afe_priv->clk[i]
> 2. free afe_priv->clk
> 
> To resolve the problem, we can utilize devm_add_action_or_reset() in
> mt8195_audsys_clk_register() so that the remove order can be changed to
> 3->2->1.
> 
> Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


