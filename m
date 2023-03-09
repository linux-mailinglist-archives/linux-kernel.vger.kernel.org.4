Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51DA6B2D56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCITGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCITGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:06:19 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15DE681B;
        Thu,  9 Mar 2023 11:06:18 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id c11so2454757oiw.2;
        Thu, 09 Mar 2023 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678388777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uiR/LxAk1QZhjuyMutqfTRyaOwiD3/uAEjdq2NyCr5I=;
        b=CmSV4PcskOsOfskSPqsTCagXfYrxKTHr67DtGnhFSUUEbxtngijG8dj3qp0tj1W/pW
         sj180XfYMSzWyc9tmgzP51WfZL1boMSN1+QIDtybvd2AVS2M2/qsOS1mWhRVxjFnzQn4
         y5+/p40WgMUik0eWapisOWE0fY2e1CdppLWkNolY5RCtWkIz1ryj256oN6RFbhK53HJu
         egBslxMjzjC74e+ELdQxHG8mnhLr9gADfJkKD+3+mOTBMDMWtlrmYleGAcI6wLIGxaL/
         FzjOSBvvvx7zu7Pgk6GRL2uRcSTgBXWpCi3k1CV2q0ELkvusl5WVmG7jhrob0dPJckQY
         0U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiR/LxAk1QZhjuyMutqfTRyaOwiD3/uAEjdq2NyCr5I=;
        b=a6E0w8Mhuh22nj6Vj/PA1yh2LuShkbqy5x2gDHIUOKkLksaWmmijsTH4zYiegitV0L
         oXxdcN/4XLgtcvtrf5XfglvFNWuOWDIyjdgEgRxrdqIe7zuv58HW80cCp/KxhNNBNGa9
         /Qi6rWWgXSutwTwHV6k8D40v5mhCCejw9Yx0YeompcedbBskCTxwWOyZhdoEoqNAWX/M
         mNphfQVzt0e7WolIowpSRjMrDuNK5QDSyGIVjZVNgwbhZ0h0hFhwF7lIW0V4cBYgd8nX
         v1/qjEXwZnEGvspfEGmAXwwluUiGDL5yaJdhi9EYwK66vfsbJtbuRh2Q+h4hLmS0XODh
         vLdg==
X-Gm-Message-State: AO0yUKX+62Cgf4reem4eQNWr+uX7/830HBIS3IPxkzJ0AoWFC40evHBu
        53Sut+N+eunXozrALR8i8GNfFGCKOOA22Jb86Xw=
X-Google-Smtp-Source: AK7set87qA9G55hYDeAgDKjAFWrHWbcLmbSx2inlaWZTuEgN9lIV0ItZEbzGVO7zQam/cTpyfLSoM7NeJhITOb+Nff8=
X-Received: by 2002:a05:6808:2343:b0:384:87c:759b with SMTP id
 ef3-20020a056808234300b00384087c759bmr6699556oib.4.1678388777423; Thu, 09 Mar
 2023 11:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com> <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
 <ZAnB/DozWsir1cIE@kroah.com> <CANeycqrtjKMfpae_DUp-VrDZugJVO7mcbBvUBB+zAc=E6aU4tw@mail.gmail.com>
 <ZAoTNlF+bHyyGs7x@kroah.com>
In-Reply-To: <ZAoTNlF+bHyyGs7x@kroah.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 9 Mar 2023 16:06:06 -0300
Message-ID: <CANeycqqBVyDa=e+heDM-Wa9Bz30PESdMJ8Eu0OCPLh4Kqv+xwQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 14:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 09, 2023 at 01:46:39PM -0300, Wedson Almeida Filho wrote:
> > On Thu, 9 Mar 2023 at 08:24, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > > > > +        // owns a reference. This is satisfied by the call to `get_device` above.
> > > > > > +        Self { ptr }
> > > > > > +    }
> > > > > > +
> > > > > > +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> > > > > > +    pub fn from_dev(dev: &dyn RawDevice) -> Self {
> > > > >
> > > > > I am a rust newbie, but I don't understand this "RawDevice" here at all.
> > > >
> > > > Different buses will have their own Rust "Device" type, for example,
> > > > pci::Device, amba::Device, platform::Device that wrap their C
> > > > counterparts pci_dev, amba_device, platform_device.
> > > >
> > > > "RawDevice" is a trait for functionality that is common to all
> > > > devices. It exposes the "struct device" of each bus/subsystem so that
> > > > functions that work on any "struct device", for example, `clk_get`,
> > > > `pr_info`. will automatically work on all subsystems.
> > >
> > > Why is this being called "Raw" then?  Why not just "Device" to follow
> > > along with the naming scheme that the kernel already uses?
> >
> > Because it gives us access to underlying raw `struct device` pointer,
> > in Rust raw pointers are those unsafe `*mut T` or `*const T`. I'm not
> > married to the name though, we should probably look for a better one
> > if this one is confusing.
> >
> > Just "Device" is already taken. It's a ref-counted `struct device` (it
> > calls get_device/put_device in the right places automatically,
> > guarantees no dandling pointers); it is meant to be used by code that
> > needs to hold on to devices when they don't care about the bus. (It in
> > fact implements `RawDevice`.)
>
> I don't understand, why do you need both of these?  Why can't one just
> do?  Why would you need one without the other?  I would think that
> "Device" and "RawDevice" here would be the same thing, that is a way to
> refer to a "larger" underlying struct device memory chunk in a way that
> can be passed around without knowing, or caring, what the "real" device
> type is.

`Device` is a struct, it is the Rust abstraction for C's `struct device`.

Let's use the platform bus as our running example: we have
`platform::Device` as the Rust abstraction for C's `struct
platform_device`.

Let's use `clk_get`as our running example of a function that takes a
`struct device` as argument.

If we have a platform device, we can't just call `clk_get` because the
types don't match. In C, we access the `dev` field of `struct
platform_device` before we call `clk_get` (i.e., we call
clk_get(&pdev->dev, ...)), but in Rust we don't want to make the
fields of `platform::Device` public, especially because they're fields
of a C struct. So as part of `platform::Device` we'd have to implement
something like:

impl platform::Device {
    fn get_device(&self) -> &Device {
    ...
    }
}

Then calling `clk_get` would be something like:

pdev.get_device().clk_get(...)

The problem is that `clk_get` doesn't know that `platform::Device` is
a device, that's why we need this `get_device()` call on each bus
abstraction of a device, plus on each call to bus-agnostic device
functions.

Since we're implementing this "adapter" function anyway, we may as
well put in a _trait_ and improve how people use it. We say: every
struct that is a device should implement the `RawDevice` (or
`IsDevice`, or whatever we decide to call it) trait. Then
`platform::Device` would still have to implement something like:

impl RawDevice for platform::Device {
    fn get_device(&self) -> &Device {
    ...
    }
}

(Note that we went from `impl X` to `impl RawDevice for X`.)

With this trait, users can call `clk_get` on a platform device as follows:

pdev.clk_get(...)

So we improve the experience of driver developers by having bus
abstraction developers add "RawDevice for" to their impl block of the
`get_device` function for their device.

> >  How about `IsDevice`?
>
> That sounds like a question, and would return a boolean, not a structure :)

`RawDevice` is not a struct, it's a trait that is implemented by
bus-specific structs.

> > Then, for example, the platform bus would implement `IsDevice` for
> > `plaform::Device`.
>
> I don't really understand that, sorry.

I tried to explain it above. I think the source of the problem is the
distinction between `struct` and `trait`, the latter of course doesn't
exist in C.

Cheers,
-Wedson
