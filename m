Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB49703559
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbjEOQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjEOQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:58:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEAE7AA9;
        Mon, 15 May 2023 09:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E381F62A33;
        Mon, 15 May 2023 16:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBBAC433EF;
        Mon, 15 May 2023 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684169875;
        bh=Jmopy33ZoS1la9R1avtjotbLsHWcwBpRSQv67QLaEP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUNA2ZCd3vS2KC5EHQUxiJ7DKlU1qI411RsEupq19AMctcTLmJce2hIaRXHVwxbDQ
         UlAgtPA1xY2E2g27GQgQImrb4cHCa7lomnNbBuS9ZF9cCypkZje1ROc3PIQJdgjGH/
         s7/F2YBz/sSicUWNwbXVcEz0J1EoTH/+9ev4F4XMM8MCIyeqiwjCW6cVd8UAZfxkiD
         VebvJWVgXDAMsP/igFigPZJ74qdmDoGNDCDkvMimM9YSjt5cNODrsixTURbcH6jDnE
         9XbGLfmlFEmBH7Qx7x96RsIwLNsdQc7a3Yji2gPt3s6k4UsWMMWaDADQxZIlVXpLJ1
         zJStYGHX4X+vA==
Date:   Mon, 15 May 2023 09:57:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ying.huang@intel.com,
        fengwei.yin@intel.com
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <20230515165754.GL858799@frogsfrogsfrogs>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Patches against upstream head only, please.  This does not apply to
6.4-rc2 without modification, and we cannot go backwards in time.  Do
you mean to pass XFS_ALLOC_FLAG_TRYLOCK from
xfs_alloc_vextent_iterate_ags into xfs_alloc_fix_freelist by way of
adding an alloc_flags argument to xfs_alloc_vextent_prepare_ag?

--D

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
> 
> 
> Also for the turbostat.Bzy_MHz diff, IIUC, 0Day always uses
> 'performance' cpufreq governor. And as the test case is running
> 32 thread in a platform with 96 CPUs, there are many CPUs in idle
> state in average, and I suspect the Bzy_MHz may be calculated 
> considering those cpufreq and cpuidle factors.
> 
> Thanks,
> Feng
> 
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
