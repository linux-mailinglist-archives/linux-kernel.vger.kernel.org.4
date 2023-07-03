Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B602745BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGCMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGCMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:10:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABAB109
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qGROpifsOdCT4Xwo5fTFRwrXOPLpnTQ2X2kSGJz1AGs=; b=Q0s11KtjRRE+XjqpowFprZ7h3z
        tT5HO09peI5vpMHiivblNnAxAVB2X7HOyFKL9MP91BInqwL4IPzWpNB+idLvVLdDy914nj6p1SIzT
        sitFrVZu5CnMlvsBuGiazlqbqXSGKCGlG8VSJ4sxDqxWQr7OefNt4MIqFvL6Bw8NXohS6Z37xHPmz
        Mud1HPm+6enB4Yj1G0ZaRmzPF/r4aNkMJyF+LKVn6cV6Z5zA8+3AuT87SCXW4EdhCPgS9XocdP194
        AMnI047OiyUOwggEVYd5Sg+sOZy213Z4QbNYAs7HNeLYsFRsOJOY8zhfbI55ccHqw/LuIO/Lm2kMj
        zAxySWZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGINg-008DYd-9u; Mon, 03 Jul 2023 12:10:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3482C30005E;
        Mon,  3 Jul 2023 14:10:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1471D202A2A17; Mon,  3 Jul 2023 14:10:10 +0200 (CEST)
Date:   Mon, 3 Jul 2023 14:10:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230703121009.GH4253@hirez.programming.kicks-ass.net>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
 <20230630152824.GC43299@lorien.usersys.redhat.com>
 <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
 <20230630162910.GD43299@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630162910.GD43299@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:29:10PM -0400, Phil Auld wrote:

> I think you are agreeing that I need the pick next code but need to remove
> the hierarchy walks, right?

Yeah, the dequeue case makes we have to care about pick, not sure we
then also need to care about sched_update_tick_dependency() though.
There is indeed a window where these two will 'race', but afaict it is
benign.

