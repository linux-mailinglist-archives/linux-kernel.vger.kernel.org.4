Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A46B28F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCIPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCIPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:39:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC22AE2776
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xvB/naRoyLGV4ZaygDeiI3tROuzOiLJV/rJsU/6xWCM=; b=I0NaxsRJKYLpeIYDhulCC2BJ5d
        nUtQIgiKsdONvmqhQgu/zB28TKgLuTv1D5IyNReq87bH8F3xPEwEFGjkKsMCBvybnuFz0vU/USZOE
        NQg/GJjiiRM7IowPpJDfJpsaDTVHq0rKuNc8oFQ4GSB8P4twzw5PV/IaLBW+K7TD3WNLOQ5GGZAFB
        g/91PVbGX4U3WQlte8v3d8mhvEvX7WZOxCsk+fWPJsPXlMhe98EzWg07GTWllMgdjNQruSHqhy5h+
        tMYKHZVM4dueMP8ofRGzuDHkQvJyoS6iF2Ys3qzy+lHqPRP+DxqF5/Vj9lSwvC88P6A3g7EV2CbxL
        nvXd4dTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1paIMF-0009iv-0e;
        Thu, 09 Mar 2023 15:39:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7516930030B;
        Thu,  9 Mar 2023 16:39:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AAC72CE67A5E; Thu,  9 Mar 2023 16:39:05 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:39:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
Message-ID: <ZAn9mfs0qgPtBr0r@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.810909205@infradead.org>
 <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
 <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
 <20230309090633.GK2017917@hirez.programming.kicks-ass.net>
 <ZAnUnSEJ92bKpim7@hirez.programming.kicks-ass.net>
 <ZAn7QAjQvw5q6aI5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAn7QAjQvw5q6aI5@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:29:04PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 09, 2023 at 01:44:13PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 09, 2023 at 10:06:33AM +0100, Peter Zijlstra wrote:
> > > Hi Mike!
> > > 
> > > On Wed, Mar 08, 2023 at 02:36:01PM +0100, Mike Galbraith wrote:
> > > > On Wed, 2023-03-08 at 09:39 +0100, Mike Galbraith wrote:
> > > > >
> > > > > Curiosity got the best of me...
> > > > 
> > > > Remember this little bugger, allegedly distilled from a real
> > > > application control thread starvation issue?
> > > 
> > > Oooh, yeah, I should still have that somewhere. I'll try and remember
> > > what exactly was needed to make it behave properly.
> > 
> > That thing wants both wakeup preemption and sleeper bonus. Specifically,
> > it needs the signal to insta-preempt the 'pointless' kill loop.
> > 
> > What happens is that while positive lag, we get this, when negative lag
> > happens wakeup-preemption is not achieved and we get delayed by a full
> > tick.
> > 
> > This gets us very little actual runtime.
> > 
> > Let me see what do do about that...
> 
> So if I add TICK_NSEC based sleeper bonus (/2 for gentle), then starve
> works -- this is the absolutely minimal amount required. It sucks a bit
> it's HZ dependent, but alas.
> 
> Also, the whole sleeper bonus gets us back into needing to track the old
> vruntime and the overflow crap for super long sleeps and all that fugly
> :/ I was so hoping we could delete that code.
> 
> Oh well.
> 
> (also, did you know that removing the debug cruft helps with running
> numbers? ;-)

Also, it helps to turn the sched_feat on... clearly i should be calling
it a day.
