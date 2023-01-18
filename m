Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487DF6724D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjARR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjARR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:27:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EEC14E88
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:27:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1F075C1A3;
        Wed, 18 Jan 2023 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674062822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rme+J37+1wmMiSJN3/9qvxJPCETZuXLtzu0rIV+DCE8=;
        b=VOl8M1j32fEoQROZKP5BX8QEun+ys6lASiBkTNut3VHnQ5gytED+kNqLXQ8AXr80REuxuE
        sr6rKatScGFv0ZxEpATvIo3ZdlnRVbhEKkNiHTpkva1q4U1TQZpUqSyrHgFoZAsMhCUF1F
        Kg9T70eKwktop3KAf+Z8ED/w9V0qBLo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8914F139D2;
        Wed, 18 Jan 2023 17:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b/WJHuYryGOdSAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 17:27:02 +0000
Date:   Wed, 18 Jan 2023 18:27:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Message-ID: <Y8gr5haAMtQJJSR6@dhcp22.suse.cz>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117231632.2734737-3-minchan@kernel.org>
 <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
 <Y8gpNgkwMqVPN7dm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gpNgkwMqVPN7dm@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 09:15:34, Minchan Kim wrote:
> On Wed, Jan 18, 2023 at 10:11:46AM +0100, Michal Hocko wrote:
> > On Tue 17-01-23 15:16:32, Minchan Kim wrote:
> > > madvise LRU manipulation APIs need to scan address ranges to find
> > > present pages at page table and provides advice hints for them.
> > > 
> > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > shows the proactive reclaim efficiency so this patch addes those
> > > two statistics in vmstat.
> > 
> > Please describe the usecase for those new counters.
> 
> I wanted to know the proactive reclaim efficieny using MADV_COLD/MDDV_PAGEOUT.
> Userspace has several policy which when/which vmas need to be hinted by the call
> and they are evolving. I needed to know how effectively their policy works since
> the vma ranges are huge(i.e., nr_hinted/nr_scanned).

I can see how that can be an interesting information but is there
anything actionable about that beyond debugging purposes? In other words
isn't this something that could be done by tracing instead?

Also how are you going to identify specific madvise calls when they can
interleave arbitrarily?

-- 
Michal Hocko
SUSE Labs
