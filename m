Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0936A3607
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB0Ayv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjB0Ayt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:54:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5FCB74D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 16:54:48 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i202so1967224ioa.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 16:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vfA8cCXK2hULckPJbRVreXLCcxArmL/xefqXVeDWtM=;
        b=jaLlde/UNUUfyYs2nHDL2E5+B+xRISCOE7MdSmEJPADNpHUvy89CdECwS+lY/U2Y9y
         +hrAsXE2XA1ts0VuJPopKxaNllBtUdmNAOyF2zoEv8xWY+ct7TPNDMVD6G0GveQA3WOE
         K913/Rr/mM0WjwDKrovI2NDkL787OL/oVe1wTfpBSdmflnSP6ycQvZd36BK+KcMhTiB6
         bF53H1Jz7imQJtmIy1Ll3yL5QKSz5rK+yeOgfEcra/4L9lBEGI1bJ7uYKMOR3BJiVaxZ
         SoL9XmzvrflLw/tqOBBiDM4WDl+PZF52E1rRQDhH4wgDEeDG9Jd+R1Y2aRItA4uf1ns8
         XoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vfA8cCXK2hULckPJbRVreXLCcxArmL/xefqXVeDWtM=;
        b=1kXGMGpjq+d4/x6yEGYV9oRujbLnSRS/AAguE3yA6mgKOYB3f2bC0lT+N8EkI/v/vo
         cNiWUVkNYjGt1Qtfubz9HoEeCpIu/G4IVvS8OEdMuerdxy/4RVqdl6LYNVqAMx9cqz0n
         nr8CNWBcGhGz1a6OswaJl4n9uHYJVgSZOWdiOAoyHKBvswvBwgBxgPsk5atTcBKX9H9r
         oRi3M2qwOxuIUHuiB+ZAHgOXv85ypIHteSYSy2GChJre1PxqnzPL6zmmCuqr2JSqGIBb
         mxs46pfED4L+CJ0zz4LBLUS++70B76nuInFKRim3y6yL4XdO2UD2TD01BJcJpEWKiKMf
         66IQ==
X-Gm-Message-State: AO0yUKUPe8fdv7ViEbRlkCCX7ygbb8IpBsJ2L2eFJQh0iFv7uMu4+Iab
        hokRMOvGrBuTzWKiQgGFjfo=
X-Google-Smtp-Source: AK7set+fGuTpSVD5zx+mrnnIeh0GdB2sdvBzSLkVZy6qiW3WWCTa+6jycaMwne78HKDh0KCgwqyOoQ==
X-Received: by 2002:a6b:fe03:0:b0:719:62d5:ed6c with SMTP id x3-20020a6bfe03000000b0071962d5ed6cmr15893137ioh.18.1677459287657;
        Sun, 26 Feb 2023 16:54:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5-20020a92ce85000000b00316e3a38becsm1614090ilo.18.2023.02.26.16.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 16:54:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 26 Feb 2023 16:54:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, hch@lst.de, tonyb@cybernetics.com,
        akpm@linux-foundation.org, kernel-team@meta.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 11/12] dmapool: link blocks across pages
Message-ID: <20230227005445.GA3425881@roeck-us.net>
References: <20230126215125.4069751-1-kbusch@meta.com>
 <20230126215125.4069751-12-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126215125.4069751-12-kbusch@meta.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 26, 2023 at 01:51:24PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The allocated dmapool pages are never freed for the lifetime of the
> pool. There is no need for the two level list+stack lookup for finding a
> free block since nothing is ever removed from the list. Just use a
> simple stack, reducing time complexity to constant.
> 
> The implementation inserts the stack linking elements and the dma handle
> of the block within itself when freed. This means the smallest possible
> dmapool block is increased to at most 16 bytes to accomodate these
> fields, but there are no exisiting users requesting a dma pool smaller
> than that anyway.
> 
> Removing the list has a significant change in performance. Using the
> kernel's micro-benchmarking self test:
> 
> Before:
> 
>   # modprobe dmapool_test
>   dmapool test: size:16   blocks:8192   time:57282
>   dmapool test: size:64   blocks:8192   time:172562
>   dmapool test: size:256  blocks:8192   time:789247
>   dmapool test: size:1024 blocks:2048   time:371823
>   dmapool test: size:4096 blocks:1024   time:362237
> 
> After:
> 
>   # modprobe dmapool_test
>   dmapool test: size:16   blocks:8192   time:24997
>   dmapool test: size:64   blocks:8192   time:26584
>   dmapool test: size:256  blocks:8192   time:33542
>   dmapool test: size:1024 blocks:2048   time:9022
>   dmapool test: size:4096 blocks:1024   time:6045
> 
> The module test allocates quite a few blocks that may not accurately
> represent how these pools are used in real life. For a more marco level
> benchmark, running fio high-depth + high-batched on nvme, this patch
> shows submission and completion latency reduced by ~100usec each, 1%
> IOPs improvement, and perf record's time spent in dma_pool_alloc/free
> were reduced by half.
> 

