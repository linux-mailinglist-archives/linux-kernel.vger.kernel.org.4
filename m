Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA963688128
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjBBPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjBBPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:07:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D19219F;
        Thu,  2 Feb 2023 07:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB82B826A8;
        Thu,  2 Feb 2023 15:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A96C4339B;
        Thu,  2 Feb 2023 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675350445;
        bh=YeJE6uZ37bJcmTAbr8/Yu8hgf1dLf5Sq3hNz8iQtYCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NzYP42QpCsIW/Q0SYpv4K5ROZwtkSX236NePhvmcpu2Yu+Jsh26Z8Ku7q2j3sKFDn
         fSzqVTFcYsKoludKJWAMpfyTstIqp8us2agp5xCD6ZfQhcE87U8BNkjbQAwm6PDN9U
         F+oqQRYtD1P6XE7St6Ui2Hu0m/3LE/4uL1tuFBEKMMMlFxD38Pbp4DwJ+nY+68INY/
         PyMxszvsFlKqfKOGTDwT8Q03CaoAK7QQOZ+i3PiQBAKqCUzwPw7jcHAA4FKio5Zc5z
         YBh0RNhDsWC2CQKDZgOgyT1NsUz5QlNjaS90b6hhRNRAzzDD3yPshnPmHHc56RotRA
         /4Q+iIKI+d+GA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 35B645C0D1A; Thu,  2 Feb 2023 07:07:25 -0800 (PST)
Date:   Thu, 2 Feb 2023 07:07:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 01/13] rcu/kvfree: Add kvfree_rcu_mightsleep() and
 kfree_rcu_mightsleep()
Message-ID: <20230202150725.GW2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-2-urezki@gmail.com>
 <IA1PR11MB6171B7FD584BC5546714379889D69@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6171B7FD584BC5546714379889D69@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 07:54:31AM +0000, Zhuo, Qiuxu wrote:
> > From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Sent: Wednesday, February 1, 2023 11:08 PM
> > To: LKML <linux-kernel@vger.kernel.org>; RCU <rcu@vger.kernel.org>; Paul E .
> > McKenney <paulmck@kernel.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>; Oleksiy Avramchenko
> > <oleksiy.avramchenko@sony.com>; Jens Axboe <axboe@kernel.dk>; Philipp
> > Reisner <philipp.reisner@linbit.com>; Bryan Tan <bryantan@vmware.com>;
> > Steven Rostedt <rostedt@goodmis.org>; Eric Dumazet
> > <edumazet@google.com>; Bob Pearson <rpearsonhpe@gmail.com>; Ariel
> > Levkovich <lariel@nvidia.com>; Theodore Ts'o <tytso@mit.edu>; Julian
> > Anastasov <ja@ssi.bg>
> > Subject: [PATCH 01/13] rcu/kvfree: Add kvfree_rcu_mightsleep() and
> > kfree_rcu_mightsleep()
> > 
> > These two macroses will replace single-argument k[v]free_rcu() ones.
> > By adding an extra _mightsleep prefix we can avoid of situations when someone
> 
> s/prefix/suffix

Good eyes, thank you!

Please see below for the version currently queued in the -rcu tree.

							Thanx, Paul

> > intended to give a second argument but forgot to do it in a code where sleeping
> > is illegal.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ...

------------------------------------------------------------------------

commit d6b54a44de23c83944d042b6f6fd9d19ccd3f1b8
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Feb 1 16:08:07 2023 +0100

    rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()
    
    The kvfree_rcu() and kfree_rcu() APIs are hazardous in that if you forget
    the second argument, it works, but might sleep.  This sleeping can be a
    correctness bug from atomic contexts, and even in non-atomic contexts
    it might introduce unacceptable latencies.  This commit therefore adds
    kvfree_rcu_mightsleep() and kfree_rcu_mightsleep(), which will replace
    the single-argument kvfree_rcu() and kfree_rcu(), respectively.
    
    This commit enables a series of commits that switch from single-argument
    kvfree_rcu() and kfree_rcu() to their _mightsleep() counterparts.  Once
    all of these commits land, the single-argument versions will be removed.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 822ff7b4bb1ed..094321c17e48a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1013,6 +1013,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
+#define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
+
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
