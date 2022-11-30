Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9063DB04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiK3Qwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiK3Qwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:52:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FEA1704D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:52:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o12so8374251pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6c57TrNa1xcClHezph2gUK6a15ufM6LCFiURMV8YWow=;
        b=K3t8SVWbj+moagBOegxEUsIQJhDnMJ/D7UsKpI1mWjxW+DfbSupIAJqmuyXLYyz1m9
         gKgKF45AG17pHAWhJNkmbcV0fznVGtHkJoVp9J3ZH1zhIVGBcl3GVkZsIkBYM92zTW6v
         H8GEZY3SwtR3/xoD+Gw/VHVcjonhAzUnONUhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c57TrNa1xcClHezph2gUK6a15ufM6LCFiURMV8YWow=;
        b=omG2E+WOdx3SEr1NTVIlppe9zJmFdyrGZ50ZNwfNU/e6qrd3kwBfsuzsMLqJA2YSAE
         TEkss7DRrfHsjKr7KcOuaWHaPWkNjAPuLuVEmE11vy5LqdCZNfjV6MNW/SFvricZaonX
         BlwT+vDix+phCcgC1ACgzZfDiwHWHjvBELGzMAwDu0loUlrmB9iYKjwljqQ78JnF3/4B
         JbxVEkW2PGkLZK/TdHSnyfDg2jYD+vGkYvahCncjLhnv/SgiLT4oBVF5vXJ+C8ivn1PU
         LSPm09vyQt6stxqVcGfXEDr6aDHZejxaKhCucdZU9+iY0Tps61mMopl4e09qBWKGhii7
         xDkQ==
X-Gm-Message-State: ANoB5plST1fGWmTXPH+fKkdtN/ZgOY0tYkU4BGa4r1BeQb4IFUMKd6hW
        rZoCfCdOlw/yrlOwZJd1QcbYSmxWKUPiew==
X-Google-Smtp-Source: AA0mqf5c++5cPZDBOWKyHw6vE64Npy+49CbJhaT4CpHx3V3779WkOgd4EEUacDNb1Aa/2XcOIGUWJg==
X-Received: by 2002:a17:90a:5b09:b0:218:a0cd:5a99 with SMTP id o9-20020a17090a5b0900b00218a0cd5a99mr54959334pji.76.1669827162441;
        Wed, 30 Nov 2022 08:52:42 -0800 (PST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001869f2120a4sm1716071pli.94.2022.11.30.08.52.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:52:41 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2772924pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:52:41 -0800 (PST)
X-Received: by 2002:a17:90a:2b44:b0:213:d66b:4973 with SMTP id
 y4-20020a17090a2b4400b00213d66b4973mr72186366pjc.85.1669827160411; Wed, 30
 Nov 2022 08:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
 <Y3cbswXxTKWhMjKT@google.com> <CANg-bXAxeL_N53umfeoYjAyDfw5EeHmcniZusPo+bb-BE1R4Ow@mail.gmail.com>
 <Y4cBwft2EMT4boPc@google.com>
In-Reply-To: <Y4cBwft2EMT4boPc@google.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 30 Nov 2022 09:52:29 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Dm1XbcQXjKXAfWUimL7NzYS8tkfwANpnB8kVRORsAjzw@mail.gmail.com>
Message-ID: <CAHQZ30Dm1XbcQXjKXAfWUimL7NzYS8tkfwANpnB8kVRORsAjzw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:10 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Tue, Nov 29, 2022 at 11:13:04AM -0700, Mark Hasemeyer wrote:
> > > > @@ -392,6 +393,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
> > > >  static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
> > > >                        cros_ec_uart_resume);
> > > >
> > > > +static const struct of_device_id cros_ec_uart_of_match[] = {
> > > > +     { .compatible = "google,cros-ec-uart" },
> > > > +     {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, cros_ec_uart_of_match);
> > >
> > > It would need a guard for checking CONFIG_OF.  Similar to what
> > > `cros_ec_uart_acpi_id` does.
> > >
> > > > @@ -405,6 +412,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
> > > >       .driver = {
> > > >               .name   = "cros-ec-uart",
> > > >               .acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
> > > > +             .of_match_table = cros_ec_uart_of_match,
> > >
> > > It would need be wrapped by `of_match_ptr()`.  Similar to what
> > > `ACPI_PTR()` does.
> >
> > I'm not sure we want a guard in this case because we compile the kernel without
> > CONFIG_OF enabled for (most?) x86 platforms. Yet we still need the device
> > tree code to enumerate using the PRP0001 _HID method.
>

> I'm not familiar to ACPI.  However, I thought it should add the compatible
> string in the _DSD instead of using of_match for the case.  See example
> in [1].
>
> [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.html#device-tree-namespace-link-device-id

Correct, we need to add the compatible string inside the _DSD. This is
what we currently do for all of our released devices:
```
    Device (CRFP)
    {
        Name (_HID, "PRP0001")  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (_DDN, "Fingerprint Reader")  // _DDN: DOS Device Name
        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
Properties for _DSD */,
            Package (0x03)
            {
                Package (0x02)
                {
                    "compatible",
                    "google,cros-ec-uart"
                },
                ...
            }
        }
    }
```

Since we define our `_HID` as `PRP0001` we need the `of_match_table`
so the ACPI node can bind.
