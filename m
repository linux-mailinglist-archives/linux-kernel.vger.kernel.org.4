Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC89679E60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjAXQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:16:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AF303CE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Unn061V4Jao+mFVgczqW4o8yu90bXgPEP/3+texvOEA=; b=YNiTQDTYWVCPebPepGx0EimJI6
        fIaSeIaoEn5Qv9drp8+pbdo11nzel5DZDkJ/zkQHQ5ygCi5YYp3Up0fpfJrB8pk6ebq6QiBuOB5DI
        2Z9UTZ6xHdfNmzdCKARVwpJClmmd27piEPqm+MKKrzKtG+MjluEdsh6UALz6tcaRUrUglc2fvfn1g
        2JcZkrH2ikH6XcewM3Essz6YkHSxdhu+6JjQo2p8xkzcLc0ksFUqACvy32xuSOCP9ohrxO3kD4rv1
        fi1dQ9kuud3gzfluxErCU8vxWBHzZ9nsgMzazdjuzL6wG/TYUSCzp4DExqtx/9XURMnhO8R9lMv0Q
        gsLh1YXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKLyA-005BKV-ND; Tue, 24 Jan 2023 16:16:22 +0000
Date:   Tue, 24 Jan 2023 16:16:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     George Prekas <george@enfabrica.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 9/9] mm: kmemleak: fix undetected leaks for page aligned
 objects
Message-ID: <Y9AEVhNyllqmn0ZH@casper.infradead.org>
References: <20230123170419.7292-1-george@enfabrica.net>
 <20230123170419.7292-10-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123170419.7292-10-george@enfabrica.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:04:19AM -0600, George Prekas wrote:
> If kmalloc returns a page aligned object, then the object has 2
> references: the pointer returned by kmalloc and page->s_mem of the first
> page of the object. Account for this extra reference, so that kmemleak
> can correctly detect leaks for page aligned objects.

Is this true for multi-page slabs?  Imagine if you allocate objects of
size 4kB.  Slab/Slub will allocate slabs of size 32kB and try to
allocate 8 objects from each slab.  Only the first one will have an
s_mem pointing into it.  No?

> -		kmemleak_alloc_recursive(p[i], s->object_size, 1,
> +		min_count = 1;
> +		/* If p[i] is page aligned, then a page->s_mem refers to it. */

Also this comment should read 'slab->s_mem'.  Individual pages within
the slab do not have s_mem pointers, only the slab.

> +		if (((uintptr_t)p[i] & ~PAGE_MASK) == 0)
> +			min_count++;
> +		kmemleak_alloc_recursive(p[i], s->object_size, min_count,
>  					 s->flags, flags);
