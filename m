Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38C66DE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbjAQMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjAQMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:54:57 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A233310E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:54:56 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id l14so17704370qvw.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vAXlo1+KmzVCHdtK5nVV4/3Y1bUF5O6kHwPxr8fQok=;
        b=sisOYN/G+qD2cXr9IjRrw/651XPdMyySEqQtcbWAPIToIwplHKa/QHjypG6TZMvFOt
         xHwJ6PxM8vg8T6nLY713qR985UfH/N0v+J6i0eii6NNV4RQWnOdAjEXqhW+unKnZvHqd
         2bB4IxMjdxk6M/FD0fgv+NSfQ9C7ykvPFq0TMh0croBTh/4jSKQB91yYo2+HtOnCXwSu
         BYPFIxAinJhWgIHPsvcnoV6Dyr5wh+lk/Mc20CfsQMWGlbPvseQHiKWm7fCnmX6kaLBL
         dkXFgwHIzv/IWywAiFBuIBOBuHeyeMfoioR+KHvU2ExJLeEgn+v47sa5Js0AuvppUlGF
         fn/A==
X-Gm-Message-State: AFqh2ko50oxUmny78EktWr57Dk3PNkQ4w7NyGqRqJLiP0lEeYPI7i3IV
        JAD8BLBQHNvkDMfuetZpWBrBYiKh+XdfWg==
X-Google-Smtp-Source: AMrXdXtdCpR5IGF8mOq3pmC84pHh3jNbzeC8aQtiFzrwzKYh1wycsdtgMAknlVmYFVB7TXaDwTdj6w==
X-Received: by 2002:a05:6214:1401:b0:4c7:cf4:f424 with SMTP id pr1-20020a056214140100b004c70cf4f424mr4700142qvb.35.1673960095184;
        Tue, 17 Jan 2023 04:54:55 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b006fed58fc1a3sm20260463qkp.119.2023.01.17.04.54.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 04:54:54 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id p188so33869196yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:54:54 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr310008ybo.380.1673960094321; Tue, 17 Jan
 2023 04:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20221226031417.1056745-1-victor.liu@nxp.com>
In-Reply-To: <20221226031417.1056745-1-victor.liu@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jan 2023 13:54:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiebe0c59-sWjaBmU9T-OxWX7HbPF9eM528UeaHDfT=w@mail.gmail.com>
Message-ID: <CAMuHMdWiebe0c59-sWjaBmU9T-OxWX7HbPF9eM528UeaHDfT=w@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND] drivers: bus: simple-pm-bus: Use clocks
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        saravanak@google.com, linux-imx@nxp.com, greg@kroah.com,
        arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 4:13 AM Liu Ying <victor.liu@nxp.com> wrote:
> Simple Power-Managed bus controller may need functional clock(s)
> to be enabled before child devices connected to the bus can be
> accessed.  Get the clock(s) as a bulk and enable/disable the
> clock(s) when the bus is being power managed.
>
> One example is that Freescale i.MX8qxp pixel link MSI bus controller
> needs MSI clock and AHB clock to be enabled before accessing child
> devices.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v4->v5:
> * Fix build warnings when CONFIG_PM=n by using RUNTIME_PM_OPS,
>   NOIRQ_SYSTEM_SLEEP_PM_OPS and pm_ptr macros.
> * Drop Geert's R-b tag due to the fix.
> * Resend based on v6.2-rc1.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
