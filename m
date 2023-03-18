Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978156BF8D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCRIFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCRIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:05:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC02F07D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:04:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B341B21ACB;
        Sat, 18 Mar 2023 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679126679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joBQbNC8bn1uR7n71TdJ8U6+++2L30U1m3muXQOtw3k=;
        b=KXmuWl60DEFYNotlYguYEgdjzikPvuqnIN81zhI5GK3WyBDDKDwCwpqmU5IhDoII0Vkmu6
        a7H3svZPc0fEKzMM9+cQDBa3yxwqOpY1/UYXOuz9tNAVTpTkhFuFhlzABfYhYwOlq5I/fz
        cVK59///umtvvC/hfTtOQvg4erniMXM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91DED13A00;
        Sat, 18 Mar 2023 08:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id toKqIJdwFWS8OQAAMHmgww
        (envelope-from <mhocko@suse.com>); Sat, 18 Mar 2023 08:04:39 +0000
Date:   Sat, 18 Mar 2023 09:04:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <fweisbecker@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBSy2QZYZRtCNBd8@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-03-23 15:35:05, Marcelo Tosatti wrote:
> On Fri, Mar 17, 2023 at 03:33:13PM -0300, Marcelo Tosatti wrote:
> > On Fri, Mar 17, 2023 at 02:44:47PM +0100, Michal Hocko wrote:
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > Provide this new API to check if a CPU has been isolated either through
> > > isolcpus= or nohz_full= kernel parameter.
> > > 
> > > It aims at avoiding kernel load deemed to be safely spared on CPUs
> > > running sensitive workload that can't bear any disturbance, such as
> > > pcp cache draining.
> > 
> > Hi Michal,
> > 
> > This makes no sense to me.
> > 
> > HK_TYPE_DOMAIN is set when isolcpus=domain is configured.
> > HK_TYPE_TICK is set when nohz_full= is configured.
> > 
> > The use-cases i am aware of use either:
> > 
> > isolcpus=managed_irq,... nohz_full=
> > OR
> > isolcpus=domain,managed_irq,... nohz_full=
> > 
> > So what is the point of this function again?
> > 
> > Perhaps it made sense along with, but now does not make sense
> > anymore:
> > 
> > Subject: [PATCH 1/2] sched/isolation: Merge individual nohz_full features into a common housekeeping flag
> > 
> > The individual isolation features turned on by nohz_full were initially
> > split in order for each of them to be tunable through cpusets. However
> > plans have changed in favour of an interface (be it cpusets or sysctl)
> > grouping all these features to be turned on/off altogether. Then should
> > the need ever arise, the interface can still be expanded to handle the
> > individual isolation features.
> > 
> > But Michal can just use housekeeping_test_cpu(cpu, HK_TYPE_TICK) and
> > the convertion of nohz_full features into a common housekeeping flag
> > can convert that to something else later?
> 
> Actually introducing cpu_is_isolated() seems fine, but it can call
> housekeeping_test_cpu(cpu, HK_TYPE_TICK) AFAICS.
 
This is not really my area. Frederic, could you have a look please?

-- 
Michal Hocko
SUSE Labs
