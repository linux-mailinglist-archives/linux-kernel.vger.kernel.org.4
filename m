Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E896AE851
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCGRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCGROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:14:42 -0500
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86E8C807
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:09:34 -0800 (PST)
Date:   Tue, 07 Mar 2023 17:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1678208970; x=1678468170;
        bh=6ECXS/A+g9Xh21KAj63nlWfk5zLMlwT216CxnuMFQt8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dVB7eAkUgKG9AXMCQ1n9E2tToguIMbPIZEN7o5SLOeLOVNxmjRUI+QRlCnfxJtMNb
         3mS1kE2URMXehEecX1Mfw2niGMCKmeID89u+baYD2nYp7QVsmiqXLrEy0iSjE6/ngH
         5C+gHKZq5zyIEBPVkqDWQLIEI6ppkQrn/e2Mwfr1AYmnvM23AsKKmYyOMRX7e6AkUd
         3jOGkLgnyXSSC4yiNzir/PIsaghw+Qm+nx2mIl3v3v5gu20z1uxV9izNgyifwHfZ32
         +0KKR11VFKV6kHW56gHEDnoHmAf4TjMKVl66LugvAT8ay4Zk+5qPYF9D4mp6G8hHZh
         PgitYtxhsp1Pg==
To:     Daniel Almeida <daniel.almeida@collabora.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     wedsonaf@gmail.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH] rust: virtio: add virtio support
Message-ID: <OBVROfBri9SuVdfyos-71URYovcNLhbDb_50cECWMwhycY2sHH90w28f0qlJ_q_dMuCnOD_4nQCVUnwOkgyCEH1298nsVLW0YFuuiIlLPow=@protonmail.com>
In-Reply-To: <20230307130332.53029-1-daniel.almeida@collabora.com>
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 7th, 2023 at 14:03, Daniel Almeida <daniel.almeida@collab=
ora.com> wrote:

> This patch adds virtIO support to the rust crate. This includes the
> capability to create a virtIO driver (through the module_virtio_driver
> macro and the respective Driver trait) as well as initial virtqueue
> support.
>=20
> A sample virtIO module is included for conveninence.
>=20
> Signed-off-by: Daniel Almeida daniel.almeida@collabora.com
>=20
> ---
>=20
> Ok so this is my first Rust contribution here. It's part of a virtIO
> driver I was originally writing. Both the probing and the virtqueue
> support in here were confirmed as working in said prototype driver, and
> the pieces were picked separately into this patch.
>=20
> Feel free to point me to the best practices around Rust patch
> submission, as the C stuff like checkpatch etc probably does not apply
> yet. I did take care to run clippy though.
>=20

Great to see Rust support for the driver side of VirtIO! I've got a couple =
of review comments, but I don't see any big issues. Maybe you could write a=
n actual driver which uses add_sgs though? It doesn't have to be complicate=
d, but just something to show how it will work. That may help with checking=
 if the api is usable. You might try something like virtio-console or virti=
o-entropy I think.

> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |  18 +++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/virtio.rs           | 217 ++++++++++++++++++++++++++++++++
>  rust/kernel/virtio/virtqueue.rs | 110 ++++++++++++++++
>  samples/rust/Kconfig            |  10 ++
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_virtio.rs     |  54 ++++++++
>  8 files changed, 414 insertions(+)
>  create mode 100644 rust/kernel/virtio.rs
>  create mode 100644 rust/kernel/virtio/virtqueue.rs
>  create mode 100644 samples/rust/rust_virtio.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 048bae2197ac..e5bf6f4c3188 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -34,6 +34,8 @@
>  #include <linux/slab.h>
>  #include <linux/sysctl.h>
>  #include <linux/uaccess.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
>  #include <linux/uio.h>
>=20
>  /* `bindgen` gets confused at certain things. */
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bf790f46c763..28cd97228c14 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -39,6 +39,8 @@
>  #include <linux/skbuff.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
>=20
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -655,6 +657,22 @@ int rust_helper_fs_parse(struct fs_context *fc,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_fs_parse);
>=20
> +struct virtqueue *rust_helper_virtio_find_single_vq(struct virtio_device=
 *vdev,
> +=09=09=09=09=09=09    vq_callback_t *c,
> +=09=09=09=09=09=09    const char *n)
> +{
> +=09return virtio_find_single_vq(vdev, c, n);
> +}
> +
> +EXPORT_SYMBOL_GPL(rust_helper_virtio_find_single_vq);
> +
> +void rust_helper_virtio_del_vqs(struct virtio_device *vdev)
> +{
> +=09vdev->config->del_vqs(vdev);
> +}
> +
> +EXPORT_SYMBOL_GPL(rust_helper_virtio_del_vqs);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index c20b37e88ab2..324ff45f825d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -73,6 +73,8 @@ pub mod power;
>  pub mod revocable;
>  pub mod security;
>  pub mod task;
> +#[cfg(CONFIG_VIRTIO)]
> +pub mod virtio;
>  pub mod workqueue;
>=20
>  pub mod linked_list;
> diff --git a/rust/kernel/virtio.rs b/rust/kernel/virtio.rs
> new file mode 100644
> index 000000000000..57894af4f5ba
> --- /dev/null
> +++ b/rust/kernel/virtio.rs
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#![allow(missing_docs)]
> +
> +///! Virtio abstractions
> +///!
> +///! C header: [`include/linux/virtio.h`](../../../../include/media/virt=
io.h)
> +use crate::{
> +    device, driver,
> +    error::{self, from_kernel_result},
> +    prelude::*,
> +    str::CStr,
> +    to_result, ForeignOwnable, ThisModule,
> +};
> +
> +pub mod virtqueue;
> +
> +#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
> +pub struct DeviceId {
> +    pub device: u32,
> +    pub vendor: u32,
> +}
> +
> +unsafe impl const crate::driver::RawDeviceId for DeviceId {
> +    type RawType =3D bindings::virtio_device_id;
> +
> +    const ZERO: Self::RawType =3D bindings::virtio_device_id {
> +        device: 0,
> +        vendor: 0,
> +    };
> +
> +    // No `data` pointer.
> +    fn to_rawid(&self, _offset: isize) -> Self::RawType {
> +        bindings::virtio_device_id {
> +            device: self.device,
> +            vendor: self.vendor,
> +        }
> +    }
> +}
> +
> +#[macro_export]
> +macro_rules! define_virtio_id_table {
> +    ($data_type:ty, $($t:tt)*) =3D> {
> +        $crate::define_id_table!(ID_TABLE, $crate::virtio::DeviceId, $da=
ta_type, $($t)*);
> +    };
> +}
> +
> +/// A registration of a virtio driver.
> +pub type Registration<T> =3D driver::Registration<Adapter<T>>;
> +
> +/// An adapter for the registration of virtio drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +impl<T: Driver> driver::DriverOps for Adapter<T> {
> +    type RegType =3D bindings::virtio_driver;
> +
> +    unsafe fn register(
> +        reg: *mut bindings::virtio_driver,
> +        name: &'static CStr,
> +        _module: &'static ThisModule,
> +    ) -> Result {
> +        // SAFETY: By the safety requirements of this function `reg` is =
non-null
> +        // and valid.
> +        let virtio_driver =3D unsafe { &mut *reg };
> +
> +        virtio_driver.driver.name =3D name.as_char_ptr();
> +        virtio_driver.probe =3D Some(Self::probe_callback);
> +        virtio_driver.remove =3D Some(Self::remove_callback);
> +        if let Some(t) =3D T::ID_TABLE {
> +            virtio_driver.id_table =3D t.as_ref();
> +        }
> +
> +        to_result(unsafe { bindings::register_virtio_driver(reg) })
> +    }
> +
> +    unsafe fn unregister(reg: *mut bindings::virtio_driver) {
> +        // SAFETY: By the safety requirements of this function `reg` was=
 passed
> +        // (and updated) by a previous successful call to
> +        // `register_virtio_driver`.
> +        unsafe { bindings::unregister_virtio_driver(reg) };
> +    }
> +}
> +
> +impl<T: Driver> Adapter<T> {
> +    extern "C" fn probe_callback(virtio_device: *mut bindings::virtio_de=
vice) -> core::ffi::c_int {
> +        from_kernel_result! {
> +            // SAFETY: `virtio_device` is valid by the contract with the=
 C code.
> +            // `dev` is alive only for the duration of this call, so it =
is
> +            // guaranteed to remain alive for the lifetime of `virtio_de=
vice`.
> +            let mut dev =3D unsafe { Device::from_ptr(virtio_device) };
> +            let data =3D T::probe(&mut dev)?;
> +
> +            unsafe { (*virtio_device).priv_ =3D data.into_foreign() as _=
 }
> +            Ok(0)
> +        }
> +    }
> +
> +    // Note, this type is a wrapper over a kernel pointer, meaning that =
we
> +    // cannot be sure that the pointee is actually going away when the w=
rapper
> +    // is dropped. Thus, release resources here instead, since the kerne=
l will
> +    // call this when the actual pointee is to be removed.
> +    extern "C" fn remove_callback(virtio_device: *mut bindings::virtio_d=
evice) {
> +        // SAFETY: `virtio_device` is guaranteed to be a valid, non-null
> +        // pointer. `priv_` was set on probe().
> +        let ptr =3D unsafe { (*virtio_device).priv_ };
> +        // SAFETY:
> +        //   - we allocated this pointer using `T::Data::into_foreign`,
> +        //     so it is safe to turn back into a `T::Data`.
> +        //   - the allocation happened in `probe`, no-one freed the memo=
ry,
> +        //     `remove` is the canonical kernel location to free driver =
data. so OK
> +        //     to convert the pointer back to a Rust structure here.
> +        let data =3D unsafe { T::Data::from_foreign(ptr) };
> +        T::remove(&data);
> +
> +        // SAFETY: just a couple of FFI call with a valid pointer.
> +        unsafe {
> +            bindings::virtio_del_vqs(virtio_device);
> +            bindings::virtio_reset_device(virtio_device);
> +        }
> +        <T::Data as driver::DeviceRemoval>::device_remove(&data);
> +    }
> +}
> +
> +/// A virtio driver.
> +pub trait Driver {
> +    /// Data stored on device by driver in virtio_device.priv
> +    type Data: ForeignOwnable + Send + Sync + driver::DeviceRemoval =3D =
();
> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: Option<driver::IdTable<'static, DeviceId, ()>> =3D N=
one;
> +    /// The virtio features offered. This depends on the specifics of th=
e given
> +    /// virtio protocol for the device and can be empty.
> +    const FEATURES: &'static [i32] =3D &[];
> +
> +    /// Virtio driver probe.
> +    ///
> +    /// Called when a new virtio device is added or discovered.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(dev: &mut Device) -> Result<Self::Data>;
> +
> +    /// Virtio driver remove.
> +    ///
> +    /// Called when a virtio device is removed.
> +    /// Implementers should prepare the device for complete removal here=
.
> +    fn remove(_data: &Self::Data) {}
> +}
> +
> +/// A virtio device.
> +///
> +/// # Invariants
> +///
> +/// The field `ptr` is non-null and valid for the lifetime of the object=
.
> +pub struct Device {
> +    ptr: *mut bindings::virtio_device,
> +}
> +
> +impl Device {
> +    /// Creates a new device from the given pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be non-null and valid. It must remain valid for the l=
ifetime of the returned
> +    /// instance.
> +    pub unsafe fn from_ptr(ptr: *mut bindings::virtio_device) -> Self {
> +        // INVARIANT: The safety requirements of the function ensure the=
 lifetime invariant.
> +        Self { ptr }
> +    }
> +
> +    /// Returns id of the virtio device.
> +    pub fn id(&self) -> i32 {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is no=
n-null and valid.
> +        unsafe { (*self.ptr).id.device as _ }
> +    }
> +
> +    pub fn find_virtqueue<T: virtqueue::Operations>(
> +        &self,
> +        name: &CStr,
> +    ) -> Result<virtqueue::Virtqueue<T>> {
> +        let callback =3D if T::HAS_CALLBACK {
> +            Some(virtqueue::Virtqueue::<T>::vq_callback as _)
> +        } else {
> +            None
> +        };
> +
> +        // SAFETY: ptr is valid due to the type invariant, callback poin=
ts to a
> +        // valid address and the pointer passed in is passed in by the k=
ernel,
> +        // so it is assumed to be valid.
> +        let vq =3D unsafe { bindings::virtio_find_single_vq(self.ptr, ca=
llback, name.as_char_ptr()) };
> +        let vq =3D error::from_kernel_err_ptr(vq)?;
> +
> +        // SAFETY: vq is checked with `from_kernel_err_ptr`
> +        Ok(unsafe { virtqueue::Virtqueue::from_ptr(vq) })
> +    }
> +
> +    pub fn data<T: Driver>(&self) -> <T::Data as ForeignOwnable>::Borrow=
ed<'_> {
> +        unsafe { <T::Data as ForeignOwnable>::borrow((*self.ptr).priv_) =
}
> +    }
> +
> +    pub fn raw_device(&self) -> *mut bindings::virtio_device {
> +        self.ptr
> +    }
> +}
> +
> +// SAFETY: The device returned by `raw_device` is the raw virtio device.
> +unsafe impl device::RawDevice for Device {
> +    fn raw_device(&self) -> *mut bindings::device {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is no=
n-null and valid.
> +        unsafe { &mut (*self.ptr).dev }
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single virtio driver.
> +#[macro_export]
> +macro_rules! module_virtio_driver {
> +    ($($f:tt)*) =3D> {
> +        $crate::module_driver!(<T>, $crate::virtio::Adapter<T>, { $($f)*=
 });
> +    };
> +}
> diff --git a/rust/kernel/virtio/virtqueue.rs b/rust/kernel/virtio/virtque=
ue.rs
> new file mode 100644
> index 000000000000..b842e0f0da41
> --- /dev/null
> +++ b/rust/kernel/virtio/virtqueue.rs
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// #![allow(missing_docs)]
> +
> +///! Virtqueue abstractions
> +///!
> +///! C header: [`include/linux/virtio.h`](../../../../include/linux/virt=
io.h)
> +use core::marker::PhantomData;
> +
> +use crate::error;
> +use crate::prelude::*;
> +use crate::virtio;
> +use crate::ForeignOwnable;
> +
> +#[vtable]
> +pub trait Operations: Sized {
> +    /// Data passed into the callback.
> +    type PrivateData: ForeignOwnable;
> +
> +    /// The virtqueue callback.
> +    fn callback(virtqueue: Virtqueue<Self>);
> +}
> +
> +pub struct Virtqueue<T: Operations> {
> +    ptr: *mut bindings::virtqueue,
> +    phantom: PhantomData<T>,
> +}
> +
> +impl<T: Operations> Virtqueue<T> {
> +    /// # Safety
> +    /// The caller must ensure that `ptr` is valid and remains valid for=
 the lifetime of the
> +    /// returned [`Virtqueue`] instance.
> +    ///
> +    /// Caller must ensure that get_buf() returns None before the Virtqu=
eue is
> +    /// dropped, so that ownership of the passed in T::PrivateData can b=
e
> +    /// retrieved.
> +    pub unsafe fn from_ptr(ptr: *mut bindings::virtqueue) -> Self {
> +        Self {
> +            ptr,
> +            phantom: PhantomData,
> +        }
> +    }
> +
> +    /// A wrapper over virtqueue_add_sgs()
> +    pub fn add_sgs(
> +        &mut self,
> +        scatterlists: &mut [*mut bindings::scatterlist],
> +        num_out: usize,
> +        num_in: usize,
> +        data: T::PrivateData,
> +        gfp: u32,
> +    ) -> Result {

This function takes scatterlist raw pointers as argument and passes them to=
 virtqueue_add_sgs which will read from and write to these scatter lists an=
d also to memory pointed to by these scatter lists. You will either need to=
 make add_sgs unsafe or add a safe abstraction which ensures that only vali=
d scatter lists are passed in and that these scatter lists remain valid unt=
il control over them is passed back from the virtio subsystem to the driver=
.

> +        if num_out + num_in > scatterlists.len() {
> +            return Err(EINVAL);
> +        }
> +

All unsafe blocks need to be annotated with a SAFETY comment explaining why=
 it is safe to do. You are missing these SAFETY comments at a couple of loc=
ations.

> +        let res =3D unsafe {
> +            bindings::virtqueue_add_sgs(
> +                self.ptr,
> +                scatterlists.as_mut_ptr(),
> +                num_out as u32,
> +                num_in as u32,
> +                data.into_foreign() as _,
> +                gfp,
> +            )
> +        };
> +
> +        error::to_result(res)
> +    }
> +
> +    /// A wrapper over virtqueue_kick()
> +    pub fn kick(&mut self) -> Result {
> +        let res =3D unsafe { bindings::virtqueue_kick(self.ptr) };
> +        error::to_result(res as i32)
> +    }
> +
> +    /// Returns the underlying virtio::Device.
> +    pub fn virtio_device(&self) -> virtio::Device {
> +        // SAFETY: The virtio framework places a pointer to the virtio d=
evice
> +        // when creating the virtqueue
> +        unsafe { virtio::Device::from_ptr((*self.ptr).vdev) }
> +    }
> +
> +    /// A wrapper over virtqueue_get_buf().
> +    pub fn get_buf(&mut self) -> Option<(T::PrivateData, u32)> {
> +        let mut len =3D 0;
> +
> +        let data =3D unsafe {
> +            let buf =3D bindings::virtqueue_get_buf(self.ptr, &mut len a=
s _);
> +
> +            if buf.is_null() {
> +                return None;
> +            } else {
> +                // SAFETY: if there is a buffer token, it came from
> +                // into_foreign() as called in add_sgs.
> +                <T::PrivateData as ForeignOwnable>::from_foreign(buf)
> +            }
> +        };
> +
> +        Some((data, len))
> +    }
> +
> +    pub(crate) unsafe extern "C" fn vq_callback(vq: *mut bindings::virtq=
ueue) {
> +        // SAFETY: the caller should guarantee that vq is valid for the =
lifetime
> +        // of Self.
> +        let virtqueue =3D unsafe { Self::from_ptr(vq) };
> +        T::callback(virtqueue);
> +    }
> +}
> +
> +unsafe impl<T: Operations> Send for Virtqueue<T> {}
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 189c10ced6d4..0507c57170ec 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -163,4 +163,14 @@ config SAMPLE_RUST_SELFTESTS
>=20
>  =09  If unsure, say N.
>=20
> +config SAMPLE_RUST_VIRTIO
> +=09tristate "Virtio"
> +=09help
> +=09  This option builds the Rust virtio module sample.
> +
> +=09  To compile this as a module, choose M here:
> +=09  the module will be called rust_minimal.
> +
> +=09  If unsure, say N.
> +
>  endif # SAMPLES_RUST
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 420bcefeb082..24059795480f 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -15,5 +15,6 @@ obj-$(CONFIG_SAMPLE_RUST_NETFILTER)=09=09+=3D rust_netf=
ilter.o
>  obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)=09=09+=3D rust_echo_server.o
>  obj-$(CONFIG_SAMPLE_RUST_FS)=09=09=09+=3D rust_fs.o
>  obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)=09=09+=3D rust_selftests.o
> +obj-$(CONFIG_SAMPLE_RUST_VIRTIO)=09=09+=3D rust_virtio.o
>=20
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)=09=09+=3D hostprogs
> diff --git a/samples/rust/rust_virtio.rs b/samples/rust/rust_virtio.rs
> new file mode 100644
> index 000000000000..8dbae35e99a8
> --- /dev/null
> +++ b/samples/rust/rust_virtio.rs
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust virtio device driver sample.
> +
> +use kernel::bindings;
> +use kernel::module_virtio_driver;
> +use kernel::prelude::*;
> +use kernel::sync::Arc;
> +use kernel::virtio::virtqueue;
> +
> +module_virtio_driver! {
> +    type: Driver,
> +    name: "rust_virtio",
> +    license: "GPL",
> +}
> +
> +struct Driver;
> +
> +impl kernel::driver::DeviceRemoval for Driver {
> +    fn device_remove(&self) {}
> +}
> +
> +impl kernel::virtio::Driver for Driver {
> +    type Data =3D Arc<Self>;
> +
> +    kernel::define_virtio_id_table! {(), [
> +         (kernel::virtio::DeviceId {
> +            device: 0, // The protocol ID.
> +            vendor: bindings::VIRTIO_DEV_ANY_ID,
> +         }, None),
> +    ]}
> +
> +    fn probe(_: &mut kernel::virtio::Device) -> Result<Self::Data> {
> +        // To get an actual virtqueue you need VMM support, an example i=
s left
> +        // below.
> +        //
> +        // let virtqueue =3D virtio_dev.find_virtqueue::<VirtqueueCallba=
ck>(kernel::c_str!(""))?;
> +        Arc::try_new(Self {})
> +    }
> +}
> +
> +pub(crate) struct VirtqueueCallback;
> +
> +#[vtable]
> +impl virtqueue::Operations for VirtqueueCallback {
> +    type PrivateData =3D Arc<Self>;
> +
> +    fn callback(vq: virtqueue::Virtqueue<Self>) {
> +        let vdev =3D vq.virtio_device();
> +        let data =3D vdev.data::<Driver>();
> +        let _data =3D &*data;
> +        // Usually some work is enqueued here to be processed later.
> +    }
> +}
> --
> 2.39.2

Cheers,
Bjorn
