Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE3A63CD84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiK3CvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiK3Cu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:50:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4CB6CA14
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:50:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t17so14473721pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJzc1gkg7CYBIcnaOjHcKkT6tHJF7mw6uyG74ehPpXE=;
        b=WXu89bM8VSuMbjfLwDvOPgmdicHl23wdBR2XnPmgu0fbPUfWaoNkRHT47b9zlRU+3E
         Y0AVtZq9wJPW3p+6Qil1AakvSXNAGQr12qshsTOiUPugziY6IHk6w3tu3mpHIplFtLAh
         ux9pt8nUCrG+Dh6B5lCVsl76kjGpebfkKsTi5w/3moHCIIrqmOQUnF3fgi5FlbFWAvta
         cfJGpoMPWGQqPJIAA5lt6ajmHLyjSTq9r+AnUXSJzqty/DIVaurOjxq44+X4FEM7PZKd
         fj3NeyitI/6b8Qqn27Uh+LxtSyH5l86wMYLZLXn99H2VqDaAVhBlyf4JdhqncRqFo+8A
         Qrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJzc1gkg7CYBIcnaOjHcKkT6tHJF7mw6uyG74ehPpXE=;
        b=AlpYBGd+/V/AeFSvLRnbTkyHePEWRe8g17P3F1P8ATVQ0T20aYZxSOo3ACD5UK0W5K
         J0DtmnlTf80LbfIOU8YM2ln9ywFY7GFRKnUuNfNDoElUfso39T0vKoetw4ky10r+Xt76
         gyOXtzxi5Ng8C4G1pzDOxQSeeZSy1Ri+7ap0A96aIheT6hal/hQ4LuDoPrOD/G628+TM
         8n4YjqC0B6kMHFFujkS4HiFC6R9H8McW2eCysGCsNYYX4cpefwMkoGHN6Fu0WtMSMrJ9
         28b2R7pe1i1o2hvl+6HosSXaLe6AkUZfisozcIV+3VjNgXY7MWm5X1+YnwNrkNKpdl6S
         fh2A==
X-Gm-Message-State: ANoB5pl4YOVGZs7+Vj7f0od8qql5ad/dniKuDqEhl0v2sRu1iHEEXMAS
        JPRdBhyUptBDFf+q2hIyL1cauA==
X-Google-Smtp-Source: AA0mqf4FSdPpqYs7fYp7rBaRklVNCUU5c5tQxLKaAX48o3YF24D+ccCJJwQKzUKhJuWUQmh48zRSdA==
X-Received: by 2002:a17:903:100c:b0:189:a682:c5a6 with SMTP id a12-20020a170903100c00b00189a682c5a6mr2166271plb.78.1669776656888;
        Tue, 29 Nov 2022 18:50:56 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b0018986ba1db9sm5542309plx.284.2022.11.29.18.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 18:50:56 -0800 (PST)
Date:   Tue, 29 Nov 2022 18:50:56 -0800 (PST)
X-Google-Original-Date: Tue, 29 Nov 2022 18:50:47 PST (-0800)
Subject:     Re: [PATCH 1/2] RISC-V: Align the shadow stack
In-Reply-To: <CAMKF1srMj5aH4_+iwbFuu+AEgyyz85y+UPEszUGeQ7U=u19R3Q@mail.gmail.com>
CC:     jszhang@kernel.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Khem Raj <raj.khem@gmail.com>
Message-ID: <mhng-0a99c7e2-7e15-4a5f-a5fa-1e4c844a5ecd@palmer-ri-x1c9a>
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

On Tue, 29 Nov 2022 18:47:55 PST (-0800), Khem Raj wrote:
> Hi Palmer
>
> On Tue, Nov 29, 2022 at 6:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> The standard RISC-V ABIs all require 16-byte stack alignment.  We're
>> only calling that one function on the shadow stack so I doubt it'd
>> result in a real issue, but might as well keep this lined up.
>
> Is 16-byte alignment required on rv32 as well ?

For the standard ABIs that's the case, it's so the Q extension can spill 
without aligning the stack.  There's also at least a proposed embedded 
ABI that has just XLEN (32-bit on rv32) alignment, as the bigger stack 
alignment has an impact on some use cases.

>> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  arch/riscv/kernel/traps.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index be54ccea8c47..acdfcacd7e57 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -206,7 +206,7 @@ static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>>   * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
>>   * to get per-cpu overflow stack(get_overflow_stack).
>>   */
>> -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
>> +long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
>>  asmlinkage unsigned long get_overflow_stack(void)
>>  {
>>         return (unsigned long)this_cpu_ptr(overflow_stack) +
>> --
>> 2.38.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
