Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C668B51A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 06:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBFFKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 00:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBFFKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 00:10:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A5B1BEE;
        Sun,  5 Feb 2023 21:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/vaXmDiISQEbay077BGity4tzOnqmD7ndpsdu1qs8A=; b=nX9Af+4rlwZgUZ6WeRrHLyGzDq
        7MTeZhdMzCzQ80agG7XygW7yiQT7NcXxClU5K4oaHwppap+EL9b/ah6a5+UjNTAnyfK+/GlMKUF4j
        6cb9mIDFnVRNqgkhwbF/1KQ8raWUVc/kxMjN0vTn8wKB/xZVOz+XcuSfcJk1yW34uwqXu9Ny+IK+W
        nPH7KjNi2JUxsixkNHQVocg/QlA8YKYxneiyzRAmmbxJKOn/3ZlYbIPLyPhaFtPtY+/7KaVcyw2RZ
        okpCyxtfa31XrApkHzNOk3fBt6SpytUFP0QAv9oW6+QXnnoH1sBlRORpIMowCfiEMtg1VRVQ0+SCm
        1t5RuBUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOtlO-00GUEA-00; Mon, 06 Feb 2023 05:09:58 +0000
Date:   Mon, 6 Feb 2023 05:09:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+CLpdnOGFg28uMJ@casper.infradead.org>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
 <Y+BPy3jFcHqOnWL0@x1n>
 <Y+BrJhxeJbAp49QE@casper.infradead.org>
 <Y+BxhuGUx1K+3XHb@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+BxhuGUx1K+3XHb@xz-m1.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 10:18:30PM -0500, Peter Xu wrote:
> On Mon, Feb 06, 2023 at 02:51:18AM +0000, Matthew Wilcox wrote:
> > That wasn't what I meant.  I meant putting VM_FAULT_BADMAP and
> > VM_FAULT_SIGSEGV in mm_types.h.  Not having "Here is a range of reserved
> > arch private ones".
> 
> VM_FAULT_SIGSEGV is there already; I assume you meant adding them all
> directly into vm_fault_reason.
> 
> Then I don't think it's a good idea..
> 
> Currently vm_fault_reason is a clear interface for handle_mm_fault() for
> not only arch pffault handlers but also soft faults like GUP.
> 
> If handle_mm_fault() doesn't return VM_FAULT_BADMAP at all, I don't think
> we should have it as public API at all.  When arch1 people reading the
> VM_FAULT_ documents, it shouldn't care about some fault reason that only
> happens with arch2.  Gup shouldn't care about it either.
> 
> Logically a new page fault handler should handle all the retval of
> vm_fault_reason afaiu.  That shouldn't include e.g. VM_FAULT_BADMAP either.

Hmm, right.  Looking specifically at how s390 uses VM_FAULT_BADMAP,
it just seems to be a badly structured fault.c.  Seems to me that
do_fault_error() should take an extra si_code argument, and
instead of returning VM_FAULT_BADACCESS / VM_FAULT_BADMAP from
various functions, those functions should call do_fault_error()
directly, passing it VM_FAULT_SIGSEGV and the appropriate si_code.

But this is all on the s390 people to fix; I don't want to break their
arch by trying it myself.
