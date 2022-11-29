Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7863BF47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiK2LqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiK2LqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:46:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03194A07B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:46:04 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EF437F8;
        Tue, 29 Nov 2022 12:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669722362;
        bh=Ovz0LB8la76yzk7QtN0fJ3MeKeUVniHAK4oNq/JmhdU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cLGhsYUKh9UxJ+SJCJ77f75GAT+BO/2VeNTJDLA6jN0v0YKY0s6duz4qL0jE4gETV
         legWS57dkl03uxvEbeD/Ctk3fty413sM5R65EsIBYcpaLrbWxM6+7zffRmfvHHs87O
         vSovZANSTSvoqL5M2HILleRXIVk472OCzyI5f4eA=
Message-ID: <34c2e9c8-9e3d-129c-8295-18ff440f1f84@ideasonboard.com>
Date:   Tue, 29 Nov 2022 13:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix output polarity setting bug
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Qiqi Zhang <eddy.zhang@rock-chips.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221125104558.84616-1-eddy.zhang@rock-chips.com>
 <CAD=FV=XAU8qQ1tFV9_4FF9Rd7ouT5ORzt6JUnQ4KqJgRsEXqHw@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <CAD=FV=XAU8qQ1tFV9_4FF9Rd7ouT5ORzt6JUnQ4KqJgRsEXqHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 03:13, Doug Anderson wrote:
> Hi,
> 
> On Fri, Nov 25, 2022 at 2:54 AM Qiqi Zhang <eddy.zhang@rock-chips.com> wrote:
>>
>> According to the description in ti-sn65dsi86's datasheet:
>>
>> CHA_HSYNC_POLARITY:
>> 0 = Active High Pulse. Synchronization signal is high for the sync
>> pulse width. (default)
>> 1 = Active Low Pulse. Synchronization signal is low for the sync
>> pulse width.
>>
>> CHA_VSYNC_POLARITY:
>> 0 = Active High Pulse. Synchronization signal is high for the sync
>> pulse width. (Default)
>> 1 = Active Low Pulse. Synchronization signal is low for the sync
>> pulse width.
>>
>> We should only set these bits when the polarity is negative.
>> Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
>> ---
>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> index 3c3561942eb6..eb24322df721 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> @@ -931,9 +931,9 @@ static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata)
>>                  &pdata->bridge.encoder->crtc->state->adjusted_mode;
>>          u8 hsync_polarity = 0, vsync_polarity = 0;
>>
>> -       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>> +       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>>                  hsync_polarity = CHA_HSYNC_POLARITY;
>> -       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>> +       if (mode->flags & DRM_MODE_FLAG_NVSYNC)
>>                  vsync_polarity = CHA_VSYNC_POLARITY;
> 
> Looks right to me.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I've never seen the polarity matter for any eDP panels I've worked
> with, which presumably explains why this was wrong for so long. As far

Afaik, DP doesn't have sync polarity as such (neither does DSI), and the 
sync polarity is just "metadata". So if you're in full-DP domain, I 
don't see why it would matter. I guess it becomes relevant when you 
convert from DP to some other bus format.

> as I can tell, it's been wrong since the start. Probably you should
> have:
> 
> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
> 
> I put this on a sc7180-trogdor-lazor device and it didn't make
> anything worse. Since the sync polarity never mattered to begin with,
> I guess this isn't a surprise. ...so I guess that's a weak tested-by:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>
> 
> I'm happy to land this patch, but sounds like we're hoping to get
> extra testing so I'll hold off for now.

Looks fine to me and works for me with my DP monitor.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

