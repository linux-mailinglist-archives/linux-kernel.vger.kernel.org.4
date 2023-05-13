Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A437015DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbjEMJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:45:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01BE63
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=El0l087sOFY6OAgFSr8oWIIFy6Mx+wASTh5jlhfwCH4=; b=kxjyN2u4NjJaQp/QDPkIldUon/
        yWTeTsf2ZkV4fY8YJslXYtCuSljSby77Mym5m8glpDQClsv0urqzcKxtDc8VL6wniPj79RSeq2CSR
        2SV0rJAqnfulAdeoMT9H9jtRN6MbrymMZK+eP+TlHLF/LNKpfaKL9Mbe3kNT5BaLcD8jVJprKBLjL
        pVeRmmDc91Ert1rfjhfPD5LMMozEBbHePfVSv7TOxNdyDXyi891nfwVntP6w60pO3yhKgz9VhxyPy
        PwgkLgY+mktypL/wveNgzzJt+PKZWedtv3JqmNpHCFmDziNesByvHG6h19/6/A0KsPm97QewS8ffU
        Nz8UY99A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxloM-001aEq-MD; Sat, 13 May 2023 09:45:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36B203000DC;
        Sat, 13 May 2023 11:45:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0539C24178BCE; Sat, 13 May 2023 11:45:08 +0200 (CEST)
Date:   Sat, 13 May 2023 11:45:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     yang.yang29@zte.com.cn, mingo@redhat.com, axboe@kernel.dk,
        tj@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: [RESEND PATCH linux-next] sched/psi: avoid resetting the min
 update period when it is unnecessary
Message-ID: <20230513094508.GC4253@hirez.programming.kicks-ass.net>
References: <202305121642367753446@zte.com.cn>
 <CAJuCfpEC67SBGFSCOD9TykwE_BR2ax5+T4XUKhq_U=qBJttMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEC67SBGFSCOD9TykwE_BR2ax5+T4XUKhq_U=qBJttMgw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:56:02AM -0700, Suren Baghdasaryan wrote:
> On Fri, May 12, 2023 at 1:42 AM <yang.yang29@zte.com.cn> wrote:
> >
> > From: Yang Yang <yang.yang29@zte.com.cn>
> >
> > Psi_group's poll_min_period is determined by the minimum window size of
> > psi_trigger when creating new triggers. While destroying a psi_trigger, there
> > is no need to reset poll_min_period if the psi_trigger being destroyed did not
> > have the minimum window size, since in this condition poll_min_period will
> > remain the same as before.
> >
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> 
> Hi Peter,
> This is another psi-related patch that slipped through the cracks.
> Could you please take it into your tree? The original one [1] had a
> different title but the same code.

It does not cleanly apply to tip/sched/core; could either of you rebase
please?

Thanks!
