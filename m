Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6949569466F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjBMM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBMM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE111642
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676293150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sr32W6YPmd1W7Q3/7hIKrP1sIec4jf+zMzMaG9iU4Ts=;
        b=Aob1D3zy8JGLXR/fXMYYBsX7WQysut1HH3t4ZCvVkzCg6DJZ9/r8cYYvSzLUkY1kocJvk0
        WXJLSeRHxQ4CzrW27Q8WiNllEWerJeLvh4kbjtRtnrQnkYssKmvIwanZyHt4KoC46o/VfR
        rTHrPCpal+62owGa8xe0cfa+sRYC8rs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-LkCOxyUHPBq2mDBynsZgBQ-1; Mon, 13 Feb 2023 07:59:09 -0500
X-MC-Unique: LkCOxyUHPBq2mDBynsZgBQ-1
Received: by mail-wm1-f69.google.com with SMTP id ay19-20020a05600c1e1300b003dc54daba42so6109673wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr32W6YPmd1W7Q3/7hIKrP1sIec4jf+zMzMaG9iU4Ts=;
        b=kmR3NYUtOjbPsA35NN4lzieyLK6By4P+3DycW3p579wnEa8CkYzHk/2FHyg/I42zBF
         WU9DVcwoG/mDV8XsR8d1JMLh6JkqizWPBs5SKL6vBJa9uNPxp1+TwzApL14sgokDfrt1
         FxSUixmuQWPG0G4riyxdSLv0wckPHqD/Yj8FqAFz0pa6hlu6t+TuCwdXavQISFK8KU8c
         K4cbTDwBQ3muMlC/QQViR/mm9E1RqpuGAtEzY6R6FNvzz4Oz8uuwV/EOyzIswYMTyJsD
         Cep/BhzUdglI2uA29WXRmG7NqJ8KP+EvrnEVKnjW2afJLUjIVE+20pXuP4BfmLXreCr+
         k81w==
X-Gm-Message-State: AO0yUKVkh9QMtCGVwSTGkyehDl5Z6s6wirZoc9i7h8xQRZ0ukMrlog2x
        KkKDtRnwzehwTT1TcP1ipTIkYTSMzOK8HVAjoBiFZSWLfJx6CFXwR6mIiKBJgIW6fpQXY/t6HM4
        Nz6iaGNoYQQ1mvWEhVK4jya+J
X-Received: by 2002:a05:6000:124e:b0:2c5:5454:22f5 with SMTP id j14-20020a056000124e00b002c5545422f5mr4041005wrx.54.1676293147856;
        Mon, 13 Feb 2023 04:59:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+2CfSs0HvvE0g5xn98FoymHYlVBVN/pq+asF2ZXlqjZN8eHrzya9X+exWrdVF5/TFVr4zoTw==
X-Received: by 2002:a05:6000:124e:b0:2c5:5454:22f5 with SMTP id j14-20020a056000124e00b002c5545422f5mr4040988wrx.54.1676293147637;
        Mon, 13 Feb 2023 04:59:07 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b002be0b1e556esm10382182wrn.59.2023.02.13.04.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:59:07 -0800 (PST)
Message-ID: <d6b158ff-382c-c659-04c8-930b2681e8d6@redhat.com>
Date:   Mon, 13 Feb 2023 13:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/4] drm/vc4: hdmi: Enable power domain before setting
 minimum
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
 <20230126-rpi-display-fw-clk-cleanup-v1-2-d646ff6fb842@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230126-rpi-display-fw-clk-cleanup-v1-2-d646ff6fb842@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 18:05, Maxime Ripard wrote:
> On the RaspberryPi0-3, the HSM clock was provided by the clk-bcm2835
> driver, but on the Pi4 it was provided by the firmware through the
> clk-raspberrypi driver.
> 
> The clk-bcm2835 driver registers the HSM clock using the
> CLK_SET_RATE_GATE flag that prevents any modification to the rate while
> the clock is active.
> 
> This meant that we needed to call clk_set_min_rate() before our call to
> pm_runtime_resume_and_get() since our runtime_resume implementation
> needs to enable the HSM clock for the HDMI controller registers to be
> functional.
> 
> However, the HSM clock is part of the HDMI power domain which might not
> be powered prior to the pm_runtime_resume_and_get() call, so we could
> end up changing the rate of the HSM clock while its power domain was
> disabled.
> 
> We recently changed the backing driver for the RaspberryPi0-3 to
> clk-raspberrypi though, which doesn't have such restrictions. We can
> thus move the clk_set_min_rate() after our call to runtime_resume and
> avoid the access while the power domain is disabled.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

I'm not familiar with the RPi clock hierarchy but the commit message explains
why a clk_set_min_rate() was needed before the pm_runtime_resume_and_get(),
and why that isn't needed anymore after the switch to clk-raspberrypi driver.

And certainly, the correct thing to do is to enable the power domain that a
controller is part of, before attempting to change the rate for one of its
clocks. So the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

