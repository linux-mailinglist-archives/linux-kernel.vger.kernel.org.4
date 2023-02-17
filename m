Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779769AA30
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjBQLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBQLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:19:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EC521945;
        Fri, 17 Feb 2023 03:19:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 780AC660212C;
        Fri, 17 Feb 2023 11:18:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632738;
        bh=SK5YF4VJ5EozXIVUN6qmnCrFlh18Ax8TQqauGjRXIGQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WMyE8gviyZndoO2l8tpuskyHMQ2zeb8xNOuaCrpD4DDz+XXhwouR/u4ihRVForz3G
         1eVJZPom2MjwqK51ftNdhkAccq9aKziiF/9sEQODFrRA/cGww2o3zyQ8mViV4UaCpN
         mhmFpGWEKiE7y/LDTSW3ImDAxziUzqo5ry3ztMpHbsy1+2y0THrbG7LgMbxhXOsnGz
         7+kfGsrrIOOwqmHVT3KdVgLOabyLTpqlf/4Cadmm+lPtX8Cs9clMyFeJaRLPNjaVPx
         zl0leqSafApgLfbUvCmh4TLJlQFHa414xFXgarx5fw4j5p8zy7BF3Ar7m9ugoPlxVH
         Zays9ND768Pfw==
Message-ID: <6ed4ca9f-bb75-2698-6c8a-2008b1320570@collabora.com>
Date:   Fri, 17 Feb 2023 12:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 34/47] clk: mediatek: Switch to
 module_platform_driver() where possible
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
 <20230214134127.59273-35-angelogioacchino.delregno@collabora.com>
 <CAGXv+5E3KCRyaRpkYab0XmT8XDZQO21RYBpKVgCcGtWmZ+dv3g@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E3KCRyaRpkYab0XmT8XDZQO21RYBpKVgCcGtWmZ+dv3g@mail.gmail.com>
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

Il 17/02/23 05:19, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Lots of clock drivers have got both .probe() and a .remove() callbacks:
>> switch from builtin_platform_driver() to module_platform_driver() so
>> that we actually register the .remove() callback.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt2701-aud.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-bdp.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-eth.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-g3d.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-hif.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-img.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-mm.c           | 3 +--
>>   drivers/clk/mediatek/clk-mt2701-vdec.c         | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-bdp.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-img.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-jpgdec.c       | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-mfg.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-mm.c           | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-vdec.c         | 3 +--
>>   drivers/clk/mediatek/clk-mt2712-venc.c         | 3 +--
>>   drivers/clk/mediatek/clk-mt6765-audio.c        | 3 +--
>>   drivers/clk/mediatek/clk-mt6765-cam.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt6765-img.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt6765-mipi0a.c       | 3 +--
>>   drivers/clk/mediatek/clk-mt6765-mm.c           | 3 +--
>>   drivers/clk/mediatek/clk-mt6765-vcodec.c       | 3 +--
>>   drivers/clk/mediatek/clk-mt6797-img.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt6797-mm.c           | 3 +--
>>   drivers/clk/mediatek/clk-mt6797-vdec.c         | 3 +--
>>   drivers/clk/mediatek/clk-mt6797-venc.c         | 3 +--
>>   drivers/clk/mediatek/clk-mt7622-aud.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt7622-eth.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt7622-hif.c          | 3 +--
>>   drivers/clk/mediatek/clk-mt7629-eth.c          | 1 -
> 
> This one looks fishy. It wasn't converted to the simple probe library.
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>


Oh wow. Thanks for making me notice. Yeah you're right, mt7629-eth was not
converted to simple probe.... and I need to split sgmiisys and sgmiisys1.
This means that I need to change bindings and devicetree to add a new
compatible "mediatek,mt7629-sgmiisys1".

I won't do that in this series as I don't want to spam this huge amount of
patches to the devicetree list... but I'll do that as a separated series
that depends on this one.

So, for this one, I will simply drop the mt7629-eth change (as it's useless).

Thanks again!
Angelo
