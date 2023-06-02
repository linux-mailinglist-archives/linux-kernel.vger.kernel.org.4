Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24871FA63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjFBGyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjFBGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:54:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C56128;
        Thu,  1 Jun 2023 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0tEG+kOckeg3UItjrrMKBdlC2WTUbMBjYClf/3MJRkA=; b=CRVIrQyubwHc3DkY8TJQl/3zlg
        32VYIzgFZE8JSbcwpzI66cIA8YbRA7kKFH28lwnJ+WVSW+uRuNvlJ98HFp3aW8XwNomxn/X3HIlZE
        c/BVq8DfNXuKNy3VHjQFcIbeEJJuCX1SUQe0T1VgeDr7U9cINzl7jyp0FWKJH0ZdYqQngZneQ2y7W
        waOUcLlgefbgJnuMbqpCjdzdEXQ5u1QDeXLWZYjtslXyp3R095qTyW8CkqKjeZB81Z7MV2uwGXDo0
        9Dy7nEx1sQ14nnsRYGfR8c60s4utgh7pZr3+UufRn23HKwHxw+CFNcOob/qNMQNXhNV5oxeF3+FGJ
        DlT7MmPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4ygK-008zuF-1f; Fri, 02 Jun 2023 06:54:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5E97300188;
        Fri,  2 Jun 2023 08:54:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF74A214120A1; Fri,  2 Jun 2023 08:54:38 +0200 (CEST)
Date:   Fri, 2 Jun 2023 08:54:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230602065438.GB620383@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:43:37AM +0530, K Prateek Nayak wrote:
> Grouping near-CCX for the offerings that do not have 2CCX per CCD will
> prevent degenration and limit the search scope yes. Here is what I'll
> do, let me check if limiting search scope helps first, and then start
> fiddling with the topology. How does that sound?

So my preference would be the topology based solution, since the search
limit is random magic numbers that happen to work for 'your' machine but
who knows what it'll do for some other poor architecture that happens to
trip this.

That said; verifying the limit helps at all is of course a good start,
because if it doesn't then the topology thing will likely also not help
much.
