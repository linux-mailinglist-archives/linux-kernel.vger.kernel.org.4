Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7E665670
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjAKIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjAKIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:47:42 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B803DF3C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:47:41 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id cb7so3488890uab.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZP8HsxExNYyzVB1ST5ZwO0Xtwgz2ixrWdtcp5jV9Xo=;
        b=O0AGmSfPILnwACr+4essOCug/2y5DUN03erWxjWQgzUn6mV0BEjH/DyRmIiwDKGqdz
         SdbTiV4IRkjzZbqOhyGW67ew7ou6NBFUwuD0EN4kHjUn25M0+eAQPNYMkGFGjOjFwQFQ
         hhDkGQmNygZTStZ+/10xljzXVm1sdOwtL+GJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZP8HsxExNYyzVB1ST5ZwO0Xtwgz2ixrWdtcp5jV9Xo=;
        b=GCmkkyaAXUYEOV/IBhb83KyoA/yXa4f+rW22WIxQuOmiiij70jKm2/+p4u22OOHu71
         RixdF8oEIPYqzzQ2vcBMBifGNRf5Oy4fZPMgnljrR2RNajGmba6p19bUEVAFbYk7q7W3
         LAeLKDSX9mFXSk15CG9kFSq1bWM2EcbctCMJ615MR6P5bKnlbJwj1wmXhrNhwClg2+Hd
         jwUtPqG0WGu34qQX7uH4SXRt5O01WkDvOVJhAr7+XX/SLS+QTUTEXuxLXTWa0aqx/1/n
         rDb0fvXy7GzlPjkVaA/eHgEif+8FO5IQEhC66HGi1m79SXxG13dRzi84kB8I7iOTdAdj
         8mxQ==
X-Gm-Message-State: AFqh2kqFwz6plMTD5ySTMSy9vNPR0oWBW/Q9uB3qlLf9fOep0wWe0gB/
        +MSGEvMIMwuZfBv/iuW5EXeFRX1u2hXiTzMPjAQ2obb0X0tekPtl
X-Google-Smtp-Source: AMrXdXvQHmtujSUw5YqZk5UbKSHJrTFz/HphmMcFnfSuHj1eSHk2t1ENGHzZUClOTcsrL5Hgz8u1y8XUpDX7Z2dHGAQ=
X-Received: by 2002:a9f:3189:0:b0:4c7:b2c7:d054 with SMTP id
 v9-20020a9f3189000000b004c7b2c7d054mr6886596uad.97.1673426860662; Wed, 11 Jan
 2023 00:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20230111074146.2624496-1-wenst@chromium.org>
In-Reply-To: <20230111074146.2624496-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 11 Jan 2023 16:47:29 +0800
Message-ID: <CAGXv+5HTOR2Nt5CtmiYx2jrJ-0=YjFaGnQXesRBNFMoogsHJQw@mail.gmail.com>
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

On Wed, Jan 11, 2023 at 3:41 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> the following lock sequences:
>
> 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> 2. lock(&ec_dev->lock); lock(prepare_lock);
>
> The actual dependency chains are much longer. The shortened version
> looks somewhat like:
>
> 1. cros-ec-rpmsg on mtk-scp
>    ec_dev->lock -> prepare_lock
> 2. In rt5682_i2c_probe() on native I2C bus:
>    prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
> 3. In rt5682_i2c_probe() on native I2C bus:
>    regmap->lock -> i2c_adapter->bus_lock
> 4. In sbs_probe() on i2c-cros-ec-tunnel I2C bus attached on cros-ec:
>    i2c_adapter->bus_lock -> ec_dev->lock
>
> While lockdep is correct that the shared lockdep classes have a circular
> dependency, it is bogus because
>
>   a) 2+3 happen on a native I2C bus
>   b) 4 happens on the actual EC on ChromeOS devices
>   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
>      happens to expose a cros-ec interface, but does not have an
>      i2c-cros-ec-tunnel I2C bus
>
> In short, the "dependencies" are actually on different devices.
>
> Setup a per-device lockdep key for cros_ec devices so lockdep can tell
> the two instances apart. This helps with getting rid of the bogus
> lockdep warning. For ChromeOS devices that only have one cros-ec
> instance this doesn't change anything.

Actually, hold off on this for a bit. I just realized this makes the
kernel give a big warning:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

