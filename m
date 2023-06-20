Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8C737517
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFTTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjFTTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:30:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D321704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:30:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-54fbcfe65caso4092661a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687289454; x=1689881454;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxbAB6x8wYPpV1ZKtdNP9xJrU3nLdB1/iIS73PBEfC8=;
        b=YScjX+HVPsTW42Q9iNRZVlLdte3SLQ1VHNdCDPsHAn/jerdshUD8c8yQ9zHQd7wcED
         t5p+PkI5uYBj5xd9ErM77/Eo0xKTLwtrRE7TjoVWXWJx3uO84Tzwi8APG8yXW7+yRY3A
         CsgYlza9FCWtcCkBepcbtbjGH0mCKr3w8rVwsvDeIGWUWjP8RcnxS0Rdi/oC/QwGVU59
         RT6JCk67Ms7umsS2I/0RzFmWLj+epGzTUL06GyAjEn7tp+KUan1rFXziaiSIXMkhoSv9
         Fq4R90lXHLZ/BjXcXmYcT4QuYq9AjFjit7SU8rHhLfdAHl8bNFYGV0aoTW3iNi1qZw/C
         Cw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289454; x=1689881454;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxbAB6x8wYPpV1ZKtdNP9xJrU3nLdB1/iIS73PBEfC8=;
        b=C5ymYLHnseF2x+iCHUGW6PkTUDG0gMujDq5VPejFyXqHPSxcHI3/VoVc9D16+BnvIW
         DTAGYlV2o+idZjRHPvcJ6ronjnou2CvTGqEHtOJTR0YdBmqjnfL0JgVdrfbHHt+RfVPU
         S/Nd5RHRwpkEPtpFHUtZTuQLr099hms7CjYY13WYqyJqmvwDw0Jy5aJAe1nWpgh2687A
         WMz5Rry6Qy6XGJQwC7aQq+t59b7uV45uZFW7WwjwoSwTojOP60VBPx69HIOkvoivtp9D
         J+CVI49Y4UbpH6KL5QB7LaIrENnARyY4nGFsgnEFPkToJiSSosQiwafDfW1yw8TB1UXS
         OCrw==
X-Gm-Message-State: AC+VfDwK3ASz7t5BpGZXyzojBp1QNec1OALlu8E3OQ5MF4q71ZFjH22d
        MUDNz/LOS2YeJtCRxDqAUW7Q/g==
X-Google-Smtp-Source: ACHHUZ5KirkJsChd1Dvw7/Wi3JSVnuoM7ljNp5I/iZ9TFT4X8h/6ceaPQvjv3ku2MbqEvjObKj6sJw==
X-Received: by 2002:a17:902:c40d:b0:1ac:6fc3:6beb with SMTP id k13-20020a170902c40d00b001ac6fc36bebmr22331826plk.9.1687289454320;
        Tue, 20 Jun 2023 12:30:54 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001a6dc4f4a8csm1983321plg.73.2023.06.20.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:30:53 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:30:53 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 12:28:45 PDT (-0700)
Subject:     Re: [PATCH] riscv: replace deprecated scall with ecall
In-Reply-To: <CAFP8O3JSaZ6D=nGoVu+-_t2HZBLX7M8wggALWKNWH=PnubY8yA@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maskray@google.com
Message-ID: <mhng-246452e8-2536-41b6-b143-f28779445a38@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 14:51:56 PDT (-0700), maskray@google.com wrote:
> On Thu, May 11, 2023 at 3:41 PM Fangrui Song <maskray@google.com> wrote:
>>
>> On Sun, Apr 23, 2023 at 3:32 PM Fangrui Song <maskray@google.com> wrote:
>> >
>> > scall is a deprecated alias for ecall. ecall is used in several places,
>> > so there is no assembler compatibility concern.
>> >
>> > Signed-off-by: Fangrui Song <maskray@google.com>
>> > ---
>> >  arch/riscv/kernel/entry.S             | 4 ++--
>> >  arch/riscv/kernel/vdso/rt_sigreturn.S | 2 +-
>> >  2 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> > index 99d38fdf8b18..2f51935612d1 100644
>> > --- a/arch/riscv/kernel/entry.S
>> > +++ b/arch/riscv/kernel/entry.S
>> > @@ -191,7 +191,7 @@ handle_syscall:
>> >         REG_S a0, PT_ORIG_A0(sp)
>> >         /*
>> >          * Advance SEPC to avoid executing the original
>> > -        * scall instruction on sret
>> > +        * ecall instruction on sret
>> >          */
>> >         addi s2, s2, 0x4
>> >         REG_S s2, PT_EPC(sp)
>> > @@ -603,6 +603,6 @@ END(excp_vect_table)
>> >  #ifndef CONFIG_MMU
>> >  ENTRY(__user_rt_sigreturn)
>> >         li a7, __NR_rt_sigreturn
>> > -       scall
>> > +       ecall
>> >  END(__user_rt_sigreturn)
>> >  #endif
>> > diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vdso/rt_sigreturn.S
>> > index 0573705eac76..10438c7c626a 100644
>> > --- a/arch/riscv/kernel/vdso/rt_sigreturn.S
>> > +++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
>> > @@ -11,6 +11,6 @@ ENTRY(__vdso_rt_sigreturn)
>> >         .cfi_startproc
>> >         .cfi_signal_frame
>> >         li a7, __NR_rt_sigreturn
>> > -       scall
>> > +       ecall
>> >         .cfi_endproc
>> >  ENDPROC(__vdso_rt_sigreturn)
>> > --
>> > 2.40.0.634.g4ca3ef3211-goog
>> >
>>
>> Ping:)
>>
>>
>> --
>> 宋方睿
>
> Ping^2 :)

Sorry this took a while, I had to fix up some merge issues but I think 
it's OK.  Should be on for-next now.
