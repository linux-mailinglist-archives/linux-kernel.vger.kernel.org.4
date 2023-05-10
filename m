Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0306FD695
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjEJGLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjEJGK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:10:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882D449C
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:10:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so42081325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683699039; x=1686291039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6pa9jOL+FS7sdVMkryy+XB+jWacnITy30HAcpROQk=;
        b=sYyonTPDuVD12f/fRHqYxhmS4ZV0pC4hkHkJ6WwnCLZjoQW+mEnk2DitOpbXpw5Nub
         AakkPdsTHP2M/niggFjawLcQ9I/B/QGUX6B7Ons+ZhViohhr10jRRYNQfgQ91Pwb39C+
         NvGrOyOuw8m8Ha0DsqXLBsrk5BSt5FcU9U/uGmgOi6hPKyr4GvtEy8oV8ZypI7HKeCno
         U0xmbByQ7D/1KG9F0pOzIdjVZUKWYEPgx4IQckQERhwBLiZaEwHbK9+vo8rRSvy8yTno
         gdhbvJwFnohLfb5OPC8Wrx7FJcFESybuMkjsfCHkOV0wQ9TGS0XckhTD8jDRPQPSjf3i
         p69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683699039; x=1686291039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF6pa9jOL+FS7sdVMkryy+XB+jWacnITy30HAcpROQk=;
        b=P/0i3DwGkS/5u1L8Q6PeOMyRe4yNOWc8MkSeyo2HD0BPv1nvK8GJ757exQrlDIRD3W
         ZmhuSlDqOlarJ1bwCNl3E31+nnzANFR9BTCmYEStibe6kHGPqwW4iB+RqIwBo+g3VrRb
         Jeb7cQpHcsQ6hEnmqLNtsWfQUlL9iHlFahrNWooVodvuEyMkI5CfVH/+vhF64j+j8jHO
         4+aXzgQzXYnoXvXlqZlJZzwrW//2u66rfinSvPdFjO0tqc2KN8E+HK6zoOfRQJoTzHzK
         0Ega0ZvvAFwz3F3fumFzFurFMxkxAxmMIE1bnzEsZU35ZG8hWlCPJns16jCHD6lHUKx3
         EuxA==
X-Gm-Message-State: AC+VfDx/bsrnzFYNUDI9z2EKFhoaBkPrkiMD4yWW4Pws1uQ/dLmJ/K4n
        macY5oyBBWFveaFVbNuQAemkLuBOfV8vy4P1QQWgjw==
X-Google-Smtp-Source: ACHHUZ5h/hKJcCSMOATO3TWn2+Pew1ggT0AjsCAr+Xf1zU8r/ZTlkjNEafbkGI660Tjoga1A1wtCDO8cAPrOei90ovQ=
X-Received: by 2002:a7b:c398:0:b0:3f4:2907:20d8 with SMTP id
 s24-20020a7bc398000000b003f4290720d8mr4534823wmj.36.1683699039337; Tue, 09
 May 2023 23:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230405111559.110220-1-lma@semihalf.com>
In-Reply-To: <20230405111559.110220-1-lma@semihalf.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Wed, 10 May 2023 08:10:28 +0200
Message-ID: <CAFJ_xbqNu3=_jq0HADad9zj+F=TPa4zCoi_8y6Fp3FjymQLkrA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] serial: core: fix broken console after suspend
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there anything more I should do regarding these changes ?

Best regards,
Lukasz
=C5=9Br., 5 kwi 2023 o 13:19 Lukasz Majczak <lma@semihalf.com> napisa=C5=82=
(a):
>
> This is v2 of a patch[1].
> v1->v2:
> * Fixed typos in commit message
> * Tested[2] patch "serial: core: preserve cflags, ispeed and ospeed" on a=
ll
>   current LTS kernels (4.14, 4.19, 5.4, 5.10, 5.15, 6.1) and on top of
>   6.3-rc5 with positive results - console was working after resume
> * During tests another issue was observed  on 6.1+ - FIFO not enabled aft=
er
>   resume - and an additional change was needed ("serial: core: enable
>   FIFO after resume")
> * Test procedure:
>   1) ensure the console output is ok
>   2) suspend device with "echo freeze > /sys/power/state"
>      (/sys/module/printk/parameters/console_suspend =3D=3D N)
>   3) resume device and check the console output
>   4) suspend device with "echo freeze > /sys/power/state"
>      (/sys/module/printk/parameters/console_suspend =3D=3D Y)
>   5) resume device and check the console output
>
> [1] https://lore.kernel.org/lkml/20230301075751.43839-1-lma@semihalf.com/
> [2] Test platforms: PC with i5-8400 + GB H370M D3H
>                     HP Elite c1030 Chromebook Enterprise i5-10310U
>
> Lukasz Majczak (2):
>   serial: core: preserve cflags, ispeed and ospeed
>   serial: core: enable FIFO after resume
>
>  drivers/tty/serial/serial_core.c | 57 +++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 30 deletions(-)
>
> --
> 2.40.0.577.gac1e443424-goog
>
