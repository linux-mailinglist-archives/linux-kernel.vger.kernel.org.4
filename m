Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B446A1090
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBWT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjBWT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:27:15 -0500
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CDF2A14E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:27:11 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677180429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=93bVx02zlbrQnwTZTSNvShQJzlPpRkLQRK5G6ygAYkI=;
        b=ANS0VwXQ5R75DFJwYzHTfscfnypBDkctiE/0MdkqW0mc+MWrHU9pZOeSX1SalRhrI5Df5h
        Tew7dq4flfvT96bBgPGdnEtLizdPq3nyr7oGoelPt/KcY6Sj/9osioABpBgZbvzDyPlJ1E
        IodgdtSbiBDavJ/28X3xzlyQ+TB355E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: Re: [PATCH 1/2] lockdep: lock_set_lock_cmp_fn()
Message-ID: <Y/e+Ci5ptzJT84wq@moria.home.lan>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
 <20230218032117.2372071-2-kent.overstreet@linux.dev>
 <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
 <Y/QHn+PecW2n2K5O@moria.home.lan>
 <Y/djxk1q5EiYHFfF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/djxk1q5EiYHFfF@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 02:01:58PM +0100, Peter Zijlstra wrote:
> I would suggest the same as last time; integrate this in the class
> setting zoo of functions.

I don't really see a particular zoo, things like pretty scattered to me.
With lockdep_init_map_type?

> If you insiste, please keep it one function
> and force print_fn when cmp_fn. We don't want people to skimp out on
> this.

That's easily done.

> 
> Other than that, I don't think this can fully replace subclasses, since
> subclasses would allow lock hierarchies with other classes inter-twined,
> while this really relies on pure class nesting.
> 
> That is:
> 
> 	A/0
> 	B
> 	A/1
> 
> is a valid subclass nesting set, but you can't achieve the same with
> this.

Why not just assign those As to two different classes?

> That said; it does seem like a very useful additional annotation for the
> more complex nesting sets.
> 
> Thanks!

Cheers
