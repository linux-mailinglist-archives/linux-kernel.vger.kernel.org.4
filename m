Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5F6E5C03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDRIbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDRIbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:31:06 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE2E63;
        Tue, 18 Apr 2023 01:31:04 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4D9B085AEC;
        Tue, 18 Apr 2023 10:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1681806662;
        bh=NER7E2tIy4C9f7YN78pLwyujIq9Yo6zWQEwmdMaeBDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I6eVjHo4vpZiCrxLUgi7n+p+dKPGuhcgJWLCstM5xs3PigsNjAhpryGV6rOLeEt4n
         VVLOe8qBaeKICa1SFxitaY7sk2YMlNtuy7CaqPxU91n7mbiORqgEeKZK4Fn+106ij6
         v8d7iNSLu4Dqfxmn9BWc3BwN2aapyUYG1lJPqiARIVprDH/B4slbnUJzEmIBH7RD9h
         kPbmqAxWJYKnHukinQE8LyBhiYyM1X79Fk4/XVWVXdkI3lhQDMY8FV2Dn+DMfVmqXQ
         Lvno3k5PRx1NMcu9mkR8fCxMXeggCVc4lGIgF8wtmA91wBzvZ1CD7j9cykWIbTF6Zn
         KwRSsgDb0TxoQ==
Message-ID: <56085a0f-02f7-6f45-f351-1f9ee612b748@denx.de>
Date:   Tue, 18 Apr 2023 10:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency
 automatically
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230415104104.5537-1-aford173@gmail.com>
 <20230415104104.5537-3-aford173@gmail.com>
 <7eed74e8-9f67-a410-3cec-f61a6db85238@denx.de>
 <CAHCN7xKw26TQ=t75TEDbEkA0mb9rnEwNW=7ei1=WFBZjiJMf=g@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xKw26TQ=t75TEDbEkA0mb9rnEwNW=7ei1=WFBZjiJMf=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 04:29, Adam Ford wrote:
> On Sun, Apr 16, 2023 at 5:08 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/15/23 12:41, Adam Ford wrote:
>>> Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
>>> having an entry in the device tree for samsung,pll-clock-frequency.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>>    drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
>>> index 9fec32b44e05..73f0c3fbbdf5 100644
>>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
>>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
>>> @@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
>>>        struct device_node *node = dev->of_node;
>>>        int ret;
>>>
>>> -     ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
>>> -                                    &dsi->pll_clk_rate);
>>> -     if (ret < 0)
>>> -             return ret;
>>> -
>>>        ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
>>>                                       &dsi->burst_clk_rate);
>>>        if (ret < 0)
>>
>> Does this break compatibility with old samsung DTs ?
> 
> My goal here was to declutter the device tree stuff and fetch data
> automatically if possible. What if I changed this to make them
> optional?  If they exist, we can use them, if they don't exist, we
> could read the clock rate.  Would that be acceptable?

If you do not see any potential problem with ignoring the DT property 
altogether, that would be better of course, but I think you cannot do 
that with old DTs, so you should retain backward compatibility fallback, 
yes. What do you think ?
