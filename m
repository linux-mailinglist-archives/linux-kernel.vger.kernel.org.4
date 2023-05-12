Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133BB700941
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjELNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjELNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:32:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C1527A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:32:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f42c865535so44007295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683898351; x=1686490351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SGcgNeMjoxieUtPpFqEKzKmtbMzY7/Fef/+6eMQ9tM=;
        b=bLixAcvv6QoCZM3gpOCEk0VyDJSSTWIIpWmXnQEHr8UXQXxxJZx7pcKxWDAX4YP1WK
         ioePr1Pa8xTM2beSi/JHn6QUt/1pCzU6NA/P+gxRajD8mxOLmlLXpgWpXpsJczf9/QVk
         vN5vndSP2Y0S1T8m7H76L6XOxFCdc8dvDlgzqFYOOTIRBh9/pMhxiMv70X/GzBGFm94v
         NxQZBD2TsP7IPBp6QkN3gtSSX28H91QG17i5oQZFpfQY7pVzFFgJzMdLx9UsM66dS06e
         ZNcbf9sxUyuQSVeBAaaSVgP6w24GnB7ZM0m4p3ARByNlQC+va9RW+0u0o33s0qPyrYCv
         fyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683898351; x=1686490351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SGcgNeMjoxieUtPpFqEKzKmtbMzY7/Fef/+6eMQ9tM=;
        b=gr3GbL9imhqAWZJtGKiNte24q8068wKM3iiA4YpzzxNJowPQY/2HdokUnwzA6kxez6
         RqbAdUDj7i30/ntuL9Hba0o7Vyc4slSolfXFkNwXvJy73u2Fov2y2S9B0taUAX+PDB/B
         VZhAUQnQHljMb9D9S6/F4waZBmrtUoLtZ6gxsaWQsFZ34FnR/rindTJ0khWP7wftGBRc
         fKXEKMsxPnXuet3A/WUgJcv0TjPRGXPewbYIpBsKl7pV8Qki/2Y93uW4mNR79oVmFp88
         QbzkN7weXIhhBTKiqg+67so3bRPIWEpTQ/3izSaqY0FANTRWGEvmrvKh3QVy3tpUL2Yw
         qxgA==
X-Gm-Message-State: AC+VfDyBBatGivrP5h40uTQ78Xw/NeQSkplCwFd2917E5r1RFku+W4xl
        mPAjJDhrwwrDzzJL++8VoXyORw==
X-Google-Smtp-Source: ACHHUZ7AgxfuUTNVMF0Wxbr5hkiwVl7hPCJ0GDBhPPALYU53elsE56jLs70/vV9cThwKLoazdBUKgA==
X-Received: by 2002:a7b:c7d5:0:b0:3f4:d18f:b2fb with SMTP id z21-20020a7bc7d5000000b003f4d18fb2fbmr6440381wmk.8.1683898351147;
        Fri, 12 May 2023 06:32:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f31d44f0cbsm28824757wml.29.2023.05.12.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:32:28 -0700 (PDT)
Date:   Fri, 12 May 2023 16:32:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
 __alloc_pages+0x2e8/0x3a0
Message-ID: <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain>
References: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pretty sure Chuck Lever did this intentionally, but he's not on the
CC list.  Let's add him.

regards,
dan carpenter

