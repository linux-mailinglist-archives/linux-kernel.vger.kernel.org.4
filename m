Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4B649D06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiLLLHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiLLLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:06:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B3F5B0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:52:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g10so11647053plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/x5RVB0C4ixDlrmRoy61hoV7zGh5kz89ZwW+bn5qGc=;
        b=EG+HYXmLQxSZjmx5POY+EmrROaM/1qWS18m7mSDvPTzKp7L4UfKD6s+aDktkD8GY08
         Ke/a8tma2erKDbfcmaE/No/xAsty8J4/QwU3jCQVYem51lRwhYxpAwdkKF0pmOe8wymn
         nWFt35X3CTwfHAXN7Br6PVblEDiyeRa7mnubm0m7YEha9DDbU1YzpyKrIG+oprdPyJNI
         XUpnQQPf6v8s5GxeXghmqhfEEs6fHRR7IfpZpp+MTuWKCN9d0yAF6u1ecOQC3XxIpJ10
         P9augjeyRqJS+kcMja1aIC4IvqaK8sBkErcwgkRICnVCurSdbqA2SmoZRtrLWd/PAqdg
         D2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/x5RVB0C4ixDlrmRoy61hoV7zGh5kz89ZwW+bn5qGc=;
        b=VA1vMJctR8XCW0uKkL8bA1yjJEdz4anTPRmfd0sVUIiuIofNYXrfywUMjEQQ7Gj25+
         65tpIylVNjdLsNBYZkFkSN7PSEhPumQ8IZE2PxY4zW1p0uaYExOUJ5mZPZiBe2Zn9Nc+
         I0tNXNKqR6ou57RkXYpxSIh1TvDcTL3z57eMDw+L/izX/YqL31GgKfaWlQdR+sPnr4dH
         OTjHK0j3MfspVRbA1rZcd13o33yzrChBX2hHvZhEMWgEb4vaNMJva0HYAr3FSlrd5QId
         Xib/0nQW9RHOiQz39sWuJjw3svUAhzVUkRNN6bB19cxkihvuEuY8jhcfqQ/MOo/LBh2P
         I+Dg==
X-Gm-Message-State: ANoB5pm107tGHovcEaHs4NMFlzwRZWvmPmIDMAtnjs22m/W3rGsaEgNA
        OfCmpbvMZkgvJj9MBPX5KbYRIg==
X-Google-Smtp-Source: AA0mqf62k4otCG0ns1XL7KhjQFVjJ5f/a8PBB/bkRVc08Zd7/PD+3ysB+ZJCVxjkYH7J3y6ToW1quw==
X-Received: by 2002:a17:902:e811:b0:189:d8fb:152d with SMTP id u17-20020a170902e81100b00189d8fb152dmr22283049plg.25.1670842345779;
        Mon, 12 Dec 2022 02:52:25 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001811a197797sm6008738plb.194.2022.12.12.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:52:24 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:52:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hans-Peter Nilsson <hp@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to
 sort -nu
Message-ID: <Y5cH4I8XD8804hqa@leoy-yangtze.lan>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s>
 <Y4Cspv98j8TqwCqZ@axis.com>
 <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
 <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Nov 25, 2022 at 02:56:31PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 25, 2022, at 13:54, Leo Yan wrote:
> > On Fri, Nov 25, 2022 at 12:53:10PM +0100, Vincent Whitchurch wrote:
> 
> >> It looks like this patch was never applied?  AFAICS it is still needed
> >> on current HEAD and it still applies cleanly.
> >
> > Thanks a lot for bringing up this.
> >
> > Before there have a discussion [1] for refactoring Arm64 system call
> > table but it didn't really happen.
> 
> I actually worked on this last week and did a new series to convert
> the old asm-generic/unistd.h header into the syscall.tbl format,
> and change arm64 to use that.
> 
> You can find my work in the 'syscall-tbl' branch of my asm-generic
> tree [1]. This has only seen light build testing so far, and is
> probably still buggy, but most of the work is there. The missing
> bits are the Makefiles for the other seven architectures using
> asm-generic/unistd.h, and checking the output to ensure the
> contents are still the same.

Thanks a lot for sharing the patch set.

I went through the whole patch set, below are several things I observed:

- I did a quick compilation but found building failure, this failure
  is caused by the first patch "arm64: convert unistd_32.h to
  syscall.tbl format", it removes the macro __NR_compat_syscalls.

  In file included from ./include/vdso/const.h:5,
                 from ./include/linux/const.h:4,
                 from ./arch/arm64/include/asm/alternative-macros.h:5,
                 from ./arch/arm64/include/asm/alternative.h:5,
                 from ./arch/arm64/include/asm/lse.h:15,
                 from ./arch/arm64/include/asm/cmpxchg.h:14,
                 from ./arch/arm64/include/asm/atomic.h:16,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/refcount.h:95,
                 from kernel/seccomp.c:18:
  ./arch/arm64/include/asm/seccomp.h:27:33: error: ‘__NR_compat_syscalls’ undeclared here (not in a function); did you mean ‘in_compat_syscall’?
     27 | # define SECCOMP_ARCH_COMPAT_NR __NR_compat_syscalls
        |                                 ^~~~~~~~~~~~~~~~~~~~
  ./include/uapi/linux/const.h:34:40: note: in definition of macro ‘__KERNEL_DIV_ROUND_UP’
     34 | #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
        |                                        ^
  ./include/linux/types.h:11:28: note: in expansion of macro ‘BITS_TO_LONGS’
     11 |         unsigned long name[BITS_TO_LONGS(bits)]
        |                            ^~~~~~~~~~~~~
  kernel/seccomp.c:168:9: note: in expansion of macro ‘DECLARE_BITMAP’
    168 |         DECLARE_BITMAP(allow_compat, SECCOMP_ARCH_COMPAT_NR);
        |         ^~~~~~~~~~~~~~
  kernel/seccomp.c:168:38: note: in expansion of macro ‘SECCOMP_ARCH_COMPAT_NR’
    168 |         DECLARE_BITMAP(allow_compat, SECCOMP_ARCH_COMPAT_NR);
        |                                      ^~~~~~~~~~~~~~~~~~~~~~
 
- The patch set breaks git bisection, when I use "git bisect" I can
  find more building failures caused by middle patches.

- The patch "arm64: generate 64-bit syscall.tbl" removes macros:

  __ARCH_WANT_RENAMEAT
  __ARCH_WANT_NEW_STAT
  __ARCH_WANT_SET_GET_RLIMIT
  __ARCH_WANT_TIME32_SYSCALLS
  __ARCH_WANT_SYS_CLONE3
  __ARCH_WANT_MEMFD_SECRET

  Seems to me we still need to enable these macros so can enable Arm64
  specific system calls?

- We also need to update the header files:
  tools/include/uapi/asm-generic/unistd.h

You are welcome to CC me when you send out formal patches to mailing
list and I can test it (and look if can refine perf code for this).

Thanks,
Leo
