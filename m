Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32D658F41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiL2Qvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiL2Qvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:51:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81C9DF88
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cnL6QnxP/K+nmxQWxJETPtt5kczBdA/yoSQY1DSaqog=; b=LmjuFtOEV0tPO3SypWjtYP5xI5
        JbSCwXzl8GY92DBFc5ltCbDh+uImdIZz7NyKkZOzjnlR5x17U5E66D7TczSXSjxjh0RfHSEU8UsB+
        5waUugrXekLCPzeKeqD9tUaJ1H5sjY3vYYRO+qAjkPFvi4FaZX0N/Isb31s6FYKycr/j/N+BrPN68
        aFvhlbilCVcDGvtoR4P8wcTuznUC7g4WuQ7hBbFEb/GeNNEn7UsP+T6JyZxMP3XkPQqB9jcUjPqAe
        GzQMrCK3SKKmM2aaBq6asRuSt/aFITeSBo39hIkCmTTDw7fYSOZGNmLrnT9OssVThxEAncquxAG7B
        iZ9nwRGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAw81-00A08R-A5; Thu, 29 Dec 2022 16:51:37 +0000
Date:   Thu, 29 Dec 2022 16:51:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y63FmaNoLAcdsLaU@casper.infradead.org>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y62ipKlWGEbJZKXv@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:22:28PM +0900, Hyeonggon Yoo wrote:
> On Wed, Dec 28, 2022 at 08:50:36PM +0000, Matthew Wilcox wrote:
> > The long term goal is even larger than this.  Ideally, the VMA tree
> > would be protected by a spinlock rather than a mutex. 
> 
> You mean replacing mmap_lock rwsem with a spinlock?
> How is that possible if readers can take it for page fault?

The mmap_lock is taken for many, many things.  So the plan was to
have a spinlock in the maple tree (indeed, there's still one there;
it's just in a union with the lockdep_map_p).  VMA readers would walk
the tree protected only by RCU; VMA writers would take the spinlock
while modifying the tree.  The work Suren, Liam & I are engaged in
still uses the mmap semaphore for writers, but we do walk the tree
under RCU protection.

> > While I've read the RCUVM paper, I wouldn't say it was particularly an
> > inspiration.  The Maple Tree is independent of the VM; it's a general
> > purpose B-tree.
> 
> My intention was to ask how to synchronize with other VMA operations
> after the tree traversal with RCU. (Because it's unreasonable to handle
> page fault in RCU read-side critical section)
> 
> Per-VMA lock seem to solve it by taking the VMA lock in read mode within
> RCU read-side critical section.

Right, but it's a little more complex than that.  The real "lock" on
the VMA is actually a sequence count.  https://lwn.net/Articles/906852/
does a good job of explaining it, but the VMA lock is really there as
a convenient way for the writer to wait for readers to be sufficiently
"finished" with handling the page fault that any conflicting changes
will be correctly retired.

https://www.infradead.org/~willy/linux/store-free-page-faults.html
outlines how I intend to proceed from Suren's current scheme (where
RCU is only used to protect the tree walk) to using RCU for the
entire page fault.

