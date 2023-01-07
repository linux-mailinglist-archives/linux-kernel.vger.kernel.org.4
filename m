Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA16660C99
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 06:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAGFoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 00:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAGFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 00:44:10 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3EE840A9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 21:44:08 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id i185so3579425vsc.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 21:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xVOvUXIxXHGoJc1RNEJDnYnyJOQ4H4zXliT+/36ft90=;
        b=ZyG0V7jq7NAy8AJxDI7/EU2U+MZeRpD+iXBRi4jxWLTU0lxeRWudQndiBFDYPtnxlt
         8378mG02AEC93Al/JchoTCV23LIeNhqCC+3Qa/8WDACdymL54TpZ1FKVShbpIwKc9PNB
         2Rfrid6d49f9U9z2kFkhNa4adGILwKueoAIPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVOvUXIxXHGoJc1RNEJDnYnyJOQ4H4zXliT+/36ft90=;
        b=shfbdBKJbtG52/NcVZ7MrgBE5xblrWax1G4Pu/4qRvmeClAlDjppoYnUQxrlOnxuXX
         LekqAGjUh3dPiAzNwgd41+YRpz4oYmktE0AX74UPPRzGc1piz+KIrTiD5KoAwekMLYVg
         hiT9BB6I3vMiQZ4VVcrX/tgDZA3T1jutKxMJ6C+izAganFIavZfULQPp+mrJ4L55KI0Z
         GYFfng59O23KugImaqpamwKGk3ry15elD4O8uMpkIYnsSudTpDYiyG5PQopn5RSCbiOK
         wWjxWRYsYrUgCFEDYmsFVUoEB0meuiATFpC0xcGeuRSWwpf65Z6eh4RRnOg6i1SxNvkw
         lo8w==
X-Gm-Message-State: AFqh2kpnWWjrxKH0EaPYiDgLipyL3CxM1khk9yor/52DdDrq7yTkswsr
        qiC7IvF7/0MFvLYyGOqitBiip6uYi4cxvr3wDTtuaA==
X-Google-Smtp-Source: AMrXdXtvfHpboGi3+kQNwiHMAefcbd5zPgsZn5cmMiEll6r3JYwBIs6oorMmBBWfIYDvWi+By4kLIePyNBkdA2HLIY0=
X-Received: by 2002:a67:fbc2:0:b0:3cc:fb59:8c71 with SMTP id
 o2-20020a67fbc2000000b003ccfb598c71mr3384556vsr.65.1673070248034; Fri, 06 Jan
 2023 21:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20230106045537.1243887-1-wenst@chromium.org> <Y7flCydDtLVwsXIJ@google.com>
In-Reply-To: <Y7flCydDtLVwsXIJ@google.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Sat, 7 Jan 2023 13:43:57 +0800
Message-ID: <CAGXv+5Gnc6tCjO95VjBJ4F5p5bnS+M96at3ErpSX==3qPwNUsg@mail.gmail.com>
Subject: Re: [PATCH] platform/chromeos: cros_ec: Use per-device lockdep key
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 5:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 12:55:37PM +0800, Chen-Yu Tsai wrote:
> > Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> > the following lock sequences:
> >
> > 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> > 2. lock(&ec_dev->lock); lock(prepare_lock);
> >
> > The actual dependency chains are much longer. The shortened version
> > looks somewhat like:
> >
> > 1. cros-ec-rpmsg on mtk-scp
> >    ec_dev->lock -> prepare_lock
> > 2. In rt5682_i2c_probe() on native I2C bus:
> >    prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
> > 3. In rt5682_i2c_probe() on native I2C bus:
> >    regmap->lock -> i2c_adapter->bus_lock
> > 4. In sbs_probe() on cros-ec-i2c (passthrough) I2C bus on cros-ec
> >    i2c_adapter->bus_lock -> ec_dev->lock
> >
> > While lockdep is correct that the shared lockdep classes have a circular
> > dependency, it is bogus because
> >
> >   a) 2+3 happen on a native I2C bus
> >   b) 4 happens on the actual EC on ChromeOS devices
> >   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
> >      happen to expose a cros-ec interface, but do not have a passthrough
> >      I2C bus
> >
> > In short, the "dependencies" are actually on different devices.
>
> Path of 4 looks weird to me.
>
> Could you point out where sbs_probe() gets to acquire ec_dev->lock?

sbs_probe() calls sbs_get_battery_presence_and_health(), which

  -> does an I2C transfer. This SBS instance is connected on the I2C bus
     on the EC, so the I2C transfer

     -> acquires i2c_adapter->bus_lock, and

       -> calls ec_i2c_xfer(), which

          -> calls cros_ec_cmd_xfer_status(), which

             -> calls cros_ec_cmd_xfer(), which

               -> acquires ec_dev->lock


> I may misunderstand: I thought there is no such I2C bus for passthrough
> from kernel's point of view (as the bus and devices behind the EC).
> See also [2].

It is an I2C adapter on the EC, also known as i2c-cros-ec-tunnel.
Passthrough probably isn't the right word.

> [2]: https://elixir.bootlin.com/linux/v6.2-rc2/source/drivers/platform/chrome/cros_ec.c#L241
>
>
> On a related note, for the commit title: s/chromeos/chrome/ if it gets
> chance to have next version.

OK.


Thanks
ChenYu
