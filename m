Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5172513C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbjFGAup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjFGAum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:50:42 -0400
Received: from smtp.tom.com (smtprz25.163.net [106.38.219.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC31189
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:50:40 -0700 (PDT)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id DC907B00CBF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:50:35 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID -1855971513
          for <linux-kernel@vger.kernel.org>;
          Wed, 07 Jun 2023 08:50:35 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id B38F5B00D42
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:50:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1686099035; bh=QsFM4uyy5VZQwk9mEzKAccKlevD3TSVUAfLJgnmLgyU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GeWkcCSocYpAIfjS1zXhLvob49Q3HRhMPXc6qXDllzN07hUYC4C5YMUtDBE6JLw6N
         NKfue4T4hfe6z4JIyPlS/DUaTraGT7nuj9vZB9alVIojirtSubISpwYZCzTETdhCVA
         xvrS1ETseqqcP5cHJAZPkcXzE+qaQ42uCpQ++mNE=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 4D21ED41AE1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:50:34 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id miztMT90RBjg for <linux-kernel@vger.kernel.org>;
        Wed,  7 Jun 2023 08:50:27 +0800 (CST)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by antispam1.tom.com (Postfix) with ESMTPA id 3D3ACD4170C;
        Wed,  7 Jun 2023 08:50:24 +0800 (CST)
Message-ID: <928cc71e-7b66-9cb0-7751-ce1f65489360@tom.com>
Date:   Wed, 7 Jun 2023 08:50:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        u.kleine-koenig@pengutronix.de
References: <20230606075527.155346-1-suhui@nfschina.com>
 <CAD=FV=X_n4Si3k4iQ0yRJZRqX2DuhGF2pjPqEzbiKqBY3ZCNHg@mail.gmail.com>
From:   Longsuhui <Jack_sun@tom.com>
In-Reply-To: <CAD=FV=X_n4Si3k4iQ0yRJZRqX2DuhGF2pjPqEzbiKqBY3ZCNHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/6 23:28, Doug Anderson wrote:
> Hi,
>
> On Tue, Jun 6, 2023 at 12:56 AM Su Hui <suhui@nfschina.com> wrote:
>> Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <= 5.
>>
>> Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> index 7a748785c545..952aae4221e7 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> @@ -305,7 +305,8 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
>>           * The PWM refclk is based on the value written to SN_DPPLL_SRC_REG,
>>           * regardless of its actual sourcing.
>>           */
>> -       pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
>> +       if (i < refclk_lut_size)
>> +               pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
> I don't think this is quite the right fix. I don't think we can just
> skip assigning "pdata->pwm_refclk_freq". In general I think we're in
> pretty bad shape if we ever fail to match a refclk from the table and
> I'm not quite sure how the bridge chip could work at all in this case.
> Probably that at least deserves a warning message in the logs. There's
> no place to return an error though, so I guess the warning is the best
> we can do and then we can do our best to do something reasonable.
>
> In this case, I think "reasonable" might be that if the for loop exits
> and "i == refclk_lut_size" that we should set "i" to 1. According to
> the datasheet [1] setting a value of 5 (which the existing code does)
> is the same as setting a value of 1 (the default) and if it's 1 then
> we'll be able to look this up in the table.
I think you are right. And " if ( i >= refclk_lut_size) i=1" is a 
suitable change.
I will send patch v2 a litter latter.
Thanks for your suggestion.

Su Hui

>
> [1] https://www.ti.com/lit/gpn/sn65dsi86
>
> -Doug
