Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EC71FA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjFBGwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFBGwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:52:11 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60EEB;
        Thu,  1 Jun 2023 23:52:10 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so2245966e87.1;
        Thu, 01 Jun 2023 23:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685688728; x=1688280728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9DWVlf1ssnI9gx+MVSnTE5Fm8P+7zFjGjwuixjorcE=;
        b=PCOqk2ns7tyP4Bo88GqKNiSL5aLD4DswOnPGtNzMHmY7xBwgove5qbW7KmQnT/X1Zn
         nm7pNNek0LqEDlGvSUo61MLNu91bSu9fCzbDEYsFCNP+UuROQa5dbQK7WxUG7UhiuIc2
         1/ezreUgEWhMEXVjXez1GgQYRHK1HoS5VVsYRjZ2gsLdux6G+L7qN/Qzqk074D2lwBoL
         8LuCyzpFn/gbu2uGeUvs8EInI92n9tEh+CkPZi6gEGhhgIoMM1IxRNO7KujPVGoFIr5C
         J5B/sFS+QGUUrkNR/PdUuM4v9GC82C6zxBuf6VNoC6XgPDXZKv85VAS3PPHXYzZToP0j
         N26Q==
X-Gm-Message-State: AC+VfDwIqWQN2Q+ELNldiF+acdPonxJeReyesMZ9/EsxdFeO9m2ppIqX
        IM0bSyzqX1UcAFWwG8gxGxMA/aQMDg4wo61z
X-Google-Smtp-Source: ACHHUZ6299qgCzP4n9ikrNBatD5GiNuvjlQOfLgk8dtIHX4b06fzaN9YZhz6NVv89G42ZOKAsfJHhQ==
X-Received: by 2002:ac2:46d0:0:b0:4f1:30cc:3dae with SMTP id p16-20020ac246d0000000b004f130cc3daemr1405815lfo.10.1685688727739;
        Thu, 01 Jun 2023 23:52:07 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512390e00b004f5e681eec1sm64898lfu.92.2023.06.01.23.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 23:52:06 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f6148f9679so64861e87.3;
        Thu, 01 Jun 2023 23:52:06 -0700 (PDT)
X-Received: by 2002:a05:6512:11ef:b0:4f3:b49b:e246 with SMTP id
 p15-20020a05651211ef00b004f3b49be246mr1353520lfs.5.1685688726700; Thu, 01 Jun
 2023 23:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com> <ZHkQDTvk6I2q-9CF@surfacebook>
In-Reply-To: <ZHkQDTvk6I2q-9CF@surfacebook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Jun 2023 08:51:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
Message-ID: <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
To:     andy.shevchenko@gmail.com
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

CC GregKH

On Thu, Jun 1, 2023 at 11:40 PM <andy.shevchenko@gmail.com> wrote:
> Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang kirjoitti:
> > This is a sloppy logic analyzer using GPIOs. It comes with a script to
> > isolate a CPU for polling. While this is definitely not a production
> > level analyzer, it can be a helpful first view when remote debugging.
> > Read the documentation for details.
>
> One note since I have done recent review and realize one issue with debugfs.
>
> ...
>
> > +     priv->debug_dir = debugfs_create_dir(devname, gpio_la_poll_debug_dir);
>
> If this fails with NULL...
>
> > +     debugfs_create_blob("meta_data", 0400, priv->debug_dir, &priv->meta);
> > +     debugfs_create_ulong("delay_ns", 0600, priv->debug_dir, &priv->delay_ns);
> > +     debugfs_create_ulong("delay_ns_acquisition", 0400, priv->debug_dir, &priv->acq_delay);
> > +     debugfs_create_file_unsafe("buf_size", 0600, priv->debug_dir, priv, &fops_buf_size);
> > +     debugfs_create_file_unsafe("capture", 0200, priv->debug_dir, priv, &fops_capture);
> > +     debugfs_create_file_unsafe("trigger", 0200, priv->debug_dir, priv, &fops_trigger);
>
> ...and any of these is not, we will end up with the file in a root folder of debugfs...
>
> > +     dev_info(dev, "initialized");
>
> ...
>
> > +static int gpio_la_poll_remove(struct platform_device *pdev)
> > +{
> > +     struct gpio_la_poll_priv *priv = platform_get_drvdata(pdev);
> > +
> > +     mutex_lock(&priv->lock);
> > +     debugfs_remove_recursive(priv->debug_dir);
>
> ...and this one won't remove it.
>
> > +     mutex_unlock(&priv->lock);
> > +     mutex_destroy(&priv->lock);
> > +
> > +     return 0;
> > +}
>
> ...
>
> However, I haven't checked if it's pure theoretical issue with the current code
> base of debugfs or a potential problem. Easy fix is to check an error code and

I think debugfs_create_dir() can only fail reasonably due to OOM.

> skip the files creation. Not sure if driver will be useful in that case.

Having to add such error checks would really be unfortunate, because
one of the design principles of debugfs is that there is never a need
to check for errors.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
