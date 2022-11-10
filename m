Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6683A6246BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKJQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKJQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:20:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631F1AD85
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x+QCdRZ/JfoXhX+rWKt8rf0Poetyt6zzg0FgqSCk/4E=; b=rW1N/RwPBsMIKgFZJxtvG9cGpW
        3LC2lY5EWKeVQIrq03W5q23NQDuNi4ggOO9Bi9h15RwmePBdhWG1BqMTNa2rdt0jGuEwWCEq//MsS
        CQzT9T6xaaqpfVmQuInWqWSIpgKctL+tfaPqX+lFNqhkWLIlhc3wdSaRFYM92GKsKgcZmKo/0ATo3
        2qCb2HDLQT4+Fm2Ir5Esv22W8jqx7LWlcx1QB2RN/97vA6is3BaTCcbu6SvHBcypZiFyHmdSW+Dtr
        UanCdz7ie7xULs8Khg1NzQr4mvun+wd654tBXHbFJKdwIEN/jxJRz0f9KgNGy8iAGZe8CfZnviZ5p
        rpSiw04A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otAHc-00CCgi-Q0; Thu, 10 Nov 2022 16:20:04 +0000
Date:   Thu, 10 Nov 2022 16:20:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Cercueil <paul@crapouillou.net>, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        rkovhaev@gmail.com, roman.gushchin@linux.dev,
        Feng Tang <feng.tang@intel.com>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y20ktNwgPqUbOwxH@casper.infradead.org>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
 <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
 <Y2yArTbOpKd6ASkd@mit.edu>
 <e610b6fa-aa71-d612-0eb2-03ba6c4a6b46@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e610b6fa-aa71-d612-0eb2-03ba6c4a6b46@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:31:31AM +0100, Vlastimil Babka wrote:
> >     octeon-hcd will crash the kernel when SLOB is used. This usually happens
> >     after the 18-byte control transfer when a device descriptor is read.
> >     The DMA engine is always transfering full 32-bit words and if the
> >     transfer is shorter, some random garbage appears after the buffer.
> >     The problem is not visible with SLUB since it rounds up the allocations
> >     to word boundary, and the extra bytes will go undetected.
> 
> Ah, actually it wouldn't *now* as SLUB would make the allocation fall into
> kmalloc-32 cache and only add redzone beyond 32 bytes. But with upcoming
> changes by Feng Tang, this should work.

This is kind of "if a bug stings a tree in a forest, does it hurt"
problem.  If all allocations of 18 bytes are rounded up to 20 or more
bytes, then it doesn't matter that the device has this bug.  Sure, it
may end up hurting in the future if we decide to create 18-byte slab
caches, but it's not actually going to affect anything today (and we
seem to be moving towards less precision in order to get more
performance)
