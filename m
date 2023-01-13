Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8102A66981F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbjAMNMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbjAMNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:11:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84C3E84E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sfJlOYO8oT2oPc3YcXscu+eA6dh/Ct/nDZR0RvIAf6Y=; b=XiIJ6939tE1F6/5MIyvqQRsyX4
        zPQinpFwfCbUsr/ZeCKo0iPXa9gyR5C0u68GCX0LDeo4dwCSAuqGb1HcuNOc8EyIGcJlVk6QLr1sG
        3cTf/k7bOSKHZ5APi0Ip5t1q5jaPxnaaPwBGJY5teGYcBo0PPK9+hh1ipyYmWLNoBt/u2z+4wFvt0
        a/Pk3KzwPw7M9ERS7wWijK4ZoSmJCRqII4YP6dO0Z1jEHF5lhvvIIMmcRws26s7y6QzGOCEIPkv2J
        3hZs7m/RgwXavhyuPQO6FvjYJwAN6OjHM1gmDFTiNaUlXMGJb/cdlCfeemQxfBC4UgHBaVDU5QWeu
        9aIi9Flg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGJfH-0066XJ-Al; Fri, 13 Jan 2023 13:00:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5685300642;
        Fri, 13 Jan 2023 13:59:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A17DB20B8E4E3; Fri, 13 Jan 2023 13:59:56 +0100 (CET)
Date:   Fri, 13 Jan 2023 13:59:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        x86@kernel.org
Subject: Re: [RFC][PATCH 0/6] x86: Fix suspend vs retbleed=stuff
Message-ID: <Y8FVzPWQOHl0H4CY@hirez.programming.kicks-ass.net>
References: <20230112143141.645645775@infradead.org>
 <20230113073938.1066227-1-joanbrugueram@gmail.com>
 <Y8EhucZfQ2IyJtnU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8EhucZfQ2IyJtnU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:17:46AM +0100, Peter Zijlstra wrote:

> > (2) Tracing with QEMU I still see two `sarq $5, %gs:0x1337B33F` before
> >     `%gs` is restored. Those correspond to the calls from
> >     `secondary_startup_64` in `arch/x86/kernel/head_64.S` to
> >     `verify_cpu` and `sev_verify_cbit`.
> >     Those don't cause a crash but look suspicious, are they correct?
> > 
> >     (There are also some `sarq`s in the call to `early_setup_idt` from
> >     `secondary_startup_64`, but `%gs` is restored immediately before)
> 
> OK, I'll have a look, thanks!

Definitely fishy and I'm not sure why SMP bringup doesn't burn. Trying
to figure out what to do about this.

One thing I noticed is that trampoline_start already does verify_cpu,
and perhaps we can make startup_64 also do it, then secodary_startup_64
doesn't have to do it (and the realmode trampolines aren't patched).

Doing that would also require pushing the whole SEV thing into the
trampoline which them also gets rid of sev_verify_cbit I think.

But this definitely needs more thinking -- this is not an area I've
poked at much before.
