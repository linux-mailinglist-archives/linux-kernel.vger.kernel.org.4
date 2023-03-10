Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4F6B5210
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCJUjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCJUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:39:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DD12CBC4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tVh/FaM3dZNSYbN/bBJA1OJq8Peh9PQDLU9bnCC/5rI=; b=WDaoKilYGg54+ouLA3Bfn5hCsl
        p+oImU/LymdMXHpV1j17+9x9JKYEbYD7meP0vHmDQ/PPWgfTGi6ot7kGo2o+j9+Wc7Sl4ZukhmsOQ
        4AJbpaP6mKKJzT/7Hu6G0JiDgXPfHf7rJqtU5vZGIddX2306hKD4HzVjKUVWenT9tZXY8caWikl8P
        ja9HM3E1XcwL73YiYk1001hoao1b1aL6PF6eWlydkJ3DVr8oBnWQpQsAZpt7r4HbFRZ2x5h8bAYQT
        Wdx4u3ziJ0Yh9EQCGuxxVSHDMVviuiFokgvB4INP5L6zy9pYLuBdA0WUeh+I3Q4KZlc8O1BxfoQrC
        Kb4TyqUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pajVK-009gv9-SW; Fri, 10 Mar 2023 20:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBAF4300288;
        Fri, 10 Mar 2023 21:38:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92ADE2CEACFA0; Fri, 10 Mar 2023 21:38:14 +0100 (CET)
Date:   Fri, 10 Mar 2023 21:38:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
Message-ID: <20230310203814.GA1605437@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.810909205@infradead.org>
 <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
 <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
 <5b567c5aecabf0a89d92593d99a73bef41bd65da.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b567c5aecabf0a89d92593d99a73bef41bd65da.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 05:23:33AM +0100, Mike Galbraith wrote:
> Ok, seems there must be a math booboo lurking.

Yep that.. please try the version I pushed out here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/eevdf

(It's based on 6.3-rc1, but it should be trivial to rebase onto v6.2 if
you so wish.)
