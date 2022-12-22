Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102D65491C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiLVXFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLVXFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9026AF3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671750264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDeshYsFzsV86X1KOSZ/3pdcOk+Tna6Uckljdyy2RF8=;
        b=WSqvKAVbI3uaJkb+t4+8xpP6kTbNoaOvkuvw/qxGOZH+FZEqyi9JnJDLZXWZExVJIhjlGe
        MT0b9eeJhehzmkOsCxslwH0ytP7eedhtHMtKGFajXUPw+LGUS4mMNqv49SBvsVk9nZx0bs
        TuTK+HNAg3YcAIq9bKeRu/Bt3fncly4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-7XiUUrQIPca-otr3Gx7n7w-1; Thu, 22 Dec 2022 18:04:22 -0500
X-MC-Unique: 7XiUUrQIPca-otr3Gx7n7w-1
Received: by mail-wm1-f69.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso1388205wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDeshYsFzsV86X1KOSZ/3pdcOk+Tna6Uckljdyy2RF8=;
        b=a41eADrG3m2dnsXF/8o7UFw6m3k5xP84n/uZ1bcWCCEWCWqBb4wk0iJkXq8LOQZ0RV
         vzqIlPvo+qNUuXHiaPB0rB3cizVYt0tGeGQmPHNFfmUNLiwBaNxwj1xZXANOdWo0mAI0
         mNTVT0JJ4nrVZOn8hHFju7d5Hyv4xHsgFPHs/upzJKSAId3RoGzGdaExpNHPry2mJorV
         b/n8B5VJLXk2W7f+hHxucEySrHut0y8JWzN2e2Q9+UNK1i6QyRW68l+U4dkW/DhtT3Qu
         gNKcsuhk27MptK63LIzROFVi70ntjwHBHVjXxQrbcqhNSagx0uYDvER0HXse172XsEMe
         vp2g==
X-Gm-Message-State: AFqh2kohJVKLPiuoFaBQNGEjbqAyuKxY/aZ0J1nD4QW6Qchag9DE6LB3
        VXMFDCqcEojVNrfcj2SMZX/qZFlxZuvS16WAvdmp6EA8C9ZdHcyvL4qUYWntyjCtjK1JRSC4dY9
        C5wGk5iIlFJ48642+MNXPWuod
X-Received: by 2002:a7b:c4c8:0:b0:3d3:5a4a:9101 with SMTP id g8-20020a7bc4c8000000b003d35a4a9101mr8400349wmk.23.1671750261718;
        Thu, 22 Dec 2022 15:04:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsRpCTqsnPlNZ+CYl+PJ8WJe4hBMc4zpUYGpFfR67OxQ/mL0PszQFuVVcvkMXe0Yey2+OQkhQ==
X-Received: by 2002:a7b:c4c8:0:b0:3d3:5a4a:9101 with SMTP id g8-20020a7bc4c8000000b003d35a4a9101mr8400338wmk.23.1671750261555;
        Thu, 22 Dec 2022 15:04:21 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003b49bd61b19sm7757852wms.15.2022.12.22.15.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 15:04:20 -0800 (PST)
Message-ID: <4407048b-0bcb-ad46-4267-079a9c5baa90@redhat.com>
Date:   Fri, 23 Dec 2022 00:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 042/606] drm/panel: olimex-lcd-olinuxino: Convert to i2c's
 .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-43-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-43-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 23:36, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

