Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C560D554
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiJYUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiJYUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:14:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2E356CB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dBpIq/TdGK7Y9QgaqRjiNwMRg2hbzqbzJ+ZsxtPyXYc=; b=gGG7yAkeqEaBVMVkty7OvpYCdH
        NO6y7z3X4O/jaERksvcYe77kTxJkxYT4Z5uHGjzQp4sjFeT6ifeMdBY5duWXPt9rHazGIki2jfbs5
        D9Yqhq3KI9P2QxGFqys7PwT/qNepO21MlnB24rKlJGcPjbdgXZqzhnVE244fGM2UP01Pq1pgUAaCM
        9JwH8EhCLqpLSA8lwv+UgNF92nBB6AsB0IpwhFwkOcS3E1in484DwQAGi1w0ZgvU+PK3YItNwLFfB
        DgoMBiAF3GjnGxDjHEIuDIk5jt2A4qTmP4TVbqeP1IgM57+gMv2R08Kn+UuoYrqXWrYLEWH+sCVy3
        DWr7kOAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQJr-00GWLL-La; Tue, 25 Oct 2022 20:14:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1EBE30017F;
        Tue, 25 Oct 2022 22:14:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D43D3203DC845; Tue, 25 Oct 2022 22:14:33 +0200 (CEST)
Date:   Tue, 25 Oct 2022 22:14:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v3 2/5] locking/rwsem: Limit # of null owner retries for
 handoff writer
Message-ID: <Y1hDqerj3MjgmDTT@hirez.programming.kicks-ass.net>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-3-longman@redhat.com>
 <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
 <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
 <Y1fG7nQxiLyKIhQ6@hirez.programming.kicks-ass.net>
 <Y1fNJZ9SALWlmoon@hirez.programming.kicks-ass.net>
 <d67740dc-d608-4b1a-0889-b9861153fdf3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67740dc-d608-4b1a-0889-b9861153fdf3@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:55:09PM -0400, Waiman Long wrote:

> That is quite a number of changes spread over many different functions. That
> is the kind of changes that may make it harder to backport to stable
> releases.

Yeah; don't care. it's the right thing to do. It also doesn't need to be
reverted since it's a sane and good property for lock-ops to have.
