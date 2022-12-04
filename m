Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4854D6420A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 00:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLDXzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 18:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLDXzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 18:55:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB9B1FB;
        Sun,  4 Dec 2022 15:55:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h193so9015414pgc.10;
        Sun, 04 Dec 2022 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHlZGpeZlTuBVPZFLOSWn4tUqUYQHoDhbXM9z/ibwxk=;
        b=NVPCNqIYQwJ9riFBXF9JBy0G6xWfj+kYEuyG/U/R9TRpQlNH0ftWSX5J+oxMxU5RZI
         cp6krhYjoSadBWzHh4U0D0CbqBmnQ80pjtWYKW5USrbj4LMmMqDTZoH0WymauCZk5PLa
         f5THaB5h+f134C/UwnY3U0fVLlycd3mzSe65ilIIIMu1/6HkyLvymnZNIzarKelrwOb/
         MwpTEc0FPShO2Ho3FGnJUOa66Pdv1YSwUU7GxXAoOewSP7Nh+DQNm4ykxMw6zVcY7BVZ
         RpeFezVWxW1/d3O1CJXnht0Aeh46fE4r1bb/67Z0455qAKKa3tYVWHLhNHCi6AVIiNC2
         O6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHlZGpeZlTuBVPZFLOSWn4tUqUYQHoDhbXM9z/ibwxk=;
        b=Vs9tFYVABnj8/HNBzZPNSl5Y3LydGCFIzxMGtm3WgjGOdMY5/ygveG8WWvsY1IAjMy
         +GrJWHikzLy6AdXx0/O6ZcTnL7dpAc+PteH0idM2vSLLg0sXX57dCLDJ9MG3g0ZrMp7J
         U/KVYaYpN5guq/bZ5Bvr8mRDlJxfRhpuZ3a1vPzt27qEW+ZC5h3waiwrMB69Xu0Szixt
         AUiA5u5XuYmSbwYpcqoBC7gDSqY1fVfa73w6aFvO57q+qdN3OtwonMwopQbzZR3Kux5c
         urRoRBuJaFedD6YQKL6DVr3usaYrMV2qUekbXgqCF5R/yc7C94f2ozi8qwmKkrPe7SIH
         tXvQ==
X-Gm-Message-State: ANoB5pkSRE/PA9rjGk01sTvYX9sVyrLZdhJFNPWZuea+1127/XJCmwFq
        i8JXjq7buJKXq1Yb+7Wx6qc=
X-Google-Smtp-Source: AA0mqf4pMxxhbRVxKZP9kRnJWpyGf5dQqY829R1P8RGw1dgjRNh6xo628tCXNeoJ+fmMbjg0u+d7KQ==
X-Received: by 2002:a63:cd44:0:b0:478:1391:fc43 with SMTP id a4-20020a63cd44000000b004781391fc43mr31855466pgj.431.1670198123613;
        Sun, 04 Dec 2022 15:55:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:ea63:b7ba:2a89:fec])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b0056f0753390csm8802078pfg.96.2022.12.04.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 15:55:22 -0800 (PST)
Date:   Sun, 4 Dec 2022 15:55:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Li Yang <leoyang.li@nxp.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [RESEND PATCH] soc: fsl: qe: request pins non-exclusively
Message-ID: <Y40zZ8fkE9d1zbbV@google.com>
References: <Y4wnGgMLOr04RwvU@google.com>
 <81a7715b-559f-4c5c-bdb6-1aa00d409155@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a7715b-559f-4c5c-bdb6-1aa00d409155@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 01:10:19PM +0100, Arnd Bergmann wrote:
> On Sun, Dec 4, 2022, at 05:50, Dmitry Torokhov wrote:
> >
> > SoC team, the problematic patch has been in next for a while and it
> > would be great to get the fix in to make sure the driver is not broken
> > in 6.2. Thanks!
> 
> I have no problem taking thsi patch, but I get a merge conflict that
> I'm not sure how to resolve:
> 
> 
> @@@ -186,23 -182,27 +180,43 @@@ struct qe_pin *qe_pin_request(struct de
>         if (WARN_ON(!gc)) {
>                 err = -ENODEV;
>                 goto err0;
> ++<<<<<<< HEAD
>  +      }
>  +      qe_pin->gpiod = gpiod;
>  +      qe_pin->controller = gpiochip_get_data(gc);
>  +      /*
>  +       * FIXME: this gets the local offset on the gpio_chip so that the driver
>  +       * can manipulate pin control settings through its custom API. The real
>  +       * solution is to create a real pin control driver for this.
>  +       */
>  +      qe_pin->num = gpio_chip_hwgpio(gpiod);
>  +
>  +      if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
>  +              pr_debug("%s: tried to get a non-qe pin\n", __func__);
>  +              gpiod_put(gpiod);
> ++=======
> +       } else if (!fwnode_device_is_compatible(gc->fwnode,
> +                                               "fsl,mpc8323-qe-pario-bank")) {
> +               dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
> ++>>>>>>> soc: fsl: qe: request pins non-exclusively
>                 err = -EINVAL;
> -               goto err0;
> +       } else {
> +               qe_pin->controller = gpiochip_get_data(gc);
> +               /*
> +                * FIXME: this gets the local offset on the gpio_chip so that
> +                * the driver can manipulate pin control settings through its
> +                * custom API. The real solution is to create a real pin control
> +                * driver for this.
> +                */
> +               qe_pin->num = desc_to_gpio(gpiod) - gc->base;
>         }
> 
> Could you rebase the patch on top of the soc/driver branch in the
> soc tree and send the updated version?

I see, it conflicts with:

	c9eb6e546a23 soc: fsl: qe: Switch to use fwnode instead of of_node

that is in next but not in soc/driver tree/branch. OK, I'll rebase and I
just noticed that I was leaking gpiod in case we could not locate gc
(unlikely but still...).

Thanks.

-- 
Dmitry
