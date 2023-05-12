Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0B701250
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbjELXFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240007AbjELXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:05:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5B211F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:05:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6436e004954so10915428b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683932708; x=1686524708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDjWjICi5dfHeJD8jjNAckygSSqWC7cZ1U4u8cLgo+8=;
        b=b+EkQMOovJD4q+RcqhdM5THPiaQnOoMQQmQUdAE1/5C5yoRdmjd826KH8hDHBymbl8
         oTKPyKWnnE2Q8lhIrIzJX7M8P5+4hMyo47M4rsXMASW0xbYt3MRYU7ITvyOoZaMPvSde
         ON6uo1KLHh8/1tghvnn80GZjlNEOciBO+yztiz9QJlBGlQvJFcBw4ELc2HMNisiz3BHg
         8u6RZAmSUxGwfHYI4QVnEnYu5gpI67i2mCxOmlOytbCuMyYtoi7zgy7Tv+TrSdmoAxH7
         +Co8ydCoFrcpStr9Rm/F1zLjpM6u3RUhH3KADEfDbDhRoeX4vCJ/VAQSDQ1gxLm63Qv+
         TIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683932708; x=1686524708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDjWjICi5dfHeJD8jjNAckygSSqWC7cZ1U4u8cLgo+8=;
        b=Axzfa/vVQdQljF07Pm5Y3Du5+D62J9T7MC+5GjpPeWepKidR1f9HG3anp/1ZY31FWX
         Xo+SCMwNtOHMN5R8rzTw1pJHqpvS4egNp6QCu1KfCDtBdAk1kNMth6g5fG5hXU20Yf+M
         ZLf36hx7A70eStIGfZka9j2ZS6IafMd4RRzYfCX+XUVfLcSS03K13e8tUAdvYLb8u4Dj
         sfhqQAV2y7TYxjpECaii6deEoxeFuMQqds43DrHq3iHY55C7rGBlR2wSlJp5g1TCGC5E
         xaw0Yn2053qrS/HCgeoF+beq/3QRhiiuYrxFM3fiqlqzGZCOaQS6GT4usAIwTRZBNzYl
         bdUA==
X-Gm-Message-State: AC+VfDwHWrnX4x/auUNcWPXZPgmU0e46HX35JlDjwFr6gNX0al2e76Mi
        byIeowcbBFRsX7xJPx8flK0v/Q==
X-Google-Smtp-Source: ACHHUZ6PYFc8acpfxUTxuuQj7QEQwrfqqFf+HV9VDYlbLP/6n+FJTlDvLm4ftm/f8U07EhaVuDWFWQ==
X-Received: by 2002:a05:6a21:789c:b0:100:607:b986 with SMTP id bf28-20020a056a21789c00b001000607b986mr26046294pzc.56.1683932707867;
        Fri, 12 May 2023 16:05:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id t23-20020a62ea17000000b0062cf75a9e6bsm7540715pfh.131.2023.05.12.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:05:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pxbou-00Ea0E-Ko; Sat, 13 May 2023 09:05:04 +1000
Date:   Sat, 13 May 2023 09:05:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <20230512230504.GF3223426@dread.disaster.area>
References: <202305090905.aff4e0e6-oliver.sang@intel.com>
 <20230509065433.GT3223426@dread.disaster.area>
 <20230509071053.GE2651828@dread.disaster.area>
 <ZF3uXe+cjAsfCLic@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF3uXe+cjAsfCLic@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 03:44:29PM +0800, Oliver Sang wrote:
> hi, Dave Chinner,
> 
> On Tue, May 09, 2023 at 05:10:53PM +1000, Dave Chinner wrote:
> > On Tue, May 09, 2023 at 04:54:33PM +1000, Dave Chinner wrote:
> > > On Tue, May 09, 2023 at 10:13:19AM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed a -5.7% regression of fsmark.files_per_sec on:
> > > > 
> > > > 
> > > > commit: 2edf06a50f5bbe664283f3c55c480fc013221d70 ("xfs: factor xfs_alloc_vextent_this_ag() for  _iterate_ags()")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > This is just a refactoring patch and doesn't change any logic.
> > > Hence I'm sceptical that it actually resulted in a performance
> > > regression. Indeed, the profile indicates a significant change of
> > > behaviour in the allocator and I can't see how the commit above
> > > would cause anything like that.
> > > 
> > > Was this a result of a bisect? If so, what were the original kernel
> > > versions where the regression was detected?
> > 
> > Oh, CONFIG_XFS_DEBUG=y, which means:
> > 
> > static int
> > xfs_alloc_ag_vextent_lastblock(
> >         struct xfs_alloc_arg    *args,
> >         struct xfs_alloc_cur    *acur,
> >         xfs_agblock_t           *bno,
> >         xfs_extlen_t            *len,
> >         bool                    *allocated)
> > {
> >         int                     error;
> >         int                     i;
> > 
> > #ifdef DEBUG
> >         /* Randomly don't execute the first algorithm. */
> >         if (get_random_u32_below(2))
> >                 return 0;
> > #endif
> > 
> > We randomly chose a near block allocation strategy to use to improve
> > code coverage, not the optimal one for IO performance. Hence the CPU
> > usage and allocation patterns that impact IO performance are simply
> > not predictable or reproducable from run to run. So, yeah, trying to
> > bisect a minor difference in performance as a result of this
> > randomness will not be reliable....
> 
> Thanks a lot for guidance!
> 
> we plan to disable XFS_DEBUG (as well as XFS_WARN) in our performance tests.
> want to consult with you if this is the correct thing to do?

You can use XFS_WARN=y with performance tests - that elides all the
debug specific code that changes behaviour but leaves all the
ASSERT-based correctness checks in the code.

> and I guess we should still keep them in functional tests, am I right?

Yes.

> BTW, regarding this case, we tested again with disabling XFS_DEBUG (as well as
> XFS_WARN), kconfig is attached, only diff with last time is:
> -CONFIG_XFS_DEBUG=y
> -CONFIG_XFS_ASSERT_FATAL=y
> +# CONFIG_XFS_WARN is not set
> +# CONFIG_XFS_DEBUG is not set
> 
> but we still observed similar regression:
> 
> ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    8176057 ± 15%      +4.7%    8558110        fsmark.app_overhead
>      14484            -6.3%      13568        fsmark.files_per_sec

So the application spent 5% more CPU time in userspace, and the rate
the kernel processed IO went down by 6%. Seems to me like
everything is running slower, not just the kernel code....

>     100.50 ±  5%      +0.3%     100.83        turbostat.Avg_MHz
>       5.54 ± 11%      +0.3        5.82        turbostat.Busy%
>       1863 ± 19%      -6.9%       1733        turbostat.Bzy_MHz

Evidence that the CPU is running at a 7% lower clock rate when the
results are 6% slower is a bit suspicious to me. Shouldn't the CPU
clock rate be fixed to the same value for A-B performance regression
testing?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
