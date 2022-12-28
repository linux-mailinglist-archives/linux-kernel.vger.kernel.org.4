Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBC6586D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 21:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiL1Uuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 15:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1Uuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 15:50:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746212A8B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 12:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f5MIKcljMcE7MvfbzWkOdHywhkXeIvtEXmo6zdl9LQ8=; b=WigkmznklbBaMTp0pO+NktJkdC
        C0sozicZLpHWh40cEB8nAniR+BhkVcdcHqmITf3ej6X3mp2apCnPArdPZSuWqvV8XvcLX2BUUFgK5
        cIZkTMjuE9ZpSIFc7rNTPif1WxDcd8+rxJJDncIeicUjOehoZ0PEHYwxKg0VeZVGr6G2WmsF4j0LF
        jRUk1EIBgVatyhqKiXQNqmIxrI7AB3nM3tCzMOSIrppuf/rtIxY6cA9PRAR7C4VujPRpsHNWC7Mkv
        MN8acv8vbQgfbk3ktn8HVX4yZ0XzAhXCME0DPSpicmf43xvVOLRiN2aCx51809WjFOve3PMekmMcB
        aXO0/VVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAdNk-009Nk8-Gs; Wed, 28 Dec 2022 20:50:36 +0000
Date:   Wed, 28 Dec 2022 20:50:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y6ysHNPvKayTfeq8@casper.infradead.org>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 09:48:51PM +0900, Hyeonggon Yoo wrote:
> Hello mm folks,
> 
> I have a few questions about the current status of mmap_lock scalability.
> 
> =============================================================
> What is currently causing the kernel to use mmap_lock to protect the maple tree?
> =============================================================
> 
> I understand that the long-term goal is to remove the need for mmap_lock in readers
> while traversing the maple tree, using techniques such as RCU or SPF.
> What is the biggest obstacle preventing this from being achieved at this time?

The long term goal is even larger than this.  Ideally, the VMA tree
would be protected by a spinlock rather than a mutex.  That turned out
to be too large a change for the moment (and isn't all that important
compared to enabling RCU readers)

> ==================================================
> How does the maple tree provide RCU-safe manipulation of VMAs?
> ==================================================
> 
> Is it similar to the approach suggested in the RCUVM paper (replacing the original
> root node with a new root node that shares most of its nodes and deferring
> the freeing of stale nodes using RCU)?
> 
> I'm having difficulty understanding the design of the maple tree in this regard.
> 
> [RCUVM paper] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

While I've read the RCUVM paper, I wouldn't say it was particularly an
inspiration.  The Maple Tree is independent of the VM; it's a general
purpose B-tree.  As with any B-tree, when modifying a node, we don't
touch nodes that we don't need to touch.  As with any RCU data structure,
we defer freeing things while RCU readers might still have a reference
to them.

We don't necessarily go all the way to the root node when modifying a
leaf node.  For example, if we have this structure:

Root: Node A, 4000, Node B
Node A: p1, 50, p2, 100, p3, 150, p4, 200, NULL, 250, p6, 1000, p7
Node B: p8, 4050, p9, 4100, p10, 4150, p11, 4200, NULL, 4250, p13

and we replace p4 with a NULL over the whole range from 150-199,
we construct a new Node A2 that contains:

Node A2: p1, 50, p2, 100, p3, 150, NULL, 250, p6, 1000, p7

and we simply write A2 over the entry in Root.  Then we mark Node A as
dead and RCU-free Node A.  There's no need to replace Root as stores
to a pointer are atomic.  If we need to rebalance between Node A and
Node B, we will need to create a new Root (as well as both A and B),
mark all of them as dead and RCU-free them.
