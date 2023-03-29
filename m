Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40F6CEEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjC2QGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjC2QFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:05:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086534C16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:04:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r11so16290345wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680105821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IRtUBbRSjYRGGTzk2ZeeLFD58mRS+B7ZwMU5v21lN8=;
        b=RPNeUpw6H4k78hZDbjnl2vxtFBfHeLhVW0W7MgG/AzYvCwWhN3vLmdMA3tfU/GFI6J
         8Cs45VEEX/AthWAzM33HedfMZYdXHoDkzqbfVSA1gplwO77zalHdslRr3UzhlMvMCDn4
         lLAzC167vCnctSygBHU85+tBKbQhzYjcBjojAWVKA+AfcdQhDOW0VYg1nDu+rH5mCIgd
         910UxiFQpWziCoksnYDHOoo7E4/ZVXVkMVWwvMsBNueWywE1mR5ZeTFNzbtZXuDqXxHh
         W6mHgoZjYaTj1DUrbzqvm/PAm9/eEfGNTaYJzBk0OBYNNDGNo+uFOZaO6t9ARwzOT5SU
         pBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IRtUBbRSjYRGGTzk2ZeeLFD58mRS+B7ZwMU5v21lN8=;
        b=J97IqKl4wkcoihaOL4L1FJVZyKNoXf8pe9G8vFq6yS0fTwLznSZpLHdDqV6iWlYBtO
         sFinqby7keUZx2/okAWocbzLcSXwBJPJYWdlHmRUJ+/hYgTbFwaXbeocpswCubJu7ImM
         ILitQtdgnHIKM2EIvFmPi5BBHVoiFm8ALLJ+gdZWny8T7xHKud+ZpmBeqJsuloMuN2LA
         YNWLmvOl/pHkovdAvX3O8CCNNOuHZRI/tZ65SkFfcSAR5DPdke1MXMPzhClGVTzgZLlh
         RyadYMTJ/qhqWJ9idvoZR4cRz9pYZryAMoe+zDw/GMm9hlk2m8/jF2fGMmcbJUtWtuRp
         IQPg==
X-Gm-Message-State: AAQBX9cKyXIjvLBLxTevCFPXWk36eEpQ0Pcnyk2biTLcqYgkslntdxUJ
        O0ZVTXomOlqKZozBtHdX9fU=
X-Google-Smtp-Source: AKy350aB4UjMmjOybgA5VoyRCtdL4cDgoRtImatSJnCjwG3Rg/l1NyO0wa1UVW6Fu+gCYJfZ6cG/aA==
X-Received: by 2002:a5d:458c:0:b0:2ce:a3e0:238f with SMTP id p12-20020a5d458c000000b002cea3e0238fmr16534797wrq.60.1680105820930;
        Wed, 29 Mar 2023 09:03:40 -0700 (PDT)
Received: from suse.localnet (host-95-248-13-140.retail.telecomitalia.it. [95.248.13.140])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d510d000000b002c794495f6fsm27494148wrt.117.2023.03.29.09.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:03:40 -0700 (PDT)
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
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 0/9] drm/i915: Replace kmap_atomic() with kmap_local_page()
Date:   Wed, 29 Mar 2023 18:03:38 +0200
Message-ID: <4498688.cEBGB3zze1@suse>
In-Reply-To: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 29 marzo 2023 09:32:11 CEST Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> Hi list,
>=20
> Sorry for a long delay since v1 [1]. This patchset is based on 197b6b6
> (Linux 6.3-rc4).
>=20
> Welcome and thanks for your review and comments!
>=20
>=20
> # Purpose of this patchset
>=20
> The purpose of this pacthset is to replace all uses of kmap_atomic() in
> i915 with kmap_local_page() because the use of kmap_atomic() is being
> deprecated in favor of kmap_local_page()[1]. And 92b64bd (mm/highmem:
> add notes about conversions from kmap{,_atomic}()) has declared the
> deprecation of kmap_atomic().
>=20
>=20
> # Motivation for deprecating kmap_atomic() and using kmap_local_page()
>=20
> The main difference between atomic and local mappings is that local
> mappings doesn't disable page faults or preemption (the preemption is
> disabled for !PREEMPT_RT case, otherwise it only disables migration).
>=20
> With kmap_local_page(), we can avoid the often unwanted side effect of
> unnecessary page faults and preemption disables.
>=20
>=20
> # Patch summary
>=20
> Patch 1, 4-6 and 8-9 replace kamp_atomic()/kunmap_atomic() with
>         kmap_local_page()/kunmap_local() directly. With thses local
>         mappings, the page faults and preemption are allowed.
>=20
> Patch 2 and 7 use memcpy_from_page() and memcpy_to_page() to replace
>         kamp_atomic()/kunmap_atomic(). These two variants of memcpy()
>         are based on the local mapping, so page faults and preemption
>         are also allowed in these two interfaces.
>=20
> Patch 3 replaces kamp_atomic()/kunmap_atomic() with kmap_local_page()/
>         kunmap_local() and also diable page fault since the for special
>         handling (pls see the commit message).
>=20
>=20
> # Changes since v1
>=20
> * Dropped hot plug related description in commit message since it has
>   nothing to do with kmap_local_page().
> * Emphasized the motivation for using kmap_local_page() in commit
>   message.
> * Rebased patch 1 on f47e630 (drm/i915/gem: Typecheck page lookups) to
>   keep the "idx" variable of type pgoff_t here.
> * Used memcpy_from_page() and memcpy_to_page() to replace
>   kmap_local_page() + memcpy() in patch 2.
>=20
>=20
> # Reference
>=20
> [1]:
> https://lore.kernel.org/lkml/20221017093726.2070674-1-zhao1.liu@linux.int=
el.c
> om/ [1]:
> https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com -=
=2D-
> Zhao Liu (9):
>   drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
>   drm/i915: Use memcpy_[from/to]_page() in gem/i915_gem_pyhs.c
>   drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
>   drm/i915: Use kmap_local_page() in gem/selftests/huge_pages.c
>   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
>   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
>   drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
>   drm/i915: Use kmap_local_page() in i915_cmd_parser.c
>   drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c
>=20

I _think_ that the "long delay" you mentioned in the first sentence has pai=
d=20
off in full.=20

I don't see things to improve (except all those "kamp_atomic()" typo in the=
=20
patches summary; however, typos are only in the cover so I'm sure they won'=
t=20
hurt anybody).=20

Each of the nine patches listed above looks good to me, so they are all=E2=
=80=A6

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks!

=46abio

PS: Obviously there was no need to reconfirm my tag for patch 3/9. A single=
=20
tag that catches all patches is easier for a lazy person like me :-)

>
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       | 10 +++++-----
>  drivers/gpu/drm/i915/gem/i915_gem_object.c           |  8 +++-----
>  drivers/gpu/drm/i915/gem/i915_gem_phys.c             | 10 ++--------
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c            |  6 ++++--
>  drivers/gpu/drm/i915/gem/selftests/huge_pages.c      |  6 +++---
>  .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
>  .../gpu/drm/i915/gem/selftests/i915_gem_context.c    |  8 ++++----
>  drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c             |  5 +----
>  drivers/gpu/drm/i915/i915_cmd_parser.c               |  4 ++--
>  9 files changed, 28 insertions(+), 41 deletions(-)
>=20
> --
> 2.34.1




