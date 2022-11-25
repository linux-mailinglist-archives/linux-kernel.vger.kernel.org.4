Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD403638916
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKYLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKYLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:53:13 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366CA1A800
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669377192;
  x=1700913192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crz04ig20tpvAmEbWeHvM10lzZnFghyvDj4EsoOeDhI=;
  b=EEnoPylpzVWOO7cWrNVme95lRN1AOoxdjgMvd0vdT/MWHcN+kVbPvXKH
   x+ZHqdo83elwR7IqZwZZAzsVYF0IJe5VBxLrlnqpH+yzRa8BHmc1NDiBg
   5vjaL8pjOtJnzaTs/rDgEd0THUgLdcWcOeXFtYDuxxzz3ymySpviq9r7+
   e8Gs72Yt8zdeQ3JjMiXTM2Xm4mHSj4ncy70dJzjpZyl2Hdj9ETv5aIyJw
   WJ2sSKfGJH9CZJphOFH6LTwd5/QSImxINrH6wWeqtydC0awvnMdOMves0
   +G04YFmHBPHZKN7DeeNjUDzQTX1mhZlIvjOAiwslg7xCEAsPQgYXoU2zw
   A==;
Date:   Fri, 25 Nov 2022 12:53:10 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Hans-Peter Nilsson <hp@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>,
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
Message-ID: <Y4Cspv98j8TqwCqZ@axis.com>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201229030933.GC28115@leoy-ThinkPad-X240s>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:09:33AM +0800, Leo Yan wrote:
> On Mon, Dec 28, 2020 at 03:39:41AM +0100, Hans-Peter Nilsson wrote:
> > When using "sort -nu", arm64 syscalls were lost.  That is, the
> > io_setup syscall (number 0) and all but one (typically
> > ftruncate; 64) of the syscalls that are defined symbolically
> > (like "#define __NR_ftruncate __NR3264_ftruncate") at the point
> > where "sort" is applied.
> > 
> > This creation-of-syscalls.c-scheme is, judging from comments,
> > copy-pasted from powerpc, and worked there because at the time,
> > its tools/arch/powerpc/include/uapi/asm/unistd.h had *literals*,
> > like "#define __NR_ftruncate 93".
> > 
> > With sort being numeric and the non-numeric key effectively
> > evaluating to 0, the sort option "-u" means these "duplicates"
> > are removed.  There's no need to remove syscall lines with
> > duplicate numbers for arm64 because there are none, so let's fix
> > that by just losing the "-u".  Having the table numerically
> > sorted on syscall-number for the rest of the syscalls looks
> > nice, so keep the "-n".
> > 
> > Signed-off-by: Hans-Peter Nilsson <hp@axis.com>
> 
> Very good catching!  I tested this patch with the commands:
> 
> $ cd $LINUX_KERN
> $ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl \
>         $ARM64_TOOLCHAIN_PATH/aarch64-linux-gnu-gcc \
>         gcc tools tools/include/uapi/asm-generic/unistd.h
> 
> It gives out complete syscall tables:
> 
> $ diff /tmp/mksyscall_before.txt /tmp/mksyscall_after.txt
> 1a2,4
> > 	[223] = "fadvise64",
> > 	[25] = "fcntl",
> > 	[44] = "fstatfs",
> 2a6,11
> > 	[0] = "io_setup",
> > 	[62] = "lseek",
> > 	[222] = "mmap",
> > 	[71] = "sendfile",
> > 	[43] = "statfs",
> > 	[45] = "truncate",
> 
> Rather than dropping option "-u" for sort command, I googled and read
> the manual of "sort", but cannot find other better method.  So this
> patch looks good for me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>

It looks like this patch was never applied?  AFAICS it is still needed
on current HEAD and it still applies cleanly.
