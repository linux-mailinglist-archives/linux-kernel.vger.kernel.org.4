Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8F73A106
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjFVMf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjFVMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:35:55 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D51BC6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:53 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-471b3ad20e1so1399250e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687437352; x=1690029352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BwL1XXFpB7Juc23gGcrmpmP3rd5YyIO3kgOAyPIlzcM=;
        b=CqGj2E1L8WAGd6HSmOq2ffig5DVss6jWELqzntl3GKlXUEYm5evoPvavsg0cZPdyUG
         uVYi/gfibC8xVIb/UDtPwlUBdDgsGbxguuycXjG2YxnCEy6H8kcNelG4AmVpMpuckiFA
         eyEowBgxCKXjLiR8L0kyDyIwgAAsE6ldsvwGIJ3f6rUlNWz3fc1ZPRn8DOTpQsHvf9U3
         rCVWH3iloZlCntq1nkRIF3PZgXJe73H9ULOZzTrIaIObG/zpStYEiw4JdcsdNwNBIaPh
         qAF5aEyVo3tt/zl56/6m0CiD/OPH7Vi4QYEnxzx/YEwhml9wARWBRGCZwE5R0GDgcGQY
         E3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437352; x=1690029352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwL1XXFpB7Juc23gGcrmpmP3rd5YyIO3kgOAyPIlzcM=;
        b=S1Jg5Rric7lC+ppjR6KmZm6PlkuRtPJHxCUU7Vm18BlPOexbv9zTrLYOhYN0yAT2Mm
         RQauC8sWHEk5yFte6zI4xG3xjCpnBceTNBK6ZV+SKLGwVCFLZZQU9fTiKiY09NKVYQoi
         LwjR7lV+tq7GvVnTZRjOtokjr57gs0hdyFbuCJaMYc9hQqZ/lCOyuBLNKwK2oRdTa26G
         C45DvgCxVRgluUxSQjq6YZcvvrD/a8JAJXaci3nHRYpPSGmOmArxdiWPJQRpfu8tWm/+
         kGclF6EdxWWYF2s4dMp2kwGwGXv/0JBrtbqjh3CLM5RfAhDBrWazUENZCusV6WbFDGST
         BPNA==
X-Gm-Message-State: AC+VfDz87I66BETb75tmGYSE16HiPE2Rr25hoVRVrcBVbu+6pzFtZ5qh
        0nRkwQJitGVZ7lmOfkYdAuJwpnpQazEwg8HdWybsyw==
X-Google-Smtp-Source: ACHHUZ4bpL2T9bnI4qregSI95k/VcQbvtJLdxgrvfNu5HuW8eTOaNzhJ0fgEC/46fMtfm/dxsGD0owYkxtdDBTEbKLI=
X-Received: by 2002:a1f:e201:0:b0:471:4ceb:675f with SMTP id
 z1-20020a1fe201000000b004714ceb675fmr5066318vkg.9.1687437352169; Thu, 22 Jun
 2023 05:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
In-Reply-To: <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 22 Jun 2023 18:05:40 +0530
Message-ID: <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 22 Jun 2023 at 15:12, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > Following boot warnings and crashes noticed on arm64 Rpi4 device running
> > > Linux next-20230621 kernel.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > boot log:
> > >
> > > [   22.331748] Kernel text patching generated an invalid instruction
> > > at 0xffff8000835d6580!
> > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] PREEMPT SMP
> >
> > This indicates execution of AARCH64_BREAK_FAULT.
> >
> > That could be from dodgy arguments to aarch64_insn_gen_*(), or elsewhere, and
> > given this is in the networking code I suspect this'll be related to BPF.
> >
> > Looking at next-20230621 I see commit:
> >
> >   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> >
> > ... which changed the way BPF allocates memory, and has code that pads memory
> > with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might* be related.
>
> For the benefit of those just looknig at this thread, there has been some
> discussion in the original thread for this commit. Summary and links below.
>
> We identified a potential issue with missing cache maintenance:
>
>   https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S0Q05N/
>
> Puranjay verified that was causing the problem seen here:
>
>   https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com/
>
> Alexei has dropped this commit for now:
>
>   https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_Dehyf=SkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/

Thanks for the detailed information.
I am happy to test any proposed fix patches.


>
> Thanks,
> Mark.

- Naresh
