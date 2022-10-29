Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6E6120E0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ2HMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ2HMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:12:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D096105CD0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:12:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso5122808wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LmWzyQSrl0RTIim8O+jOq3HpQpoL52+tegLujW7nc0=;
        b=Qamia2mNdG+4Etnm9fZK/GEWc2oTqVjcWJemA7+faBe3tTKpki0Pviae5dWL+SMhnM
         /H7Tc0jAkp/j45lulMewb6aSxzuN4FO4dV5/POjSf5dYTtDkYkZjsYctkEPWVfx7kypa
         4cmCWsoCwhMC8V6eVGEjLvzrS6NKQ0De4PbQ1Pu/H9VWjInsIsuwAJOa1DkJ3GL0P08m
         6IDjGrkVG1n3jeEHGclMpBc4QqOi4iymkVfTm+pkkU3cUBL688P9Wxp2mLlFB96vvgtn
         7ZBgRVK3DVM80isOIS3GhW7yhMous00OcaYmNpZAbZwHX/oXFfeGTbZEdTgtf8JF2LCb
         BVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LmWzyQSrl0RTIim8O+jOq3HpQpoL52+tegLujW7nc0=;
        b=gStYbZi/JAXCJwLNMKKUo4RT8usTbkSA3gaph5R1Mo5SCZrU+qJbmfvK6FrmYX1IUB
         hZD4nqqSeG6fOJ9hY8QD037Qz0WW4ijPLZvvYtHQjoMZpOsl6OstThZ3KvB0P+Qu2hC8
         jnZfCUllEbObusQu9Akq+3gMIVDPqxAFSf/U7vyUQ4/kSJjFqv3uQ+WUqnqcsKubHHk+
         bK0OPRQcgwCGBUJIGu/s0+xHFFvCuPYp1kz/SdSvsjh4ZjU1zy9RfH0zozvD0qgXr8vT
         3WU8UB/joJmo1KOKOoC9NS7P7yaviVMzc6ZbIrH/6QBH5RlAgEcKdk4ebCdIvmgnohTM
         TYNA==
X-Gm-Message-State: ACrzQf3xcm9HrsXplU3grnBJF7Z0gQEu9uh/5WMQcSsKdfyFzFtT4CHW
        WAstUdKc2kauePNAgipshb0=
X-Google-Smtp-Source: AMsMyM5VbYe3KHUjunTOUobsVeVOTS3YZupYVm5K8P3gIxM9vM1MlavEhYY3mc9wL16JxW82wUzG7g==
X-Received: by 2002:a05:600c:26cb:b0:3cf:6265:ddc6 with SMTP id 11-20020a05600c26cb00b003cf6265ddc6mr1902095wmv.195.1667027551615;
        Sat, 29 Oct 2022 00:12:31 -0700 (PDT)
Received: from suse.localnet (host-79-43-11-206.retail.telecomitalia.it. [79.43.11.206])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d5183000000b00231ed902a4esm784817wrv.5.2022.10.29.00.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:12:30 -0700 (PDT)
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
Subject: Re: [PATCH 0/9] drm/i915: Replace kmap_atomic() with kmap_local_page()
Date:   Sat, 29 Oct 2022 09:12:27 +0200
Message-ID: <10176905.nUPlyArG6x@suse>
In-Reply-To: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
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

On luned=EC 17 ottobre 2022 11:37:16 CEST Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> The use of kmap_atomic() is being deprecated in favor of
> kmap_local_page()[1].

Some words to explain why kmap_atomic was deprecated won't hurt. Many=20
maintainers and reviewers, and also casual readers might not yet be aware o=
f=20
the reasons behind that deprecation.
=20
> In the following patches, we can convert the calls of kmap_atomic() /
> kunmap_atomic() to kmap_local_page() / kunmap_local(), which can
> instead do the mapping / unmapping regardless of the context.

Readers are probably much more interested in what you did in the following=
=20
patches and why you did it, instead of being informed about what "we can" d=
o.

I would suggest something like "The following patches convert the calls to=
=20
kmap_atomic() to kmap_local_page() [the rest looks OK]".

This could also be the place to say something about why we prefer=20
kmap_local_page() to kmap_atomic().=20

Are you sure that the reasons that motivates your conversions are merely=20
summarized to kmap_local_page() being able to do mappings regardless of=20
context? I think you are missing the real reasons why.=20

What about avoiding the often unwanted side effect of unnecessary page faul=
ts=20
disables?

>=20
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible.

No news here. kmap_atomic() is "per thread, CPU local and not glocally=20
visible". I cannot see any difference here between kmap_atomic() and=20
kmap_local_page().

>=20
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.=
com
> ---
> Zhao Liu (9):
>   drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
>   drm/i915: Use kmap_local_page() in gem/i915_gem_pyhs.c
>   drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
>   drm/i915: Use kmap_local_page() in gem/selftests/huge_pages.c
>   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
>   drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
>   drm/i915: Use memcpy_from_page() in gt/uc/intel_uc_fw.c
>   drm/i915: Use kmap_local_page() in i915_cmd_parser.c
>   drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       | 10 +++++-----
>  drivers/gpu/drm/i915/gem/i915_gem_object.c           |  8 +++-----
>  drivers/gpu/drm/i915/gem/i915_gem_phys.c             |  8 ++++----
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c            |  6 ++++--
>  drivers/gpu/drm/i915/gem/selftests/huge_pages.c      |  6 +++---
>  .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
>  .../gpu/drm/i915/gem/selftests/i915_gem_context.c    |  8 ++++----
>  drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c             |  5 +----
>  drivers/gpu/drm/i915/i915_cmd_parser.c               |  4 ++--
>  9 files changed, 30 insertions(+), 37 deletions(-)

Thanks for helping with kmap_atomic() conversions to kmap_local_page().

=46abio


