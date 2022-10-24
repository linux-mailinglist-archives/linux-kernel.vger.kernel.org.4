Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C4609E65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJXKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJXKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:00:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEF740E37
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G8UKir9gg9i/9nT/L0vrBr4zL64OWY3kKm2Uqw5po/c=; b=OncPPm2eB6p6tyx8LFabIEegh7
        pAH9YpmDFpphRQnjAXEjKQbjgcEO9SzE8DCbDhEgpHFPCROfx9oC644bPKMOHNZPIOcE4WFZHrf8t
        kK1bFHSSZDmXE31QGC/SO1Sy+e6zfJLQINDtS/AKGx+Aj/jzzKM/FJKGHZIFDGVBX2kUWDCh021wt
        dq31qzD/5yyWRfZKsceMWHdAEblTvRYx+yT528/V2d9+9aXP8qUTXceLw/y+17RvnokxzZmQ5fr+E
        pLeRvmJlAGzm+uDOZCovQ/MGNhGFxnay5eCfR1vnazG/i/LvoQ7rVNkfu/HAPoMS2/68WaGAhhXZK
        Q3J2pr3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omuFh-00629h-04; Mon, 24 Oct 2022 10:00:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01B1E300205;
        Mon, 24 Oct 2022 12:00:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D927D205CCF48; Mon, 24 Oct 2022 12:00:11 +0200 (CEST)
Date:   Mon, 24 Oct 2022 12:00:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Optimize the process of scanning CPU for some
 functions
Message-ID: <Y1ZiKz1rxEcQ886D@hirez.programming.kicks-ass.net>
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021061558.34767-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:15:56PM +0800, Hao Jia wrote:
> These two patches optimize the process of scanning the CPU by
> adjusting the search order or breaking the loop.

Is it really optimization, as in it now runs measurably faster, or just
cleanups?
