Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D7727416
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjFHBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFHBSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:18:24 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7386626A2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:18:23 -0700 (PDT)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id DF0B418010F081;
        Thu,  8 Jun 2023 09:18:12 +0800 (CST)
Message-ID: <69929cae-5e94-65b6-7ea3-3986c89d6f61@nfschina.com>
Date:   Thu, 8 Jun 2023 09:18:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Avoid possible buffer
 overflow
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andersson@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-Bcc: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <CAD=FV=UxzUoAPbKtX3Xvq=g8DNcatQ8-s-8rcGEeE+G40a9RhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/7 22:03, Doug Anderson wrote:
> Hi,
>
> On Tue, Jun 6, 2023 at 6:25 PM Su Hui <suhui@nfschina.com> wrote:
>> Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <= 5.
>>
>> Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> index 7a748785c545..bb88406495e9 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> @@ -305,7 +305,7 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
>>           * The PWM refclk is based on the value written to SN_DPPLL_SRC_REG,
>>           * regardless of its actual sourcing.
>>           */
>> -       pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
>> +       pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i < refclk_lut_size ? i : 1];
> This looks more correct, but it really needs a comment since it's
> totally not obviously what you're doing here. IMO the best solution
> here is to update "i" right after the for loop and have a comment
> about the datasheet saying that "1" is the default rate so we'll fall
> back to that if we couldn't find a match. Moving it to right after the
> for loop will change the value written into the registers, but that's
> fine and makes it clearer what's happening.
Got it. Add some comment and move the code up.
I will send patch v3 soon.
Thanks for your suggestion again :) .

Su Hui

>
> -Doug
