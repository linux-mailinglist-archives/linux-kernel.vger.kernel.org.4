Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A36B3FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCJMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCJMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72D10D747
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678452711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZIld3XXwjg/5OVDJp8fJcoorSqaGBrbmPgeKtcFSHg=;
        b=AfG1nnjnebMBCbxovyJJGk70s16SxAVdag/+yGT0e8/8lSD3aJ0LZ1S3X3SVPOkm8fvBuI
        VXJtExj2kaQwTsPk1tCGOdSj/aMhH8dD/exMpp4982WfJ+oQt4uLd6fhOzv/3Pp1qyTAty
        ZALF/0kJadaLe5yowlFE90pQvhhQ0HE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-9wl-nak1N0uNX1V6HIqLfA-1; Fri, 10 Mar 2023 07:51:50 -0500
X-MC-Unique: 9wl-nak1N0uNX1V6HIqLfA-1
Received: by mail-yb1-f198.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso5635766ybu.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678452709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZIld3XXwjg/5OVDJp8fJcoorSqaGBrbmPgeKtcFSHg=;
        b=e18pJ8yC8UOs+hVX0qy1+Pxi+QMZhfKG3J1e33RIB0RhjtZwAQXoZlKGMBjsais2mr
         JdhjVthnP7KiZbKYpZvcow6yY1URyMRscZXKL2/8DYBfk6dFfdquyzkKnH7qvLsrsWm4
         s5oErsXiHlqvvURPWmDol8KbNK0iYr7weXlgXWiQ5EuwHsBWn5jjh2OqujxDK1WIYTv0
         NiJL9cTAsdwmsTf9RJNO7PggNnTZjCYkAbW/Xm8X0zE4tC8+NdxsiIagLXcpANTH+6MQ
         yrEpAhfEv3nv6CLQqZR1/gFRkVuDOtcvGv5qZzypmYsgwzRYQ1/h56IdvIEEb6QjZHMj
         oqPQ==
X-Gm-Message-State: AO0yUKWJC4fpjVda+5Bw8kJemdseepA49/DSAZiAlkrAOy8z4FvZHwoC
        T/8gxHvDOmhIMO9LvzBTi99qLa+j8T4kX2OMervtR0mVSeTr0QlIuOww4dBGLVnF/3bTHe7c7be
        7IYd/h7xqC9MgzN+UMf5zz8JRmcSVnh5M+8CgWDhj
X-Received: by 2002:a81:ae18:0:b0:52e:b22b:f99 with SMTP id m24-20020a81ae18000000b0052eb22b0f99mr16398139ywh.4.1678452709622;
        Fri, 10 Mar 2023 04:51:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/EKPoJpsaQ6jTGPO8ZcwOExwc+c/U5tEMzDhx6YbPVnFyVYh1GTuwqNC6IUjl6U7VfvbNFIQkaXa/4X29Luic=
X-Received: by 2002:a81:ae18:0:b0:52e:b22b:f99 with SMTP id
 m24-20020a81ae18000000b0052eb22b0f99mr16398129ywh.4.1678452709262; Fri, 10
 Mar 2023 04:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com> <20230310114150.GA62143@black.fi.intel.com>
In-Reply-To: <20230310114150.GA62143@black.fi.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 10 Mar 2023 13:51:38 +0100
Message-ID: <CAO-hwJK+yF+0u6cbw4CoV8vS80Vx5xkC2vwPjOQvnUox2SMdTA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:42=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Mar 09, 2023 at 02:40:51PM +0100, Benjamin Tissoires wrote:
> > While trying to set up an SSDT override for a USB-2-I2C chip [0],
> > I realized that the function acpi_gpiochip_find() was using the parent
> > of the gpio_chip to do the ACPI matching.
> >
> > This works fine on my icelake laptop because AFAICT, the DSDT presents
> > the PCI device INT3455 as the "Device (GPI0)", but is in fact handled
> > by the pinctrl driver in Linux.
> > The pinctrl driver then creates a gpio_chip device. This means that the
> > gc->parent device in that case is the GPI0 device from ACPI and everyth=
ing
> > works.
> >
> > However, in the hid-cp2112 case, the parent is the USB device, and the
> > gpio_chip is directly under that USB device. Which means that in this c=
ase
> > gc->parent points at the USB device, and so we can not do an ACPI match
> > towards the GPIO device.
> >
> > I think it is safe to resolve the ACPI matching through the fwnode
> > because when we call gpiochip_add_data(), the first thing it does is
> > setting a proper gc->fwnode: if it is not there, it borrows the fwnode
> > of the parent.
> >
> > So in my icelake case, gc->fwnode is the one from the parent, meaning
> > that the ACPI handle we will get is the one from the GPI0 in the DSDT
> > (the pincrtl one). And in the hid-cp2112 case, we get the actual
> > fwnode from the gpiochip we created in the HID device, making it workin=
g.
> >
> > Link: https://lore.kernel.org/linux-input/20230227140758.1575-1-kaehnda=
n@gmail.com/T/#m592f18081ef3b95b618694a612ff864420c5aaf3 [0]
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>

Thanks to both of you for the reviews.

Andy, should I resend a v2 with the rev-by from Mika and the Ice Lake chang=
es?

Cheers,
Benjamin

