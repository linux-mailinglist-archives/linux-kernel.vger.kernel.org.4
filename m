Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F945FD739
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJMJnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B914639B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665654199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRHBo5SUeLCV/E2K6kx3b4+ZRZldTZk3UWnaaDGNeBs=;
        b=IZ0P4ZL3N0N1dGgsnjpik20U5UARDmcMJGw4/8TbfQv/hFnD5xdofyeZJknwVzkmrS51Qg
        q2B0yDwv2fSpdWnx5kMgOpddwztgXlGu51+Zx90JmQKpve4f2HczxsHP48bjUQZ5uEVuZk
        Rl8jBuTZLa89Afqkw9KYJFUcs2ZW+7Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-s53JVzkEMsOFNM3JhPxH8Q-1; Thu, 13 Oct 2022 05:43:19 -0400
X-MC-Unique: s53JVzkEMsOFNM3JhPxH8Q-1
Received: by mail-wm1-f71.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso600496wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRHBo5SUeLCV/E2K6kx3b4+ZRZldTZk3UWnaaDGNeBs=;
        b=BUtQwxXzVgQ4NFZfBI4uPepaVUQoU0GFCcTOV2oVDDBaNNoyao6ZPQ3XsT71QfCcAh
         31RF/X39Bpg3KMtXmslZgeuogSQoqSneEL44ynIyZuQOBJLj/M8xkMuYMaM7qD39raAf
         jEWL/6RBPWCmKtcsSKwLtFXC1qm7DUq5RY72dhbQ6YUA0BOwfkKAggzIXROrBLA1WoW2
         sWd23HD8fvPU4UbR/fpnNmJqbG9WZoAzi+myw4+uf96+5krWgXIXSOHwRv2W0iL7+feK
         VfeeY+268Xc4NbdUJ7h9NwXRSVOzbFfnrDDM6LCHUb0cWu0GJVkfS7b3HG1zgnqm00MD
         CPFA==
X-Gm-Message-State: ACrzQf1zUWAToQiPkxQZQ9OscaccfbWExMG/rZlS7oo3nNscxMV6XNqz
        PyZfFqqms+LPzFZ5T/0Xev1Inthq6VTIpHXrLLwlUu5KvBVLqTZKtAvFd1vDUOEuIVnKgm2VkJK
        wu+XFL9pWFYf/IyyfiRzshzHH
X-Received: by 2002:a05:600c:19c7:b0:3c6:dd03:2b26 with SMTP id u7-20020a05600c19c700b003c6dd032b26mr1846732wmq.37.1665654197398;
        Thu, 13 Oct 2022 02:43:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42THVg7nhaB7qLqF5GFVCwFxBO1/Ueag57fTSguAHHm0uXxPyMwk7RcOINk5grnJLE3KuYrw==
X-Received: by 2002:a05:600c:19c7:b0:3c6:dd03:2b26 with SMTP id u7-20020a05600c19c700b003c6dd032b26mr1846717wmq.37.1665654197222;
        Thu, 13 Oct 2022 02:43:17 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e14-20020adffc4e000000b002301c026acasm1570167wrs.85.2022.10.13.02.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 02:43:16 -0700 (PDT)
Message-ID: <44ac29ea-7836-1cd6-fced-9ffd88a7f056@redhat.com>
Date:   Thu, 13 Oct 2022 11:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] drm/vc4: hdmi: Check the HSM rate at runtime_resume
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
 <20220929-rpi-pi3-unplugged-fixes-v1-2-cd22e962296c@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220929-rpi-pi3-unplugged-fixes-v1-2-cd22e962296c@cerno.tech>
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

On 9/29/22 11:21, Maxime Ripard wrote:
> If our HSM clock has not been properly initialized, any register access
> will silently lock up the system.
> 
> Let's check that this can't happen by adding a check for the rate before
> any register access, and error out otherwise.
> 
> Link: https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

