Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800A7122AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbjEZIvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbjEZIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:50:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F84135;
        Fri, 26 May 2023 01:50:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so759542a12.3;
        Fri, 26 May 2023 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685091056; x=1687683056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUvWLoLJ7ecOqnvXeIvpdjcIeOwM/KgQz5/8pA9G8eQ=;
        b=n84NiyNjWL1xHP6179rB/rjlflDf5X2HBFQ63nbtEgqvmk9lOoFy98AwhuuOGcGLLZ
         sRC0lvwHR8T9j1pFRXiRzeIW7cJCYhJZUvJaYfEw7/ugrQzqpBIKVjvmZq2KsOAIbteM
         QSD/sC+dRhzssEexVYJLwthLIZIMQlgKerWfGQIXgVsmMgL+CFd//j+mdPSTMylWg/mN
         Z5SyA7v208OHyaDuH2s3qmioliEg5QOLjHPFbD154gszPG7OBzh4X0kccRieqw+uf/VF
         XapyyMNJWhFSON2li3VQjCVZAlLiDtmKktG3bJbh0e+81e1YPcnOB65bU4pYFbDnq+ED
         FN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091056; x=1687683056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUvWLoLJ7ecOqnvXeIvpdjcIeOwM/KgQz5/8pA9G8eQ=;
        b=WPm+JRA9n/pY0RefVd8eXAHXZsiL08MfEKW34WUzAhAIp0kGDIseVeZB3X0foHrnLk
         F2OjAtwnJRUobVqHckvLPvjedar2recsk7DAqvmXwYI2SzOtYwiGC2bGDrijZwbwMaED
         ZEmmft4AclV//DJes4pat04pmeQsK5pVsFXOj58CwvihHDcmOoL3/Lh7YO1XrcbtLRIN
         u12TUcs08xOTBWiguxshCo+R9wLwwcSHDAqlPG5gKbqpOqEF2bFRDEukLVpLsYP5z4mx
         lTKHby9HcXHig/buGUZoZAYPVmCoreYW+ry5shHwYr7qskiazqrhCfljsBzt4X/Ph8Ju
         s9aA==
X-Gm-Message-State: AC+VfDxnLDKL/1klitX+TPs+itzQAJdMMgufnV6vphyOUYbFvo+/5srn
        NeSteESRlv8Otn997FcXyOo=
X-Google-Smtp-Source: ACHHUZ5vLWV4BA5GbUd7uTb6R3TNt35h/LrNw5FK47z6XTA7FhoAMdRuoTd1JbFzYtOHZbAJyUOY9A==
X-Received: by 2002:a17:907:7e81:b0:959:6fb2:1c3b with SMTP id qb1-20020a1709077e8100b009596fb21c3bmr1366954ejc.39.1685091055982;
        Fri, 26 May 2023 01:50:55 -0700 (PDT)
Received: from gmail.com (1F2EF43E.nat.pool.telekom.hu. [31.46.244.62])
        by smtp.gmail.com with ESMTPSA id e14-20020a50ec8e000000b00509d1c6dcefsm1347783edr.13.2023.05.26.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:50:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 26 May 2023 10:50:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: boot failure after merge of the tip tree
Message-ID: <ZHBy6hkfQze53pOS@gmail.com>
References: <20230524154459.48cda184@canb.auug.org.au>
 <20230524093454.GI4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524093454.GI4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 24, 2023 at 03:44:59PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the tip tree, today's linux-next build (powerpc
> > pseries_le_defconfig) failed to boot like this:
> > 
> >  Built 1 zonelists, mobility grouping on.  Total pages: 32736
> >  Policy zone: Normal
> >  mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> >  Memory: 2027392K/2097152K available (17984K kernel code, 3328K rwdata, 14784K rodata, 6080K init, 1671K bss, 69760K reserved, 0K cma-reserved)
> > 
> > *crickets*
> > 
> > Bisected to commit
> > 
> >   f4ab23558310 ("slub: Replace cmpxchg_double()")
> > 
> > I have reverted that commit (and the following one) for today.
> 
> Sorry about that; turns out I forgot to test the case where cmpxchg128
> wasn't available.
> 
> Please see:
> 
>   https://lkml.kernel.org/r/20230524093246.GP83892@hirez.programming.kicks-ass.net
> 
> As stated there, I'm going to zap tip/locking/core for a few days and
> let this fixed version run through the robots again before re-instating
> it.

Note to -next, this should now be resolved in the tip:auto-latest branch.

Thanks,

	Ingo
