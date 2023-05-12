Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658E70091B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbjELNWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbjELNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0614E64
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683897680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AlaRyQOy36sXdqy+JwhbCuIDwi8LlxpgbISw/CDPFM=;
        b=WVuFVWO6/FlQSCVBFPSJC0w1/VEBS0do9vDz6gEOk7BY/kXbJ95LDYOtcqNM3WjHSaCZvw
        q/dgJfGUO6xLvfizoSIiTsitotncXfuAFLv1jnZRfGTt6H0zQ0NrHOXe6e+urH9J6WHINu
        +MPeFTCgNTF61UxaqRCOdNs9ZQWVvng=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-B2bZivelPk6pxWZDvzhR9Q-1; Fri, 12 May 2023 09:21:19 -0400
X-MC-Unique: B2bZivelPk6pxWZDvzhR9Q-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-43477a8182eso2356776137.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897678; x=1686489678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AlaRyQOy36sXdqy+JwhbCuIDwi8LlxpgbISw/CDPFM=;
        b=SmurFfmkW4MvlzmJVppHhF9i4+fmczDitMH2G1n6iXNSnpFJkJKTRBi9ZWGWT079nz
         zxySCHlYxu19Ju5IAARm42h96DjeJz9Q8qwi1jRATZ/Ux/6OpH9XcvHmp3dmJDme3lTx
         R8dxhBw2YFKBJ4BxdmCSUk09wcXwDPkxEieOu6iKT/RGsrG/PotjjuphqHmFg5ErqPag
         HAVN3iep4mhjCPncFguXgcog8WOsWJjkISqBBtnPuzr2lGQXw0uIuT/N+dGZnXUeQX96
         0SkBCdBKu/ztVpTrD1cNNsMtvuOj96dKo2xTlNCk1PMwISck8IIWAGulbbzJt27Fh1jv
         8eFQ==
X-Gm-Message-State: AC+VfDyIewHJq5ltpRk2cThwcfxbz6uOQ0gOEG9Vg4tPBj+di7FXOF4m
        wDUjxUhfKAoP/RR6HJOrytQBWm1ABgu9VZrIM7ml5U91yDFbax/3+IwpkZZqT26PdfKd/XknOEp
        Z74gRp1QyC3en7t3SQlSXO6ot6p3eLmuY4ZHN0/+Y
X-Received: by 2002:a67:ffd5:0:b0:434:69be:8495 with SMTP id w21-20020a67ffd5000000b0043469be8495mr9541626vsq.9.1683897678643;
        Fri, 12 May 2023 06:21:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56EVhPNDeIWeojbtIxhXDW0jsNAxPEwZjDUE5jSg6VIr1fyKKsgmU+sCABqffj01zeSX7annq0Y5IBzbAanRE=
X-Received: by 2002:a67:ffd5:0:b0:434:69be:8495 with SMTP id
 w21-20020a67ffd5000000b0043469be8495mr9541577vsq.9.1683897678350; Fri, 12 May
 2023 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230512100620.36807-1-bagasdotme@gmail.com> <20230512100620.36807-10-bagasdotme@gmail.com>
In-Reply-To: <20230512100620.36807-10-bagasdotme@gmail.com>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Fri, 12 May 2023 09:21:07 -0400
Message-ID: <CAC1cPGzSpMZC3oJOpzjqiEDvgWUszzSztMri6uxW6vZ7oZtD5w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] udf: Replace license notice with SPDX identifier
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
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 6:07=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:

> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index de17a97e866742..b2b5bca45758df 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: BSD-2-Clause OR GPL-1.0+ */
>  /*
>   * ecma_167.h
>   *
> @@ -8,29 +9,6 @@
>   * Copyright (c) 2017-2019  Pali Roh=C3=A1r <pali@kernel.org>
>   * All rights reserved.
>   *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote produ=
cts
> - *    derived from this software without specific prior written permissi=
on.
> - *
> - * Alternatively, this software may be distributed under the terms of th=
e
> - * GNU Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AN=
D
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABL=
E FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIA=
L
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
> - * SUCH DAMAGE.
>   */

This is not BSD-2-Clause. Ignoring the interior statement about the
GPL, I think the closest SPDX identifier might be
https://spdx.org/licenses/BSD-Source-Code.html
but it doesn't quite match.


> diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
> index 157de0ec0cd530..6c09a4cb46f4a7 100644
> --- a/fs/udf/osta_udf.h
> +++ b/fs/udf/osta_udf.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: BSD-2-Clause OR GPL-1.0+ */
>  /*
>   * osta_udf.h
>   *
> @@ -8,29 +9,6 @@
>   * Copyright (c) 2017-2019  Pali Roh=C3=A1r <pali@kernel.org>
>   * All rights reserved.
>   *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote produ=
cts
> - *    derived from this software without specific prior written permissi=
on.
> - *
> - * Alternatively, this software may be distributed under the terms of th=
e
> - * GNU Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AN=
D
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABL=
E FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIA=
L
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
> - * SUCH DAMAGE.
>   */

Same comment - this is not BSD-2-Clause.

> diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
> index fce4ad976c8c29..d0fce5348fd3f3 100644
> --- a/fs/udf/udftime.c
> +++ b/fs/udf/udftime.c
> @@ -1,21 +1,4 @@
> -/* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, =
Inc.
> -   This file is part of the GNU C Library.
> -   Contributed by Paul Eggert (eggert@twinsun.com).
> -
> -   The GNU C Library is free software; you can redistribute it and/or
> -   modify it under the terms of the GNU Library General Public License a=
s
> -   published by the Free Software Foundation; either version 2 of the
> -   License, or (at your option) any later version.
> -
> -   The GNU C Library is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -   Library General Public License for more details.
> -
> -   You should have received a copy of the GNU Library General Public
> -   License along with the GNU C Library; see the file COPYING.LIB.  If n=
ot,
> -   write to the Free Software Foundation, Inc., 59 Temple Place - Suite =
330,
> -   Boston, MA 02111-1307, USA.  */
> +// SPDX-License-Identifier: GPL-2.0-only

Shouldn't this be
// SPDX-License-Identifier: LGPL-2.0-or-later ?
(or are you implicitly using the obscure LGPLv2.x section ... 3 mechanism?)

Richard

