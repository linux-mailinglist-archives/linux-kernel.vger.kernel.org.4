Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E73C6DAC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbjDGLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjDGLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F15277
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680866552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hH4U311j/Jsqa/Lz2ki1vR6iZrMlUESpjPBImXUbiAE=;
        b=RYL74NdujvmcjyibmRDgZrTVcH0MyuaC2gEz6QFmyOsA3I6r10GRDFyxrLSjmX9WdBG4Ck
        +w2y9N4JQlrFBexQZnCzqC2oTaN0neTSi2/ggvW4OfnhR4soCnYg1Mz6xGjyPDJ0CECU+2
        BreuPWXkEKMfOBMyTBm8ngDS57uRZro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-2Zf7pP39O7ehxmlvKZKOAg-1; Fri, 07 Apr 2023 07:22:31 -0400
X-MC-Unique: 2Zf7pP39O7ehxmlvKZKOAg-1
Received: by mail-wr1-f71.google.com with SMTP id bn9-20020a056000060900b002cfe8493fe6so5181489wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680866549;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH4U311j/Jsqa/Lz2ki1vR6iZrMlUESpjPBImXUbiAE=;
        b=MSXd1ua5++zXzLxrmtdwHi+veovCxs6MZvTIGvCEZUjvcoiP5+W2uSJEdbva/j47fD
         4hHHWlCSUi9Mz6Lxx5AQl08KQ+BrNoK8Qxm4Jyg+gEyeR7cdjwF7gclShEur+CUk17Vz
         CE+QAwwre0DIjrlo3FwbH+O3GqVlwNyKUsmclc/aRmu/3MEIkI7+vDy+xEQEz/jBQYZm
         qiVJc3pH/W4GVo9VpIAMNk9dDZgmm5rMT3dCm02wnLdW6nA6S9OcJuIkT/96ZDfnzMsR
         dzmTgmvZ5gHJrkCnxhRMsl1MazjzPWsdPHKLCqpXoTgiroO1I/P1cJvlP0ICxKC+wkXR
         nT5g==
X-Gm-Message-State: AAQBX9c34LS8hyl1kDsekDSxaVVNuMfNyCEL66Wh3U1c/qvW0AnLA1ak
        eR9X5WNS0p6nGmMBPHDE6K2O3QTj08/TqB/R+3wunMqq3ySxv8oksIsW1e98ITBG58zGKBiNuTz
        XIoDdv/DAoLYAR5txOgFh11aeqOd7IjSJFRJOeO/K+dKtkRXBabUaSw+plrCzM3JT6leWQplw2b
        GzB+WV68I7
X-Received: by 2002:adf:fb83:0:b0:2c5:5a65:79a0 with SMTP id a3-20020adffb83000000b002c55a6579a0mr1266519wrr.53.1680866549728;
        Fri, 07 Apr 2023 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZoXdyDFp/08AQ2n3ydTt4/RdllFrwf07aFzR19kGeao0DxT1onEBIG3ePDCokvXC+kvLlMVQ==
X-Received: by 2002:adf:fb83:0:b0:2c5:5a65:79a0 with SMTP id a3-20020adffb83000000b002c55a6579a0mr1266495wrr.53.1680866549380;
        Fri, 07 Apr 2023 04:22:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm258556wru.87.2023.04.07.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:22:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/vkms: A couple of trivial cleanups
In-Reply-To: <20230406110235.3092055-1-javierm@redhat.com>
References: <20230406110235.3092055-1-javierm@redhat.com>
Date:   Fri, 07 Apr 2023 13:22:28 +0200
Message-ID: <87wn2o6iob.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Hello,
>
> This series contains two trivial cleanups for the vkms driver.
>
> Patch #1 just gets rid of a wrapper helper that wasn't really adding that
> much value and patch #2 drops the <drm/drm_simple_kms_helper.h> header
> that was only used to call the drm_simple_encoder_init() function helper.
>
> Best regards,
> Javier
>
>
> Javier Martinez Canillas (2):
>   drm/vkms: Drop vkms_connector_destroy() wrapper
>   drm/vkms: Remove <drm/drm_simple_kms_helper.h> include
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

