Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A841661093
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjAGRik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjAGRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E9BF3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673113064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UoklNV81MeruvhksD2tLEyE1RirxLyKZBOM7SqghhQ=;
        b=PP4ck2B4xeP44YfZuB1LIRXJhN3wxLez9icHyqUz1hOHYppbXcBeLhowdxNqqiDnTHV205
        K6EHCZKUMJ5GExL1PfHXxyJi9iuyNphp1LUHYutCMZSNhRGbptnlDgE7ef0W2KZLDMIuvs
        Z2QbZmm9M7ME9H/NtiCZIerCHxCJAIQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-CPZgIF68NQKpyJ2QPUCARg-1; Sat, 07 Jan 2023 12:37:43 -0500
X-MC-Unique: CPZgIF68NQKpyJ2QPUCARg-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so4536999wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 09:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UoklNV81MeruvhksD2tLEyE1RirxLyKZBOM7SqghhQ=;
        b=fMIzTHrxIsQaAyXseKdzRY1/xx0wc8c7whckJauA+4s3mdLohjWP8ZdZ+aEf73eShl
         4YFvfVIuF2TTBfOgzlbXVUsRx03O7PWNH5HIXOSKEnRLFulL4r6vfx5jcYWOX9QutNym
         wM3922ToXyojHNt7b+q+zIbU6nUL/pSayJlqOPD2oB7Cq1R6ucbmHHDE1xKNspeHcULc
         Ze/QfFwC3MFouhccckDNYJLXBkMCOX/IcjLAVybsltcGbrQgOdM07foL404uulY/3HHM
         LUJuIERGfWehuJFj/07Ds1Ar6VqRdZCFS6zaoPa1Y68mY4j1atAUOxA7G9qkNeOe046R
         0hjw==
X-Gm-Message-State: AFqh2kp01Hn7+zGy6Qv90auOXMvEqEugO2jV4t+1PeiGMLscAXh29D61
        5lgHb1UlV+fXtxPz2YTSd6MdwG0VTsANyvwiduhvVmw9vJ42L3x4/CWVQh9VJ4rwadCaI8akLRR
        EMWJMbmWwq+bhUeKPY6ZrIGCG87bfRYl7z854Z/QYbNQZkmUilY3t6UUvbRjC8pgtaUW1uFoiET
        E=
X-Received: by 2002:a5d:5085:0:b0:2bb:de29:5c16 with SMTP id a5-20020a5d5085000000b002bbde295c16mr239687wrt.71.1673113061484;
        Sat, 07 Jan 2023 09:37:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuXSl8k0AQ+AaxiYKIpWccEMhElgIT4iXKymRjmLW3+uJy2TLemfEx8jQfkke3BL6dpkW4FoQ==
X-Received: by 2002:a5d:5085:0:b0:2bb:de29:5c16 with SMTP id a5-20020a5d5085000000b002bbde295c16mr239674wrt.71.1673113061253;
        Sat, 07 Jan 2023 09:37:41 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b002879c013b8asm4292158wrf.42.2023.01.07.09.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 09:37:40 -0800 (PST)
Message-ID: <033857f1-f52d-1fec-b998-a801b04a7033@redhat.com>
Date:   Sat, 7 Jan 2023 18:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20230102202542.3494677-1-javierm@redhat.com>
 <20230102202542.3494677-2-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230102202542.3494677-2-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 21:25, Javier Martinez Canillas wrote:
> Many panel drivers define dsi_dcs_write_seq() and dsi_generic_write_seq()
> macros to send DCS commands and generic write packets respectively, with
> the payload specified as a list of parameters instead of using arrays.
> 
> There's already a macro for the former, introduced by commit 2a9e9daf75231
> ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro") so drivers can be
> changed to use that. But there isn't one yet for the latter, let's add it.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

