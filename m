Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32CE6A5CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjB1QLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1QLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:11:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B32129D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677600665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7IBO5aYl69umpGyTeyvZekqQInZMv1t8j+p55wYs/4=;
        b=fTNvFVpzba55EzMS823/EqgX4pR26YpfuYQI7Fqx0MzXbVtrfMl5ImjdSNKJ/ZK3eFm54H
        Z4obwvsbcdnEyleism4IYQmLamEQ+aCLtRfX+m+4bHoY6+rWxdqxLsm6sPHxxXCw9Ef+Jy
        oi/nv6q3IcLhPf4HI2EasowYXyGSNl4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-xe3GfWjfNBa08cPXzckM-Q-1; Tue, 28 Feb 2023 11:11:03 -0500
X-MC-Unique: xe3GfWjfNBa08cPXzckM-Q-1
Received: by mail-wr1-f71.google.com with SMTP id o3-20020a5d6483000000b002cc4fe0f7fcso1005671wri.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600662;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7IBO5aYl69umpGyTeyvZekqQInZMv1t8j+p55wYs/4=;
        b=aMnqfTlw6VYSlvD+vu9AeafWXyCJnKN5uwzfah3D7H0+t1e1Fm98mujQsAWK5cUbgP
         atASCF0WS39LBXgZelDjBWnm7ukJ3yF61FjPWASZJE7j4Z5aCzDekZgsCJyaDHhoS84v
         Yeuy0tPl1lcvOFIKu4Uscm9/sNXl5g0cJd5hc6El9uipZ2pKw/uArTYPmSMQuB47E4ih
         K1tddaTWXHmVkJlLANCT/fZ16bAm7sw5h4stFAN1GYX5BQ5IKj/Lzl4bUdhcA1MGToIR
         a+6UJptk/pwL8RRsCiiw2joj5fC3QH+eFZaLwtOCtS5ngCVmJWuEYmW/QCWka1xnrTyN
         2Iaw==
X-Gm-Message-State: AO0yUKWlxd/pE1yoYOQhCvMWokhbWP4GKyIP5BVXPHrEHKYgfDWtE3yy
        Hs2ltKTfWXttNXyW/oTpSVZ+coRWJ4/gQhVjgUVF4t15RcK3ozfay4wEjj9ORSZ6GRNp7GNlm4t
        hqkFax7nCWUGBXhDnwAlkX3t1
X-Received: by 2002:a5d:6542:0:b0:2c7:434e:9a5a with SMTP id z2-20020a5d6542000000b002c7434e9a5amr2710709wrv.65.1677600662599;
        Tue, 28 Feb 2023 08:11:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+C4Sx+1qgWlESMbjldUwgs92cnO8HMzCf0I1Pku6si91VTDTWk4Zh3ewsOtCPt8aCThrr3VA==
X-Received: by 2002:a5d:6542:0:b0:2c7:434e:9a5a with SMTP id z2-20020a5d6542000000b002c7434e9a5amr2710693wrv.65.1677600662295;
        Tue, 28 Feb 2023 08:11:02 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm18453097wms.18.2023.02.28.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:11:02 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Ryan Neph <ryanneph@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4] drm/virtio: Add option to disable KMS support
In-Reply-To: <20230228155406.2881252-1-robdclark@gmail.com>
References: <20230228155406.2881252-1-robdclark@gmail.com>
Date:   Tue, 28 Feb 2023 17:11:00 +0100
Message-ID: <87bkldhisr.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Clark <robdclark@gmail.com> writes:

Hello Rob,

> From: Rob Clark <robdclark@chromium.org>
>
> Add a build option to disable modesetting support.  This is useful in
> cases where the guest only needs to use the GPU in a headless mode, or
> (such as in the CrOS usage) window surfaces are proxied to a host
> compositor.
>
> As the modesetting ioctls are a big surface area for potential security
> bugs to be found (it's happened in the past, we should assume it will
> again in the future), it makes sense to have a build option to disable
> those ioctls in cases where they serve no legitimate purpose.
>
> v2: Use more if (IS_ENABLED(...))
> v3: Also permit the host to advertise no scanouts
> v4: Spiff out commit msg
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

