Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB4671B39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjARLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjARLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:46:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15036697
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:09:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CC1AB81C52
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1B5C433D2;
        Wed, 18 Jan 2023 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674040139;
        bh=GvpUj3xLuNjjGGKiolsN/80QxOzBKhmKRzegY8kskMI=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=isWW50P9c2NFbryW876/62nH0oCkqVQLrurvR60LsZMO8Zwbz93UNRmzM/k4UgZ0b
         8v44oYLfomS+fDexpJqmNRPd7P2DkqP6u1/4TOJr6myOLVVP0WPG8ARtIrX0BobzyC
         2l9+gDdTsf2OD+rXNE4Zzx/cMqC2GIJc1CzABzhLhwAZqScD44zAU33osq/2mwV3PS
         QnoyZuQlzRJ8ac3kOoFM/Jvv+CnD+osBHEF21XcfflTxKFTnO9Q09HKBTi0Dan9be7
         LHlK5JOgw3V+E60nkQNPoFl7rFdCT+zegQW2s4Z5sSGN59BeDZkRqfNS+ZrrVsDr7j
         8hHkOc+JliylQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: Add instruction dump to RISC-V splats
In-Reply-To: <CAMuHMdXi7yEiS73YhQAQKqj+3rTCNmuRrdnNKS4prvG96Xgqog@mail.gmail.com>
Date:   Wed, 18 Jan 2023 12:08:56 +0100
Message-ID: <87pmbcnlpz.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> +static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
>> +{
>> +       char str[sizeof("0000 ") * 12 + 2 + 1], *p =3D str;
>> +       unsigned long addr =3D regs->epc;
>
> Given you never use this as an unsigned long, what about
>
>     const u16 *insns =3D (u16 *)instruction_pointer(regs);
>
> so you no longer need casts below?

Indeed! Good suggestion, thank you! I'll do this change in v3.

>> +       long bad;
>> +       u16 val;
>> +       int i;
>> +
>> +       for (i =3D -10; i < 2; i++) {
>> +               bad =3D get_kernel_nofault(val, &((u16 *)addr)[i]);
>> +               if (!bad) {
>> +                       p +=3D sprintf(p, i =3D=3D 0 ? "(%04hx) " : "%04=
hx ", val);
>> +               } else {
>> +                       printk("%sCode: Unable to access instruction at =
0x%lx.\n",
>
> %px, so you can drop the cast to long below.

Much cleaner. Thanks!


Bj=C3=B6rn
