Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C131B6033CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJRUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJRUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:09:35 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACE2191
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:09:28 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id DD8AD20003;
        Tue, 18 Oct 2022 20:09:25 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 18 Oct 2022 13:09:25 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Laight <David.Laight@aculab.com>,
        'Peter Zijlstra' <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <202210181013.923F8809@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <9bb036e48580454b81e6de7224c5f006@AcuMS.aculab.com>
 <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
 <202210181013.923F8809@keescook>
Message-ID: <24d4e2f277ecaa435075745817f2bd61@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-18 10:20, Kees Cook wrote:
> On Tue, Oct 18, 2022 at 08:58:24AM -0700, Joao Moreira wrote:
>> > Does the hash value for kCFI only depend on the function type?
>> > Or is there something like a attribute that can also be included?
>> 
>> Hi David -- does this sound like what you are asking about?
>> 
>> https://github.com/ClangBuiltLinux/linux/issues/1736
>> 
>> If yes, then it is something in our todo list :) I think Sami is 
>> handling
>> it.
> 
> I was hoping someone with prior experience with Call Graph Detaching to
> solve Transitive Clustering Relaxation[1] could assist? ;)

Hi Kees, thanks for bringing these slides up.

Yeah, I would be glad to help out with automating this sort of analysis. 
CGD, as explained in these slides would not help much here, because it 
was more of an optimization to reduce the number of allowed targets on 
returns (we did not have an almighty shadow stack at the time). Yet 
there are lots of other things we might be able to do, both statically 
and dynamically. Recent relevant research about this is multi-layer type 
analysis [1], which I may find the time to look into more deeply soon.

1 - https://www-users.cse.umn.edu/~kjlu/papers/mlta.pdf

Tks,
Joao
