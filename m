Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25344612247
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ2LRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2LRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:17:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254572695
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:17:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bs21so9629504wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0tXyLiYHTFHrnfELnhiBy2A0/lH8eJ/gz7nv9Y4WAk=;
        b=qxxZZXAn/0ROZrdlj6fgD9B8BnlwZogfSH6Qzy9kMn3t8WTqscrss4BHDk1ZyaHrui
         04M0Zu4YZIW2XQ3qqk1sxZasKIz41tFStQiFtXFlmJF9RQHoJFl7rCjZr04Y/+X0PGrj
         acVewaNhmXC8ArCzpydE/qod7eh5PtS7LB6+/a1LujunMi2u6cMSRW1MhxEX956htpPc
         7Y33Rd0Z8LzodRfWJ4KtoPTzryQsRtrfn8tye4K2/DFqc2Hn7qb9bJQPKue9p5E4d0Fx
         AIfFERvOrCqeY2vcuQdmbuQHb2aHjuxg0Gy6Pq/Np1h6zF+ZsphexiQ8DV4y5BpkhXFA
         npgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0tXyLiYHTFHrnfELnhiBy2A0/lH8eJ/gz7nv9Y4WAk=;
        b=zydIFOClNpMmjC5R68kvptUa2UsU5a2XS/4eVPlFmjTF9qw8twjQePnQvMkPzKN7Hx
         CZb0zscNAYoQPxg1AtHOTs9FWIhHzOFzTTgjq3ZBc8G4SUkqsO3fjPJU6cvy6GjtD1Hu
         wLWOHwDwJYjOOHGuLXW3pkmbDtWw/wJzmlIwLOhkJlUR5TZTqDO/zIVPAhBGpmIDmDId
         9A2FLM6mA0gjE1xdhGk8I1TYcTmJ/UZ+CkQBoVyMLBZF27BBGNBSz8hywjPcGb8DblIl
         3x/U3uGw/5xgKfc4+ILCOGL1lmupZfTMtKRz1fc910+GkgF06ZHUGEhKlcBDBZwk1tRw
         8v1A==
X-Gm-Message-State: ACrzQf0vMdwLfgUb57Stq2MT9kAa5EEr6CmilJVLtoBriGsNhnJAcP8/
        yfKpwZ4kEffGwyLslYmcAlM=
X-Google-Smtp-Source: AMsMyM6OFxR8YNWlsapvGAgXKJQWYY3dgSYdiq08z6wpiK2S3QJ21a9bAi7mXamMRWHdvBIiDvt74A==
X-Received: by 2002:adf:dd91:0:b0:236:a261:6930 with SMTP id x17-20020adfdd91000000b00236a2616930mr2086998wrl.551.1667042226974;
        Sat, 29 Oct 2022 04:17:06 -0700 (PDT)
Received: from suse.localnet (host-79-43-11-206.retail.telecomitalia.it. [79.43.11.206])
        by smtp.gmail.com with ESMTPSA id c6-20020a056000104600b0022e344a63c7sm1227924wrx.92.2022.10.29.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 04:17:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/9] drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
Date:   Sat, 29 Oct 2022 13:17:03 +0200
Message-ID: <2541717.Lt9SDvczpP@suse>
In-Reply-To: <20221017093726.2070674-2-zhao1.liu@linux.intel.com>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com> <20221017093726.2070674-2-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 17 ottobre 2022 11:37:17 CEST Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> The use of kmap_atomic() is being deprecated in favor of
> kmap_local_page()[1].
>=20
> The main difference between atomic and local mappings is that local
> mappings doesn't disable page faults or preemption.

You are right about about page faults which are never disabled by=20
kmap_local_page(). However kmap_atomic might not disable preemption. It=20
depends on CONFIG_PREEMPT_RT.

Please refer to how kmap_atomic_prot() works (this function is called by=20
kmap_atomic() when kernels have HIGHMEM enabled).

>=20
> There're 2 reasons why i915_gem_object_read_from_page_kmap() doesn't
> need to disable pagefaults and preemption for mapping:
>=20
> 1. The flush operation is safe for CPU hotplug when preemption is not
> disabled.=20

I'm confused here. Why are you talking about CPU hotplug?
In any case, developers should never rely on implicit calls of=20
preempt_disable() for the reasons said above. Therefore, flush operations=20
should be allowed regardless that kmap_atomic() potential side effect.

> In drm/i915/gem/i915_gem_object.c, the function
> i915_gem_object_read_from_page_kmap() calls drm_clflush_virt_range()

If I recall correctly, drm_clflush_virt_range() can always be called with p=
age=20
faults and preemption enabled. If so, this is enough to say that the=20
conversion is safe.=20

Is this code explicitly related to flushing the cache lines before removing=
 /=20
adding CPUs? If I recall correctly, there are several other reasons behind =
the=20
need to issue cache lines flushes. Am I wrong about this?

Can you please say more about what I'm missing here?

> to
> use CLFLUSHOPT or WBINVD to flush. Since CLFLUSHOPT is global on x86
> and WBINVD is called on each cpu in drm_clflush_virt_range(), the flush
> operation is global and any issue with cpu's being added or removed
> can be handled safely.

Again your main concern is about CPU hotplug.

Even if I'm missing something, do we really need all these details about th=
e=20
inner workings of drm_clflush_virt_range()?=20

I'm not an expert, so may be that I'm wrong about all I wrote above.

Therefore, can you please elaborate a little more for readers with very lit=
tle=20
knowledge of these kinds of things (like me and perhaps others)?
=20
> 2. Any context switch caused by preemption or sleep (pagefault may
> cause sleep) doesn't affect the validity of local mapping.

I'd replace "preemption or sleep" with "preemption and page faults" since=20
yourself then added that page faults lead to tasks being put to sleep. =20

> Therefore, i915_gem_object_read_from_page_kmap() is a function where
> the use of kmap_local_page() in place of kmap_atomic() is correctly
> suited.
>=20
> Convert the calls of kmap_atomic() / kunmap_atomic() to
> kmap_local_page() / kunmap_local().
>=20
> And remove the redundant variable that stores the address of the mapped
> page since kunmap_local() can accept any pointer within the page.
>=20
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.=
com
>=20
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Suggested by credits:
>   Dave: Referred to his explanation about cache flush.
>   Ira: Referred to his task document, review comments and explanation abo=
ut
>        cache flush.
>   Fabio: Referred to his boiler plate commit message.
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_object.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> b/drivers/gpu/drm/i915/gem/i915_gem_object.c index=20
369006c5317f..a0072abed75e 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> @@ -413,17 +413,15 @@ void __i915_gem_object_invalidate_frontbuffer(struct
> drm_i915_gem_object *obj, static void
>  i915_gem_object_read_from_page_kmap(struct drm_i915_gem_object *obj, u64=
=20
offset, void
> *dst, int size) {
> -	void *src_map;
>  	void *src_ptr;
>=20
> -	src_map =3D kmap_atomic(i915_gem_object_get_page(obj, offset >>=20
PAGE_SHIFT));
> -
> -	src_ptr =3D src_map + offset_in_page(offset);
> +	src_ptr =3D kmap_local_page(i915_gem_object_get_page(obj, offset >>=20
PAGE_SHIFT))
> +	          + offset_in_page(offset);
>  	if (!(obj->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
>  		drm_clflush_virt_range(src_ptr, size);
>  	memcpy(dst, src_ptr, size);
>=20
> -	kunmap_atomic(src_map);
> +	kunmap_local(src_ptr);
>  }
>=20
>  static void

The changes look good, but I'd like to better understand the commit message.

Thanks,

=46abio=20


