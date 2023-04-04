Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18826D5E05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjDDKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjDDKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4D30C7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680605293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsBHaVVv5Y3tPEgv/RqSi3oiQGMe5+5UDYih7KrcrZ4=;
        b=TPMSEhAvgWstMn8cBEt39yFomFg0U0RBj8y3KqAXp+83deus6MSJHIDCgzerlFNBUiyVy5
        A8EuSWattnbKN3rwUAwkjCA5o6h9DKLhMjCLX4JpTYn8bXlSK9C3Wq/fyXjHTsQg+uHAPc
        pMA/zaU85itZ/CHAIQj00F0ajqa72ts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-7tfNMNpSPOe8iA79hjfLpg-1; Tue, 04 Apr 2023 06:48:12 -0400
X-MC-Unique: 7tfNMNpSPOe8iA79hjfLpg-1
Received: by mail-wm1-f69.google.com with SMTP id o37-20020a05600c512500b003edd119ec9eso15913533wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605291;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsBHaVVv5Y3tPEgv/RqSi3oiQGMe5+5UDYih7KrcrZ4=;
        b=0p83g+fWvdh/4VNmnvpH9Hr26MlrKId/qk7iiyv+KbLr+NuPgLu2RGVGwpmKZ9ha5C
         EopW+sbJ3ss6Yj7kU7WVwcu2TA601uW93uUaeS1aCTOH7JaM7kY1bSaHpoJkUjY5LuH9
         dGn0Eaya5aOHcQkY25UV1f7KiXwuXJ5gRMZyv7Bn1Aew6AHOF6bbTwBf54d77G8iIQC4
         A9jYDAG7IqrJCVCW6P8xHwy1kTOJ4YbPymiJC9IUsYFiymyA1GBX44HW6N+wRVpiLH7O
         U8N6yF873634IWSDxzqPcG1v3CuLbP6gGdHL5fP1xv6Nr0RE6jNx2YBIW2wOTnioPM2B
         Ohqw==
X-Gm-Message-State: AAQBX9e8B3AL8omSjOjS7MiHtS7pK6zRCGcSQMKn7WQsQmOXqsN6c8yb
        OrGpxBFxH2o+whStfpVx5Xms4xVmKEPklN+ptgk3/GVZJc2IjFPU5nOjdNlLw9ykll7r0fMDIHS
        VnjwKuX1ihb76NzHdKnAt0EQw
X-Received: by 2002:a05:600c:b53:b0:3ed:9a09:183 with SMTP id k19-20020a05600c0b5300b003ed9a090183mr1846968wmr.2.1680605291187;
        Tue, 04 Apr 2023 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350bwUveWchAHYla+7cmT+EWiGjSCyodIdvY4/nYmDvD4WO77mwvF1r8B8Ciu+OtkZi1HCc00zw==
X-Received: by 2002:a05:600c:b53:b0:3ed:9a09:183 with SMTP id k19-20020a05600c0b5300b003ed9a090183mr1846950wmr.2.1680605290919;
        Tue, 04 Apr 2023 03:48:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p1-20020a7bcc81000000b003ef5b011b30sm14795462wma.8.2023.04.04.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:48:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <878rf8dksv.fsf@minerva.mail-host-address-is-not-set>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <878rf8dksv.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 04 Apr 2023 12:48:09 +0200
Message-ID: <875yabexee.fsf@minerva.mail-host-address-is-not-set>
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

> Sui Jingfeng <suijingfeng@loongson.cn> writes:
>
>>  EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
>>  driver.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

