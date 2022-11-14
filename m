Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41CB6286A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiKNRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbiKNRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:08:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A938A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wT6o0OrebUSwzOhZh+3/UUhOPE7I7NzbkchRW0gSA5s=; b=AdBKKJZdfHU5+/m6Myydrl9v6R
        z8fHiRwDgKLzpPsKt6V1dSRWNRXE+M8JJD1VqwJH4DpigXSlt1MN2+6iuqoDt6nvCzXq7HSeD0dA6
        P+yOyr6NlY35XfWX1c5iu6GsOGyozMW35Enfp35fuzUS96/fDWu05L82DHW6C+4paeODZw7/0hET+
        QFnJx0pLEiYUwCOUQ1Y7rs/Zx7yMEdhDz2l0iZqnimmTFnMD3JwEqEaMGrmCKTMF97oTavOSAKYVX
        eor1OCct6ZN5QUTCKWR3LseG6qCp9t4LFXHXxOJjNJNtvNxLry1s0EhIs/TEOPNBOHE7vVN8bSIy1
        iBvXOHfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oucwi-00FZoN-G7; Mon, 14 Nov 2022 17:08:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3438230062A;
        Mon, 14 Nov 2022 16:51:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1199D2C0A1522; Mon, 14 Nov 2022 16:51:08 +0100 (CET)
Date:   Mon, 14 Nov 2022 16:51:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 08/46] static_call, lto: Mark static keys as __visible
Message-ID: <Y3Jj67TZ9tA2a6Pf@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-9-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114114344.18650-9-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:43:06PM +0100, Jiri Slaby (SUSE) wrote:
> From: Andi Kleen <andi@firstfloor.org>
> 
> Symbols referenced from assembler (either directly or e.f. from
> DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> they could end up in a different object file than the assembler. This
> can lead to linker errors without this patch.
> 
> So mark static call functions as __visible, namely static keys here.

Why doesn't llvm-lto need this?

Also, why am I getting a random selection of the patchset?
