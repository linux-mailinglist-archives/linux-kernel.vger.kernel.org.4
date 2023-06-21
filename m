Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9460E73829D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFULcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFULcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:32:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B043E72
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rDVtJ+rsOl47VM5THJFC+Sl5c0+nicbm6KDRLGgH0Rs=; b=g+WVSO2hyrrNoLih+rJSpWIr9g
        t9NuS7d/s68Kte48/26yZmcAoZu+Af2GGQrJRvA/NHGqcBideR2UPpDbOaAdsRd7SrrBa38edrjs+
        vaEBhmVcoGrqRifIopTauqes/HCK7CRq5MTJh7t88F47V2lHhj84jAe76eASzdSEqhH+jWPP6XRm/
        jewJjd0xT658p9nlwuMphZVMJfArz9q7Ok2jKY+AkOp/M+ZeEDn9WKol4wU07nsALs3lMPbQT/aUp
        1CV2YR5hs57kh4pXTkAhmsN9scPnPDVCrPVA516kTIOEiafbWEg1PKHCuZZ72dd6XdGGSEevpOspg
        nOz8Srog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBw4h-00EHLw-S7; Wed, 21 Jun 2023 11:32:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E02F1300137;
        Wed, 21 Jun 2023 13:32:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A36B526671702; Wed, 21 Jun 2023 13:32:33 +0200 (CEST)
Date:   Wed, 21 Jun 2023 13:32:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use recent_used_cpu to test p->cpus_ptr
Message-ID: <20230621113233.GC2053369@hirez.programming.kicks-ass.net>
References: <20230620080747.359122-1-linmiaohe@huawei.com>
 <20230621101915.k323amaxqxjjefzn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621101915.k323amaxqxjjefzn@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:19:15AM +0100, Mel Gorman wrote:
> On Tue, Jun 20, 2023 at 04:07:47PM +0800, Miaohe Lin wrote:
> > When checking whether a recently used CPU can be a potential idle
> > candidate, recent_used_cpu should be used to test p->cpus_ptr as
> > p->recent_used_cpu is not equal to recent_used_cpu and candidate
> > decision is made based on recent_used_cpu here.
> > 
> > Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
> 
> Acked-by: Mel Gorman <mgorman@suse.de>

Thanks!
