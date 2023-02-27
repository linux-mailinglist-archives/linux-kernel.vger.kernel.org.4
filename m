Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08866A3E23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjB0JTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjB0JTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B120BBE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677489209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIyjUN1UbHRo/+M6TptOIJTprO+3djrqyy4P+Xz3UPg=;
        b=QYO69H5c3M5M9zxBFn8byIXEWGdtygbypc9W0aLqpLKYRHRrVvd+io6dxA4F6tsMj5gHiU
        WVVRQzgIZbXNlf9As8m1hN3cAxiuSDQemtK3GU7zjB6kM8GD0PzrBXeb11WOstIxCk9FSl
        zEhTBf97I12SCvtDb3DBZSqI8UOjLM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-adTIqwf6Miy89sjYV_tqTQ-1; Mon, 27 Feb 2023 04:13:27 -0500
X-MC-Unique: adTIqwf6Miy89sjYV_tqTQ-1
Received: by mail-wr1-f72.google.com with SMTP id i18-20020a05600011d200b002c94d861113so577436wrx.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIyjUN1UbHRo/+M6TptOIJTprO+3djrqyy4P+Xz3UPg=;
        b=tLgYF23/HfE06hS1xmBlwcgkdUqGyp5LhFb/m/hgxmGbaNsK5qUExP4zWxRAW9m4D7
         y/8btB/lPVEzWUxUVgI02oWj0PrAHRl57RXxxlM8RMcauQIAqmXTgUz0h01jtPqtzvEA
         TvvxXXCMtp40btNsUf1aUERBCy02EzDHzaEsAbN1jCMW6LoD2K/axK71v+9WZVyDsz8x
         Ub6QhdVHi5C24+PybtoHlGI7cQ6ef5bZou5n8q0BOWRQ2wnPXo2wI4W2JYZx2XPcx4D8
         IZEouitRV5VbC6Jnn0N5TjizbCP8KDwY1q/SylJvUeU2DYdYe3hJVIDWFRT+f1OwEYPE
         4uGQ==
X-Gm-Message-State: AO0yUKVXc0+pNQ5FRCE/6K/pwQsZInJswYOopdv0IwiBuv2dJNEQVHkJ
        T60TnqkUaLo6ZZvqVEJqTQAyI4hKjYwQaAn2DPvoNJ7GXXDV+cM+aK8uuQLVAJA4nYlU5lrhwG+
        vaNwcgC6+EZiF6ImR8iQspiDx
X-Received: by 2002:a05:6000:1d95:b0:2c5:4f45:90b0 with SMTP id bk21-20020a0560001d9500b002c54f4590b0mr5025682wrb.3.1677489206187;
        Mon, 27 Feb 2023 01:13:26 -0800 (PST)
X-Google-Smtp-Source: AK7set+ltcLyJInrrDgWgB4dDuQf+eIs4MmOwJbJlUO44QBOpiD5QEgz+EhE3kPKPRMGvVtbttqb1w==
X-Received: by 2002:a05:6000:1d95:b0:2c5:4f45:90b0 with SMTP id bk21-20020a0560001d9500b002c54f4590b0mr5025673wrb.3.1677489205848;
        Mon, 27 Feb 2023 01:13:25 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b002c3f81c51b6sm6474293wrc.90.2023.02.27.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:13:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/shmem-helper: Revert accidental non-GPL export
In-Reply-To: <c94a0b2c-f061-3030-ecb7-abf0a16faa1d@suse.de>
References: <20230227-shmem-export-fix-v1-1-8880b2c25e81@asahilina.net>
 <c94a0b2c-f061-3030-ecb7-abf0a16faa1d@suse.de>
Date:   Mon, 27 Feb 2023 10:13:24 +0100
Message-ID: <878rgjh3nv.fsf@minerva.mail-host-address-is-not-set>
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 27.02.23 um 10:04 schrieb Asahi Lina:
>> The referenced commit added a wrapper for drm_gem_shmem_get_pages_sgt(),
>> but in the process it accidentally changed the export type from GPL to
>> non-GPL. Switch it back to GPL.
>> 
>> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Fixes: ddddedaa0db9 ("drm/shmem-helper: Fix locking for drm_gem_shmem_get_pages_sgt()")
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Thanks a lot. I'll add your patch to drm-misc-fixes ASAP.
>

Thanks for fixing this and sorry that I missed it during review.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

