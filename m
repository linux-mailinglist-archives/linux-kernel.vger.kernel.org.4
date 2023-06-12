Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051A772BF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjFLKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjFLKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:41:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163C5319E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:25:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45BF16605907;
        Mon, 12 Jun 2023 11:00:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686564026;
        bh=r44Dg4EqyihdbL+KAokT86pfSJw+jh/v00yaiQZ3zZg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HJhMEH3H2HAFodc6o70V0xn35JJx7uqF3h2a+lWyuS7CagZrK9rwyB7WdIkbRzmq1
         j3U737I8bsAcSX2vV5QUnHW2XwgN4ksx2zq7vuYY/PA0dVJ4LmUEVh3i1EfowdS+xT
         VbcBI8v5BimBsr9OeBJYKOpHAjUDjOIpz3b76CTGgwECZDoBKG7iPVBWaK4YHOyA/7
         R0vj6fzNepw0u2IGSQ+MzcwE1oq+ELBG7GhoV2W0tWkCLlAtvnUlGRhnW7C6/tII9W
         GJPG4t9Kn/2e2TODGpTj8YntlVXMKb+IbwaZp5PCx7e5P9qwuDSL7f1nUwx1YJANvL
         IFgFXczlxrlKA==
Message-ID: <de0e99d6-dcd0-79f5-f3a4-14e25265c0a7@collabora.com>
Date:   Mon, 12 Jun 2023 12:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt8173: Fix
 snd_soc_component_initialize error path
Content-Language: en-US
To:     Ricardo Ribalda Delgado <ribalda@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org
References: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
 <20230612-mt8173-fixup-v2-1-432aa99ce24d@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230612-mt8173-fixup-v2-1-432aa99ce24d@chromium.org>
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

Il 12/06/23 11:05, Ricardo Ribalda Delgado ha scritto:
> If the second component fails to initialize, cleanup the first on.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: stable@kernel.org
> Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to component")
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


