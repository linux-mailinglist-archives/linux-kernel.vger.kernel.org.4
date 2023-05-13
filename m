Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2221470177F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjEMNom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbjEMNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5A1BD5
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683985433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9DB3tShWsmKkupSG4kjkSPgdjSDVuKYI2Ix/HxUCEp4=;
        b=AKh6BRfPbXI8tSfvbMPIWiQ/lXwc1+naBX6guPflwYEZH/Q3UGdJ2JWK+jv5/PbVsLtyHg
        UQyGkuUKsokxeI2EmGb0EnzhJkp/7YSueAY4kgLZ3EQR7saq45ePIqaSnPZTS1XUmQeONM
        61HIjoTj7K6/cjuJ5ZzDP8ifhmW30+Y=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-hy96PfUMMz-sJlGwAGmUUg-1; Sat, 13 May 2023 09:43:51 -0400
X-MC-Unique: hy96PfUMMz-sJlGwAGmUUg-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-45307c00953so1918978e0c.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 06:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683985430; x=1686577430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DB3tShWsmKkupSG4kjkSPgdjSDVuKYI2Ix/HxUCEp4=;
        b=M+vvEEY348yd2YfrHeWzoSKgr/F2EVsz4aclhdy7dN19MCLjQdRRXavrwh7Log56Lt
         QZ6xCArwQwXiud6iQ+ZludlPdm8pYKy5qjVM4KhQ0vVtvhisW+6qpYgLEQRQzlSsaNhZ
         HChtjwlita+1/cJS/UosRybuzIWfYYHkop9nt7nyd4qt+EUZa7gCMwDO13fxcIiYeqqL
         QHZPX8LMlrzc/XjVWXNmIJo99ABVMw5KPbcRO/srW1Xk72gUgznInDmY4xHWrbhNtB1G
         Smdrmjdcxymjcej6uCuEWgWVDJmCmW3qQxXy8eM4ldtAcGidwr59gipgnvGvKCIVHVbq
         Egeg==
X-Gm-Message-State: AC+VfDwmZrY1ooMQTGocWW6pqthZuleDDm5QdTw/TXd5qRT8F1aF/oMP
        9+6mGISrdrPcoqroNGziTnIZ9CogN8oF9zhlK+jn/yMXNhKkLLMKoZ6c40rPDuifrsJdI6SweeR
        g2S45L/ugHdye9C9aYPY/MGcS8pYQVGj7FTgocN1S
X-Received: by 2002:a1f:cf44:0:b0:43c:6e7d:60b0 with SMTP id f65-20020a1fcf44000000b0043c6e7d60b0mr8278749vkg.15.1683985430624;
        Sat, 13 May 2023 06:43:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OKoxadeHskX30zk/2SxsIYXX7yuqtDMX0XJgUO0uD/088ZwUUrLZ6CEQ62Rv0aKLCGZw53hFwRxRMhCBVNTA=
X-Received: by 2002:a1f:cf44:0:b0:43c:6e7d:60b0 with SMTP id
 f65-20020a1fcf44000000b0043c6e7d60b0mr8278732vkg.15.1683985430363; Sat, 13
 May 2023 06:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230512100620.36807-1-bagasdotme@gmail.com> <20230512100620.36807-9-bagasdotme@gmail.com>
 <CAC1cPGy=78yo2XcJPNZVvdjBr2-XzSq76JrAinSe42=sNdGv3w@mail.gmail.com> <ef31b33f-8e66-4194-37e3-916b53cf7088@gmail.com>
In-Reply-To: <ef31b33f-8e66-4194-37e3-916b53cf7088@gmail.com>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Sat, 13 May 2023 09:43:39 -0400
Message-ID: <CAC1cPGzznK8zoLaT1gBjpHP1eKFvTKKi+SW6xuXF3B8aHN27=g@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 6:53=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On 5/12/23 19:46, Richard Fontana wrote:
> > On Fri, May 12, 2023 at 6:07=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:
> >
> >
> >> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> >> index 504be461f992a9..822bf8905bf3ce 100644
> >> --- a/drivers/watchdog/sb_wdog.c
> >> +++ b/drivers/watchdog/sb_wdog.c
> >> @@ -1,3 +1,4 @@
> >> +// SPDX-License-Identifier: GPL-1.0+
> >>  /*
> >>   * Watchdog driver for SiByte SB1 SoCs
> >>   *
> >> @@ -38,10 +39,6 @@
> >>   *     (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
> >>   *                                             All Rights Reserved.
> >>   *
> >> - *     This program is free software; you can redistribute it and/or
> >> - *     modify it under the terms of the GNU General Public License
> >> - *     version 1 or 2 as published by the Free Software Foundation.
> >
> > Shouldn't this be
> > // SPDX-License-Identifier: GPL-1.0 OR GPL-2.0
> > (or in current SPDX notation GPL-1.0-only OR GPL-2.0-only) ?
> >
>
> Nope, as it will fail spdxcheck.py. Also, SPDX specification [1]
> doesn't have negation operator (NOT), thus the licensing requirement
> on the above notice can't be expressed reliably in SPDX here.
>
> [1]: https://spdx.github.io/spdx-spec/v2.3/SPDX-license-expressions/

The GPL identifiers in recent versions of SPDX include an `-only` and
an `-or-later` variant. So I don't see why you can't represent it as
`GPL-1.0-only OR GPL-2.0-only`. From what I understand the kernel
requires/prefers use of the earlier approach to GPL identifiers (which
was better in my opinion) under which `GPL-1.0 OR GPL-2.0` would at
least be semantically similar. I don't see why you need a negation
operator in this case. You have other patches where you used the
`-only` identifiers.

Richard

