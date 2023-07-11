Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43B74ED0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGKLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjGKLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:42:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20B1A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L73mcy0Md2qNt/m5THUnP4reYmzK9kp8si4mB9+1g1M=; b=kK50fljVE/YG+D1BO+YSkNPLG9
        rrrQ2QFDf5X/HZvVpGkAqDblIT8Wf3us5T+ip+4L5N8sgJEgYYR0yn1wr7LJojNe1IZ1+pnJ/aE+b
        SPkwqaw0wOlPo5wGyt6JS5I7qWAGks7fvUXfYAhntDWXNiODRP4cpTM36MpkYi4JRcop88kbbwfkw
        HxqeLz/qCkDahhUB0Y4AA42qsTANkb6utzNSrqFZ7Llfw+38jDui+wfG2XtcSlf4ndvq2jEsIwOC1
        QOcnHgna41F3hwzNp2ysJhEow/pCWH7ha4hsGiu6ZycDL149C4y4IRAD3hiDbCKRYNxXT4M0VLmFm
        WJ6E23fQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJBku-002NuK-2q;
        Tue, 11 Jul 2023 11:42:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2091030036B;
        Tue, 11 Jul 2023 13:42:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08DBF240EBDA8; Tue, 11 Jul 2023 13:42:08 +0200 (CEST)
Date:   Tue, 11 Jul 2023 13:42:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20230711114207.GK3062772@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:03:35PM -0500, David Vernet wrote:
> Difference between shared_runq and SIS_NODE
> ===========================================
> 
> In [0] Peter proposed a patch that addresses Tejun's observations that
> when workqueues are targeted towards a specific LLC on his Zen2 machine
> with small CCXs, that there would be significant idle time due to
> select_idle_sibling() not considering anything outside of the current
> LLC.
> 
> This patch (SIS_NODE) is essentially the complement to the proposal
> here. SID_NODE causes waking tasks to look for idle cores in neighboring
> LLCs on the same die, whereas shared_runq causes cores about to go idle
> to look for enqueued tasks. That said, in its current form, the two
> features at are a different scope as SIS_NODE searches for idle cores
> between LLCs, while shared_runq enqueues tasks within a single LLC.
> 
> The patch was since removed in [1], and we compared the results to
> shared_runq (previously called "swqueue") in [2]. SIS_NODE did not
> outperform shared_runq on any of the benchmarks, so we elect to not
> compare against it again for this v2 patch set.

Right, so SIS is search-idle-on-wakeup, while you do
search-task-on-newidle, and they are indeed complentary actions.

As to SIS_NODE, I really want that to happen, but we need a little more
work for the Epyc things, they have a few too many CCXs per node :-)

Anyway, the same thing that moticated SIS_NODE should also be relevant
here, those Zen2 things have only 3/4 cores per LLC, would it not also
make sense to include multiple of them into the shared runqueue thing?

(My brain is still processing the shared_runq name...)
