Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F687149B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjE2Mv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2MvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A18EC;
        Mon, 29 May 2023 05:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 239F961465;
        Mon, 29 May 2023 12:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC15C433D2;
        Mon, 29 May 2023 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685364671;
        bh=fv6CZtUBlZCjthVqlk7/NDYhhCLFE00AtbpCy+f//HU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MVAv5EmL9CkMTkfH281UmsgF6OrPs2K0pqdIl3QRg+AAAE3xgwSCB6UVp08/IVJ+T
         trdaip6ji8H6RpZoxX75/3Bu0qHISegjd1siwT8NBjvSZY2zWwNfGPX2q3jIBhxvjc
         jNoBQCLjR0MurcP8s3TeGScQ1N+yTSTE11JsaUHXWtoN5NyfsBMxenT1CHxmU5JZIR
         Acya7KxpXe9TsRbmZg/VREgiuSNbXDZS4DAJ5fAdEbESyc2Qczy8sAq9FtxKS5iXLc
         lLCbIKbmzs8/Kn0tna/UvgXDyw2jeRX5jxnTy8MBQPA8OUI7o4+y6tmlxpF0OKgq7n
         4dkR2/CTA0Afg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B1C7CE1CCC; Mon, 29 May 2023 05:51:11 -0700 (PDT)
Date:   Mon, 29 May 2023 05:51:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     Kirill Tkhai <tkhai@ya.ru>, RCU <rcu@vger.kernel.org>,
        Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
Message-ID: <095806f1-f7f0-4914-b04b-c874fb25bb83@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202305230837.db2c233f-yujie.liu@intel.com>
 <eba38fce-2454-d7a4-10ef-240b4686f23d@linux.dev>
 <ZG29ULGNJdErnatI@yujie-X299>
 <896bbb09-d400-ec73-ba3a-b64c6e9bbe46@linux.dev>
 <e5fb8b34-c1ad-92e0-e7e5-f7ed1605dbc6@linux.dev>
 <bfb36563-fac9-4c84-96db-87dd28892088@linux.dev>
 <be04dc3e-a671-ec70-6cf6-70dc702f4184@linux.dev>
 <44407892-b7bc-4d6c-8e4a-6452f0ee88b9@paulmck-laptop>
 <d4b1599d-14c1-071c-6205-09fe60f2ed8b@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4b1599d-14c1-071c-6205-09fe60f2ed8b@linux.dev>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 10:39:21AM +0800, Qi Zheng wrote:
