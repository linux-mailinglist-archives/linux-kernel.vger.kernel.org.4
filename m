Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B26038F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 06:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJSEst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 00:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJSEsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 00:48:47 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72B57BC7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 21:48:45 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 500D6E0003;
        Wed, 19 Oct 2022 04:48:42 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 18 Oct 2022 21:48:42 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
 <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
Message-ID: <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is it useful to get the compiler to emit 0xcc with
>> -fpatchable-function-entry under any circumstance? I can probably 
>> change
>> that quickly if needed/useful.
> 
> Having it emit 0xcc for the bytes in front of the symbol might be
> interesting. It would mean a few kernel changes, but nothing too hard.
> 
> That is, -fpatchable-function-entry=N,M gets us N-M bytes in at the
> start of the symbol and M bytes in front of it. The N-M bytes at the
> start of the function *are* executed and should obviously not become
> 0xcc (GCC keeps them 0x90 while LLVM makes them large NOPs).

Uhum, all makes sense. I drafted something here:

https://github.com/lvwr/llvm-project/commits/joao/int3

Let me know if this works for you or if there is something that should 
be tweaked, like adding a specific flag and such. This currently emits 
0xcc instead of 0x90 for the nops before the function entry symbol for 
kernel code on x86-64. It seems to be working (see generated snippet 
below), but let me know otherwise:

Generated with -fpatchable-function-entry=10,5

Disassembly of section .text:

0000000000000000 <save_processor_state-0x5>:
    0:   cc                      int3
    1:   cc                      int3
    2:   cc                      int3
    3:   cc                      int3
    4:   cc                      int3

0000000000000005 <save_processor_state>:
    5:   0f 1f 44 00 08          nopl   0x8(%rax,%rax,1)
    a:   41 57                   push   %r15
    c:   41 56                   push   %r14
...
