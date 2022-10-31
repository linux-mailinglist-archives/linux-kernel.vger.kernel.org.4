Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354CF613D46
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJaS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:25:58 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E8D80;
        Mon, 31 Oct 2022 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667240754;
        bh=m792KA+Pm5MDPwGhivRQlp6KvZ3pAaFVx83kQl5D0lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ds06VAy/Vy1ll4dkzG+xu4/gozz1gqvkrto6HPQElkhj6hKjXUrsNRiPwEmh4zjXE
         Lwofqwo8AVK2pOjCLOPNR8xBNPApQfgPMg2dh/rBZ55tJT65pg7K0nTlw3zivKh+43
         /MYAQRmDIJr8eAc6BDLEdaBWkhLeklJKMzK81UUq2C0pSWWghLU/WtHr9za22b+ea1
         Rja39Ue1hB9T0oCSjEw5zmteEU+opPt9PCxpnQ8NMNXrVhSuOZTi53dev08gwauQMP
         1vopuhHWTgrgOYQrk6e7wRlugcmU+WfegqDSenlzsU+OLuu+EephNH6hE1ySCTjWhF
         gSVRuEpdVlgQA==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N1M6B5FVyz1RRJ;
        Mon, 31 Oct 2022 14:25:54 -0400 (EDT)
Message-ID: <16944a84-800b-f40a-8b46-23bae5e9b81c@efficios.com>
Date:   Mon, 31 Oct 2022 14:25:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221031231556.a15846fd3513641d48820d5b@kernel.org>
 <20221031172706.GA196@W11-BEAU-MD.localdomain>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221031172706.GA196@W11-BEAU-MD.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-31 13:27, Beau Belgrave wrote:
> On Mon, Oct 31, 2022 at 11:15:56PM +0900, Masami Hiramatsu wrote:
[...]
>> And what is the actual advantage of this change? Are there any issue
>> to use mmaped page? I would like to know more background of this
>> change.
>>
> 
> Without this change user tracers like LTTng will have to check 2 values
> instead of 1 to tell if the kernel tracer is enabled or not. Mathieu is
> working on a user side tracing library in an effort to align writing
> tracing code in user processes that works well for both kernel and user
> tracers without much effort.
> 
> See here:
> https://github.com/compudj/side
> 
> Are you proposing we keep the bitmap approach and have side library just
> hook another branch? Mathieu had issues with that approach during our
> talks.

As overhead of the disabled tracepoints was a key factor in having the Linux
kernel adopt tracepoints when I created those back in 2008, I expect that having
minimal overhead in the disabled case will also prove to be a key factor for
adoption by user-space applications.

Another aspect that seems to be very important for wide adoption by user-space
is that the instrumentation library needs to have a license that is very
convenient for inclusion into statically linked software without additional
license requirements. This therefore excludes GPL and LGPL. I've used the MIT
license for the "side" project for that purpose.

Indeed, my ideal scenario is to use asm goto and implement something similar
to jump labels in user-space so the instrumentation only costs a no-op or a
jump when instrumentation is disabled. That can only be used in contexts where
code patching is allowed though (not for Runtime Integrity Checked (RIC) processes).

My next-to-best scenario is to have a single load (from fixed offset), test and
conditional branch in the userspace fast-path instead. This approach will need
to be made available as a fall-back for processes which are flagged as RIC-protected.

I currently focus my efforts on the load+test+conditional branch scheme, which is
somewhat simpler than the code patching approach in terms of needed infrastructure.

If we go for the current user events bitmap approach, then anything we do from
userspace will have more overhead (additional pointer chasing, loads, and masks
to apply). And it pretty much rules out code patching.

In terms of missing pieces to allow code patching to be done in userspace, here
is what I think we'd need:

- Extend the "side" (MIT-licensed) library to implement gadgets which support
code patching, but fall-back to load+test+conditional branch if code patching
is not available. Roughly, those would look like (this is really just pseudo-code):

.pushsection side_jmp
/*
  * &side_enabled_value is the key used to change the enabled/disabled state.
  * 1f is the address of the code to patch.
  * 3f is the address of branch target when disabled.
  * 4f is the address of branch target when enabled.
  */
.quad &side_enabled_value, 1f, 3f, 4f
.popsection

/*
  * Place all jump instructions that will be modified by code patching into a
  * single section. Therefore, this will minimize the amount of COW required when
  * patching code from executables and shared libraries that have instances in
  * many processes.
  */
.pushsection side_jmp_modify_code (executable section)
1:
jump to 2f
.popsection

jump to 1b
2:
load side_enabled_value
test
cond. branch to 4
3:
-> disabled
4:
-> enabled

When loading the .so or the executable, the initial states uses the load,
test, conditional branch. Then in a constructor, if code patching is available,
the jump at label (1) can be updated to target (3) instead. Then when enabled,
it can be updated to target (4) instead.

- Implement a code patching system call in the kernel which takes care of all the
details associated with code patching that supports concurrent execution (breakpoint
bypass, or stopping target processes if required by the architecture). This system
call could check whether the target process has Runtime Integrity Check enforced,
and refuse code patching as needed.

As a nice side-effect, this could allow us to implement things like "alternative"
assembler instruction selection in user-space.

- Figure out a way to let a user-space process let the kernel know that it needs
to enforce Runtime Integrity Check. It could be either a prctl(), or perhaps a
clone flag if this needs to be known very early in the process lifetime.

Thanks,

Mathieu




-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

