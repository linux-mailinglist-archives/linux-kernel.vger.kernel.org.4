Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745437040D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbjEOWUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbjEOWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:20:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27CD30E8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:20:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643a1fed360so8220296b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684189239; x=1686781239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SFqV3UQyv74Jf8n7deoWwncMcJ7izs37jK3uaW+m7g=;
        b=AYpFp2TA+3hBrRCJ8vr9SkoGUWpS+Cos7jEYPT/Mg6bozCKU+1YHCuAOe1sXt6nWOQ
         UnOAMu2aWyeSLOI03J0A4lmAAqhC5TyuoZC3nYQyQoEqDTp3AJKPoxxMh7+zz3bKbAY2
         u23C9B1lFAMtw2pPzB+Tb44bc/1HCUa+sfE36yDgBd93qI5gI1j86Z8PCzYITLsmbX3X
         YswRPw2R2Z/Sn7QOaQ5J7Y7+cMnJqwmMQwOoF9NmX3OHuxF5h4Jkfe8gUkTFsN8HE199
         loxDZCejR0gLl1nFIdK6EI2GRz+y4bn0hlGOUjeSH94W9Ro0ZSgTc3ChOc6ASijh79fN
         5pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684189239; x=1686781239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SFqV3UQyv74Jf8n7deoWwncMcJ7izs37jK3uaW+m7g=;
        b=dEtlJsVsS7MTo8hR5utubdZm1ae2aJ736yo2KDLGFiZjAHU4WN3bPT2uhBJNY33fB7
         XoeiD4pERABdQdElpjO8TFI5hSAzbKB2qG+mxBZEQZvpvpcUkPFp/pQYVvAWyyEjWH5D
         67d9mIFIZwcAlfEDS72WM/CfsOI/wCIc6R8w7HAHSFw3o5O/ug4sIPPf+KlxiUUP8oJI
         /8TQVVbXkMwdU2MOAFp59dU0GXMtSXOFvIckbPpOz3XAw/ckV6hsf2CCov094u6imNH3
         P8HVbG5CHQhRR9CKpoXCL3QD5X7TnKCQsG4x08NVE980rBhzgOJPRkeoGJkiLnyd9KMq
         rKIA==
X-Gm-Message-State: AC+VfDyyDAUCsC+h5pVbCTI0KBwDjoOLbIJckCixSgHk4r+MnaAFagJO
        j0jRZESZACdphzMAPiYSEsfF8g==
X-Google-Smtp-Source: ACHHUZ5ANtDJYeE/4uaBwJIjUuX8jUXc/gv0P5ZHNLfz12/rbYnzKuufF/tj9utEsjYyBZymW+K0TQ==
X-Received: by 2002:a05:6a20:1443:b0:101:a459:bb0d with SMTP id a3-20020a056a20144300b00101a459bb0dmr29982314pzi.2.1684189239156;
        Mon, 15 May 2023 15:20:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id p38-20020a631e66000000b0052c766b2f52sm12149144pgm.4.2023.05.15.15.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:20:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pygYU-00FkH7-Qy; Tue, 16 May 2023 08:20:34 +1000
Date:   Tue, 16 May 2023 08:20:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        ying.huang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <20230515222034.GG3223426@dread.disaster.area>
References: <202305090905.aff4e0e6-oliver.sang@intel.com>
 <20230509065433.GT3223426@dread.disaster.area>
 <20230509071053.GE2651828@dread.disaster.area>
 <ZF3uXe+cjAsfCLic@xsang-OptiPlex-9020>
 <20230512230504.GF3223426@dread.disaster.area>
 <ZGDyAOewWqjY5xvJ@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGDyAOewWqjY5xvJ@feng-clx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 10:36:48PM +0800, Feng Tang wrote:
