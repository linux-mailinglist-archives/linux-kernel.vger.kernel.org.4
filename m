Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2E70CA61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjEVUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjEVUIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:08:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF291
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tof2AA7349M+MWFrptYMm/jVekCyxohuoos8nDOEels=; b=Or2D3xTh2YxrTy+ISHxHE5ihMW
        lIaQYo56q8PEdjT1yVFh3tc0VNRND9V7QUhEJk/wrMOWHMQ9PlltQfAbwKp6kLdbPwLlRQYt+8zfq
        /sYNp/TLPJshDdluVuMTTAPQ26kC52qiKuTaEbqfg/H8xg1xNACrhQW3RGGkzQXMhv7E+/pfXYpIU
        MmeIIkzKITx9gM/Y0z4YXLaypbhyMLqI+cqe9AaQ+RnlzPLB/9HvdiWrq6UBPE92Wd6GFBLTaONqR
        Q0Ocdi+qdzXl8LWrUWr7zQgnQBa4/TPN7/GacJTJsDWkucDF3G4VDDUhg47+jA9MunCPU+ViB8670
        BfWEqveg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1BpE-00285M-3C;
        Mon, 22 May 2023 20:08:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6E0B3002C5;
        Mon, 22 May 2023 22:08:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F7B42416EAFB; Mon, 22 May 2023 22:08:10 +0200 (CEST)
Date:   Mon, 22 May 2023 22:08:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] sched: address missing-prototype warnings
Message-ID: <20230522200810.GB3334667@hirez.programming.kicks-ass.net>
References: <20230522195021.3456768-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522195021.3456768-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 09:50:16PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I sent out a lot of -Wmissing-prototype warnings already, but noticed that
> I missed some of the patches I did for the scheduler.
> 
> Addressing this is mainly useful in order to allow turning the
> warning on by default in the future, but I also tried to
> improe the code where possible.
> 
> Arnd Bergmann (5):
>   sched: hide unused sched_update_scaling()
>   sched: add schedule_user() declaration
>   sched: fair: hide unused init_cfs_bandwidth() stub
>   sched: make task_vruntime_update() prototype visible
>   sched: fair: move unused stub functions to header
> 

Thanks!
