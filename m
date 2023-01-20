Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C367599D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjATQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjATQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:14:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A547151416
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qnq+KIF4kl6KqLYHIBLRa6Y3g89vAecYM2S/QBmY6LU=; b=VAXV86zYPn+OPuYpDTRWSB2BbH
        HMyxH5/Gpv+SJvlj6D4/h9V1z/kGCmjDIhS6PyIqAhUAxYrGe6Bw3uDBySrJ/zYoMZ2mJzLa3AfoD
        xmy0Gu7UCZF+69QPH1LGmPizg+j46893MN81T3SyyZWFKyYZwtHZ2wamoaG5gXt4m7XliXLsGkcYR
        ZPL/P3Bj9x30eESQ3ckujrG9BdbpJjduJl0v15r/A4Wi/fGT7LLgMrvhSLfAx/Mf6qp7xpYA5kcyB
        aZla9Cc0QklvbYzyJjrH04IlEXUJi/msxcqlgkGbiYoC1pMdr7pfgBMMsAUs2FlGwE9G2HDi8BvRb
        Z7viKY7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIu1R-0029HO-5u; Fri, 20 Jan 2023 16:13:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7936C300033;
        Fri, 20 Jan 2023 17:13:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DD2E20DC0E8E; Fri, 20 Jan 2023 17:13:44 +0100 (CET)
Date:   Fri, 20 Jan 2023 17:13:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <Y8q9uKuB1trQuIop@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
 <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
 <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
 <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
 <Y8p4CnJU6T7+17Sw@hirez.programming.kicks-ass.net>
 <Y8qr62sZF4HevL75@hirez.programming.kicks-ass.net>
 <20230120162018.4e48f78c@yea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120162018.4e48f78c@yea>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:20:18PM +0100, Erhard F. wrote:

> Success! You nailed it.
> 
> Applied your patch on top of v6.2-rc4 and with that I got ye olde
> Thinkpad A275 with it's borked custom config + clang -Os(stupid)
> booting again. No side effects to be seen so far..

\o/

Patches now live here: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/core

Will post once the robots have had a go at it. Thanks for reporting.
