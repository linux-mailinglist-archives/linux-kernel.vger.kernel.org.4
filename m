Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFB6B93E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCNMek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCNMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:34:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634F637DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:34:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E723721A7A;
        Tue, 14 Mar 2023 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678796753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zfLpT7hdLdE3kG/mQnDxvbrMCXCopNqVUMzvG7Y9T8=;
        b=rsdLN5ilHTbzv21f1Wx+6gLpDof3nwrEUJLpwa2BEykTDXfcEjeij80pJ0spDrnUBvEKr8
        iD6ObV48rgPH3qRLfFp29rsRTQupuy4EP19wyuq3JJRkdz3NbAsjVtovmCS7kxKKzuorro
        ekcXIZUL0/2sOCo/G63uA17f9QRAQGw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D602813A26;
        Tue, 14 Mar 2023 12:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SftwM9FnEGRaVQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Mar 2023 12:25:53 +0000
Date:   Tue, 14 Mar 2023 13:25:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 00/12] fold per-CPU vmstats remotely
Message-ID: <ZBBn0evSQeuiNna4@dhcp22.suse.cz>
References: <20230313162507.032200398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313162507.032200398@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-03-23 13:25:07, Marcelo Tosatti wrote:
> This patch series addresses the following two problems:
> 
>     1. A customer provided some evidence which indicates that
>        the idle tick was stopped; albeit, CPU-specific vmstat
>        counters still remained populated.
> 
>        Thus one can only assume quiet_vmstat() was not
>        invoked on return to the idle loop. If I understand
>        correctly, I suspect this divergence might erroneously
>        prevent a reclaim attempt by kswapd. If the number of
>        zone specific free pages are below their per-cpu drift
>        value then zone_page_state_snapshot() is used to
>        compute a more accurate view of the aforementioned
>        statistic.  Thus any task blocked on the NUMA node
>        specific pfmemalloc_wait queue will be unable to make
>        significant progress via direct reclaim unless it is
>        killed after being woken up by kswapd
>        (see throttle_direct_reclaim())

I have hard time to follow the actual problem described above. Are you
suggesting that a lack of pcp vmstat counters update has led to
reclaim issues? What is the said "evidence"? Could you share more of the
story please?

>     2. With a SCHED_FIFO task that busy loops on a given CPU,
>        and kworker for that CPU at SCHED_OTHER priority,
>        queuing work to sync per-vmstats will either cause that
>        work to never execute, or stalld (i.e. stall daemon)
>        boosts kworker priority which causes a latency
>        violation

Why is that a problem? Out-of-sync stats shouldn't cause major problems.
Or can they?

Thanks!
-- 
Michal Hocko
SUSE Labs
