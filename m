Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71A60CA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiJYKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:34:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80432045
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w7jyh7t+HSd8ls+5K8wYXg67ORftlivpSuWpTIAA1Ec=; b=pwDgHKGNYy+q7+1Zq4ibtxTn9f
        4mH06Pa213DTyXq8WBhCs81sD2PBLHuokf5excD05nlRoKPtWjttOFmCAaMhiaXHbmSDTtc/ZoMh2
        cXNJVIBtMFOZcxD7pzX0Iw87EWqdbxowVdSGxtUdkZfR3tfpRGlAC35X7mmUDzUgX3PrRBt8cZ+Yh
        BcNA4f04gCGPS4pPR6UR3MckTlYIwiUcCZXozXJzdCZyedGCKRw6V9OxIgeqC10xj6RatgblM8Iuy
        I1drWuXnnZOOoIoYiJ8vQIaND5k3Y+Zg/h/4biEtQsK8CqzwKK8fSDQ3cOT8VRi/7H+2so3BG/Fww
        658t26TQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onHFr-006I9L-Aw; Tue, 25 Oct 2022 10:33:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF151300169;
        Tue, 25 Oct 2022 12:33:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A028B2C431FAA; Tue, 25 Oct 2022 12:33:54 +0200 (CEST)
Date:   Tue, 25 Oct 2022 12:33:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [tip:x86/mm] [x86/mm] 1248fb6a82:
 Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page
Message-ID: <Y1e7kgKweck6S954@hirez.programming.kicks-ass.net>
References: <202210241508.2e203c3d-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210241508.2e203c3d-yujie.liu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:54:40PM +0800, kernel test robot wrote:
> Hi Peter,
> 
> We noticed that below commit changed the value of
> CPU_ENTRY_AREA_MAP_SIZE. Seems KASAN uses this value to allocate memory,
> and failed during initialization after this change, so we send this
> mail and Cc KASAN folks. Please kindly check below report for more
> details. Thanks.
> 
> 
> Greeting,
> 
> FYI, we noticed Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page due to commit (built with gcc-11):
> 
> commit: 1248fb6a8201ddac1c86a202f05a0a1765efbfce ("x86/mm: Randomize per-cpu entry area")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [    7.114808][    T0] Kernel panic - not syncing: kasan_populate_pmd+0x142/0x1d2: Failed to allocate page, nid=0 from=1000000
> [    7.119742][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00001-g1248fb6a8201 #1
> [    7.122122][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    7.124976][    T0] Call Trace:
> [    7.125849][    T0]  <TASK>
> [    7.126642][    T0]  ? dump_stack_lvl+0x45/0x5d
> [    7.127908][    T0]  ? panic+0x21e/0x46a
> [    7.129009][    T0]  ? panic_print_sys_info+0x77/0x77
> [    7.130618][    T0]  ? memblock_alloc_try_nid_raw+0x106/0x106
> [    7.132224][    T0]  ? memblock_alloc_try_nid+0xd9/0x118
> [    7.133717][    T0]  ? memblock_alloc_try_nid_raw+0x106/0x106
> [    7.135252][    T0]  ? kasan_populate_pmd+0x142/0x1d2
> [    7.136655][    T0]  ? early_alloc+0x95/0x9d
> [    7.137738][    T0]  ? kasan_populate_pmd+0x142/0x1d2
> [    7.138936][    T0]  ? kasan_populate_pud+0x182/0x19f
> [    7.140335][    T0]  ? kasan_populate_shadow+0x1e0/0x233
> [    7.141759][    T0]  ? kasan_init+0x3be/0x57f
> [    7.142942][    T0]  ? setup_arch+0x101d/0x11f0
> [    7.144229][    T0]  ? start_kernel+0x6f/0x3d0
> [    7.145449][    T0]  ? secondary_startup_64_no_verify+0xe0/0xeb
> [    7.147051][    T0]  </TASK>
> [    7.147868][    T0] ---[ end Kernel panic - not syncing: kasan_populate_pmd+0x142/0x1d2: Failed to allocate page, nid=0 from=1000000 ]---

Ufff, no idea about what KASAN wants here; Andrey, you have clue?

Are you trying to allocate backing space for .5T of vspace and failing
that because the kvm thing doesn't have enough memory?

