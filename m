Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF66488C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLITC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiLITCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:02:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A19EAE4E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:02:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y17so5843333plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifbs+XvCCj88/lcEt+puLfhmeo1egK0Vk+w9LlAMKCg=;
        b=4Rux6t4XmWwM+AknbpI8EYJc9d8VlB3qnwjbOs49K3WO+P5jJU1+SQ464MA3SixwIF
         HXx9q016B9LtUUNhDzn7MkogCb6STF29kNMA/FkejErP+M+0OLHG720Cip1FpFvfuFDr
         HSIgQ03aKzkWHpNMNzwlJUs61r7NvVoJIJPYoXcczX4hzP0bC3dAHycWmISlTudW0uew
         XwAGc64f154MvDdb+8+DDQOzzZ30IolvjuUiJ4bQn5bTfH2NcHdJUrMYASykY3KtiEYY
         BCx7jxkJlYFqUkBTBj5g/C2PgGRuHZi7SCWUVkiIMtyByuICcB0Sa5ca+p4HgIXBYeGD
         nmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifbs+XvCCj88/lcEt+puLfhmeo1egK0Vk+w9LlAMKCg=;
        b=UPUKBUcjupUJuvzOWjjqXCAhvL5Q17G6wLYztVEWpNJ9xaNGRPtxCUCm5apM8BD/cI
         7poer0OG3V9LSlEmwgmDDt80uNfTuew8cWYWX9W5W4qk1T+cLhorG5nbmtYARSWR+upN
         +XZEcjDgNp4vEUkSbg2RN2cuZebZdoi8GTur07EsQchavwaU8QTnU74mrbWHvGUFS/gk
         YNFnHjaF/pOa6EuQMC4YYHDo4/R11kTXEDnXvyEoONdYiYcYFI1CRMRwnEExJGX9itBn
         0aueWx5V0gUs/1d0JkLNxEAf8Zz6wg/NfyGS7A9tFMrXCjGbG9ngalpkEJ74luYUxVS/
         L5Bg==
X-Gm-Message-State: ANoB5pkAcoAZmgrcYEqBLcOKzpXEKCgJ7cfjD8brRfN19fTXGbVDHmzD
        7VaeagvZyEWnxgH+KkWzf1+bHw==
X-Google-Smtp-Source: AA0mqf73AMcFFrVohNub6mN09kcuHEzO/Hjroa+swPIGqWYmTtnt7v9b2T2Xg9Oh7qblqYdsuiF+gA==
X-Received: by 2002:a17:902:cf06:b0:187:261a:8441 with SMTP id i6-20020a170902cf0600b00187261a8441mr7902841plg.16.1670612538799;
        Fri, 09 Dec 2022 11:02:18 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00189c536c72asm1669977plh.148.2022.12.09.11.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:02:18 -0800 (PST)
Date:   Fri, 09 Dec 2022 11:02:18 -0800 (PST)
X-Google-Original-Date: Fri, 09 Dec 2022 11:02:12 PST (-0800)
Subject:     Re: [RFC PATCH] riscv: vdso: remove hardcoded 0x800 .text section start addr
In-Reply-To: <Y3+XmWazrB0RURfI@xhacker>
CC:     ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-599fbea8-24d0-4d59-896f-7ce09eb6c1c6@palmer-ri-x1c9>
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

On Thu, 24 Nov 2022 08:11:05 PST (-0800), jszhang@kernel.org wrote:
> On Thu, Nov 24, 2022 at 11:32:55AM +0100, Andrew Jones wrote:
>> On Thu, Nov 24, 2022 at 12:18:05AM +0800, Jisheng Zhang wrote:
>> > It seems the hardcoded 0x800 isn't necessary, but removing it brings a
>>
>> s/, but/and/
>>
>> > small vdso.so and aligns with other architectures.
>>
>> This commit message didn't really satisfy my desire to understand why
>> the comment and '. = 0x800' were there in the first place and if its safe
>> to remove now, so I tried to do some of my own digging. I found
>>
>> commit 5b9304933730 ("x86 vDSO: generate vdso-syms.lds")
>> commit f6b46ebf904f ("x86 vDSO: new layout")
>>
>> which removes the comment and hard coding for x86 by changing the vdso
>> Makefile. Then looking at
>>
>> commit 9031fefde6f2 ("arm64: VDSO support")
>>
>> we see that it starts with the new Makefile approach and doesn't bother
>> with the hard coding from the start. As riscv also started with the new
>> Makefile approach it also could have dropped the hard coding from the
>> start (I guess).
>>
>> >
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> > ---
>> >  arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
>> >  1 file changed, 1 insertion(+), 7 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
>> > index 150b1a572e61..7be7e618d59c 100644
>> > --- a/arch/riscv/kernel/vdso/vdso.lds.S
>> > +++ b/arch/riscv/kernel/vdso/vdso.lds.S
>> > @@ -31,13 +31,7 @@ SECTIONS
>> >
>> >  	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
>> >
>> > -	/*
>> > -	 * This linker script is used both with -r and with -shared.
>> > -	 * For the layouts to match, we need to skip more than enough
>> > -	 * space for the dynamic symbol table, etc. If this amount is
>> > -	 * insufficient, ld -shared will error; simply increase it here.
>> > -	 */
>> > -	. = 0x800;
>> > +	. = ALIGN(4);
>>
>> I realize 4 is used here now because I questioned the 16, but after doing
>> my digging I think a larger alignment may be better. Loading the text may
>> be done with 8 byte or larger reads, so having the section aligned to a
>> larger size would be better reading it. We might as well use 16, like
>> arm64 does, and like you had before?
>>
>> Also, having enough separation between data and text seems to be
>> important for cache reasons, based on the comment in
>> ./arch/x86/entry/vdso/vdso-layout.lds.S and other vdso history.
>> Maybe we should move .note, .eh_frame_hdr, and .eh_frame below
>> .rodata like x86 has it?
>>
>
> Thank you so much for pointing out the two commits and above
> separation, new version will be sent out soon.

Not sure if I missed the v2?  I can't find one.
