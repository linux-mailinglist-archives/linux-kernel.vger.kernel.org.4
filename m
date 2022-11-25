Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D5639122
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiKYVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKYVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:35:07 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9029CBB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:35:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w23so4978291ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j19IwnC8RkwHj/wJbasgF1K7q6L4NDpWoMvT/gTRM0I=;
        b=HnHwFCtS5HanJQq80MvNg+egi/Zbc3q5eblpduEwSXtJZCG7GY5Waqc+UNxejAypfi
         ptTkkTZaUPyckmHBnUhSk0DfoPfbcWpznIRNnHDxQf4ZZfpX6jsadDmnPOJTCB7t+zcq
         DVz/P7T2RAjka178ljnEOejs7WsHcq5ucxgASTj/RUqPuFNVD2aO31n3HHKqPxwbGXAp
         CgknCT0Le2v8s0JCLW0Luet/88s4rscY7cVVcVzBknBATb2l849sI0mbupuoWL7yOwlm
         pWFrSwYfo7a9YDbSttyAcLi07z9SrvSPi7/qKo3B2n1a2ynTRn19zXzcuuM7dLAdtZSM
         lMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j19IwnC8RkwHj/wJbasgF1K7q6L4NDpWoMvT/gTRM0I=;
        b=MbksqN/hAOgfdlDb1+fFtZAxtoHso2gkc+8re60qPGR8S5pJmvFnLAXVnBgwYdLEAC
         ty7uWWW1EnYS2ec0MtYegGFscwVMPes3eeUxJcXtUNjCSU0wnMVMC0iRu00wJ1mGfNTw
         LFoyEe/8GsCGKhTp2M6N4q7iymYXSsXHx9coYOWnlQc8cCxrnLPtvtGK36yPISlUL+Up
         LnD5Kb6/bqkiayB4Fjh7X98KiAYoStAhIOglphzmxWW54KDD9vsr6TisS/NqySceLIAM
         HLuZc4BO8kPxwNhsckpilgJNjDIMJV7lna+Lqqy2O/N95si6BQZCYSiUOilUlUq87aDp
         4UEQ==
X-Gm-Message-State: ANoB5pnaz35VorVD8efkLYh51XSiiF5ZzWo1AMIHGZqhlXUg4nbiTk7h
        Fk1LNHC+P8P89g89ZSg2v69hmA==
X-Google-Smtp-Source: AA0mqf5XCPljPOokHY/PUd0jBF87iUDZ4r4IHMTLVevRsZyfqnT+DZaP9DbWc+kjTYPygeNH5RagKQ==
X-Received: by 2002:a17:902:d2c7:b0:189:d3b:61f4 with SMTP id n7-20020a170902d2c700b001890d3b61f4mr20217931plc.169.1669412105998;
        Fri, 25 Nov 2022 13:35:05 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c200-20020a624ed1000000b00574d8d64560sm504655pfb.175.2022.11.25.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 13:35:05 -0800 (PST)
Date:   Fri, 25 Nov 2022 13:35:03 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221125213503.GB2037421@debug.ba.rivosinc.com>
References: <20221124094845.1907443-1-debug@rivosinc.com>
 <Y3+NMjOQW+yA1Kqj@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y3+NMjOQW+yA1Kqj@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 11:26:42PM +0800, Jisheng Zhang wrote:
>On Thu, Nov 24, 2022 at 01:48:45AM -0800, Deepak Gupta wrote:
>> commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
>> support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches to
>> `shadow_stack` temporarily before switching finally to per-cpu
>> `overflow_stack`.
>>
>> If two CPUs/harts are racing and end up in over flowing kernel stack, one
>> or both will end up corrupting each other state because `shadow_stack` is
>> not per-cpu. This patch optimizes per-cpu overflow stack switch by
>> directly picking per-cpu `overflow_stack` and gets rid of `shadow_stack`.
>>
>> Following are the changes in this patch
>>
>>  - Defines an asm macro to obtain per-cpu symbols in destination
>>    register.
>>  - In entry.S, when overflow is detected, per-cpu overflow stack is
>>    located using per-cpu asm macro. Computing per-cpu symbol requires
>>    a temporary register. x31 is saved away into CSR_SCRATCH
>
>This only works if CSR_SCRATCH doesn't contain any valid reg saving,
>but.. see below.
>
>>    (CSR_SCRATCH is anyways zero since we're in kernel).
>>
>
>To be honest, before [1] I have similar idea to keep the percpu usage,
>however, the solution doesn't work. The key here is that there's
>another VMAP_STACK bug in current riscv implementation: it only checks
>vmap stack overflow when comming from kernelspace, but vmap should
>check when comming from both kernelspace and userspace. So we can't

Why do we need to check if space is available or not when coming from user space.
Kernel stack is fresh and just starting out it's life.

>assume CSR_SCRATCH is always zero and free to use. The only available
>solution is my fix[1] which only makes use of tp. But since[1] modifies
>lots of code, it's not idea to merge it as a fix, so [2] is suggested
>and sent out.
>
>PS: I planed to send a fix for the missing FROM_USERSPACE after the
>race fix is merged.
>
>
>[1]https://lore.kernel.org/linux-riscv/20220925175356.681-1-jszhang@kernel.org/T/#t
>[2]https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
>
