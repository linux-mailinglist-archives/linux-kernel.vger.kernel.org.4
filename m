Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25E637044
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXCKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKXCKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:10:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A668E2BC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E52C61F90
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F071C4314A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669255843;
        bh=c9UdDpmuSX8C2v9Fvfsgma0HGHdxBqm/WGUiMAoGwYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VvMk2EdcB/JEOwaACLaobDK0LM6aSZsv05+QJOQVurIilX3a86ec2z7dNQvXEVAlZ
         Q2CWCvIVwCRZWCRxKDGxp7vCelwKFVkb8Igbr1YqjI1Zwnv9a3XeMsK9OyXxpx4Yhv
         DOa2MqTm4mN+Rv3ZDbyD4YEjApXeGzxw2tg+DJeBn0sl+u6oLQ3NuQNel+52TvGPR3
         iidAH8+uMf4T4bWdn2pZCRaLGTaWuFBg1t6+U5pJ7/Nvi9n/18MRXySOCO/kTxIAWO
         B91SRXLFMhLeHA0YEYhFKB+RozESS+hWpSw9xKOiWpZ/7DYOFIC4HojFmESX0FWlAm
         rZVat8eD1zt1A==
Received: by mail-ed1-f45.google.com with SMTP id z63so735931ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:10:43 -0800 (PST)
X-Gm-Message-State: ANoB5pkwDpJTjCRv8hEDnrnt/5n7O7TkXjW8ijwwwwT/HaGVK0SxR9Qn
        N0kiZzn5RnwQMQcogzH++iQwVZnoyw5Dz7QLoBM=
X-Google-Smtp-Source: AA0mqf7MS5mBZeSUrHoSEyV74Sek3FEghp4uaQK/VbW8jtQyx7r3Uu9BLluaul+nOfZ4ky6g9FT8jZB3FVPUTSyDoNA=
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id
 r26-20020a056402019a00b0046074135d46mr28223123edv.47.1669255841778; Wed, 23
 Nov 2022 18:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20221123153950.2911981-1-guoren@kernel.org> <20221123153950.2911981-2-guoren@kernel.org>
 <Y359eOOrm/lpDHjt@spud>
In-Reply-To: <Y359eOOrm/lpDHjt@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 24 Nov 2022 10:10:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRvSkXD+dmVGfObrKE6ZsJdQdcH1G-hRxmYsMSoMbm8vg@mail.gmail.com>
Message-ID: <CAJF2gTRvSkXD+dmVGfObrKE6ZsJdQdcH1G-hRxmYsMSoMbm8vg@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] riscv: ftrace: Fixup panic by disabling preemption
To:     Conor Dooley <conor@kernel.org>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 4:07 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Nov 23, 2022 at 10:39:46AM -0500, guoren@kernel.org wrote:
> > From: Andy Chiu <andy.chiu@sifive.com>
> >
> > In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> > forming a jump that jumps to an address over 4K. This may cause errors
> > if we want to enable kernel preemption and remove dependency from
> > patching code with stop_machine(). For example, if a task was switched
> > out on auipc. And, if we changed the ftrace function before it was
> > switched back, then it would jump to an address that has updated 11:0
> > bits mixing with previous XLEN:12 part.
> >
> > p: patched area performed by dynamic ftrace
> > ftrace_prologue:
> > p|      REG_S   ra, -SZREG(sp)
> > p|      auipc   ra, 0x? ------------> preempted
> >                                       ...
> >                               change ftrace function
> >                                       ...
> > p|      jalr    -?(ra) <------------- switched back
> > p|      REG_L   ra, -SZREG(sp)
> > func:
> >       xxx
> >       ret
> >
> > Fixes: fc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
>
> ==========
> verify_fixes - FAILED
>
> Commit: be26b864dac9 ("riscv: ftrace: Fixup panic by disabling preemption")
>         Fixes tag: Fixes: fc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> This should instead be:
> Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Thank you! Sorry, I missed the first letter :P

>
> Thanks,
> Conor.
>


-- 
Best Regards
 Guo Ren
