Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72AC698E28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBPH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:56:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C991242BFA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:55:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AFEBB825D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B89C433EF;
        Thu, 16 Feb 2023 07:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676534083;
        bh=KA/5JF5HlerkurForNO9JKH5IFf6vgsN6Wv08r1dIwM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l/WJ5eYYPOVw4F5vwb0QTZCVSVofcMD8FP6A6jZfcJsTs2qNkbEuZntflodp7jdjM
         U395s6xJr3Ll2QU3lJST1ALbt4JjCwjremXGiRU5dIC5tj5OdJJfnKsDviK988ESrg
         ubh/YJjD7lWxQj2S7uVO+AvKs+5wnP6RqHzSuzYIbtwrklFdnJwaooLHvzXNchiCJV
         oPe8Uf9t6Lpb5xP8xV1MpO0NN298ErBhPmfmz652cxGdDFBHhAKM+N1HDdJ2Vnb4w+
         GVi7KzDV0DsuEtITSI1/EX3SBp/6eBaCipwNuoVWfckGLCHbaANlCeHa4zKCVfl9Nj
         lFEOtMN0c9oCQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>, Andrea Parri <parri.andrea@gmail.com>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
 <Y9jz+zUDebQ4VLlF@andrea>
 <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
Date:   Thu, 16 Feb 2023 08:54:41 +0100
Message-ID: <878rgy3v0e.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Tue, Jan 31, 2023 at 6:57 PM Andrea Parri <parri.andrea@gmail.com> wro=
te:
>>
>> > > It's the concurrent modification that I was referring to (removing
>> > > stop_machine()). You're saying "it'll always work", I'm saying "I'm =
not
>> > > so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say that
>> > Software must ensure write c.ebreak on the head of an 32b insn.
>> >
>> > That means IFU only see:
>> >  - c.ebreak + broken/illegal insn.
>> > or
>> >  - origin insn
>> >
>> > Even in the worst case, such as IFU fetches instructions one by one:
>> > If the IFU gets the origin insn, it will skip the broken/illegal insn.
>> > If the IFU gets the c.ebreak + broken/illegal insn, then an ebreak
>> > exception is raised.
>> >
>> > Because c.ebreak would raise an exception, I don't see any problem.
>>
>> That's the problem, this discussion is:
>>
>> Reviewer: "I'm not sure, that's not written in our spec"
>> Submitter: "I said it, it's called -accurate atomicity-"
> I really don't see any hardware that could break the atomicity of this
> c.ebreak scenario:
>  - c.ebreak on the head of 32b insn
>  - ebreak on an aligned 32b insn
>
> If IFU fetches with cacheline, all is atomicity.
> If IFU fetches with 16bit one by one, the first c.ebreak would raise
> an exception and skip the next broke/illegal instruction.
> Even if IFU fetches without any sequence, the IDU must decode one by
> one, right? The first half c.ebreak would protect and prevent the next
> broke/illegal instruction. Speculative execution on broke/illegal
> instruction won't cause any exceptions.
>
> It's a common issue, not a specific ISA issue.
> 32b instruction A -> 16b ebreak + 16b broken/illegal -> 32b
> instruction A. It's safe to transform.

Waking up this thread again, now that Changbin has showed some interest
from another thread [1].

Guo, we can't really add your patches, and claim that they're generic,
"works on all" RISC-V systems. While it might work for your I/D coherent
system, that does not imply that it'll work on all platforms. RISC-V
allows for implementations that are I/D incoherent, and here your
IFU-implementations arguments do not hold. I'd really recommend to
readup on [2].

Now how could we move on with your patches? Get it in a spec, or fold
the patches in as a Kconfig.socs-thing for the platforms where this is
OK. What are you thoughts on the latter?


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/20230215034532.xs726l7mp6xlnkdf@M91=
0t/
[2] https://github.com/riscv/riscv-j-extension/blob/master/id-consistency-p=
roposal.pdf
