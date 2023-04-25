Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198496EDDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjDYIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjDYIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C6D40DF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682410903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIIauKKDlxGiywiZSy6POl99LscbO+Z+FWK2Qk7igxw=;
        b=A4tLUScYrsogBHZPOqtupTVTsBuhNwbvGJ7p04G7sOewzfq6CA2FALbxa/7pmNq4FXRfvh
        6+eHz67aWMZTnS7PVFs/+FiajfQlBnElTEjmi2caK2KFvKjMhcMSDClafvVZBrdEHlzySz
        P2J693Yqi6RojqJn5G8IRUFVWqsKimk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Hirq0dIvOrKiu8Ew7yKJew-1; Tue, 25 Apr 2023 04:21:41 -0400
X-MC-Unique: Hirq0dIvOrKiu8Ew7yKJew-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f1757ebb1eso18857635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410900; x=1685002900;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIIauKKDlxGiywiZSy6POl99LscbO+Z+FWK2Qk7igxw=;
        b=e2ubWgiQRZ9E8fU27s0W8HMmRVo+MbUMN1YfBgV+2sT1RtQqIRjz5lMAEdHC5RVYBC
         mGY6kuHhRmMoqRvAWiC3FxKeGZH7bV40tEYZGUuTFrEza06AZzNWdUAgDlaNnOhBTVaE
         mhpOHmTuyj8col7h76L2ryB23wmZZllvQWHtKdp8vjnYJE8EVZwgJ7rOEOhM/DBvd1dZ
         U43BSljg8w4AWixr145YIxRb3XXxD/c0cwUJAwfaBwF3MJNzp4HIat2jQasNDMyCr7Vf
         OCoEnm9Dyx+V7aHSvj+QiYzWVOJUdm6FvvIGzo/NA+8jpaOBq/3Dr2yNdmhKFZYuoKN6
         deuw==
X-Gm-Message-State: AAQBX9enuqTAbpf1O+8iWM29E90TxlpQ7PMSplNyZiyVeE4Mu5IuHIFq
        QaM6f/mTh2ShklFA4eeYqV9HXAzc7qeP1Ikx/eZ03PylExTQj1pSbFYaLmtfch0QoOsS9/Vrcou
        5gWhj6/6j0FyCq1R0KUMa5FxPmql1JGNd
X-Received: by 2002:a5d:464f:0:b0:2ce:d84d:388f with SMTP id j15-20020a5d464f000000b002ced84d388fmr12417118wrs.40.1682410900610;
        Tue, 25 Apr 2023 01:21:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YQpEqfNv2QOHfCXZ6AcQ5KinFlo+949TgOWtyI/79R2NhWA5GoU5enU8y4wOcGrnVBDnMa9Q==
X-Received: by 2002:a5d:464f:0:b0:2ce:d84d:388f with SMTP id j15-20020a5d464f000000b002ced84d388fmr12417098wrs.40.1682410900322;
        Tue, 25 Apr 2023 01:21:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d5950000000b0030490c8ccafsm556130wri.52.2023.04.25.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 01:21:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 1/9] drm/vc4: Switch to container_of_const
In-Reply-To: <6ckl6zmizxsm52imeau55bicb4hmd3p46btsqih64qaoeptvww@bktsqhuq4lek>
References: <20221207-rpi-hdmi-improvements-v3-0-bdd54f66884e@cerno.tech>
 <20221207-rpi-hdmi-improvements-v3-1-bdd54f66884e@cerno.tech>
 <87354sij2i.fsf@minerva.mail-host-address-is-not-set>
 <6ckl6zmizxsm52imeau55bicb4hmd3p46btsqih64qaoeptvww@bktsqhuq4lek>
Date:   Tue, 25 Apr 2023 10:21:38 +0200
Message-ID: <87pm7sgynh.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> writes:

> Hi Javier,
>
> On Sat, Apr 22, 2023 at 07:26:13AM +0200, Javier Martinez Canillas wrote:
>> Maxime Ripard <maxime@cerno.tech> writes:
>> > container_of_const() allows to preserve the pointer constness and is
>> > thus more flexible than inline functions.
>> >
>> > Let's switch all our instances of container_of() to
>> > container_of_const().
>> >
>> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>> > ---
>> 
>> [...]
>> 
>> > -static inline struct vc4_dpi *
>> > -to_vc4_dpi(struct drm_encoder *encoder)
>> > -{
>> > -	return container_of(encoder, struct vc4_dpi, encoder.base);
>> > -}
>> > +#define to_vc4_dpi(_encoder)						\
>> > +	container_of_const(_encoder, struct vc4_dpi, encoder.base)
>> >
>> 
>> A disadvantage of this approach though is that the type checking is lost.
>
> Not entirely, the argument is still type-checked, but yeah, it's true
> for the returned value.
>
>> Since you already had these, I would probably had changed them to return
>> a const pointer and just replace container_of() for container_of_const().
>> 
>> But I see that there are a lot of patches from Greg all over the kernel
>> that do exactly this, dropping static inline functions in favor of using
>> container_of_const() directly. So it seems the convention is what you do.
>
> More importantly, container_of_const() isn't always returning a const
> pointer or always taking a const argument, it's returning the pointer
> with the same const-ness than the argument.
>
> This is why it makes sense to remove the inline function entirely,
> because it removes the main benefit it brings.
>

Got it. Thanks for the explanations.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

