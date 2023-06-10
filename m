Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43372ADE5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjFJRwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFJRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C035BC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686419505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKSaQZ4znfpr2ozE1Mb7MZQL8rtwbT4mvdyngtft6oE=;
        b=QjiIlDm/HXKRBT/W8DcqrnZxfETPkb0/5iRWExYsLPBm8UZrsBRaTKJJT6LOLH4DTKdaez
        cVqHqUY1EH1lf80IX299LQaHtYjkUWlMgaWkg4e04nccuhmhyIJh2NEhLq14nEMe0oDtwY
        k1Ios4AkF2xqSOXXXnK5LelD7crjqvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ost0nZJuMgmt-0PG9XT6wA-1; Sat, 10 Jun 2023 13:51:44 -0400
X-MC-Unique: ost0nZJuMgmt-0PG9XT6wA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f739cc1aafso12472255e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686419503; x=1689011503;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKSaQZ4znfpr2ozE1Mb7MZQL8rtwbT4mvdyngtft6oE=;
        b=aXEi1FPG7U1KD91NYjZrHA1bSI3+aWLzLQWswaFFCKRjOt2YOUPyK2TgpEyByDz3mK
         kKc+Vj404OFYMCauqm6fFuWBM5HUy7qDIE2m29MyiZreomSqDOcL1pj8dR6h/kDWrlt/
         XFZhzQdJen5cECVj21v6gZO9dMe4YygmyBqziub1Y7ku217R3ZeUL3i+PVSJAXXnHN1z
         LLbYHdzPg+SVmnSBwLzLKAg7RKfGPSgk2aF8K4QO6nCMUoqhXPWyW/Zmt1yTvWraKBQi
         UCd6mkhFqf9zHQCF7fLa5pC7JsiRdy7L6lTus8QOw7lfdsHE8kZmCfL7cJ3CwxRahuaN
         aQRg==
X-Gm-Message-State: AC+VfDxWsPRW3c3Z1rO4oPSBan+P4jp5qlOUad5D+LLDRe1oc4sXwhAc
        JyYhmOzsfNLnHAMLk3VynzwKSyAB2jwuJGDqmWxwQ5pqQNBRIkIeRmyfhgcs8owfoQLEvqTdoI+
        NCjVhS9xgJlP4POlIJ41w2FcA
X-Received: by 2002:a05:600c:2189:b0:3f7:81e9:2f02 with SMTP id e9-20020a05600c218900b003f781e92f02mr2985115wme.4.1686419503153;
        Sat, 10 Jun 2023 10:51:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oloD0EK/STe16UJZzvVaQXGexNAqmk7NaH1zGxsm7M2y6ZMJc4nxV7hPbfHGklvgtsvLviw==
X-Received: by 2002:a05:600c:2189:b0:3f7:81e9:2f02 with SMTP id e9-20020a05600c218900b003f781e92f02mr2985110wme.4.1686419502754;
        Sat, 10 Jun 2023 10:51:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003f60e143d38sm6287776wmk.11.2023.06.10.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 10:51:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Remove default
 width and height values
In-Reply-To: <20230610-opposite-quality-81d4a1561c88@spud>
References: <20230609170941.1150941-1-javierm@redhat.com>
 <20230609170941.1150941-3-javierm@redhat.com>
 <20230610-opposite-quality-81d4a1561c88@spud>
Date:   Sat, 10 Jun 2023 19:51:35 +0200
Message-ID: <87r0qj19zs.fsf@minerva.mail-host-address-is-not-set>
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

Conor Dooley <conor@kernel.org> writes:

> On Fri, Jun 09, 2023 at 07:09:37PM +0200, Javier Martinez Canillas wrote:
>> A default resolution in the ssd130x driver isn't set to an arbitrary 96x16
>> anymore. Instead is set to a width and height that's controller dependent.
>
> Did that change to the driver not break backwards compatibility with
> existing devicetrees that relied on the default values to get 96x16?
>

It would but I don't think it is an issue in pratice. Most users of these
panels use one of the multiple libraries on top of the spidev interface.

For the small userbase that don't, I believe that they will use the rpif
kernel and ssd1306-overlay.dtbo DTB overlay, which defaults to width=128
and height=64 [1]. So those users will have to explicitly set a width and
height for a 96x16 panel anyways.

The intersection of users that have a 96x16 panel, assumed that default
and consider the DTB a stable ABI, and only update their kernel but not
the  DTB should be very small IMO.

[1]: https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/overlays/ssd1306-overlay.dts

> Cheers,
> Conor.
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

