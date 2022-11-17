Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772F962D4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiKQIYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiKQIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:24:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD5B27FCE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=24lQ+vB2A9HKyuZWwcPYI0llW6cx4tLwTs8kPnawQG0=; b=KJLYsWFxNDxSqACXhkvA0ynOpL
        J43a0H0SWNiDhsCqhpXIcKphHTLcibi61SUpuwtu3pbq0SUeEBwYDNXa2RKIeWhU/Z6eDu0d1b69r
        l1xSK8NY18iHb5EK1gl2T7nv5lCBwksuT0KawAmm1a5y3PZ/0DMKXmZRtLItNuXIAMyvvdGVjq3jn
        DWiIa4p7uiincVinbDRx/jLvl32wAz85AWuptfkYTwMg4aPjxQ5Jt+4yOn+K79W4ooCZHj3n7wqJ8
        oZOmcAx5O3NIybmkLOB5FPf26OHUfMpZFTTgicv/+oa2AFEHtpN2hxvjcT+9IX3q2s7v1x9FQTnky
        +ov91RZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovaC2-000ngc-Ue; Thu, 17 Nov 2022 08:24:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE6E1300137;
        Thu, 17 Nov 2022 09:24:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C4EE200FC693; Thu, 17 Nov 2022 09:24:11 +0100 (CET)
Date:   Thu, 17 Nov 2022 09:24:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 08/46] static_call, lto: Mark static keys as __visible
Message-ID: <Y3Xvq/TXwtLt4uon@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-9-jirislaby@kernel.org>
 <Y3Jj67TZ9tA2a6Pf@hirez.programming.kicks-ass.net>
 <20221114203433.2pskttlyqjo3gua7@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114203433.2pskttlyqjo3gua7@two.firstfloor.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:34:33PM -0800, Andi Kleen wrote:
> On Mon, Nov 14, 2022 at 04:51:07PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 14, 2022 at 12:43:06PM +0100, Jiri Slaby (SUSE) wrote:
> > > From: Andi Kleen <andi@firstfloor.org>
> > > 
> > > Symbols referenced from assembler (either directly or e.f. from
> > > DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> > > they could end up in a different object file than the assembler. This
> > > can lead to linker errors without this patch.
> > > 
> > > So mark static call functions as __visible, namely static keys here.
> > 
> > Why doesn't llvm-lto need this?
> 
> It has an integrated assembler that can feed this information to the LTO
> symbol table, while gas cannot do that.
> 
> There was some discussion to extend the gcc top level asm syntax to 
> express external symbols, but so far it doesn't exist.

Urgh, that's ugly too. Why does GCC insist on ugly solutions; clang has
shown it can be done sanely, follow.
