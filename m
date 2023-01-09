Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CED661F39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjAIHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjAIHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:30:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3BC12AD0
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:30:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D5A60F2B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B43C433D2;
        Mon,  9 Jan 2023 07:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673249403;
        bh=1Hq0DEnK2923z/BKZOvwoVQzsKees+S8IR/4o9Xr5e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAPBxfbBLo2bt/mvY390pjTOZfD+YMH3IZlGduyIrr08wNdsJb3pa6bF8uMUtMtP/
         oHlg8w1R8wHc1Osqr7v7fSr3SO8vGu3JNiOPKIppSRDNA9qde2YFxtmty0rzgj8BIm
         9eN7F+SysFqMC69dpzWNaQcQQxtNqZ5cIetO/zuSW/9hXwJ9dtV1QKwn1ArBWC/Uc6
         HrV+ClK+r6gdt5b5OIn/lvATpKuxgI4KBvZfCHYn7IeyD2T8yBiCYqDZ7gSg3wcI2n
         1sFZ+6Cia4ZyW/y/TTJrAb4XGqd/3LWgIIC23Dy8F7F1rUTbw75aM9+CrZ05R3plN9
         2XG4vVBumf0oQ==
Date:   Mon, 9 Jan 2023 15:30:00 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chromeos: cros_ec: Use per-device lockdep key
Message-ID: <Y7vCeNzJMn0nOrla@google.com>
References: <20230106045537.1243887-1-wenst@chromium.org>
 <Y7flCydDtLVwsXIJ@google.com>
 <CAGXv+5Gnc6tCjO95VjBJ4F5p5bnS+M96at3ErpSX==3qPwNUsg@mail.gmail.com>
 <Y7uqJ+DPyqFxaQUV@google.com>
 <CAGXv+5GNUyVpe5P7QazHB6K37C_0dNLwoP9gWKhgAbfXWRxJwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5GNUyVpe5P7QazHB6K37C_0dNLwoP9gWKhgAbfXWRxJwA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 02:19:38PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jan 9, 2023 at 1:46 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Sat, Jan 07, 2023 at 01:43:57PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Jan 6, 2023 at 5:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 06, 2023 at 12:55:37PM +0800, Chen-Yu Tsai wrote:
> > > > > Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> > > > > the following lock sequences:
> > > > >
> > > > > 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> > > > > 2. lock(&ec_dev->lock); lock(prepare_lock);
> > > > >
> > > > > The actual dependency chains are much longer. The shortened version
> > > > > looks somewhat like:
> > > > >
> > > > > 1. cros-ec-rpmsg on mtk-scp
> > > > >    ec_dev->lock -> prepare_lock
> > > > > 2. In rt5682_i2c_probe() on native I2C bus:
> > > > >    prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
> > > > > 3. In rt5682_i2c_probe() on native I2C bus:
> > > > >    regmap->lock -> i2c_adapter->bus_lock
> > > > > 4. In sbs_probe() on cros-ec-i2c (passthrough) I2C bus on cros-ec
> > > > >    i2c_adapter->bus_lock -> ec_dev->lock
> > > > >
> > > > > While lockdep is correct that the shared lockdep classes have a circular
> > > > > dependency, it is bogus because
> > > > >
> > > > >   a) 2+3 happen on a native I2C bus
> > > > >   b) 4 happens on the actual EC on ChromeOS devices
> > > > >   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
> > > > >      happen to expose a cros-ec interface, but do not have a passthrough
> > > > >      I2C bus
> > > > >
> > > > > In short, the "dependencies" are actually on different devices.
> > > >
> > > > Path of 4 looks weird to me.
> > > >
> > > > Could you point out where sbs_probe() gets to acquire ec_dev->lock?
> > >
> > > sbs_probe() calls sbs_get_battery_presence_and_health(), which
> > >
> > >   -> does an I2C transfer. This SBS instance is connected on the I2C bus
> > >      on the EC, so the I2C transfer
> > >
> > >      -> acquires i2c_adapter->bus_lock, and
> >
> > I see.
> >
> > Another question: the i2c_adapter here should be different from the native
> > I2C bus in 2 and 3.  Did they really form the circular dependencies?
> 
> That's why it's a false positive. lockdep normally doesn't track individual
> instances, only classes of locks. The class is declared as part of the
> mutex_init() macro.

Is the following understanding correct:
It has 2 ways to break the "fake" circular dependencies: separate lockdep key
for i2c_adapter vs. ec_dev.  The patch adopts the latter one because it has
limited impact for other I2C-related drivers.
