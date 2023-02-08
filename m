Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8346368EA47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBHJAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBHJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:00:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED693609C;
        Wed,  8 Feb 2023 01:00:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79BC5660208E;
        Wed,  8 Feb 2023 09:00:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675846801;
        bh=11ktIaV2fDGiz0UeBz/ISfzVWABGbiyyfbya63PwGMs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T9RV5qmD60LiRDwyUp39R43ZgRCBtA6FigFe30IE9fUCoDKiE1RRPyeOlOJRAjOCR
         0xXLDap3/7wiCWeks9aHIsRWxfCTmSUG95o/RC6bvlHUAZQu4LXULvsQXdgY330NoR
         /4sMdFT3+vfrtGAPYTpCzM5FGtzz0nUhegRqPC79DirjtyJfsPp1Qf/pC5WJvrai54
         O/4vWOarHvZ/fCosB1Ej9uBoam2d8OSEPk4R+CHOkdEbqQ1P+EHw1dJlp7flivDUny
         M19DaQL6g/+gdGiZnIRpyDakEE7YtCwgz5FJJiO3NHNt33Nqi/nC/gBu0i3qgfKTDm
         Ff95/Pqy2FIsA==
Message-ID: <45f8e284-8d56-898b-0897-94c576e09c2c@collabora.com>
Date:   Wed, 8 Feb 2023 09:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 35/45] clk: mediatek: Split MT8195 clock drivers and
 allow module build
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
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-36-angelogioacchino.delregno@collabora.com>
 <CAGXv+5HTP0cLGEQ+qkAt8nsOp5DqCOgPyAOJ66fF91SKX=hZvw@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HTP0cLGEQ+qkAt8nsOp5DqCOgPyAOJ66fF91SKX=hZvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/02/23 09:28, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
>> option: there's no reason to do that, as it is totally unnecessary to
>> build in all or none of them.
>>
>> Split them out: keep boot-critical clocks as bool and allow choosing
>> non critical clocks as tristate.
> 
> The power domain controller references vppsys*, vdecsys*, vdosys*, wpesys,
> imgsys and camsys. I'd argue that this makes these clock drivers
> semi-boot-critical. Maybe mfgcfg as well when we add the GPU?

You don't need to power on additional power domains if you want to load modules
from a ramdisk! :-)

Besides, you caught me: mtk-pm-domains will be my next target after clocks...
I don't like how it behaves in regard to probe deferrals. Specifically,
I dislike the fact that you either register *all domains* or *none at all*
(unless instantiating two different driver instances and that's ugly).


Angelo

> 
> They should be bundled together at the very least. The power domain
> controller not probing disables all display and multimedia capabilities.
> 
> Also wondering if we should have "default COMMON_CLK_MT8195" ...
> 
> I suppose the same questions apply to other SoCs.
> 
> ChenYu


