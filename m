Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE570F854
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjEXOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjEXOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:08:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFEE18C;
        Wed, 24 May 2023 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZElh3inBw5eGIDiW0Pg939ijd8l5AaxQuiOExPhpig8=; b=DwZ91V1Uj89ekLj6Qt3Bw1SBxL
        TZke4gSQ4aXmJJWwjcaWvAIGp+ugDcjDa5uBv2q099VRvS7P5agmTBMa6mchNYa+lmIcxUnrth/FY
        e3j6thONzYPJOWWO67qYCp3w5bpIsj9CQgtVI8vlQ8lmjFGFTIuxgopwKfQibfKU9IGQwpbLuZniI
        QDXkfgC2BFDY8xrXTygcUMGIzTwr/qlIEBXpKdskBo4ltbov7LHV/9UMVjYuCXIh4KjrVNnAM+DLe
        vNYPnG52fcj7Ur4whekePkJESXeFztjwDPw/qWBLExhPhu9PgzFmKyj7pgaA+D14YldT44hRjfro6
        VbldiJww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1p9X-004zv2-1q;
        Wed, 24 May 2023 14:07:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB1233006B1;
        Wed, 24 May 2023 16:07:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C01820A99305; Wed, 24 May 2023 16:07:44 +0200 (CEST)
Date:   Wed, 24 May 2023 16:07:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
Message-ID: <20230524140744.GK4253@hirez.programming.kicks-ass.net>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:32:20PM +0530, Naresh Kamboju wrote:
> While running LTP controllers following kernel crash noticed on qemu-x86_64
> compat mode with stable-rc 6.3.4-rc2.

Both your reports are stable-rc 6.3.4-rc2; can I assume that stable
6.3.3 is good?

Either way, could you please:

 1) try linus/master
 2) bisect stable-rc

I don't immediately see a patch in that tree that would cause either of
these things.
