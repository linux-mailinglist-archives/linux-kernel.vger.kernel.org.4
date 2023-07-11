Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE374F52E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGKQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjGKQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:30:17 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7B10CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:30:16 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-765a5b93b5bso550994185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093015; x=1691685015;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TzW/vBHbXTAjjFGYmRarEsX18HaY+lFJnEIK4F63G8=;
        b=B+lPTm7DysdiRLLUBm1ibbBncKITqz4qfw90GKRskiN7K6GhhZRwfC0bo9kTw87RS5
         jPd7iRgKtld1eUX75GIMg1LMRrNml5F6FA6xoqms2Mc+++M9u+Gux2KMnz3lkxywGHGV
         enrGvlOQhpp/AGDCZSakm2t3TX0G+kXPWRfT+/b0N+IlXk/Fs9X1/L0KUXE4JcbvkeCD
         hAaCdvdcoUW0VGRE9JmwDMvKGX8zZN0rnxlwrklYEkMGldxdDa9hUyOkWLAoqqMLfJzd
         SUvPxOtmBkI88/NUCIpf+Fc/PI+z/mUjiOrFINhe+Q+gviGC8K8yLFWIBws0sNksgdLi
         ZmIw==
X-Gm-Message-State: ABy/qLaqGDklZPIKTT2S7ULtCpQ6BK1TDSDU9e2SZocjzjooH5L8FEui
        OONVhsvDXdrQdCwX8p59c4k=
X-Google-Smtp-Source: APBJJlEYDS1O7/Ysnpnw8YSZmsZUYvKfbzZDz6CgFE2QnE113NxfKjlex9PUY5xbVSz4Lgr4xbeJDA==
X-Received: by 2002:a05:620a:c47:b0:765:6542:d9fa with SMTP id u7-20020a05620a0c4700b007656542d9famr20744930qki.11.1689093015326;
        Tue, 11 Jul 2023 09:30:15 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1d49])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a13b000b0076718652789sm1142593qki.117.2023.07.11.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:30:15 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:30:12 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 7/7] sched: Move shared_runq to
 __{enqueue,dequeue}_entity()
Message-ID: <20230711163012.GC389526@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-8-void@manifault.com>
 <20230711105136.GH3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711105136.GH3062772@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:51:36PM +0200, Peter Zijlstra wrote:
> 
> 
> Ufff.. so I see how you ended up with the series in this form, but I
> typically prefer to have less back and forth. Perhaps fold back at least
> this last patch?

Sure, will do. I kept them separate so we could drop this patch from the
series if we didn't want it, but given that benchmarks seem to only
improve with this (if we also shard), I'll just fold this in with [0]
and the patch following it.

[0]: https://lore.kernel.org/all/20230710200342.358255-5-void@manifault.com/
