Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EB6D9658
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjDFLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbjDFLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD27A247
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680781640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWwwDUBcTxMQFoR2Rf9eY7h3vDUIUGt5Sqa76Fd1rXQ=;
        b=VJ0fPBZinjSBigHnAr/K8h0Tls09F+pHVybsedYYnv4O30MFthYG+h1bMkX62g2TheCCea
        CPuEKFeAWag4p8HiGWP1+RvNUXTCZFo4H8dqdSkYsYfqEmk4nJBwy37O/La7fGu4hWjAl2
        vU0jfmgA8y4qJgM/sUa60YucJqtO5pI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-xBYxV9plM5aVsFaMdZf7SQ-1; Thu, 06 Apr 2023 07:47:18 -0400
X-MC-Unique: xBYxV9plM5aVsFaMdZf7SQ-1
Received: by mail-wm1-f70.google.com with SMTP id j14-20020a05600c1c0e00b003f066d2638aso1473738wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680781637;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iWwwDUBcTxMQFoR2Rf9eY7h3vDUIUGt5Sqa76Fd1rXQ=;
        b=0ckGvEXbAnStbo6/ZBTIlkJ6Ou83qOam9e7p7btktuRm0yTaiCUxShzTTuUCtftAVD
         gkTBDwAKz4vXVZATZu2M3nEVefF95ak9tc3nZMwNYPWNxWkqO3IHCQOkP2+/zSliNIWA
         z6iMuwTUCo/mAer/Sz1+kHeHgpaz3fE9Rbc1NtDqftYh2U4yKy9nCpo3MzFRzcrDw2H5
         tug0qQ1SOuxIzFyAA84g/HH6CHDHlnX0RACxrXes1OKFz5jQ0t0crIZADbujwvqpc4xm
         dRG6+zdxhLQU4Qh3T/xSo+y5sG8DdVJWLX0S0ABTGBTSOIUk9Lu/zAP9UbwaBYZDk62y
         PpSg==
X-Gm-Message-State: AAQBX9fWi6tBmJbZczufKcyemH3cZSHxEMm1SP0Uk19rgqaBBoTev82F
        ERQtQhpYbz0fxOkxGyM4YfPq40DXWchAT+0XF9vF/bYy9ZgnoafhFfiJQHH8aTDyjmKFCew8f1x
        dLMQOBmjS4qCftYT9oxTMKxii
X-Received: by 2002:a7b:c384:0:b0:3e9:f15b:935b with SMTP id s4-20020a7bc384000000b003e9f15b935bmr6859113wmj.32.1680781637698;
        Thu, 06 Apr 2023 04:47:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z0w2RyUkiZdYYT4EK5OLcz6zUdIliWv60GkRn8oIaecMiGXS9uj7lrRVOK6go6/Yfh3Z6Q3g==
X-Received: by 2002:a7b:c384:0:b0:3e9:f15b:935b with SMTP id s4-20020a7bc384000000b003e9f15b935bmr6859102wmj.32.1680781637431;
        Thu, 06 Apr 2023 04:47:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q31-20020a05600c331f00b003ee610d1ce9sm5006690wmp.34.2023.04.06.04.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:47:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Marius Vlad <marius.vlad@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/vkms: Drop vkms_connector_destroy() wrapper
In-Reply-To: <accdc804-19e7-df59-7dd3-69c83f52405d@igalia.com>
References: <20230406110235.3092055-1-javierm@redhat.com>
 <20230406110235.3092055-2-javierm@redhat.com>
 <ZC6o4l7tzSIwFTKw@phenom.ffwll.local>
 <accdc804-19e7-df59-7dd3-69c83f52405d@igalia.com>
Date:   Thu, 06 Apr 2023 13:47:16 +0200
Message-ID: <878rf58c6z.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ma=C3=ADra Canal <mcanal@igalia.com> writes:

Hello Ma=C3=ADra,

> On 4/6/23 08:11, Daniel Vetter wrote:
>> On Thu, Apr 06, 2023 at 01:02:34PM +0200, Javier Martinez Canillas wrote:
>>> This helper is just a wrapper that calls drm_connector_cleanup(), there=
's
>>> no need to have another level of indirection.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>=20
>> On both patches:
>>=20
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>=20
>> Aside, would be a nice cleanup to move vkms output stuff (crtc and
>> connector) over to the drmm_ stuff. The plane already does that.
>
> I sent a patch [1] a while ago moving the CRTC to the drmm_ functions.
> If you could take a look at it, it would be great.
>
> [1] https://lore.kernel.org/dri-devel/20230116205800.1266227-1-mcanal@iga=
lia.com/T/
>

I've now reviewed both patches from your series and they look good to me.

> Best Regards,
> - Ma=C3=ADra Canal
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

