Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C76656E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjAKJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbjAKJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:05:34 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F142AF2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:03:42 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id a64so15021000vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CuDeia0CiKF+kBYrZ/MDemWf2Ns0OMCpwHIl94bJeDQ=;
        b=SixLufghEGhPEmxxlP0A0/uka1fXtkDi/h1sYVTDiDGSlE0gbb40W49vQf0gi91EE0
         0IegYvFndksHzUGIFeissTjQDwqojJcWExswCWYzIvSlpvvSAZ+P8xpLv9AG490w1gIf
         WEHEqyme0EAovtS1Mln9nBgIy2p+jVZQbvQpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuDeia0CiKF+kBYrZ/MDemWf2Ns0OMCpwHIl94bJeDQ=;
        b=o1ztLBi2JTBvxd+DBl8tWmuuwoYGLjn7Vu+0jaVVktFHIMAefj6QxTI42DT0BC39Kx
         qARh2R1iR2R2GEM7jG4K0VXnWc0VxpNkdjFiMDEB3DZ+qat79Wfc57FOOh5ksxRx5UTY
         /0l740Z9xzwzDoDgAYaO35vVAe1YNCyxLbBcpF9Kw8iIWQ5DrdgKZtkgxWTe3PRnHMDw
         Gi5MkbuGKAt1F0qXU8pdkddnLTay3GkSK/i354XvtGe2UYQ4rMRk3EixItEwVGg1YPXq
         6vJ6Y84y0qjmcnrsyHRVljkUnXqDZL8xYLGoRwQTNGSqZkEi5T633tinI09mvr97nKR0
         RV/w==
X-Gm-Message-State: AFqh2kpBE8gEeXkLjMSpeW6HgZHzM0ykOpdrP9v1g1UUvJtWScLv7y2y
        6xS3Mi8wDMHH6cQ7OwV72FkNbecR46jQn/dDDNYsoQ==
X-Google-Smtp-Source: AMrXdXsFyoid4ItvwTPHWthZr/uIBj7vvrNjoGsRDiCIZPGJwqc3YKf8CK+48+Q+6SePCDAmPYVJtoonKfk5B/4kQek=
X-Received: by 2002:a67:447:0:b0:3ce:d0ae:f6f6 with SMTP id
 68-20020a670447000000b003ced0aef6f6mr4429984vse.26.1673427813282; Wed, 11 Jan
 2023 01:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20230111074146.2624496-1-wenst@chromium.org> <CAGXv+5HTOR2Nt5CtmiYx2jrJ-0=YjFaGnQXesRBNFMoogsHJQw@mail.gmail.com>
In-Reply-To: <CAGXv+5HTOR2Nt5CtmiYx2jrJ-0=YjFaGnQXesRBNFMoogsHJQw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 11 Jan 2023 17:03:22 +0800
Message-ID: <CAGXv+5FtXn3Q7Y_om11vh-rkw_mKC_8k4XdTVLN4z7xefrzTDw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Use per-device lockdep key
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
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

On Wed, Jan 11, 2023 at 4:47 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Wed, Jan 11, 2023 at 3:41 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
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
> > 4. In sbs_probe() on i2c-cros-ec-tunnel I2C bus attached on cros-ec:
> >    i2c_adapter->bus_lock -> ec_dev->lock
> >
> > While lockdep is correct that the shared lockdep classes have a circular
> > dependency, it is bogus because
> >
> >   a) 2+3 happen on a native I2C bus
> >   b) 4 happens on the actual EC on ChromeOS devices
> >   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
> >      happens to expose a cros-ec interface, but does not have an
> >      i2c-cros-ec-tunnel I2C bus
> >
> > In short, the "dependencies" are actually on different devices.
> >
> > Setup a per-device lockdep key for cros_ec devices so lockdep can tell
> > the two instances apart. This helps with getting rid of the bogus
> > lockdep warning. For ChromeOS devices that only have one cros-ec
> > instance this doesn't change anything.
>
> Actually, hold off on this for a bit. I just realized this makes the
> kernel give a big warning:
>
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
>
> CPU: 0 PID: 99 Comm: kworker/u16:3 Not tainted
> 6.2.0-rc3-next-20230111-04021-g65853aed7123-dirty #472
> 8115f54190814e6abf2d53f6a2194c1af0b27040
> Hardware name: Google juniper sku16 board (DT)
> Workqueue: events_unbound async_run_entry_fn
> Call trace:
>  dump_backtrace.part.0+0xb4/0xf8
>  show_stack+0x20/0x38
>  dump_stack_lvl+0x88/0xb4
>  dump_stack+0x18/0x34
>  register_lock_class+0x16c/0x40c
>  __lock_acquire+0xa0/0x1064
>  lock_acquire+0x1f0/0x2f0
>  down_write+0x5c/0x80
>  __blocking_notifier_chain_register+0x64/0x84
>  blocking_notifier_chain_register+0x1c/0x28
>  cros_ec_debugfs_probe+0x218/0x3ac
>  platform_probe+0x70/0xc4
>  really_probe+0x158/0x290
>  __driver_probe_device+0xc8/0xe0
>  driver_probe_device+0x44/0x100
>  __device_attach_driver+0x64/0xdc
>  bus_for_each_drv+0xa0/0xc8
>  __device_attach_async_helper+0x70/0xc4
>  async_run_entry_fn+0x3c/0xe4
>  process_one_work+0x2d0/0x48c
>  worker_thread+0x204/0x274
>  kthread+0xe8/0xf8
>  ret_from_fork+0x10/0x20

I think this is caused by

    d90fa2c64d59 platform/chrome: cros_ec: Poll EC log on EC panic

That commit is missing a BLOCKING_INIT_NOTIFIER_HEAD() call.

ChenYu
