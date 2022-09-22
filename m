Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD375E5DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiIVIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiIVIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:45:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36708D01CB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJSFq9n4IhTHE9LgY9araioWWsK4zmhxNFi739AGsPo=; b=XwJrVigSu5bOF7oxRDqBIlMMQI
        3Jxcxfu2wcdnszoe8TrJL/vCRq1YXzL7ysaUqRq/3jN/40P99Ie63b5G+EfTALeIFcwGLht8JPA9c
        qaZ26ZfqdPH0gw8vh4KopCuuzFxuow0TXO/TcJe/VoIE+x7Duq89RSooLj81oV/uzemMP4C+xRwWU
        reuDRTwCJmqK4Pe9TQrOfUMcSP8/NUpY38WzTe/z52C/Xd1m960aUxEeJpDYiDJxXgDBM+kDzd8ru
        YbP4OkpDQmpvR1oQzI08sUJirU04ItKdT/5wc1neJPuf9pbRSKb4+k7/LGJgrdvjn1JqXGUAym7nC
        jdJhC20g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obHpt-00Ev25-BR; Thu, 22 Sep 2022 08:45:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD357300169;
        Thu, 22 Sep 2022 10:45:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EFEC2B662EF7; Thu, 22 Sep 2022 10:45:31 +0200 (CEST)
Date:   Thu, 22 Sep 2022 10:45:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v9 0/7] sched: Persistent user requested affinity
Message-ID: <Yywgq+NUZH+JuJpF@hirez.programming.kicks-ass.net>
References: <20220916183217.1172225-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916183217.1172225-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:32:10PM -0400, Waiman Long wrote:

> Waiman Long (7):
>   sched: Add __releases annotations to affine_move_task()
>   sched: Use user_cpus_ptr for saving user provided cpumask in
>     sched_setaffinity()
>   sched: Enforce user requested affinity
>   sched: Introduce affinity_context structure
>   sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
>   sched: Fix sched_setaffinity() and fork/clone() race
>   sched: Always clear user_cpus_ptr in do_set_cpus_allowed()

I still think this is ordered all wrong. Esp. with that affinity context
doing the right thing isn't onerous at all.

So please, re-order this and fold all fixes back in so that it becomes
a sane series. Basically patches 5 and 6 shouldn't exist, they fix
issues created by the earlier patches.
