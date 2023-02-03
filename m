Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274DD6897CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBCLgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjBCLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:35:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C22915F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HYvSJM1T50UTS1OQgzplPNLCiUTfOsC4WSC7CRDxRUA=; b=bhBSv0ck9qrD4exufh1Qc0LScG
        IHQP656RBMwDwwz84DYxboCM22EgrTsUf1lkmRgZYw3HUZXybZLF1w1+1N4futidQYdUBHkWfoCGj
        /5Hdr6N/I9GUIORP+lLTBeV3TD2GHEbh0GN/6hhSC0ccRqskhCMccrVh4zKwLVZrY3BNffP+FZpGq
        87CCRAiwZchtgjTP0qt9FGqPKVIjuMnc+MS0PBK5548saCPCdUunM5KkC8MUZ8RoTS2Z0muEKMz8o
        wujk8jWVYUh5/Pg6Dzeg2cueXPMmgB+7w62gj6GQ7P6kQ58x5y14/ic3ULT0uJeoxDEuT/5MERdf6
        bgVrX19g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNuM5-00EGoj-Sc; Fri, 03 Feb 2023 11:35:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12A143003E1;
        Fri,  3 Feb 2023 12:35:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 044D2212BDE63; Fri,  3 Feb 2023 12:35:45 +0100 (CET)
Date:   Fri, 3 Feb 2023 12:35:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [PATCH V2 3/3] sched/numa: Reset the accessing PID information
 periodically
Message-ID: <Y9zxkGf50bqkucum@hirez.programming.kicks-ass.net>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <b0f273113fedffb02f9b1358c88813ff355a81d6.1675159422.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f273113fedffb02f9b1358c88813ff355a81d6.1675159422.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:32:22PM +0530, Raghavendra K T wrote:

> 2) Maintain duplicate list of accessing PIDs to keep track of history of access. and switch/reset. use OR operation during iteration
> 
>  Two lists of PIDs maintained. At regular interval old list is reset and we make current list as old list
> At any point of time tracking of PIDs accessing VMA is determined by ORing list1 and list2  
> 
> accessing_pids_list1 <-  current list
> accessing_pids_list2 <-  old list

( I'm not sure why you think this part of the email doesn't need to be
  nicely wrapped at 76 chars.. )

This seems simple enough to me and can be trivially extended to N if
needed.

The typical implementation would looks something like:

	unsigned long pids[N];
	unsigned int pid_idx;

set:
	unsigned long *pids = numab->pids + pid_idx;
	if (!__test_bit(bit, pids))
		__set_bit(bit, pids);

test:
	unsigned long pids = 0;
	for (int i = 0; i < N; i++)
		pids |= numab->pids[i];
	return __test_bit(bit, &pids);

rotate:
	idx = READ_ONCE(numab->pid_idx);
	WRITE_ONCE(numab->pid_idx, (idx + 1) % N);
	numab->pids[idx] = 0;

Note the actual rotate can be simplified to ^1 for N:=2.
