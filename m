Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFDF65EE22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjAEOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjAEOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:01:22 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3E5D419
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:59:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ge16so36289569pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1c1qx6KG4npfG7YbIwvASK4METKt6nVBigcejFFGhM=;
        b=WbrWJ+TK0ix1C08/Qrl//vAE+PnVWxYZyICx6p+9D0KuY5G5lBIbe57haulKFukmh8
         qxNEVM1ZjAHiqkSIX27otDR7olcijdkxBRPydJwnk+BNdZfe5teShb+olsInJPL8JblW
         rUzGUcduTT6zbhNxR/yLPw1z1cBtMnLnRZCfdi780gwjUdsHIYaQbmwMvCZM2633lu2d
         597P9BxloIONadTz1qhbMPSn+IOq32OHIV+rtYr/kBsNloEgio52jHs56IqDBIDH+S3P
         zcTknLpTXH6p/zvZijZvBCQPQFtBxgTVVt+DUWO+RKvFgwHew9/A/t/hBNBcSpBerDZv
         mHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1c1qx6KG4npfG7YbIwvASK4METKt6nVBigcejFFGhM=;
        b=T49HUQpHlyG04+uTxFbOy4sNK/MQJemIl+UHF5NabURjIkiivtchrAWzwqYzcqby+z
         C8swHvXwucRpHxMBZl3ITd4PPc+QRBQ4zPCRHBXy/Md5mNaRXXlYb7wDhUZKCKqAylAQ
         Npv3vyt9yHZit0KwItkie7mv5hQawD8iBIIGCZEkcy4FW5UmmTwVzBYfM69X/01zdyVG
         Y+sb1UTzXv/OHaGw5s52z7fL21lmdu5ci9okQKl2z5uL8N0+nSK/iuGbylHMbLdHHaRT
         NX2y+xjL1d4IpZWObYgmjOOMpsHdCIijn60L5on5+YF2ZUXO6a5FjL1bQ2qYY7R8Bv8x
         +WeA==
X-Gm-Message-State: AFqh2kpnDpDlGAk8iPoumXUNTAMiXByLjiU51Vp8kxa1vDY2rvv/eb8R
        a6B0lW2JcujMxc7PbWiN/XI=
X-Google-Smtp-Source: AMrXdXuSp3hBC2Wiil/yjk6pChFSKo2R+Yf4oCvxKJRr0tI8sHQyUjK/8R48xhVTECh4ZPCmicwtSQ==
X-Received: by 2002:a05:6a20:b044:b0:a2:405b:6769 with SMTP id dx4-20020a056a20b04400b000a2405b6769mr51292731pzb.2.1672927179997;
        Thu, 05 Jan 2023 05:59:39 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h4-20020a654804000000b004785c24ffb4sm22085584pgs.26.2023.01.05.05.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:59:39 -0800 (PST)
Date:   Thu, 5 Jan 2023 22:59:33 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7bXxXgTd6e6XatS@hyeyoo>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev, lkp@intel.com,
	Mike Rapoport <rppt@linux.ibm.com>,
	Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Bcc: 
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Reply-To: 
In-Reply-To: <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>