> Hi Paul,
> 
> On 2023/5/27 19:14, Paul E. McKenney wrote:
> > On Thu, May 25, 2023 at 12:03:16PM +0800, Qi Zheng wrote:
> > > On 2023/5/24 19:56, Qi Zheng wrote:
> > > > On 2023/5/24 19:08, Qi Zheng wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > 
> > > > > Well, I just ran the following command and reproduced the result:
> > > > > 
> > > > > stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &
> > > > > 
> > > > > 1) with commit 42c9db3970483:
> > > > > 
> > > > > stress-ng: info:  [11023] setting to a 60 second run per stressor
> > > > > stress-ng: info:  [11023] dispatching hogs: 9 ramfs
> > > > > stress-ng: info:  [11023] stressor       bogo ops real time  usr
> > > > > time sys time   bogo ops/s     bogo ops/s
> > > > > stress-ng: info:  [11023]                           (secs)    (secs)
> > > > > (secs)   (real time) (usr+sys time)
> > > > > stress-ng: info:  [11023] ramfs            774966     60.00
> > > > > 10.18 169.45     12915.89        4314.26
> > > > > stress-ng: info:  [11023] for a 60.00s run time:
> > > > > stress-ng: info:  [11023]    1920.11s available CPU time
> > > > > stress-ng: info:  [11023]      10.18s user time   (  0.53%)
> > > > > stress-ng: info:  [11023]     169.44s system time (  8.82%)
> > > > > stress-ng: info:  [11023]     179.62s total time  (  9.35%)
> > > > > stress-ng: info:  [11023] load average: 8.99 2.69 0.93
> > > > > stress-ng: info:  [11023] successful run completed in 60.00s (1 min,
> > > > > 0.00 secs)
> > > > > 
> > > > > 2) with commit f95bdb700bc6b:
> > > > > 
> > > > > stress-ng: info:  [37676] dispatching hogs: 9 ramfs
> > > > > stress-ng: info:  [37676] stressor       bogo ops real time  usr
> > > > > time sys time   bogo ops/s     bogo ops/s
> > > > > stress-ng: info:  [37676]                           (secs)    (secs)
> > > > > (secs)   (real time) (usr+sys time)
> > > > > stress-ng: info:  [37676] ramfs            168673     60.00
> > > > > 1.61   39.66      2811.08        4087.47
> > > > > stress-ng: info:  [37676] for a 60.10s run time:
> > > > > stress-ng: info:  [37676]    1923.36s available CPU time
> > > > > stress-ng: info:  [37676]       1.60s user time   (  0.08%)
> > > > > stress-ng: info:  [37676]      39.66s system time (  2.06%)
> > > > > stress-ng: info:  [37676]      41.26s total time  (  2.15%)
> > > > > stress-ng: info:  [37676] load average: 7.69 3.63 2.36
> > > > > stress-ng: info:  [37676] successful run completed in 60.10s (1 min,
> > > > > 0.10 secs)
> > > > > 
> > > > > The bogo ops/s (real time) did drop significantly.
> > > > > 
> > > > > And the memory reclaimation was not triggered in the whole process. so
> > > > > theoretically no one is in the read critical section of shrinker_srcu.
> > > > > 
> > > > > Then I found that some stress-ng-ramfs processes were in
> > > > > TASK_UNINTERRUPTIBLE state for a long time:
> > > > > 
> > > > > root       42313  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42314  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42315  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42316  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42317  7.8  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42318  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42319  7.8  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42320  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42321  7.8  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42322  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42323  7.8  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42324  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42325  7.8  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42326  0.0  0.0  69592  2068 pts/0    S    19:00   0:00
> > > > > stress-ng-ramfs [run]
> > > > > root       42327  7.9  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42328  7.9  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42329  7.9  0.0  69592  1812 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > root       42330  7.9  0.0  69592  1556 pts/0    D    19:00   0:02
> > > > > stress-ng-ramfs [run]
> > > > > 
> > > > > Their call stack is as follows:
> > > > > 
> > > > > cat /proc/42330/stack
> > > > > 
> > > > > [<0>] __synchronize_srcu.part.21+0x83/0xb0
> > > > > [<0>] unregister_shrinker+0x85/0xb0
> > > > > [<0>] deactivate_locked_super+0x27/0x70
> > > > > [<0>] cleanup_mnt+0xb8/0x140
> > > > > [<0>] task_work_run+0x65/0x90
> > > > > [<0>] exit_to_user_mode_prepare+0x1ba/0x1c0
> > > > > [<0>] syscall_exit_to_user_mode+0x1b/0x40
> > > > > [<0>] do_syscall_64+0x44/0x80
> > > > > [<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > 
> > > > > + RCU folks, Is this result as expected? I would have thought that
> > > > > synchronize_srcu() should return quickly if no one is in the read
> > > > > critical section. :(
> > 
> > In theory, it would indeed be nice if synchronize_srcu() would do that.
> > In practice, the act of checking to see if there is anyone in an SRCU
> > read-side critical section is a heavy-weight operation, involving at
> > least one cache miss per CPU along with a number of full memory barriers.
> > 
> > So SRCU has to be careful to not check too frequently.
> 
> Got it.
> 
> > 
> > However, if SRCU has been idle for some time, normal synchronize_srcu()
> > will do an immediate check.  And this will of course mark SRCU as
> > non-idle.
> > 
> > > > With the following changes, ops/s can return to previous levels:
> > > 
> > > Or just set rcu_expedited to 1:
> > > 	echo 1 > /sys/kernel/rcu_expedited
> > 
> > This does cause SRCU to be much more aggressive.  This can be a good
> > choice for small systems, but please keep in mind that this affects normal
> > RCU as well as SRCU.  It will cause RCU to also be much more aggressive,
> > sending IPIs to CPUs that are (or might be) in RCU read-side critical
> > sections.  Depending on your workload, this might or might not be what
> > you want RCU to be doing.  For example, if you are running aggressive
> > real-time workloads, it most definitely is not what you want.
> 
> Yeah, that's not what I want, a shrinker might run for a long time.
> 
> > 
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index db2ed6e08f67..90f541b07cd1 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -763,7 +763,7 @@ void unregister_shrinker(struct shrinker *shrinker)
> > > >           debugfs_entry = shrinker_debugfs_remove(shrinker);
> > > >           up_write(&shrinker_rwsem);
> > > > 
> > > > -       synchronize_srcu(&shrinker_srcu);
> > > > +       synchronize_srcu_expedited(&shrinker_srcu);
> > 
> > If shrinkers are unregistered only occasionally, this is an entirely
> > reasonable change.
> > 
> > > >           debugfs_remove_recursive(debugfs_entry);
> > > > 
> > > > stress-ng: info:  [13159] dispatching hogs: 9 ramfs
> > > > stress-ng: info:  [13159] stressor       bogo ops real time  usr time
> > > > sys time   bogo ops/s     bogo ops/s
> > > > stress-ng: info:  [13159]                           (secs)    (secs)
> > > > (secs)   (real time) (usr+sys time)
> > > > stress-ng: info:  [13159] ramfs            710062     60.00      9.63
> > > > 157.26     11834.18        4254.75
> > > > stress-ng: info:  [13159] for a 60.00s run time:
> > > > stress-ng: info:  [13159]    1920.14s available CPU time
> > > > stress-ng: info:  [13159]       9.62s user time   (  0.50%)
> > > > stress-ng: info:  [13159]     157.26s system time (  8.19%)
> > > > stress-ng: info:  [13159]     166.88s total time  (  8.69%)
> > > > stress-ng: info:  [13159] load average: 9.49 4.02 1.65
> > > > stress-ng: info:  [13159] successful run completed in 60.00s (1 min,
> > > > 0.00 secs)
> > > > 
> > > > Can we make synchronize_srcu() call synchronize_srcu_expedited() when no
> > > > one is in the read critical section?
> > 
> > Yes, in theory we could, but this would be a bad thing in practice.
> > After all, the point of having synchronize_srcu() be separate from
> > synchronize_srcu_expedited() is to allow uses that are OK with longer
> > latency avoid consuming too much CPU.  In addition, that longer
> > SRCU grace-period latency allows the next grace period to handle more
> > synchronize_srcu() and call_srcu() requests.  This amortizes the
> > overhead of that next grace period over a larger number of updates.
> > 
> > However, your use of synchronize_srcu_expedited() does have that effect,
> > but only for this call point.  Which has the advantage of avoiding
> > burning excessive quantities of CPU for the other 50+ call points.
> 
> Thanks for such a detailed explanation.
> 
> Now I think we can continue to try to complete the idea[1] from
> Kirill Tkhai. The patch moves heavy synchronize_srcu() to delayed
> work, so it doesn't affect on user-visible unregistration speed.
> 
> [1]. https://lore.kernel.org/lkml/153365636747.19074.12610817307548583381.stgit@localhost.localdomain/

A blast from the past!  ;-)

But yes, moving the long-latency synchronize_srcu() off the user-visible
critical code path can be even better.

							Thanx, Paul
