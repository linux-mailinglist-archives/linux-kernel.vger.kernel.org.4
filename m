Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BF5BACB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiIPLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiIPLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:48:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3BACA32
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jRLLoms3gEFmE3Xqk3ace4Mb+kdij3/aL1dHcL5UlLY=; b=Aokz8rIoFPHEGU/NeMtgjaI7yE
        lUegGiRNvJbrPBr3jicrciiVj7SPmG5E9s43CoWSv0shwTZ3k80xR+CaCAJdUNt8Y/KiCAlpyoINr
        2WmnfdfV4F15nGURh3CLrncu2dPw42nmEGezlLI9xun4cgtrtWYzg7CdSDfBzaVAC0akfwNFhYILk
        Lxcj1BpKKImKvSHI/xRO2MgMz+G1MOILvqQr7vuqNIXjUj94tqizlvoBhnvnIAKRFaaOjbGCRBKM4
        3pX77kvwX4/3ldkOQNbLgYDZ3IhZNucpb4yxSjdL6zNnPTbYTH7/ofQGkFtPK4MqiVc27xNMyGHLm
        AkeeQehQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZ9oz-00CzGj-T0; Fri, 16 Sep 2022 11:47:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E8F430013F;
        Fri, 16 Sep 2022 13:47:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 656BC201A0BBA; Fri, 16 Sep 2022 13:47:49 +0200 (CEST)
Date:   Fri, 16 Sep 2022 13:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YyRiZTTi2KQfJebc@hirez.programming.kicks-ass.net>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915165407.1776363-1-yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:54:07AM +0800, Chen Yu wrote:

> Current proposal is a variant of 2:
> If the target CPU is running a short-time slice task, and the wakee
> is also a short-time slice task, the target CPU could be chosen as the
> candidate when the system is busy.

Since this benchmark only has short running tasks, the result is that
you always pick the local cpu and therefore the migrations are reduced?

Doesn't this inhibit spreading the workload when there's geniunely idle
CPUs around?
