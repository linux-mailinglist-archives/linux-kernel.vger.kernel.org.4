Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302C45FD72D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJMJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D2123458
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665653882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9snsm3rk9oLMX8YjTU2ibqvXXarlConNz6Jrmux1oCU=;
        b=O88Y7/SfATVMPy9jPxubP54g/qXgKQ56n7Dkt/6zjAQ2oIQcncRI8Se3RnbE9VKMS0pZ8b
        pjXqUo1bhxwHDwvK7OfDwOsBxkpOtYMYPQgJs/RwRrbYuSziILz1ZKonFAYizLs7QEHqkG
        LYVnKgcBKRL/rcfi5WOgOBRJ7BUxq48=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-W5ycxfQxMYGfmcp8d7NE8Q-1; Thu, 13 Oct 2022 05:38:00 -0400
X-MC-Unique: W5ycxfQxMYGfmcp8d7NE8Q-1
Received: by mail-wr1-f70.google.com with SMTP id g27-20020adfa49b000000b0022cd5476cc7so325006wrb.17
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9snsm3rk9oLMX8YjTU2ibqvXXarlConNz6Jrmux1oCU=;
        b=z7cCoLUN/9zOfqRZLQjvagi0Q8e+dYdpBUs8KwpZ8YCq4w/PCGH6pnhIf0cmmbJAQc
         OO+L+5LrSdwtbB4YqCcS4VXF69ABO0ZcNcQhXM22Fd3AwOl0nETehBNX1ZAVJ/53M4V4
         x7SNx7jBUQWDZudf4fqHaVD9XD8BT3e229uqJTX0iU7Y3l9D3r4+0Dr+v9oCI55PnByv
         I1jNBDCy7sQS/yzVFWuIlm5CWXsHnLWrvHMAa9VwXop2DB4JQ6JE4BsPzdXTyPWU3imo
         8ot/bFeLjp+eYUYtGFCbcypLTs9xrLKDduFFZ6LuKkQa6qtDOmy+qW/IrF/ddY2GPvXb
         6E7A==
X-Gm-Message-State: ACrzQf2qhl8stumGXcphkUrFp42oki4UJP7RHQ4XqpM9IAPaSw6QaMC1
        gjGxkbFQ8GwiInTJDYZQhPVZQqOvhk08njI6T91zysVliDnYm6xaSyxKA+yCZK6a4djASg4lFR/
        vyvOQ+4NBzN6oee+mCGMkG0Ki
X-Received: by 2002:a5d:4f10:0:b0:231:1c7b:e42 with SMTP id c16-20020a5d4f10000000b002311c7b0e42mr9831845wru.568.1665653879274;
        Thu, 13 Oct 2022 02:37:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7aKiCQzKwG4ALs3g7YVHciVvngW7vaZpaRtnbUpk0vmjjT0EU7jXg6H/lJIm7bxDjjILLbjQ==
X-Received: by 2002:a5d:4f10:0:b0:231:1c7b:e42 with SMTP id c16-20020a5d4f10000000b002311c7b0e42mr9831824wru.568.1665653879063;
        Thu, 13 Oct 2022 02:37:59 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b003c6c3fb3cf6sm3944476wms.18.2022.10.13.02.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 02:37:58 -0700 (PDT)
Message-ID: <be19509a-3e9a-e2a9-24c5-0aac74987942@redhat.com>
Date:   Thu, 13 Oct 2022 11:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] drm/vc4: hdmi: Enforce the minimum rate at
 runtime_resume
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech>
 <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On 9/29/22 11:21, Maxime Ripard wrote:
> This is a revert of commit fd5894fa2413 ("drm/vc4: hdmi: Remove clock
> rate initialization"), with the code slightly moved around.
> 
> It turns out that we can't downright remove that code from the driver,
> since the Pi0-3 and Pi4 are in different cases, and it only works for
> the Pi4.
> 
> Indeed, the commit mentioned above was relying on the RaspberryPi
> firmware clocks driver to initialize the rate if it wasn't done by the
> firmware. However, the Pi0-3 are using the clk-bcm2835 clock driver that
> wasn't doing this initialization. We therefore end up with the clock not
> being assigned a rate, and the CPU stalling when trying to access a
> register.
> 
> We can't move that initialization in the clk-bcm2835 driver, since the
> HSM clock we depend on is actually part of the HDMI power domain, so any
> rate setup is only valid when the power domain is enabled. Thus, we
> reinstated the minimum rate setup at runtime_suspend, which should
> address both issues.
> 
> Link: https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
> Fixes: fd5894fa2413 ("drm/vc4: hdmi: Remove clock rate initialization")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 199bc398817f..2e28fe16ed5e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2891,6 +2891,15 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
>  	u32 __maybe_unused value;
>  	int ret;
>  
> +	/*
> +	 * The HSM clock is in the HDMI power domain, so we need to set
> +	 * its frequency while the power domain is active so that it
> +	 * keeps its rate.
> +	 */
> +	ret = clk_set_min_rate(vc4_hdmi->hsm_clock, HSM_MIN_CLOCK_FREQ);
> +	if (ret)
> +		return ret;
> +

I'm not familiar with VC4 but your commit message has a great explanation
of the issue and the code is doing what you mention there. So this patch
looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

