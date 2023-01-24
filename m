Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD25679DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjAXPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjAXPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:41:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF74B88C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQj7qrmg8E8ggKL5hoaCBFJQA0qF06XIOhJLfPvujKg=; b=Dd21g0fy1sfNqWvlQlDclyouJP
        jviTRj8ksYlJj3CFfWGweGiXiyEGAGIF32xspUgHnznn5JcjappD+xLpscm/A+o2kvOX83q4JeGuf
        lI4lhcTpBTp99NzkGtXZhktI+2q/e3LE8NyVUvo4fwhFjImq70TEjiJvLTCadJ8ArUTu6XBqldq9n
        nPyVZBJ3hbOXaZDqpBUcpYwLnqQVo9z5V3PiYly57BzN+m80vezqKXONOyosqUWX7E59KSPPGwtcB
        W4Fkbp4yiegu93o5XQxzAcuyv+2/gT2ljawg0Q6j95LBduSFYNhaGdKAdvxbupUuJndpuDebWxPd7
        IUoF8AcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKLPs-005A1B-Q2; Tue, 24 Jan 2023 15:40:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DA06300657;
        Tue, 24 Jan 2023 16:40:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20957299F2F7E; Tue, 24 Jan 2023 16:40:56 +0100 (CET)
Date:   Tue, 24 Jan 2023 16:40:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER
 threads
Message-ID: <Y8/8CFwtpmjzdK9c@hirez.programming.kicks-ass.net>
References: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:23:20AM -0700, Jens Axboe wrote:
> We don't set it on PF_KTHREAD threads as they never return to userspace,
> and PF_IO_WORKER threads are identical in that regard. As they keep
> running in the kernel until they die, skip setting the FPU flag on them.

No objection to the actual patch; but this changelog fails to tell us
why this is important.

What made you get up and write this patch :-) Presumably this is a
performance issue? If so, can you quantify how much?
