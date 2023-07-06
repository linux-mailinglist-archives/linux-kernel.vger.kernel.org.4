Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8204749981
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGFKa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:30:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42751DD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JQkBABxbcBPjRsvz232SlGsXKwv/W7a4/roDpYtgz6c=; b=sr69by/ciVy3IjydXe3wv+AdF6
        VYMraV2ahn3k+GMOknHCFxN+FzKH406SsCIpHzoZ3kKS6pEnKLk85OilgqkuX9D1r8X4xCWF1VOuo
        /jyAOO+a2spLEJHAUcvZ6Q1rW88W/5UjlUrTe5GmAMuasp5LRlFtuZ+3Ig5Ty1pUHx1kzNbBxh/dx
        DPqfJRZFOjXOrPiuv/u2ADJSwdAhwRExSoJcWdP4NlyhePEg3xpSBB/WQKMxyU1M0EEyWsjz+G+YE
        WRzL+6qPIeGYxc/r18KakSoDQSpJoeSpYIDalIbN5D414icYRsiHVWasVN21eNfYXIHq6m4iGYiGF
        qdH+z6Sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHMFC-00AyH2-O4; Thu, 06 Jul 2023 10:29:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C08A3300274;
        Thu,  6 Jul 2023 12:29:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96AA820071AF7; Thu,  6 Jul 2023 12:29:48 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:29:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, surenb@google.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] sched/psi: make psi_cgroups_enabled static
Message-ID: <20230706102948.GG2833176@hirez.programming.kicks-ass.net>
References: <20230525103428.49712-1-linmiaohe@huawei.com>
 <20230525174937.GA34467@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525174937.GA34467@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:49:37PM -0400, Johannes Weiner wrote:
> On Thu, May 25, 2023 at 06:34:28PM +0800, Miaohe Lin wrote:
> > The static key psi_cgroups_enabled is only used inside file psi.c.
> > Make it static.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> This was previously submitted by Tom:
> https://lore.kernel.org/lkml/20230405163602.1939400-1-trix@redhat.com/
> 
> Peter, could you please pick this up?

Found it, will queue after -rc1.
