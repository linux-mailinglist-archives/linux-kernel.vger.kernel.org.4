Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8D68D5FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBGLvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBGLvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:51:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886A93EA;
        Tue,  7 Feb 2023 03:51:50 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66DF86602065;
        Tue,  7 Feb 2023 11:51:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675770708;
        bh=MWr1vOqArgCsUOmneGrQYdT5d7VoYOD70EsSHjzp9K8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TsgF/WNw7qo5dn46OkfZHT1D/q98kQkrCN5//xeC/347i9WPKGpRsO66puk+834UZ
         IOb2B2a5Na7D8UZdCBJ4GNW8w0qxRGwtef0wygCM5NPNBF6daxUT3jr9YjXOkZo7Xd
         ricB4Aym84ZyzlOjQCSRZKG8CD1OlSa9mGV/XY5ZsYlDVwa4s1KkYqTQ+Pbc4oGABo
         wEnptoVnb2DAfQEVhY1lC5Pwrr6GIp2rZ4vadHkZB0dR38wk4EBhPPR4aBAk145Ulb
         agCj9zoeViupOp+lyYRfARikgOjDBKQpJm7CTl1pqp9e4Qei6G83bMUJeWygYjhli/
         LxU8P4ykTe3kQ==
Message-ID: <0713672c-37fe-663b-11a4-0baf02c11e6b@collabora.com>
Date:   Tue, 7 Feb 2023 12:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 16/45] clk: mediatek: mt8167: Convert to
 mtk_clk_simple_{probe,remove}()
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
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-17-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Gb5S0k1c5EqPKoiBBHFyf7QBqyeWZkdAjQDCcTLYU_bw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gb5S0k1c5EqPKoiBBHFyf7QBqyeWZkdAjQDCcTLYU_bw@mail.gmail.com>
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

Il 07/02/23 09:07, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Convert topckgen and infracfg clock drivers to use the common
>> mtk_clk_simple_probe() mechanism and change this from the old
>> "static" CLK_OF_DECLARE to be a platform driver, allowing it
>> to eventually be built as a module.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Code looks OK, but vdecsys converted to builtin_platform_driver() while
> the others to module_platform_driver(). This deserves an explanation.
> 

There's nothing to be explained, other than this being a big overlook... :-P

Fixed that for v2, vdec deserves the module_platform_driver() treatment too!

Cheers,
Angelo


