Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D466974B200
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjGGNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7D26A9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lszDzBh1sFuGKtdYdBJwoIUw40PY44r7U0tPTyFHI1Y=;
        b=C/uyhEkVC0bU0K+UW/LzuhSwAQkh8RUXH/vtze2/wMvwdbIS6mpPJv3Xu3DQcfmXbrKWlr
        xwKyboxorQGfX2QYyxKvBVUnogYoc3GxjMECSJzQGQgG+LY3k8WPWFxbjOX/xe4Mee/cK4
        IV43bpa3bZmt7xDYjDJ1e+egK+hvwrg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-vlR8vTclNcylVZY0LPAgjA-1; Fri, 07 Jul 2023 09:41:52 -0400
X-MC-Unique: vlR8vTclNcylVZY0LPAgjA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3140030cacfso1005764f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737311; x=1691329311;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lszDzBh1sFuGKtdYdBJwoIUw40PY44r7U0tPTyFHI1Y=;
        b=Ozf8XhjdP57FR8R4MMjiaP3x/avHQZ9SU4O5bpV6MeTZP5T80TuZge2Oc7Wh2XOoCy
         XKwI5OYCOpkA9caNCV89PUyq+uC25M1IKmBEaVMAUw35goUNDhA5RHD597xu1XhHZHxF
         ojCAyqaiOH83kvybOe2cv3lEKj6RQ8lyJaa6ghWwXN5C2MsjkbL8hDsFWbS5x8o6QS76
         GX2bbXnI2D1WCk5GCsaA9nWhv/QMkhc8Gn8MWctKPUVzN7TprpIyu/geUQJBQFHc0d3k
         YARDAPMoiYNEBHaocBM11bDLN0QaO3/hVeaET66pMxZajKubQkW2qySOT6ZRnxparw4V
         G1Og==
X-Gm-Message-State: ABy/qLbJtqrprMSyYIM0dex4/Hz3S9b2dA7QkOyh0PIeEn4w5Y7jbAF5
        fJM7l7dOFzB6XPuYRUiuIv/7RTsk6ZZ8SItoHnbhjWOSGktE6QXXTs8TTUVj+qgpoKXXCaTWCZY
        x3cdHdpbgA8np9xkOmB1J6fWQ
X-Received: by 2002:a5d:4d4d:0:b0:313:ed1d:39d5 with SMTP id a13-20020a5d4d4d000000b00313ed1d39d5mr3821985wru.35.1688737311023;
        Fri, 07 Jul 2023 06:41:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSL73NnelkECzSlrHFzZyBm2hgT0OM42vU9A9OivdXpoF5fr4x25M2kgCTNebgI6XNosfvXQ==
X-Received: by 2002:a5d:4d4d:0:b0:313:ed1d:39d5 with SMTP id a13-20020a5d4d4d000000b00313ed1d39d5mr3821963wru.35.1688737310726;
        Fri, 07 Jul 2023 06:41:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003fc02a410d0sm181059wmk.48.2023.07.07.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:41:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
In-Reply-To: <20230707095415.1449376-3-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-3-arnd@kernel.org>
Date:   Fri, 07 Jul 2023 15:41:49 +0200
Message-ID: <87h6qfyh2a.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The dummycon default console size used to be determined by architecture,
> but now this is a Kconfig setting on everything except ARM. Tracing this
> back in the historic git trees, this was used to match the size of VGA
> console or VGA framebuffer on early machines, but nowadays that code is
> no longer used, except probably on the old footbridge/netwinder since
> that is the only one that supports vgacon.
>
> On machines with a framebuffer, booting with DT so far results in always
> using the hardcoded 80x30 size in dummycon, while on ATAGS the setting
> can come from a bootloader specific override. Both seem to be worse
> choices than the Kconfig setting, since the actual text size for fbcon
> also depends on the selected font.
>
> Make this work the same way as everywhere else and use the normal
> Kconfig setting, except for the footbridge with vgacon, which keeps
> using the traditional code. If vgacon is disabled, footbridge can
> also ignore the setting. This means the screen_info only has to be
> provided when either vgacon or EFI are enabled now.
>
> To limit the amount of surprises on Arm, change the Kconfig default
> to the previously used 80x30 setting instead of the usual 80x25.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

