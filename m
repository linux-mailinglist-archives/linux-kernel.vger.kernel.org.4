Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD67C6388F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKYLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiKYLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689A1BE8E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669376490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOhIdeO2viHCtBqTf2iYEwnXDI6Ezk/3Vbjgspkc6Ig=;
        b=KBJ/+nUngYjIimzyazzf5IVEMZCVzCdGJ7vdH5xJ7P3qPXAMy3aXNHdzlpJPrGmX38QgY2
        uBPtmCjCvi7LRXHyVHThZTB4vLhNgNLqJ/Pbbz7lh+Z3lobrO3IJ5OpLqW8Fo39bCFxVoc
        E3tpuG1OxqlwfhlyR3flGIIknkODh9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-e-dOen_SO8eWVX3CFGB8tw-1; Fri, 25 Nov 2022 06:41:26 -0500
X-MC-Unique: e-dOen_SO8eWVX3CFGB8tw-1
Received: by mail-wm1-f72.google.com with SMTP id h4-20020a1c2104000000b003d01b66fe65so4087284wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOhIdeO2viHCtBqTf2iYEwnXDI6Ezk/3Vbjgspkc6Ig=;
        b=GpoyQek9++OPTp8H8pEj9w63vxJoqlZulGB1nW2W6WdB4P6cYFad0i0QGfif1OpocP
         s0FLBrkuWfJMWufahfvPJJ0mCc9ywgGisF4aMs3ocqiGRj1GsSIIAE/64K9juaE/vgvi
         LbtMcHW7+F9ztD7jrXJBwaxIlRJT5wfUge1zwc88WgyO6Jbu8WDVje9ej+GhkVCZN0Bp
         jDENzyf6h6H//n1KUrfuP3lPHd3rh3pY3Zs5VscVXbRDYmot54Qd9KEQPV94/l/9OVtX
         vAaYnXwbIE49T3GZXCYWudJ0CUXZS9HFUIRMExAIv2eyez1lcgRs0zE7rzZD0OUyXXBq
         B1cw==
X-Gm-Message-State: ANoB5pm8Hqu/cQUMKhJOOxRts8b9v2xbpErQfNXk5gO5wbmh/+jqyySV
        +VMShEazY/3W7Wtu0o4eFaZlnINZNhhE6BB0DLX6thfuV6gOfOi0q9yIddBlXk2ml+Js+vWVbkQ
        i5+iEpX/nr2NHHqT8V+cUC/9Y
X-Received: by 2002:adf:e34d:0:b0:241:ee4a:2301 with SMTP id n13-20020adfe34d000000b00241ee4a2301mr7222669wrj.429.1669376485538;
        Fri, 25 Nov 2022 03:41:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XK7j/pUPAtmTo6t54sJnnyf1J8fqURJI79qjd/c5yPhwa217razm52j8W7b414NZu8YvG6w==
X-Received: by 2002:adf:e34d:0:b0:241:ee4a:2301 with SMTP id n13-20020adfe34d000000b00241ee4a2301mr7222654wrj.429.1669376485339;
        Fri, 25 Nov 2022 03:41:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id he6-20020a05600c540600b003cf4ec90938sm4846070wmb.21.2022.11.25.03.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:41:24 -0800 (PST)
Message-ID: <a39d6b1f-a496-d293-8f27-c17d30d6c0b5@redhat.com>
Date:   Fri, 25 Nov 2022 12:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 21/24] drm/vc4: hvs: Provide a function to initialize the
 HVS structure
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
 <20221123-rpi-kunit-tests-v1-21-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-21-051a0bb60a16@cerno.tech>
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

On 11/23/22 16:26, Maxime Ripard wrote:
> We'll need to initialize the HVS structure without a backing device to
> create a mock we'll use for testing.
> 
> Split the structure initialization part into a separate function.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

