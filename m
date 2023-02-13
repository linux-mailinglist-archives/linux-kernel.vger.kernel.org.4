Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95CE694254
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBMKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjBMKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:09:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD2126FA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MHGhzzVxBpgc6PSBAfW9tz+rSkRb/BH0GD2KgfKYV+0=; b=WEzYelLeasulKo9YkCBc4gKjMR
        stClwOY80Du8dfltNhiCuc4qQRpc+yJ1pcItpIILgyvnH+v7kh/GoYUjDbIL2hbsyXdaBtawzZSm+
        bspY1jC38q0Iujnfnfxy7c5divqgLFYWgesR8r94i5kFGspumjKdt5RAwMMaezsUJWG05/LFNt7lg
        zrmjLfhHu1qLg+18/yKiA0cImAYR1VhdeIY/13V58v9irgQHDIoWnN24phcGro6wXEP5FPk5pPCN7
        ryMLfb9gBfvoI67qTvG+1MQykwnqki1psTWMw7SSIT5HbcqceWmgxOxBSmkyCaMzoW4HlPEcaheOP
        im/Ohq4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRVlV-005dwL-2w; Mon, 13 Feb 2023 10:08:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 962B830036B;
        Mon, 13 Feb 2023 11:08:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DE7520C6EEA1; Mon, 13 Feb 2023 11:08:52 +0100 (CET)
Date:   Mon, 13 Feb 2023 11:08:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     JaeJoon Jung <rgbi3307@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [kernel/sched/core.c] Review and Modified of the prio_less()
 about sched class priority.
Message-ID: <Y+oMND+7L7S9mByY@hirez.programming.kicks-ass.net>
References: <CAHOvCC5Tde6aTtcAeHig1eoAp_9FZGTd4XtFGbmrhy-NoV7zDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOvCC5Tde6aTtcAeHig1eoAp_9FZGTd4XtFGbmrhy-NoV7zDA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:11:04AM +0900, JaeJoon Jung wrote:
> The sched_class structure is defined to be sorted by pointer size.
> @@ -176,22 +161,18 @@ static inline int __task_prio(struct task_struct *p)
>  /* real prio, less is less */
>  static inline bool prio_less(struct task_struct *a, struct
> task_struct *b, bool in_fi)
>  {
> +        int less = a->sched_class - b->sched_class;
> 
> +        if (less == 0) {
> +                if (a->sched_class == &dl_sched_class)
> +                        return !dl_time_before(a->dl.deadline, b->dl.deadline);
> 
> +                else if (a->sched_class == &fair_sched_class)
> +                        return cfs_prio_less(a, b, in_fi);
> +                else
> +                        return false;
> +        } else
> +                return (less > 0) ? true : false;
>  }
> 
> If the prio_less() function is modified as above, the __task_prio()
> function is not required.

Yeah, except your patch is whitespace mangled..
