Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501F6DBC8C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDHTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDHTGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:06:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CE01FC3;
        Sat,  8 Apr 2023 12:06:48 -0700 (PDT)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 453246603133;
        Sat,  8 Apr 2023 20:06:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680980806;
        bh=CofPGuyTFoAUQlXTpv+W3TvW8sbLgzIIn70423fF+5M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XTwvstqDEZP7q8sfhAD8ZFhaYI2Z+KrCL5970jrr5Sq4vWw9qXGWTwMP3xA+oAcfe
         na3SV5DK2LtupVDz/hLmoJ2hb6q40SUsZI6W95ZlhkX6xVA6fna/jsVG6igRiO2o2C
         qxK92757vu4sKt+R/Wqerf3+aJ3mHBEEgN1ZGZL3izFwZ1hA6vPqplghR3KcgCmrej
         xZgW5XpMOlFm7WGU4fX76gOXJzKGbNr2m3fny5g1e2kUi1GkJ30i9jBaMNVyRL3ew/
         ps20GIcQKJGhp5ZFCmt0GddkwKv+oG96FdVqYuhKiiZ9SUnjP/k8l/cXUi46Xq+W2h
         HamnC7LK+UiFQ==
Message-ID: <0062de67bfe89653ffdc5e3c564fb24bc1adf3f4.camel@collabora.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Date:   Sat, 08 Apr 2023 16:06:31 -0300
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, one of the things I dislike about this series is that
there's a needless distinction between

struct Foo(bindgen::foo)

vs

struct FooRef(*mut bindgen::foo)

This gets in the way of having an owned Foo embedded into a larger
struct. It also gets in the way of instantiating an owned Foo on the
stack.

My first thought was to use enums:

enum Foo {
  Owned(bindgen::foo),
  NotOwned(*mut bindgen::foo),
}

But that would mean that users would invariably pay the price for the
owned variant always, as enums use as much space as its largest
variant.

My current understanding is that we can move all the implementations to
traits, with a suitable bound on AsRef<bindings::foo> and
AsMut<bindings::foo>.

Here is a code example for the wrapper of bindings::v4l2_format (see
format.rs), which was extended to account for both owned and non-owned
bindgen types:


