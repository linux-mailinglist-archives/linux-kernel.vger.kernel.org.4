Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4397748128
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGEJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGEJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:40:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2951711
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lt4FoXy4mNnBDTHwO7RpxArjIgn4jpLnPfJAc07tOaw=; b=cxZc6bSVU91ZlMek6r7HQnXZEK
        3iJ4uYLoTisPlvfjOlT61Tdx87raQna23rQFMILhZM/zES++pxNEHBe5/WTS5KTzcM1IEtZaLgVSn
        mxvzTmwDUt3NnBE3W9JK3LNngUeKcLUbbc6B5v0GE6rz0SVSXs1LRPUFENqKxav6rxDYW2o4A2oVg
        zAXFeyxFtC/kIH2PqF4X7oeGehS2x97UqEP75rxaOePJ64Ah+Cou2BnZWVPl4XSC+S6d109SckC0r
        WhWbFpGC29o65uUfDa6d0GI5OB49DKRWhpttKsFy2ZDpVnRrIIZtWKbcilILKn4hTWyMvQMTRHlDv
        +yM6LJlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGyxO-00C4EN-12;
        Wed, 05 Jul 2023 09:39:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 933B930036B;
        Wed,  5 Jul 2023 11:37:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B62C2028F056; Wed,  5 Jul 2023 11:37:52 +0200 (CEST)
Date:   Wed, 5 Jul 2023 11:37:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Message-ID: <20230705093752.GW4253@hirez.programming.kicks-ass.net>
References: <20230628211637.1679348-1-longman@redhat.com>
 <20230703102604.GC4253@hirez.programming.kicks-ass.net>
 <5bc41342-5ba6-68e9-8315-9e5cef65d102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc41342-5ba6-68e9-8315-9e5cef65d102@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 10:55:02AM -0400, Waiman Long wrote:

> Our OpenShift team has actually hit a problem with the recent persistent
> user provided cpu affinity change because they are relying on the fact that
> moving a task to a different cpuset will reset cpu affinity to the cpuset
> default which is no longer true. That is the main reason behind this patch
> to provide a way to reset cpu affinity to the cpuset default.

Where is the sched_setaffinity() in that story?

So somewhere this thing did a sched_setaffinity() and then starts
playing with cpusets. Instead of adding more sched_setaffinity() calls,
can't it just remove some?


