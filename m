Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FC63F8C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiLAUGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLAUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:06:41 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6973FA518B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:06:40 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s7so2685003plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eECL7FFsHBH2zCKlJm2Sf1U0/PkSsC+DaNCICiNrHA4=;
        b=7ETsuVw75zM20YPxF79vgzShYETVvs5HQJDjgduACfj2mUDnyE17YFhf0CHhdiKqWD
         /AfYtm/ccEoBX8vXWy2GYwmXzG03S67tezDAW5ER53aGynhfLPoeVKqLvArKDmy39i/F
         aL6chILSuXx74UTjGA/dYe+R4hJX/3dye42BapjHVlGbgts6QmVt7dCJFbG3OpWoN47z
         jILXdwAzK+n+1SRVEYLXPQRdDQsZU09NR6SA5ZaUwqP8fnVDSF7Yt09Nj+yG8FVp0i+I
         e1xQeseSq2Dl6uTPinAerUlmh3KaI0o9ND7siRKwN+gbTy5X+aR6J55ejrbm4Jdra7Rb
         jXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eECL7FFsHBH2zCKlJm2Sf1U0/PkSsC+DaNCICiNrHA4=;
        b=Ot8rh2cLMXJBe1cNfUPubYua+qXnWTODeQZD1jiHeesv90i9miywGPPuLq1HzIn504
         TBKb6/dXIECD9IdHCdTEyE+06CO6ddgnigNPF2kod6YQb24m2744UfJ0wQ01CtsviCxn
         yB7UwmUV3CYDGOT2qblfVYGx3bGmGy4uhUhiEf7XNvZu8fkK1KadRoh4sSkyJbNzmfC5
         /K0VLs66EPvZD1aJyw/yjtOJ/G9Me/axrou90QTrqLqvwp+aRPjM8XXze55fUCRJqCxd
         jWCPLTw06Q7ge8KQcNlQ73E6CRPRB1/+O0l6ttilkXk9EO1DN/bYAtkFG3knl42TEJNf
         Q6Bw==
X-Gm-Message-State: ANoB5pnOwFtYT0T94sD8uV5jY3eGgWLCn2Q4TZFrK6F6dFVT9g7CybLz
        sP+BEkJsP9LVCd9EeAODRArbYw==
X-Google-Smtp-Source: AA0mqf763Eoc8HmJOusQht95t6nP6Z+b5yytGjvvh2a2H45c3AhWwYKHfOZ5pFzWbwg+HCmknfKIbA==
X-Received: by 2002:a17:90b:1186:b0:219:2f17:f952 with SMTP id gk6-20020a17090b118600b002192f17f952mr24170757pjb.195.1669925199763;
        Thu, 01 Dec 2022 12:06:39 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902cecd00b00186e34524e3sm4043394plg.136.2022.12.01.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:06:39 -0800 (PST)
Date:   Thu, 01 Dec 2022 12:06:39 -0800 (PST)
X-Google-Original-Date: Thu, 01 Dec 2022 12:06:29 PST (-0800)
Subject:     Re: [PATCH V4 6/7] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
In-Reply-To: <Y4kIcGY0rXTGb3po@spud>
CC:     guoren@kernel.org, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        rostedt@goodmis.org, mhiramat@kernel.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, suagrfillet@gmail.com,
        andy.chiu@sifive.com, mark.rutland@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-2612202a-d3bf-4b2b-9b8b-df67b38b5315@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2022 12:02:56 PST (-0800), Conor Dooley wrote:
> On Mon, Nov 28, 2022 at 10:32:29PM -0500, guoren@kernel.org wrote:
>> From: Song Shuai <suagrfillet@gmail.com>
>>
>> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>>
>> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
>> register_ftrace_direct[_multi] interfaces allowing users to register
>> the customed trampoline (direct_caller) as the mcount for one or
>> more target functions. And modify_ftrace_direct[_multi] are also
>> provided for modifying direct_caller.
>>
>> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
>> tracer, k[ret]probes) co-exist, a temporary register is nominated to
>> store the address of direct_caller in ftrace_regs_caller. After the
>> setting of the address direct_caller by direct_ops->func and the
>> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
>> by the `jr` inst.
>>
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> Tested-by: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> ---
>>  arch/riscv/Kconfig              | 1 +
>>  arch/riscv/include/asm/ftrace.h | 6 ++++++
>>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 1d0e5838b11b..2828537abfcd 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -278,6 +278,7 @@ config ARCH_RV64I
>>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>> +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>  	select HAVE_FUNCTION_GRAPH_TRACER
>>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>
> Please sort new entries here in alphabetical order, so move the new
> entry up by one line :)

IIRC whomever sorted these entrties orignially posted a script that does 
that.  Maybe that should be integrated into either checkpatch or one of 
the patchwork robots so we don't have to manually remember the alphabet?
