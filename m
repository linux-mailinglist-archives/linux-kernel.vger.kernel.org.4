Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3E638A94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKYMyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:54:10 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686B20F5E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:54:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n17so3887390pgh.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvxK7g2/OoP+dWq+SzoWxDDlutXiD4a/hU/5/6tjljU=;
        b=WDk8HuQoLgoFtqcCu7vG0M6zDpOHTB8F3PCm6MXmWptYILZ1mGyOau0HPDY8JSg6MM
         xWJeFl8gSaM/xZmZxN3GXGQh6VXSpGPICuwCNfLly8YRiSSIrNdPYP7Oj2wfigIMfk8j
         Ckf9OEsVHvHnIjJXThs5MQMR0wIf0px3jEI3mceKwZ+rSvXvckeNIv6R537Q/XZPBUlY
         pTPIjxuAa7XBfX2X7MeyCVswl+p/IiN7lSN6+ntN4fCgYd+GMiPuX44MIKWs+t5x9wOq
         sXMuo0aPMKjZbwwXpFnKWrwKXY2ZrN08vhx50Shlv98BQ9SsCS0QZ1HpY38mL+wGrnmX
         ESOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvxK7g2/OoP+dWq+SzoWxDDlutXiD4a/hU/5/6tjljU=;
        b=Rxrg2TBv8unqO135dFjDAfnR1d0NreaVTLN8Zrru8pST470APJou8H6AlB65YWsvqY
         31JnzQDcYRa/7xsc1Zf8bgIclhITw/dijiwWDeoV0uGKLENZMHrvrUUl/ANCI0qpvwIm
         w0DcutY0c1xZpB+4WbVW9bT15FTKosSvKea87uENL2rpZO4qzDuQb99HMuavAu2NhbRM
         3GC3NnsamKp68rk3DFNAp3W3ABvZ9RK+RncrS4f9HTXraHE3UaKf2GoG582t+tE5UvQc
         fa9q92fplVeUjpdK6O9+FaU14M80kIqpH9jw+uQBjpWkZrKJe6+3OlH2r4DgjGntjV4C
         41qg==
X-Gm-Message-State: ANoB5pmUz8vmjnegKqGNhxxidyEI9GfmdgUEUx3NeQjMdzaJmYKd/mKD
        EQ+1rTpa+ysZZZQCbHzZkwBvhg==
X-Google-Smtp-Source: AA0mqf608MisyiUu6taSsiP77NzaO+DRdBelfI2fTX31wK6PdoWClQDxoDCMHtJpVKoNd4/wVf6X+w==
X-Received: by 2002:a63:1062:0:b0:470:a47:996a with SMTP id 34-20020a631062000000b004700a47996amr16156950pgq.377.1669380848537;
        Fri, 25 Nov 2022 04:54:08 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id p21-20020a631e55000000b004597e92f99dsm2542684pgm.66.2022.11.25.04.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:54:07 -0800 (PST)
Date:   Fri, 25 Nov 2022 20:54:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s>
 <Y4Cspv98j8TqwCqZ@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Cspv98j8TqwCqZ@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

[ + Arnd ]

On Fri, Nov 25, 2022 at 12:53:10PM +0100, Vincent Whitchurch wrote:
> On Tue, Dec 29, 2020 at 11:09:33AM +0800, Leo Yan wrote:
> > On Mon, Dec 28, 2020 at 03:39:41AM +0100, Hans-Peter Nilsson wrote:
> > > When using "sort -nu", arm64 syscalls were lost.  That is, the
> > > io_setup syscall (number 0) and all but one (typically
> > > ftruncate; 64) of the syscalls that are defined symbolically
> > > (like "#define __NR_ftruncate __NR3264_ftruncate") at the point
> > > where "sort" is applied.
> > > 
> > > This creation-of-syscalls.c-scheme is, judging from comments,
> > > copy-pasted from powerpc, and worked there because at the time,
> > > its tools/arch/powerpc/include/uapi/asm/unistd.h had *literals*,
> > > like "#define __NR_ftruncate 93".
> > > 
> > > With sort being numeric and the non-numeric key effectively
> > > evaluating to 0, the sort option "-u" means these "duplicates"
> > > are removed.  There's no need to remove syscall lines with
> > > duplicate numbers for arm64 because there are none, so let's fix
> > > that by just losing the "-u".  Having the table numerically
> > > sorted on syscall-number for the rest of the syscalls looks
> > > nice, so keep the "-n".
> > > 
> > > Signed-off-by: Hans-Peter Nilsson <hp@axis.com>
> > 
> > Very good catching!  I tested this patch with the commands:
> > 
> > $ cd $LINUX_KERN
> > $ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl \
> >         $ARM64_TOOLCHAIN_PATH/aarch64-linux-gnu-gcc \
> >         gcc tools tools/include/uapi/asm-generic/unistd.h
> > 
> > It gives out complete syscall tables:
> > 
> > $ diff /tmp/mksyscall_before.txt /tmp/mksyscall_after.txt
> > 1a2,4
> > > 	[223] = "fadvise64",
> > > 	[25] = "fcntl",
> > > 	[44] = "fstatfs",
> > 2a6,11
> > > 	[0] = "io_setup",
> > > 	[62] = "lseek",
> > > 	[222] = "mmap",
> > > 	[71] = "sendfile",
> > > 	[43] = "statfs",
> > > 	[45] = "truncate",
> > 
> > Rather than dropping option "-u" for sort command, I googled and read
> > the manual of "sort", but cannot find other better method.  So this
> > patch looks good for me:
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> It looks like this patch was never applied?  AFAICS it is still needed
> on current HEAD and it still applies cleanly.

Thanks a lot for bringing up this.

Before there have a discussion [1] for refactoring Arm64 system call
table but it didn't really happen. I think it's the right thing to merge
this patch, @Arnaldo, could you pick up this patch?

Thanks,
Leo

[1] https://lore.kernel.org/lkml/CAK8P3a1G2YHh2FRd=vBY4xxsJ1wZFh2pB1wyw82QmQOaiV4+CA@mail.gmail.com/
