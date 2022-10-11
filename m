Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC725FAE54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJKIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:24:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC075BA1;
        Tue, 11 Oct 2022 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UykTJ7aWjC0CKU4x9PgcpHxD5DYk8iJQd5iBQkWjMTk=; b=c+MzSjAxmmB0/S1jD//ocqinK1
        RiN3+LuJMBRcdZ+TdbDvXcKuRj61y8IbMoawQiCVBzoXh39LlkTu/Eb6E5dQJ5270kWTAoXpDuyMV
        /AJS63N2Q9nsseYasm6d032m92km9XGf3N6Ppy9tk0jOzcNMUb4PJbfb7jtujUSVU4L66j13bvLCm
        numbJxW7IuXv7ZaSLs05jFNnW4GzUO4HoGIZfNGrV62c9FRBbO3VIMhzWs7DKjigg10ixHZjAVMbo
        dDa6hF/vuC6WqgWVP+hxoMsLbiDOtL/WmPHzqQ3C0+K3/oZwt3Xuue7AsC8POttpNdjDnKIHJbBM6
        y2ePx0dQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiAYy-004o4V-Kq; Tue, 11 Oct 2022 08:24:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DBBC3001CB;
        Tue, 11 Oct 2022 10:24:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2082B20E1D7E5; Tue, 11 Oct 2022 10:24:27 +0200 (CEST)
Date:   Tue, 11 Oct 2022 10:24:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.1-rc1
Message-ID: <Y0UoO2+NsJjbZtaf@hirez.programming.kicks-ass.net>
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
 <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 06:20:00PM -0700, Linus Torvalds wrote:
> The other thing I notice from just doing a build is that I now get
> 
>    vmlinux.o: warning: objtool: kasan_report+0x12: call to
> stackleak_track_stack() with UACCESS enabled

So kasan_report() is already marked as being special; and it does the
mandatory user_access_save() / user_access_restore() things to fix it
up.

But it looks like kasan code itself is now getting instrumented by the
stackleak stuff and that inserts a call outside of the
user_access_save()/restore() thing, and *that* is getting flagged.

Looking at mm/kasan/Makefile it disables a lot of the instrumentation,
but perhaps not enough?

I've not yet tried to reproduce, I'm taking this is allyesconfig or
something glorious like that? LLVM-15 ?
