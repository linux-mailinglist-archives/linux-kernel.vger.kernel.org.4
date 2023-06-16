Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E705E7331C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbjFPNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbjFPNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:00:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233AC1BF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gqK+3KsGUGOMq8M8tTFeaLnp1A2G//WBIl2/x8oKhVE=; b=GGJxhuENkgCZS/h4JJhbgI8Vu1
        ezHgFnloGG/Zw+bqxn2bgIpzjpdrtEqW7o5PCDC+/g6L3oLVaOq529I3K2D/093u5VHnZZ7VZ63XV
        ndjBUQwpR5Dkybg+xkPAnxpZhd/mFGtUUeVVPhQ1bolqdex1g4oq+l6pcp+AP1v1ocvarCvg/+ARS
        xKwf5S9+eR4oSkXHRUwD31gqtOLarquq/92XZvTUXxz4zFySu109Hg0nLSYXoj5/3ohbvMHnxopxo
        A5jPfZBWeXl3e6/TGS6oPwoRxqZgXUvH8JKLidi/CZByKeztRRsaAT5uqT3Nj9bshWGB7w8EsiFQ2
        c3ffp0/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA93M-0091BP-Dn; Fri, 16 Jun 2023 12:59:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC29430020B;
        Fri, 16 Jun 2023 14:59:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 791E327438941; Fri, 16 Jun 2023 14:59:46 +0200 (CEST)
Date:   Fri, 16 Jun 2023 14:59:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH V3 5/6] sched/fair: Add trivial fair server
Message-ID: <20230616125946.GN83892@hirez.programming.kicks-ass.net>
References: <cover.1686239016.git.bristot@kernel.org>
 <8db5a49ea92ad8b875d331d6136721645a382fe8.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db5a49ea92ad8b875d331d6136721645a382fe8.1686239016.git.bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:58:17PM +0200, Daniel Bristot de Oliveira wrote:
> +void fair_server_init(struct rq *rq)
> +{
> +	struct sched_dl_entity *dl_se = &rq->fair_server;
> +
> +	init_dl_entity(dl_se);
> +
> +	dl_se->dl_runtime = TICK_NSEC;
> +	dl_se->dl_deadline = 20 * TICK_NSEC;
> +	dl_se->dl_period = 20 * TICK_NSEC;
> +
> +	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
> +}

These here numbers should obviously become a tunable somewhere... :-)
