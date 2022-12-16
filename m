Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E63F64EBDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLPNGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiLPNGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:06:01 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B052A960;
        Fri, 16 Dec 2022 05:06:00 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-43ea87d0797so3742007b3.5;
        Fri, 16 Dec 2022 05:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXF9c7i/pRZwb/zK4b3gP0kYwDE/+CkuRpF8ttFbdN4=;
        b=l6PATB868fr4d3YF83iMoL9gZrL0DVm5wVxcQGRgLaPJWSjgEyZ2i/DNHtmiWYnfFp
         05+Y7EpMmJahQTNDiusfHkkfykV163RdO7IZbZe+4s6rMl9wWmC4wz9yybZh5Ff/EhmU
         Ox1i9LDd4rt4VUQUE22W2tDjONMjM5LnKOzD5Pc2MKf9D26t1/jbg49/64+uavx7HDgP
         7hT4xWheJ/8jS2mTnxxc7FBvm8Z6zRLgKWAfU1PiCOIsnIi5UnJyOctvdqXgZF10sFIi
         scgsukm03YXe8RnXnp0o9EprOpEQJ9NQbAUByBOywwUuk1dyXJwSqMECoQAOntmSEdPN
         Id0A==
X-Gm-Message-State: ANoB5pkkpc6C2jvYlGU3a5A4o3hFPQsXNCugvdtzuysPs7fOwvuKAXIa
        OlO3Qlepr5xMOVUT3jiBXjFOhn5WQTfFPA==
X-Google-Smtp-Source: AA0mqf4Aq6ticabG5QcKLKfzwPbPLtx4dun+78K6CTRoPxjqhcg6sfe+5ucaM8hs9nnK0HvaWDlGHg==
X-Received: by 2002:a05:7500:579f:b0:eb:5db:86f4 with SMTP id bz31-20020a057500579f00b000eb05db86f4mr4204563gab.62.1671195959208;
        Fri, 16 Dec 2022 05:05:59 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y18-20020a37f612000000b006fefa5f7fcesm1465631qkj.10.2022.12.16.05.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:05:58 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3f15a6f72d0so32136857b3.1;
        Fri, 16 Dec 2022 05:05:58 -0800 (PST)
X-Received: by 2002:a0d:dd4b:0:b0:370:61f5:b19e with SMTP id
 g72-20020a0ddd4b000000b0037061f5b19emr28600389ywe.316.1671195958287; Fri, 16
 Dec 2022 05:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20221215170234.2515030-1-arnd@kernel.org>
In-Reply-To: <20221215170234.2515030-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Dec 2022 14:05:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZX9_c7Wvpbu2E9JSm4eoh6S4U+aNfPQ-kk0zyEQdj7A@mail.gmail.com>
Message-ID: <CAMuHMdWZX9_c7Wvpbu2E9JSm4eoh6S4U+aNfPQ-kk0zyEQdj7A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: omapfb: avoid stack overflow warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Dec 15, 2022 at 6:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The dsi_irq_stats structure is a little too big to fit on the
> stack of a 32-bit task, depending on the specific gcc options:
>
> fbdev/omap2/omapfb/dss/dsi.c: In function 'dsi_dump_dsidev_irqs':
> fbdev/omap2/omapfb/dss/dsi.c:1621:1: error: the frame size of 1064 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>
> Since this is only a debugfs file, performance is not critical,
> so just dynamically allocate it, and print an error message
> in there in place of a failure code when the allocation fails.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> @@ -1536,22 +1536,28 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
>  {
>         struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
>         unsigned long flags;
> -       struct dsi_irq_stats stats;
> +       struct dsi_irq_stats *stats;
> +
> +       stats = kzalloc(sizeof(*stats), GFP_KERNEL);
> +       if (!stats) {
> +               seq_printf(s, "out of memory\n");

I guess this is futile?
No need to increase kernel size for OOM messages.

> +               return;
> +       }
>
>         spin_lock_irqsave(&dsi->irq_stats_lock, flags);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
