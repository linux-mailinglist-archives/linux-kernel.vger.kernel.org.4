Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBB71FA78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjFBHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:00:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E48E51;
        Fri,  2 Jun 2023 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qIXWERo/5mBFHk32MXDQmFK2NEQeMdXkkddg8rxcan8=; b=GGuIqeWdaba7AOsx85ARJWgKjM
        uk8SbyVwf4xlrO8+V0O+2PsNjaycUsbSuhUyAqiKlXay62e8Te5AIPQvEegLuanH8Rqe3+rkguZ73
        y5VQC7/BH0nRjvTVmqlz7w8KosU7+EDwLyn6SO4UPxPfNHDyy0vcmpaVhANmfhQJdk6IuJtI2TC6C
        M578SG/A8GQSMmnRpKo8WZSRUliViV4hFjCzHNkqVkczF6snEbvzVV+2h6HAqgwaRZAscEtkFM+KA
        jEGmfo05BEnZPtyOjAIaKknjF1I+XOd3i85Ygao0BtJNoSFn9SznrBa5f3/k7eIFV9yUa+kQ2Sav6
        4X6/MATA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ylx-001G9O-1O;
        Fri, 02 Jun 2023 07:00:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0848730031F;
        Fri,  2 Jun 2023 09:00:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E463F214120A1; Fri,  2 Jun 2023 09:00:28 +0200 (CEST)
Date:   Fri, 2 Jun 2023 09:00:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230602070028.GC620383@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:43:37AM +0530, K Prateek Nayak wrote:

> This makes sense but I wonder if new domain will add more load balancing
> jitters. Also this will require larger evaluation with some more diverse
> workloads.

Always the case, isn't it :-)

> Let me go check if we can get find the NPS2/NPS4 boundary when
> in NPS1 mode.

Yeah, that would be nice; if not you can see if you can reverse engineer
them from FMS and the topology bits we do have and file a request with
your hardware people to pretty please expose this going forward.
