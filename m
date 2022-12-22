Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D06539FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLVAI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:08:53 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143CF1403B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:08:52 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-45c11d1bfc8so7127827b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gRJiaMBN5q0w63AV8y2lpXPrHKb44IbAvEnQCP+/w78=;
        b=ltr0IRNdED3tcQyKKmA6vC2ztlwcFPDYcV2FrMx+nNuKthK6Rlp9ZA0DtcD98U++tc
         Y2WcM6v48jVYEJ4dEmomek8JUu/2Nx7uujy0Ws4yFsJHwbl2DUuNJGQvlh52putC3AAP
         lmLn6g0XVrzrlqmAf8BS81xWCY0Vb3tb9+Bk0jh5rmL3CpVtYZwDdxwX6aiyeHYfoQy0
         oSQXKvGUTgCuZrYJd+cNP1SoR0YQ8L9FHoaGnvG5+rWep6AlYUBzbIgCaHG6ybTZRhHM
         rRb0sXiubW3z7Rt829kfJjvEm5hGlXe1oaqo0tgXFbZNAyjGZxcfLYdS3oPQRMirmFIJ
         fqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRJiaMBN5q0w63AV8y2lpXPrHKb44IbAvEnQCP+/w78=;
        b=PTA8tV4G1V5si7mgqswHFy7dvf5EmpCewLb7ud1OKSe2LYvFiRkseZCcm14OgZNAED
         mXwpFl4hR83yWw1Rbn/FjtAj/92/9UpQFHmDrDxw+zOub+2er8v8yXn1b5DqYxjRCaUz
         xvqi2WFq8Rluyl6ljLZ8mh7sT/0TiJCKJmwoXJyk8vDv9M/oTCxTmhpsUKnwz7bkkJnB
         9T7N/2h6arSnau2yfYM8ELGCgvOkPJWxbcD0rwUGY/tmLMZHVl+wllWriXqo8fRYjJd7
         gfJ5YMuAF45pF2QGO/RjMCXsrpfgTJ8Ul0FtFmSgwnzaCW5iOom/PfO6P8YcHBtvRq9+
         5Lfw==
X-Gm-Message-State: AFqh2koZ/AGAc3cMnBibl7YXYnjvjS2E7ecEC4k2Ntlwy+wTYY3Caw15
        5vVJzEBLYttNjdBFNGjlpvW/xvqG9fpAtCwpXWYZaA==
X-Google-Smtp-Source: AMrXdXtxti6TUYNedXjSlbb50sB2ItknfQ43lWElm2HOSR6vNaJnf6iD0ID5rz0S83rNBjt7UWVubWmkfJNjSuo6bIo=
X-Received: by 2002:a81:f111:0:b0:3df:6a50:40ec with SMTP id
 h17-20020a81f111000000b003df6a5040ecmr373835ywm.340.1671667731127; Wed, 21
 Dec 2022 16:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20221221185540.2265771-1-robbarnes@google.com>
 <CABXOdTcHppsLTDTXBd9ikL+Hk8W4oW_NkWMhOJgmf9aDSW+FKA@mail.gmail.com> <CA+Dqm32+G+PGYDw+KbYLN5unK3Q6Oc6cC6EJDhsQ2ZipKT+9Gw@mail.gmail.com>
