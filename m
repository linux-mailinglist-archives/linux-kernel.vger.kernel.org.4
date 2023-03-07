Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1905A6ADA47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCGJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCGJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:25:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96613144B5;
        Tue,  7 Mar 2023 01:24:59 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E3036602FE5;
        Tue,  7 Mar 2023 09:24:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678181097;
        bh=q3luoZTgpNdhEHW9jdKgy83al0aOJTjkSQZabZ2eSNI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W8ZSG78OC0e/uulkRGd5Gm6py5CcblJbNWn1TQOWZv/EZ0g0shxFXfxDTp0262JYR
         liRNvSmuJOPli90jo2/hE6h6gkO0GePEbxa5OOIRAS7ADdfRlCptRhPAsR0ZtMTFOZ
         y+QLPOFue9xJHHJQrG0J4bLfTMhJmxChge6xibg9M3APxTzLNeEJPjBDxPtPXNj1tI
         A0mgGGcOhmhCLgAqxjxMPgtLaJ0gUge6mPI5Z4q0A9jGMBaywuerKA3cBPnySWXzx8
         j/AtZCGNrZGSHqJrmoHpC/IiG0jtBidJsLHkNy0zVuKmJNOdb/LRks7cFxQqIUBP2z
         +JnIUIZpky/Aw==
Message-ID: <5ca9ad61-0a79-5700-8c6a-e9afa94a59c5@collabora.com>
Date:   Tue, 7 Mar 2023 10:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 47/54] clk: mediatek: mt8192: Move apmixedsys clock
 driver to its own file
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
 <20230306140543.1813621-48-angelogioacchino.delregno@collabora.com>
 <ZAZjYTv4TLKSunFZ@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZAZjYTv4TLKSunFZ@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/03/23 23:04, Daniel Golle ha scritto:
> On Mon, Mar 06, 2023 at 03:05:36PM +0100, AngeloGioacchino Del Regno wrote:
>> This is the last man standing in clk-mt8192.c that won't allow us to
>> use the module_platform_driver() macro, and for *no* good reason.
>> Move it to clk-mt8192-apmixedsys.c and while at it, also add a
>> .remove() callback for it.
>>
>> Also, since the need for "clk-mt8192-simple" and "clk-mt8192" was
>> just due to them being in the same file and probing different clocks,
>> and since now there's just one platform_driver struct per file, it
>> seemed natural to rename the `-simple` variant to just "clk-mt8192".
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Tested-by: Miles Chen <miles.chen@mediatek.com>
>> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>> ---
>>   drivers/clk/mediatek/Makefile                |   2 +-
>>   drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 214 ++++++++++++++++++
>>   drivers/clk/mediatek/clk-mt8192.c            | 221 +------------------
>>   3 files changed, 219 insertions(+), 218 deletions(-)
>>   create mode 100644 drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> 
> I've tried to apply this on clk-next (currently v6.3-rc1) and also
> linux-next (next-20230306), on both this patch doesn't apply:
> 
> Applying: clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
> error: patch failed: drivers/clk/mediatek/clk-mt8192.c:12
> error: drivers/clk/mediatek/clk-mt8192.c: patch does not apply
> Patch failed at 0047 clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 

You've missed the dependency that I've listed in the cover letter.

https://patchwork.kernel.org/project/linux-mediatek/list/?series=719067

Regards,
Angelo

