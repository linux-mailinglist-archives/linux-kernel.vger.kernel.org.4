Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064756776DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAWI6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjAWI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:58:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7A14EA8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:58:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6A9B1F388;
        Mon, 23 Jan 2023 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674464310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIYcLkIhHoIqMTHU7z0z+ani6y5ft7j45PE+7GKmbjU=;
        b=t56Gdt2YqfMDFP9ycCDdRfCDH0nRp9TEdZr+wahpxuHv9wvnt5U5uEP+aR5NfLD1ItMmGG
        NzRhTiJay4EawlaFHdnsWXwmjmjOeMDvptjwjENxtboarwYhULWQt3CQhuGojFUH5kBNw5
        a9vFx/aDZNwt6NfUbkONweihqx8IENs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B97731357F;
        Mon, 23 Jan 2023 08:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qRweLDZMzmMNZQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 23 Jan 2023 08:58:30 +0000
Date:   Mon, 23 Jan 2023 09:58:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <Y85MNmZDc5czMRUJ@dhcp22.suse.cz>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
 <Y8vSZ+gOFXWDKC8Z@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8vSZ+gOFXWDKC8Z@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 21-01-23 20:54:15, Hyeonggon Yoo wrote:
> On Sat, Jan 21, 2023 at 12:29:44PM +0100, Vlastimil Babka wrote:
> > On 1/21/23 04:39, Hyeonggon Yoo wrote:
> > > In workloads where this_cpu operations are frequently performed,
> > > enabling DEBUG_PREEMPT may result in significant increase in
> > > runtime overhead due to frequent invocation of
> > > __this_cpu_preempt_check() function.
> > > 
> > > This can be demonstrated through benchmarks such as hackbench where this
> > > configuration results in a 10% reduction in performance, primarily due to
> > > the added overhead within memcg charging path.
> > > 
> > > Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
> > > of its potential impact on performance in some workloads.
> > > 
> > > hackbench-process-sockets
> > > 		      debug_preempt	 no_debug_preempt
> > > Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
> > > Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
> > > Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
> > > Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
> > > Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
> > > Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
> > > Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
> > > Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
> > > Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*

Do you happen to have any perf data collected during those runs? I
would be interested in the memcg side of things. Maybe we can do
something better there.
-- 
Michal Hocko
SUSE Labs
