Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1E6897B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBCL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjBCL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:27:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80A2953FE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fe00gUO64tWqmWeMTAQN2xyY16z2zsqc7VdaC5m0adc=; b=KwSyuBJac1Mrgqhm69oD1VBOL8
        obyT/+bUUYqTkIMGWPgqoD5h+bRE12fX83cd6Jj4f1rcA+rm7aTbkPRnQkPBcYiG/4M2kl5h8jYbj
        MrVpT9KFLRqipaWcycpX8P2uWJZZ1X5lmXGRo//oPjghMB8GxBZMcmiM1RzFlekuhhvU4VSkudL+Q
        iNzKF8+khzXJ64FB5ovdRLE+NEmqlOPWXyRF6UwtKR4LU3m23eawQuFpUNaMyQAeUYrSztWbEtQbL
        /caQWxEkg4+RfI0B+H2uPH+kjVIl8Lmen+WlWb9YHOftL0uuQ8on0T5UMKv02MAy7ySSK9VihAv3t
        iV7mdG8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNuDQ-005UiC-0J;
        Fri, 03 Feb 2023 11:26:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D82330012F;
        Fri,  3 Feb 2023 12:27:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69BB5212BDE63; Fri,  3 Feb 2023 12:27:23 +0100 (CET)
Date:   Fri, 3 Feb 2023 12:27:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Message-ID: <Y9zvm4aB2B412drn@hirez.programming.kicks-ass.net>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:15:48PM +0100, Peter Zijlstra wrote:

> > +static inline void vma_set_active_pid_bit(struct vm_area_struct *vma)
> > +{
> > +	unsigned int active_pid_bit;
> > +
> > +	if (vma->numab) {
> > +		active_pid_bit = current->pid % BITS_PER_LONG;
> > +		vma->numab->accessing_pids |= 1UL << active_pid_bit;
> > +	}
> > +}
> 
> Perhaps:
> 
> 	if (vma->numab)
> 		__set_bit(current->pid % BITS_PER_LONG, &vma->numab->pids);
> 
> ?
> 
> Or maybe even:
> 
> 	bit = current->pid % BITS_PER_LONG;
> 	if (vma->numab && !__test_bit(bit, &vma->numab->pids))
> 		__set_bit(bit, &vma->numab->pids);
> 

The alternative to just taking the low n bits is to use:

  hash_32(current->pid, BITS_PER_LONG)

That mixes things up a bit.
