Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64AC679509
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjAXKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAXKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA533D08C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDZ2X6v9gZZjw/mylSeu05Q/SHm7XIRiCSfNoQKcE4s=;
        b=IrTaEO8b0t6KUBDYMvG20sfER7pUo/QBK3ILhY1ZCc4Gnk+SwhZa0EvEjBk6SfVDm8tkh9
        wxqgqJFhdsMwMUKKgb9tFcfmcoFNqHHKr4d7kxvYcu2sPcl+nGAg5yU0bgjlgkyuDppkLT
        Lhir3ZkpN1ZWWK3JmWwB7Hd46n8lOCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-g5UD9PdvNkOt98y9Lkl1Ag-1; Tue, 24 Jan 2023 05:18:51 -0500
X-MC-Unique: g5UD9PdvNkOt98y9Lkl1Ag-1
Received: by mail-wm1-f69.google.com with SMTP id j8-20020a05600c190800b003db2dc83dafso7549931wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDZ2X6v9gZZjw/mylSeu05Q/SHm7XIRiCSfNoQKcE4s=;
        b=oE3+6H8EQB6u6suliefoFKoVq/k5VFE8X2hQWkx51gtSV5fNReRxAqkPemVwws8m1y
         uy8OFzVIiikvo8YVJvNKIUucxjGAtENjSlvg2EmKeLjg3ma18ukItnZ65v3rYI/Cs+77
         Z7r+H1uG/wQRMqd7/RPKEU5SNV7BYL3Tvzuh5Xib0peO85Tc1xL45Z8nHgPkbEBMubrN
         YH/73dUbf338ulUzTkKr3qu8RJOTSQal/8bF9SYzsrkmqUpviqzGhLoFr+V/YzGMr4iS
         URQZWr0UR65CTiGf6EG6NtS9ZjkXZ0KEqIpha8icgLFEWaTdCDHDm4proU2/rpoks9JX
         GOmg==
X-Gm-Message-State: AFqh2kpZm2CP6UyzcZUL5/WBbH0RgbJq5lRZwwbiRq3yDjavRf7l5cse
        vMJVFUpqhnKqBBm+qQp7Qsc870pZEdnFQgkdb3q41/HSwKd5/4n5Nx9B+v0dQwt9gijD9sWhcfT
        ZJSZaxaxRBUVERV6NAw34MjrrNF70xbCV042qbRMSoFj2omsUQFHFLvEuBS9lovCSZhEaRNS0gL
        Q=
X-Received: by 2002:a05:600c:3d9b:b0:3db:1afd:ac36 with SMTP id bi27-20020a05600c3d9b00b003db1afdac36mr20999548wmb.32.1674555529894;
        Tue, 24 Jan 2023 02:18:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu8zqFziGgSNsVTa/vJxE+MIl3zeqyq4trWRM1k2BTskMl0Qm00LweTGrV0W3Enfm9oMajDIA==
X-Received: by 2002:a05:600c:3d9b:b0:3db:1afd:ac36 with SMTP id bi27-20020a05600c3d9b00b003db1afdac36mr20999525wmb.32.1674555529610;
        Tue, 24 Jan 2023 02:18:49 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003db0ee277b2sm12997027wmi.5.2023.01.24.02.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:18:49 -0800 (PST)
Message-ID: <1ae9b489-4afe-d6ce-e055-9a6fd518745e@redhat.com>
Date:   Tue, 24 Jan 2023 11:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] drm/fb-helper: Check fb_deferred_io_init() return
 value
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
References: <20230121192418.2814955-1-javierm@redhat.com>
 <20230121192418.2814955-3-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230121192418.2814955-3-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 20:24, Javier Martinez Canillas wrote:
> The fb_deferred_io_init() can fail and return an errno code but currently
> there is no check for its return value.
> 
> Fix that and propagate to errno to the caller in the case of a failure.
> 
> Fixes: d536540f304c ("drm/fb-helper: Add generic fbdev emulation .fb_probe function")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Pushed this to drm-misc (drm-misc-fixes). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

