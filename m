Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD8658DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiL2OgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2OgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949D12D2D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672324519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KePM8LGAehS8PxVf3em7bkMvOyCCyGkD1QJPFzoXjoY=;
        b=evb0+MHXl4X7BfSCvTX0+E86yeukqK/kOgvH+y3vhs5uyvbBf6tPt2DQXiQasc+TJfpM2G
        0UlDT0fHW+sz0yT4ZV+PkR8uUPQk7Inez+s031sRHR3gYqXxULRCCCka4Y+fmXgg86Z/HV
        z1jw/evvPN1cggBc8NqJ15PniOzrFo4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-Wq_qhN4YMCO089IIybe08g-1; Thu, 29 Dec 2022 09:35:15 -0500
X-MC-Unique: Wq_qhN4YMCO089IIybe08g-1
Received: by mail-wm1-f70.google.com with SMTP id c23-20020a7bc857000000b003d97c8d4935so5553739wml.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KePM8LGAehS8PxVf3em7bkMvOyCCyGkD1QJPFzoXjoY=;
        b=6fBuMGNwzMClGBKtB4QjZAUSDN3A1Fc/A8xq6ul55vihoR/QtLlaKtrXFsHzhx7dXE
         +YqsJiAL3lyerHYnW9wmkIYJlKNzlqt4NKTKnih2oR/Oo13e5nEvSvRg/kq6TNPZdCiq
         iFEGCiCr93R8SxiBlVS3o4HmeqsQlpfYZ3Em9N94j65r46QSG3afplT1dwai0pCeTsfs
         WbOlDBA52ivN5jfPnKCL47Co9r6+XQKeOAIvhdDkiTn7tJi6Eo/3PqfzF1wlkE5Hqljf
         6bfBgczhb0E7J6yTHZtHHRAnkwXiRZjSIiLu89qpVKHN5A80EZrJTyzKWvGLC2JbSOVZ
         y1vQ==
X-Gm-Message-State: AFqh2kp6Bcw/l5HXfjNxOQKE29EhvMSdW9FqdjXljNi6N55tNvIHJq8a
        /njf+9fc+7cweBVonUTA9hJ+zdpH0Ohb/EJzA6bbrB9W0OE0ME67NAI3ZZlFXMt9ARm9zF5MxRa
        pVYddkdh+5t+z9ldc7+b1xnjw
X-Received: by 2002:a5d:460d:0:b0:242:69f4:cb6a with SMTP id t13-20020a5d460d000000b0024269f4cb6amr16459187wrq.9.1672324514804;
        Thu, 29 Dec 2022 06:35:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuhgKP5nEJxUo1DwVlnSvFu/L2yowvsm+jGS3h9joQUDWOjQmxTMQckkrXQ+uhe+DCqYeOJDQ==
X-Received: by 2002:a5d:460d:0:b0:242:69f4:cb6a with SMTP id t13-20020a5d460d000000b0024269f4cb6amr16459171wrq.9.1672324514569;
        Thu, 29 Dec 2022 06:35:14 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003d1f2c3e571sm32813393wmq.33.2022.12.29.06.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 06:35:14 -0800 (PST)
Message-ID: <21fe5a6c-06f9-a902-6621-19c4a2a451ad@redhat.com>
Date:   Thu, 29 Dec 2022 15:35:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 01/11] drm/amd: Delay removal of the firmware
 framebuffer
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Carlos Soriano Sanchez <csoriano@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, christian.koenig@amd.com,
        stable@vger.kernel.org, Alex Deucher <alex.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20221228163102.468-1-mario.limonciello@amd.com>
 <20221228163102.468-2-mario.limonciello@amd.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221228163102.468-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mario,

On 12/28/22 17:30, Mario Limonciello wrote:
> Removing the firmware framebuffer from the driver means that even
> if the driver doesn't support the IP blocks in a GPU it will no
> longer be functional after the driver fails to initialize.
> 
> This change will ensure that unsupported IP blocks at least cause
> the driver to work with the EFI framebuffer.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Alex Deucher <alex.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

As mentioned, I'm not familiar with this driver but the change looks
good to me. Delaying the firmware-provided framebuffer removal is the
correct thing to do IMO.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

