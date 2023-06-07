Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB67271AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjFGW3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFGW26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500D2128
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686176822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJqV4lLT62HnrT9ItChiqvV/XgE8Wa2n/kOQ4fIu70w=;
        b=AD3MjnW8qjEPFpSth7J8SskjpEC/XafXrNYBuWX6FXxDPgl41IjRV8Cpv/s6rkBzWzNIzT
        KtewngobA7QyiD/5/33aiDqqUr80KWlyTVVF5Qxjany935DwHVIy7gUV4OFjwlQIHiOyiC
        M6Fa7lvO/nLIVULZMKCaEqaCVYYy60k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Vw-q2HTXP5-gNcd7lSAL3A-1; Wed, 07 Jun 2023 18:27:00 -0400
X-MC-Unique: Vw-q2HTXP5-gNcd7lSAL3A-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77a1d6d2f7fso185708239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 15:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176820; x=1688768820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJqV4lLT62HnrT9ItChiqvV/XgE8Wa2n/kOQ4fIu70w=;
        b=Uk+0vCMK2XbfwQSddScigECMDoeefLURx+Jc3Z7OH7kGUuKEvNxVWaIUTNdmMY6YeM
         Ft7Mb7ilkhoVusL8OXRSTaHMjZZYqrE52Lg7VSftdQWc2PyHdxAkaESXM3TGIhwdurJl
         flbJuhJt92//0S0Mp+MECE5pp+ivulnQ6FbWY786+kTyeu2AJYjQpIIwqG+ANXSyH4+P
         X0aR3x820s4ZBdo6Xx+EcjNZjR2SehW9Z4rjB7kl8A4x8VeI/uhTHUgbTS/TSTrftvzG
         qOmIqdGw51JtBvWhbywcHZrNTxWM1S7Pb0LX5C9vQmuqwOzL5eb6c6LcpVBKlI2+FxGI
         1luw==
X-Gm-Message-State: AC+VfDwDapIdFDT0Uipo7hIY/wL2ekI4yX/tgg2YQTADRpoLCMQH1BLi
        OIlJdz02SpBtq01Fa7y/7NNjVDOEs+ASht2gO/bpN+h7PQIYz9Z630SMhAtopaYHkuI0DPnJNlT
        WEEUY1dgSYDpaYsRmra93P9DQ
X-Received: by 2002:a5d:93c1:0:b0:774:9c64:e0ab with SMTP id j1-20020a5d93c1000000b007749c64e0abmr5633322ioo.17.1686176819884;
        Wed, 07 Jun 2023 15:26:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60Efki1Y5Y9iqO30Tk+CoaJFFkzFF5sqRJmPVeAJ7Q1eu8iC//0o7lxnkPOW6U9zOm0oPtfA==
X-Received: by 2002:a5d:93c1:0:b0:774:9c64:e0ab with SMTP id j1-20020a5d93c1000000b007749c64e0abmr5633307ioo.17.1686176819666;
        Wed, 07 Jun 2023 15:26:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s25-20020a02c519000000b0041d7ad74b36sm2407393jam.17.2023.06.07.15.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:26:59 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:26:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, dmy@semihalf.com, tn@semihalf.com,
        dbehr@google.com, dbehr@chromium.org, upstream@semihalf.com,
        dtor@google.com, jgg@ziepe.ca, kevin.tian@intel.com,
        cohuck@redhat.com, abhsahu@nvidia.com, yishaih@nvidia.com,
        yi.l.liu@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: Re: [PATCH v4] vfio/pci: Propagate ACPI notifications to user-space
 via eventfd
Message-ID: <20230607162655.103e067d.alex.williamson@redhat.com>
In-Reply-To: <CAH76GKNtCSdBOgTY2GLg2k2EOJCLYu8FUE66YNUbJMDAkze8-w@mail.gmail.com>
References: <20230522165811.123417-1-jaz@semihalf.com>
        <20230525144055.15d06a0b.alex.williamson@redhat.com>
        <CAH76GKPu-5r=Fh+xFGumyKhp_FFdgzNj9Hxoo_hWEdta3dJRTA@mail.gmail.com>
        <CAH76GKNtCSdBOgTY2GLg2k2EOJCLYu8FUE66YNUbJMDAkze8-w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 22:22:12 +0200
Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
> > >
> > > Can we drop the NTFY and just use VFIO_PCI_ACPI_IRQ_INDEX?  
> >
> > ACPI_IRQ at first glance could be confused with SCI, which is e.g.
> > registered as "acpi" irq seen in /proc/interrupts, maybe it is worth
> > keeping NTFY here to emphasise the "Notify" part?  
> 
> Please let me know if you prefer VFIO_PCI_ACPI_IRQ_INDEX or
> VFIO_PCI_ACPI_NTFY_IRQ_INDEX taking into account the above.

This is a device level ACPI interrupt, so it doesn't seem like it would
be confused with SCI.  What other ACPI related interrupts would a
device have?  I'm still partial to dropping the NTFY but if you're
attached to it, let's not abbreviate it, make it NOTIFY and do the same
for function names.

...
> > > > +     } else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
> > > > +             u32 notification_val;
> > > > +
> > > > +             if (!count)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             notification_val = *(u32 *)data;  
> > >
> > > DATA_BOOL is defined as a u8, and of course also as a bool, so we
> > > expect only zero/non-zero.  I think a valid interpretation would be any
> > > non-zero value generates a device check notification value.  
> >
> > Maybe it would be helpful and ease testing if we could use u8 as a
> > notification value placeholder so it would be more flexible?
> > Notification values from 0x80 to 0xBF are device-specific, 0xC0 and
> > above are reserved for definition by hardware vendors for hardware
> > specific notifications and BTW in practice I didn't see notification
> > values that do not fit in u8 but even if exist we can limit to u8 and
> > gain some flexibility anyway. Please let me know what you think.  
> 
> Does the above seem ok for you?

The data type is only a u8 for practicality, it's still labeled as a
bool which suggests it's interpreted as either zero or non-zero.  We
also need to reconcile DATA_NONE, which should trigger the interrupt,
but with an implicit notification value.  I see the utility in what
you're proposing, but it logically implies an extension of the SET_IRQS
ioctl for a new data type which has hardly any practical value.  Thanks,

Alex