On Thu, Jan 05, 2023 at 09:46:06AM +0800, Oliver Sang wrote:
> hi, Hyeonggon, hi, Vlastimil,
> 
> On Wed, Jan 04, 2023 at 06:04:20PM +0900, Hyeonggon Yoo wrote:
> > On Tue, Jan 03, 2023 at 09:46:33PM +0800, Oliver Sang wrote:
> > > On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> > > > So the events leading up to this could be something like:
> > > > 
> > > > - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
> > > > - despite being on partial list, it's freed ???
> > > > - somebody else allocates order-2 page 0x2daec and uses it for whatever,
> > > > then frees it
> > > > - 0x2daec is reallocated as order-1 slab from names_cache, then freed
> > > > - we try to allocate from the slab page 0x2daee and trip on the PageTail
> > > > 
> > > > Except, the freeing of order-2 page would have reset the PageTail and
> > > > compound_head in 0x2daec, so this is even more complicated or involves some
> > > > extra race?
> > > 
> > > FYI, we ran tests more up to 500 times, then saw different issues but rate is
> > > actually low
> > > 
> > > 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> > > ---------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs
> > >            |             |             |
> > >            :500         12%          61:500   dmesg.invalid_opcode:#[##]
> > >            :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
> > >            :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
> > >            :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
> > >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
> > >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c
> > > 
> 
> hi Vlastimil,
> 
> as you mentioned
> > Hm even if rate is low, the different kinds of reports could be useful to
> > see, if all of that is caused by the commit.
> 
> we tried to run tests even more times, but with the config which enable
>     CONFIG_DEBUG_PAGEALLOC
>     CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> (config is attached as
>     config-6.1.0-rc2-00014-g0af8489b0216+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> the only diff with previous config is
> @@ -5601,7 +5601,8 @@ CONFIG_HAVE_KCSAN_COMPILER=y
>  # Memory Debugging
>  #
>  CONFIG_PAGE_EXTENSION=y
> -# CONFIG_DEBUG_PAGEALLOC is not set
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
>  CONFIG_PAGE_OWNER=y
>  # CONFIG_PAGE_POISONING is not set
>  CONFIG_DEBUG_PAGE_REF=y
> )
> 
> what we found now is some issues are also reproduced on parent now (still by
> rcutorture tests here), though seems lower rate on parent.
> 
> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
> 
> 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           8:985         19%         199:990   dmesg.invalid_opcode:#[##]
>            :985          5%          51:990   dmesg.kernel_BUG_at_include/linux/mm.h
>           3:985          4%          41:990   dmesg.kernel_BUG_at_include/linux/page-flags.h
>           4:985         10%         102:990   dmesg.kernel_BUG_at_lib/list_debug.c
>            :985          0%           2:990   dmesg.kernel_BUG_at_mm/page_alloc.c
>           1:985          0%           3:990   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> however, we noticed dmesg.kernel_BUG_at_include/linux/mm.h still have
> relatively high rate on this commit but keeps clean on parent.
> 
> so I attached dmesg-rcutorture-bug-at-mm-h.xz
> since it has
> [   33.586931][  T183] ------------[ cut here ]------------
> [   33.590089][  T183] kernel BUG at include/linux/mm.h:825!
> [   33.591219][  T183] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
> not sure if this is helpful.
> 
> > > > 
> > > > In any case, this is something a debug_pagealloc kernel could have a chance
> > > > of catching earlier. Would it be possible to enable CONFIG_DEBUG_PAGEALLOC
> > > > and DEBUG_PAGEALLOC_ENABLE_DEFAULT additionally to the rest of the
> > > > configuration, and repeat the test?
> > > 
> > > ok, we are starting to test by these 2 additional configs now.
> > 
> > BTW it seems to be totally unrelated to rcutorture tests.
> > Are there similar reports in boot tests with the same config?
> 
> hi Hyeonggon,
> 
> per your suggestion (Thanks a lot!) we used same config as above which
> enabled CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> to do boot tests. the results have some differences:
> 
> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
> 
> 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>          11:999         20%         208:999   dmesg.invalid_opcode:#[##]
>           2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>           4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>           4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
>            :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>           1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> here the dmesg.kernel_BUG_at_include/linux/mm.h is also reproduced on parent,
> only issue shows on this commit but not on parent is (but rate is very low)
>     dmesg.kernel_BUG_at_mm/page_alloc.c
>
> 
> I also attached dmesg-boot-bug-at-page_alloc-c.xz
> which has
> [   17.251777][    C0] ------------[ cut here ]------------
> [   17.252218][    C0] kernel BUG at mm/page_alloc.c:1406!
> [   17.252647][    C0] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
> 
> If you need more information, please let us know. Thanks

[dmesg-rcutorture-but-at-mm-h.xz]

