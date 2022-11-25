Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0810638860
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKYLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKYLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436094D5E3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lxU1Rbb/abSsZvZ6c7uR6nOCdyrA7Yjf5rgzN1ey7M=;
        b=bIq0/wW3cfbmomHWU9rrPZfNhhlkaJIaN6MZJCmhg/tgvmE67hBwwekCSsAnMut+QbvgyF
        1uu6P13/QUUNeFseULuvYtYj3f8pjCiLjGcwFcgryZkTZYFX/IRhsTVC1jSAyFYUVKv2bo
        mah7Zn23yEeWEaCf9GzIjtCDb1NmGTc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-zA6qtKd5M2SLXKfgDQdmOQ-1; Fri, 25 Nov 2022 06:12:12 -0500
X-MC-Unique: zA6qtKd5M2SLXKfgDQdmOQ-1
Received: by mail-wm1-f71.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso4054693wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lxU1Rbb/abSsZvZ6c7uR6nOCdyrA7Yjf5rgzN1ey7M=;
        b=twGTkHRjwG5Pgj+5VqiRLF/YintlolTyVvK+T3Am9RkDaTUuD9juopuU+0gHG5w+kp
         qGS3oYWpFQ6Odg0BcxDXnGFxce35jQA1hb5oOC+0pqeSXMnVxykXxsJbHWgYztOUPfpL
         ht/B0ExhSvM3/3yABZiV+jQabVfu7aaXTuYhq2z2KSVsOY8YUoky+no5XWyaA9UV991B
         1mCFRrkdwpBjQNDSLCNW1bLV+bvGdzIZhYYhfpGY5othUBNVOIURer0VrcsgQJUhaiUu
         WC0JTxjmpD4JN+0JJIilTODXQz7znKMhoubDF8B6DMXjOUijvS+HO979Npv9ImCp/qwn
         l1+A==
X-Gm-Message-State: ANoB5pkzqXsXUnJnmoSBcM0W71aNfjHv15ueXbqjNzHaG8t0SFqbGxCp
        aPXHrGwsrJzG5WXqemdWF2OIkXz+CznyltCF4B2oCuV5ul1HCpgahO0yDCC52BapI/rUMot1L/1
        0Bc1Ooq5g05Ujb+qvjvzzu5/q
X-Received: by 2002:a05:6000:1c0e:b0:241:e4d1:d192 with SMTP id ba14-20020a0560001c0e00b00241e4d1d192mr10209319wrb.534.1669374731091;
        Fri, 25 Nov 2022 03:12:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7p1vj0N8iVuX9+tqZWhKZmYo4t7Jz83x2SXNSaxC/wK47BdRJZAm4d8wEODTWCBcg4oGQSAA==
X-Received: by 2002:a05:6000:1c0e:b0:241:e4d1:d192 with SMTP id ba14-20020a0560001c0e00b00241e4d1d192mr10209298wrb.534.1669374730903;
        Fri, 25 Nov 2022 03:12:10 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id hg27-20020a05600c539b00b003a3170a7af9sm5141530wmb.4.2022.11.25.03.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:12:10 -0800 (PST)
Message-ID: <c7995e42-7802-a432-7ff5-412b4f3d0cc3@redhat.com>
Date:   Fri, 25 Nov 2022 12:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 16/24] drm/vc4: txp: Initialise the CRTC before the
 encoder and connector
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-16-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-16-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> It makes more sense to register the CRTC before the encoder and
> connectors, so let's move our call around.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

