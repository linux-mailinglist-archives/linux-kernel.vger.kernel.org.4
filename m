Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7306F13A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbjD1IzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjD1Iyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:54:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F375BB9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:54:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so65697635e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1682672030; x=1685264030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pL4Xsln7CoA4UJTPrm8Ceoo9nwMvFKVDs7triguts9c=;
        b=iOgcvluJ5NlwY+G2e3qRzuy+4lPMNksSVQlm7/f+23M3xismiwP81z2CjEF983Rtzz
         hfAKd9oi1J+uyQpmFVfLIOEh9YTNZ5tvHlChRgsM9K/WaTIlJqz8bp6UWXacz0IpIhbn
         MekpkdSne5knaH4YfrOPUlQWNE3hHOG3i/jRykdfxxBJvW111nbs+cbjdVtSpjH4vR+x
         wrNyi2FQ8LRBY+F2hkQvMk5UGNZnHkcTuU8xIitWijrjoV3Vjr2tZFLEIb3jEbbgVgO1
         cqLKVJDm/+qbcilvevaTFEhIbxJSbqS/comyiqIQrMTlC8ja8cADbGUVrANh0K9SGGZN
         VJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682672030; x=1685264030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pL4Xsln7CoA4UJTPrm8Ceoo9nwMvFKVDs7triguts9c=;
        b=LCHnSaU2mSfdLraQQ6jyRR2xBf9YrFNtOEAsU1VWFzKY/jsCmVd5fOarDL5EhID2B+
         HPlExfiYdL1peiZe7dmLH0tVXz9vytPeuwlJsp4PZV+Hl8Dc1/fwAoY7zBwDNKZCfBAp
         5GvQAviMK2SK67Jb7rQiTHSTdtCokFUtHtKPeNZov0gdbgwqlD20zRHt4ijwZCs25pIG
         s0B6XrtMr0JJbDLxBidwJPHhS3drCBxcp1Sx76o3WcDFIeAxr4ipx72PDN9yr9W3qN4N
         W4hu/AU6YNadsP/5V6BGyjLf9kXwgM7u/1qj+pPllVJTiW+62f1Quo7WuXTZHTZlM8I/
         dHjw==
X-Gm-Message-State: AC+VfDyJnVKvIpybZRxcMOnmhWfoIfru//0WCKHCujZUwDcTZr01BZE5
        GC364FEXOZ8IR4jgDkZZGTXmxWJolDhzyBmIKH8Lyw==
X-Google-Smtp-Source: ACHHUZ4L+JHzNv6HlWmdBjRonkyWikGIyXD0OGcZhY2soKtk3FiHrs3ub07ijNaUbKOzSh/rnPq0ARlpLFg9zkYYhek=
X-Received: by 2002:a7b:c5c6:0:b0:3f0:8fb3:24ea with SMTP id
 n6-20020a7bc5c6000000b003f08fb324eamr3436522wmk.9.1682672029706; Fri, 28 Apr
 2023 01:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Fri, 28 Apr 2023 09:53:38 +0100
Message-ID: <CAHbf0-HwQhFsYW8cp0t9660877b9tTxZBego7VSfx0ayAwKePQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Muchun Song <muchun.song@linux.dev>,
        Ondrej Zary <linux@zary.sk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        petr@tesarici.cz, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 at 11:05, Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>
> The goal of my work is to provide more flexibility in the sizing of
> SWIOTLB.
>
> The software IO TLB was designed with these assumptions:
>
> 1. It would not be used much, especially on 64-bit systems.
> 2. A small fixed memory area (64 MiB by default) is sufficient to
>    handle the few cases which require a bounce buffer.
> 3. 64 MiB is little enough that it has no impact on the rest of the
>    system.
>
> First, if SEV is active, all DMA must be done through shared
> unencrypted pages, and SWIOTLB is used to make this happen without
> changing device drivers. The software IO TLB size is increased to
> 6% of total memory in sev_setup_arch(), but that is more of an
> approximation. The actual requirements may vary depending on the
> amount of I/O and which drivers are used. These factors may not be
> know at boot time, i.e. when SWIOTLB is allocated.
>
> Second, other colleagues have noticed that they can reliably get
> rid of occasional OOM kills on an Arm embedded device by reducing
> the SWIOTLB size. This can be achieved with a kernel parameter, but
> determining the right value puts additional burden on pre-release
> testing, which could be avoided if SWIOTLB is allocated small and
> grows only when necessary.
>
> Changes from v1-devel-v7:
> - Add comments to acquire/release barriers
> - Fix whitespace issues reported by checkpatch.pl
>
> Changes from v1-devel-v6:
> - Provide long description of functions
> - Fix kernel-doc (Returns: to Return:)
> - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
>
> Changes from RFC:
> - Track dynamic buffers per device instead of per swiotlb
> - Use a linked list instead of a maple tree
> - Move initialization of swiotlb fields of struct device to a
>   helper function
> - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> - Introduce per-device flag if dynamic buffers are in use
> - Add one more user of DMA_ATTR_MAY_SLEEP
> - Add kernel-doc comments for new (and some old) code
> - Properly escape '*' in dma-attributes.rst
>
> Petr Tesarik (7):
>   swiotlb: Use a helper to initialize swiotlb fields in struct device
>   swiotlb: Move code around in preparation for dynamic bounce buffers
>   dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
>   swiotlb: Dynamically allocated bounce buffers
>   swiotlb: Add a boot option to enable dynamic bounce buffers
>   drm: Use DMA_ATTR_MAY_SLEEP from process context
>   swiotlb: per-device flag if there are dynamically allocated buffers
>
>  .../admin-guide/kernel-parameters.txt         |   6 +-
>  Documentation/core-api/dma-attributes.rst     |  10 +
>  drivers/base/core.c                           |   4 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +-
>  drivers/gpu/drm/drm_prime.c                   |   2 +-
>  include/linux/device.h                        |  12 +
>  include/linux/dma-mapping.h                   |   6 +
>  include/linux/swiotlb.h                       |  54 ++-
>  kernel/dma/swiotlb.c                          | 382 ++++++++++++++++--
>  9 files changed, 443 insertions(+), 35 deletions(-)
>
> --
> 2.25.1
>

Hi

Is this a potential fix for
https://bugzilla.kernel.org/show_bug.cgi?id=217310 where I'm manually
setting bigger buffers to keep my wifi working?

Thanks

Mike
