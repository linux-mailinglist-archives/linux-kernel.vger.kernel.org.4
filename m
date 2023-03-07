Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C55B6AEAFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCGRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjCGRia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:38:30 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95CC3B20E;
        Tue,  7 Mar 2023 09:34:32 -0800 (PST)
Date:   Tue, 07 Mar 2023 17:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1678210468; x=1678469668;
        bh=8OZWBaubQuoarrG6jpZ95qDxehDJejucdLPuF5MOp3M=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bUt03tBYnJoUKg8MnJvg7z9HQpfFvZX7S4++QQTsXHM1NqB94GwS0lmrXUP64L3Fa
         vflhoh4N9ws9+4MmnfcFzK+ci9z91GcRiGi+h8TdGp6/7ibuiV4eeXOmXMXAdtLLzG
         +IsUKYbiNy4En5xtoajOEkZ7tt0HmKaC2X2DDXlxW7ew8xFvWInzetjP3MzKxS5zSe
         tk/16eVsaDX7+dJn7TstItNAVOVIh5obsrqqhU4f2kt1AcB7W+UyG1GETwQwDoV6G2
         6wvELg9dPl7X4c6RQaC4DftQcjWRzSpd/+yRJv9CvBJUZKRCiWp11pabvglmXVXwnT
         DF8zVB+62PaBg==
To:     Asahi Lina <lina@asahilina.net>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH RFC 01/18] rust: drm: ioctl: Add DRM ioctl abstraction
Message-ID: <D9Cyx-9kbjaeb8QVBFqapDyctoDdVyu5uXEJDR41sdXUDXM1VgdRicV5huJDwfC3-T2J-R_DYHH8JZ1_aRdgbeYZFT78J9QveeeYbiTq4yU=@protonmail.com>
In-Reply-To: <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net>
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net> <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Tuesday, March 7th, 2023 at 15:25, Asahi Lina <lina@asahilina.net> wrote=
:

> DRM drivers need to be able to declare which driver-specific ioctls they
> support. This abstraction adds the required types and a helper macro to
> generate the ioctl definition inside the DRM driver.
>=20
> Note that this macro is not usable until further bits of the
> abstraction are in place (but it will not fail to compile on its own, if
> not called).
>=20
> Signed-off-by: Asahi Lina lina@asahilina.net
>=20
> ---
>  drivers/gpu/drm/Kconfig         |   7 ++
>  rust/bindings/bindings_helper.h |   2 +
>  rust/kernel/drm/ioctl.rs        | 147 ++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/drm/mod.rs          |   5 ++
>  rust/kernel/lib.rs              |   2 +
>  5 files changed, 163 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index dc0f94f02a82..dab8f0f9aa96 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -27,6 +27,13 @@ menuconfig DRM
>  =09  details.  You should also select and configure AGP
>  =09  (/dev/agpgart) support if it is available for your platform.
>=20
> +# Rust abstractions cannot be built as modules currently, so force them =
as
> +# bool by using these intermediate symbols. In the future these could be
> +# tristate once abstractions themselves can be built as modules.
> +config RUST_DRM
> +=09bool "Rust support for the DRM subsystem"
> +=09depends on DRM=3Dy
> +
>  config DRM_MIPI_DBI
>  =09tristate
>  =09depends on DRM
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 91bb7906ca5a..2687bef1676f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,6 +6,7 @@
>   * Sorted alphabetically.
>   */
>=20
> +#include <drm/drm_ioctl.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> @@ -23,6 +24,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/timekeeping.h>
>  #include <linux/xarray.h>
> +#include <uapi/drm/drm.h>
>=20
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> new file mode 100644
> index 000000000000..10304efbd5f1
> --- /dev/null
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +#![allow(non_snake_case)]
> +
> +//! DRM IOCTL definitions.
> +//!
> +//! C header: [`include/linux/drm/drm_ioctl.h`](../../../../include/linu=
x/drm/drm_ioctl.h)
> +
> +use crate::ioctl;
> +
> +const BASE: u32 =3D bindings::DRM_IOCTL_BASE as u32;
> +
> +/// Construct a DRM ioctl number with no argument.
> +pub const fn IO(nr: u32) -> u32 {
> +    ioctl::_IO(BASE, nr)
> +}
> +
> +/// Construct a DRM ioctl number with a read-only argument.
> +pub const fn IOR<T>(nr: u32) -> u32 {
> +    ioctl::_IOR::<T>(BASE, nr)
> +}
> +
> +/// Construct a DRM ioctl number with a write-only argument.
> +pub const fn IOW<T>(nr: u32) -> u32 {
> +    ioctl::_IOW::<T>(BASE, nr)
> +}
> +
> +/// Construct a DRM ioctl number with a read-write argument.
> +pub const fn IOWR<T>(nr: u32) -> u32 {
> +    ioctl::_IOWR::<T>(BASE, nr)
> +}
> +
> +/// Descriptor type for DRM ioctls. Use the `declare_drm_ioctls!{}` macr=
o to construct them.
> +pub type DrmIoctlDescriptor =3D bindings::drm_ioctl_desc;
> +
> +/// This is for ioctl which are used for rendering, and require that the=
 file descriptor is either
