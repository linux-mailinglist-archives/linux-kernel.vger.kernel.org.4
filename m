Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524BE6A2AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBYQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBYQnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:43:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552EEB42;
        Sat, 25 Feb 2023 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pM83uqbXqTHLmOlK/mY3HQLkQc9Qi4g0v5iw3hpj/zc=; b=o86srJca1jHtuxhY168Jnhqesx
        8H3fkrBmKYRCu11Yu87tVmiuxZ2T4hdTNsXMxwcFlLycWYObBT1vgVrdaMrim3pJFNPJpFW+ut5uR
        ntAlv/XXKZf9GTbybMlGmwQyRFH4ECGh5nwjlYSYfgOwA53TazTbARxW6/b80lqKe55gTh7jVi2WA
        2KpKAR7wNHuJMq6D7kqUmOmQ3KOG5TmEKdkIU71tF2EmTmabExsT5l5MBlfVOSbugWZvjid9KQxby
        4oux0HwsXmVC8Hf7rH6+rYoJgcEmEph88feT9+8Z4KOMa0XXQKxoPM41txm2RpK+/HNQuo37x0a9Y
        qnF8hvSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVxdU-00GEwG-Kd; Sat, 25 Feb 2023 16:43:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E41C300033;
        Sat, 25 Feb 2023 17:42:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A216209F7545; Sat, 25 Feb 2023 17:42:59 +0100 (CET)
Date:   Sat, 25 Feb 2023 17:42:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Beeman Strong <beeman@rivosinc.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: Perf event to counter mapping question
Message-ID: <Y/o6k6RMjEKyb1Nb@hirez.programming.kicks-ass.net>
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
 <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
 <CAP55G9A=z2cM1TEDJ1prAsqfpa0xqvB21RP3omd3aBZ47ixceg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP55G9A=z2cM1TEDJ1prAsqfpa0xqvB21RP3omd3aBZ47ixceg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:48:35AM -0800, Beeman Strong wrote:
> Hi Peter, thanks for the feedback.  Can you say more about AMD's
> overlapping constraints?

bc1738f6ee83 ("perf, x86: Fix event scheduler for constraints with overlapping counters")
