Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51A465239C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiLTPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLTPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:22:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF51A3B7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671549765; x=1703085765;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gLafIRStZG6lRFMZBHBv6Gl27kyIWKo/pz2JOmDTLk=;
  b=PNhbt/RG5VMnLfX+xaFMtZjPy8jzBwniLs2Jt2C7NY7wwHsIN2Q66Fok
   GYM9+QTLPF7p73SszHZfA9yI/A479xbRIA6ZSA4CgDGQKYaSXBMwTtl9e
   2ESwsHGdAhsQg4fwMeyhsylwfM9XB7LigEX0+hlebROy6np5cZoL8m9xa
   M8Bj5AghIGBEphOzomoqvaAnuEo6B8/vT3dNlcGS4kDOPxftnWwGWCQcH
   s8OudC/ukntrybYikRqEG8TIOBt7hOKk8pLSHN+IOHakDVS5Z6LAg2N2w
   Uc0ENffLbba1LW0hls8fktRMbDySxE2l7PNQaO0/xLVqcmrl0ChPIvIpG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="319688045"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="319688045"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 07:22:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="719601472"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="719601472"
Received: from kjayadev-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.27.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 07:22:37 -0800
Message-ID: <05424a5351a847786377a548dba0759917d8046c.camel@linux.intel.com>
Subject: Re: Possible regression in drm/i915 driver: memleak
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        tvrtko.ursulin@linux.intel.com
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx@lists.freedesktop.org
Date:   Tue, 20 Dec 2022 07:22:36 -0800
In-Reply-To: <f849cc70-b21f-6476-ba26-08989d1243c2@alu.unizg.hr>
References: <f849cc70-b21f-6476-ba26-08989d1243c2@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Added DRM mailing list and maintainers

On Tue, 2022-12-20 at 15:33 +0100, Mirsad Todorovac wrote:
> Hi all,
> 
> I have been unsuccessful to find any particular Intel i915 maintainer
> emails, so my best bet is to post here, as you will must assuredly 
> already know them.
> 
> The problem is a kernel memory leak that is repeatedly occurring 
> triggered during the execution of Chrome browser under the latest
> 6.1.0+ 
> kernel of this morning and Almalinux 8.6 on a Lenovo desktop box
> with Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz CPU.
> 
> The build is with KMEMLEAK, KASAN and MGLRU turned on during the
> build, 
> on a vanilla mainline kernel from Mr. Torvalds' tree.
> 
> The leaks look like this one:
> 
> unreferenced object 0xffff888131754880 (size 64):
>    comm "chrome", pid 13058, jiffies 4298568878 (age 3708.084s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> ................
>      00 00 00 00 00 00 00 00 00 80 1e 3e 83 88 ff ff 
> ...........>....
>    backtrace:
>      [<ffffffff9e9b5542>] slab_post_alloc_hook+0xb2/0x340
>      [<ffffffff9e9bbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>      [<ffffffff9e8f767a>] kmalloc_trace+0x2a/0xb0
>      [<ffffffffc08dfde5>] drm_vma_node_allow+0x45/0x150 [drm]
>      [<ffffffffc0b33315>] __assign_mmap_offset_handle+0x615/0x820
> [i915]
>      [<ffffffffc0b34057>] i915_gem_mmap_offset_ioctl+0x77/0x110
> [i915]
>      [<ffffffffc08bc5e1>] drm_ioctl_kernel+0x181/0x280 [drm]
>      [<ffffffffc08bc9cd>] drm_ioctl+0x2dd/0x6a0 [drm]
>      [<ffffffff9ea54744>] __x64_sys_ioctl+0xc4/0x100
>      [<ffffffff9fbc0178>] do_syscall_64+0x58/0x80
>      [<ffffffff9fc000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> The complete list of leaks in attachment, but they seem similar or
> the same.
> 
> Please find attached lshw and kernel build config file.
> 
> I will probably check the same parms on my laptop at home, which is
> also 
> Lenovo, but a different hw config and Ubuntu 22.10.
> 
> Thanks,
> Mirsad
> 
> -- 
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu

