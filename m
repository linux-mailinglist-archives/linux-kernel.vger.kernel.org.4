Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614B0694680
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjBMNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBMNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:05:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810F15C98
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676293493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwrV3ycx4iFO2320A5Qv6QZGdJkUA6v5aGk1TzzMXqA=;
        b=apItXTkSa101q9hR+T7tybAEFyskumJYaRZElQhQvTypy26XgA90zBiFCrJ8xhrGvUMj5L
        CtunKNzNZbInSLi6UNndISrubjuElJk5af/2Z9OXE+ASHAZzq5ECCdewyf2At9fJYcwlxS
        nmQ1otyROncuzRRUlQHBV7HQLq8GtnM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-9AEh6irPNbG3gvMdKDZMxg-1; Mon, 13 Feb 2023 08:04:52 -0500
X-MC-Unique: 9AEh6irPNbG3gvMdKDZMxg-1
Received: by mail-wr1-f69.google.com with SMTP id o9-20020adfa109000000b002bfc062eaa8so2412780wro.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwrV3ycx4iFO2320A5Qv6QZGdJkUA6v5aGk1TzzMXqA=;
        b=YFpGQvjsf/8AtWcCUPumRHEOwl67puvf9Ol2qERvtVNzCSkY2R+bYmIp1lxImf2GIM
         tykXADQBys6tqPaIWi+XBUV0srXBTFY6Dk3EF6P6hZj9e3pyq+gT6mz8zijgzk4AD/nh
         m1LJ2cgZUuNVXZsHlr6tlotnAMY+doyX40+4S7jxfBeonOYC9sogf1zpWJJwI4A0c3gL
         hDg6aGweZ2W5Ywg2jpsNUerRsxwlXPIjXFG+62d7YxHlwYeVI8iovZ4RssEZibR5oRai
         RMK3mbiXxU+uvwtIUF9ySLeNQFcDNVLZUHhNKWDHkJ0BSuW9leKIbTMTt1Y0LeBmuHfu
         AaSw==
X-Gm-Message-State: AO0yUKXqHKkPgMePi+2A2tvEPPCpxr2yw+lB6txvXRy+O6oHSA5DzERM
        s2Ox90DPz67XPAi/FLc7h2xi05Zsb/8xs2tQOcUWDUlZS1UUHHQPwUk8zn2KE+avMf4nMqR2Gzb
        RWiJBYYIA+raDX2bDE8nrp53H
X-Received: by 2002:adf:db88:0:b0:2c3:d83a:113a with SMTP id u8-20020adfdb88000000b002c3d83a113amr20956964wri.4.1676293491438;
        Mon, 13 Feb 2023 05:04:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+2fYVfJ8xcbOh8Q019xoi0eGuMc4hfGo5jogmj3eAYReeBtklOcxey30kucV/8Pt9pouK1zg==
X-Received: by 2002:adf:db88:0:b0:2c3:d83a:113a with SMTP id u8-20020adfdb88000000b002c3d83a113amr20956954wri.4.1676293491245;
        Mon, 13 Feb 2023 05:04:51 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d4b41000000b002c54c0a5aa9sm7768432wrs.74.2023.02.13.05.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:04:50 -0800 (PST)
Message-ID: <7ffc4967-11b2-e74d-2239-8f5ff19dcb28@redhat.com>
Date:   Mon, 13 Feb 2023 14:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] Revert "drm/vc4: hdmi: Fix HSM clock too low on Pi4"
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
 <20230126-rpi-display-fw-clk-cleanup-v1-3-d646ff6fb842@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230126-rpi-display-fw-clk-cleanup-v1-3-d646ff6fb842@cerno.tech>
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
> This reverts commit 3bc6a37f59f21a8bfaf74d0975b2eb0b2d52a065.
> 
> Commit 3bc6a37f59f2 ("drm/vc4: hdmi: Fix HSM clock too low on Pi4") was
> introduced to work around an issue partly due to the clk-bcm2835 driver
> on the RaspberryPi0-3.
> 
> Since we're not using that driver for our HDMI clocks, we can now revert
> that inelegant solution.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

