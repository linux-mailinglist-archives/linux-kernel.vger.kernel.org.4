Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF960BA26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiJXU0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiJXUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:24:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACEDB6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=akJ2W+uE7OGa4ZjTNkn21zAS2A7n6Qf/s+7yzWK/Cqc=; b=IMAKJAcGYm9qO1MftwLm71XddX
        ynVKoU6ZdvsDiCLJIgAR3b2t9GHdJs5on/p85YDgKL28b6tx7iF9pBpV6TnXq59IyT2RO6dB+IQbO
        3uy4JlTKNUFyI8JcNucHyPYGCEyXJXDOHFOru0wnrnt+cKseE3fLJTsqs306WaYyig8Cf+OlA/bIx
        FH2mwjvAVUth7rs2qLqszsJeehR1aVE0BweyogPMNW1zGxjuXhaYwkwM0v9xdeBLSJxQY97tlga36
        4Y8Gu48r4haiCh4D5o38p8BRYREXpO2qlAaQ2eGM2OZGn0TIWA9QM03LVYaJjF3kE1l+AWLBpzet6
        WwM8LY9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omxXz-0064Oq-ML; Mon, 24 Oct 2022 13:31:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 321AC3000DD;
        Mon, 24 Oct 2022 15:31:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1174F2018F17F; Mon, 24 Oct 2022 15:31:18 +0200 (CEST)
Date:   Mon, 24 Oct 2022 15:31:17 +0200
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
Message-ID: <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017211356.333862-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:13:53PM -0400, Waiman Long wrote:
> Commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically
> spin on owner") assumes that when the owner field is changed to NULL,
> the lock will become free soon.  That assumption may not be correct
> especially if the handoff writer doing the spinning is a RT task which
> may preempt another task from completing its action of either freeing
> the rwsem or properly setting up owner.

I'm confused again -- rwsem_*_owner() has
lockdep_assert_preemption_disabled(). But more specifically; why can the
RT task preempt a lock-op like that?
