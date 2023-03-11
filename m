Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29C06B58F6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCKGdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:33:26 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE021C321;
        Fri, 10 Mar 2023 22:33:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso7126115pjs.3;
        Fri, 10 Mar 2023 22:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678516405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ+nhmVjwHZ6QFf7JMBkQR/zIZ3Yd/huMBL/cm4iNmk=;
        b=YwbUBaQ94Jkn4cElkpeXswJBzsf17zkSBeqeq1RolkjLWCq6FVODndKYzRo2q/2lE4
         +Tv+KMz3XsH0UQ0JjqQk7p/xvWq46RjYtzP+5IULTM06SCjJa0h+qqgfNT+7bXs1M8IL
         +X1k4Kwb5cCWymsteEuOFSaRxRmoNltyDwWyZVPJKJrLDh6jacOT5tLw2lfam8Wf322Y
         jnvrJKeSU+nsU9EEDkSq1kB/Ppf5aZa5iC3VIHkyV6Q+CHLQMMtCT3XNfe55NH4AbckK
         VpRx4SBVg7Aw3+rQRP3dPyoIxQ0gKrQroSjfaJnNVWn+A+Qilxg0/yYp3mnpTl9eb9C/
         Jwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678516405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ+nhmVjwHZ6QFf7JMBkQR/zIZ3Yd/huMBL/cm4iNmk=;
        b=BgnVUWDPPTjR/JzrSddpx/9QfXNlKtGGjTuO1f3jbWXmsKfHICCmJJZ+KvcbolNsM6
         ygZrKMLFVOCQgWRVbURnCweInVQGfow+GCAnI6rpjFuzZqGYhtyuzL3JFezEgrtmJ9i/
         1P1Hwh3D96HGoITdh0O9vvXCsh2APfWMCp1IAUrySsdUvGqwBii8NBKwoeLx1QCHwtZb
         7V2pO+eYIvJShsoRwkFhPQoTsxtnpsEybRvO36ai/hehxcr/qyoN603L5WS0aInkCTQB
         eJYQdZYYhp1brZcUyOHs7GULwrI2kh8sylg4ELbtuonC2YwCxP0a2IfKfvQIumgLHaUS
         5RAQ==
X-Gm-Message-State: AO0yUKXfJ84FBrp+qUVWrT0RdRMBkC16mBcnfmu20j5PTjeRo6agJkGE
        /dV/7/9UkkXJWqJB/Wk6odQ=
X-Google-Smtp-Source: AK7set816qLD75sU6ayDA8I1y1Rgse0n0WSvhFSlB58g0NpWpzg8IoZ8A7Wd7E0BIRnHE2g2/4z+AA==
X-Received: by 2002:a17:90b:1d88:b0:237:99b8:4eef with SMTP id pf8-20020a17090b1d8800b0023799b84eefmr29501361pjb.9.1678516404934;
        Fri, 10 Mar 2023 22:33:24 -0800 (PST)
Received: from redecorated-mbp (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090aaa8800b002349608e80csm850931pjq.47.2023.03.10.22.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 22:33:24 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:33:13 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Subject: Re: [PATCH v5 0/2] Apple Magic Keyboard Backlight
Message-ID: <20230311173313.66c829a7@redecorated-mbp>
In-Reply-To: <nycvar.YFH.7.76.2303101535440.1142@cbobk.fhfr.pm>
References: <20230220115203.76154-1-orlandoch.dev@gmail.com>
        <nycvar.YFH.7.76.2303101535440.1142@cbobk.fhfr.pm>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 15:36:34 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Mon, 20 Feb 2023, Orlando Chamberlain wrote:
> 
> > This patchseries adds support for the internal keyboard backlight of
> > Macs with Apple's "Magic" keyboard (MacBookPro16,* and
> > MacBookAir9,1), and also documents what names should be used for
> > keyboard backlight leds in Documentation/leds/well-known-leds.txt.
> > 
> > v4->v5:
> > - use <tab><space><space> for help in Kconfig
> > - prepend "hid-" to filename in MAINTAINERS
> > 
> > v3->v4:
> > - collect reviews from Andy and Thomas
> > - remove now unused hdev member of apple_magic_backlight
> > 
> > v2->v3:
> > - remove unneeded header inclusion
> > - use s32 for report value type
> > - remove unneeded null check
> > - don't set drvdata as its never used
> > - prepend "hid-" to module name
> > 
> > v1->v2:
> > - drop unneeded remove function
> > - combine set functions
> > - add missing header inclusions
> > - avoid char as argument in favour of u8
> > - handful of style/formatting fixes
> > - use standard led name ":white:kbd_backlight"
> > - rename USAGE_MAGIC_BL to HID_USAGE_MAGIC_BL
> > - New patch documenting preferred keyboard backlight names
> > 
> > v1:
> > https://lore.kernel.org/linux-input/7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com/
> > v2:
> > https://lore.kernel.org/linux-input/20230216041224.4731-1-orlandoch.dev@gmail.com/
> > v3:
> > https://lore.kernel.org/linux-input/20230217102319.3419-1-orlandoch.dev@gmail.com/
> > v4:
> > https://lore.kernel.org/linux-input/20230218090709.7467-1-orlandoch.dev@gmail.com/
> > 
> > Orlando Chamberlain (2):
> >   Documentation: leds: standardise keyboard backlight led names
> >   HID: hid-apple-magic-backlight: Add driver for keyboard backlight
> > on internal Magic Keyboards
> > 
> >  Documentation/leds/well-known-leds.txt  |   8 ++
> >  MAINTAINERS                             |   6 ++
> >  drivers/hid/Kconfig                     |  13 +++
> >  drivers/hid/Makefile                    |   1 +
> >  drivers/hid/hid-apple-magic-backlight.c | 120
> > ++++++++++++++++++++++++ 5 files changed, 148 insertions(+)
> >  create mode 100644 drivers/hid/hid-apple-magic-backlight.c  
> 
> Hi,
> 
> thanks for creating the support for backlight.
> 
> Is there any reason why not to fold all this into existing hid-apple?
> I don't think we need separate driver for the backlist, separated
> from the rest of hid-apple support.

Hi Jiri,

I think we can do that if we modify hid-apple to support usb endpoints
with only the keyboard backlight and no keyboard, assuming it doesn't
prevent the (not upstream) touchbar driver from using the touchbar
backlight interface (and I don't think it will, given hid-apple lets a
different driver bind to the trackpad interface of the
keyboard/trackpad usb device).

> 
> Thanks,
> 

