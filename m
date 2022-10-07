Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1075F5F7A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJGPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJGPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:15:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA2227177
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CKFD/oTGOiFxEu/pZAva19bWJWF96VfyiRYYlHNKNGI=; b=e1AiAsgug4Glx7OLuStb9Haz1Y
        fJMgJLn3/bjf87Ej8JIIZ8Wh6GwMJzf10H2WMm6cIw/OrJ51TlqdJ5vLDFLSzHhdbj50cKPoyNbPu
        oPkvwQYqqIi9xnUA3WkBB7TFcx3IdXaP0FcknUoU1TjsJIO1KkuoPSTGasjmK2CD2UgFWfJVIvpjh
        Pbvr9oMIGyNvMAsGy/5++uDsRd4xL9qY6ggTU1et1g/C0n4S69Vd+QOEof4KfaU+UgOnhWMxn3yEH
        qyjiJ7CYgaCyEHlMB5fU9vYxPzLo9eZy003cObPe5UmqJS8li2MecbULjIZLDg/e0kbeTvoROw54j
        /P4gB3VQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogp3w-001UU5-CJ; Fri, 07 Oct 2022 15:14:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E816C30006D;
        Fri,  7 Oct 2022 17:14:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D05C82BD95FCB; Fri,  7 Oct 2022 17:14:55 +0200 (CEST)
Date:   Fri, 7 Oct 2022 17:14:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, Jann Horn <jannh@google.com>,
        Natalie Silvanovich <natashenka@google.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: x86/mm: Randomize per-cpu entry area
Message-ID: <Y0BCb7mkLv75BqYK@hirez.programming.kicks-ass.net>
References: <Yz/mfJ1gjgshF19t@hirez.programming.kicks-ass.net>
 <Y0A7ZAjtDcq2PJaX@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0A7ZAjtDcq2PJaX@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 08:44:52AM -0600, Jason A. Donenfeld wrote:
> On Fri, Oct 07, 2022 at 10:42:36AM +0200, Peter Zijlstra wrote:
> > +	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
> > +
> > +	/* O(sodding terrible) */
> > +	for_each_possible_cpu(i) {
> > +		unsigned int cea;
> > +
> > +again:
> > +		cea = prandom_u32_max(max_cea);
> 
> Just FYI, max_cea is 2274876 (at least in my test rig), which means the

Yeah, that sounds about right, just over 21 bits.

> values returned from prandom_u32_max() won't be uniformly distributed.
> Right now the kernel doesn't have a function that does rejection
> sampling to get uniform distribution, but I could add one if you need.

I figured it was better than '% max_cea'.

> Alternatively, maybe you don't actually *need* this to be perfectly
> distributed -- which seems to be a common perspective -- and so this is
> good enough. Your call, but just wanted to make you aware.

First iteration had a LFSR to 'uniformly' and uniquely distribute the
CEAs around, but someone took offence to that :-). Anyway, I think
anything non-obvious is good enough in this case.
