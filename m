Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0141569AABC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBQLsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBQLsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:48:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC06358D;
        Fri, 17 Feb 2023 03:48:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A28AE660212C;
        Fri, 17 Feb 2023 11:48:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676634530;
        bh=dBP7v0YZbwQzQkPvAVj2reXSNCbTqEMoGcDeR59liII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kV+m3R5A86A0nLueIh8jrwxNat+57w+Bclvok1gsFlnbZZIbwVYtYv9A5iXV5cK/a
         FulzoWP3UsJL0rnAE7wYI2rkeoLiLaGvW+IyGivck49aO8vwRgE/czSRZfs4itDKyK
         O0eq07qzGbUkXu4p27uBup8m2v1FdYlEd3hlMkS2PRdMz9rXZL2fUYVRldwA/sI70I
         83ksR6SodFXfzu+HCXHgrSKn40F8G7uVtGLThl7Nng21pWWaJmp3fR65z6Op8ZwNTA
         44b0hc/9rB43Sn1CfDiWVw4UxVESgnOEqiiQOTR2Tfy1ofBRRcnNCbmrKJ7vFT5BIH
         bV48ZTjDkCiQA==
Message-ID: <f0f12c20-6132-6e7d-c74d-670d3c8e5ce5@collabora.com>
Date:   Fri, 17 Feb 2023 12:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 00/47] MediaTek clocks: full module build and cleanups
Content-Language: en-US
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
 <CAGXv+5HrP2TCacuOBcF3OG-22pAuukhtTHUoA+D2zY6wNfoYAA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HrP2TCacuOBcF3OG-22pAuukhtTHUoA+D2zY6wNfoYAA@mail.gmail.com>
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

Il 17/02/23 09:05, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Changes in v2:
>>   - Fixed issues on MT8183 (thanks Chen-Yu!)
>>   - Changed builtin_platform_driver() -> module_platform_driver() for
>>     MT8167 vdecsys clocks (as that was a mistake!)
>>   - Some patches were split, some others were reordered
>>   - Summarized: applied changes from Chen-Yu's review
>>
>> This is part 2 of the "MediaTek clocks cleanups and improvements" series,
>> which was already picked.
>>
>> If reading this full cover letter is too boring for you, here's a short
>> summary of the changes of this series:
>>   - Added mtk_clk_pdev_probe() for mtk-mmsys probed clocks;
>>   - Added divider clock support to common probe mechanism;
>>   - Various cleanups here and there;
>>   - Converted most clock drivers to platform_driver;
>>   - MediaTek clocks can now be built as modules.
>>
>> NOTE: Applies on top of [1] and [2].
> 
> I think I covered all the patches. Was there any particular reason for
> skipping clk-mt8135.c for the conversions?
> 

No, for whatever reason, I missed it I don't know why and how, but I didn't
intend to actually miss it.

I'll add some commits converting that one too.

Thanks,
Angelo

> Thanks
> ChenYu