> Hi Dave,
> 
> On Sat, May 13, 2023 at 09:05:04AM +1000, Dave Chinner wrote:
> > On Fri, May 12, 2023 at 03:44:29PM +0800, Oliver Sang wrote:
> [...]
> > > Thanks a lot for guidance!
> > > 
> > > we plan to disable XFS_DEBUG (as well as XFS_WARN) in our performance tests.
> > > want to consult with you if this is the correct thing to do?
> > 
> > You can use XFS_WARN=y with performance tests - that elides all the
> > debug specific code that changes behaviour but leaves all the
> > ASSERT-based correctness checks in the code.
> > 
> > > and I guess we should still keep them in functional tests, am I right?
> > 
> > Yes.
> > 
> > > BTW, regarding this case, we tested again with disabling XFS_DEBUG (as well as
> > > XFS_WARN), kconfig is attached, only diff with last time is:
> > > -CONFIG_XFS_DEBUG=y
> > > -CONFIG_XFS_ASSERT_FATAL=y
> > > +# CONFIG_XFS_WARN is not set
> > > +# CONFIG_XFS_DEBUG is not set
> > > 
> > > but we still observed similar regression:
> > > 
> > > ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >    8176057 ± 15%      +4.7%    8558110        fsmark.app_overhead
> > >      14484            -6.3%      13568        fsmark.files_per_sec
> > 
> > So the application spent 5% more CPU time in userspace, and the rate
> > the kernel processed IO went down by 6%. Seems to me like
> > everything is running slower, not just the kernel code....
> > 
> > >     100.50 ±  5%      +0.3%     100.83        turbostat.Avg_MHz
> > >       5.54 ± 11%      +0.3        5.82        turbostat.Busy%
> > >       1863 ± 19%      -6.9%       1733        turbostat.Bzy_MHz
> > 
> > Evidence that the CPU is running at a 7% lower clock rate when the
> > results are 6% slower is a bit suspicious to me. Shouldn't the CPU
> > clock rate be fixed to the same value for A-B performance regression
> > testing?
> 
> For commit 2edf06a50f5, it seems to change the semantics a little
> about handling of 'flags' for xfs_alloc_fix_freelist(). With the debug
> below, the performance is restored.
> 
> 
> ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4 68721405630744da1c07c9c1c3c 
> ---------------- --------------------------- --------------------------- 
> 
>      14349            -5.7%      13527            +0.6%      14437        fsmark.files_per_sec
>     486.29            +5.8%     514.28            -0.5%     483.70        fsmark.time.elapsed_time
> 
> Please help to review if the debug patch miss anything as I don't
> know the internals of xfs, thanks.

Well spotted. :)

The relevant commit dropped the trylock flag, so the perf regression
and change of allocator behaviour is due to it blocking on a busy AG
instead of skipping to the next uncontended on and so all
allocations came from extents in the last block of the free space
btree in that AG.

> 
> ---
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 98defd19e09e..8c85cc68c5f4 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -3246,12 +3246,12 @@ xfs_alloc_vextent_set_fsbno(
>   */
>  static int
>  __xfs_alloc_vextent_this_ag(
> -	struct xfs_alloc_arg	*args)
> +	struct xfs_alloc_arg	*args, int flag)
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	int			error;
>  
> -	error = xfs_alloc_fix_freelist(args, 0);
> +	error = xfs_alloc_fix_freelist(args, flag);
>  	if (error) {
>  		trace_xfs_alloc_vextent_nofix(args);
>  		return error;
> @@ -3289,7 +3289,7 @@ xfs_alloc_vextent_this_ag(
>  	}
>  
>  	args->pag = xfs_perag_get(mp, args->agno);
> -	error = __xfs_alloc_vextent_this_ag(args);
> +	error = __xfs_alloc_vextent_this_ag(args, 0);
>  
>  	xfs_alloc_vextent_set_fsbno(args, minimum_agno);
>  	xfs_perag_put(args->pag);
> @@ -3329,7 +3329,7 @@ xfs_alloc_vextent_iterate_ags(
>  	args->agno = start_agno;
>  	for (;;) {
>  		args->pag = xfs_perag_get(mp, args->agno);
> -		error = __xfs_alloc_vextent_this_ag(args);
> +		error = __xfs_alloc_vextent_this_ag(args, flags);
>  		if (error) {
>  			args->agbno = NULLAGBLOCK;
>  			break;

I don't think this is the right way to fix this. The code is -very-
different at the end of the series that this is in the middle of,
and I need to check what callers now use the trylock behaviour to
determine how the trylock flag shold be passed around...

> Also for the turbostat.Bzy_MHz diff, IIUC, 0Day always uses
> 'performance' cpufreq governor. And as the test case is running
> 32 thread in a platform with 96 CPUs, there are many CPUs in idle
> state in average, and I suspect the Bzy_MHz may be calculated 
> considering those cpufreq and cpuidle factors.

If "busy MHz" includes the speed of idle CPUs, then it's not really
a measure of the speed of "busy" CPUs. If what you say is true, then
it is, at best, badly names - it would just be the "average Mhz",
right?

-Dave.

-- 
Dave Chinner
david@fromorbit.com
