Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4605C6F365B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjEASz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEASz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:55:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FAB6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yxDleUQ2J/PiENXcRMI6lXFktbPZYkLi3wBEIWyspt0=; b=SsOr2pOerOAv1gTkFtKYOPCj5O
        Ohu8CHwIRetuJkbs/uuwVxcMs2fQvr3UKHPP309tBF33497Vmd+kviw0olEzyIPIpyfT7v7uw9zOm
        IaMgD56Sn85Y+wQzUA49MKY2vZuSfTDHyJNkRJUNsUvGRE+owe7bpXG0GGKcpsMZn3Ahz/Ew7W4B8
        thJZ0/QHD46eLKvg0ri/XvlWouLn/hhSq4/qB3log6OlE8fTHvG5SobqrVWnYpEXf1f9vzQz0wKIH
        wf8EYNUdFjOUROStwCNKAyP3FWetlLeLJYutZmD4KYV+5yYgfqJiiGDyhZFVhn+bzRhwosSBbaGzI
        SCAnsRkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptYgR-007bFE-R2; Mon, 01 May 2023 18:55:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 403603002BF;
        Mon,  1 May 2023 20:55:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0018823C5C342; Mon,  1 May 2023 20:55:33 +0200 (CEST)
Date:   Mon, 1 May 2023 20:55:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, Chen Yu <yu.c.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Message-ID: <20230501185533.GD1597476@hirez.programming.kicks-ass.net>
References: <20230406152633.3136708-1-chris.hyser@oracle.com>
 <20230429145635.GA1495785@hirez.programming.kicks-ass.net>
 <3fdc9c92-4a4f-b716-c8bc-056111feb3e0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdc9c92-4a4f-b716-c8bc-056111feb3e0@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 12:21:17PM -0400, chris hyser wrote:
> In terms of actually wanting to fix this, I'm a bit confused. It clearly was
> worth fixing the first time around (it has your sign-off), and the only
> thing that has changed is that that fix no longer works.

Well, the amount of effort to fix it has dramatically increased, 40+
extra lines vs 2 extra lines.

> > If we do find we want this (why?!) then should we not invest in a better
> > debugfs_create_u32_minmax() or something so that we don't get to add 40+
> > lines for everthing we want to add limits on?
> 
> I will look at a way to greatly simplify the bounds checking here as you
> suggest.

Thanks, that might make it all a lot nicer indeed.