On Fri, May 12, 2023 at 06:15:04PM +0530, Naresh Kamboju wrote:
> Following kernel warning has been noticed on qemu-arm64 while running kunit
> tests while booting Linux 6.4.0-rc1-next-20230512 and It was started from
> 6.3.0-rc7-next-20230420.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> This is always reproducible on qemu-arm64, qemu-arm, qemu-x86 and qemu-i386.
> Is this expected warning as a part of kunit tests ?
> 
> Crash log:
> -----------
> 
> [  663.530868]     KTAP version 1
> [  663.531545]     # Subtest: Handshake API tests
> [  663.533521]     1..11
> [  663.534424]         KTAP version 1
> [  663.535406]         # Subtest: req_alloc API fuzzing
> [  663.542460]         ok 1 handshake_req_alloc NULL proto
> [  663.550345]         ok 2 handshake_req_alloc CLASS_NONE
> [  663.558041]         ok 3 handshake_req_alloc CLASS_MAX
> [  663.565790]         ok 4 handshake_req_alloc no callbacks
> [  663.573882]         ok 5 handshake_req_alloc no done callback
> [  663.580284] ------------[ cut here ]------------
> [  663.582129] WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
> __alloc_pages+0x2e8/0x3a0
> [  663.585675] Modules linked in:
> [  663.587808] CPU: 0 PID: 1200 Comm: kunit_try_catch Tainted: G
>           N 6.4.0-rc1-next-20230512 #1
> [  663.589817] Hardware name: linux,dummy-virt (DT)
> [  663.591426] pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [  663.592978] pc : __alloc_pages+0x2e8/0x3a0
> [  663.594236] lr : __kmalloc_large_node+0xbc/0x160
> [  663.595548] sp : ffff80000a317bc0
> [  663.596577] x29: ffff80000a317bc0 x28: 0000000000000000 x27: 0000000000000000
> [  663.598863] x26: ffff0000c8925b20 x25: 0000000000000000 x24: 0000000000000015
> [  663.601098] x23: 0000000000040dc0 x22: ffffbf424e7420c8 x21: ffffbf424e7420c8
> [  663.603100] x20: 1ffff00001462f88 x19: 0000000000040dc0 x18: 0000000078b4155a
> [  663.605582] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  663.607328] x14: 0000000000000000 x13: 6461657268745f68 x12: ffff60001913bc5a
> [  663.609355] x11: 1fffe0001913bc59 x10: ffff60001913bc59 x9 : 1fffe0001913bc59
> [  663.611004] x8 : 0000000041b58ab3 x7 : ffff700001462f88 x6 : dfff800000000000
> [  663.613556] x5 : 00000000f1f1f1f1 x4 : 00000000f2f2f200 x3 : 0000000000000000
> [  663.615364] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffbf42516818e2
> [  663.617753] Call trace:
> [  663.618486]  __alloc_pages+0x2e8/0x3a0
> [  663.619613]  __kmalloc_large_node+0xbc/0x160
> [  663.621454]  __kmalloc+0x84/0x94
> [  663.622551]  handshake_req_alloc+0x74/0xe8
> [  663.623801]  handshake_req_alloc_case+0xa0/0x170
> [  663.625467]  kunit_try_run_case+0x7c/0x100
> [  663.626592]  kunit_generic_run_threadfn_adapter+0x30/0x4c
> [  663.628998]  kthread+0x1d4/0x1e4
> [  663.629715]  ret_from_fork+0x10/0x20
> [  663.631094] ---[ end trace 0000000000000000 ]---
> [  663.643101]         ok 6 handshake_req_alloc excessive privsize
> [  663.649446]         ok 7 handshake_req_alloc all good
> [  663.651032]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
> [  663.653941]     ok 1 req_alloc API fuzzing
> [  663.665951]     ok 2 req_submit NULL req arg
> [  663.674278]     ok 3 req_submit NULL sock arg
> [  663.682968]     ok 4 req_submit NULL sock->file
> [  663.694323]     ok 5 req_lookup works
> [  663.703604]     ok 6 req_submit max pending
> [  663.714655]     ok 7 req_submit multiple
> [  663.725174]     ok 8 req_cancel before accept
> [  663.733780]     ok 9 req_cancel after accept
> [  663.742528]     ok 10 req_cancel after done
> [  663.750637]     ok 11 req_destroy works
> [  663.751884] # Handshake API tests: pass:11 fail:0 skip:0 total:11
> [  663.753579] # Totals: pass:17 fail:0 skip:0 total:17
> 
> links:
> ------
> 
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230512/testrun/16901289/suite/log-parser-boot/test/check-kernel-exception/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230512/testrun/16901289/suite/log-parser-boot/tests/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230420/testrun/16385677/suite/log-parser-boot/test/check-kernel-warning-ac79d2ca0f443d407d9749244f1738c9a2b123c609820f82d9e8907c756f5340/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230512/testrun/16901289/suite/log-parser-boot/test/check-kernel-warning-ac79d2ca0f443d407d9749244f1738c9a2b123c609820f82d9e8907c756f5340/history/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