[   33.533541][  T183] page:(ptrval) refcount:1 mapcount:0 mapping:00000000 index:0x0 pfn:0x8df2
[   33.535615][  T183] page:(ptrval) refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x8df0
[   33.537599][  T183] flags: 0x0(zone=0)
[   33.538516][  T183] raw: 00010200 c0100b70 c0100b70 c019b680 c8df1000 00020001 ffffffff 00000001
[   33.540538][  T183] raw: 00000000 00000000
[   33.541514][  T183] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
[   33.547407][  T183] page_owner tracks the page as freed
[   33.548569][  T183] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 180, tgid 180 (systemd-journal), ts 33548330257, free_ts 33548381837
[   33.551910][  T183]  post_alloc_hook+0x29a/0x320
[   33.552602][  T183]  get_page_from_freelist+0x226/0x310
[   33.553469][  T183]  __alloc_pages+0xdd/0x360
[   33.554387][  T183]  alloc_slab_page+0x12d/0x200
[   33.555375][  T183]  allocate_slab+0x6a/0x350
[   33.556334][  T183]  new_slab+0x48/0xc0
[   33.557199][  T183]  __slab_alloc_node+0xfb/0x270
[   33.558510][  T183]  kmem_cache_alloc+0x8f/0x4e0
[   33.559599][  T183]  getname_flags+0x33/0x2f0
[   33.560750][  T183]  user_path_at_empty+0x2d/0x90
[   33.561910][  T183]  do_faccessat+0xb5/0x410
[   33.562993][  T183]  __ia32_sys_access+0x2a/0x40
[   33.564112][  T183]  __do_fast_syscall_32+0x72/0xd0
[   33.565340][  T183]  do_fast_syscall_32+0x32/0x70
[   33.566379][  T183]  do_SYSENTER_32+0x15/0x20
[   33.567307][  T183]  entry_SYSENTER_32+0xa2/0xfb
[   33.568331][  T183] page last free stack trace:
[   33.569321][  T183]  free_pcp_prepare+0x39f/0x970
[   33.570383][  T183]  free_unref_page_prepare+0x29/0x210
[   33.571559][  T183]  free_unref_page+0x3a/0x3b0
[   33.572586][  T183]  __free_pages+0x187/0x1f0
[   33.573628][  T183]  __free_slab+0x1fd/0x350
[   33.574890][  T183]  free_slab+0x22/0x70
[   33.575888][  T183]  free_to_partial_list+0x125/0x260
[   33.577142][  T183]  do_slab_free+0x30/0x70
[   33.578176][  T183]  kmem_cache_free+0x171/0x1e0
[   33.579266][  T183]  putname+0x9f/0xf0
[   33.580198][  T183]  do_sys_openat2+0xe2/0x1f0
[   33.581327][  T183]  do_sys_open+0x8e/0xe0
[   33.582408][  T183]  __ia32_sys_openat+0x2b/0x40
[   33.583508][  T183]  __do_fast_syscall_32+0x72/0xd0
[   33.584743][  T183]  do_fast_syscall_32+0x32/0x70
[   33.585888][  T183]  do_SYSENTER_32+0x15/0x20
[   33.586931][  T183] ------------[ cut here ]------------
[   33.590089][  T183] kernel BUG at include/linux/mm.h:825!
[   33.591219][  T183] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[   33.592301][  T183] CPU: 0 PID: 183 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #1 7084bf045416bf9c79a76bd063d103f14dfaa815
[   33.594693][  T183] EIP: __dump_page.cold+0x282/0x369
[   33.595580][  T183] Code: ff ff 83 05 c8 9e bf c5 01 ba 94 31 30 c4 89 f8 83 15 cc 9e bf c5 00 e8 12 89 ed fd 83 05 d8 9e bf c5 01 83 15 dc 9e bf c5 00 <0f> 0b 83 05 e0 9e bf c5 01 b8 ac c5 a7 c4 83 15 e4 9e bf c5 00 e8
[   33.598957][  T183] EAX: 00000000 EBX: e6bf1dd0 ECX: 00000000 EDX: ffffffff
[   33.600184][  T183] ESI: e6bf1d80 EDI: e6bf1d80 EBP: c8bbdd84 ESP: c8bbdd48
[   33.601409][  T183] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
[   33.602791][  T183] CR0: 80050033 CR2: 0063209c CR3: 08bdd000 CR4: 000406d0
[   33.604116][  T183] Call Trace:
[   33.604821][  T183]  dump_page+0x2a/0xc0
[   33.605616][  T183]  folio_flags+0x23/0x70


This time for newly allocated slab page, PageTail(page) returns true.

