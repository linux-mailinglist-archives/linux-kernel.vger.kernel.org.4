Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA36E5165
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDQUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:08:03 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C197;
        Mon, 17 Apr 2023 13:08:01 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F0E8685EA1;
        Mon, 17 Apr 2023 22:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1681762079;
        bh=XPP/G+qQIG5sSIyEjLZmdN2TPpVm52+eBjT1AvxiWxQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ugfZ3KIJ+KaeTax2ZVm6VcUGnx/XmsCQNR9m1m11D15ktTdAorJBuZyU05wGA9oMx
         RlldaNA58RLUIXAEwcdDnatL7YFxkUJAwMKGGhUSuLY4alntaoIxQmV1tRs8dJK0nL
         YMGf275S3W/KJ3CDm0SZf0l4/GSa4SRWm+r93ccZi3Tq4+kpmAirWDjNNp3ificymF
         CRwcsgDWCKs+p1pSLfEBScSma2AOXQhferBU5spwvB+DfCKIc46LUMImYJ+aUxRNmx
         748L+r0eXYExBJphenJMetA02XGNHZxefwlbGOdaT3s4miBhdDZDyNiK7SS8opvt4m
         K4o51Ca4P4wog==
Message-ID: <88e53197-2819-c068-eba6-a218a19d8d15@denx.de>
Date:   Mon, 17 Apr 2023 22:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] drm: bridge: samsung-dsim: Support non-burst mode
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
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
References: <20230415104104.5537-1-aford173@gmail.com>
 <20230415104104.5537-5-aford173@gmail.com>
 <807aa6c6-bbea-abcc-172d-17e22d1a3988@denx.de>
 <CAHCN7x+NUnMtLbj_7A_uqxPsi5NXRXsPFwDnn=sf1bgm-Q-BsQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7x+NUnMtLbj_7A_uqxPsi5NXRXsPFwDnn=sf1bgm-Q-BsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 13:57, Adam Ford wrote:
> On Sun, Apr 16, 2023 at 5:13 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/15/23 12:41, Adam Ford wrote:
>>> The high-speed clock is hard-coded to the burst-clock
>>> frequency specified in the device tree.  However, when
>>> using devices like certain bridge chips without burst mode
>>> and varying resolutions and refresh rates, it may be
>>> necessary to set the high-speed clock dynamically based
>>> on the desired pixel clock for the connected device.
>>
>> The link rate negotiation should happen internally between the nearest
>> bridge and DSIM, so please add that to DRM core instead of hacking
>> around it by tweaking the HS clock again.
> 
> I thought you tried to add something like this before and had some resistance.

Yes, all my attempts were rejected by a single reviewer. I suspended my 
efforts in that area for now.

> The Pixel clock is set by the bridge already without any new code
> added to the DRM core..  I am just reading that value that's there,
> and setting the clock accordingly.  I don't see how this is a hack.

Assume you have a DSI-to-HDMI bridge attached to your DSIM bridge, it 
operates in non-burst mode, like ADV7533 . How would you configure the 
HS clock rate for such a bridge in DT ? (hint: you cannot, because the 
required clock comes from the EDID, which may not be available just yet)
