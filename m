Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47567E4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjA0MSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjA0MSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:18:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004419F30
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C7nFkPl7lubRhxaJVnuEdeLBgE/QirVa7r2a+1q8ftY=; b=C5tF6DY71tsSBvUzBNyQW97/NX
        lFfu9QYIc5s2xLfT6Km//lYmdxTvjyagG5R6HWG8h1bq4yn1IzC3jU1mABI/z5ogOhz49XdsGarpk
        mcNxGdmzZ+ddgrlZc+9N7yb63ATX25oh/ziRkyr4jRlQQ0xjoPr4loecK5cCTgh/ePCHwBGlITjur
        eCSfUE/9RoLknLbhG1fhvxaM9hKq69RqAYYvuSFVwUykJS9uJbx7FV0mgblwnyJBZs++Q3m6pGzFZ
        1RQ0OXVI+k9RMwUpWTgf3mxhvGi0iZOB3lgE4xtE2MVA9BOKHWPouPuEJweDguF0Bjfu8AclBmClW
        E8BFBfwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pLNcX-002mCX-08;
        Fri, 27 Jan 2023 12:14:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2DBE300446;
        Fri, 27 Jan 2023 13:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DB41209E6751; Fri, 27 Jan 2023 13:14:47 +0100 (CET)
Date:   Fri, 27 Jan 2023 13:14:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: objtool warning from next-20230125
Message-ID: <Y9PAN12SPHuGL99G@hirez.programming.kicks-ass.net>
References: <20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1>
 <20230126205954.zk3t4fpmxqowfu2d@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126205954.zk3t4fpmxqowfu2d@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:59:54PM -0800, Josh Poimboeuf wrote:
> On Thu, Jan 26, 2023 at 10:23:02AM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > I have started seeing these objtool warnings from a wide variety of
> > KASAN-enabled rcutorture-related test scenarios in next-20230125.  It has
> > been awhile since I tested -next, so I am not yet sure where this started.
> > 
> > vmlinux.o: warning: objtool: __asan_memset+0x34: call to __memset() with UACCESS enabled
> > vmlinux.o: warning: objtool: __asan_memmove+0x4d: call to __memmove() with UACCESS enabled
> > vmlinux.o: warning: objtool: __asan_memcpy+0x4d: call to __memcpy() with UACCESS enabled
> > 
> > As usual, should I be worried?
> 
> This apparently came from Peter's
> 
>   69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> 
> but I have no idea how this is supposed to work.  Peter?

Durr.. I'm not sure why I put them in the uaccess_safe_builtin[] array.

So yeah, this reproduces using defconfig+KASAN, removing the functions
from the array shuts it up and doesn't generate new ones -- for that
config.

Let me try and build a few more .configs...
