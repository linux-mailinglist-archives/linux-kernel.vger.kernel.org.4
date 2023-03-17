Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223C6BF034
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCQRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCQRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:53:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEC93E1EF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HtKFqdARoZKY+egv95E9RVJkLOzthc2dmuVvR4Mgc7w=; b=UZXK5e19vWYzz4AIreTf5SJQuN
        5VM6sNomaJbTp8rjzw5VfrQMz3BBd+zP8a7lHkOPLdEskXaJYU2ptdyTM2tPz9iqNbrtxXSMFDr+d
        hSJlUEDsoNE1OudLKpImOMOIEv88eJrfiXCugu3qUE2aWpgV1dwza1Nff1z7uRY+FykPs9SraF+c2
        FO37fmnipGJrReCTTjtsT064GRE5qgRruABmLdafcqo+PkaHc7n60OQLZbTgr6mxx+tjs/fCdrl3H
        aITRQusKSXW4dqasejIrrvkQtUXGGntVH7Sib7ayBN9YJpWDhnFWPsWkNkyhLdDtFGMbEpSA8c6lF
        78rZIU9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdEGA-00G5od-Cn; Fri, 17 Mar 2023 17:52:58 +0000
Date:   Fri, 17 Mar 2023 17:52:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <ZBSo+mLUOsKvy3rC@casper.infradead.org>
References: <20230306235730.GA31451@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306235730.GA31451@monkey>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> One of our product teams recently experienced 'memory bloat' in their
> environment.  The application in this environment is the JVM which
> creates hundreds of threads.  Threads are ultimately created via
> pthread_create which also creates the thread stacks.  pthread attributes
> are modified so that stacks are 2MB in size.  It just so happens that
> due to allocation patterns, all their stacks are at 2MB boundaries.  The
> system has THP always set, so a huge page is allocated at the first
> (write) fault when libpthread initializes the stack.

Do you happen to have an strace (or similar) so we can understand what
the application is doing?

My understanding is that for a normal app (like, say, 'cat'), we'll
allow up to an 8MB stack, but we only create a VMA that is 4kB in size
and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
Therefore we won't create a 2MB page because the VMA is too small.

It sounds like the pthread library is maybe creating a 2MB stack as
a 2MB VMA, and that's why we're seeing this behaviour?