[   33.610604][  T183]  alloc_slab_page+0x7f/0x200
[   33.611402][  T183]  allocate_slab+0x6a/0x350
[   33.612162][  T183]  new_slab+0x48/0xc0
[   33.612850][  T183]  __slab_alloc_node+0xfb/0x270
[   33.613878][  T183]  kmem_cache_alloc+0x8f/0x4e0
[   33.614799][  T183]  ? __lock_acquire+0x427/0xad0
[   33.615757][  T183]  getname_flags+0x33/0x2f0
[   33.616631][  T183]  getname+0x1a/0x30
[   33.617385][  T183]  do_sys_openat2+0xa5/0x1f0
[   33.618230][  T183]  do_sys_open+0x8e/0xe0
[   33.618978][  T183]  __ia32_sys_openat+0x2b/0x40
[   33.619753][  T183]  __do_fast_syscall_32+0x72/0xd0
[   33.620669][  T183]  ? lockdep_hardirqs_on_prepare+0x242/0x400
[   33.621632][  T183]  ? syscall_exit_to_user_mode+0x5f/0x90
[   33.622540][  T183]  ? __do_fast_syscall_32+0x7c/0xd0
[   33.623395][  T183]  ? lockdep_hardirqs_on_prepare+0x242/0x400
[   33.624281][  T183]  ? syscall_exit_to_user_mode+0x5f/0x90
[   33.625202][  T183]  ? __do_fast_syscall_32+0x7c/0xd0
[   33.626069][  T183]  ? syscall_exit_to_user_mode+0x5f/0x90
[   33.627016][  T183]  ? __do_fast_syscall_32+0x7c/0xd0
[   33.627996][  T183]  ? __do_fast_syscall_32+0x7c/0xd0
[   33.628916][  T183]  ? irqentry_exit_to_user_mode+0x23/0x30
[   33.629958][  T183]  ? irqentry_exit+0x7f/0xc0
[   33.630728][  T183]  do_fast_syscall_32+0x32/0x70
[   33.631583][  T183]  do_SYSENTER_32+0x15/0x20
[   33.632361][  T183]  entry_SYSENTER_32+0xa2/0xfb
[   33.633179][  T183] EIP: 0xb7f10549
[   33.633783][  T183] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   33.636795][  T183] EAX: ffffffda EBX: 00000005 ECX: 00631b01 EDX: 002a8000
[   33.642042][  T183] ESI: 00000000 EDI: 00000001 EBP: 00631adc ESP: bfdff390
[   33.643329][  T183] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
[   33.644726][  T183] Modules linked in:
[   33.646532][  T183] ---[ end trace 0000000000000000 ]---
[   33.647477][  T183] EIP: __dump_page.cold+0x282/0x369
[   33.648422][  T183] Code: ff ff 83 05 c8 9e bf c5 01 ba 94 31 30 c4 89 f8 83 15 cc 9e bf c5 00 e8 12 89 ed fd 83 05 d8 9e bf c5 01 83 15 dc 9e bf c5 00 <0f> 0b 83 05 e0 9e bf c5 01 b8 ac c5 a7 c4 83 15 e4 9e bf c5 00 e8
[   33.651543][  T183] EAX: 00000000 EBX: e6bf1dd0 ECX: 00000000 EDX: ffffffff
[   33.652761][  T183] ESI: e6bf1d80 EDI: e6bf1d80 EBP: c8bbdd84 ESP: c8bbdd48
[   33.653995][  T183] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
[   33.655452][  T183] CR0: 80050033 CR2: 0063209c CR3: 08bdd000 CR4: 000406d0
[   33.656826][  T183] Kernel panic - not syncing: Fatal exception
[   33.658167][  T183] Kernel Offset: disabled



[dmesg-boot-bug-at-page_alloc-c.xz]

[   17.236089][    C0] page:(ptrval) refcount:1 mapcount:0 mapping:00000000 index:0x0 pfn:0x8c96
[   17.236862][    C0] head:(ptrval) order:1 compound_mapcount:0 compound_pincount:0

In this case the page (pfn 0x8c96) is head page of order-1 page
because it's pfn is even number, and the page is used for kernel stack.

According to the configuration, the page (whose pfn is 0x8c96)
is allocated for kernel stack from the buddy allocator and is
just about to be freed after RCU grace period.

