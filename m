Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC8663D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjAJKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjAJKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB650076
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673345449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuquTFMqRJVfYTO7+J+3i6OURVu6jEbVGPSXjBZGYVA=;
        b=IovgLdytgIredn/kizpL8IBt724jp6kJo8Lrh9uUJp4s/4qAn7lfViUq7QsHx0WpgeEfE5
        gfh1JqtBD59qcDbd0tlYevv+Tm6Q+aGt2g0sZbdFZsYBsEtQGsp8NAMV2idxVPLVsIYN/S
        ZcX/FDwKuQxlUHd+j/o7KMatHtHdQCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-pAqLOUUZMryzfSLVbta0SA-1; Tue, 10 Jan 2023 05:10:47 -0500
X-MC-Unique: pAqLOUUZMryzfSLVbta0SA-1
Received: by mail-wm1-f71.google.com with SMTP id k20-20020a05600c1c9400b003d9717c8b11so6098340wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuquTFMqRJVfYTO7+J+3i6OURVu6jEbVGPSXjBZGYVA=;
        b=tLDgvqeKKgZoZy77H2U5YZx4pUIbRAfZpX6iu9xPfkGcb5KzRk4lkq/tD4n1CpO4ig
         y0Ot+v8mtO3etPKMhHq7g6FlCCHr8e9OWdcK8FooMZunW0X5unUK2rKak0wFVjE1Enxb
         /9wfsBeg63rTfTtnkHRiTcyYKDCtyjPkJWoviCsrCfgPgzAdcqDnQ+9tBm2V02+rsI5W
         2efHT/5/zWTHQmCQcdUmgt8iTOEsnihx2DNNyc6H8CpsLteEIhHxx5iZPhcIP27zD3db
         ld23WaeKDeLvIkhad8e09cUMYfwoHoPv5Asa6mMKiTH0MIohD6lyI1aU74DJoQsAW6j5
         rueQ==
X-Gm-Message-State: AFqh2koQyAP+6CSvrhKmHyEXcRNSnJz3aIKoz79ZNEnHo593cIBEA3Zz
        41mCbZWKCpq4n68AVJvEwXZEmiCh7DiRZCEkrd5aPuprEJFA0vKR7TijltOostib7OpYdFAa9tX
        Jhk2ZQ4TqtBeYk89ptNrSTVF5
X-Received: by 2002:a05:600c:44d4:b0:3cf:7925:7a3 with SMTP id f20-20020a05600c44d400b003cf792507a3mr48001541wmo.24.1673345446641;
        Tue, 10 Jan 2023 02:10:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtCaGy649oJyyMLaGDn2H4O3O+B/V9Ndk46ypRQlhZdduR+FByER9txa5+XPtVk9k1GBxK2xw==
X-Received: by 2002:a05:600c:44d4:b0:3cf:7925:7a3 with SMTP id f20-20020a05600c44d400b003cf792507a3mr48001519wmo.24.1673345446478;
        Tue, 10 Jan 2023 02:10:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm21349198wmq.22.2023.01.10.02.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:10:46 -0800 (PST)
Message-ID: <b5ad4a5a-50ed-4bdb-024c-e2ac76c79edd@redhat.com>
Date:   Tue, 10 Jan 2023 11:10:45 +0100
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
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
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

