Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729AE74EC00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGKKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGKKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:52:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F5E51
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Z/xC05gLwZtPaZlsQh7rC8ZWVjNqGBhmoZ85nIuO8A=; b=jfAS+5Sp3zFXAatxf9mFmA3h2Q
        axsWxhHwNoJAyosDFgFZ90NVP2nj7WP+CACYofyDjiEM7yiIBsB/qkLTh/wL1KuCe+ZckiTfxSvVU
        A/fV6bVoKMrX672gpR+JLMZ0VmZU4HoEFhiwEgrLwEB3ly0W+gXxaB2HqRRp4zF4YKfSy/eKWy8gK
        iO10+ZsO01o9A9BUK2QtYKvd8MaVHXnm8bEp81muXq9yNINk6k+MGs+PlxwthxW3xxxNxVUb68jcH
        cTNpU9dMjKZ1f2dFaJHnqJwztJL0aC83JWV4zCQm3n60a9iXSqnTQnMzyTYc4I4IFJp53OCkpEay1
        VhbVVfag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJAy1-00Fdmu-S2; Tue, 11 Jul 2023 10:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9460130014A;
        Tue, 11 Jul 2023 12:51:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8531F243429D0; Tue, 11 Jul 2023 12:51:36 +0200 (CEST)
Date:   Tue, 11 Jul 2023 12:51:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 7/7] sched: Move shared_runq to
 __{enqueue,dequeue}_entity()
Message-ID: <20230711105136.GH3062772@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-8-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-8-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Ufff.. so I see how you ended up with the series in this form, but I
typically prefer to have less back and forth. Perhaps fold back at least
this last patch?
