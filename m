Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED17386BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjFUOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjFUOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:22:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B019B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MJ/642zHZOOqTrpl/HiTX5NRBKWbAKUu4HSl5kH/V3E=; b=QUdAZlmu7Efc3VxAVqhYZpraeA
        oI325eUcAwlye0o5Le4iokZ7rhRROPqjIq2Rc6x+e+g+/Mjrzdy4bLw10SQoA5RPyv0QULQMRDbp6
        dIFMv+HfpNVTfAw0bIGnCmk9Z7jTHx9YpZZlgTqSXwFTA4RSstes6ukJi+w83t5Lrscb3ubdpq/yX
        bKc4VPu8+uNLRCYOR/LQZgZXq60Rt7Q404lfMBpCl8O4H9IeF3TxMD3g/gB2vquGCW97HCSQHuMgE
        ljuoBjXBQb2yB7+j+lhFmHkE5meVufvYvriKQodPcMC6iVD84ARnWj5pG9e1wOqQitEH1+Si2GZwM
        9AF7SWtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qByiq-00EPdE-P8; Wed, 21 Jun 2023 14:22:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E60A3002F0;
        Wed, 21 Jun 2023 16:22:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 460CD2130B3BB; Wed, 21 Jun 2023 16:22:12 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:22:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230621142212.GH2053369@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <CAKfTPtCT==N_r1Vp-e_cFtVmcdo_YN1aD45AfbLMSpGpu1oU=w@mail.gmail.com>
 <20230620195423.GB3027191@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620195423.GB3027191@maniforge>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:54:23PM -0500, David Vernet wrote:

> Another consideration is that even if we could adjust newidle_balance()
> to load balance well enough for our specific purpose, we're still
> relying on heuristics to determine when it's appropriate to load
> balance; and that will 

Your thing has heuristics too.

But if we're going to do this, then it should replace newidle <= LLC
domains.
