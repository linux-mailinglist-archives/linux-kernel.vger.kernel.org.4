Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90FC638589
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKYIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiKYIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5066275DB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669366235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCa5X8lXlExaGphI0WGFeQw46HpXtfvTpixratHZyiE=;
        b=B3Lh+NtPg/yvsm5mOnBrZzbuAWTquVHGKL5wg1PJiufqANb6kdhDa3iYRZsycsoqXK4+Ik
        KkIM4uiGN3A4er9AiBRxiPlYtLr9PUMx/pEr3obNfGapjRFUAtMy+RlNBkYs7ld24FzeiX
        HyNvdApubs6CW4gmG6Ivfm494iQOSus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-g2FjUN9JPhekY7p4RMWW5A-1; Fri, 25 Nov 2022 03:50:34 -0500
X-MC-Unique: g2FjUN9JPhekY7p4RMWW5A-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso2129516wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCa5X8lXlExaGphI0WGFeQw46HpXtfvTpixratHZyiE=;
        b=fztEEFsu837OP5KDdmWQD9N9GKMGDYm2EVRRtXd3WabvTfgq3oIfArhe+VRAgom4vE
         7xAEVIKVpo7/gBJHUG4ecYTs/PIZ57OMCFf8uYGOJK+b2zyImnEYc1NbsVSFHADK0n9a
         bhuAMWDihqxX8ex32+sHDPcDsQVDQTx6uwsKajqaxwHrTuTXC9OAWCyOuy8jF+U8RCo2
         ivm2P1uFeAwzYmxJMiDbm+vwjjOUFGeQiQ9OJYZ3vDvqcfyZC1t7OkxHGisdSG9X95Q2
         7HMLnTH502gG85ODTyejCgjslm7eQDzPSQ85ZLuI8395uEDF/85iAww2VU09YdHbU2M5
         xG8A==
X-Gm-Message-State: ANoB5pnx8qP57CMB9q+Y0pvSFiAcX1/KznjqxXn7a23iaGlsTi/jVHJG
        FDjDLoLyzgk7hbUFQ9Lz2pUnkVsYY+Sw1WSuObF8hUnBUvnn76qk8rlTaY5v6pgrryQq1msJayp
        GJ5lY4GkX+lE0kchXWgo8Uew9
X-Received: by 2002:a5d:5305:0:b0:242:25e:e731 with SMTP id e5-20020a5d5305000000b00242025ee731mr2642371wrv.48.1669366233209;
        Fri, 25 Nov 2022 00:50:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6mov6a1ABQsKCpweMfuKZj8FtStMvwn4E4x4v/bkoJJVxviE1bsUHgijhFDEI16xW3gYv3qw==
X-Received: by 2002:a5d:5305:0:b0:242:25e:e731 with SMTP id e5-20020a5d5305000000b00242025ee731mr2642344wrv.48.1669366232940;
        Fri, 25 Nov 2022 00:50:32 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003cfd10a33afsm8890236wmo.11.2022.11.25.00.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:50:32 -0800 (PST)
Message-ID: <2517016e-1b31-b821-df0c-8c0498f11719@redhat.com>
Date:   Fri, 25 Nov 2022 09:50:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 01/24] drm/tests: helpers: Rename the device init helper
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
 <20221123-rpi-kunit-tests-v1-1-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-1-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> The name doesn't really fit the conventions for the other helpers in
> DRM/KMS, so let's rename it to make it obvious that we allocate a new
> DRM device.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

