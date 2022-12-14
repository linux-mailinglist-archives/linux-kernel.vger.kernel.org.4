Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7A64C59A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiLNJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLNJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:11:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6AD1DD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J9zy1I1jvlVgO4gzWDG/fOFo9/RhHbRmxr5v73Xv7gw=; b=oMRZQuRTOV1r55GY3GDiNpot78
        YV423zDDRBUOUvXbu/ES3QOoWo+D7G/ZEmV4z5HkDVM2fzgocVhNEEkRmh6MHxwvhfd56nfuqV0yQ
        hgBx+t/2NhPLzUqMVmF/+szA7pZz6ERJ9BoL6XxrFGnqIw/OElmzUVLW11ReeeuUwFFr/nBS/AXS0
        L83UKKPFejjhH0zCqd2bn7aiMBblLX1i79qpcKsKJivAywur0kmbfObV46a72fOlRHxExY0AcAf+Z
        gEzf87rH77AOPvVt+pJPK4aBr0lhpjB2ct4vUKqX2lIWWbbK/rKKUp5/JtCdElvlTVCZ9PR/qF7d1
        kP5qVSgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5NnD-00D4Ly-6P; Wed, 14 Dec 2022 09:11:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8705530036B;
        Wed, 14 Dec 2022 10:11:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AA54202344B3; Wed, 14 Dec 2022 10:11:01 +0100 (CET)
Date:   Wed, 14 Dec 2022 10:11:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Make const-safe
Message-ID: <Y5mTJVi2PBix+Gy6@hirez.programming.kicks-ass.net>
References: <20221212144946.2657785-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212144946.2657785-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:49:46PM +0000, Matthew Wilcox (Oracle) wrote:
> With a modified container_of() that preserves constness, the compiler
> finds some pointers which should have been marked as const.  task_of()
> also needs to become const-preserving for the !FAIR_GROUP_SCHED case so
> that cfs_rq_of() can take a const argument.  No change to generated code.

More const more better I suppose.. Thanks!

Happen to have a sha for the container_of() commit handy?
