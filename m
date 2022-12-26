Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A36564D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 20:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiLZTwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 14:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiLZTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 14:52:10 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC2111E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 11:52:09 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id c133so10935784oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 11:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWYSPSIrfkoYnJg6m/4VcDHxK65kqTI6ZG2tXU8qx+w=;
        b=UbcpRYnTJjxlME36wtgQ5f20bT5geXurrwccbIL394ZNHpdSCNl3EyqsPQ1JeaHlsK
         cHQWbPGtH6i1F/HuDqjc7CCjTgZU43olU5MP5zmuUsTThT/pemAQEnXjvqdh9EPtPNL0
         XuG4SiZZsc7dx8eZC8x5xTkpc66IUBqCU2Bo+qRTmPW/qmk8cy5N1GTD0b8/tplfI7l2
         mCLs7O6bHqJwVvGb3X71VE6PXhgRzw6I3Igf7ieo2Ht+0egjfLGUNv09bwvjTsBCIO5f
         lh8psYltFS2eq9/QVAR277OBsqSUnWft5a3WiqocnNKDWvHPjCyIGRpKeILBQWjIFYdZ
         kQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWYSPSIrfkoYnJg6m/4VcDHxK65kqTI6ZG2tXU8qx+w=;
        b=4dBP2m8l02oIOGn8vqyyY0Mi3ltY+A6lh70WKJkmPbi4t9ez8UvyLe6eV56TYKmJch
         g02YYjIUkGbaRx81XmfHMhkhIP+w4dq/kZOJstRqSssBj8U4wWVzfv7+TJ4qdBm1haaC
         4ny+gGZdAeHpw8keYioZkkkX1KA67RjuhYPdy4KRLUkacRb9hA12Q55qDud5/JcmiRoe
         xaqiurTQz6wv7+Gzj+fSa6P2t9zSsfEoB1SHIIoqi3of/l7+/frMgT4Cfz8aoumwLYF/
         LMj6Ur5WZ0pC1QZhKa/1EOBm+6nOWv6+Epct3TJkKYO9/xfXxNr5kEYhqNpG6jUFKfmM
         FXzw==
X-Gm-Message-State: AFqh2kq2LiJcb8h34HqgcDeB8y3skl2iGuXIIiNYmkvUG6x7o3dUFfZG
        XW5KhFPz7ivWxxcims6PtSg=
X-Google-Smtp-Source: AMrXdXuwjRIcU16EO93gGMXeyGGQE/Upxzw2RQdQeZyeNFIm9fuvLBuBoWArYSDUyneIcCoYbdCwxw==
X-Received: by 2002:a05:6808:2021:b0:35c:2a72:72c2 with SMTP id q33-20020a056808202100b0035c2a7272c2mr11054001oiw.0.1672084328880;
        Mon, 26 Dec 2022 11:52:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13-20020a9d5e8d000000b0066eab2ec808sm5680696otl.1.2022.12.26.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 11:52:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Dec 2022 11:52:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20221226195206.GA2626419@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 02:07:05PM -0800, Linus Torvalds wrote:
> So it's Christmas Day here, but it's also Sunday afternoon two weeks
> after the 6.2 merge window opened. So holidays or not, the kernel
> development show must go on.
> 
> Thanks to a lot of people sending their pull requests early, I got
> much of the merge window work done before the holidays started in
> earnest, and mostly before my pre-xmas travel. So despite flight
> delays, missed connections, and the resulting airport hotel
> excursions, the merge window mostly went smoothly, and there was no
> reason to delay rc1.
> 
> That said, realistically I expect most people to be on vacation for at
> least another week, so I wouldn't be surprised if we end up with a
> delayed final release due to the season. But it's too early to worry
> about that yet, we'll just have to see how it goes.
> 
> Also, 6.2 looks like it's a bigger release (certainly bigger than 6.1
> was). The summary below is, as usual, just my merge log: we've got
> about 13.5k commits from ~1800 people in total in this merge window,
> which is actually not that far off the total size of the whole 6.1
> release. But let's hope that despite the size, and despite the likely
> slow start of the post-merge-window calming down period, we'll have a
> smooth release.
> 

Test results:

Build results:
	total: 155 pass: 151 fail: 4
Failed builds:
	powerpc:allmodconfig
	sh:defconfig
	sh:shx3_defconfig
	xtensa:allmodconfig
