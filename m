Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9876FA21D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjEHIYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjEHIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0AC1A10A;
        Mon,  8 May 2023 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ypZSIxmdSA8iF2yRhvmEJb0SvA/i+Bsfp62do6qBrxw=; b=VPvIQNx+z5YLvzawxyYzGAQtCH
        2J9yjl/4Q4nWJ96EMrzB9/QoWY8RUjsHEcym+xZTmnSdQa/KybMMAjA/E5U/VlNinuQEpdJwVkY7e
        hXnYIQY+GxO8M8DYU6qdSOqoI5Yp0fYM1xwBpucfIe6OlfMHJqMA3l5SJRb7+4J3wEJiPBUTKXfia
        uRfTb9tcX+IpH7QOoy2ntWpmZwUYGi0V+ux5fNUaSPY2TXDpsoYKEa3WRlBCzr/dEDIp9ztLb2kxo
        S6w6b7wvubdW7Vbe/YRGdxXLUl4CShF6k1w237T9BycZXcodfLTCQeR7rZD5qUhBP8CXx+EPvqBZd
        8czoxKJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pvwA1-00DyCr-O1; Mon, 08 May 2023 08:23:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C08D030026A;
        Mon,  8 May 2023 10:23:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E74D23937D84; Mon,  8 May 2023 10:23:56 +0200 (CEST)
Date:   Mon, 8 May 2023 10:23:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] locking/rwsem: Add __always_inline annotation to
 __down_read_common() and inlined callers
Message-ID: <20230508082356.GS83892@hirez.programming.kicks-ass.net>
References: <20230503023351.2832796-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503023351.2832796-1-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 02:33:51AM +0000, John Stultz wrote:
> Apparently despite it being marked inline, the compiler
> may not inline __down_read_common() which makes it difficult
> to identify the cause of lock contention, as the blocked
> function in traceevents will always be listed as
> __down_read_common().
> 
> So this patch adds __always_inline annotation to the common
> function (as well as the inlined helper callers) to force it to
> be inlined so the blocking function will be listed (via Wchan)
> in traceevents.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: kernel-team@android.com
> Cc: stable@vger.kernel.org
> Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>

Thanks!
