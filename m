Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47B654921
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiLVXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiLVXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E33A275C4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671750309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDeshYsFzsV86X1KOSZ/3pdcOk+Tna6Uckljdyy2RF8=;
        b=O5lVI3FlRN0B9nmxttGl3Q9uFz4hcqNlBmUip/2n5yP3poNJf3Y0UVrlsMbENLmAAD7hrB
        rIFsZ9hErgL4oOwGfmxy6iuOxpJSWA8v1Xth6hCiekpia6WN0U3c2Y8oh2w8d+T+BFHey8
        hTerLensdCujm5OPMUBDax/WwyR/LVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-ZoQMwnJJNsu2KUr1nKz0jg-1; Thu, 22 Dec 2022 18:05:08 -0500
X-MC-Unique: ZoQMwnJJNsu2KUr1nKz0jg-1
Received: by mail-wm1-f71.google.com with SMTP id r129-20020a1c4487000000b003d153a83d27so1410655wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDeshYsFzsV86X1KOSZ/3pdcOk+Tna6Uckljdyy2RF8=;
        b=MaGHwzGK1worNb4MN5leM3/1NktlbZd0Dj5/Y8NWrOxGXfblPaq4v0p1owtR91WpqP
         t36m1NOrQ54zx/ciAga2QzR0a8/5m0UZlpIgmFk5mtZAHbiRSRGIUki6fbi8r+o85FXG
         NGFP0WLETqQKBefFPGEB3rr/XEvuA2vdoS7UBoY6VS6zdBOMjhQvTPLdEdAJ/BE/j4fl
         CS9ABSspq15hr7yoMaS8M9vrdj7PA/RTdHijFI2ZcB+4hq8aSUJ7RQxrnh+rd3yTA4/k
         41PvRk/PTwW/+mKcQ9RHURu1MMiW+QkPHclhaoXLhOw2MvKlZHET7j4XmsT/Ux06p/nz
         zLeg==
X-Gm-Message-State: AFqh2koS9p+zxavZ6OLQ39Hpl07oHGq6CdO7ZTBpqS+AOUoYHLgxDBWh
        Z5PThgZ2oXL9mfVhJ6FZBj2fGfeGR/sdb1+Xe7AdPoYWr20yXM2k1k6ouqmJdIsO064WoYPMs4v
        wAsgVNilFYOov4EMKtSnZcPxR
X-Received: by 2002:a05:600c:1509:b0:3d2:17a5:17fe with SMTP id b9-20020a05600c150900b003d217a517femr5668675wmg.18.1671750307397;
        Thu, 22 Dec 2022 15:05:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvD25Z/YHiooSzgqh71tRpQOAEo73yfqsXEDBtcnZt/C2er07zo/l+UVRh9D9JHC5Wgs75O2g==
X-Received: by 2002:a05:600c:1509:b0:3d2:17a5:17fe with SMTP id b9-20020a05600c150900b003d217a517femr5668668wmg.18.1671750307172;
        Thu, 22 Dec 2022 15:05:07 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm2349947wmq.25.2022.12.22.15.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 15:05:06 -0800 (PST)
Message-ID: <6fb84448-0b05-eb9c-40b2-3e9dc9bb51bc@redhat.com>
Date:   Fri, 23 Dec 2022 00:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 039/606] drm/i2c/sil164: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-40-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-40-uwe@kleine-koenig.org>
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

