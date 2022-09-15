Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0606E5BA0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIOSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIOSs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:48:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D09C1F2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:48:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b23so18922243pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=nzN4TyiTu/X8WAurRhkbXC36H2L4MWW2PoQoLXhqLcE=;
        b=LZDW87FSIwPstY1qzL4UsH73KhoyRifwSXjD+rWJo8ryGkYwNJedTxWXbrRqpGmdWs
         3mL+jU2nvuEC2N2CpSSKqAKzIGAyXHRQc1xqr39T3sIxIC4wSy12/JYHHT9XwJ4zjBWk
         kiYqOdLDESYNv55bWp29QjiXG5a97teLGK+wRlvZc6BF3L6xWhSnAQescnqTChcPywvu
         Rm5uxKCXp5/giu+k3wm/uunVGS8yR23XEymAsBddd9mEcrbKbEch7xc7psMnRNmplqjx
         lbMLwwAIFHYTqdSqQS5OU6z8Iw72MBhK+dwpOYcoG+eDgHzq1MKTFjeu5lxONyR0ti5b
         C7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nzN4TyiTu/X8WAurRhkbXC36H2L4MWW2PoQoLXhqLcE=;
        b=HyoAcnzxDF9K9BNvY3WXC0v+QFlNOIWMcvCmKmt/QUPCT1+7j07ynPKLsYuo6YertQ
         pB2Bq1brj7oN5LQiXw5Ft+yQB4qWp6AFvwBcrE+8cTS1dxSoqcaOVxYXx1TzYrgagzB4
         3pC+LHzo6d1i5b940Oj4bytQt+KEeRsNWw4RQ/kbyxOf+P9RupR8A2JoELnzZVYomuxf
         aSRZT1JC5uBXhD9ixzLXNRXPp7iZ9/b01YBvZx1e0bf0DmAwxgpn9qWjsJTvXpHGyvEr
         FcHuXTCmexe9ZjnHXB3TBiU4SGtflbqxNAkg7eVLhfKKHvyXez/eoMSxYd2+sSxNMLPP
         AtPg==
X-Gm-Message-State: ACrzQf2jm/Jk/lbzkUTEkhS3e81HLLIzuo4w0vyb2aUT1j8iBz16SiKN
        /yDoyj5Oj9vftUSHRvY3Dp/ikQ==
X-Google-Smtp-Source: AMsMyM4jTMgoRTPQkiYw9ISiXw/RY3S7O4HMvcs5dQsRmIdu4kuNsLOpiqd2iEHFJ+i17qJttCvbJQ==
X-Received: by 2002:a63:1304:0:b0:439:ac9b:34af with SMTP id i4-20020a631304000000b00439ac9b34afmr1062185pgl.464.1663267702450;
        Thu, 15 Sep 2022 11:48:22 -0700 (PDT)
Received: from localhost ([172.58.176.196])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a598b00b001ef8ab65052sm1996135pji.11.2022.09.15.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:48:22 -0700 (PDT)
Date:   Thu, 15 Sep 2022 11:48:22 -0700 (PDT)
X-Google-Original-Date: Thu, 15 Sep 2022 11:47:59 PDT (-0700)
Subject: Re: [PATCH] riscv: fix a nasty sigreturn bug...
In-Reply-To: <YxJEiSq/CGaL6Gm9@ZenIV>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     viro@zeniv.linux.org.uk, ajones@ventanamicro.com
Message-ID: <mhng-d888fd65-86fc-4c2d-8a0f-801e9da62701@palmer-ri-x1c9>
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

> Ping?  Does anybody have objections?  AFAICS, the bug is still
> there...

Sorry, something's gone off the rails with email and this thread doesn't 
show up in my inbox (not even any of the replies).  I tried to patch 
together this reply manually so hopefully it works.

This is on fixes, thanks -- trying to debug this one would have been a 
nightmare.

> On Fri, Sep 24, 2021 at 01:55:27AM +0000, Al Viro wrote:
>> riscv has an equivalent of arm bug fixed by 653d48b22166; if signal
>> gets caught by an interrupt that hits when we have the right value
>> in a0 (-513), *and* another signal gets delivered upon sigreturn()
>> (e.g. included into the blocked mask for the first signal and posted
>> while the handler had been running), the syscall restart logics will
>> see regs->cause equal to EXC_SYSCALL (we are in a syscall, after all)
>> and a0 already restored to its original value (-513, which happens to
>> be -ERESTARTNOINTR) and assume that we need to apply the usual
>> syscall restart logics.
>>     
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> ---
>> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
>> index c2d5ecbe55264..f8fb85dc94b7a 100644
>> --- a/arch/riscv/kernel/signal.c
>> +++ b/arch/riscv/kernel/signal.c
>> @@ -121,6 +121,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>  	if (restore_altstack(&frame->uc.uc_stack))
>>  		goto badframe;
>>  
>> +	regs->cause = -1UL;
>> +
>>  	return regs->a0;
>>  
>>  badframe:
