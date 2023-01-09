Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E4661F48
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjAIHf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjAIHfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:35:23 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A531BA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:35:20 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id l3so430646vkk.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 23:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0suxQdAcQu0p2UKz47c1j8q2hACyOlrOS3RM69ysgcU=;
        b=Sr6WYLcxn0+IUm77HQaJ5O6/6vU8v2M3Kb0i3kRohqyTL55ykUNdkLJf1RtLIwGRIR
         wRGGlIYb9QTocNQdDknipspG7Zvv9Rr4QCZDhTdams+Sh2OXM+zEMCQk7G1lsRBMWvYW
         DlUKs1dhkelMXvZ8AbmvFsOTYgMDdgkXghqTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0suxQdAcQu0p2UKz47c1j8q2hACyOlrOS3RM69ysgcU=;
        b=YLCAATlxPzvbOf6GhTyuQ0f+8V3DPb90ZDsF6sOP/MNKenvq5tbFTjVpeeuudLH6fm
         H+4zCBQqrHYlWeArhM+hAzAKh67yCwllpetCQRDnUhMxUTPaPuKfgGaySgKha3q3z+Eu
         +uOLF00voXI7YNxue319ctHtwtMlFB5cbdk8p2Q2Ifq1jugy2wW8PgB1L9w3Y6RMBcV+
         ob77Yqdr0lvZXwCOyAETfMpj7zsJD6wdiLKVXRiXQs87r9Ba78TJBvxkYCsAXgTMYiKx
         jVC8FUydJkS2cReSkge8RJKSoglZZsgP/ftvG5atG8+ytAheJK1mv38f7DKFJb0XB5h/
         q9HA==
X-Gm-Message-State: AFqh2kpUEcLC8KDsQEu+0Ecy3K3NDSA0bs6LgCjsMWStLYJw6FsjtT/B
        GlyQ/PwbH23D/QP3rJzqe1NR+QoigWya3coqO2U4NQ==
X-Google-Smtp-Source: AMrXdXup+yxUrF9QQjUzNYfkBT9Vi3LgwtinciNz13DOlCZHzAo9Y/3pKDZ7DrtYumSWVbHr+kwY8Ca83HtT58fSH+0=
X-Received: by 2002:a1f:940a:0:b0:3bd:e439:84e4 with SMTP id
 w10-20020a1f940a000000b003bde43984e4mr7518397vkd.11.1673249719507; Sun, 08
 Jan 2023 23:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20230106045537.1243887-1-wenst@chromium.org> <Y7flCydDtLVwsXIJ@google.com>
 <CAGXv+5Gnc6tCjO95VjBJ4F5p5bnS+M96at3ErpSX==3qPwNUsg@mail.gmail.com>
 <Y7uqJ+DPyqFxaQUV@google.com> <CAGXv+5GNUyVpe5P7QazHB6K37C_0dNLwoP9gWKhgAbfXWRxJwA@mail.gmail.com>
 <Y7vCeNzJMn0nOrla@google.com>
In-Reply-To: <Y7vCeNzJMn0nOrla@google.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 9 Jan 2023 15:35:08 +0800
Message-ID: <CAGXv+5FELCKmmU2tiETGagOk+83x8OkYAxFTTxt+9tRdsujtmA@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 3:30 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Jan 09, 2023 at 02:19:38PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Jan 9, 2023 at 1:46 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > >
> > > On Sat, Jan 07, 2023 at 01:43:57PM +0800, Chen-Yu Tsai wrote:
> > > > On Fri, Jan 6, 2023 at 5:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jan 06, 2023 at 12:55:37PM +0800, Chen-Yu Tsai wrote:
> > > > > > Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> > > > > > the following lock sequences:
> > > > > >
> > > > > > 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> > > > > > 2. lock(&ec_dev->lock); lock(prepare_lock);
> > > > > >
> > > > > > The actual dependency chains are much longer. The shortened version
> > > > > > looks somewhat like:
> > > > > >
> > > > > > 1. cros-ec-rpmsg on mtk-scp
> > > > > >    ec_dev->lock -> prepare_lock
> > > > > > 2. In rt5682_i2c_probe() on native I2C bus:
> > > > > >    prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
> > > > > > 3. In rt5682_i2c_probe() on native I2C bus:
> > > > > >    regmap->lock -> i2c_adapter->bus_lock
> > > > > > 4. In sbs_probe() on cros-ec-i2c (passthrough) I2C bus on cros-ec
> > > > > >    i2c_adapter->bus_lock -> ec_dev->lock
> > > > > >
> > > > > > While lockdep is correct that the shared lockdep classes have a circular
> > > > > > dependency, it is bogus because
> > > > > >
> > > > > >   a) 2+3 happen on a native I2C bus
> > > > > >   b) 4 happens on the actual EC on ChromeOS devices
> > > > > >   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
> > > > > >      happen to expose a cros-ec interface, but do not have a passthrough
> > > > > >      I2C bus
> > > > > >
> > > > > > In short, the "dependencies" are actually on different devices.
> > > > >
> > > > > Path of 4 looks weird to me.
> > > > >
> > > > > Could you point out where sbs_probe() gets to acquire ec_dev->lock?
> > > >
> > > > sbs_probe() calls sbs_get_battery_presence_and_health(), which
> > > >
> > > >   -> does an I2C transfer. This SBS instance is connected on the I2C bus
> > > >      on the EC, so the I2C transfer
> > > >
> > > >      -> acquires i2c_adapter->bus_lock, and
> > >
> > > I see.
> > >
> > > Another question: the i2c_adapter here should be different from the native
> > > I2C bus in 2 and 3.  Did they really form the circular dependencies?
> >
> > That's why it's a false positive. lockdep normally doesn't track individual
> > instances, only classes of locks. The class is declared as part of the
> > mutex_init() macro.
>
> Is the following understanding correct:
> It has 2 ways to break the "fake" circular dependencies: separate lockdep key
> for i2c_adapter vs. ec_dev.  The patch adopts the latter one because it has
> limited impact for other I2C-related drivers.

That's correct.