> +/// for a render node, or if it=E2=80=99s a legacy/primary node, then it=
 must be authenticated.
> +pub const AUTH: u32 =3D bindings::drm_ioctl_flags_DRM_AUTH;
> +
> +/// This must be set for any ioctl which can change the modeset or displ=
ay state. Userspace must
> +/// call the ioctl through a primary node, while it is the active master=
.
> +///
> +/// Note that read-only modeset ioctl can also be called by unauthentica=
ted clients, or when a
> +/// master is not the currently active one.
> +pub const MASTER: u32 =3D bindings::drm_ioctl_flags_DRM_MASTER;
> +
> +/// Anything that could potentially wreak a master file descriptor needs=
 to have this flag set.
> +///
> +/// Current that=E2=80=99s only for the SETMASTER and DROPMASTER ioctl, =
which e.g. logind can call to force
> +/// a non-behaving master (display compositor) into compliance.
> +///
> +/// This is equivalent to callers with the SYSADMIN capability.
> +pub const ROOT_ONLY: u32 =3D bindings::drm_ioctl_flags_DRM_ROOT_ONLY;
> +
> +/// Whether drm_ioctl_desc.func should be called with the DRM BKL held o=
r not. Enforced as the
> +/// default for all modern drivers, hence there should never be a need t=
o set this flag.
> +///
> +/// Do not use anywhere else than for the VBLANK_WAIT IOCTL, which is th=
e only legacy IOCTL which
> +/// needs this.
> +pub const UNLOCKED: u32 =3D bindings::drm_ioctl_flags_DRM_UNLOCKED;
> +
> +/// This is used for all ioctl needed for rendering only, for drivers wh=
ich support render nodes.
> +/// This should be all new render drivers, and hence it should be always=
 set for any ioctl with
> +/// `AUTH` set. Note though that read-only query ioctl might have this s=
et, but have not set
> +/// DRM_AUTH because they do not require authentication.
> +pub const RENDER_ALLOW: u32 =3D bindings::drm_ioctl_flags_DRM_RENDER_ALL=
OW;
> +
> +/// Declare the DRM ioctls for a driver.
> +///
> +/// Each entry in the list should have the form:
> +///
> +/// `(ioctl_number, argument_type, flags, user_callback),`
> +///
> +/// `argument_type` is the type name within the `bindings` crate.
> +/// `user_callback` should have the following prototype:
> +///
> +/// ```
> +/// fn foo(device: &kernel::drm::device::Device<Self>,
> +///        data: &mut bindings::argument_type,
> +///        file: &kernel::drm::file::File<Self::File>,
> +/// )
> +/// ```
> +/// where `Self` is the drm::drv::Driver implementation these ioctls are=
 being declared within.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// kernel::declare_drm_ioctls! {
