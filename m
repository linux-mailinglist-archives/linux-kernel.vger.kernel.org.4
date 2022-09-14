Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0395B8EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiINSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiINSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:33:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7C7330A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:33:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n81so12601880iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vSj623uSHxO0oVI/Q9wO/OKZArt2x1BaVoPyjdenhVw=;
        b=be+8kTLNJULJ2PK8PDlYNxkvOH9mMmtB2rahv3H4TKnEDphAAkmXCOE/IJeod6Hn7s
         5bfrqzY55uo+WMDgfUuRTLnl3LQV0KqxaKo9Hoaec6URvxcr4+Uuej3n9eNHdHp4OrQy
         hhupSd3M3qkMCC7pUEhaLICCpyPOIsfS/nENA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vSj623uSHxO0oVI/Q9wO/OKZArt2x1BaVoPyjdenhVw=;
        b=07jSOgkW7BpNXxkWouEQUy4Pj3Y1MMZgb+o6fFkZXAF4HuAhq5Ej8jP3QxdQcnzjTu
         pH6MVGhfoCdvF9tjYx8lD1Qo9MEvbLX1NxVvgwdNHC6N6kjk05VyyvshCb7vVSUVpZ1F
         7QuW5IRphdoSbqVumdS/ZFeAOsSRYQMvnvx2LeaW+h/4RUFlRWoRhheQKAo8gaAXfLS4
         HBu2B09pP2lQ8NeiEe9TZ21jQdcgTea/wCa5dJlw+oP9Kct0/SM81GDDhRZ869Y3hHlH
         mtuBSrWNVASyKmqexkt3xTNlVC+FGJP/ZW6jUeVG6L1gLhsQcf5/7tFKVfm2hk5EoIiq
         tz7A==
X-Gm-Message-State: ACgBeo0FZYuUImWVcJxSqNABjWDAC2cfLQF6dld5XAcqVkfkRIVKczjZ
        EvDtELqdVFt3ycxTLlvX9Kr3stdL4q1DiA==
X-Google-Smtp-Source: AA6agR523eCCt3hQQucYwv++rBFqXPD4RI6FwhB1alKebV/PK1NbqfS7oNbCss2oKednOp2Zq4XkJQ==
X-Received: by 2002:a05:6638:134a:b0:35a:67e1:3ed3 with SMTP id u10-20020a056638134a00b0035a67e13ed3mr2447840jad.235.1663180415161;
        Wed, 14 Sep 2022 11:33:35 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id i11-20020a056e020ecb00b002e8ea827aafsm6840971ilk.74.2022.09.14.11.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 11:33:31 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id b17so8472021ilh.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:33:29 -0700 (PDT)
X-Received: by 2002:a05:6e02:2189:b0:2f1:92d4:6b22 with SMTP id
 j9-20020a056e02218900b002f192d46b22mr14224475ila.210.1663180409089; Wed, 14
 Sep 2022 11:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid>
 <YyC9N62JaMGaeanf@smile.fi.intel.com> <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
 <YyDNAw+ur177ayY0@smile.fi.intel.com> <CAHQZ30DP1asiMj7hoebQQvGqE36sBDjaFmp3ju3eUEF1PruFeg@mail.gmail.com>
 <YyGh6Yjbb/5rkh35@smile.fi.intel.com>
In-Reply-To: <YyGh6Yjbb/5rkh35@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 14 Sep 2022 12:33:17 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Dsk2ikhctYSk_eP=1qcOOn_tjgtCftPOqQFkHNfQwBsg@mail.gmail.com>
Message-ID: <CAHQZ30Dsk2ikhctYSk_eP=1qcOOn_tjgtCftPOqQFkHNfQwBsg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This is similar to what of_i2c_get_board_info() does, no?
> > > Note: _get_ there.
> >
> > `*info` is an out parameter in that case. Ideally I would have
> > `i2c_acpi_get_irq`, `acpi_dev_gpio_irq_get_wake`,
> > `platform_get_irq_optional`, and `i2c_dev_irq_from_resources` all
> > return a `struct irq_info {int irq; bool wake_capable;}`. This would
> > be a larger change though.
>
> Seems the ACPI analogue is i2c_acpi_fill_info(). Can we do it there?
>

So I originally had that thought, but decided against it to avoid
changing too many things,
but since you brought it up, I thought I would try it.

So I moved the GPIO lookup into `i2c_acpi_do_lookup`, but it failed
spectacularly.
I've linked some logs of both cases. grep for `RX:` to see my logging messages.

* https://0paste.com/393416 - Logs with IRQ lookup happening in
`i2c_acpi_do_lookup`
    * We can see that `i2c_acpi_do_lookup` gets called in three cases
         1) Early on from i2c_acpi_notify when the I2C ACPI nodes are
first created
         2) From `i2c_dw_adjust_bus_speed` as part of `dw_i2c_plat_probe`
         3) From `i2c_register_adapter` as part of `i2c_dw_probe_master`.
    * What happens is that all of these calls happen before the GPIO
chip has been registered.
      This means that `acpi_dev_gpio_irq_get` will return `-EPROBE_DEFER`. This
      messes something up in the i2c init sequence and the devices are never
      probed again.
    * You can see the `amd gpio driver loaded` message after all the
i2c probing.
* https://0paste.com/393420 - Logs of a normal boot
    * Here we can see the GPIO controller registers early
    * We can see the i2c devices being probed by `__driver_attach_async_helper`.
      I'm guessing the device was enqueued as part of `i2c_acpi_register_device`
      early on and it gets probed later.

I could try moving the gpio lookup into `i2c_acpi_get_info`, but I
think that suffers from the
same problem, the stack can't handle a PROBE_DEFER. So I think we need to keep
the lookup in `i2c_device_probe` for the PROBE_DEFER logic to work correctly.
