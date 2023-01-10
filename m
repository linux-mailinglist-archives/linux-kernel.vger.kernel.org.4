Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8907663DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjAJKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbjAJKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1BA11442
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673345512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuquTFMqRJVfYTO7+J+3i6OURVu6jEbVGPSXjBZGYVA=;
        b=Gk5fqV8JeRgtGxjIyaH7sJ0C8iCh82FyogHhdTizqL7QFRL4/VoyskWdZxuUDI5Li31OQe
        Wy2GrWx6ftM6m+DJua44Lb6UE3qZdMIGTuPpJKH2u7HyLw4wdlRLxen1kvBQITKoPrWY4G
        wNwcD07OjY/GvCRnUxQrkPKr8zC5J+A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-4JEn3TWDMW-cg7AbizvEcg-1; Tue, 10 Jan 2023 05:11:51 -0500
X-MC-Unique: 4JEn3TWDMW-cg7AbizvEcg-1
Received: by mail-wr1-f72.google.com with SMTP id v12-20020adfc5cc000000b0029910b64099so1849914wrg.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuquTFMqRJVfYTO7+J+3i6OURVu6jEbVGPSXjBZGYVA=;
        b=DygfxEVX1LEJQ1SPX5rHjeQ68Y+PHRVgk1Y1ZTMXqTIqN+0QbtxLyp9TPUyr3Aio/X
         lYs4ycPVKhJ1yoWl/88niucY1hWsZ36aNulUUnO0P3nV5KVflUWH8wDaEOLl+C7w1MC0
         n1YC48nHRg7ODeHWgc7yM6rQQnwN5ZgJA5yZBDUOSrB20vvX5GOCiMnoy3DQzcNAND9I
         Ia2SIqVi+/8yr7Wjya3te5l6HEukqTK6v4X2MUAQEqn3MFmjJr/V1Gb4uh3oBjSNCtYS
         O8CBzn0kPFm3t4q7ZDLxbjOegCQB2fNhcKFFJNo6YdhLHEco5nys5mana3ye/8TezfWf
         mdBA==
X-Gm-Message-State: AFqh2kp3hJ2uETxlHGrp9CPPjmyFihv934N+1tX+7VyeB91Pac3o0qq4
        MzkhxA6CaFEJTQrJu1pM41lqsHabvGwn1OQiA/kVbMvVMueBbsAnuX/O27V6rgH+d+t/gElPOeM
        N0rVPgG7MN6zYtI57CMtuIgaE
X-Received: by 2002:a05:6000:1207:b0:2bb:d412:9866 with SMTP id e7-20020a056000120700b002bbd4129866mr7103303wrx.25.1673345510542;
        Tue, 10 Jan 2023 02:11:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtfFFHhzmCucFrCTK/XNlXR0dhKPkmzqLJkR6YXyfiB0YU/92FR0QQnnJ2aakpIWDe4m/HZmQ==
X-Received: by 2002:a05:6000:1207:b0:2bb:d412:9866 with SMTP id e7-20020a056000120700b002bbd4129866mr7103292wrx.25.1673345510382;
        Tue, 10 Jan 2023 02:11:50 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e1-20020adfdbc1000000b002b8fe58d6desm10831321wrj.62.2023.01.10.02.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:11:49 -0800 (PST)
Message-ID: <d30afd16-950a-7f2a-9ee9-31a0f3493ed1@redhat.com>
Date:   Tue, 10 Jan 2023 11:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 041/606] drm/i2c/tda998x: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-42-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-42-uwe@kleine-koenig.org>
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

