Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596825EF351
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiI2KTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiI2KTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:19:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613D1A23F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rxft7ndABZ9qipjmBrDh9jvHt6lSVgY5Ltx6M5fli+k=; b=m62FxX2Xjy07MFozwP9i95kRSB
        pfbC9DBqcK76cT2Qjux3Nz1NzHu4bfmWdyNXoKCbfx6GD/uAR9cJ3gmmHT2caOP1b8Wd1RuZpwxdB
        SIfKZkPa/LrqKwqgHFdxHZAS8F4qbwLhYEKEn57XOI5xtBD4vT/RK+spliUrKpWaX3XoyAUwWhTDE
        J5vdOmPHZ85AtQ3vGzdfZ+3IAv9r/ZSxN+j9oEM+6QhBMsd+4bYkKmLgEOqijITx4S08XY1/Pup/l
        TJaGhqBTe5913R0cTi++3RYBPT7sSfNTo/gkTPX0dyqg6lZSQbpIVWCMIbiwyBz0frI6YYdFbn7vc
        EdkL64Gg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odqdP-00DBpE-Ak; Thu, 29 Sep 2022 10:19:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E33530008D;
        Thu, 29 Sep 2022 12:19:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032B6203D391A; Thu, 29 Sep 2022 12:19:10 +0200 (CEST)
Date:   Thu, 29 Sep 2022 12:19:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, ananth.narayan@amd.com,
        ravi.bangoria@amd.com
Subject: Re: [PATCH 0/2] perf/x86/amd/lbr: fix LBR filtering support
Message-ID: <YzVxHn4PPnMTlZxi@hirez.programming.kicks-ass.net>
References: <20220928184043.408364-1-eranian@google.com>
 <YzVT/TQtkoerDPFV@hirez.programming.kicks-ass.net>
 <388f2491-3b66-50ca-6f65-b5003bf3257a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388f2491-3b66-50ca-6f65-b5003bf3257a@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:00:07PM +0530, Sandipan Das wrote:
> On 9/29/2022 1:44 PM, Peter Zijlstra wrote:
> > On Wed, Sep 28, 2022 at 11:40:41AM -0700, Stephane Eranian wrote:
> >> Short patch series to address some kernel issues with the AMD LBrv2
> >> enablement which were introduced in Linux 6.0.
> >>
> >> Stephane Eranian (2):
> >>   perf/x86/utils: fix uninitialized var in get_branch_type()
> >>   perf/x86/amd/lbr: adjust LBR regardless of filtering
> >>
> >>  arch/x86/events/amd/lbr.c | 8 ++++++--
> >>  arch/x86/events/utils.c   | 4 ++++
> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > If you want this in perf/urgent you're missing Fixes tags.
> 
> That would be:
> 
> Fixes: df3e9612f758 ("perf/x86: Make branch classifier fusion-aware")
> 
> and 
> 
> Fixes: 245268c19f70 ("perf/x86/amd/lbr: Use fusion-aware branch classifier")
> 
> for the 1st and 2nd patch respectively.

Thanks; but trying to queue then in /urgent resulted in me finding out
they're not at all slated for 6.0. The AMD LBRv2 stuff is in perf/core,
waiting for 6.1 to start. So I'll just go queue them there.

Still, good to have Fixes tags on them.