CPU: 0 PID: 99 Comm: kworker/u16:3 Not tainted
6.2.0-rc3-next-20230111-04021-g65853aed7123-dirty #472
8115f54190814e6abf2d53f6a2194c1af0b27040
Hardware name: Google juniper sku16 board (DT)
Workqueue: events_unbound async_run_entry_fn
Call trace:
 dump_backtrace.part.0+0xb4/0xf8
 show_stack+0x20/0x38
 dump_stack_lvl+0x88/0xb4
 dump_stack+0x18/0x34
 register_lock_class+0x16c/0x40c
 __lock_acquire+0xa0/0x1064
 lock_acquire+0x1f0/0x2f0
 down_write+0x5c/0x80
 __blocking_notifier_chain_register+0x64/0x84
 blocking_notifier_chain_register+0x1c/0x28
 cros_ec_debugfs_probe+0x218/0x3ac
 platform_probe+0x70/0xc4
 really_probe+0x158/0x290
 __driver_probe_device+0xc8/0xe0
 driver_probe_device+0x44/0x100
 __device_attach_driver+0x64/0xdc
 bus_for_each_drv+0xa0/0xc8
 __device_attach_async_helper+0x70/0xc4
 async_run_entry_fn+0x3c/0xe4
 process_one_work+0x2d0/0x48c
 worker_thread+0x204/0x274
 kthread+0xe8/0xf8
 ret_from_fork+0x10/0x20

>
> Also add a missing mutex_destroy, just to make the teardown complete.
>
> [1] This is likely the per I2C bus lock with shared lockdep class
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Changed subject prefix from "chromeos" to "chrome"
> - Changed "passthrough I2C bus" to exact name, i2c-cros-ec-tunnel
> - Added kerneldoc for new "lockdep_key" field
>
>  drivers/platform/chrome/cros_ec.c           | 14 +++++++++++---
>  include/linux/platform_data/cros_ec_proto.h |  4 ++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index ec733f683f34..4ae57820afd5 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -198,12 +198,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         if (!ec_dev->dout)
>                 return -ENOMEM;
>
> +       lockdep_register_key(&ec_dev->lockdep_key);
>         mutex_init(&ec_dev->lock);
> +       lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
>
>         err = cros_ec_query_all(ec_dev);
>         if (err) {
>                 dev_err(dev, "Cannot identify the EC: error %d\n", err);
> -               return err;
> +               goto destroy_mutex;
>         }
>
>         if (ec_dev->irq > 0) {
> @@ -215,7 +217,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 if (err) {
>                         dev_err(dev, "Failed to request IRQ %d: %d\n",
>                                 ec_dev->irq, err);
> -                       return err;
> +                       goto destroy_mutex;
>                 }
>         }
>
> @@ -226,7 +228,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         if (IS_ERR(ec_dev->ec)) {
>                 dev_err(ec_dev->dev,
>                         "Failed to create CrOS EC platform device\n");
> -               return PTR_ERR(ec_dev->ec);
> +               err = PTR_ERR(ec_dev->ec);
> +               goto destroy_mutex;
>         }
>
>         if (ec_dev->max_passthru) {
> @@ -292,6 +295,9 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  exit:
>         platform_device_unregister(ec_dev->ec);
>         platform_device_unregister(ec_dev->pd);
> +destroy_mutex:
> +       mutex_destroy(&ec_dev->lock);
> +       lockdep_unregister_key(&ec_dev->lockdep_key);
>         return err;
>  }
>  EXPORT_SYMBOL(cros_ec_register);
> @@ -309,6 +315,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
>         if (ec_dev->pd)
>                 platform_device_unregister(ec_dev->pd);
>         platform_device_unregister(ec_dev->ec);
> +       mutex_destroy(&ec_dev->lock);
> +       lockdep_unregister_key(&ec_dev->lockdep_key);
>  }
>  EXPORT_SYMBOL(cros_ec_unregister);
>
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 017d502ed66e..3db26c891d5c 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -9,6 +9,7 @@
>  #define __LINUX_CROS_EC_PROTO_H
>
>  #include <linux/device.h>
> +#include <linux/lockdep_types.h>
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>
> @@ -122,6 +123,8 @@ struct cros_ec_command {
>   *            command. The caller should check msg.result for the EC's result
>   *            code.
>   * @pkt_xfer: Send packet to EC and get response.
> + * @lockdep_key: Lockdep class for each instance. Unused if CONFIG_LOCKDEP is
> + *              not enabled.
>   * @lock: One transaction at a time.
>   * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
>   *                        the maximum supported version of the MKBP host event
> @@ -166,6 +169,7 @@ struct cros_ec_device {
>                         struct cros_ec_command *msg);
>         int (*pkt_xfer)(struct cros_ec_device *ec,
>                         struct cros_ec_command *msg);
> +       struct lock_class_key lockdep_key;
>         struct mutex lock;
>         u8 mkbp_event_supported;
>         bool host_sleep_v1;
> --
> 2.39.0.314.g84b9a713c41-goog
>
