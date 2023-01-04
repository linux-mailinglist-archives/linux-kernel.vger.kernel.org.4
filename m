Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53465CF44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjADJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjADJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:12:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBFB1C408
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:12:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC72B810FA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41330C433D2;
        Wed,  4 Jan 2023 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672823545;
        bh=Hr95qdIHJ3vIdDscritgygh7Q2O7d4i8wglmOqf/p48=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=u3+CsheNf9bobT93mNgsGA68gR+9bS/z0GyylZIoWcbeiwOQ2OnLHh0Kiqmb95dIl
         bzF1L0nlgALs1KD1uxDcn7s73yNMp/Wbu2st8NdkwUoH87ZtVrfH7ku+e+oXOcNiq+
         HmT5wHRWfJ3dKgCSirXyVW4K/huMlbt90n/CV7t4sa+V5SDLOLS1UerflfR2XkWrNW
         XkuTQdntlgyqoKso1QIJnF0zhsuxCLgNMqDtKQALzpJDikb9W2ohSkkUogq5tCZcM9
         T55cKec4lKKrQXMoVtdKJpJ2JR0tRYCyXPsHWzOc5bUAmLKedYU6X3YO1l9GN3eNiK
         rTQGD2DeNNMxQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] riscv/kprobe: Prepare detour buffer for
 optimized kprobe
In-Reply-To: <088ed826-59a8-37a3-401e-2ed022a4a097@huawei.com>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-8-chenguokai17@mails.ucas.ac.cn>
 <87r0wcvmn1.fsf@all.your.base.are.belong.to.us>
 <088ed826-59a8-37a3-401e-2ed022a4a097@huawei.com>
Date:   Wed, 04 Jan 2023 10:12:23 +0100
Message-ID: <87sfgqr7d4.fsf@all.your.base.are.belong.to.us>
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

"liaochang (A)" <liaochang1@huawei.com> writes:

>>> +SYM_ENTRY(optprobe_template_insn, SYM_L_GLOBAL, SYM_A_NONE)
>>> +	/*
>>> +	 * Step3:
>>> +	 * NOPS will be replaced by the probed instruction, at worst case 3 R=
VC
>>> +	 * and 1 RVI instructions is about to execute out of line.
>>> +	 */
>>> +	nop
>>=20
>> A nop here will be either a compressed nop or a non-compressed,
>> depending on the build (C-enabled or not), right? Maybe be explicit to
>> the assembler what you want?
>>=20
>
> You are right, if CONFIG_RISCV_ISA_C is disabled, two NOP is enough for 2=
 RVI execute out of line,
> if CONFIG_RISCV_ISA_C is enabled, it needs eight C.NOP here for the worst=
 case (3 RVC + 1 RVI).
>
> I will use {C}.NOP explicitly for different configure in next revision, t=
hanks.

What I meant was that "nop" can expand to compressed instructions, and
you should be explicit. So you know how it's expanded by the
compiler/assembler.

An example:

$ cat bar.S
	.text
bar:
	nop
	nop
$ riscv64-linux-gnu-gcc -O2 -o bar.o -c bar.S && riscv64-linux-gnu-objdump =
-M no-aliases -d bar.o

bar.o:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <bar>:
   0:	0001                	c.addi	zero,0
   2:	0001                	c.addi	zero,0


vs

$ cat foo.S
	.text
foo:
	.option norvc
	nop
	nop

$ riscv64-linux-gnu-gcc -O2 -o foo.o -c foo.S && riscv64-linux-gnu-objdump =
-M no-aliases -d foo.o

foo.o:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <foo>:
   0:	00000013          	addi	zero,zero,0
   4:	00000013          	addi	zero,zero,0


Bj=C3=B6rn