With this patch in linux-next, I see a boot failure when trying to boot
a powernv qemu emulation from the SCSI MEGASAS controller.

Qemu command line is

qemu-system-ppc64 -M powernv -cpu POWER9 -m 2G \
	-kernel arch/powerpc/boot/zImage.epapr \
	-snapshot \
	-device megasas,id=scsi,bus=pcie.0 -device scsi-hd,bus=scsi.0,drive=d0 \
	-drive file=rootfs-el.ext2,format=raw,if=none,id=d0 \
	-device i82557a,netdev=net0,bus=pcie.1 -netdev user,id=net0 \
	-nographic -vga none -monitor null -no-reboot \
	--append "root=/dev/sda console=tty console=hvc0"

Reverting this patch together with "dmapool: create/destroy cleanup"
fixes the problem.

Bisect log is attached for reference.

Guenter

---
# bad: [8232539f864ca60474e38eb42d451f5c26415856] Add linux-next specific files for 20230225
# good: [c9c3395d5e3dcc6daee66c6908354d47bf98cb0c] Linux 6.2
git bisect start 'HEAD' 'v6.2'
# good: [fe3130bc4df0b1303de4321af2bc4dcee5d7db2f] cifs: reuse cifs_match_ipaddr for comparison of dstaddr too
git bisect good fe3130bc4df0b1303de4321af2bc4dcee5d7db2f
# good: [8138ddac3c324feb92cc30f6d0d3a1bba51345a9] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect good 8138ddac3c324feb92cc30f6d0d3a1bba51345a9
# bad: [2a15ddbcd09ca3a7843a48832884e37e703eaf83] Merge branch 'master' of git://linuxtv.org/media_tree.git
git bisect bad 2a15ddbcd09ca3a7843a48832884e37e703eaf83
# bad: [a7d241d71cf464413307df69177ae2dec8481d37] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
git bisect bad a7d241d71cf464413307df69177ae2dec8481d37
# bad: [446eb7f1f4aec9232d4b10222123a4566a8b1a95] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
git bisect bad 446eb7f1f4aec9232d4b10222123a4566a8b1a95
# good: [14c61d2100377dde2f6338395325b4090279d6a7] soc: document merges
git bisect good 14c61d2100377dde2f6338395325b4090279d6a7
# bad: [cb26c07e8a8acaecb43228181e1eae68ece8db0e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
git bisect bad cb26c07e8a8acaecb43228181e1eae68ece8db0e
# bad: [d37d53a39d853fcc2121770fd3b61f274985d594] Merge branch 'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad d37d53a39d853fcc2121770fd3b61f274985d594
# bad: [708a06c601945c3415240ed0950e37fe27dd8e60] mm/userfaultfd: support WP on multiple VMAs
git bisect bad 708a06c601945c3415240ed0950e37fe27dd8e60
# good: [beb78ba6c0dbed73b38d5ed74bf47aa2c65fafa7] dmapool: move debug code to own functions
git bisect good beb78ba6c0dbed73b38d5ed74bf47aa2c65fafa7
# bad: [a2cb3f101b06f78258cf0c6813b3a17bd1ec846a] zsmalloc: remove insert_zspage() ->inuse optimization
git bisect bad a2cb3f101b06f78258cf0c6813b3a17bd1ec846a
# good: [e637ac603aec2b0a73e50fd8031481c6e55bf139] dmapool: don't memset on free twice
git bisect good e637ac603aec2b0a73e50fd8031481c6e55bf139
# bad: [8f5073712e32685dfeb4925f13a95c6eb9f10cd8] dmapool: create/destroy cleanup
git bisect bad 8f5073712e32685dfeb4925f13a95c6eb9f10cd8
# bad: [28b0a0c64bc658e176368f9270dc8085aa469c63] dmapool: link blocks across pages
git bisect bad 28b0a0c64bc658e176368f9270dc8085aa469c63
# first bad commit: [28b0a0c64bc658e176368f9270dc8085aa469c63] dmapool: link blocks across pages
