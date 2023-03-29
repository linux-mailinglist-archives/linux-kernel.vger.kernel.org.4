Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78976CEFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjC2QzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjC2QzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B9D1709
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9F561DA0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E6DC433D2;
        Wed, 29 Mar 2023 16:54:48 +0000 (UTC)
Date:   Wed, 29 Mar 2023 17:54:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [BUG] Usersapce MTE error with allocation tag 0 when low on
 memory
Message-ID: <ZCRtVW9Q0WOKEQVX@arm.com>
References: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Steven Price who added the MTE swap support.

On Wed, Mar 29, 2023 at 02:55:49AM +0000, Qun-wei Lin (林群崴) wrote:
> Hi,
> 
> We meet the mass MTE errors happened in Android T with kernel-6.1.
> 
> When the system is under memory pressure, the MTE often triggers some
> error reporting in userspace.
> 
> Like the tombstone below, there are many reports with the acllocation
> tags of 0:
> 
> Build fingerprint:
> 'alps/vext_k6897v1_64/k6897v1_64:13/TP1A.220624.014/mp2ofp23:userdebug/
> dev-keys'
> Revision: '0'
> ABI: 'arm64'
> Timestamp: 2023-03-14 06:39:40.344251744+0800
> Process uptime: 0s
> Cmdline: /vendor/bin/hw/camerahalserver
> pid: 988, tid: 1395, name: binder:988_3  >>>
> /vendor/bin/hw/camerahalserver <<<
> uid: 1047
> tagged_addr_ctrl: 000000000007fff3 (PR_TAGGED_ADDR_ENABLE,
> PR_MTE_TCF_SYNC, mask 0xfffe)
> signal 11 (SIGSEGV), code 9 (SEGV_MTESERR), fault addr
> 0x0d000075f1d8d7f0
>     x0  00000075018d3fb0  x1  00000000c0306201  x2  00000075018d3ae8  x
> 3  000000000000720c
>     x4  0000000000000000  x5  0000000000000000  x6  00000642000004fe  x
> 7  0000054600000630
>     x8  00000000fffffff2  x9  b34a1094e7e33c3f  x10
> 00000075018d3a80  x11 00000075018d3a50
>     x12 ffffff80ffffffd0  x13 0000061e0000072c  x14
> 0000000000000004  x15 0000000000000000
>     x16 00000077f2dfcd78  x17 00000077da3a8ff0  x18
> 00000075011bc000  x19 0d000075f1d8d898
>     x20 0d000075f1d8d7f0  x21 0d000075f1d8d910  x22
> 0000000000000000  x23 00000000fffffff7
>     x24 00000075018d4000  x25 0000000000000000  x26
> 00000075018d3ff8  x27 00000000000fc000
>     x28 00000000000fe000  x29 00000075018d3b20
>     lr  00000077f2d9f164  sp  00000075018d3ad0  pc  00000077f2d9f134  p
> st 0000000080001000
> 
> backtrace:
>       #00 pc 000000000005d134  /system/lib64/libbinder.so
> (android::IPCThreadState::talkWithDriver(bool)+244) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #01 pc 000000000005d448  /system/lib64/libbinder.so
> (android::IPCThreadState::getAndExecuteCommand()+24) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #02 pc 000000000005dd64  /system/lib64/libbinder.so
> (android::IPCThreadState::joinThreadPool(bool)+68) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #03 pc 000000000008dba8  /system/lib64/libbinder.so
> (android::PoolThread::threadLoop()+24) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #04 pc 0000000000013440  /system/lib64/libutils.so
> (android::Thread::_threadLoop(void*)+416) (BuildId:
> 10aac5d4a671e4110bc00c9b69d83d8a)
>       #05 pc
> 00000000000c14cc  /apex/com.android.runtime/lib64/bionic/libc.so
> (__pthread_start(void*)+204) (BuildId:
> 718ecc04753b519b0f6289a7a2fcf117)
>       #06 pc
> 0000000000054930  /apex/com.android.runtime/lib64/bionic/libc.so
> (__start_thread+64) (BuildId: 718ecc04753b519b0f6289a7a2fcf117)
> 
> Memory tags around the fault address (0xd000075f1d8d7f0), one tag per
> 16 bytes:
>       0x75f1d8cf00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d000: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d100: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d200: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d300: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d400: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d500: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d600: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>     =>0x75f1d8d700: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 [0]
>       0x75f1d8d800: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d900: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8da00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8db00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8dc00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8dd00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8de00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
> 
> Also happens in coredump.
> 
> This problem only occurs when ZRAM is enabled, so we think there are
> some issues regarding swap in/out.
> 
> Having compared the differences between Kernel-5.15 and Kernel-6.1,
> We found the order of swap_free() and set_pte_at() is changed in
> do_swap_page().
> 
> When fault in, do_swap_page() will call swap_free() first:
> do_swap_page() -> swap_free() -> __swap_entry_free() ->
> free_swap_slot() -> swapcache_free_entries() -> swap_entry_free() ->
> swap_range_free() -> arch_swap_invalidate_page() ->
> mte_invalidate_tags_area() ->  mte_invalidate_tags() -> xa_erase()
> 
> and then call set_pte_at():
> do_swap_page() -> set_pte_at() -> __set_pte_at() -> mte_sync_tags() ->
> mte_sync_page_tags() -> mte_restore_tags() -> xa_load()
> 
> This means that the swap slot is invalidated before pte mapping, and
> this will cause the mte tag in XArray to be released before tag
> restore.
> 
> After I moved swap_free() to the next line of set_pte_at(), the problem
> is disappeared.
> 
> We suspect that the following patches, which have changed the order, do
> not consider the mte tag restoring in page fault flow:
> https://lore.kernel.org/all/20220131162940.210846-5-david@redhat.com/
> 
> Any suggestion is appreciated.
> 
> Thank you.
