Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BA725544
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjFGHSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFGHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08387173B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686122238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8ZRfR4SbsRmuStbxG9wgKBb6rXoxZXDXcGM0Hiws6Y=;
        b=YFonmdq7SjuXomE8iV0XwkqH2Wsu2nnynHUVs07wPZRUCj0yJL8S4x2erRFmbPPVXF85rj
        q2C7Zg/F6hUgGWHKHZUGZHHLYJ7GXqISKeIToa/QWEKPSpfDFCeR5FdfgNIXNKRDPuAJCk
        gtrJMgcsugAlL0tP1sGFg5js/ioEYak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-WVvjZDOwPX2vNUmpJx2efQ-1; Wed, 07 Jun 2023 03:17:16 -0400
X-MC-Unique: WVvjZDOwPX2vNUmpJx2efQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7678c74beso20056565e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122235; x=1688714235;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8ZRfR4SbsRmuStbxG9wgKBb6rXoxZXDXcGM0Hiws6Y=;
        b=DyLLcEq7j52ba1UDQytPIZZoXUg8H9PCZs/ujkBc9RCuDOMcH/H7KH1SUw7LzeNW0l
         Q02nzcywVUzzqWU1EI7lqnJ2HByqLvf77Gitag3yFFm5GLppaP1Uy7dCYO5jYURjgWo9
         dwpPoEl6BMo5/srdl1FqQbNO1Y7ILaZhUwxr1BWanVxRHEYg16dZC1xfKVOIerFuwuAI
         9ut6Cs/uaq1v86LEJB8SY6P3MoEKXCQdhwZArxlFJoBxboBvR+OpWdzZ0sEkkIxrLACT
         7GwbTiZEvKLRozUO7LrE+gqSytClFl6WzAWr1XBVdkEcnSUUJnu145tg0O466flXL0IE
         cXrQ==
X-Gm-Message-State: AC+VfDyd3OCTvIIUb9ziVsxweLAnw++kzi5o1a2ySehTPzNGKfoiihtZ
        kGwadASgn2GZBDkY3mzFVVsl7A3yiA06y5+eahOYqrSIaEHJ/7Kog4QKUXGyyOt1eyxnvWoyYAG
        qnC5ef1i+dZ8QkYGAXGFVv/U9
X-Received: by 2002:a7b:c7d4:0:b0:3f6:117:6ed7 with SMTP id z20-20020a7bc7d4000000b003f601176ed7mr3883284wmk.35.1686122235551;
        Wed, 07 Jun 2023 00:17:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+t4ruO68j5xRFuJyfpOU2/snN7eVdCEGUlFwfIVjPMhRolkXR3gPuON67Rkmj4YBG7RPArw==
X-Received: by 2002:a7b:c7d4:0:b0:3f6:117:6ed7 with SMTP id z20-20020a7bc7d4000000b003f601176ed7mr3883273wmk.35.1686122235304;
        Wed, 07 Jun 2023 00:17:15 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bcb89000000b003f72468833esm1113666wmi.26.2023.06.07.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:17:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/5] drm/ssd130x: A few enhancements and cleanups
In-Reply-To: <6b0a12bf-a8d4-43df-860c-3aa271cfc624@suse.de>
References: <20230605074753.562332-1-javierm@redhat.com>
 <6b0a12bf-a8d4-43df-860c-3aa271cfc624@suse.de>
Date:   Wed, 07 Jun 2023 09:17:14 +0200
Message-ID: <87edmnhhc5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi Javierm,
>
> I've read through the patches and they look correct to me.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks a lot for your review!

> But I had one question about the page size. You round up to multiples of 
> page_size in several places. That could lead to an out-of-bounds access. 
> Do you need to allocate GEM buffers to be multiples of page_size as well?
>

That's a good point and I would need to have a closer look to the driver
to determine if that's needed or not as well. If that's the case though,
the issue is already present in the driver. We could fix it as follow-up.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

