Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0B969A981
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBQK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:57:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA918AB2;
        Fri, 17 Feb 2023 02:57:53 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DAE9660212C;
        Fri, 17 Feb 2023 10:57:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676631471;
        bh=oWG8qB73mWU6tgSPCfIdc7ieSokgqJaXwrk6pTlekvU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cSAyNr/NSxAq0AEJXIj85+gwSmFRHcHrD4KlyyyQhu5yFrYMiTYh+AaSgCdw4Y2Z1
         4oHiKZkMrVvStL0Y3dDeBduGDoBrSzL/IIKScQBMbX67wAQeChZZmP6fbylq+m0VxT
         GFMBFAHkKKZIiETJg6e12D2qvwi7NErWooZIY0Oo5ECKzLyPm3wBq9i3GYpl/omJni
         4s4oXWg1SMakWZi5sCIczrYlXJahcGFWMpz07tPIJ+ez+SUwU3lPgvAwKNr9YER13t
         54N0eWVFPBPjcVUBzAVDZfr2FQnwyZWsKn6ZSaoUg95kQPdEBV8h/vMjFg6uDMR6Bc
         u6pUbxi/i/eTw==
Message-ID: <8a19a7b3-f047-3fc5-5002-ce07c1dbdf4a@collabora.com>
Date:   Fri, 17 Feb 2023 11:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 29/47] clk: mediatek: Propagate struct device with
 mtk_clk_register_dividers()
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-30-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EEO2RMzwkknMEwYZmtO7PbDhOTj_=yRrU0UHeCdc==iw@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EEO2RMzwkknMEwYZmtO7PbDhOTj_=yRrU0UHeCdc==iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/23 05:09, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Propagate struct device for divider clocks registered through clk-mtk
>> helpers to be able to get runtime PM support for MTK clocks.
> 
> Sidenote: I think we still need to call pm_runtime_enable() (or some other
> function) on the underlying device before any clk_hw_register() calls are
> made for the clk core to pick up runtime PM support?
> 

The clk_core checks...

	if (dev && pm_runtime_enabled(dev))
		core->rpm_enabled = true;

...at __clk_register() time, and there's no way to enable it *later*, which
is something that may or may not be good for us.

We could call pm_runtime_enable() on the clock driver itself (so, in simple_probe)
but that's something I didn't want to do right now because this needs a rather big
amount of testing on multiple SoCs.

But yes I agree with you on that we still need to *flip the switch* to actually
enable rpm support. These commits are meant to make us able to do that in one line,
instead of one line per file :-P

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks! :-)
