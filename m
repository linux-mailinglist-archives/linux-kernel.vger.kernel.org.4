Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D646E9C24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjDTS4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjDTS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:56:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3FF273B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NFkQyXyMWyB02eAcI8GMAq5pUeEMVa46lIHf0EI/tyk=; b=S6YYnMYHJrGyUJih/xpnXrwa/8
        y1BeIB/oAPAFPl2SylHVSlzEeMKMLMAOIRl7hbysr5mTPBuWiBIJl+JMVbvtl2sUTBTfsubPq9oEs
        Awbla2MmuKL1wRIGvENfSP5l7tnz+DNzuObM3w2fJ950LPfcskyXDx/cBK4A8fWDbaeQ1WWr/FuN4
        hXyet6rqfkekWMuaxRd1taqB8yQ5rgToiyV+PSLFOlPU/7GAUc94Yk+jr7elAGdK4W+uuBSlo2jK0
        pWPKDbXvJ/y9DmY37XOnE5olCL4wwYTx2wkgG8pfRMifQDjrT2gdLAK2ZN7zm1IoPci+m5lxFg01V
        BkQD7f5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ppZRw-003rfV-1p;
        Thu, 20 Apr 2023 18:56:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E571C30015F;
        Thu, 20 Apr 2023 20:56:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6DCB24177E4D; Thu, 20 Apr 2023 20:56:06 +0200 (CEST)
Date:   Thu, 20 Apr 2023 20:56:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Mason <clm@meta.com>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        gautham.shenoy@amd.com
Subject: Re: schbench v1.0
Message-ID: <20230420185606.GA1148774@hirez.programming.kicks-ass.net>
References: <bc85a40c-1ea0-9b57-6ba3-b920c436a02c@meta.com>
 <20230420150537.GC4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420150537.GC4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 05:05:37PM +0200, Peter Zijlstra wrote:

> EEVDF base_slice = 3000[us] (default)
> 
> schbench -m2 -F128 -n10	-r90	OTHER	BATCH
> Wakeup  (usec): 99.0th:		3820	6968
> Request (usec): 99.0th:		30496	24608
> RPS    (count): 50.0th:		3836	5496
> 
> EEVDF base_slice = 6440[us] (per the calibrate run)
> 
> schbench -m2 -F128 -n10	-r90	OTHER	BATCH
> Wakeup  (usec): 99.0th:		9136	6232
> Request (usec): 99.0th:		21984	12944
> RPS    (count): 50.0th:		4968	6184
> 
> 
> With base_slice >= request and BATCH (disables wakeup preemption), the
> EEVDF thing should turn into FIFO-queue, which is close to ideal for
> your workload.
> 
> For giggles:
> 
> echo 6440000 > /debug/sched/base_slice_ns
> echo NO_PLACE_LAG > /debug/sched/features
> chrt -b 0 ./schbench -m2 -F128 -n10 -r90

FWIW a similar request size can be achieved through using latency-nice-5

  latency-nice-4 gives 3000*1024/526 ~ 5840[us], while
  latency-nice-5 gives 3000*1024/423 ~ 7262[us].

Which of course raises the question if we should instead of latency-nice
expose sched_attr::slice (with some suitable bounds).

The immediate problem of course being that while latency-nice is nice
(harhar, teh pun) and vague, sched_attr::slice is fairly well defined.
OTOH as per this example, it might be easier for software to request a
specific slice length (based on prior runs etc..) than it is to guess at
a nice value.

The direct correlation between smaller slice and latency might not be
immediately obvious either, nor might it be a given for any given
scheduling policy.

Also, cgroups :/
