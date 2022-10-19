Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1458603924
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJSFTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJSFTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:19:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA36BCC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:19:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z20so15863665plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWFxEAB2F9CbS75gH5wpSsFQfxQPeaI8Ne8SV0JZG80=;
        b=ReRhsKvZzOsIbmwWPB1VIdcN0lbglhKGeOT1nPGZ0vfZoJjE6oYe4sIFwHZCW0lYlO
         C2v7J2hSI0MNSPePVJEBO1U6nTeFIMAkzM/WWDpGDTmxKfhUwCWUcXCpXP6Mp/WoSXF3
         Z2U/GQ1ui1g/HL6Ly9Uf++2TsL17Wacdr8mxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWFxEAB2F9CbS75gH5wpSsFQfxQPeaI8Ne8SV0JZG80=;
        b=LrAPoEorZ40BfP18EvPndIWm7LilQ0qjRx5agx+XpOBAFA2RIiYjaL+ZNzj4SZjIFh
         xo9dGMg6+qVxKcASjE7ySctiyIW1j0AANbIvmi3FDSTEbZ4jHAWu8z6AUgGL8i0n8ulW
         2WuVe8B7E3gFo1E2vCBwqCai0tFhYosp+GYnp7/DpMgJHkOzBIqNAeLKKmSUdxT0RR6R
         zHUth1s10HhoYIACk07IMyId+mU+g2C/LD5DwQTiWZ4oPMP+ZOYonI7p9VKezl24Un1L
         DY/935Hl6SUmeJTkuucADxZLgDi9K1aMgGsBEPCBirwUWciZH/CsUnkb3yetcv4ZMA56
         9TaA==
X-Gm-Message-State: ACrzQf1J3Qc8VTXpCl7yMHDETwnlmriAnTptXrCKS5454aUhfLxlIgEi
        XhAPYAtY6CNw+/ahVtvTBfBkww==
X-Google-Smtp-Source: AMsMyM4TxQtKtb96YYNVsIsXE90IQjM2hukfsZUtef2BpH1Fmx92QXjgqr9Lr6gbiISzgg4Il7z7UQ==
X-Received: by 2002:a17:902:bf08:b0:178:90fb:8cda with SMTP id bi8-20020a170902bf0800b0017890fb8cdamr6605600plb.9.1666156752757;
        Tue, 18 Oct 2022 22:19:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b0017d7e5a9fa7sm5426773pll.92.2022.10.18.22.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:19:11 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:19:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182218.56AD2871@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
 <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
 <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:48:42PM -0700, Joao Moreira wrote:
> > > Is it useful to get the compiler to emit 0xcc with
> > > -fpatchable-function-entry under any circumstance? I can probably
> > > change
> > > that quickly if needed/useful.
> > 
> > Having it emit 0xcc for the bytes in front of the symbol might be
> > interesting. It would mean a few kernel changes, but nothing too hard.
> > 
> > That is, -fpatchable-function-entry=N,M gets us N-M bytes in at the
> > start of the symbol and M bytes in front of it. The N-M bytes at the
> > start of the function *are* executed and should obviously not become
> > 0xcc (GCC keeps them 0x90 while LLVM makes them large NOPs).
> 
> Uhum, all makes sense. I drafted something here:
> 
> https://github.com/lvwr/llvm-project/commits/joao/int3
> 
> Let me know if this works for you or if there is something that should be
> tweaked, like adding a specific flag and such. This currently emits 0xcc
> instead of 0x90 for the nops before the function entry symbol for kernel
> code on x86-64. It seems to be working (see generated snippet below), but
> let me know otherwise:
> 
> Generated with -fpatchable-function-entry=10,5
> 
> Disassembly of section .text:
> 
> 0000000000000000 <save_processor_state-0x5>:
>    0:   cc                      int3
>    1:   cc                      int3
>    2:   cc                      int3
>    3:   cc                      int3
>    4:   cc                      int3
> 
> 0000000000000005 <save_processor_state>:
>    5:   0f 1f 44 00 08          nopl   0x8(%rax,%rax,1)
>    a:   41 57                   push   %r15
>    c:   41 56                   push   %r14

Cool! I like that. Assuming objtool doesn't freak out, that seems like a
nice way to go.

-- 
Kees Cook
