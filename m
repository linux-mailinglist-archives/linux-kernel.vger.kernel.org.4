Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5D70085A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbjELMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjELMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63119BE
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683895626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJgqlXLztFl0MBoQFQIqJTCsGooWxTVjQq7Oro5jGqw=;
        b=c3OBITSi0iAvjxYyegQPs7BuhxJZVs3ltIJyrOoR/jQf39v/6qbqFdRMyeKrenJYJN/P34
        eVIjwn7XrDEwr9ItFT3hJ6Bac++h3TvU5fy4zhXLdorqkr9WJ7ZhLjCJItmG9HZkQvyaxP
        yM/syhzx2v2XClpYbdypIhisEDoOQSA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-1iz5fLaAOl6XV13A_KLqpQ-1; Fri, 12 May 2023 08:47:05 -0400
X-MC-Unique: 1iz5fLaAOl6XV13A_KLqpQ-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4539ab1c80fso146145e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895624; x=1686487624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJgqlXLztFl0MBoQFQIqJTCsGooWxTVjQq7Oro5jGqw=;
        b=SJgGRkg7rNBgFEH6T2qFKxMj4GTesjL/v4XjKN2CM92fgkNU5a3/HwG/ipUcbsBajO
         wAhz7LnBRd4jbVX9VkUBp5ozYZGWxs85RZPGAMeCm/uk4ePWQGHv8cNN1QlGnGoygh2M
         nRgRUtEDtQUWd7FcVAeobNNvAUcIbdcR05SMquhGOb+WTl/HiqSF9hpUC/ICBc0Zwrz7
         m/KLRWm36tG5rn6FYDGnDZ7q5t6xq18GLh3YZl6HSzZ1nA6c0/EBcuxBV1Pt3NOTxZ8F
         sssEjb+ug2F4idcJ78vM3LlJaAgJNSyb9BuwiYHGqSWWtr1AjNJ0ofurDB9nhUmjxzI2
         FQKw==
X-Gm-Message-State: AC+VfDyqbmcLKkHLgyUXQ0s9WpvA/4mjWV2t3mEFfmGp670KmSy6kDcr
        kpxLEE28/aE1ACUj6MJOmf8zTNurm4kMLnTYJS1eu2vwfY59aBsrvJQg9yfBxIY8LD5jNdJkv01
        pDqEWr6LiZDcb4dqwq8xF4LJA5Ahice1QLtW7VNjg
X-Received: by 2002:a1f:dd42:0:b0:43c:290c:25e8 with SMTP id u63-20020a1fdd42000000b0043c290c25e8mr8337209vkg.6.1683895624610;
        Fri, 12 May 2023 05:47:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yZxumejHu+zJzEaaKqa6xt9pvg90H/4AFuwccsjqfjD5b2ojZakUIS11JCd4jdY0ELP7Fv4O8lj5wR8QlcEU=
X-Received: by 2002:a1f:dd42:0:b0:43c:290c:25e8 with SMTP id
 u63-20020a1fdd42000000b0043c290c25e8mr8337198vkg.6.1683895624367; Fri, 12 May
 2023 05:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230512100620.36807-1-bagasdotme@gmail.com> <20230512100620.36807-9-bagasdotme@gmail.com>
In-Reply-To: <20230512100620.36807-9-bagasdotme@gmail.com>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Fri, 12 May 2023 08:46:53 -0400
Message-ID: <CAC1cPGy=78yo2XcJPNZVvdjBr2-XzSq76JrAinSe42=sNdGv3w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drivers: watchdog: Replace GPL license notice
 with SPDX identifier
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Watchdog Devices <linux-watchdog@vger.kernel.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Airlie <airlied@redhat.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Sam Creasey <sammy@sammy.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ray Lehtiniemi <rayl@mail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrey Panin <pazke@donpac.ru>, Oleg Drokin <green@crimea.edu>,
        Marc Zyngier <maz@kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Sylver Bruneau <sylver.bruneau@googlemail.com>,
        Andrew Sharp <andy.sharp@lsi.com>,
        Denis Turischev <denis@compulab.co.il>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 6:07=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:


> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> index 504be461f992a9..822bf8905bf3ce 100644
> --- a/drivers/watchdog/sb_wdog.c
> +++ b/drivers/watchdog/sb_wdog.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-1.0+
>  /*
>   * Watchdog driver for SiByte SB1 SoCs
>   *
> @@ -38,10 +39,6 @@
>   *     (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
>   *                                             All Rights Reserved.
>   *
> - *     This program is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 1 or 2 as published by the Free Software Foundation.

Shouldn't this be
// SPDX-License-Identifier: GPL-1.0 OR GPL-2.0
(or in current SPDX notation GPL-1.0-only OR GPL-2.0-only) ?

