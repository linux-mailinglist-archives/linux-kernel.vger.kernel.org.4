Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B5692010
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBJNr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjBJNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:47:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802D3432A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0lqaZaJHkyrpzRI3A9/gbJ1M1ZHzYmLQlhLEyybnczE=; b=DMqNHzCslZtoXIG7+XkFgc0hYh
        XPMjELfujbW46uFpypzvUTWGzHJ0ZiDY3IXJ6UGBGrwQiZIcqu+80JugKOzCW/K6+OIYGHZdntxcE
        yf/w5Ad+WGKjriTQn/VrTKjx2ZUTUrbwcNaTYxstWWXn6ntrMyxZcq3+yGgwrcuXwo3KBweGjOjzT
        2g90faGIYxGbH+iNI/RNxo+zAhZx+pxMjA2NRRRrgu+JzGG/wv6uhKonVJNYdNk1vh9P9nGhPCpnh
        YejKeB4l13gL5ngQMR95Fv4f/vejv4gDQGgzj+dnbTpuhND+46I20z2s4x1ylx0nb2xOFG2DGn4wv
        7X5xZr+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQTkj-0039Q1-3C; Fri, 10 Feb 2023 13:47:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEC15300293;
        Fri, 10 Feb 2023 14:47:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF7E9209E1AFD; Fri, 10 Feb 2023 14:47:47 +0100 (CET)
Date:   Fri, 10 Feb 2023 14:47:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction^Wreloc
Message-ID: <Y+ZLA/m5sp7aU+Qo@hirez.programming.kicks-ass.net>
References: <20230208171756.898991570@infradead.org>
 <20230209195740.v4dhjuuri53wimui@treble>
 <Y+YHWHjv87qvc+8s@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+YHWHjv87qvc+8s@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:59:05AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 09, 2023 at 11:57:40AM -0800, Josh Poimboeuf wrote:
> 
> > To make the last patch legit we could just have reloc_offset(),
> > reloc_addend(), reloc_type() helpers to abstract access to rela/rel
> > fields.
> > 
> > And I'm sure there are other savings we could do to struct reloc, like
> > single-linked lists, bitfields, etc.
> > 
> > Let me know if you want me to do it.
> 
> I'll make a start today -- I've got snot pouring out of me, so thinking
> isn't going to happen, might as well just do the busy work :-)

(lightly tested...)

Shrinks reloc from 120 to 80 bytes:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/shrink-reloc

pre:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem
post:	4:12.71 real,   188.21 user,    64.49 sys,      18144848 mem

(still running on the exact same allyesconfig image)

I can probably get rid of symbol::reloc_list if I rewrite that whole
symtable trainwreck and I think I can also get rid of
instruction::alt_group, but both of those are a bit more work.
