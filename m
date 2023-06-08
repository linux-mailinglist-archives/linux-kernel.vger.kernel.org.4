Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33D727A09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjFHIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjFHIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9926B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FPWtaDVdvXZWTVU7x6Xobi2mZSJGnrC3Z2LShYUbHLQ=; b=IoeCzYYDonJnkwgesb2CGHFss9
        pioSbiF1sk/OhYC5tlefog4c9WgmjtfTgIZYzjyCKJBJSP5pRWN3+PuxNbFtzSoopRhlv4/Sqwa0B
        ByW4Fm2tmkjn1jX4Tr2wqNiDlGERSl7cp7KpTr4sYofNcP09guqR+PSz72txSGRiNFQ/LuuJkmdJX
        nj0ft7XKU2H7QdMyBfxJAEMdV//Zvrt7EZGuyqMhU5DfCZV92WV915Ny1JnNsvdAkrmvlwXk+M5Eg
        TsDH6DE95PJZNRKl6ti1maQcKqIVz9QpciElKjfvsv/quERXlJjPMjdW8uYSdT2XTRVqUF/cwmgdS
        N0FqzaYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7B5l-00FGkI-6I; Thu, 08 Jun 2023 08:34:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D97D300274;
        Thu,  8 Jun 2023 10:34:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 600FF20D72194; Thu,  8 Jun 2023 10:34:00 +0200 (CEST)
Date:   Thu, 8 Jun 2023 10:34:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/idle: disable tick in idle=poll idle entry
Message-ID: <20230608083400.GH998233@hirez.programming.kicks-ass.net>
References: <ZIEqlkIASx2F2DRF@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIEqlkIASx2F2DRF@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:10:46PM -0300, Marcelo Tosatti wrote:
> 
> Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> ("tick/nohz: Conditionally restart tick on idle exit") allows
> a nohz_full CPU to enter idle and return from it with the 
> scheduler tick disabled (since the tick might be undesired noise).
> 
> The idle=poll case still unconditionally restarts the tick when entering
> idle.
> 
> To reduce the noise for that case as well, stop the tick when entering
> idle, for the idle=poll case.
> 
> tick_nohz_idle_exit (called if the NEED_RESCHED bit is set) 
> is responsible for re-enabling the tick when necessary. 

Who cares and why?
