Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28F6033BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJRUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJRUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:05:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7019399E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hEyTJ01sZLFKOSx1A/k1KivyIirrO5cvl1Pq/bkC22s=; b=dgmT0t2RJW+4XDqw9ATFF5xVbd
        UA4uohpamh5aWPqVv9hMCS5Zb50x0RW8ZYUO9atSeH7H6GDEU45SmvPGbsfti4SW/QKtAJNt07GUz
        QWU3jULZUbdw0P7i6d2PzCfEZbJ2uQiYfIoZnwo5Vk9YyjiGBe4Sgvsau9nUbSNcFbsYBSWwk0h5o
        ssWfUUsljju/7Bj7zgy+j2t1Jhl3eLIfpcTwaLssCorFvHsjOEeBYg6TYo3pLJQtN+Jengeh/h1Nh
        h8ByKaAp9LeRxTneGGg+bsMTK5vjXw9dor+SLs3vC73AUjP3upcjuItawSB4BN19UCNsKjmu7mo3A
        Oprb8/rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okspo-00AzCD-CE; Tue, 18 Oct 2022 20:05:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BC8930008D;
        Tue, 18 Oct 2022 22:05:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CFE828576661; Tue, 18 Oct 2022 22:05:03 +0200 (CEST)
Date:   Tue, 18 Oct 2022 22:05:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y08G73HOddpS40ny@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210181020.79AF7F7@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> I still think it's worth noting it does technically weaken the
> "attacker-controlled executable memory content injection" attack
> requirements, too. While an attacker needs to make sure they place an
> ENDBR at the start of their injected code, they no longer need to also
> learn and inject the CFI hash too, as the malicious code can just not
> do the check at all. The difference in protection currently isn't much.

Hmm, true; although I do feel that the moment attackers can write code
we might be having worse problems.

> It's not a very difficult requirement to get attacker-controlled bytes
> into executable memory, as there are already existing APIs that provide
> this to varying degrees of reachability, utility, and discoverability --
> for example, BPF JIT when constant blinding isn't enabled (the unfortunate
> default). 

BPF has another problem in that the current control transfer to BPF
progs is nocfi. At the very least we can have them have a hash, no?
