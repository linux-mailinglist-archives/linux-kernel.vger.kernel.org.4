Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1D749A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjGFLPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGFLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:15:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C1119;
        Thu,  6 Jul 2023 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSlL37087xTCXokKPbb0YKoOakvJNB5SSToD/acvXa4=; b=Dc9YYPLnaVOExpdsmgzVFIgnNm
        sT4P33wS1wpkPPD1Q/7n9elVaJBKQjv3sJo1DFOGMXuRJJbx8CfrRPwN61fmI4yCiY2c9c0EYcb6N
        j46l2hsRO0IgV2WShwYQZCOndP68HuTyiF32+I+7GR7149BhqCvIW3UKbv+ekX8Yra6tdo91Ombkn
        RFAzHdk2REdU4LZauhTZFbcrVG/cvlSkx54ZGagtjMzbO/55EaRVC7GdaDX8ZSzQhQFMVKE5RiEhl
        orvuHRxyUcDcelML+YDFTqviHCETuvU2RuWLilI0IT5BIA0oL80ApdGPiGdm+KH1ZZbWe0QAnSidb
        7Ssa4dYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHMwf-00B0Gp-09; Thu, 06 Jul 2023 11:14:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4E6930005E;
        Thu,  6 Jul 2023 13:14:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85C6F20071AF3; Thu,  6 Jul 2023 13:14:43 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:14:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Message-ID: <20230706111443.GH2833176@hirez.programming.kicks-ass.net>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-2-lukasz.luba@arm.com>
 <20230531182629.nztie5rwhjl53v3d@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531182629.nztie5rwhjl53v3d@airbuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 07:26:29PM +0100, Qais Yousef wrote:
> On 05/22/23 15:57, Lukasz Luba wrote:
> > The user-space can set uclamp value for a given task. It impacts task
> > placement decisions made by the scheduler. This is very useful information
> > and helps to understand the system behavior or track improvements in
> > middleware and applications which start using uclamp mechanisms and report
> > better performance in tests.
> 
> Do you mind adding a generic one instead please? And explain why we can't just
> attach to the syscall via kprobes? I think you want to bypass the permission
> checks, so maybe a generic tracepoint after that might be justifiable?
> Then anyone can use it to track how userspace has changed any attributes for
> a task, not just uclamp.

Yeah, so I'm leaning towards the same, if you want to put a tracepoint
in __sched_setscheduler(), just trace the whole attr and leave it at
that:

	trace_update_sched_attr_tp(p, attr);

or somesuch.