> +///     (FOO_GET_PARAM, drm_foo_get_param, ioctl::RENDER_ALLOW, my_get_p=
aram_handler),
> +/// }
> +/// ```
> +///
> +#[macro_export]
> +macro_rules! declare_drm_ioctls {
> +    ( $(($cmd:ident, $struct:ident, $flags:expr, $func:expr)),* $(,)? ) =
=3D> {
> +        const IOCTLS: &'static [$crate::drm::ioctl::DrmIoctlDescriptor] =
=3D {
> +            const _:() =3D {
> +                let i: u32 =3D $crate::bindings::DRM_COMMAND_BASE;
> +                // Assert that all the IOCTLs are in the right order and=
 there are no gaps,
> +                // and that the sizeof of the specified type is correct.
> +                $(
> +                    let cmd: u32 =3D $crate::macros::concat_idents!($cra=
te::bindings::DRM_IOCTL_, $cmd);
> +                    ::core::assert!(i =3D=3D $crate::ioctl::_IOC_NR(cmd)=
);
> +                    ::core::assert!(core::mem::size_of::<$crate::binding=
s::$struct>() =3D=3D $crate::ioctl::_IOC_SIZE(cmd));
> +                    let i: u32 =3D i + 1;
> +                )*
> +            };
> +
> +            let ioctls =3D &[$(
> +                $crate::bindings::drm_ioctl_desc {
> +                    cmd: $crate::macros::concat_idents!($crate::bindings=
::DRM_IOCTL_, $cmd) as u32,
> +                    func: {
> +                        #[allow(non_snake_case)]
> +                        unsafe extern "C" fn $cmd(
> +                                raw_dev: *mut $crate::bindings::drm_devi=
ce,
> +                                raw_data: *mut ::core::ffi::c_void,
> +                                raw_file_priv: *mut $crate::bindings::dr=
m_file,
> +                        ) -> core::ffi::c_int {
> +                            // SAFETY: We never drop this, and the DRM c=
ore ensures the device lives
> +                            // while callbacks are being called.
> +                            //
> +                            // FIXME: Currently there is nothing enforci=
ng that the types of the
> +                            // dev/file match the current driver these i=
octls are being declared
> +                            // for, and it's not clear how to enforce th=
is within the type system.
> +                            let dev =3D ::core::mem::ManuallyDrop::new(u=
nsafe {
> +                                $crate::drm::device::Device::from_raw(ra=
w_dev)
> +                            });
> +                            // SAFETY: This is just the ioctl argument, =
which hopefully has the right type
> +                            // (we've done our best checking the size).

In the rust tree there is the ReadableFromBytes [1] trait which indicates t=
hat it is safe to read arbitrary bytes into the type. Maybe you could add i=
t as bound on the argument type when it lands in rust-next? This way you ca=
n't end up with for example a struct containing a bool with the byte value =
2, which is UB.

https://rust-for-linux.github.io/docs/kernel/io_buffer/trait.ReadableFromBy=
tes.html [1]

> +                            let data =3D unsafe { &mut *(raw_data as *mu=
t $crate::bindings::$struct) };
> +                            // SAFETY: This is just the DRM file structu=
re
> +                            let file =3D unsafe { $crate::drm::file::Fil=
e::from_raw(raw_file_priv) };
> +
> +                            match $func(&*dev, data, &file) {
> +                                Err(e) =3D> e.to_kernel_errno(),
> +                                Ok(i) =3D> i.try_into().unwrap_or(ERANGE=
.to_kernel_errno()),
> +                            }
> +                        }
> +                        Some($cmd)
> +                    },
> +                    flags: $flags,
> +                    name: $crate::c_str!(::core::stringify!($cmd)).as_ch=
ar_ptr(),
> +                }
> +            ),*];
> +            ioctls
> +        };
> +    };
> +}
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> new file mode 100644
> index 000000000000..9ec6d7cbcaf3
> --- /dev/null
> +++ b/rust/kernel/drm/mod.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM subsystem abstractions.
> +
> +pub mod ioctl;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7903490816bf..cb23d24c6718 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -37,6 +37,8 @@ mod build_assert;
>  pub mod delay;
>  pub mod device;
>  pub mod driver;
> +#[cfg(CONFIG_RUST_DRM)]
> +pub mod drm;
>  pub mod error;
>  pub mod io_buffer;
>  pub mod io_mem;
>=20
> --
> 2.35.1

Cheers,
Bjorn
