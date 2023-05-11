Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24596FFBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjEKVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjEKVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:11:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41C10F6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BcmV9Aw2E0H6l6GyxDS0g0rL3d0GJwBvc39g/nl/58c=; b=uxbICcvLBrJHxoL/FLgrkrwOWi
        jLHAS4MTmzPC4W+Q3Y79tGBdTOJWs01AOfriARjJ+/08ZeYlzqUdKQwDVK83EO/ZZolPApI6Qz15Y
        IUNghPRpJwbbDbdDD5y6aGPRgVCLdJpg7tLZGXMxsKF5hh9so8UAY0jWo2e1JVTG7AuCVAdZINCDe
        x2EuRklcEsXP+XJyMj66H4B8AedI3sz5/4CSaiUQiyWDTOm0EseFeLdYcL7JL8kwYll11NiufhC0d
        SPs88Z+dxP/1pIWrExh8fFq+6FXszev2tQtX1/eCzdbGKBusEnccVdcqXDf+nqLOEGwfQsmIziAFc
        66/FPR0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxDZX-00HZrK-DF; Thu, 11 May 2023 21:11:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 595DF300023;
        Thu, 11 May 2023 23:11:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 417CB2C7C5BEB; Thu, 11 May 2023 23:11:34 +0200 (CEST)
Date:   Thu, 11 May 2023 23:11:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 7/7] workqueue: Track and monitor per-workqueue CPU time
 usage
Message-ID: <20230511211134.GG2296992@hirez.programming.kicks-ass.net>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-8-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511181931.869812-8-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:19:31AM -1000, Tejun Heo wrote:
> Now that wq_worker_tick() is there, we can easily track the rough CPU time
> consumption of each workqueue by charging the whole tick whenever a tick
> hits an active workqueue. While not super accurate, it provides reasonable
> visibility into the workqueues that consume a lot of CPU cycles.
> wq_monitor.py is updated to report the per-workqueue CPU times.

I'm utterly failing to read that dragon thing (or possibly snake, but I
can typically sorta make out what it intends to do).

However, while you don't have preempt-out, you still have sched-out
through wq_worker_sleeping(), so you should be able to compute the time
spend on the workqueue by past worker runs -- fully accurate.

Then you only need to add the time since sched-in of any current worker
and you have a complete picture of time spend on the workqueue, no
approximation needed.

Or am I completely missing the point?
