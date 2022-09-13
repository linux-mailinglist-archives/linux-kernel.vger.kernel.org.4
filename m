Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9171F5B7A67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiIMTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIMTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:01:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21819297
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:56:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q83so8350106iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LtAYZje0M68/s1r4tHyDwDNi40n/sG8DGVF2ayd5a6Y=;
        b=QWyBZ80Zq0ZcdHrZPzyM5kzKrK2LeLxgmwqnRm3WBzlsmowMa86coHFuZ7UFnXdydh
         1vrWYRjtGsfas8YhI08LVyrhnKYueEF8m0Hds0exJ3LwcENGYuHpKvwZVWp/HUVH0R3N
         xB3Z7vHhZ0Jrlc61V0COnfQLcjdNUkByn2cGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LtAYZje0M68/s1r4tHyDwDNi40n/sG8DGVF2ayd5a6Y=;
        b=oYojWwA5Tpz1x1hgPTcbBs7gxTXLpNZSyK/XSTk/7LLv68pIjKm+YWhldl+c0+MDp8
         GCwWvC2IF6aI5q/rXUQpmia933qC3YHAEkc3eclSadaN3Aw/KTPIuoS4Jjecn+y8ZabZ
         c7JQ4DcgEgIXyFs2xobspCGaLCQsLjqIfB+DAY35d6UOVJynW6ucN2svxWJX2Rlk7cgu
         R1GiM/Ns4aK6KihOvnjMgHJ5ItW9U7JKfqa+yeHS7t8zLUpnWmMrZZ1fHLfObkjdLqO4
         /BMsXCbDUGmzOjh12vkIt0GiObQpvHmrTFkizZp4Lz1k2GP9iFky5GDIc2c2/WgAHiw2
         NlzA==
X-Gm-Message-State: ACgBeo3ILUCTO73uOVDJfYZkP0T9mbFWK0eQrK6VQIcJ+n8f4KiptvEY
        M69FWk1XOFnn2ZUJwVtYk4Beuzc19TlFBQ==
X-Google-Smtp-Source: AA6agR598YeipSf1ChWjB5xC0eDApGZTE92agYq0BoO+JQhrsgCKZhzzuS5nGb1zvyu/SNWDSeSb3g==
X-Received: by 2002:a05:6602:26d4:b0:68a:e0e3:4d06 with SMTP id g20-20020a05660226d400b0068ae0e34d06mr14602683ioo.215.1663095415024;
        Tue, 13 Sep 2022 11:56:55 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id f3-20020a056e0204c300b002ea9d1b0102sm5438193ils.39.2022.09.13.11.56.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 11:56:52 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id v128so10384305ioe.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:56:52 -0700 (PDT)
X-Received: by 2002:a02:9509:0:b0:349:b6cb:9745 with SMTP id
 y9-20020a029509000000b00349b6cb9745mr16993260jah.281.1663095412005; Tue, 13
 Sep 2022 11:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid>
 <YyC9N62JaMGaeanf@smile.fi.intel.com> <CAHQZ30DAr_BwH03=bG9tfCSGW+-he-c-4PPeJMOqH28cVcKDoA@mail.gmail.com>
 <YyDNAw+ur177ayY0@smile.fi.intel.com>
In-Reply-To: <YyDNAw+ur177ayY0@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 13 Sep 2022 12:56:37 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DP1asiMj7hoebQQvGqE36sBDjaFmp3ju3eUEF1PruFeg@mail.gmail.com>
Message-ID: <CAHQZ30DP1asiMj7hoebQQvGqE36sBDjaFmp3ju3eUEF1PruFeg@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 12:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 13, 2022 at 12:07:53PM -0600, Raul Rangel wrote:
> > On Tue, Sep 13, 2022 at 11:26 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 12, 2022 at 04:13:11PM -0600, Raul E Rangel wrote:
> > > > Device tree already has a mechanism to pass the wake_irq. It does this
> > > > by looking for the wakeup-source property and setting the
> > > > I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses the
> > > > ACPI interrupt wake flag to determine if the interrupt can be used to
> > > > wake the system. Previously the i2c drivers had to make assumptions and
> > > > blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
> > > > If there is a device with an Active Low interrupt and the device gets
> > > > powered off while suspending, the interrupt line will go low since it's
> > > > no longer powered and wakes the system. For this reason we should
> > > > respect the board designers wishes and honor the wake bit defined on the
> > > > interrupt.
> >
> > >
> > > > +                     if (irq > 0 && acpi_wake_capable)
> > > > +                             client->flags |= I2C_CLIENT_WAKE;
> > >
> > > Why do we need a parameter and can't simply set this flag inside the callee?
> >
> > Are you suggesting `i2c_acpi_get_irq` modify the `client->flags`? IMO
> > that's a little surprising since the I wouldn't expect a `get`
> > function to modify it's parameters. I'm fine implementing it if others
> > agree though.
>


> This is similar to what of_i2c_get_board_info() does, no?
> Note: _get_ there.
>

`*info` is an out parameter in that case. Ideally I would have
`i2c_acpi_get_irq`, `acpi_dev_gpio_irq_get_wake`,
`platform_get_irq_optional`, and `i2c_dev_irq_from_resources` all
return a `struct irq_info {int irq; bool wake_capable;}`. This would
be a larger change though.