In-Reply-To: <CA+Dqm32+G+PGYDw+KbYLN5unK3Q6Oc6cC6EJDhsQ2ZipKT+9Gw@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 21 Dec 2022 16:08:40 -0800
Message-ID: <CABXOdTdKNSfEbRAjrPTrCghb05xMNLrqhTz1C+G_UCnpMBJL+A@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Handle CrOS EC panics
To:     Rob Barnes <robbarnes@google.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 3:56 PM Rob Barnes <robbarnes@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 1:07 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Wed, Dec 21, 2022 at 10:56 AM Rob Barnes <robbarnes@google.com> wrote:
> > >
> > > Add handler for CrOS EC panic events. When a panic is reported,
> > > poll EC log then force an orderly shutdown.
> > >
> > > This will preserve the EC log leading up to the crash.
> > >
> > > Signed-off-by: Rob Barnes <robbarnes@google.com>
> > > ---
> > >  drivers/platform/chrome/cros_ec_debugfs.c   | 24 +++++++++++++++++++++
> > >  drivers/platform/chrome/cros_ec_lpc.c       | 10 +++++++++
> > >  include/linux/platform_data/cros_ec_proto.h |  9 ++++++++
> > >  3 files changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> > > index 21d973fc6be2..31637a4e4cf9 100644
> > > --- a/drivers/platform/chrome/cros_ec_debugfs.c
> > > +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> > > @@ -49,6 +49,7 @@ struct cros_ec_debugfs {
> > >         struct delayed_work log_poll_work;
> > >         /* EC panicinfo */
> > >         struct debugfs_blob_wrapper panicinfo_blob;
> > > +       struct notifier_block notifier_panic;
> > >  };
> > >
> > >  /*
> > > @@ -437,6 +438,23 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
> > >         return ret;
> > >  }
> > >
> > > +static int cros_ec_debugfs_panic_event(struct notifier_block *nb,
> > > +                                      unsigned long queued_during_suspend,
> > > +                                      void *_notify)
> > > +{
> > > +       struct cros_ec_debugfs *debug_info =
> > > +               container_of(nb, struct cros_ec_debugfs, notifier_panic);
> > > +
> > > +       if (debug_info->log_buffer.buf) {
> > > +               /* Force log poll work to run immediately */
> > > +               mod_delayed_work(debug_info->log_poll_work.wq, &debug_info->log_poll_work, 0);
> > > +               /* Block until log poll work finishes */
> > > +               flush_delayed_work(&debug_info->log_poll_work);
> > > +       }
> > > +
> > > +       return NOTIFY_DONE;
> > > +}
> > > +
> > >  static int cros_ec_debugfs_probe(struct platform_device *pd)
> > >  {
> > >         struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> > > @@ -473,6 +491,12 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
> > >         debugfs_create_u16("suspend_timeout_ms", 0664, debug_info->dir,
> > >                            &ec->ec_dev->suspend_timeout_ms);
> > >
> > > +       debug_info->notifier_panic.notifier_call = cros_ec_debugfs_panic_event;
> > > +       ret = blocking_notifier_chain_register(&ec->ec_dev->panic_notifier,
> > > +                                              &debug_info->notifier_panic);
> > > +       if (ret)
> > > +               goto remove_debugfs;
> > > +
> > >         ec->debug_info = debug_info;
> > >
> > >         dev_set_drvdata(&pd->dev, ec);
> > > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > > index 7fc8f82280ac..21958c3b0c28 100644
> > > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/platform_data/cros_ec_proto.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/printk.h>
> > > +#include <linux/reboot.h>
> > >  #include <linux/suspend.h>
> > >
> > >  #include "cros_ec.h"
> > > @@ -332,6 +333,15 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
> > >
> > >         if (value == ACPI_NOTIFY_DEVICE_WAKE)
> > >                 pm_system_wakeup();
> > > +
> > > +       if (value == ACPI_NOTIFY_CROS_EC_PANIC) {
> > > +               dev_err(ec_dev->dev,
> > > +                       "CrOS EC Panic Reported. Shutdown is imminent!");
> >
> > dev_emerg() would seem to be more appropriate, given that we'll be
> > crashing a second later.
>
> Makes sense. Will do.
>
> >
> > > +               blocking_notifier_call_chain(&ec_dev->panic_notifier, 0,
> > > +                                            ec_dev);
> > > +               /* Begin orderly shutdown. Force shutdown after 1 second. */
> > > +               hw_protection_shutdown("CrOS EC Panic", 1000);
> >
> > That seems to be the wrong API. From its description:
> >
> >  * Initiate an emergency system shutdown in order to protect hardware from
> >  * further damage. Usage examples include a thermal protection or a voltage or
> >  * current regulator failures.
> >
> > This is an EC crash that apparently can not be handled gracefully.
> > That has nothing to do with hardware protection. Why not just call
> > panic() ?
>
> I'm adding the ability for the EC to somewhat gracefully handle a
> class of panics. The EC will enter "system safe mode" aka limp mode.
> All tasks are disabled except for a few critical ones. The purpose of
> this mode is to give the OS a couple of seconds to extract info about
> the EC panic and shutdown as gracefully as possible. EC will still
> force a reset after 2 seconds.
>
> Since the EC is in a precarious, non deterministic state and the EC is
> at least partially responsible for thermal and power regulation, it is
> arguably a hardware protection event.
>

In my opinion it is an abuse of the API. I guess we have to agree to disagree.

Guenter

> The primary motivation for allowing the OS to attempt an orderly
> shutdown is to sync user data and EC panic data to storage. Will panic
> sync storage? Or will that need to be a seperate call?
>
> >
> > > +       }
> >
> > It troubles me that this comes last. That means the entire
> > mkbp_event_supported handling executes first. What troubles me even
> > more is that 'value' is, with the exception of
> > ACPI_NOTIFY_DEVICE_WAKE, not checked at all. Presumably the EC sends
> > some well defined value if it has an event to report. I don't think it
> > is a good idea to depend on cros_ec_get_next_event() returning
> > something useful after the EC crashed.
>
> Could certainly move the ACPI_NOTIFY_CROS_EC_PANIC to the top. I think
> 'value' will be 0x80 when there's MKBP events. I will validate this
> assumption.
>
> > How is this handled today ? Does the EC just reset the AP ?
>
> EC just immediately resets the AP and itself. System safe mode (see
> go/ec-system-safe-mode) will allow the EC to run a few seconds after
> some types of crashes.
>
>
>
> >
> > >  }
> > >
> > >  static int cros_ec_lpc_probe(struct platform_device *pdev)
> > > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > > index e43107e0bee1..1c4487271836 100644
> > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > @@ -41,6 +41,13 @@
> > >  #define EC_MAX_REQUEST_OVERHEAD                1
> > >  #define EC_MAX_RESPONSE_OVERHEAD       32
> > >
> > > +/*
> > > + * EC panic is not covered by the standard (0-F) ACPI notify values.
> > > + * Arbitrarily choosing B0 to notify ec panic, which is in the 84-BF
> > > + * device specific ACPI notify range.
> > > + */
> > > +#define ACPI_NOTIFY_CROS_EC_PANIC      0xB0
> > > +
> > >  /*
> > >   * Command interface between EC and AP, for LPC, I2C and SPI interfaces.
> > >   */
> > > @@ -176,6 +183,8 @@ struct cros_ec_device {
> > >         /* The platform devices used by the mfd driver */
> > >         struct platform_device *ec;
> > >         struct platform_device *pd;
> > > +
> > > +       struct blocking_notifier_head panic_notifier;
> > >  };
> > >
> > >  /**
> > > --
> > > 2.39.0.314.g84b9a713c41-goog
> > >