```
use core::cell::UnsafeCell;

/// The shared implementation between Format and FormatRef.
pub trait FormatImpl: AsRef<bindings::v4l2_format> +
AsMut<bindings::v4l2_format> {
    /// Returns the `type_` field.
    fn type_(&self) -> u32 {
        self.as_ref().type_
    }

    /// Get the field `field` for the `pix` union member.
    fn pix_field(&self) -> Result<enums::Field> {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        enums::Field::try_from(pix.field)
    }

    /// Get the field `width` for the `pix` union member.
    fn pix_width(&self) -> u32 {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        pix.width
    }

    /// Get the field `height` for the `pix` union member.
    fn pix_height(&self) -> u32 {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        pix.height
    }

    /// Get the field `pixelformat` for the `pix` union member.
    fn pix_pixelformat(&self) -> u32 {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        pix.pixelformat
    }

    /// Get the field `bytesperline` for the `pix` union member.
    fn pix_bytesperline(&self) -> u32 {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        pix.bytesperline
    }

    /// Get the field `sizeimage` for the `pix` union member.
    fn pix_sizeimage(&self) -> u32 {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        pix.sizeimage
    }

    /// Get the field `colorspace` for the `pix` union member.
    fn pix_colorspace(&self) -> Result<enums::Colorspace> {
        let fmt =3D self.as_ref();
        let pix =3D &unsafe { fmt.fmt.pix };
        enums::Colorspace::try_from(pix.colorspace)
    }

    /// Set the field `field` for the `pix` union member.
    fn set_pix_field(&mut self, field: enums::Field) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.field =3D field as u32;
    }

    /// Set the field `width` for the `pix` union member.
    fn set_pix_width(&mut self, width: u32) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.width =3D width;
    }

    /// Set the field `height` for the `pix` union member.
    fn set_pix_height(&mut self, height: u32) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.height =3D height;
    }

    /// Set the field `pixelformat` for the `pix` union member.
    fn set_pix_pixel_format(&mut self, pixel_format: u32) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.pixelformat =3D pixel_format;
    }

    /// Set the field `bytesperline` for the `pix` union member.
    fn set_pix_bytesperline(&mut self, bytesperline: u32) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.bytesperline =3D bytesperline;
    }

    /// Set the field `sizeimage` for the `pix` union member.
    fn set_pix_sizeimage(&mut self, sizeimage: u32) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.sizeimage =3D sizeimage;
    }

    /// Set the field `sizeimage` for the `pix` union member.
    fn set_pix_colorspace(&mut self, colorspace: enums::Colorspace) {
        let fmt =3D self.as_mut();
        let pix =3D &mut unsafe { fmt.fmt.pix };
        pix.colorspace =3D colorspace as u32;
    }
}

/// A wrapper over a pointer to `struct v4l2_format`.
#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
pub struct FormatRef(*mut bindings::v4l2_format);

impl FormatRef {
    /// # Safety
    /// The caller must ensure that `ptr` is valid and remains valid
for the lifetime of the
    /// returned [`FormatRef`] instance.
    pub unsafe fn from_ptr(ptr: *mut bindings::v4l2_format) -> Self {
        Self(ptr)
    }
}

impl AsRef<bindings::v4l2_format> for FormatRef {
    fn as_ref(&self) -> &bindings::v4l2_format {
        // SAFETY: ptr is safe during the lifetime of [`FormatRef`] as
per
        // the safety requirement in `from_ptr()`
        unsafe { self.0.as_ref().unwrap() }
    }
}

impl AsMut<bindings::v4l2_format> for FormatRef {
    fn as_mut(&mut self) -> &mut bindings::v4l2_format {
        // SAFETY: ptr is safe during the lifetime of [`FormatRef`] as
per
        // the safety requirement in `from_ptr()`
        unsafe { self.0.as_mut().unwrap() }
    }
}

impl FormatImpl for FormatRef {}

/// An owned version of `FormatRef`.
#[derive(Default)]
pub struct Format(UnsafeCell<bindings::v4l2_format>);

impl AsRef<bindings::v4l2_format> for Format {
    fn as_ref(&self) -> &bindings::v4l2_format {
        // SAFETY:
        // It is safe to dereference the pointer since it is valid
whenever this type is instantiated.
        // It is safe to cast this into a shared reference: because
this is the
        // only method that returns &bindings::v4l2_format and because
we take
        // &self, the compiler takes care of enforcing the Rust
reference rules for
        // us. Thus, enforcing the safety guarantees of
UnsafeCell::get() by
        // proxy.
        unsafe { &*self.0.get() }
    }
}

impl AsMut<bindings::v4l2_format> for Format {
    fn as_mut(&mut self) -> &mut bindings::v4l2_format {
        // SAFETY:
        // It is safe to dereference the pointer since it is valid
whenever this type is instantiated.
        // It is safe to cast this into an exclusive reference: because
this is the
        // only method that returns &mut bindings::v4l2_format and
because we take
        // &mut self, the compiler takes care of enforcing the Rust
reference rules for
        // us. Thus, enforcing the safety guarantees of
UnsafeCell::get() by
        // proxy.
        unsafe { &mut *self.0.get() }
    }
}

impl FormatImpl for Format {}

```

This makes it possible to:

- Share the implementations between Format and FormatRef,
- Have both Format (while paying the cost of storing the
bindings::v4l2_format member) and FormatRef (while paying the cost of
storing a pointer) separately.
- Be generic over Format and FormatRef when needed, e.g.:

```
fn some_fn(format: impl FormatImpl) {...}
```=20

Thoughts?

-- Daniel
