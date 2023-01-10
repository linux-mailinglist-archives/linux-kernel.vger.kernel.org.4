Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D74663DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjAJKOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbjAJKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57484193F5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673345573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuquTFMqRJVfYTO7+J+3i6OURVu6jEbVGPSXjBZGYVA=;
        b=Zxpehn0DRjlvG7JrYxNH/8sgqMEjsy23tWFiN4wAx18M7z33TND0CM7Zu70XqVmUb+Hkv+
        dsbklXUt4JDOmQLyd4DZUopceaahsBjfhZ0B++Zw8yoLOm2qA73Ez/DfdrskdHyz78WDT+
        GterM27mk+UG1i71EJ1cwKySDGq/Zjo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-3LJ8YcreP1-16LjUq-VEXw-1; Tue, 10 Jan 2023 05:12:51 -0500
X-MC-Unique: 3LJ8YcreP1-16LjUq-VEXw-1
Received: by mail-wr1-f69.google.com with SMTP id b6-20020adfc746000000b002bae2b30112so1825779wrh.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuquTFMqRJVfYTO7+J+3i6OURVu6jEbVGPSXjBZGYVA=;
        b=eAIBrKuueHmHJx1j3R/wH1rBH9s+0yCXOt5P5UPRiaOmK0nBm2aYwPdkvQNwX6/Pil
         1Aqd9UwHDM30RfiZhbSdIKVqgssY+3Oc77X7OllGRAFWFy5TNOG8bG6DufHI1s1aH90F
         VYRdE9RxDbXzlrnazIYztwla76k/8lx7c+H5b1x9a8ZtHeAGOMegA/Gqzt3aT2QWPs7e
         fiIjl/1hfRMbNSLJcihBNSG3CzEO1Xzo+OMber3h4a68GyjZzFN8pERZQSG++uRGPrVk
         +O0E1QgVKnDZGxG2pgLR9y2E+Jqbf60K+zbZxBI7UKUFpHAZFgqxIwwpWePL1x9gatXD
         Ao6Q==
X-Gm-Message-State: AFqh2krz4jvGf9q0mjb2WhF6HzpUihWoTBh3nWIjI/26RWAj0rg8K/Bl
        r+7OGjC/ycDzzuDOHhB6Z2AIpMJVdKp8lU++TT4/iIlR/w/ed+UCuQSAxSmDAEvn2+y5F3PEAwv
        vU56r+fReSzBsFafCGo68VYEk
X-Received: by 2002:a05:6000:1c03:b0:2bb:ed0c:a0d8 with SMTP id ba3-20020a0560001c0300b002bbed0ca0d8mr5142075wrb.53.1673345570712;
        Tue, 10 Jan 2023 02:12:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu/5e/whfZNkNjxhGF3SHOyW9iABZBnx4Wufy63eX0Zml438v1A3SA4AofxRL6YDrsAARLP7g==
X-Received: by 2002:a05:6000:1c03:b0:2bb:ed0c:a0d8 with SMTP id ba3-20020a0560001c0300b002bbed0ca0d8mr5142067wrb.53.1673345570528;
        Tue, 10 Jan 2023 02:12:50 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002426d0a4048sm11083364wrn.49.2023.01.10.02.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:12:50 -0800 (PST)
Message-ID: <415593c5-e603-099f-98b0-7f6919474e73@redhat.com>
Date:   Tue, 10 Jan 2023 11:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 043/606] drm/panel: raspberrypi-touchscreen: Convert to
 i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-44-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-44-uwe@kleine-koenig.org>
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

