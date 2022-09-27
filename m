Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F505EC194
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiI0Lg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiI0Lgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87041449D5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664278610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoQe3mHnQYoYlajKMGO7Dx2ZrN3SElKzFqBGu4p1Rsc=;
        b=Dh8p/QR6dw1GSxpJIxpYx0VRh4HPFVFaBS54uW1L5E7XAI1yKM5TLmL3TuEmDP0oCZlSOn
        PDGj/tujYSyGw1jAN8thAtXJz6UvP08MmAZtXf4xwyNvZsDxyh9PI7MrSURX0N6FcASfBn
        PH4U4eE2sjKDWVtlLOvqOy3n1BddQm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-gZWp9wisMwe15h7_KCuhMw-1; Tue, 27 Sep 2022 07:36:49 -0400
X-MC-Unique: gZWp9wisMwe15h7_KCuhMw-1
Received: by mail-wm1-f69.google.com with SMTP id g8-20020a05600c4ec800b003b4bcbdb63cso5421250wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EoQe3mHnQYoYlajKMGO7Dx2ZrN3SElKzFqBGu4p1Rsc=;
        b=OUw8xbcA6N09HmvGf+BQ9V6YTWu8vA8giNdWP8mlrR4QCUkrmG8wQk1baSOCDvZFZl
         TvpnaYPt7b0lBgj/mzUYhNkgmBgXQ3+cfqgzEKu01omF6Yqtupc0AdXKBryblmTlE6g3
         yq/BIJewwu4jy8ig8FzyvQ8Q+AwJvCO6vUMYodKMu8gJk0xTviH65blzXzNL9rOlbOM0
         4I3kfj+RMfwLRA1PVzryCvgFrAA9WMDA2uzUsMoXFhxkjOSImylUHKzhqRrDF+rTFwEe
         K2PwExRh7bbGh5Z/l/cWXq+I7kBmlCEMJjwRhDb3EaDJGxvMiv9pGbgKEln1nCam4Enk
         fDzA==
X-Gm-Message-State: ACrzQf2HEAkDRn3WCsbISGl9AwzW2nDV3AZ/MD0Xa4OlHj8FVeWiTpbo
        OjgzX900U2zD7wzXmpwUmfKsffwPS6Dd8R00AZwl903aViKVJnzQlMcsxZEAqCGDbU+zS766slz
        br/wK3bErvwSCZtHmI+sUBfgq
X-Received: by 2002:a05:6000:178e:b0:22b:451:9f63 with SMTP id e14-20020a056000178e00b0022b04519f63mr15895501wrg.521.1664278608349;
        Tue, 27 Sep 2022 04:36:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5aRKpUsAhOykOk2Jxp+/Ojmr91lbVAF3k9VyYwNBaAklCp5COwFMiCEfMmUrrqWwr8i/YAZA==
X-Received: by 2002:a05:6000:178e:b0:22b:451:9f63 with SMTP id e14-20020a056000178e00b0022b04519f63mr15895488wrg.521.1664278608138;
        Tue, 27 Sep 2022 04:36:48 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y1-20020a056000108100b002250c35826dsm1491711wrw.104.2022.09.27.04.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:36:47 -0700 (PDT)
Message-ID: <21ce0011-4ffa-d229-404f-58f98aba5860@redhat.com>
Date:   Tue, 27 Sep 2022 13:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Synchronize access to dma-buf imported GEM
 BOs
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20220927095249.1919385-1-javierm@redhat.com>
 <bd64206e-4d67-6932-30c2-740237a05bd0@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <bd64206e-4d67-6932-30c2-740237a05bd0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 13:18, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.09.22 um 11:52 schrieb Javier Martinez Canillas:
>> Synchronize CPU access to GEM BOs with other drivers when updating the
>> screen buffer. Imported DMA buffers might otherwise contain stale data.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

