Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FA66BD4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjAPLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjAPLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:54:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7FE1BAED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eGsHU6sqmbFVl1zRgn6gOMLKxH6DWZk5x5LomRvhTac=; b=pYUkq5eI33A3JlBvQrD3bokhWw
        BLMKa0qV2+13JNErCWcDDUtPsBk9HfX/T7waxIlXTnfdXy3609+K30M8BJnkxj0kH4V4IdWCI/P32
        +UZPi0IwFiPHWQMmmaLfftewKmOfg+LCpktWO+jNbo0y3OWnlzj9iQMkW+VYv/tUf6wetJw22UoqG
        MTw+NY95lMl7K8Qk7pobBixsZRoLuAxci97xYJ6wxEwYCiMEkCqCj6mZdIuHP6mYhly0NOLmRbZjM
        lZPA/NnIULZnSi7M9OkcPeuRJ4e/R3aWMpkgFrRERq6QOQXeKy0Ry+OslyKEPClvUTR1+yUnoEl+I
        Wi1oo2Rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHO4D-005aGT-2r;
        Mon, 16 Jan 2023 11:54:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77264300642;
        Mon, 16 Jan 2023 12:54:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 543E320EF0A1A; Mon, 16 Jan 2023 12:54:29 +0100 (CET)
Date:   Mon, 16 Jan 2023 12:54:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Message-ID: <Y8U69WeQgvgjQdhj@hirez.programming.kicks-ass.net>
References: <20230112162426.217522-1-bristot@kernel.org>
 <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
 <Y8USikoCYTBl7VFr@gmail.com>
 <Y8UYtEepRT3xC8O/@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8UYtEepRT3xC8O/@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:28:20AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > Urgh, can we please make this a cpuidle governor thing or so? So that 
> > > we don't need to invent new interfaces and such.
> > 
> > I think the desired property here would be to make this interface on top 
> > of pretty much any governor. Ie. have a governor, but also a way to drop 
> > any CPU into idle-poll, overriding that.
> 
> ... with the goal of having the best governor for power efficiency by 
> default - but also the ability to drop a handful of CPUs into the highest 
> performance / lowest latency idle mode.

Bah, so while you can set a cpufreq gov (say performance) per cpu,
you can't do the same with cpuidle.

