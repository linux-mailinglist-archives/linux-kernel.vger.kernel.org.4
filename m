Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6BD73DDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFZLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjFZLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:36:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06502723
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:35:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D18A1F898;
        Mon, 26 Jun 2023 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687779340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5yjlh7t2dHVVBraoSHmCUGOPQgG+BcdKVJI9xyylaX8=;
        b=cH4xcOtv7Yr0d7bOW5jXEdf7ghUZJQse/1knIS9JBIDZBCaACgjvlI934NgpqNseQXZOd9
        flSxVvGHZuMRupc5h7tF0be1GiQK47CDKm/rSyBabbguA139nyrfCjoMi90vemEfXbStez
        7zB4MXym+7PjEpnmDyqwtFVep2NPbCw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A25713483;
        Mon, 26 Jun 2023 11:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x2IKDAx4mWTILwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 26 Jun 2023 11:35:40 +0000
Date:   Mon, 26 Jun 2023 13:35:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <ZJl4C7aVk3gLLyMs@dhcp22.suse.cz>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
 <20230626104831.GT4253@hirez.programming.kicks-ass.net>
 <3a4ad958-a9a5-c367-a16d-bd89a173a628@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a4ad958-a9a5-c367-a16d-bd89a173a628@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-06-23 20:26:02, Tetsuo Handa wrote:
> On 2023/06/26 19:48, Peter Zijlstra wrote:
> > On Mon, Jun 26, 2023 at 06:25:56PM +0900, Tetsuo Handa wrote:
> >> On 2023/06/26 17:12, Sebastian Andrzej Siewior wrote:
> >>> On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
> >>>> Why not to do the same on the end side?
> >>>>
> >>>>  static inline void do_write_seqcount_end(seqcount_t *s)
> >>>>  {
> >>>> - 	seqcount_release(&s->dep_map, _RET_IP_);
> >>>>  	do_raw_write_seqcount_end(s);
> >>>> +	seqcount_release(&s->dep_map, _RET_IP_);
> >>>>  }
> >>>
> >>> I don't have a compelling argument for doing it. It is probably better
> >>> to release the lock from lockdep's point of view and then really release
> >>> it (so it can't be acquired before it is released).
> >>
> >> We must do it because this is a source of possible printk() deadlock.
> >> Otherwise, I will nack on PATCH 2/2.
> > 
> > Don't be like that... just hate on prink like the rest of us. In fact,
> > i've been patching out the actual printk code for years because its
> > unusable garbage.
> > 
> > Will this actually still be a problem once all the fancy printk stuff
> > lands? That shouldn't do synchronous prints except to 'atomic' consoles
> > by default IIRC.
> 
> Commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq
> seqlock") was applied to 4.14-stable trees, and CONFIG_PREEMPT_RT is available
> since 5.3. Thus, we want a fix which can be applied to 5.4-stable and later.
> This means that we can't count on all the fancy printk stuff being available.

Is there any reason to backport RT specific fixup to stable trees? I
mean seriously, is there any actual memory hotplug user using
PREEMPT_RT? I would be more than curious to hear the usecase.

-- 
Michal Hocko
SUSE Labs
