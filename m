Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0979066BCB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjAPLTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjAPLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:19:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9749165A0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K5M7ZAEyaWW+WNHWn0Ib+GABLC2gPGGPJYlg1grcpoo=; b=uQe+ocC7Zpc4c3eFhyJT7dIPGV
        pPxD0Kgy50UxgHuqVaU9Grkg514zAH8mGJYRIAn01moNsIQvdbykNzQwVK9s738IK3zgY22TNcg1d
        MYT6cl3tnxGFlukIoj2hIqdF3zrbY+l0eGqvYs8b4diqodql8AYN7Iok85lXoMxndTqNq5PivT42d
        OQpomAaEsBrhF3UgIawOURE7ce7zd1jE/eRD3Ba6N3qLcbGIyx3hrOuN0wBz+LXwe0gLZ+iVVHrRq
        8XgxcA/SCJ5/6dH2gHiOKrtAowar4v2nEUje74QGbM1xIeq2vDdwXjTHbySotWku1jqfZ1BOBKJtO
        yJuN/63g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHNWM-008gA2-NF; Mon, 16 Jan 2023 11:19:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42D0A300193;
        Mon, 16 Jan 2023 12:19:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE64F2081B293; Mon, 16 Jan 2023 12:19:06 +0100 (CET)
Date:   Mon, 16 Jan 2023 12:19:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Avoid WARN_DOUBLE_CLOCK warning when
 CONFIG_SCHED_CORE
Message-ID: <Y8UyqnVRNTcBD/V7@hirez.programming.kicks-ass.net>
References: <20221206070550.31763-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206070550.31763-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:05:50PM +0800, Hao Jia wrote:
> When we need to call update_rq_clock() to update the rq clock of
> other CPUs on the same core, before that we need to clear RQCF_UPDATED
> of rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
> Because at this time the rq->clock_update_flags of other CPUs
> may be RQCF_UPDATED.

So you've found that the WARN_DOUBLE_CLOCK machinery doesn't work for
core-sched -- but then instead of fixing that machinery, you put
band-aids on it :/


