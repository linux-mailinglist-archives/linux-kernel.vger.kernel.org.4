Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5062876E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiKNRs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiKNRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:48:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422322515
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IsUyS38f+l1a8x4Kf/i7TrtAyeuaOWOUYXGxNjKlgTw=; b=awZ8yFNthjh5BeK8CcaRz2uVZj
        MPAYwsyQsf9X64hT3EPKTClqFyMlDDuB07ch6N0vcGCd5pBgXGoY2c+QuKaWiJUny0eTVJwVjjnUP
        d7VMrRg5DtSWpYKVd0NNK+jGA269eiX+eeLbqZ09Jj5/KREJy4csCY43XkCV5N1EqlECu1IWyhAS8
        aAPkAw4H+5gGqEqXk4oC09bADdDjJUWPoLobIyTEZtv4HQjDDVNhakAnjUoTpZidx3OC229mbiHYM
        AHWiTrxRq8gEjaXf5FkjmBk4BFhUMpwQFZ9M69NVFI7vy0YNV2oVqNrHsy7XlL7Xs52gG1U3tSyoZ
        AZQnqQZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oudZP-00FcSy-Kg; Mon, 14 Nov 2022 17:48:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC2E83010ED;
        Mon, 14 Nov 2022 16:54:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB5A92B891F5A; Mon, 14 Nov 2022 16:54:16 +0100 (CET)
Date:   Mon, 14 Nov 2022 16:54:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 10/46] static_call, lto: Mark func_a() as __visible_on_lto
Message-ID: <Y3JkqDBR0zgaTyPn@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-11-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114114344.18650-11-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:43:08PM +0100, Jiri Slaby (SUSE) wrote:

> -static int func_a(int x)
> +__visible_on_lto int sc_func_a(int x)

>  } static_call_data [] __initdata = {
>        { NULL,   2, 3 },
>        { func_b, 2, 4 },
> -      { func_a, 2, 3 }
> +      { sc_func_a, 2, 3 }
>  };

I must say I really hate this. Also, with address taken, it still
eliminiates it?

This whole GCC-LTO sounds sub-par.
