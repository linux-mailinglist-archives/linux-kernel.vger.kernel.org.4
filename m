Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62501672A25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjARVPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjARVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:14:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C453E4B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:13:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3EBD5C332;
        Wed, 18 Jan 2023 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674076418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89f0PyHMTcU1wP4oLEjhhdUSmrRlYKAe9wYRnXUS3o8=;
        b=XI5WJWm7SzfxR1z66yjeCcGNGrLMKHRuO2AR/iADQPTSG42FHZpSIgrQBXanf5uhucK3uD
        EMJFapFzmsgYIJ6B4FvK3t6HZqb6Dg6bKpC9qxHhieWRETt8hbSEn0+goojAVwIuimog9U
        4it1d/VWddMXDsvoZ5zNb1APWwJmmBE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A823D139D2;
        Wed, 18 Jan 2023 21:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jvHDJgJhyGOxMQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 21:13:38 +0000
Date:   Wed, 18 Jan 2023 22:13:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Message-ID: <Y8hhAslIzgNH3hzv@dhcp22.suse.cz>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117231632.2734737-3-minchan@kernel.org>
 <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
 <Y8gpNgkwMqVPN7dm@google.com>
 <Y8gr5haAMtQJJSR6@dhcp22.suse.cz>
 <Y8gympFAnomQePGD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gympFAnomQePGD@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 09:55:38, Minchan Kim wrote:
> On Wed, Jan 18, 2023 at 06:27:02PM +0100, Michal Hocko wrote:
> > On Wed 18-01-23 09:15:34, Minchan Kim wrote:
> > > On Wed, Jan 18, 2023 at 10:11:46AM +0100, Michal Hocko wrote:
> > > > On Tue 17-01-23 15:16:32, Minchan Kim wrote:
> > > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > > present pages at page table and provides advice hints for them.
> > > > > 
> > > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > > shows the proactive reclaim efficiency so this patch addes those
> > > > > two statistics in vmstat.
> > > > 
> > > > Please describe the usecase for those new counters.
> > > 
> > > I wanted to know the proactive reclaim efficieny using MADV_COLD/MDDV_PAGEOUT.
> > > Userspace has several policy which when/which vmas need to be hinted by the call
> > > and they are evolving. I needed to know how effectively their policy works since
> > > the vma ranges are huge(i.e., nr_hinted/nr_scanned).
> > 
> > I can see how that can be an interesting information but is there
> > anything actionable about that beyond debugging purposes? In other words
> > isn't this something that could be done by tracing instead?
> 
> That's the statictis for telemetry. With those stat, we are collecting
> various vmstat fields(i.e., pgsteal/pgscan) from real field devices
> and thought those two stats would be good fit along with other reclaim
> statistics in vmstat since we can know how much proactive madvise policy
> could make system healthier(e.g., less kswapd scan, less allocstall
> and so on).
> 
> > 
> > Also how are you going to identify specific madvise calls when they can
> > interleave arbitrarily?
> 
> I guess you are talking about how we could separate MADV_PAGEOUT and
> MADV_COLD from vmstat. That's valid question. I thought for the start,
> adds just umbrella stat like this and if we want to break down, we need
> to introudce sysfs likewise slab. 

No, not really. MADV_COLD is about aging. There is no actual reclaim
going on so pgscan/steal metrics do not make any sense. I am asking
about potential different concurrent MADV_PAGEOUT happening. From what
you've said earlier (how effectively policy works) I have understood you
want to find out how a specific MADV_PAGEOUT effective is. But there
maybe different callers of this applied to all sorts of different memory
mappings and therefore the efficiency might be really different. As
there is no clear way to tell one from the other I am really questioning
whether this global stat is actually useful.

-- 
Michal Hocko
SUSE Labs
