Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA960507F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJSTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJSTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:35:29 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98AD160215
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:35:27 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5F0A6E0005;
        Wed, 19 Oct 2022 19:35:25 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 19 Oct 2022 12:35:25 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <202210182222.64C2D87E0@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <5094174a77cdc44cf50c346bf1617555@overdrivepizza.com>
 <202210182222.64C2D87E0@keescook>
Message-ID: <8b580fc28f17a644c114e9cbfca57733@overdrivepizza.com>
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

>> >
>> If we look back at how well ASLR did over the years I think we can't 
>> really
>> rely that randomizing the hashes will solve anything. So what you are
>> suggesting is that we flip a "viable defence against SpectreBHB" for a
>> randomization-based scheme, when what we really should be doing is 
>> getting
>> constant blinding enabled by default.
> 
> I don't think any of these things are mutually exclusive. The
> randomization means an additional step (and possibly additional 
> primitive)
> is needed for an attack chain. Since we get this from a one-time cost
> on our end, that seems like reasonable value.
> 
I think I misunderstood your original comment/suggestion, so my bad for 
the noise.

And yeah, I agree that randomization is relevant from the perspective of 
security in depth. With this said, FWIIW, all suggestions sound good to 
me.

>> 
>> Assuming we got 16 bytes padding to play with on each function 
>> prologue, you
>> can randomize between 0-11 in which offset you emit the ENDBR 
>> instruction.
>> Caller/Callee would look like (hopefully I did not mess-up offset):
>> 
>> <caller>:
>> and 0xf3, r11b
>> call *r11
>> 
>> <callee>:
>> nop
>> nop
>> nop
>> endbr // <- this position is randomized/patched during boot time.
>> nop
>> nop
>> ...
>> 
>> And of course, you get more entropy as you increase the padding nop 
>> area.
> 
> Oh, I kind of like this -- it'd need to be per matching hash. This 
> would
> require roughly 3 bits of entropy exposure of the .text area. For X^R,
> that becomes annoying for an attacker, though likely once close enough,
> multiple attempts could find it, assume panic_on_oops/warn wasn't set.
> 
> Anyway, this sounds like an interesting idea to keep in our back
> pocket...

Agreed. It is hard to implement this because the space overhead would be 
too big for meaningful entropy. Yet, again, could be a trick in a swiss 
army knife for future problems.

Tks,
Joao
