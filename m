Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B770EF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbjEXHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbjEXHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:35:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C79E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qkbTHa74RqVx5scyvuURKZ3IXXkvsRG06ONrBK7Q0vM=; b=SEeenSyO+zoxIqiysPU5pxE140
        yqb6r8HRIiROJ5lXrscO8mPffvWto3MvioiJsWQNKw8clYMCI6df/HodWIi+pgAA/9A3MWG/u/Kg0
        s0zBJq8aCcQzV8yiNqudF8vv5v4CL4t5beE7+oisxi29rxJ8kB018XL1l7Xne7RDdP8jNxNXjutZt
        agebM0jy+xlvBc7+bB87it1Y2/nGdhd2Cc3UuOeOygQto62TiHaga56su+y8Ww4YPnbNted1aIBaT
        lGKFWS7x7Fc1PsUlgDnefjAUxmWljRsULUBn+47ZY9ugj/gLC1ixkb/H0+a7so3/DFtNj4b25QqhX
        fScvd7aw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1j1O-00AyiB-Jv; Wed, 24 May 2023 07:34:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D48C300322;
        Wed, 24 May 2023 09:34:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41EEE212FC822; Wed, 24 May 2023 09:34:56 +0200 (CEST)
Date:   Wed, 24 May 2023 09:34:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, gautham.shenoy@amd.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <20230524073456.GO83892@hirez.programming.kicks-ass.net>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230523111818.GH4253@hirez.programming.kicks-ass.net>
 <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 06:12:45PM +0200, Vincent Guittot wrote:

> Another possibility to investigate would be that each wakeup of a
> worker is mostly unrelated to the previous one and it cares only
> waker. so we should use -1 for the prev_cpu

Tejun is actually overriding p->wake_cpu in this series to target a
specific LLC -- with the explicit purpose to keep the workers near
enough.

But the problem is that with lots of short tasks we then overload the
LLC and are not running long enough for the idle load-balancer to spread
things, leading to idle time.

And that is specific to this lots of little LLC topologies.