[   17.237503][    C0] memcg:c8a98c81
[   17.237789][    C0] flags: 0x10200(slab|head|zone=0)
[   17.238217][    C0] raw: 00000000 e6bef721 00000122 00000400 00000000 00000000 ffffffff 00000000
[   17.238932][    C0] raw: c8b1c1e2 00000000
[   17.239260][    C0] head: 00010200 00000100 00000122 c019b780 00000000 000a000a ffffffff 00000001
[   17.239959][    C0] head: c8a98c81 00000000

The page's (again pfn 0x8c96) page->flags and page->_refcount are zero
like freed page when it's not freed yet. These two fields must be
overwritten after its allocation, but who overwrote these fields is
still a question.

also the value of page->compound_head (0xe6bef721) does not make sense at all.
This value cannot be set by buddy, because head page of order-1
page cannot be tail page of another order-1 page.

If this value is set by slab allocator's list operation, the last bit
must not be set because struct page is at least word-aligned.

[   17.240300][    C0] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
[   17.244977][    C0] page_owner tracks the page as allocated
[   17.245471][    C0] page last allocated via order 1, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 1, tgid 1 (systemd), ts 17077181323, free_ts 0
[   17.246702][    C0]  post_alloc_hook+0x29a/0x320
[   17.247126][    C0]  get_page_from_freelist+0x226/0x310
[   17.247550][    C0]  __alloc_pages+0xdd/0x360
[   17.247907][    C0]  alloc_thread_stack_node+0x48/0xf0
[   17.248342][    C0]  dup_task_struct+0x73/0x330
[   17.248722][    C0]  copy_process+0x2d6/0x2f90
[   17.249088][    C0]  kernel_clone+0x95/0x4f0
[   17.249426][    C0]  __ia32_sys_clone+0x8a/0xc0
[   17.249785][    C0]  __do_fast_syscall_32+0x72/0xd0
[   17.250209][    C0]  do_fast_syscall_32+0x32/0x70
[   17.250589][    C0]  do_SYSENTER_32+0x15/0x20
[   17.250964][    C0]  entry_SYSENTER_32+0xa2/0xfb
[   17.251339][    C0] page_owner free stack trace missing
[   17.251777][    C0] ------------[ cut here ]------------
[   17.252218][    C0] kernel BUG at mm/page_alloc.c:1406!
[   17.252647][    C0] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[   17.253148][    C0] CPU: 0 PID: 185 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #1 7084bf045416bf9c79a76bd063d103f14dfaa815
[   17.254174][    C0] EIP: free_pcp_prepare+0x70/0x970
[   17.254561][    C0] Code: 74 48 83 05 b0 8e c1 c5 01 ba 50 5e 2f c4 89 d8 83 15 b4 8e c1 c5 00 e8 2e 65 fa ff 83 05 c0 8e c1 c5 01 83 15 c4 8e c1 c5 00 <0f> 0b 83 05 c8 8e c1 c5 01 b8 d8 7a a8 c4 83 15 cc 8e c1 c5 00 e8
[   17.256029][    C0] EAX: 00000000 EBX: e6bef770 ECX: 00000002 EDX: c36c5dbd
[   17.256571][    C0] ESI: 00000001 EDI: c019ff68 EBP: c019fed0 ESP: c019fea8
[   17.257122][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
[   17.257705][    C0] CR0: 80050033 CR2: 0062f8bc CR3: 08ba7000 CR4: 000406d0
[   17.258241][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   17.258768][    C0] DR6: fffe0ff0 DR7: 00000400
[   17.259115][    C0] Call Trace:
[   17.259367][    C0]  <SOFTIRQ>
[   17.259615][    C0]  free_unref_page_prepare+0x29/0x210
[   17.260019][    C0]  free_unref_page+0x3a/0x3b0
[   17.260381][    C0]  __free_pages+0x187/0x1f0
[   17.260746][    C0]  thread_stack_free_rcu+0x2e/0x40
[   17.261149][    C0]  rcu_do_batch+0x267/0xab0
[   17.261509][    C0]  ? rcu_do_batch+0x1f3/0xab0
[   17.261877][    C0]  rcu_core+0x21b/0x450
[   17.262204][    C0]  rcu_core_si+0x16/0x30
[   17.262535][    C0]  __do_softirq+0x178/0x53b
[   17.262892][    C0]  ? __softirqentry_text_start+0x8/0x8
[   17.263322][    C0]  do_softirq_own_stack+0x32/0x50
[   17.263711][    C0]  </SOFTIRQ>
