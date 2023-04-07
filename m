Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C59C6DB73D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDGXgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDGXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:36:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698CA27B;
        Fri,  7 Apr 2023 16:36:51 -0700 (PDT)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C54B6603133;
        Sat,  8 Apr 2023 00:36:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680910610;
        bh=U92h6mBorkK2GfO57Y3hQxwoW1sYUwbwLA36Ut5C1Po=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mBwiG5b5MVsT1PirCzrJr2STC4IIeHt1bhofLwHTCr/kvUCMvCDpcQGlw1PlvrbH8
         EgBMjRKPPx7+ViGjF2UfdApetygAq2YEiDu8ZmnfAovOS4frAise1umLMZHxwzEiKe
         0GGiAmjfKvzgYmp8Rff3scuTrB3VoNeOZ+S2LN0rabAHOL9kiBtAkSiHCvU3jLEoay
         n6AtxJMhhdeOI9kyswCfbuKsoRgGLcxkwUkR40UDyrL40V9l/Brs3vEGlH3s5CBxsm
         TX3Flg16U0lFFutLi6/JDnhgNwqs/TvWxTP0xbSl2L5tcLuDmcyECEstGM5oIQt3NK
         n+fVGlrwH0FqQ==
Message-ID: <f8b738940f2502e582acb59229d419825c9a1ffb.camel@collabora.com>
Subject: Re: [PATCH v2 2/2] rust: virtio: add virtio support
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Date:   Fri, 07 Apr 2023 20:36:35 -0300
In-Reply-To: <CANeycqoh+ePXODJ57UT1UdhHDgzDXr=KoQEo7HiSDJDHha2dsQ@mail.gmail.com>
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
         <20230405201416.395840-3-daniel.almeida@collabora.com>
         <CANeycqoh+ePXODJ57UT1UdhHDgzDXr=KoQEo7HiSDJDHha2dsQ@mail.gmail.com>
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

Hi Wedson, Martin,

First of all, thanks for the review.


> > +=C2=A0=C2=A0=C2=A0 /// VirtIO driver remove.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// Called when a virtio device is removed.
> > +=C2=A0=C2=A0=C2=A0 /// Implementers should prepare the device for comp=
lete
> > removal here.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// In particular, implementers must ensure no buff=
ers are
> > left over in the
> > +=C2=A0=C2=A0=C2=A0 /// virtqueues in use by calling [`virtqueue::get_b=
uf()`]
> > until `None` is
> > +=C2=A0=C2=A0=C2=A0 /// returned.
>=20
> What happens if implementers don't do this?
>=20
> If this is a safety requirement, we need to find a different way to
> enforce it.
>=20
> >=20

This is the worst part of this patch by far, unfortunately. If one
doesn't do this, then s/he will leak the `data` field passed in through
into_foreign() here:



> +        // SAFETY: `self.ptr` is valid as per the type invariant.
> +        let res =3D unsafe {
> +            bindings::virtqueue_add_sgs(
> +                self.ptr,
> +                sgs.as_mut_ptr(),
> +                num_out as u32,
> +                num_in as u32,
> +                data.into_foreign() as _,
> +                gfp,
> +            )
> +        };
> +

Note the comment here:


> +            // SAFETY: if there is a buffer token, it came from
> +            // `into_foreign()` as called in `add_sgs()`.
> +            <T::PrivateData as ForeignOwnable>::from_foreign(buf)


To be honest, I tried coming up with something clever to solve this,
but couldn't. Ideally this should happen when this function is called:

> +    extern "C" fn remove_callback(virtio_device: *mut
bindings::virtio_device) {


But I did not find a way to iterate over the the `vqs` member from the
Rust side, i.e.:

```

struct virtio_device {
	int index;
	bool failed;
	bool config_enabled;
	bool config_change_pending;
	spinlock_t config_lock;
	spinlock_t vqs_list_lock; /* Protects VQs list access */
	struct device dev;
	struct virtio_device_id id;
	const struct virtio_config_ops *config;
	const struct vringh_config_ops *vringh_config;
	struct list_head vqs; <------------------
```

Is there any wrappers over list_for_each_entry(), etc, to be used from
Rust? If so, I could not find them.

Doing this cleanup from Virtqueue::Drop() is not an option either:
since we wrap over a pointer owned by the kernel, there's no guarantee
that the actual virtqueue is going away when drop is called on the
wrapper. In fact, this is never the case, as virtqueues are deleted
through this call:


> +void rust_helper_virtio_del_vqs(struct virtio_device *vdev)
> +{
> +       vdev->config->del_vqs(vdev);
> +}
> +



Suggestions welcome,

-- Daniel

