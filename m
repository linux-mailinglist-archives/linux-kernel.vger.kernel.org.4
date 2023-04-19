Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F426E7DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjDSPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjDSPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:09:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18786EAF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=teQjVnXlf4lhJ2o/juCXqre3cPfSTFtFwCFRcevwxZI=; b=wUQFZqIUf/pqaoiQJG9nvBNX+y
        Qxvgt50FfQQGBOCCBu+lTnAqjnf9YtuZ9aELBmolZz4qGeQ3g4f4XwoO66H8+/tQqIb3XGfJtolTT
        Ft+UHLKDj0ZCAHmRXZylE5kheLXu5K00Tgt6iKg+UO4MLmx9eTiUQ/vqUgTjkLzI1z8XzlEtsJouQ
        wt6SFj1V1gM2ynVtAbTMzY9A9CLM33LayRnCibN+3l0sN3nvGt+tE9YJ8HhQw+k0/XoPQb9Pdw+1J
        zseT6LRXDg5cTiO6JBjBisZKWm++RndVUl3hYPug39y7rIxiGWZ4sNWQ3z3Fdd8L1NoTCz45JiZuc
        gNpbzrHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pp9Qc-00DLXX-HQ; Wed, 19 Apr 2023 15:09:02 +0000
Date:   Wed, 19 Apr 2023 16:09:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Message-ID: <ZEAEDqVhS0qz6Wx1@casper.infradead.org>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
 <ZD9kKTsPVlzlEZLp@casper.infradead.org>
 <9f92d530-1cfc-6e50-a717-321ac64ed1c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f92d530-1cfc-6e50-a717-321ac64ed1c2@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:07:04AM -0400, Waiman Long wrote:
> On 4/18/23 23:46, Matthew Wilcox wrote:
> > On Tue, Apr 18, 2023 at 09:16:37PM -0400, Waiman Long wrote:
> > >   1) App runs creating lots of threads.
> > >   2) It mmap's 256K pages of anonymous memory.
> > >   3) It writes executable code to that memory.
> > >   4) It calls mprotect() with PROT_EXEC on that memory so
> > >      it can subsequently execute the code.
> > > 
> > > The above mprotect() will fail if the mmap'd region's VMA gets merged with
> > > the VMA for one of the thread stacks.  That's because the default RHEL
> > > SELinux policy is to not allow executable stacks.
> > By the way, this is a daft policy.  The policy you really want is
> > EXEC|WRITE is not allowed.  A non-writable stack is useless, so it's
> > actually a superset of your current policy.  Forbidding _simultaneous_
> > write and executable is just good programming.  This way, you don't need
> > to care about the underlying VMA's current permissions, you just need
> > to do:
> > 
> > 	if ((prot & (PROT_EXEC|PROT_WRITE)) == (PROT_EXEC|PROT_WRITE))
> > 		return -EACCESS;
> 
> I am not totally sure if the application changes the VMA to read-only first.
> Even if it does that, it highlights another possible issue when an anonymous
> VMA is merged with a stack VMA. Either the mprotect() to write-protect the
> VMA will fail or the application will segfault if it writes stuff to the
> stack. This particular issue is not related to SELinux. It provides another
> good idea why we should avoid merging stack VMA to anonymous VMA.

mprotect will split the VMA into two VMAs, one that is
PROT_READ|PROT_WRITE and one the is PROT_READ|PROT_EXEC.
