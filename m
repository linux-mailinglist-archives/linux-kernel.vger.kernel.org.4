Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E346122A1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ2Lzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2Lz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:55:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFC5C968;
        Sat, 29 Oct 2022 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lHdbtESOn5xy1KfsCsCLI2wm3liZxvsQaEV6RBfZqOo=; b=ejx7pkNz1Yp9ZpZYTOxkkh/tjB
        Kg3Gac9JaVwweww1ndnz4CRobtVOWlCqyBtIaTX+SRQ9gl799EEOTWpuJjADtfYfo/bLwTazSFH6V
        HVZWvjclYDJA97SIjo8sKHll0z7fI+8UXYxGCiMz3VgstVa/yYorHtRmMv04H4gKTNAWyrqyqOd7b
        COfc1VkNUmaWxe9lq/I5Ayt5MNbyFBu4J0uTsvX1E/aXcoU6n/Y9ckmCDot0Hj+nUtqYUalpoTISl
        uEmtnz9Z4gRm1RuJXtgol0MM1dTrDyWw0EMmQYygIRAMO0ooNIp2KDxZaSqOzSLSu/2fWpcDlpw1o
        WRFdw87w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ookQs-002331-3z; Sat, 29 Oct 2022 11:55:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1CCE3001CB;
        Sat, 29 Oct 2022 13:55:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84867200F0B45; Sat, 29 Oct 2022 13:55:16 +0200 (CEST)
Date:   Sat, 29 Oct 2022 13:55:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-tip-commits@vger.kernel.org,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [External] [tip: sched/core] sched/psi: Fix avgs_work re-arm in
 psi_avgs_work()
Message-ID: <Y10UpNIGtffsZHXr@hirez.programming.kicks-ass.net>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
 <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
 <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
 <Y1wzVeCYDFSO0KYe@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wzVeCYDFSO0KYe@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:53:57PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 28, 2022 at 08:58:03AM -0700, Suren Baghdasaryan wrote:
> 
> > Not sure what went wrong. Peter, could you please replace this one
> 
> Probably me being an idiot and searching on subject instead of msgid :/
> 
> I'll go fix up -- tomorrow though, it's late and I'm likely to mess it
> up again.

Can you please check queue.git/sched/core ; did I get it right this
time?
