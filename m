Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F366E6A2336
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBXUlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBXUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:41:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14CC688D2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:40:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bt28so376445wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZgvci6eHjrOPPgePA1cuqgHKUVED6K4d316DCUBe0I=;
        b=TvkiIGGGQAh+0GtVhyubX1KlVFvnSI2hJ8eTWfPLvMBeZssiWbfy1YwiGqu70hSA9I
         BWsz6kI7cQGm2ThoeM14lJhCk6Xe4ZJt+im/mISdBAvlnyrRdUQZ65BObvAprbZiX+mo
         DRH3X3c9akpfuZrB32bW8TC5Vxe2DL5jAxngdrrWjd2/EogOA/c6TIKyxNH9uHRR9uMJ
         lNdhqbbGT+sIljJC0n7iulNKGbqkskU4S907BsENK+4zO2CHIRjq3iNWXa/LhY4bRFg/
         Icggg5+w+C1V6ZsDxMOf3Z87/HeSYRflTJG3F9CtqI4mdrO1dRh2pLFn4uD4/XF4y4wQ
         lkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZgvci6eHjrOPPgePA1cuqgHKUVED6K4d316DCUBe0I=;
        b=JKXtvbCZYhzu6VnsMUIhBysNQIW2PXqoYNJrePRJzIMk7brLbpStIgEuk6Tw5n8sqg
         hYZz5uenleKmqndmzR1NjfgNt+fy2EF+iF6emFTzbfVI78AbzEXCoD72InOMy1+GH8Zq
         LJCy/ZVZ1NT3wmiKemf750wJUYKYXvJKhD+JGl5eGnItfK5wX/C+XWJ8B37GZ8igLjY9
         Huxx09EU2XsBLnDKvNKQDXbRYhJCzpyCBRTLnNqkRJrYmuKRORN7AV0kyLraLRQw6k8S
         /a7XNywxQIHYFbbJHCeFFsAjWHK1XuEhBI+LCxor4B7QyVWQqyLt0w4mEowuMimIZjaY
         qRMw==
X-Gm-Message-State: AO0yUKVZ3JyAV9Nlyn3GGO8YNeAx7PDH/6S8a8BL5faeySM+Eex9d2BB
        l82h4ePkrhl7XDdOMD4RDctlLywtg9AxfNv0
X-Google-Smtp-Source: AK7set9dAngDA1uYaW0uodDeHuwek0WthqBK6ecpVJoqaRbOvclxCDFcOOXn1GB0+y+FYq178UaAZQ==
X-Received: by 2002:adf:eccf:0:b0:2c7:e406:67d8 with SMTP id s15-20020adfeccf000000b002c7e40667d8mr1686178wro.35.1677271246325;
        Fri, 24 Feb 2023 12:40:46 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:d12b:5d7b:42ef:d31a? ([2a02:6b6a:b566:0:d12b:5d7b:42ef:d31a])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c4f0400b003df7b40f99fsm4491838wmq.11.2023.02.24.12.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 12:40:45 -0800 (PST)
Message-ID: <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com>
Date:   Fri, 24 Feb 2023 20:40:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] [PATCH v2 0/5] x86-64: Remove global variables from
 boot
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230224154235.277350-1-brgerst@gmail.com>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230224154235.277350-1-brgerst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 15:42, Brian Gerst wrote:
> This is based on the parallel boot v11 series.
> 
> Remove the global variables initial_gs, initial_stack, and
> early_gdt_descr from the 64-bit boot code.  The stack, GDT, and GSBASE
> can be determined from the CPU number.
> 
> v2: - Dropped first two patches which were merged into another patch in
>        the parallel boot series.
>      - Fixed a compile error in patch 1 found by the kernel test robot.
>      - Split out the removal of STARTUP_SECONDARY into a separate patch
>        and renumber the remaining flags.
> 
> Brian Gerst (5):
>    x86/smpboot: Remove initial_stack on 64-bit
>    x86/smpboot: Remove early_gdt_descr on 64-bit
>    x86/smpboot: Remove initial_gs
>    x86/smpboot: Simplify boot CPU setup
>    x86/smpboot: Remove STARTUP_SECONDARY
> 
>   arch/x86/include/asm/processor.h |  6 +-
>   arch/x86/include/asm/realmode.h  |  1 -
>   arch/x86/include/asm/smp.h       |  5 +-
>   arch/x86/kernel/acpi/sleep.c     |  5 +-
>   arch/x86/kernel/head_64.S        | 99 ++++++++++++--------------------
>   arch/x86/kernel/smpboot.c        |  6 +-
>   arch/x86/xen/xen-head.S          |  2 +-
>   7 files changed, 49 insertions(+), 75 deletions(-)
> 

Its weird putting something in earlier patches like 
STARTUP_APICID_CPUID_*,STARTUP_SECONDARY.. and removing/changing it 
later on in *the same series*. Maybe better to keep this as a separate 
series from parallel smp? i.e. not include this in v12 and review it 
separately? Happy with whatever you and David decide..

Thanks,
Usama
