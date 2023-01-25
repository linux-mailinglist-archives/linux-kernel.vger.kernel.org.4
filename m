Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E412567B7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjAYRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjAYRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:08:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2D366AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:08:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C5C721C87;
        Wed, 25 Jan 2023 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674666421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7Ju2TighrFIcVxjh+s1qto4imNLUIwLW2Cvl9ClH/c=;
        b=mERbHiW3P/FkBgADmDFMb3EIyG+9ELTNSjsHkg2ww9hD2EYeRufEt5MgdhgbLBrCPxKiYc
        QcCRd5KunNq16r6rhn3/xfCygB8tvnR1+nW/vMEooieGQo+mKor0/fGwGD7f3r4Hm4EF+i
        XiG8HGWhufcJabdDDaEI5WiNWYwc6E8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57C791358F;
        Wed, 25 Jan 2023 17:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pVeAErVh0WNuJAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 17:07:01 +0000
Date:   Wed, 25 Jan 2023 18:07:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FacrcUIaLZq4DL@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-01-23 08:36:02, Minchan Kim wrote:
> On Wed, Jan 25, 2023 at 09:04:16AM +0100, Michal Hocko wrote:
> > On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> > > madvise LRU manipulation APIs need to scan address ranges to find
> > > present pages at page table and provides advice hints for them.
> > > 
> > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > shows the proactive reclaim efficiency so this patch adds those
> > > two statistics in vmstat.
> > > 
> > > 	madvise_pgscanned, madvise_pghinted
> > > 
> > > Since proactive reclaim using process_madvise(2) as userland
> > > memory policy is popular(e.g,. Android ActivityManagerService),
> > > those stats are helpful to know how efficiently the policy works
> > > well.
> > 
> > The usecase description is still too vague. What are those values useful
> > for? Is there anything actionable based on those numbers? How do you
> > deal with multiple parties using madvise resp. process_madvise so that
> > their stats are combined?
> 
> The metric helps monitoing system MM health under fleet and experimental
> tuning with diffrent policies from the centralized userland memory daemon.

That is just too vague for me to imagine anything more specific then, we
have numbers and we can show them in a report. What does it actually
mean that madvise_pgscanned is high. Or that pghinted / pgscanned is
low (that you tend to manually reclaim sparse mappings)?

> That's really good fit under vmstat along with other MM metrics.
> 
> > 
> > In the previous version I have also pointed out that this might be
> > easily achieved by tracepoints. Your counterargument was a convenience
> > in a large scale monitoring without going much into details. Presumably
> > this is because your fleet based monitoring already collects
> > /proc/vmstat while tracepoints based monitoring would require additional
> > changes. This alone is rather weak argument to be honest because
> > deploying tracepoints monitoring is quite trivial and can be done
> > outside of the said memory reclaim agent.
> 
> The convenience matters but that's not my argument. 
> 
> Ithink using tracepoint for system metric makes no sense even though
> the tracepoint could be extended by using bpf or histogram trigger to
> get the accumulated counters for system metric.

System wide metrics data collection by ftrace is a common use case. I
really do not follow your argument here. There are certainly cases where
ftrace is suboptimal solution - e.g. when the cumulative data couldn't
have been collected early on for one reason or another (e.g. system
uptime is already high when you decide to start collecting). But you
have stated there is data collection happening so what does prevent
collecting this just along with anything else.
 
> The tracepoint is the next step if we want to know further breakdown
> once something strange happens. That's why we have separate level metric
> system to narrow problem down rather than implementing all the metric
> with tracepoint. Please, look at vmstat fields. Almost every fields
> would have same question you asked "how do you break down if multiple
> processes were invovled to contribute the metric?"

Yes, we tended to be much more willing to add counters. Partly because
runtime debugging capabilities were not that great in the past as we
have these days.

> I am fine if you suggest adding tracepoint as well as the vmstat fields
> for further breakdown but only relying on tracepoint and frineds for
> system global metric doesn't make sense.

We have to agree to disagree here. I am not going to nack this but I
disagree with this patch because the justification is just too vague and
also those numbers cannot really be attributed to anybody performing
madvise to actually evaluate that activity.
-- 
Michal Hocko
SUSE Labs
