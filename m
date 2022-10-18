Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B356033AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJRT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJRT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:59:50 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B772D1C5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:59:47 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id B759FFF80A;
        Tue, 18 Oct 2022 19:59:42 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 18 Oct 2022 12:59:42 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <202210181020.79AF7F7@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
Message-ID: <5094174a77cdc44cf50c346bf1617555@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>>    o IBT WAIT-FOR-ENDBR state is a speculation stop; by placing
>>      the hash validation in the immediate instruction after
>>      the branch target there is a minimal speculation window
>>      and the whole is a viable defence against SpectreBHB.
> 
> I still think it's worth noting it does technically weaken the
> "attacker-controlled executable memory content injection" attack
> requirements, too. While an attacker needs to make sure they place an
> ENDBR at the start of their injected code, they no longer need to also
> learn and inject the CFI hash too, as the malicious code can just not
> do the check at all. The difference in protection currently isn't much.
> 
> It's not a very difficult requirement to get attacker-controlled bytes
> into executable memory, as there are already existing APIs that provide
> this to varying degrees of reachability, utility, and discoverability 
> --
> for example, BPF JIT when constant blinding isn't enabled (the 
> unfortunate
> default). And with the hashes currently being deterministic, there's no
> secret that needs to be exposed first; an attack can just calculate it.
> An improvement for kCFI would be to mutate all the hashes both at build
> time (perhaps using the same seed infrastructure that randstruct 
> depends
> on for sharing a seed across compilation units), and at boot time, so
> an actual .text content exposure is needed to find the target hash 
> value.
> 
If we look back at how well ASLR did over the years I think we can't 
really rely that randomizing the hashes will solve anything. So what you 
are suggesting is that we flip a "viable defence against SpectreBHB" for 
a randomization-based scheme, when what we really should be doing is 
getting constant blinding enabled by default.

In fact, even if an attacker is able to inject an ENDBR at the target 
through operation constants as you suggest, there is still the need for 
an info-leak to figure out the address of the ENDBR. I bet this is not a 
problem for any skilled attacker as much as figuring out the randomized 
hashes shouldn't be. Unfortunately no CFI scheme I know that relies on 
anything at the callee-side is fully reliable if an attacker can 
manipulate executable pages, and randomizing hashes won't change that. 
So I don't think there is a strong enough difference here. ClangCFI 
perhaps could be better in that perspective, but as we know it would 
bring many other drawbacks.

At this point I feel like going on is a bit of bike-shedding, but if 
this really matters, below is how to use randomization on FineIBT. Maybe 
with lot less entropy, but just ideas thrown that could be improved over 
time (don't take this as a serious proposal):

Assuming we got 16 bytes padding to play with on each function prologue, 
you can randomize between 0-11 in which offset you emit the ENDBR 
instruction. Caller/Callee would look like (hopefully I did not mess-up 
offset):

<caller>:
and 0xf3, r11b
call *r11

<callee>:
nop
nop
nop
endbr // <- this position is randomized/patched during boot time.
nop
nop
...

And of course, you get more entropy as you increase the padding nop 
area.
