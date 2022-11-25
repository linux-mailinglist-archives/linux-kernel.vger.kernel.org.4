Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF696388C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKYLbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKYLbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A1178A9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669375836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NAIt6DmSH0rxYc10/Lncuu2fhazNaRFZIsHf4ynJeo=;
        b=TTV8WxRVGWnBY3WZ2GLxH/8VdDUdknOsneVXKEWUyXaQRNcWNCmfeqoHsTOCbZRg/kTssU
        vS95HZY8+wDF11SDjWlMRYVITKHoHBFVL2/YiaddUmnWSNJLyT7jJpMBc67q/r5YRTddux
        ROIB7krT6N5sA+knLfwkPHaFJnOOb1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-e5nfF3hGMY-lrOdoa87OwA-1; Fri, 25 Nov 2022 06:30:33 -0500
X-MC-Unique: e5nfF3hGMY-lrOdoa87OwA-1
Received: by mail-wm1-f69.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso4075463wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NAIt6DmSH0rxYc10/Lncuu2fhazNaRFZIsHf4ynJeo=;
        b=pY/C+nF1q96Zv59HAMtV1vAvPnWYOZEAphLFoY4L1Cs2bGgCdVXcQoVSaFiCF9uwT1
         QKKwe3ENRyoMKfFSj3ro/3aKyqIcf+QV6B1y2nI2Xkl21bWYT6XJL222RN37rwRldDIU
         R+lj15/BMZuPsiXLa82pQe5j5LqKBHYrhizOKDoWOXAugUynUD4w03jT5h+9t1A30TrD
         Wb4brsNztM4JeRMvXFkYtPfzhBRVzNmPMp/QqgFjtTauxNUxo69VJKTANT3139e93GOG
         Lzxvqdpsur4SmXpwRzbetvl4kq/15NwIWhxwsK4KBRenEjqG5zTr1Km1D48j0M1ZSIj7
         rvyw==
X-Gm-Message-State: ANoB5pkFFh1jF05YYMMVF2vpnljWXX1i4ah7Z5K4zFZMy3MzYZ+3mw9a
        P6wKowt6PH80VpGV++r4Q0IaSOwBRz+6cdVXdmQLZ+I67mS0DSw/PUrlxzNhgPgw0GAyiXIN3an
        i2rdTw7Bvl03tThTjYV+mYD62
X-Received: by 2002:adf:f782:0:b0:236:73fa:c56e with SMTP id q2-20020adff782000000b0023673fac56emr16927462wrp.432.1669375831770;
        Fri, 25 Nov 2022 03:30:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5BqcPogGv74wKCFoPNLhym/zSZ5Ydptut3F8lISznnnvwUd9+tWysN/KklB3LvI2knnu0JgQ==
X-Received: by 2002:adf:f782:0:b0:236:73fa:c56e with SMTP id q2-20020adff782000000b0023673fac56emr16927439wrp.432.1669375831561;
        Fri, 25 Nov 2022 03:30:31 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003c70191f267sm9996825wmp.39.2022.11.25.03.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:30:30 -0800 (PST)
Message-ID: <323c8e02-4085-c46f-61cc-b9edbd902544@redhat.com>
Date:   Fri, 25 Nov 2022 12:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 19/24] drm/vc4: crtc: Make encoder lookup helper public
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
 <20221123-rpi-kunit-tests-v1-19-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-19-051a0bb60a16@cerno.tech>
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
> We'll need a function that looks up an encoder by its vc4_encoder_type.
> Such a function is already present in the CRTC code, so let's make it
> public so that we can reuse it in the unit tests.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

