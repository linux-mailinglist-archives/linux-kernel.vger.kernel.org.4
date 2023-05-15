Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C22702B92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbjEOLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbjEOLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:33:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D5189;
        Mon, 15 May 2023 04:33:50 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A37466031D7;
        Mon, 15 May 2023 12:33:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684150429;
        bh=0Op7/1O++9f9jKqNzHu0BHLGnt+h03kOJbIaWi9PeKs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HrS1R2p9PM3I1yxbCWG+C30ZX/cEa5ugTBKNO3T5Emy1qniUwHhESsZhVy/LMKmMg
         bKTtwNBibki/OauZ1RHDUi95FkFk2vKFuA5ht4V86ArWKFDyIoJr9zrvy/ifPx3Oo9
         EDK2Yc+Wn8uRtv4Z+jzZTj+d/ht6NbponChojL5q4EftCnakM4bSPDBJK1b5okD5N7
         CxLZtEKJCCeBaCTwa4kCuT/1Rwf27NikcsLNTn2J+ebnNHzOxm7SGfZeJrmQJmAsHg
         jpccAqjglu9DCIWz0CBaqAcr5FmgjViOcOeR7F9PfZ0NK7m+A3SYwCOPWNd010UR1S
         JeHS7lr9bPWHg==
Message-ID: <8a3249a5-787b-5c7d-cf7c-69b732eb100e@collabora.com>
Date:   Mon, 15 May 2023 13:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mediatek/clk-mt8173-apmixedsys: use devm_of_iomap to
 avoid resource leak in clk_mt8173_apmixed_probe
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Hao Ge <gehao@kylinos.cn>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        gehao618@163.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230509021214.17105-1-gehao@kylinos.cn>
 <CAGXv+5Gvw0QsOa-7E==61WUiJ-q=9qAqN9E0L9hsmk+t12RJ9A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gvw0QsOa-7E==61WUiJ-q=9qAqN9E0L9hsmk+t12RJ9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/05/23 02:39, Chen-Yu Tsai ha scritto:
> On Tue, May 9, 2023 at 11:12 AM Hao Ge <gehao@kylinos.cn> wrote:
>>
>> Use devm_platform_ioremap_resource to take the place of of_iomap for
>> avoid that we don't called iounmap when return some error or remove
>> device.
>>
>> Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
>> index 8c2aa8b0f39e..8a2a88c63d15 100644
>> --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
>> +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
>> @@ -146,8 +146,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
>>          struct clk_hw *hw;
>>          int r;
>>
>> -       base = of_iomap(node, 0);
>> -       if (!base)
>> +       base = devm_of_iomap(&pdev->dev, node, 0, NULL);
>> +       if (IS_ERR(base))
> 
>  From lib/devres.c:
> 
>   * Please Note: This is not a one-to-one replacement for of_iomap() because the
>   * of_iomap() function does not track whether the region is already mapped.  If
>   * two drivers try to map the same memory, the of_iomap() function will succeed
>   * but the devm_of_iomap() function will return -EBUSY.
> 
> The register range for apmixedsys given in mt8173.dtsi overlaps with
> the HDMI phy. I'm concerned that would cause issues.

I agree, that will cause issues.

Regards,
Angelo

