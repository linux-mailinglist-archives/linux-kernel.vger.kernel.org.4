Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4139D67D545
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjAZTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAZTTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99B20686
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674760737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fMObdQvzZWrd2jmea2KvQ+KMA1oa3ru9SdLqtXyBe4=;
        b=Omo4xkbqPn1+n0D3oJ12fWSiDn0VvL8AP9aRkX1YRf8Ff1VQlrcqf/8uGPuKmWjuWBuFZX
        BKnJGl7D1p/PYDqhwqInHEwxZ1dSfTfaFVwHVwjAvuq9yvfd0O+sIL/pb6Zu/uwCV4OG9z
        QAzd09faj3UnazO6XqNpgDYPEX5Qilc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-xaZKzE-RPK6PWlbnUtR8wQ-1; Thu, 26 Jan 2023 14:18:55 -0500
X-MC-Unique: xaZKzE-RPK6PWlbnUtR8wQ-1
Received: by mail-wm1-f70.google.com with SMTP id fl5-20020a05600c0b8500b003db12112fdeso1527368wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fMObdQvzZWrd2jmea2KvQ+KMA1oa3ru9SdLqtXyBe4=;
        b=z/oGs8y3qVSnlNXHDYTDfgZpPKSrJrk0hQ5mKs03RSpyv00TtNTrIHO75UFTo8rOpp
         WPizHVC87nYjN7wahy+b8F63GFm9OB3H9NC8DroYZLabG+Ta4fLZyQhz2UdSQ0KXtxet
         7KnoX3Ub+H7FmlcCYjmxtDUqYf05opwQB/2YfdX/M5ikTU4qzTlNhmpBqH2y0dDnSZSQ
         tqyo6DLsM6i9Ve9Mz5r/5//qIMYVIAoch1cAr/V1zfgyVWzNZf9eeIvlLbJr0X36AOpF
         odYVGH+6s/QSL3R7CkeFpM8d2NTmwpxn+aYGWTYChMRCBQ9+xl3WXCL+b3F3/G3cujbH
         u4Zg==
X-Gm-Message-State: AO0yUKUm00JhkZGE9yCmOf8PU5e0mq8fMISxRLRaPjIagMBRolZbKJs1
        D/2aXy1alEcCvSA6Vs9V1RxzMpdfm26r7I+ovwxx2oE4sr9vlZoAkWdmgOFGKQ2LYB6K5ajHyZe
        h74LWQvGKMSs/Sbfsms/uwuO0
X-Received: by 2002:adf:a50f:0:b0:2bf:bf36:1604 with SMTP id i15-20020adfa50f000000b002bfbf361604mr5661517wrb.35.1674760734857;
        Thu, 26 Jan 2023 11:18:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+3EpQgIqyXltSXk5BrveJaffTWXPBze3LY8R7Ub/MqZC5yKZ6KN5yJVNbyyTeFoEed+5tLUQ==
X-Received: by 2002:adf:a50f:0:b0:2bf:bf36:1604 with SMTP id i15-20020adfa50f000000b002bfbf361604mr5661504wrb.35.1674760734631;
        Thu, 26 Jan 2023 11:18:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b002b6bcc0b64dsm2065409wrq.4.2023.01.26.11.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 11:18:54 -0800 (PST)
Message-ID: <d7286bc1-32bb-ac70-113d-04c3a56519bb@redhat.com>
Date:   Thu, 26 Jan 2023 20:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/ssd130x: Init display before the SSD130X_DISPLAY_ON
 command
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230125184230.3343206-1-javierm@redhat.com>
 <82ad8c89-9d6a-ffa8-e2ad-7b53ac27cafb@suse.de>
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <82ad8c89-9d6a-ffa8-e2ad-7b53ac27cafb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 20:56, Thomas Zimmermann wrote:
> 
> 
> Am 25.01.23 um 19:42 schrieb Javier Martinez Canillas:
>> Commit 622113b9f11f ("drm/ssd130x: Replace simple display helpers with the
>> atomic helpers") changed the driver to just use the atomic helpers instead
>> of the simple KMS abstraction layer.
>>
>> But the commit also made a subtle change on the display power sequence and
>> initialization order, by moving the ssd130x_power_on() call to the encoder
>> .atomic_enable handler and the ssd130x_init() call to CRTC .reset handler.
>>
>> Before this change, both ssd130x_power_on() and ssd130x_init() were called
>> in the simple display pipeline .enable handler, so the display was already
>> initialized by the time the SSD130X_DISPLAY_ON command was sent.
>>
>> For some reasons, it only made the ssd130x SPI driver to fail but the I2C
>> was still working. That is the reason why the bug was not noticed before.
>>
>> To revert to the old driver behavior, move the ssd130x_init() call to the
>> encoder .atomic_enable as well. Besides fixing the panel not being turned
>> on when using SPI, it also gets rid of the custom CRTC .reset callback.
>>
>> Fixes: 622113b9f11f ("drm/ssd130x: Replace simple display helpers with the atomic helpers")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Applied this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

