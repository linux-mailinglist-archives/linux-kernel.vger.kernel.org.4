Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6612863D322
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiK3KTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiK3KQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:16:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C68C7E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxbB2FEXTvRF2CzuUkTWE4rFXxyela8ryo1CFsrhtF4=;
        b=Ilu7a2SO+i0LeScqUcu5bN0e6oxFILp0xY6uymxsTrxrpiTnJ3CHSsWePUwMJcX+APlU/V
        sEeNAV0H0ndS8XoOle4arHS3ICzg8w7QhZKQa+6aIn9aiBY+DTLTdYWljaMRTWfo3ansnz
        ZwX0zckvG+Z9J8+gMKzZl0k85YSEq08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-YikgaKWQNMWcoSAAwnYV3g-1; Wed, 30 Nov 2022 05:15:48 -0500
X-MC-Unique: YikgaKWQNMWcoSAAwnYV3g-1
Received: by mail-wm1-f72.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so461701wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxbB2FEXTvRF2CzuUkTWE4rFXxyela8ryo1CFsrhtF4=;
        b=1GWVTtihMOanv2QO6ajGZv1kZyvNdOBv/W8cP1g9WKg0qJhucVKfRQTJKROs3e5ahh
         NueTtrMhvsyZYWyzqm1whKTxivenPJzlkiTnK7Op0qfB1LjLVZFA2JQSs75DJS+W9foK
         CQkItijVmWsjdjUZDrvekcy0F1MseipPzb2usOJ2EXQjb/qEl/+Gdl8nmSYrf8OfQKVt
         Oy6MFL7K3ZKqW/pd5FI7arzQO1FLpJ+lEi46kfrRfAFOes6ffhQ5/7+o+Bvn5Z/3Sku1
         dJ53dL5/7IyqnkmHZUjGGP6pQGzkEYNp/EZDKproGehfgqjzFvBSK6HzHJSljY+LXJJN
         6BMQ==
X-Gm-Message-State: ANoB5pn42jrICi4w0YheCEBD2MlBh+ocAygHGQ6Kx4FNLgNYUOBxNLVL
        e1vfXkfQaHG4pjisBSzIvnE7V1SzVt/8N4qthDiPnEuGNT5P1WdsWEXk3/gbrTAHtd+CLbF7A44
        1glmwnoMoqVW6hPoCx4U1lA41
X-Received: by 2002:a05:6000:71e:b0:241:df3f:f5d6 with SMTP id bs30-20020a056000071e00b00241df3ff5d6mr25887794wrb.288.1669803347043;
        Wed, 30 Nov 2022 02:15:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf489Ao4FvIZrt2NmdFFZZC3lnncO3vTH3xWCwvBSPnOhZqxpghPRCNXtDB4BiPRHtQZXu9P+w==
X-Received: by 2002:a05:6000:71e:b0:241:df3f:f5d6 with SMTP id bs30-20020a056000071e00b00241df3ff5d6mr25887772wrb.288.1669803346802;
        Wed, 30 Nov 2022 02:15:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l11-20020a1ced0b000000b003b3307fb98fsm1397702wmh.24.2022.11.30.02.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:15:46 -0800 (PST)
Message-ID: <6222f13a-a03f-cf20-343a-e885f80cc4ed@redhat.com>
Date:   Wed, 30 Nov 2022 11:15:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 17/17] drm/vc4: tests: Add unit test suite for the PV
 muxing
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-17-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-17-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 15:53, Maxime Ripard wrote:
> The HVS to PixelValve muxing code is fairly error prone and has a bunch
> of arbitrary constraints due to the hardware setup.
> 
> Let's create a test suite that makes sure that the possible combinations
> work and the invalid ones don't.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Thanks for this patch. It shows how powerful KUnit can be for testing drivers. 

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