Qemu test results:
	total: 500 pass: 498 fail: 2
Failed tests:
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:net,default:zynq-zc702:rootfs
	arm:xilinx-zynq-a9:multi_v7_defconfig:usb0:mem128:zynq-zed:rootfs

Details below.

Guenter

---
Build errors
============

Building powerpc:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/string.h:253,
                 from arch/powerpc/include/asm/paca.h:16,
                 from arch/powerpc/include/asm/current.h:13,
                 from include/linux/thread_info.h:23,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from fs/f2fs/inline.c:9:
fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
   59 | #define __underlying_memset     __builtin_memset
      |                                 ^
include/linux/fortify-string.h:337:9: note: in expansion of macro '__underlying_memset'
  337 |         __underlying_memset(p, c, __fortify_size);                      \
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/fortify-string.h:345:25: note: in expansion of macro '__fortify_memset_chk'
  345 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
      |                         ^~~~~~~~~~~~~~~~~~~~
fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
  430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
      |         ^~~~~~
cc1: all warnings being treated as errors

xtensa:allmodconfig

Building xtensa:allmodconfig ... failed
--------------
Error log:
kernel/kcsan/kcsan_test.c: In function '__report_matches':
kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes

Bisect for both points to commit e240e53ae0abb08 ("mm, slub: add
CONFIG_SLUB_TINY").  Reverting it on its own is not possible, but
reverting the following two patches fixes the problem.

149b6fa228ed mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
e240e53ae0ab mm, slub: add CONFIG_SLUB_TINY

Context: CONFIG_SLUB_TINY is enabled with allmodconfig builds.
This enables some previously disabled configurations and disables
some previously enabled configurations. Not sure if that is a good
thing or a bad thing, but it does result in the above errors.

---
sh:defconfig
sh:shx3_defconfig

Building sh:defconfig ... failed
--------------
Error log:
In file included from <command-line>:
In function 'follow_pmd_mask',
    inlined from 'follow_pud_mask' at mm/gup.c:735:9,
    inlined from 'follow_p4d_mask' at mm/gup.c:752:9,
    inlined from 'follow_page_mask' at mm/gup.c:809:9:
include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
  358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Bisect points to commit 0862ff059c9e ("sh/mm: Make pmd_t similar to pte_t").
This commit introduces

-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct {
+       struct {
+               unsigned long pmd_low;
+               unsigned long pmd_high;
+       };
+       unsigned long long pmd;
+} pmd_t;

That should probably be "typedef union", not "typedef struct".

=============

Runtime:

Boot tests of arm:xilinx-zynq-a9 fail after

[    5.849451] ci_hdrc ci_hdrc.0: failed to register ULPI interface
[    5.849577] ci_hdrc: probe of ci_hdrc.0 failed with error -110

Caused by commit 8a7b31d545d3 ("usb: ulpi: defer ulpi_register on
ulpi_read_id timeout"). Revert is pending.

---

Not exactly a regression, but worth mentioning:

CONFIG_MEMCPY_KUNIT_TEST now sometimes takes several minutes to
execute in qemu. On top of that, it may result in hung task timeouts
if the hung task timeout is set to low values (45 seconds and below).
Example, seen with s390:

...
[   18.494320]     ok 2 memcpy_test
[   52.969037]     ok 3 memcpy_large_test
...
[   52.974505]     ok 4 memmove_test
[   87.325400]     ok 5 memmove_large_test
[  143.562760] INFO: task swapper/0:1 blocked for more than 46 seconds.
...
[  143.564441] Call Trace:
[  143.564689]  [<0000000000f1ec80>] __schedule+0x370/0x720
[  143.565175]  [<0000000000f1f098>] schedule+0x68/0x110
[  143.565374]  [<0000000000f278d4>] schedule_timeout+0xc4/0x160
[  143.565603]  [<0000000000f1fde2>] __wait_for_common+0xda/0x250
[  143.565816]  [<0000000000903c90>] kunit_try_catch_run+0x98/0x178
[  143.566029]  [<0000000000f05c9c>] kunit_run_case_catch_errors+0x7c/0xb8
[  143.566956]  [<00000000009023c0>] kunit_run_tests+0x220/0x638
...

That is too much for my test bed. I dropped this test as result. This means
that extending the tests has, at least in the context of my testing, the
opposite effect.
