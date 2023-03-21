Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4E6C3536
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCUPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCUPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:11:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A171E181;
        Tue, 21 Mar 2023 08:11:12 -0700 (PDT)
Message-ID: <ac95f1f7-2af3-1461-2ea2-3608d081de3f@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679411470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBlQ00hG8MhlBw3zA8EtNC/Bw+Cu0Ips6JNpdNr1g4M=;
        b=fVwfxng4IJTFZtsvF5yprFb/Wp0n9ZX+YVtvS6VP0JX/6/0Vbv7GVCeL51O7ZtxD8le2kK
        2Tvy1i/v6SNwo7OlIr0f9p2sENh4xSSCglMUubh8/o7+wEklup/srCZ9X/hjuYNd+x2d/c
        yWu2jxtyanfdUXDQPrhKakVWTRFix7dB57Ef73t7sPPC0hr3LBD0RXeKaYKomrVDK8Fpby
        gUZGXQw/uZ4mKgmMJVPVVBvq7y6C2x+BOyTFcD3P10v4iTCGLI2SiU4FFHBT9nOskH3hGT
        CheittC97+dYnkCxcBps8ffDush3p7q+UTCPTHNXeSUoo1/6QcVuctV0HbBo3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679411470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBlQ00hG8MhlBw3zA8EtNC/Bw+Cu0Ips6JNpdNr1g4M=;
        b=2x5XtpYX4NC5EfkxM7kkgkx3ui432bSQnPyGkedfMh7q0Y4F4gh0SO76UXyaMeULraCzYY
        KDfMxDpKcyF2Y+BA==
Date:   Tue, 21 Mar 2023 16:11:07 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Donglin Peng <pengdonglin@sangfor.com.cn>, mhiramat@kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
 <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
 <2eeef5a3-cbe7-7a01-489a-87c5ac00adf7@linutronix.de>
 <20230321104413.43a81ffb@gandalf.local.home>
From:   Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH v5 1/2] function_graph: Support recording and printing the
 return value of function
In-Reply-To: <20230321104413.43a81ffb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 15:44, Steven Rostedt wrote:
> On Tue, 21 Mar 2023 15:09:40 +0100
> Florian Kauer <florian.kauer@linutronix.de> wrote:
> 
>> On 20.03.23 14:16, Donglin Peng wrote:
>>> When using the function_graph tracer to analyze system call failures,
>>> it can be time-consuming to analyze the trace logs and locate the kernel
>>> function that first returns an error. This change aims to simplify the
>>> process by recording the function return value to the 'retval' member of
>>> 'ftrace_graph_ent' and printing it when outputing the trace log.  
>>
>> I just came across your patch by pure luck and it helped me a lot
>> to trace down a problem I had, thanks!
>>
>> So you can have my
>> Tested-by: Florian Kauer <florian.kauer@linutronix.de>
>>  
>>> New trace options are introduced: funcgraph-retval and graph_retval_hex.  
>>
>> I would personally prefer to have the second option scoped better, so for example
>> "funcgraph-retval-hex".
> 
> That could be an ftrace option.

What do you mean? In the current implementation both funcgraph-retval and graph_retval_hex
are options for the function_graph tracer, but one is prefixed with "funcgraph-" as nearly
all other options for the function_graph tracer and one is not (and is even snake_case, while
the others are kebab-case). So it just looks inconsistent for me, but there might be a reason?

By the way: The documentation patch also references "function-retval" instead of
"funcgraph-retval" in the documentation of the graph_retval_hex option.

> Anyway, could you tell us your use case, and that could go into the change
> log of this patch as "one use case that this helped with".

Nothing spectacular. I just wanted to find out why ICMP port unreachable messages
sporadically lead to -111 (Connection Refused) for __sys_sendto() when IP_RECVERR is set
and the call never fails if IP_RECVERR is not set. (I am still unsure if this is
REALLY intended behavior, but at least it makes sense why this occurs when reading
the sources).

And with this patch, the -111 is directly popping up in the trace, but I do not think
that my missing knowledge about details of the kernel network stack
really qualifies as a good argument ;-)

Greetings,
Florian
