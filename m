Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72FF73323C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbjFPNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFPNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:33:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9241BC3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IAe1OrIyWEFnwZDTe546YOQM4N0IfwEjPVANZHzJGYU=; b=WzO4zfX6tEeZvwIhrppvLVDDF5
        YlLY7Nwjd4cn4hexblx7QDMyEsB0TFby0xiIF6IEjODJ8LX734ZKPqXuwD0fuGR1lOagPaN5Jpwx0
        UwjGswzi0g0iKZfJWKiKWUupfgdbpJjtiF4438qpH7m1C1FTfxJWvafVAgz3tkh2GIFsOIw2LPsUF
        yCLeZbW+ZvlZ2gYim5LxIe4XUgImyg88aup12tyTVhxTSdH9k5yopZtPnpaQTrQtyNvn0l5nlfoKe
        l8cpv3UZwU2yMz/R3ubVX2IE7jB9g2ikaxQGridfDizPhI6DauO1HMXymWR0ef6ikNogKXZAkjsjc
        XLH2YGuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA9Zs-00CvZx-0K;
        Fri, 16 Jun 2023 13:33:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81C703002A9;
        Fri, 16 Jun 2023 15:33:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65998265FBB8F; Fri, 16 Jun 2023 15:33:23 +0200 (CEST)
Date:   Fri, 16 Jun 2023 15:33:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix throttle accounting with nested bandwidth
 limits
Message-ID: <20230616133323.GH4253@hirez.programming.kicks-ass.net>
References: <20230615201252.1009678-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615201252.1009678-1-joshdon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:12:52PM -0700, Josh Don wrote:
> This fixes two issues:
> - throttled_clock should only be set on the group that is actually
>   getting throttled
> - self-throttled time should only be accounted on entry/exit to
>   throttled state when we have nested limits
> 
> Fixes: 88cb2868250c ("sched: add throttled time stat for throttled children")
> Fixes: 3ab150d011da ("sched: don't account throttle time for empty groups")
> Signed-off-by: Josh Don <joshdon@google.com>

Hurmph, those are not the sha1 I have in tip/sched/core.

Also, should I rebase and just pull those patches so we can try again?
