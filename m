Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714CB73D50F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 00:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFYWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYWgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 18:36:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019F1BB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 15:36:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262e81f6154so227909a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687732567; x=1690324567;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsqNhkE5oWlMgtIBUOkdhdib6xZtYP/JVM/Zsc0j+ts=;
        b=cihVByItGc+eVG4fy+EISc6Bqco0E+A7e5FqMT8JF5b0t783oDa2N6FS+yHNR8JIZH
         Zb4RiTZgIp+m8w+DIbKDSNXBgGxFnJnlcD2xDghKMQn8huuoRW5ueQCZzR9ZYLQsg6Fz
         QC5rQL3JGLuVLms9u+yh2gdmlPirR8det57xQlpb/OHS6hZshppUKdVamBLmFEQZg27k
         Sdgw+xPpf+Yxl0skzejaeB86m/eizwSpjvG6VCyZxllPmExoCPMo1Z7H3WZYw9DHU2GO
         8RrNOsr94j4k/Bnn9v0xZzNgPCka5OuAiVcNqUIdnHEqEyQz7NzktKyTzda2C//Cfzn5
         Rvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687732567; x=1690324567;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsqNhkE5oWlMgtIBUOkdhdib6xZtYP/JVM/Zsc0j+ts=;
        b=IP34kGWJ6zs8qGffRCHN+qo6e9n6H8a7BMRLKOgN3Fm8NX2UvF1K/0/86DG7qkdauM
         1h98ZgnUwbRWKEVYvadcjKmI7poyEkOOhvIxF8PYSe17t5WDWkRWKEr5zpV8wZsBpruq
         298VJsDmysFuUySfuOGWqu74DnGcdE7d0xsEvGSViGV5vQpgvvvsjyNrV6qsGPX3B1fH
         9FCfvv22oPD8+DcG9wTI3Arl3pXjIRtU1wuq6CL88YcYnLRS2W8H/QOZEv3zBfKuu2Tz
         RdQzcwXyHgaoPxXXCOEaV8F+jAGBIzweJ0CCOnz3lzEN6W4r1m9TY1GH0dCyE0TBU1tl
         aZSA==
X-Gm-Message-State: AC+VfDzMjarUqH0bgn2Gi8hmrn73RrznIv/yLDLOVyIayuwCO9aHHZSw
        21lyuBmiwcRFcoFO9iP1mFWrFw==
X-Google-Smtp-Source: ACHHUZ69BZVi1KJzS7hQaMLqlt1Sd5kzMCZwpAk6rFMb0eeKG+qy91PnYxOv+QVg7tosGmhPDxdWVw==
X-Received: by 2002:a17:90a:1:b0:262:b3f8:6ae with SMTP id 1-20020a17090a000100b00262b3f806aemr3976171pja.46.1687732567008;
        Sun, 25 Jun 2023 15:36:07 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id ip4-20020a17090b314400b0025374fedab4sm4789374pjb.22.2023.06.25.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 15:36:06 -0700 (PDT)
Date:   Sun, 25 Jun 2023 15:36:06 -0700 (PDT)
X-Google-Original-Date: Sun, 25 Jun 2023 15:35:24 PDT (-0700)
Subject:     Re: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
In-Reply-To: <20230625-obstinate-grimy-b765a1d3d741@spud>
CC:     suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, Arnd Bergmann <arnd@arndb.de>, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        Conor Dooley <conor.dooley@microchip.com>, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-57d088de-b527-4f19-89f5-fec31a6df475@palmer-ri-x1c9a>
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

On Sun, 25 Jun 2023 15:15:14 PDT (-0700), Conor Dooley wrote:
> Hey,
>
> On Sun, Jun 25, 2023 at 11:09:21PM +0800, Song Shuai wrote:
>
>> Sorry for the delayed reply,
>
> It wasn't really delayed at all actually, you replied within an hour or
> so, AFAICT.
>
>> My tinylab email went something wrong, I'll use gmail in this thread.
>> 
>> 在 2023/6/25 22:18, Conor Dooley 写道:
>> > On Sun, Jun 25, 2023 at 10:09:29PM +0800, Song Shuai wrote:
>> > > This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.
>> > > 
>> > > With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
>> > > linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
>> > > load address which was placed at a PMD boundary.
>> > 
>> > > And firmware always
>> > > correctly mark resident memory, or memory protected with PMP as
>> > > per the devicetree specification and/or the UEFI specification.
>> > 
>> > But this is not true? The versions of OpenSBI that you mention in your
>> > cover letter do not do this.
>> > Please explain.
>> > 
>> 
>> At this time, OpenSbi [v0.8,v1.3) and edk2(RiscVVirt) indeed don't obey the
>> DT/UEFI spec. This statement is excerpted from "Reserved memory for resident
>> firmware" part from the upcoming riscv/boot.rst. It isn't accurate for now.
>> How about deleting this one?
>
> It is incorrect, so it will need to be removed, yes.
> Unfortunately writing a doc does not fix the existing implementations :(
>
>> Actually with 3335068f8721 reverted, the change of MIN_MEMBLOCK_ADDR can
>> avoid the mapping of firmware memory, I will make it clear in the next
>> version.
>
> To be honest, I'd like to see this revert as the final commit in a
> series that deals with the problem by actually reserving the regions,
> rather than a set of reverts that go back to how we were.
> I was hoping that someone who cares about hibernation support would be
> interested in working on that - *cough* starfive *cough*, although maybe
> they just fixed their OpenSBI and moved on.
> If there were no volunteers, my intention was to add a firmware erratum
> that would probe the SBI implementation & version IDs, and add a firmware
> erratum that'd parse the DT for the offending regions and reserve them.

Is there any actual use case for hibernation on these boards?  Maybe 
it's simpler to just add a "reserved regions actually work" sort of 
property and then have new firmware set it -- that way we can avoid 
sorting through all the old stuff nobody cares about and just get on 
with fixing the stuff people use.

>
> Cheers,
> Conor.
>
>> > > So those regions will not be mapped in the linear mapping and they
>> > > can be safely saved/restored by hibernation.
>> > > 
>> > > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> > > ---
>> > >   arch/riscv/Kconfig | 5 +----
>> > >   1 file changed, 1 insertion(+), 4 deletions(-)
>> > > 
>> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > index 5966ad97c30c..17b5fc7f54d4 100644
>> > > --- a/arch/riscv/Kconfig
>> > > +++ b/arch/riscv/Kconfig
>> > > @@ -800,11 +800,8 @@ menu "Power management options"
>> > >   source "kernel/power/Kconfig"
>> > > -# Hibernation is only possible on systems where the SBI implementation has
>> > > -# marked its reserved memory as not accessible from, or does not run
>> > > -# from the same memory as, Linux
>> > >   config ARCH_HIBERNATION_POSSIBLE
>> > > -	def_bool NONPORTABLE
>> > > +	def_bool y
>> > >   config ARCH_HIBERNATION_HEADER
>> > >   	def_bool HIBERNATION
>> > > -- 
>> > > 2.20.1
>>
