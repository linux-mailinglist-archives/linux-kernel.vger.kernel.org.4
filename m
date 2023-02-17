Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA169A983
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBQK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQK6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:58:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280D3028D;
        Fri, 17 Feb 2023 02:58:49 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F875660212C;
        Fri, 17 Feb 2023 10:58:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676631528;
        bh=HiIY/CHOeQ0W4JiYTTFiDjPDA7EMN/1wcpbOI06k6UA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RFR+n/KsV6JSyO7HKc36N9BK0uTlofQ815g1IdTufZDYuzI66WwoSiXQUofFHyxe+
         GSiEWk7cqSsLUgShorxctstElID+WoEeEaMOslvyrWH5fZp9XCpfr8kHcUD98q6NjB
         28h3pFseB+baHNeQuOq/d4oejjTar+V5iIc115WDRlME472ZfmoUvTHkmFcrwzvTKW
         sEctq9YYH6TooVYw3Zifim5dydsGaN7K28gWqfGWUY3UF0B1GtaASHyjcHaK37j/Ug
         xcEgICvi/lBloYlIJC+HfssNSCqrfHlg6mCBhn5+AMWWV2URzkXDaEjwlJIm7qCWiH
         GWkq3QJ+sLbzA==
Message-ID: <fb81280c-3bcf-7447-3328-0863b2ffd136@collabora.com>
Date:   Fri, 17 Feb 2023 11:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 32/47] clk: mediatek: mt7986-eth: Migrate to common
 probe mechanism
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
 <20230214134127.59273-33-angelogioacchino.delregno@collabora.com>
 <CAGXv+5F5KxA_3jtbgXfat1xSL79_k+W7kzpiOZmGHyEM3fnSkQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5F5KxA_3jtbgXfat1xSL79_k+W7kzpiOZmGHyEM3fnSkQ@mail.gmail.com>
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

Il 17/02/23 05:12, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Convert this driver to use the common mtk_clk_simple_probe() mechanism.
>> While at it, also remove __initconst annotations (as these structures
>> are used also at runtime).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Git really doesn't produce good diffs on these large rewrites *sigh*.

I know... and I feel the pain...

Cheers,
Angelo
