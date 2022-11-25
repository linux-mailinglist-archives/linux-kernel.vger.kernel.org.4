Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C963881E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiKYLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiKYLBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F794A071
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/ZkLtm8A9FTaUIt1krh1NXQg3mdZeQrz9lNHvK9Ra0=;
        b=Ynt936F3L64vY2SATAA+42O1c1oRsAdtVz70eQ0TYF0OqZ5I5uBx/lOdoCJbjF74A1fjer
        8ttF1+AxquXpLpopu1fHo3VYoB21vunRisblvq7eN6rIw124CZF0EjhK5RoTe9QHASu/kf
        0hXqhiBcK019ROsCoMIWd4JmKqhWRZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-7DjtB-U9O4OXU9mgPc9Naw-1; Fri, 25 Nov 2022 06:00:47 -0500
X-MC-Unique: 7DjtB-U9O4OXU9mgPc9Naw-1
Received: by mail-wr1-f72.google.com with SMTP id o8-20020adfba08000000b00241e80f08e0so775144wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/ZkLtm8A9FTaUIt1krh1NXQg3mdZeQrz9lNHvK9Ra0=;
        b=awXorezkFRRPHikDgkWpsAJkY7btagiHCA0nE5E9mQM/Bk6a7+soa+K1p9EdPaHXcv
         L4rkWWEYOZbusudgefmGruH9SYgZnX5wcBDWwRWtFgGrvnD7hTNLexpnc45XO4k/84vf
         GPuwkegmI7lwXGggc+J/MZdB3Pf+8kB60OeMv7C9SARJqzuYgRah+SUMTUov96Ck1OND
         RZ37o9eZM22L2zs7+FDPlD9Zyeif3pzs6UAgSqfVE6YKhmWyb+eFSt+1xMP8HxKbKRFJ
         uy5ioKoqH3jgRuoRwqGCk+iQpGiSM1KS7OmNHfll5x74Nw/6TJE+YSfG3fD86yFplxN5
         sXFA==
X-Gm-Message-State: ANoB5plIvS5XI0IkGUk1yVrFmA0iEIiOBBdnV7RDpmliEVkTivSZqgty
        4Z3mYPfFLPvCebSLzyoktqbPBVRVL85cYEKk05q0A4TC2X9zna7e7ez7ATyvUoWMmxegNrFTh0p
        15UH+f1SRzeAzHKgcTO5qU6M6
X-Received: by 2002:adf:e508:0:b0:236:588f:b5d with SMTP id j8-20020adfe508000000b00236588f0b5dmr11244631wrm.255.1669374046415;
        Fri, 25 Nov 2022 03:00:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Xu/NP6mlFBtx0snOLhZERGkaY9p8k3uPMLjkAV/xFHCXfHC5Y76yhHYrvcopCb8lv41h+LQ==
X-Received: by 2002:adf:e508:0:b0:236:588f:b5d with SMTP id j8-20020adfe508000000b00236588f0b5dmr11244612wrm.255.1669374046175;
        Fri, 25 Nov 2022 03:00:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4cba4ef71sm8531125wmi.41.2022.11.25.03.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:00:45 -0800 (PST)
Message-ID: <2762e41f-0508-2e25-b787-7b68d5014a77@redhat.com>
Date:   Fri, 25 Nov 2022 12:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 10/24] drm/vc4: kms: Sort the CRTCs by output before
 assigning them
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-10-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-10-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> On the vc4 devices (and later), the blending is done by a single device
> called the HVS. The HVS has three FIFO that can operate in parallel, and
> route their output to 6 CRTCs and 7 encoders on the BCM2711.
> 
> Each of these CRTCs and encoders have some contraints on which FIFO they

constraints.

> can feed from, so we need some code to take all those constraints into
> account and assign FIFOs to CRTCs.
> 
> The problem can be simplified by assigning those FIFOs to CRTCs by
> ascending output index number. We had a comment mentioning it already,
> but we were never actually enforcing it.
> 
> It was working still in most situations because the probe order is
> roughly equivalent, except for the (optional, and fairly rarely used on
> the Pi4) VEC which was last in the probe order sequence, but one of the
> earliest device to assign.
> 
> This resulted in configurations that were rejected by our code but were
> still valid with a different assignment.
> 
> We can fix this by making sure we assign CRTCs to FIFOs by ordering
> them by ascending HVS output index.
> 
> Fixes: 87ebcd42fb7b ("drm/vc4: crtc: Assign output to channel automatically")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

>  
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -		struct vc4_crtc_state *old_vc4_crtc_state =
> -			to_vc4_crtc_state(old_crtc_state);
> -		struct vc4_crtc_state *new_vc4_crtc_state =
> -			to_vc4_crtc_state(new_crtc_state);
> -		struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> +	/*
> +	 * The problem we have to solve here is that we have up to 7
> +	 * encoders, connected to up to 6 CRTCs.
> +	 *
> +	 * Those CRTCs, depending on the instance, can be routed to 1, 2
> +	 * or 3 HVS FIFOs, and we need to set the change the muxing

This sentence sounds a little bit off to me. Did you mean:

"we need to set the muxing between" or "we need to change the muxing" ?

I'm not familiar with VC4 but the patch seems to do what the commit message
says, so the changes look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

