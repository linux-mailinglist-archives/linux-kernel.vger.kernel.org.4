Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30BB6758A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjATPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjATPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:33:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB91E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PjoJ42EgnGagzBWpbrImMu5qIYgZY+Uq1SMiOfjJCwE=; b=MYFDw6J6w+vjOHbQqp65d7Jpnd
        SKhuANy7rZ71MIIp0Zf6arLF6ikMqARW9PJo641mQp/6JYaV4pWNmOGp4z3jD5RIhuYmAF4UZoagJ
        c5bBPfynEpuejJTPVovQcbOvCFXcCmgdaOan1KOfK0Vu59F6iwdFeUkbSlERHhbefIyr/1c4QAMSE
        FUOTAlxx4AsA3K6puj81qppOrGQ6vvrLZVwgLV9+hb4FteIx3PUAv11qQI0MhcfWa7WUttDBpG74Y
        1Iq0tMRkhDJFguM95s/urrHM2Jds+BcEFwnzWvX9ZnAwdKN74WAyVRSTXeltd0zHVHjWGTJkPeBql
        u8rGXbGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pItNp-00250F-HX; Fri, 20 Jan 2023 15:32:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F56430008D;
        Fri, 20 Jan 2023 16:32:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49013201C94AC; Fri, 20 Jan 2023 16:32:49 +0100 (CET)
Date:   Fri, 20 Jan 2023 16:32:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <Y8q0IfjtKPNxYHFy@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
 <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
 <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
 <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
 <Y8p4CnJU6T7+17Sw@hirez.programming.kicks-ass.net>
 <Y8qr62sZF4HevL75@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qr62sZF4HevL75@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:57:48PM +0100, Peter Zijlstra wrote:
> +extern void __static_call_return(void);
> +
> +asm (".global __static_call_return\n\t"
> +     ".type __static_call_return, @function\n\t"
> +     ASM_FUNC_ALIGN "\n\t"
> +     "__static_call_return:\n\t"
	ANNOTATE_NOENDBR
	ANNOTATE_RETPOLINE_SAFE
> +     "ret; int3\n\t"
> +     ".size __static_call_return, . - __static_call_return \n\t");

are needed to quiet some objtool complaints, but otherwise this seems to
boot and build a kernel.

I suppose I had better go make these proper patches..
