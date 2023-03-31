Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218A16D2410
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjCaPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjCaPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:32:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDD1DFA9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:32:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j24so22894739wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680276740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfS1A2UVrL/vzisEkb7b8TXzYiJS2jrBia0j1kZ6QPc=;
        b=iVACrs7aNGDMS+Iz72GAFBLZld4BV+nVYjKc0gWOkFx26+FRyAR4H7H1+PzgWPS7EE
         fYhVpsD4N+Y7cmyLAxwS1lBsdWE2C/d9M6BGgIvXM3J0V/1MN76fXxxVC+9YJBOySJ8g
         EABMuZEZ3bhnNCTiQv0k6yRXWhficZULBrJSEo9jwWCO3DZfwhOLEWPWe0EAPWcxezqb
         K/XXQ+XudT+12hA9yZhD8QQCRJdOdpG8vcdlp9o5aaCkjUTUyTUrUDeh2rMlxIlnwz2F
         tMaRQnm3BEc9t6dgKl/BcckPwkufjTDr7AmiQ8A1fjQfvyWpI5znA5OHRpKJUHKyzZSK
         W6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680276740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfS1A2UVrL/vzisEkb7b8TXzYiJS2jrBia0j1kZ6QPc=;
        b=HD37mnSmh1LWahDJGnLLgJAs1b8gGBqWpM3WlctnVfr0A01CrUliURvqv7o1r1wKb7
         bJgEJpHLSoQhR/6XzcARzFSPr4JF5VkAyC81Ea/RnQASG7zd63FtIlhXRYU6Bc7BhyP8
         mH++MJQveFoCXnnJf2UEvwI4L8VTbTiJDvYpAvSn3lkYbC7WVdobR+LkkUg800zXj282
         CP517UogdmugRrh5So2Z/rvE/o316VbA6xO30FSjH+6FLr5pdAxoeuBsspupqlT+ky1/
         AiXL4264+rUlKkyBbvJ4si5uFZjxaMIO/c/Xz9Cvr0XueWCvLfUnyQdcxfSpmqE9hFtf
         gX1A==
X-Gm-Message-State: AAQBX9dQfI4bG+0XbMQ+/NUmVbYJWfnIsXqkvoEcUhZW6dzyEU4SaC4G
        wtKyHEVu7feWg4cPdmC1sRo=
X-Google-Smtp-Source: AKy350YMiqhSspjSjgIhnwFge0LPZC1zNwzgtXMArLtNAygmlwXBTaXtMCws7lIwvtD2MsLnQeRbxQ==
X-Received: by 2002:adf:d4c8:0:b0:2d4:d4ef:265c with SMTP id w8-20020adfd4c8000000b002d4d4ef265cmr21698755wrk.45.1680276739789;
        Fri, 31 Mar 2023 08:32:19 -0700 (PDT)
Received: from suse.localnet (host-82-55-106-106.retail.telecomitalia.it. [82.55.106.106])
        by smtp.gmail.com with ESMTPSA id t16-20020adfdc10000000b002e5ff05765esm1890713wri.73.2023.03.31.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:32:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
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
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 9/9] drm/i915: Use kmap_local_page() in
 gem/i915_gem_execbuffer.c
Date:   Fri, 31 Mar 2023 17:32:17 +0200
Message-ID: <2177327.1BCLMh4Saa@suse>
In-Reply-To: <fdc8a470-1e6b-815d-e367-a9df1b0b14dd@linux.intel.com>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
 <64265ef8725fe_375f7e294a@iweiny-mobl.notmuch>
 <fdc8a470-1e6b-815d-e367-a9df1b0b14dd@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 31 marzo 2023 13:30:20 CEST Tvrtko Ursulin wrote:
> On 31/03/2023 05:18, Ira Weiny wrote:
> > Zhao Liu wrote:
> >> From: Zhao Liu <zhao1.liu@intel.com>
> >>=20
> >> The use of kmap_atomic() is being deprecated in favor of
> >> kmap_local_page()[1], and this patch converts the calls from
> >> kmap_atomic() to kmap_local_page().
> >>=20
> >> The main difference between atomic and local mappings is that local
> >> mappings doesn't disable page faults or preemption (the preemption is
> >> disabled for !PREEMPT_RT case, otherwise it only disables migration).
> >>=20
> >> With kmap_local_page(), we can avoid the often unwanted side effect of
> >> unnecessary page faults and preemption disables.
> >>=20
> >> In i915_gem_execbuffer.c, eb->reloc_cache.vaddr is mapped by
> >> kmap_atomic() in eb_relocate_entry(), and is unmapped by
> >> kunmap_atomic() in reloc_cache_reset().
> >=20
> > First off thanks for the series and sticking with this.  That said this
> > patch kind of threw me for a loop because tracing the map/unmap calls d=
id
> > not make sense to me.  See below.
> >=20
> >> And this mapping/unmapping occurs in two places: one is in
> >> eb_relocate_vma(), and another is in eb_relocate_vma_slow().
> >>=20
> >> The function eb_relocate_vma() or eb_relocate_vma_slow() doesn't
> >> need to disable pagefaults and preemption during the above mapping/
> >> unmapping.
> >>=20
> >> So it can simply use kmap_local_page() / kunmap_local() that can
> >> instead do the mapping / unmapping regardless of the context.
> >>=20
> >> Convert the calls of kmap_atomic() / kunmap_atomic() to
> >> kmap_local_page() / kunmap_local().
> >>=20
> >> [1]:
> >> https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> >>=20
> >> v2: No code change since v1. Added description of the motivation of
> >>=20
> >>      using kmap_local_page() and "Suggested-by" tag of Fabio.
> >>=20
> >> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> >> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> >> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >> ---
> >>=20
> >> Suggested by credits:
> >>    Ira: Referred to his task document, review comments.
> >>    Fabio: Referred to his boiler plate commit message and his descript=
ion
> >>   =20
> >>           about why kmap_local_page() should be preferred.
> >>=20
> >> ---
> >>=20
> >>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>=20

[snip]
=20
> However I am unsure if disabling pagefaulting is needed or not. Thomas,
> Matt, being the last to touch this area, perhaps you could have a look?
> Because I notice we have a fallback iomap path which still uses
> io_mapping_map_atomic_wc. So if kmap_atomic to kmap_local conversion is
> safe, does the iomap side also needs converting to
> io_mapping_map_local_wc? Or they have separate requirements?

AFAIK, the requirements for io_mapping_map_local_wc() are the same as for=20
kmap_local_page(): the kernel virtual address is _only_ valid in the caller=
=20
context, and map/unmap nesting must be done in stack-based ordering (LIFO).

I think a follow up patch could safely switch to io_mapping_map_local_wc() =
/=20
io_mapping_unmap_local_wc since the address is local to context.

However, not being an expert, reading your note now I suspect that I'm miss=
ing=20
something. Can I ask why you think that page-faults disabling might be=20
necessary?=20

Thanks,

=46abio

> Regards,
>=20
> Tvrtko



