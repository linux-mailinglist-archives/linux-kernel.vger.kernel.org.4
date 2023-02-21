Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC669E7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBUSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBUSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:43:02 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA63C17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1677004977;
        bh=Znw52qcnJnwY4/xsyU5WdpWB9lDTZqUikI6qs38e/7c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hFk9WHd5QCv9ZI/tmAKTb5pZVV2siIJAdr0vEikXtwaqIpRPKuPL7jfk8fBmcYjFc
         VB1+MHm3Qo5QAtGi+3XYXqV+cyZBr+9vEfJx5Wy8Q6Vt6b87EUt/0q43u6hvaqcSuM
         GCU7670eVnRrripTQv1y0+GcVVZLFKoz1Vsf195MyBRfxxrjWVpkmv94/cd2TNxuC6
         cww8hQtHyhan/db+Gy8Nv/RiItB0iuv+N3Iq8/g0ndEx2Ejo4l19uorm+OMunDlWuX
         ea6MtqLqMbxXGAv5r9aB+LvMezMkuyu7A6cllRcrwCZ3VBDdcoK0KjkAIj01L249gP
         pdGXyL0yWNp4w==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PLp7j5B3cznDG;
        Tue, 21 Feb 2023 13:42:57 -0500 (EST)
Message-ID: <5774aace-23f3-c53d-8e65-b90b588dbbe3@efficios.com>
Date:   Tue, 21 Feb 2023 13:42:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Official documentation from Intel stating that poking INT3
 (single-byte) concurrently is OK ?
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Olivier Dion <odion@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <786f4aed-2c30-806b-409b-23a60b3d7571@efficios.com>
 <20230221125032.0b02d309@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230221125032.0b02d309@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-21 12:50, Steven Rostedt wrote:
> On Tue, 21 Feb 2023 11:44:42 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Hi Peter,
>>
>> I have emails from you dating from a few years back unofficially stating
>> that it's OK to update the first byte of an instruction with a single-byte
>> int3 concurrently:
>>
>> https://lkml.indiana.edu/hypermail/linux/kernel/1001.1/01530.html
>>
>> It is referred in the original implementation of text_poke_bp():
>> commit fd4363fff3d9 ("x86: Introduce int3 (breakpoint)-based instruction patching")
>>
>> Olivier Dion is working on the libpatch [1,2] project aiming to use this
>> property for low-latency/low-overhead live code patching in user-space as
>> well, but we cannot find an official statement from Intel that guarantees
>> this breakpoint-bypass technique is indeed OK without stopping the world
>> while patching.
>>
>> Do you know where I could find an official statement of this guarantee ?
>>
> 
> The fact that we have been using it for over 10 years without issue should
> be a good guarantee ;-)
> 
> I know you probably prefer an official statement, and I thought they
> actually gave one, but can't seem to find it.

I recall an in-person discussion with Peter Anvin shortly after he got 
the official confirmation, but I cannot find any public trace of it. I 
suspect Intel may have documented this internally only.

  Anyway. how does the dynamic
> linker do this? Doesn't it update code on the fly as well?

The dynamic linker is similar to the module loader in the kernel: the 
code modification is done before the loaded code is ever executed, and 
is therefore inherently safe with respect to cross-modification of 
concurrently executing code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

