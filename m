Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53D615471
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKAVu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKAVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:50:27 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8F26E5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:50:25 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0AA9E240006;
        Tue,  1 Nov 2022 21:50:22 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 01 Nov 2022 14:50:22 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <202211011437.F82B61B8C@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
 <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
 <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com>
 <202210182218.56AD2871@keescook>
 <baced047981ff5fce633156e3e374dfd@overdrivepizza.com>
 <202211011437.F82B61B8C@keescook>
Message-ID: <1f6069657f4630c36d60baab2e9b3d10@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-01 14:39, Kees Cook wrote:
> On Mon, Oct 31, 2022 at 12:13:50PM -0700, Joao Moreira wrote:
>> On 2022-10-18 22:19, Kees Cook wrote:
>> > On Tue, Oct 18, 2022 at 09:48:42PM -0700, Joao Moreira wrote:
>> > > > > Is it useful to get the compiler to emit 0xcc with
>> > > > > -fpatchable-function-entry under any circumstance? I can probably
>> > > > > change
>> > > > > that quickly if needed/useful.
>> > > >
>> > > > Having it emit 0xcc for the bytes in front of the symbol might be
>> > > > interesting. It would mean a few kernel changes, but nothing too hard.
>> 
>> Should I push for this within clang? I have the patch semi-ready 
>> (below) and
>> would have some cycles this week for polishing it.
> 
> Sure! While the NOP vs CC issue isn't very interesting when IBT is
> available, it's nice for non-IBT to make attackers have to target
> addresses precisely.
> 
> If it's really invasive or hard to maintain in Clang (or objtool),
> then I'd say leave it as-is.

The Clang implementation is actually quite simple and, IIRC, I heard in 
the past someone mentioning that trapping instructions actually provide 
benefits for holding undesired straight-line speculation. Maybe someone 
can comment on that, or even if that is really relevant.

Meanwhile I'll work on pushing it then.
