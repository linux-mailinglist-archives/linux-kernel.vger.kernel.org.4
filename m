Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA57C694681
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBMNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7F15CB8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676293536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYkTV4tyLAcRG/rU/+4tGzBQIIPIsZ3hjAeuxGShtI0=;
        b=bYEeZDrYXgZyTSI/uY/LEC0WLAG4eVLkZvXhz2oUZnBpiM7WW4/xpyyYrUjqiwOgo7ij2L
        cHS9qlthIOLVCj9/iImAvF4STIj7wFhwTeBYyOGhJX57jbmMSdsMghQ0RFmkalR49z2IPl
        daPcRgyGULxBhJzTQbXdcWgS3+ACAzQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-pwZhr5-vMCq3I_ogz6Mfng-1; Mon, 13 Feb 2023 08:05:35 -0500
X-MC-Unique: pwZhr5-vMCq3I_ogz6Mfng-1
Received: by mail-wr1-f72.google.com with SMTP id i1-20020adfa501000000b002c54aaa28dcso1475732wrb.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYkTV4tyLAcRG/rU/+4tGzBQIIPIsZ3hjAeuxGShtI0=;
        b=yJndFUG494w1SPtJLVvNvdZ2lamdstsm5EWnQfiEvHJqCy9g1D7xkqHAOCyFcZykX0
         tRT84uB/3YQswibWVQA0FxAGty5IhxgBJ8G13olBALNiuQr7Z9cGsApt7qW6GuoRSW6n
         tzYYYJt8GNbmv+B6pwXhtutmyT/PaIPxdC6j97GT3VEBSV4wZcO5Rx4ztsERU7gRHoZ7
         Dpf0n21ZX2qClwRmt1bFyigvn1Ea/iVQiTPfh90yx8zWoufuJJ/+H2RzFM8NWcn3ZJnG
         xl/lc/QXTqGK5RsPprkFZ+jRoeIUc+eVIxMXGQ2RVONBdHijP1nFmbfGU2MMd+TwquvI
         V19g==
X-Gm-Message-State: AO0yUKUaKqjS+E3Hw2aLV7sw+b9pOw48yJ2+U/Nkb3g8l2xSTd01pwys
        bzRy8IJsK8Lwn0/J/wfw4S7EGorJ82TUs0LGWXfUs756v+vOekCW5yfETUh/g7ozWWxeilHdEzI
        4MSJBa1DtAoEFzKSL6NpRi38XtTYQZw==
X-Received: by 2002:a05:600c:16c5:b0:3d6:ecc4:6279 with SMTP id l5-20020a05600c16c500b003d6ecc46279mr19035307wmn.27.1676293534253;
        Mon, 13 Feb 2023 05:05:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8FPuXkfVk83D9UQRYyECQ/K1rXbN2t+4k28Kku0b12C+mK4WR0jl69pa62ChZt11IwVmoBDA==
X-Received: by 2002:a05:600c:16c5:b0:3d6:ecc4:6279 with SMTP id l5-20020a05600c16c500b003d6ecc46279mr19035293wmn.27.1676293534095;
        Mon, 13 Feb 2023 05:05:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm16701912wmi.18.2023.02.13.05.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:05:33 -0800 (PST)
Message-ID: <f8ec5586-7ac1-be33-76d8-48b62c253465@redhat.com>
Date:   Mon, 13 Feb 2023 14:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/4] Revert "drm/vc4: hdmi: Enforce the minimum rate at
 runtime_resume"
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
 <20230126-rpi-display-fw-clk-cleanup-v1-4-d646ff6fb842@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230126-rpi-display-fw-clk-cleanup-v1-4-d646ff6fb842@cerno.tech>
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
> This reverts commit ae71ab585c819f83aec84f91eb01157a90552ef2.
> 
> Commit ae71ab585c81 ("drm/vc4: hdmi: Enforce the minimum rate at
> runtime_resume") was introduced to work around an issue partly due to
> the clk-bcm2835 driver on the RaspberryPi0-3.
> 
> Since we're not using that driver for our HDMI clocks, we can now revert
> it.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

