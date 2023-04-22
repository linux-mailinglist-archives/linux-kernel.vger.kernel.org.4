Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF06EB797
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDVF1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 01:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDVF1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 01:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989D1729
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682141177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ZA/p0aXRTlXVY6YgSQMGx1MCcNGLE9UL/682DsXF4o=;
        b=gkY2dbkEYZINrkbznhAI+SGffhGt+0tQr3/0ep4sMsbXur0VTb20lkzUxV8b/oWid+tlZ8
        mxOmiLDqFGtcL/YXn/cR2J1QnctmUnPg5QBNj3UuWFeEB10iIMzALuvlRvoh/+7fbOkOiu
        LBkHUpteu/H+0926bMtfR5QMezuxbRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-oo8c4aKZOZ6w9r98gc4oNg-1; Sat, 22 Apr 2023 01:26:15 -0400
X-MC-Unique: oo8c4aKZOZ6w9r98gc4oNg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f831f6e175so1365921f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 22:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682141174; x=1684733174;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZA/p0aXRTlXVY6YgSQMGx1MCcNGLE9UL/682DsXF4o=;
        b=cyB6dYskp2qS09yk1pJFdzGhd4jF0rCYQeEtIrq8JsvLx9TYaHj6t+mYnGRhMtWoWX
         l5UH++nbl6yIJmGSB1BN67c8H8Z46A9ywEgVwgIzkbnScMBxNf4ESGwrlbnSyrTiKb9V
         jjQcW3i04QeZrf5iKgTJ+Wcx1rq3PfJsclPJnjY4W1SQYe9lrt+LXIMi1qFthLkUwRtH
         4Z4Je7pSLU/x9uPL5NrQ6j4pGvrOZRb967b3rrN+Qq0TpwV8XbTWyfq1sUXdT4XgTNll
         MlssBs5m3TiZ5Xcxb/NtvLaCGAFp2jnO26WuGYL70wBtvV7C4/0e38afmVWrIhBShTZf
         32PQ==
X-Gm-Message-State: AAQBX9e/9uCN+cqmYk6FXdScSxN5LWavc8Azp1qAyyjenP9w7FZI8Te3
        /v6slLnBK0vwipc89tkQaFolsjTdDeW4XfS7Qg1U4MWvEi7sn6QtuoEfSy0H+NJcuObo6IrUWtc
        eu1HVfolPm20FiqJpuJGLBNOk
X-Received: by 2002:adf:e649:0:b0:301:2452:e4d with SMTP id b9-20020adfe649000000b0030124520e4dmr5101657wrn.46.1682141174565;
        Fri, 21 Apr 2023 22:26:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350YE5Rv2hzCaPkKMr2CLb72/Tkmgn4waFGQCJg/qD17goV8xfbkJ1PVkPHDui/WEu4tRmFahhw==
X-Received: by 2002:adf:e649:0:b0:301:2452:e4d with SMTP id b9-20020adfe649000000b0030124520e4dmr5101650wrn.46.1682141174288;
        Fri, 21 Apr 2023 22:26:14 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003ee74c25f12sm9988052wmq.35.2023.04.21.22.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 22:26:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 1/9] drm/vc4: Switch to container_of_const
In-Reply-To: <20221207-rpi-hdmi-improvements-v3-1-bdd54f66884e@cerno.tech>
References: <20221207-rpi-hdmi-improvements-v3-0-bdd54f66884e@cerno.tech>
 <20221207-rpi-hdmi-improvements-v3-1-bdd54f66884e@cerno.tech>
Date:   Sat, 22 Apr 2023 07:26:13 +0200
Message-ID: <87354sij2i.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> writes:

Hello Maxime,

> container_of_const() allows to preserve the pointer constness and is
> thus more flexible than inline functions.
>
> Let's switch all our instances of container_of() to
> container_of_const().
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

> -static inline struct vc4_dpi *
> -to_vc4_dpi(struct drm_encoder *encoder)
> -{
> -	return container_of(encoder, struct vc4_dpi, encoder.base);
> -}
> +#define to_vc4_dpi(_encoder)						\
> +	container_of_const(_encoder, struct vc4_dpi, encoder.base)
>

A disadvantage of this approach though is that the type checking is lost.
Since you already had these, I would probably had changed them to return
a const pointer and just replace container_of() for container_of_const().

But I see that there are a lot of patches from Greg all over the kernel
that do exactly this, dropping static inline functions in favor of using
container_of_const() directly. So it seems the convention is what you do.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

