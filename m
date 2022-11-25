Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3D6388C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiKYLah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKYLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCBB175AC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669375776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7B+glXPiHunh65c3ikcxd5Un328udBU6gxH6BbvNec=;
        b=Jm6VZNRUHvH1Hj/BvNFJCUh780V+BESN1f52M2RDzOeYvy5pMMKsIIvdIHMy8uvAWDsUtv
        w4vba3f+GvFSI4LFk0ZywW3GkssRHbAHCsOvp1fEfsuKc/uScdxQXjG+D07ibmnE+HH2uD
        0Vh0GXsBzOODWn1aNAiCZ9q0p2wiLBY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-v6BxeaeXO2-mtveGq_Daug-1; Fri, 25 Nov 2022 06:29:33 -0500
X-MC-Unique: v6BxeaeXO2-mtveGq_Daug-1
Received: by mail-wm1-f70.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so2296106wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7B+glXPiHunh65c3ikcxd5Un328udBU6gxH6BbvNec=;
        b=3Snb+lFthG4KZp5BDNjj5Z5vlr0TCQvzZTf6gg46X9gqgAFyH4m02+uH8JFkwnrs6v
         mMCBqHXfwqctheSemfoZ+llWIUy/nWRI6nlN+elqX/4akzhJfUS7Q6oUrRpjzBBJuedt
         GZknkNQ89TJZjoVo1KLqSTDbg5Tyrc65yPRBIE9gh3R3m0WAG7JLysyU4W2hAeoWUTre
         jt5twSSbqzy9DA8wO3G1Gsai246sfmyhyH1GbY2J+KJe4K3o4X95r5XBeZXV/+PLiO0g
         nAZexeMz78lA9Md6cW3e9mWiK0yeah5MTvUIjXR0RRjwNBBSnM+Xagu9VVw9VIvl5I3d
         +5aQ==
X-Gm-Message-State: ANoB5pmwjtxv5OIQ+oyomTbAUS/n686BxIoAWwVE9zwMvgF0s5ZTWsIB
        g0IKO46ByX2LrQy60tfftMtJ/dbOFL7F1+4Y8xChrwypQAb02WgOeXzNNfLmdelU+XKHpKjtMR9
        HGdqVCyTPmXZE1rURmbAc0Lkg
X-Received: by 2002:a1c:4c0c:0:b0:3cf:9881:e9d9 with SMTP id z12-20020a1c4c0c000000b003cf9881e9d9mr27524185wmf.6.1669375772042;
        Fri, 25 Nov 2022 03:29:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4tA122+galS8pDRgP2Y6iWuz67WbLgxFBL4oNYp0k+u30rTmKQtH54GX28s3piYeICYXfz4g==
X-Received: by 2002:a1c:4c0c:0:b0:3cf:9881:e9d9 with SMTP id z12-20020a1c4c0c000000b003cf9881e9d9mr27524167wmf.6.1669375771857;
        Fri, 25 Nov 2022 03:29:31 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d4e4e000000b002366ded5864sm3471722wrt.116.2022.11.25.03.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:29:30 -0800 (PST)
Message-ID: <05e6a16f-ee7f-1b9a-0ab8-5b042d60c86d@redhat.com>
Date:   Fri, 25 Nov 2022 12:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 18/24] drm/vc4: crtc: Introduce a lower-level crtc init
 helper
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
 <20221123-rpi-kunit-tests-v1-18-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-18-051a0bb60a16@cerno.tech>
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
> The current vc4_crtc_init() helper assumes that we will be using
> hardware planes and calls vc4_plane_init().
> 
> While it's a reasonable assumption, we'll want to mock the plane and
> thus provide our own. Let's create a helper that will take the plane as
> an argument.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

