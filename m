Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4776729A19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjFIMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFIMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:33:37 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47702113
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:33:03 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33e75ca0a8bso7311145ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1686313981; x=1688905981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXB1jevBys4Ftezaza8BYRJlJZrQuu9+lUaTu+i5qYs=;
        b=Pqv8C27/GNDQjLi+Fnckk0+j0pIGzZMo55dEK+1MhWZz548qoVOUKtOMsr1m6LzOBz
         G53/zGLdECuO19REgeFLSiOqBGQcSYONnRIDi94H9XrbWUhQnJcGjr7Kbe86GGE96ftT
         BjMEpLdMVFBDshQ8gQN76S0dlnK81EYe0vrecF1MClzeX3iERrJqbM5GF8l+7ZQvWKju
         Wk0zL9y8PIVDt2oc3K50q1VDm3UJGGMGY+g9p/htQ29FZoIPcr7neZqrITWgeeioE4ZY
         s7S6CRlBP1dkb/O8dUrzThNymfliLgMQqp4HFncHIzsRN4Y5s06eolzMk/Uix+WiHJ7Z
         ukPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686313981; x=1688905981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXB1jevBys4Ftezaza8BYRJlJZrQuu9+lUaTu+i5qYs=;
        b=evZ/OQAG28xSD5DigwCF9asm2F/pdWggy0nQ6gZHAoNE9m2qbl1n0IsLBxah2dw/Xm
         SseZfNZG5Zx5doR4nr9tr85SEpAnNZj70fNqwivpnp5cEjbnaNvuUbWUEPdbuMxQbRW/
         UH1ihHUWhvPeOt3JSKXhOQqi5OAXDmRn7Otxq/vs0RWSfwknoO7jJV+2GdSJdQnfO279
         8w8q4slsnRpVdiuUhd3BKJFcDfeBer8cBzPGSk5+ftKzREL3nQTb3bZrlMUvqnt+FCtB
         Ze50+BOHwKZ/6mSjC/7NB+h/jS6uIdc3eIMNTdMy1LLKpUermKHxrxrfwijYqln739w3
         9wDw==
X-Gm-Message-State: AC+VfDywmVaPxyZUGSVMTmGWAEJ96h2L/z8IyZzqgGnl4VN/Y/wBRpW8
        kj3Nak3u5clj4lW+y3TfqgGDaGrdzmIvZKKdvRyUfg==
X-Google-Smtp-Source: ACHHUZ4xWFpqYrjonUzfRcw2CZpBf9V3xq+uhIYWp1OCR1yRWXKCbpIkPfb/ktcu+qui1ljxefUpEyxXmjTORhNMS0Q=
X-Received: by 2002:a92:cb11:0:b0:338:b887:b674 with SMTP id
 s17-20020a92cb11000000b00338b887b674mr1379277ilo.2.1686313981219; Fri, 09 Jun
 2023 05:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230522165811.123417-1-jaz@semihalf.com> <20230525144055.15d06a0b.alex.williamson@redhat.com>
 <CAH76GKPu-5r=Fh+xFGumyKhp_FFdgzNj9Hxoo_hWEdta3dJRTA@mail.gmail.com>
 <CAH76GKNtCSdBOgTY2GLg2k2EOJCLYu8FUE66YNUbJMDAkze8-w@mail.gmail.com> <20230607162655.103e067d.alex.williamson@redhat.com>
In-Reply-To: <20230607162655.103e067d.alex.williamson@redhat.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 9 Jun 2023 14:32:50 +0200
Message-ID: <CAH76GKN+hC0w_KZjmHkPfYjp+32ZmqWR3yRZasCjygEHPT8Puw@mail.gmail.com>
Subject: Re: [PATCH v4] vfio/pci: Propagate ACPI notifications to user-space
 via eventfd
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dmy@semihalf.com, tn@semihalf.com,
        dbehr@google.com, dbehr@chromium.org, upstream@semihalf.com,
        dtor@google.com, jgg@ziepe.ca, kevin.tian@intel.com,
        cohuck@redhat.com, abhsahu@nvidia.com, yishaih@nvidia.com,
        yi.l.liu@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com,
        mjrosato@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 8 cze 2023 o 00:27 Alex Williamson <alex.williamson@redhat.com>
napisa=C5=82(a):
>
> On Wed, 7 Jun 2023 22:22:12 +0200
> Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
> > > >
> > > > Can we drop the NTFY and just use VFIO_PCI_ACPI_IRQ_INDEX?
> > >
> > > ACPI_IRQ at first glance could be confused with SCI, which is e.g.
> > > registered as "acpi" irq seen in /proc/interrupts, maybe it is worth
> > > keeping NTFY here to emphasise the "Notify" part?
> >
> > Please let me know if you prefer VFIO_PCI_ACPI_IRQ_INDEX or
> > VFIO_PCI_ACPI_NTFY_IRQ_INDEX taking into account the above.
>
> This is a device level ACPI interrupt, so it doesn't seem like it would
> be confused with SCI.  What other ACPI related interrupts would a
> device have?  I'm still partial to dropping the NTFY but if you're
> attached to it, let's not abbreviate it, make it NOTIFY and do the same
> for function names.

Ok, I will use VFIO_PCI_ACPI_IRQ_INDEX then.

>
> ...
> > > > > +     } else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
> > > > > +             u32 notification_val;
> > > > > +
> > > > > +             if (!count)
> > > > > +                     return -EINVAL;
> > > > > +
> > > > > +             notification_val =3D *(u32 *)data;
> > > >
> > > > DATA_BOOL is defined as a u8, and of course also as a bool, so we
> > > > expect only zero/non-zero.  I think a valid interpretation would be=
 any
> > > > non-zero value generates a device check notification value.
> > >
> > > Maybe it would be helpful and ease testing if we could use u8 as a
> > > notification value placeholder so it would be more flexible?
> > > Notification values from 0x80 to 0xBF are device-specific, 0xC0 and
> > > above are reserved for definition by hardware vendors for hardware
> > > specific notifications and BTW in practice I didn't see notification
> > > values that do not fit in u8 but even if exist we can limit to u8 and
> > > gain some flexibility anyway. Please let me know what you think.
> >
> > Does the above seem ok for you?
>
> The data type is only a u8 for practicality, it's still labeled as a
> bool which suggests it's interpreted as either zero or non-zero.  We
> also need to reconcile DATA_NONE, which should trigger the interrupt,
> but with an implicit notification value.  I see the utility in what
> you're proposing, but it logically implies an extension of the SET_IRQS
> ioctl for a new data type which has hardly any practical value.  Thanks,

Ok I will generate device check notification value as you earlier suggested=
.

Thank you,
Grzegorz
