Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C15BCD52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiISNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiISNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:32:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E1B21835
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:32:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B8264660159F;
        Mon, 19 Sep 2022 14:32:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663594375;
        bh=TBhtk3gr4d0sylPaOG83cBfrnCWZRMcFZEocaCMqSfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OaJ8GPRjLhVosM1A/PUElwHNEgeWvltDbM6oZu8+WuZmcnch01XPp21pn/ewA7V70
         P45LJ1m110d2xmCzDAh517/7Pta90saLbYE0c+urvKeMONCZvH8BgM3pJbJARQ7SVM
         FZBFIfgtevaC0qCGU4ahm5D7/R+0SAMv28D8MJ6NCD8U1s/pB0dZZpLOPhDw7WqDNX
         QoN8TyOsZsIxjD662CnOZcP5ezoNbJJFsgyVApfT7v8TfJ66vITMJg8/p7RHdLLRZ6
         rtI/adJF5CH4FxV/TH9+q6CZHYb9R8AZ6E6Jb5o7qNNklC5cyXo58Xp1tPX+RJVhgl
         9E4Ee//hum6kA==
Message-ID: <227bce07-37cc-da1d-fc99-065a12cdf3f5@collabora.com>
Date:   Mon, 19 Sep 2022 15:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/mediatek: dsi: Move mtk_dsi_stop() call back to
 mtk_dsi_poweroff()
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220804194325.1596554-1-nfraprado@collabora.com>
 <CAJMQK-hOxxvkjgOxA6KLLUJxxBehHDQvRo-Y_FLMPLEfkoVMzA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJMQK-hOxxvkjgOxA6KLLUJxxBehHDQvRo-Y_FLMPLEfkoVMzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 10:40, Hsin-Yi Wang ha scritto:
> On Mon, Sep 19, 2022 at 4:39 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> As the comment right before the mtk_dsi_stop() call advises,
>> mtk_dsi_stop() should only be called after
>> mtk_drm_crtc_atomic_disable(). That's because that function calls
>> drm_crtc_wait_one_vblank(), which requires the vblank irq to be enabled.
>>
>> Previously mtk_dsi_stop(), being in mtk_dsi_poweroff() and guarded by a
>> refcount, would only be called at the end of
>> mtk_drm_crtc_atomic_disable(), through the call to mtk_crtc_ddp_hw_fini().
>> Commit cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from
>> enable/disable and define new funcs") moved the mtk_dsi_stop() call to
>> mtk_output_dsi_disable(), causing it to be called before
>> mtk_drm_crtc_atomic_disable(), and consequently generating vblank
>> timeout warnings during suspend.
>>
>> Move the mtk_dsi_stop() call back to mtk_dsi_poweroff() so that we have
>> a working vblank irq during mtk_drm_crtc_atomic_disable() and stop
>> getting vblank timeout warnings.
>>
>> Fixes: cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from enable/disable and define new funcs")
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

