Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169665B1C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjABMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjABMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:04:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7AE9F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:04:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y19so10352781plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWkL+Ay7xGJduzHxgREoGWnEpK2FebgVdJq9e4wRN74=;
        b=IB119u7Sbb6z/UYOkoKjjjy1GSSLRU6TTtuM8wlBc1pyTrPjYczTgibOYnNMUCH/tO
         1pmS862dpdi6fTEQ14TAz5hwKSjXCotOrLE1Nc6RuILhfzEgp33izj0hbu0tq5+gMDVS
         O9UizHTR1Pwa9ngdLj1WLxyk/VmTdphDL4YuTxISO8MbXy5OnSoBphVgv2rsTyOygInd
         u58lgi20ws/UweMAU4HzBlvMvDwPTjzfeyMS8o61dO+cpGwxKFLtjqkmIMjc/oxX71yo
         N0dLWB312Nw0kTAijIWE87GDVT1rHdji37xM8Z4w4/N6jtNQbwrmKUILgZH7LSUoEcXr
         P31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWkL+Ay7xGJduzHxgREoGWnEpK2FebgVdJq9e4wRN74=;
        b=m8bwQAt22Pi8bBzMPbVZiNOfbjEo/EA3xRV/yQcRz9cr+TrP+o9ZEmpj9de/Wst0pl
         FTWHB5MYiyC90onqy0p1aAZ2aBqmzDuuaz2yL2MKnBgZ7n++5xWNPgo9r3pj6bcWYpOX
         8cROeOq1nA1KwaYRuDZIXZV353pFmu1h3wh+MegPH++NnF332ajCHtkFTnVLkO5McaM6
         isVtSirBnHT99hJOAK5Xu6DjP8Bbgx2YM8fhA0ofUe5lXbEichIS+XPt9vA3cdPXX0Vw
         vp53VTCuckYCRt5wf23JT6URhbl+PMBhBPej4mmVDyt0oSWmkW5V/9DsW3xiUHRddaU0
         0KfQ==
X-Gm-Message-State: AFqh2kp+QH3AG5BmEe2uKuCfTB8Z1Ymd0uRxCks5z7AosiMBXmLF+wus
        9PW2awpd9apWCHvtRv1l9vo=
X-Google-Smtp-Source: AMrXdXsdAtxobuHHkRUmvju928j1cQhZ7HR9IzeQhw6EW7+Rqjzk/ZZpSduHYIKwxIlyVS7+qjkPsg==
X-Received: by 2002:a17:903:2792:b0:192:8c1a:1bea with SMTP id jw18-20020a170903279200b001928c1a1beamr24377662plb.43.1672661058789;
        Mon, 02 Jan 2023 04:04:18 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h6-20020a63c006000000b00478b930f970sm16671838pgg.66.2023.01.02.04.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 04:04:17 -0800 (PST)
Date:   Mon, 2 Jan 2023 21:04:12 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y7LIPOc/ESmhRzYk@hyeyoo>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y63FmaNoLAcdsLaU@casper.infradead.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
	ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
	linux-kernel@vger.kernel.org
Bcc: 
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Reply-To: 
In-Reply-To: <Y63FmaNoLAcdsLaU@casper.infradead.org>

On Thu, Dec 29, 2022 at 04:51:37PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 29, 2022 at 11:22:28PM +0900, Hyeonggon Yoo wrote:
> > On Wed, Dec 28, 2022 at 08:50:36PM +0000, Matthew Wilcox wrote:
> > > The long term goal is even larger than this.  Ideally, the VMA tree
> > > would be protected by a spinlock rather than a mutex. 
> > 
> > You mean replacing mmap_lock rwsem with a spinlock?
> > How is that possible if readers can take it for page fault?
> 
> The mmap_lock is taken for many, many things.  So the plan was to
> have a spinlock in the maple tree (indeed, there's still one there;
> it's just in a union with the lockdep_map_p).  VMA readers would walk
> the tree protected only by RCU; VMA writers would take the spinlock
> while modifying the tree.  The work Suren, Liam & I are engaged in
> still uses the mmap semaphore for writers, but we do walk the tree
> under RCU protection.
> 

Thanks, I get it. so it's for less overhead for maple tree modification.

> > > While I've read the RCUVM paper, I wouldn't say it was particularly an
> > > inspiration.  The Maple Tree is independent of the VM; it's a general
> > > purpose B-tree.
> > 
> > My intention was to ask how to synchronize with other VMA operations
> > after the tree traversal with RCU. (Because it's unreasonable to handle
> > page fault in RCU read-side critical section)
> > 
> > Per-VMA lock seem to solve it by taking the VMA lock in read mode within
> > RCU read-side critical section.
> 
> Right, but it's a little more complex than that.  The real "lock" on
> the VMA is actually a sequence count.  https://lwn.net/Articles/906852/
> does a good job of explaining it, but the VMA lock is really there as
> a convenient way for the writer to wait for readers to be sufficiently
> "finished" with handling the page fault that any conflicting changes
> will be correctly retired.

Oh, thanks, nice article!

> https://www.infradead.org/~willy/linux/store-free-page-faults.html
> outlines how I intend to proceed from Suren's current scheme (where
> RCU is only used to protect the tree walk) to using RCU for the
> entire page fault.

Thank you for sharing this your outlines.
Okay, so the planned scheme is:

	1. Try to process entire page fault under RCU protection
		- if failed, goto 2. if succeeded, goto 4.

	2. Fall back to Suren's scheme (try to take VMA rwsem)
		- if failed, goto 3. if succeeded, goto 4.

	3. Fall back to mmap_lock
		- goto 4.

	4. Finish page fault.

To implement 1, __p*d_alloc() need to take gfp flags
not to sleep in RCU read-side critical section.

What about introducing PF_MEMALLOC_NOWAIT process flag forcing
GFP_NOWAIT | __GFP_NOWARN

similar to PF_MEMALLOC_NO{FS,IO}, looking like this?

Will be less churn.

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..77b88f30523b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1725,7 +1725,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF__HOLE__00004000	0x00004000
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_MEMALLOC_NOWAIT	0x00010000	/* All allocation requests will force GFP_NOWAIT | __GFP_NOWARN */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..4a1196646951 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -204,7 +204,8 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 {
 	unsigned int pflags = READ_ONCE(current->flags);
 
-	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
+	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS
+					| PF_MEMALLOC_PIN | PF_MEMALLOC_NOWAIT))) {
 		/*
 		 * NOIO implies both NOIO and NOFS and it is a weaker context
 		 * so always make sure it makes precedence
@@ -216,6 +217,8 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 
 		if (pflags & PF_MEMALLOC_PIN)
 			flags &= ~__GFP_MOVABLE;
+		if (pflags & PF_MEMALLOC_NOWAIT)
+			flags = GFP_NOWAIT | __GFP_NOWARN;
 	}
 	return flags;
 }
@@ -305,6 +308,18 @@ static inline void memalloc_noio_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
 }
 
+static inline unsigned int memalloc_nowait_save(void)
+{
+	unsigned int flags = current->flags & PF_MEMALLOC_NOWAIT;
+	current->flags |= PF_MEMALLOC_NOWAIT;
+	return flags;
+}
+
+static inline void memalloc_nowait_restore(unsigned int flags)
+{
+	current->flags = (current->flags & ~PF_MEMALLOC_NOWAIT) | flags;


-- 
Thanks,
Hyeonggon
