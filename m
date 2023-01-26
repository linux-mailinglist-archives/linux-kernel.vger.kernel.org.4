Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3D67D03B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjAZPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjAZPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:31:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80D11728;
        Thu, 26 Jan 2023 07:31:06 -0800 (PST)
Received: from ryzen9 (unknown [79.119.122.0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aratiu)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B411466018E4;
        Thu, 26 Jan 2023 15:31:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674747065;
        bh=6l03pcXoUO/jHX88INu7oBIANmYByZgCGrrOf8ec8TE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j1Fj+iWfuNKhwLJchHJXaeWh5IVuL0FfKzwaMsYbmbYtd2l9Zn0UIqMeLoaU4n/F+
         4jtru2ouZzgUiUTx014f31+8o5cdEC8m8aA7LiazFvig/51vh1Bx1bVCFzukswKpkQ
         RnRLTTLMkpOjKcbyHy3zo3ycpvcrYdLURClRKDU87PkDeHhKguJ649mrBV2RxDOPzf
         miPHXgy267Eh0Cn7gEaDG2vcR2I378DEII1DpBPz5egq4sW9jpqpqRL5LjGoby+4pQ
         xerjzHOWrllJey+1NsxWMLQyI/gDhDIGkePJPiCZlvX7Tai3aG6JE9yhQideV5oiDv
         u4CrCuG0kvVIg==
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, thierry.reding@gmail.com
Subject: Re: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
In-Reply-To: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
Date:   Thu, 26 Jan 2023 17:31:02 +0200
Message-ID: <87h6wdxqh5.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Since the pwm-mtk-disp driver was fixed to get PWM_EN state from 
> the right register, an old two-wrongs-make-one-right issue 
> emerged: as a result, MT8192 Asurada Spherion got no backlight 
> at boot unless a suspend/resume cycle was performed.  Also, the 
> backlight would sometimes not get updated with the requested 
> value, requiring the user to change it back and forth until it 
> worked. 
> 
> This series fixes both of the aforementioned issues found on 
> MT8192. 

Thanks for the series. This also improves backlight on MT8183.

I've been testing using the panfrost driver on a ChromiumOS 
userspace on a jacuzzi board and I've had issues like the screen 
going blank then not coming back, which these patches appear to 
solve. Many thanks!

Tested-by: Adrian Ratiu <adrian.ratiu@collabora.com>

>
> AngeloGioacchino Del Regno (2):
>   pwm: mtk-disp: Disable shadow registers before setting backlight
>     values
>   pwm: mtk-disp: Configure double buffering before reading in
>     .get_state()
>
>  drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> -- 
> 2.39.0
