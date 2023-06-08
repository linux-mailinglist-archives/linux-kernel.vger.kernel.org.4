Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231C7286E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjFHSIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFHSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:08:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4118C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:08:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A8B41FD5F;
        Thu,  8 Jun 2023 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686247679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuVHWqF+Vmzlt+SUW4g6KuATrBuHpEsTJNICe6iwrHc=;
        b=DzKX09a3MIGcFGy/bs4aXveZ1NRbWdFmwIJGNRB9beMcnjg3/3rQybTWLiKEEr28ctuSsN
        ofr/NTBppLIfWVTmFNXZUx46CdJL0xK3Ddwm+KTSFVGpAx9e/RlIfnXRLns9g3ObZty3iL
        f+CdUzcXf1FewvV7CQfhmUyhAGPfQQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686247679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuVHWqF+Vmzlt+SUW4g6KuATrBuHpEsTJNICe6iwrHc=;
        b=Gzs5/PuXubrvgfiZMpux40aW3clbzJ70xqZmpsjIQJjGKctEyd1ZInHwX45CvkQBIAO0YA
        iK5xiXdJ0Q+vtKAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C8C6138E6;
        Thu,  8 Jun 2023 18:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QcinEv8YgmSBYQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Jun 2023 18:07:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD23BA0749; Thu,  8 Jun 2023 20:07:58 +0200 (CEST)
Date:   Thu, 8 Jun 2023 20:07:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.cz,
        vbabka@suse.cz, regressions@lists.linux.dev,
        Yu Ma <yu.ma@intel.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Message-ID: <20230608180758.z4z4ijdjgfe4mbx4@quack3>
References: <20221024052841.3291983-1-shakeelb@google.com>
 <20230608111408.s2minsenlcjow7q3@quack3>
 <20230608173700.wafw5tyw52gwoicu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608173700.wafw5tyw52gwoicu@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-06-23 17:37:00, Shakeel Butt wrote:
> On Thu, Jun 08, 2023 at 01:14:08PM +0200, Jan Kara wrote:
> [...]
> > 
> > Somewhat late to the game but our performance testing grid has noticed this
> > commit causes a performance regression on shell-heavy workloads. For
> > example running 'make test' in git sources on our test machine with 192
> > CPUs takes about 4% longer, system time is increased by about 9%:
> > 
> >                        before (9cd6ffa6025)  after (f1a7941243c1)
> > Amean     User         471.12 *   0.30%*     481.77 *  -1.96%*
> > Amean     System       244.47 *   0.90%*     269.13 *  -9.09%*
> > Amean     Elapsed      709.22 *   0.45%*     742.27 *  -4.19%*
> > Amean     CPU          100.00 (   0.20%)     101.00 *  -0.80%*
> > 
> > Essentially this workload spawns in sequence a lot of short-lived tasks and
> > the task startup + teardown cost is what this patch increases. To
> > demonstrate this more clearly, I've written trivial (and somewhat stupid)
> > benchmark shell_bench.sh:
> > 
> > for (( i = 0; i < 20000; i++ )); do
> > 	/bin/true
> > done
> > 
> > And when run like:
> > 
> > numactl -C 1 ./shell_bench.sh
> > 
> > (I've forced physical CPU binding to avoid task migrating over the machine
> > and cpu frequency scaling interfering which makes the numbers much more
> > noisy) I get the following elapsed times:
> > 
> >          9cd6ffa6025    f1a7941243c1
> > Avg      6.807429       7.631571
> > Stddev   0.021797       0.016483
> > 
> > So some 12% regression in elapsed time. Just to be sure I've verified that
> > per-cpu allocator patch [1] does not improve these numbers in any
> > significant way.
> > 
> > Where do we go from here? I think in principle the problem could be fixed
> > by being clever and when the task has only a single thread, we don't bother
> > with allocating pcpu counter (and summing it at the end) and just account
> > directly in mm_struct. When the second thread is spawned, we bite the
> > bullet, allocate pcpu counter and start with more scalable accounting.
> > These shortlived tasks in shell workloads or similar don't spawn any
> > threads so this should fix the regression. But this is obviously easier
> > said than done...
> > 
> 
> Thanks Jan for the report. I wanted to improve the percpu allocation to
> eliminate this regression as it was reported by intel test bot as well.
> However your suggestion seems seems targetted and reasonable as well. At
> the moment I am travelling, so not sure when I will get to this. Do you
> want to take a stab at it or you want me to do it? Also how urgent and
> sensitive this regression is for you?

It is not really urgent but eventually we'd like to get this fixed (like
within couple of months). I have currently other stuff in progress so if
you could get to it, it would be nice, otherwise I should be able to look
into this in a week or two.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
