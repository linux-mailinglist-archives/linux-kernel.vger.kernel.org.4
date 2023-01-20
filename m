Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53F67534D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjATLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:16:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9613584
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=42EMRJMW6nNuF6BXb3kFW7xC22CWnWGpsMibscJgfIk=; b=cdMqF0a+Pi72ZepiPeVSSHAQP6
        NEia3ZpFUj4JypIWo2PdIQjirddJY5YthAro07qBI2xpm7uA/7ZDcDmnwt9L0w90tNp0yjNxX5VHy
        YAJdC7LYQV5sx8ysTpTcb2g9cgEbAIdZbWd22zwrhMcrXcZwAuXyfoct5c+iesfXsgSG1XQkAh9PP
        PCaenUf5Qem1S6JS2Yr2VILgevYYS5RWqdqglKpQFpzpwqk9H1ZVKT0gRJJHVyqixBhfkWZ5lOmZR
        NtzOi+wvJdWoReOtrfSBf7poIscO4pPWdc54wzfMpjSq9aOm0Cnu9XmPiuTJUHRpwIJW7r/3AbrkK
        1GbJinFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIpNk-001tNv-1Z; Fri, 20 Jan 2023 11:16:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F12D530036B;
        Fri, 20 Jan 2023 12:16:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D66B72009E43D; Fri, 20 Jan 2023 12:16:26 +0100 (CET)
Date:   Fri, 20 Jan 2023 12:16:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <Y8p4CnJU6T7+17Sw@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
 <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
 <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
 <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:20:53AM +0530, Sandipan Das wrote:

> With the combination of defconfig+kvm_guest.config+localyesconfig, the only
> thing that made a difference was the compiler optimization choice. The kernel
> boots up with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y but not with
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Both Clang 15 and 16 kernel builds are affected.

*groan*..

0000000000000350 <amd_pmu_add_event>:
350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4

and static_call() can't deal with Jcc, I wonder why we've not seen that
before -- this isn't totally idiotic code-gen and esp. clang is known to
do this (see the retpoline thing).

Let me see if I can do something about that.
