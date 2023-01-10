Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D1663D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbjAJKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjAJKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44E50073
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673345335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUQwFTHyl5sEmJS56v9Sd6SQsFJb1ixfUiHemWZdP4c=;
        b=D9Q+zRn3YrG4kau28vNsEaRyKid8LzP1fWzU1sDkNEXR1G7c+cCkwX2u20vW7tYW/JuqLp
        mYqOZj/mf1ZJHq6yERfnWVI3LJzm1e8kiJD3B2ba6HTBLgzTqVM0ygaKjWc4t/g4YDV2eF
        epbCVeKYvUeWyWLa55RXvuEQx548Zc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-ZBKj1SrZNnubmii5lfsGUw-1; Tue, 10 Jan 2023 05:08:53 -0500
X-MC-Unique: ZBKj1SrZNnubmii5lfsGUw-1
Received: by mail-wr1-f72.google.com with SMTP id q22-20020adfb196000000b002bbe8a76d8dso1234416wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUQwFTHyl5sEmJS56v9Sd6SQsFJb1ixfUiHemWZdP4c=;
        b=W8mtVqJwEuhXy/W568CSWUZ0vFLzNkAgvlRuC90IbDw7DXNoPa+MiI2CrBr9IWux2I
         5AChDEjiHFS8rQIIkRdt+LpXxIMedGhNQ3e0WH6smwn1gSZKGzI/XHBU0UlIKHNDofsD
         nIyOTgP9ZLFCn9sw5RzlkaTVB5zKC88wV0u9UdI8xgZbHON5ay7ylWH06iVNM03e3yX+
         7b/d1Np2dtWkcq+tsFAzm8RyTcF7wHP4aP4ZEwCyQwRUy1fFanmOjjgTwLIR6wDK+kis
         LEsGtZh5ixpJUngJVSqCJst2JaFfzy4yQTYRkqkohIVNWHupSOTXkF8u3gyF/RUpCKIK
         SZuw==
X-Gm-Message-State: AFqh2koFSo1auJUIG4EJy95Iitk1eLwgAqCa6jbFHgPxgFp/FDesfcvl
        Iihot6EdT+vX4P2B28X5EY3W8YffBVp+oliWrWuloUWdqW2DZNBbZT5sQ4uJ3CaITDWg7BP49Ej
        mWOVf+hz+vtxuuKpDcS6zlEx7
X-Received: by 2002:a05:600c:3acd:b0:3d1:c354:77b6 with SMTP id d13-20020a05600c3acd00b003d1c35477b6mr52724137wms.29.1673345332658;
        Tue, 10 Jan 2023 02:08:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs/py9Kv0oVi6P3Ptag/7hVBbgW3PiV69fUX3cuCwR1paAwVPlvDxIkVZm9fEGVET3j5dsi4w==
X-Received: by 2002:a05:600c:3acd:b0:3d1:c354:77b6 with SMTP id d13-20020a05600c3acd00b003d1c35477b6mr52724121wms.29.1673345332487;
        Tue, 10 Jan 2023 02:08:52 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d990372dd5sm20873329wmq.20.2023.01.10.02.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:08:52 -0800 (PST)
Message-ID: <87ab7f23-d60d-108f-664f-82e5d6bdad50@redhat.com>
Date:   Tue, 10 Jan 2023 11:08:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 038/606] drm/i2c/ch7006: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-39-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-39-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 23:36, Uwe Kleine-König wrote:
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

I've pushed this to drm-misc (dri-misc-next) now. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

