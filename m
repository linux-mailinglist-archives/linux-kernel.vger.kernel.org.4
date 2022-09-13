Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B035B7766
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiIMRJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiIMRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:08:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAF915DE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:57:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so12279128plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=CGLCtRbWwRCAf6WmqGJBYksHAfnT5oX5xIBwMzUyvqg=;
        b=Gjb/1drlC0T1KT6qKQp+EOjvuce3jT3ddBuZmCIhUCD1JjfynIXluqq+ydAE0YYAmG
         p+5JnSpv26BEqUDuJzeFgV+cDv+pcrHfjXDLRRItnLSsP1xlI5YcJEZJ7pEhDX8zjIh3
         cRbSM6dRKjNE1AtZwiNsW22tXNeNU6ZbagvXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CGLCtRbWwRCAf6WmqGJBYksHAfnT5oX5xIBwMzUyvqg=;
        b=f9F973U6qQV25CtDrzdwblBBDirlICL+AJIA+116ulPvVPL205ifODYWFJAtigUW9E
         RvAlT2nm5f1baJC1/r8SqO6R82pegOpkBOPmsjfneOiFklBY6ky7F+UjVtT+lpXWs8S1
         m+v8svCl5INB2baFM2BdoRtM37il4t47GrvjUxH9X1MMbSdF1Pp6uZoqE3abSSbW0NeJ
         lFjOY5YM5Z5fjoM+aaMTJ5os+itN6YpkOApX0BJWAYAWr+jzZpTr1yzhkitWh7HG58SI
         bzM7ZE3L2t1IakcuQvf7FTXRMubOx/xK1nLZqHB+Ht75bi9ghE7F+K3S3+vptuoNxFzN
         iyCQ==
X-Gm-Message-State: ACgBeo2h12GKUFq8qn259Hqp+pKd5Ox793OSHAtri+C+UVBNIE5ruyK+
        VMtJIeDL7TdSterJC8VvoNJ+a8OmcSK94A==
X-Google-Smtp-Source: AA6agR7ALB4hxTSgKh2PVMIucvywBYft+1S26VM321RtxrcF8pv4mGDyGNijvb5lUbpgcaLGiY3deQ==
X-Received: by 2002:a17:902:be02:b0:172:d409:e057 with SMTP id r2-20020a170902be0200b00172d409e057mr32304731pls.90.1663084656154;
        Tue, 13 Sep 2022 08:57:36 -0700 (PDT)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com. [209.85.215.169])
        by smtp.gmail.com with ESMTPSA id x5-20020a628605000000b00540d75197f2sm8361904pfd.143.2022.09.13.08.57.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:57:35 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id t65so11743405pgt.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:57:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:12a8:b0:2ea:f53a:2d06 with SMTP id
 f8-20020a056e0212a800b002eaf53a2d06mr12701463ilr.223.1663084320106; Tue, 13
 Sep 2022 08:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid> <YyAxBtAD2wL91quT@shikoro>
In-Reply-To: <YyAxBtAD2wL91quT@shikoro>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 13 Sep 2022 09:51:48 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Dw8XvNyok-BJ=oQEROC+Z6hfK8D93YHS4v-KGZymNXZw@mail.gmail.com>
Message-ID: <CAHQZ30Dw8XvNyok-BJ=oQEROC+Z6hfK8D93YHS4v-KGZymNXZw@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
To:     Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Tue, Sep 13, 2022 at 1:28 AM Wolfram Sang <wsa@kernel.org> wrote:
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
> I'll let the I2C ACPI maintainers deal with the technical details
> because they are the experts here, yet one minor thing hits my eye:
>

> > +             irq_ctx.irq = acpi_dev_gpio_irq_get_wake(
> > +                     adev, 0, &irq_ctx.wake_capable);
>
> That line split looks weird with the open parens at the end of line 1.
>
Ah, looks like I missed `clang-format` on that line. I can fix it in
the next revision.

Thanks
