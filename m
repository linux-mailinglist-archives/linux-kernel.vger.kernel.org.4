Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1836334A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiKVFQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKVFQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:16:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542392E6A3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:16:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w23so12545719ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmJIC+NHaysdpOEUXMvyd23U3/2WSJwb31FRzrLQVX0=;
        b=bcUXEwRu+ZcLl22BLqCnDSOGUUqIe/cCfHQMrJM6MdKkmrVCu6JmujvqgdD15sPzSV
         ZQIY3PFhPdz8PJq3wCNQlDCxRnJ0WytsLixFmab0P+E9Mr38+R3gOK9lAQ+dbs0UfCtX
         wqmX5eA89wWEz7bwfhU7FNt5i5SchgN8T770Oc/6f2WLOOKUgZJf+fQcoPx1iaLw8/U9
         YrUBN2mOGu8AhVWRSWIGYy+kdsgpfutmDd6qk8oAbe+NhiSmQOAula6Q6do37ytN2G0J
         RWcougQ/vQz6xoJGDHltLmGJuRjCFOe5Ja1hNK3x1DXutCEbLXcXp3T6GkhC7JRgTEF3
         hZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmJIC+NHaysdpOEUXMvyd23U3/2WSJwb31FRzrLQVX0=;
        b=yoeHr6NHblzlMZ7hXSNmogjQ6zGoGN1PAwyLlUB6Xpam0ASrn0KtcqzrSnuzFDe9Bf
         EhNRsPOANz/qqHZ+DrvS04EN3p3prZOFSZ+uA98DdrcaUpPmBKF36XqcziXPzzQYWKIn
         +5AUyRqmeGgwyrd1KhHokEjZpSnfHR+WyofQYHKUwrpK04J6PTmDZiE0DfVEKPSKJPDO
         kjsNYHbsUhi1sEZPaBoWlS8MuybKfE6XpoVmOlyStSSaW4tgrqNnjg8qWwJVSPnOs7+N
         Kg1MQb+rt+kYzEg5JIJ1gtYFFtxII5g8uvRXxw5TEg440Fy1y8nWcRUvSumw0A2TRBIL
         7kYg==
X-Gm-Message-State: ANoB5pkq56haPiRqgoBzS8ymNBk2OJ+nbjaQH1n/UAoLYXDuDY7qhZ1g
        Th7e+WQvuOUtzJ9syrfpv+U7zA==
X-Google-Smtp-Source: AA0mqf7H5Kg9b0kRSpYfvU5gCu0yzDPTQ7DMorg1/QXLCCiB1FPHV3Oj4hj442qtY5yXZAiC/GmxAQ==
X-Received: by 2002:a17:903:204b:b0:180:a0e6:f81b with SMTP id q11-20020a170903204b00b00180a0e6f81bmr2737567pla.78.1669094200710;
        Mon, 21 Nov 2022 21:16:40 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id y29-20020aa79e1d000000b0056b6a22d6c9sm9594943pfq.212.2022.11.21.21.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:16:40 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:16:40 -0800 (PST)
X-Google-Original-Date: Mon, 21 Nov 2022 21:16:38 PST (-0800)
Subject:     Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
In-Reply-To: <CAAhSdy0Fs9ZVoRgtz92RgLnFPvgwUzCP_KpK9SCOiVsA-t3p3Q@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     anup@brainfault.org
Message-ID: <mhng-3f44cc1f-7305-41c5-a1cf-dfed096bd364@palmer-ri-x1c9>
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

On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
> On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> As per [1], whether or not the core can wake up from non-retentive
>> suspend is a platform-specific detail.  We don't have any way to encode
>> that, so just stop using them until we've sorted that out.
>>
>> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
>> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> This is just unnecessary maintenance churn and it's not the
> right way to go. Better to fix this the right way instead of having
> a temporary fix.
>
> I had already sent-out a patch series 5 months back to describe
> this in DT:
> https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
>
> No one has commented/suggested anything (except Samuel
> Holland and Sudeep Holla).

I see some comments from Krzysztof here 
<https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/> 
as well.  Looks like everyone is pointing out that having our CPU nodes 
encode timers is a bad idea, my guess is that they're probably right.

> Please review this series. I can quickly address comments to
> make this available for Linux-6.2. Until this series is merged,
> the affected platforms can simply remove non-retentive suspend
> states from their DT.

That leaves us with a dependency between kernel versions and DT 
bindings: kernels with the current driver will result in broken systems 
with the non-retentive suspend states in the DT they boot with when 
those states can't wake up the CPU.

> With all due respect, NACK to this patch from my side.
>
> Regards,
> Anup
>
>>
>> ---
>>
>> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
>> Events are stopped during CPU suspend"), which fixes suspend on the D1
>> but breaks timers everywhere.
>> ---
>>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> index 05fe2902df9a..9d1063a54495 100644
>> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
>> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
>>         if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>>             state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>>                 return false;
>> +
>> +       /*
>> +        * Whether or not RISC-V systems deliver interrupts to harts in a
>> +        * non-retentive suspend state is a platform-specific detail.  This can
>> +        * leave the hart unable to wake up, so just mark these states as
>> +        * unsupported until we have a mechanism to expose these
>> +        * platform-specific details to Linux.
>> +        */
>> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
>> +               return false;
>> +
>>         return true;
>>  }
>>
>> --
>> 2.38.1
>>
