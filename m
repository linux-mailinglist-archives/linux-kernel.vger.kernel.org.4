Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516716B4067
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCJN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:28:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A481744BB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678454867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oDoMqLVnOuZxZgE4flgShP8OtqI4S89KmGHHiU1L20=;
        b=GydziM5ZFVJAK1IxKIwSiUdYQx81b1dMcuIPCO6u/nteKItWWBHaqiKzBzvAoppA0Xi5Bn
        X7eRhQLUIhNnWNG8StWu35c83VVV8no1KS3LVkV/sglsQEYeb6iH0+l03WG/qYk0pdi7ZA
        qnYFifAniPkxjPXG66cqniC8foUYFm8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-PQv2-mPmOLuVsr7p6MwrEQ-1; Fri, 10 Mar 2023 08:27:45 -0500
X-MC-Unique: PQv2-mPmOLuVsr7p6MwrEQ-1
Received: by mail-wr1-f72.google.com with SMTP id u5-20020a5d6da5000000b002cd82373455so1050812wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454864;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oDoMqLVnOuZxZgE4flgShP8OtqI4S89KmGHHiU1L20=;
        b=eRhMLv9XPysd+QwNaXkQAARFfiOsvMnvqYEAuPN1GNANK8+sAf85XEA+cWqn9rNOMM
         F5yUaTdfA1CY6pvhiontQApUOXEwjQlxrJ1LnqLzMzEdfFTJR3u8YC+lueJGe0Hwidn5
         I4C+Er6wMD1LfZFZmc5pM7wDH0yBQssiuZhHJbQPiLH33I3KkJBw7FXDPKM1YQW7psts
         Tn10T6lgQvsPQLHpLWC9XsuFTsXXHXWet0XnMtACH9uNIyFivLUYhZHKlc2DHitisErQ
         qFKUNbRikTWR+Cdqc/z6Gd7K8Gv4TPubvx2BL0Ow7UQOCNZ+sCVRtDAOB8Tp5QrxhE8f
         OE/A==
X-Gm-Message-State: AO0yUKXhSrxqbLN2O/BjbvKOc5ZQRP6XlHwNFy0T7Oblkw946MhrL1Ng
        rLclJhhdEXTFv6Segd9k9cawKv/6kLcTJDahjvg0aDl9rDTT8ipACR/FCsMBXtnluF2P52gCUU5
        vmg4O3rC45kXut0ty+Oo1SUYla0KJul6H
X-Received: by 2002:adf:e5cf:0:b0:2c7:e60:abe8 with SMTP id a15-20020adfe5cf000000b002c70e60abe8mr1364267wrn.9.1678454863885;
        Fri, 10 Mar 2023 05:27:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+/F5VlfIt9oBwbVxs0Diw/+nCO6V0/XYKj4aznLE1oCJqsevDI6s1JsyAlPJIAU5Rh/oqB3A==
X-Received: by 2002:adf:e5cf:0:b0:2c7:e60:abe8 with SMTP id a15-20020adfe5cf000000b002c70e60abe8mr1364253wrn.9.1678454863604;
        Fri, 10 Mar 2023 05:27:43 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003e2058a7109sm3339325wmq.14.2023.03.10.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:27:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Bilal Elmoussaoui <belmouss@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Christian Hergert <chergert@redhat.com>,
        Albert Esteve <aesteve@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] drm/virtio: Enable fb damage clips property for the
 primary plane
In-Reply-To: <6c556799-6a78-4b67-a4c7-4de0a8f082fa@suse.de>
References: <20230310125943.912514-1-javierm@redhat.com>
 <6c556799-6a78-4b67-a4c7-4de0a8f082fa@suse.de>
Date:   Fri, 10 Mar 2023 14:27:42 +0100
Message-ID: <87fsac7n3l.fsf@minerva.mail-host-address-is-not-set>
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

Hello Thomas,

> Hi Javier
>
> Am 10.03.23 um 13:59 schrieb Javier Martinez Canillas:
>> Christian Hergert reports that the driver doesn't enable the property and
>> that leads to always doing a full plane update, even when the driver does
>> support damage clipping for the primary plane.
>> 
>> Don't enable it for the cursor plane, because its .atomic_update callback
>> doesn't handle damage clips.
>> 
>> Reported-by: Christian Hergert <chergert@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>   drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> index 4c09e313bebc..a2e045f3a000 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -390,5 +390,9 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>
> virtio_gpu_plane_init() should really be two separate functions. But 
> withing the constrains of the current code
>

Agreed, I thought the same. I may post a follow-up patch once this lands.

> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

