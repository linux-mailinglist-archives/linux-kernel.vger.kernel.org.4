Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09A05B79CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIMSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiIMSj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:39:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51C870E67
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:08:08 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-127f5411b9cso34336702fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LjK0fulvlnuvLTjKk4E4pqpGI0zifUwgFi6JRD+xi1s=;
        b=ag1hME6oKmg5TCKzS6jNswj3qklmDcrZ04qFJO5dWFAsGn8l1Y3qTSwXq5Yx1fucPz
         nmcQ+3uJi9tLtO49mzhRIZAaW0+dYV7eqq1Oo5mErNTYHZaabH+fYqoR2Wl14BsDyCqC
         4u7U7rT4w5MarvgyEO9u6vhS7AeusigkSSNTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LjK0fulvlnuvLTjKk4E4pqpGI0zifUwgFi6JRD+xi1s=;
        b=wr12H+GC2368ChMthm9d3d4EBa8qgMvt07INYC2+2IC+flWj/a4ftL+c8UUrfx9+1o
         ccitY4mf3aWv8urRTb5UL+BykUoZM73Cg7mWITxIM/0Qm28/P1T/cFJB7SwEsYk2guv8
         thjmVuaigz/aVz0jVHj3mXNHwqKC0/wNlLp2HIu5SAgu2/pAxmqJAaa5oSImS/gl6gzh
         dJq1EAs0h1ER2UwPeVqhuJvrgqYhxyHFfaD3HM3Y51bYxz442fw/bm3yOBtOI6OZ3K/k
         rxBv5lz/7gWzhv4RvYNZ0laDOXyKpmJp4dXzWfawilqolcJHKrT5drH5UzB2jc4vIPuj
         gsQg==
X-Gm-Message-State: ACgBeo2Zw2V8IXkVs7ZInfS9qrEnI9gJIqh3bDGNOOgaHJOLdqCO9ku4
        +w8qiCKsWlxXfrIszndV/Wgw2ZS7Ia/Wjw==
X-Google-Smtp-Source: AA6agR6Z9E9IX3CIM0kbNUREBeIfNMcPtExNowtnGnUVkAvAy4w1WNDaMA4hzbkhGezAYTViZ4N3Ow==
X-Received: by 2002:a05:6808:238e:b0:345:3564:2a49 with SMTP id bp14-20020a056808238e00b0034535642a49mr232068oib.221.1663092487754;
        Tue, 13 Sep 2022 11:08:07 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id m20-20020a4add14000000b00443abbc1f3csm5540121oou.24.2022.09.13.11.08.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 11:08:05 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127f5411b9cso34336230fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:08:04 -0700 (PDT)
X-Received: by 2002:a05:6871:808:b0:127:69af:9adf with SMTP id
 q8-20020a056871080800b0012769af9adfmr322361oap.120.1663092484148; Tue, 13 Sep
 2022 11:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid> <YyC9N62JaMGaeanf@smile.fi.intel.com>
In-Reply-To: <YyC9N62JaMGaeanf@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 13 Sep 2022 12:07:53 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
Message-ID: <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 11:26 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 12, 2022 at 04:13:11PM -0600, Raul E Rangel wrote:
> > Device tree already has a mechanism to pass the wake_irq. It does this
> > by looking for the wakeup-source property and setting the
> > I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses the
> > ACPI interrupt wake flag to determine if the interrupt can be used to
> > wake the system. Previously the i2c drivers had to make assumptions and
> > blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
> > If there is a device with an Active Low interrupt and the device gets
> > powered off while suspending, the interrupt line will go low since it's
> > no longer powered and wakes the system. For this reason we should
> > respect the board designers wishes and honor the wake bit defined on the
> > interrupt.

>
> > +                     if (irq > 0 && acpi_wake_capable)
> > +                             client->flags |= I2C_CLIENT_WAKE;
>
> Why do we need a parameter and can't simply set this flag inside the callee?

Are you suggesting `i2c_acpi_get_irq` modify the `client->flags`? IMO
that's a little surprising since the I wouldn't expect a `get`
function to modify it's parameters. I'm fine implementing it if others
agree though.
