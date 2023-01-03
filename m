Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A243565BADA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjACGo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjACGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:44:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0DDCFF;
        Mon,  2 Jan 2023 22:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DB3AB80E15;
        Tue,  3 Jan 2023 06:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85993C433D2;
        Tue,  3 Jan 2023 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672728292;
        bh=/5lMFYxeFk4tjVM5Sh1D4dpCcs4gKL4U7mbXKFl9Uh8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XZ/vpsOESYRh8ZWz0uxpiUANHiIBRN71wk6PU5xY4tprr93vWqFQlUKy3GQS9ryA3
         aN4b16a9Lo9jjGmWnl9abxUjVJzve6Rhy0a45zfdoNuJCbxvYlKH6y/8vHnTbxAHsG
         286P8RV389ST+mFodfka7ZfNAgIko5hR6IOYE8SJRaEX/AYDFK16fXbihXO3oj/sWN
         XvrU0EZqstjhw9egLIFzD8Wk43BXu2c3K44OvFkA7M/nQmekRyw9Y1nwnkTxGl3xKv
         TBoMcEFYbWc62ULPdu4TWxAJ7fZl81ZX4jkP2yEKOCbbQg28N2v6p7OHSCw6j6Ckse
         YlB7iYDZnikvg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv, kprobes: Stricter c.jr/c.jalr decoding
In-Reply-To: <Y7M/HlcF3u0qWIDJ@spud>
References: <20230102160748.1307289-1-bjorn@kernel.org> <Y7M/HlcF3u0qWIDJ@spud>
Date:   Tue, 03 Jan 2023 07:44:49 +0100
Message-ID: <87sfgsp15q.fsf@all.your.base.are.belong.to.us>
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

Conor Dooley <conor@kernel.org> writes:

> Hey Bjorn,
>
> On Mon, Jan 02, 2023 at 05:07:48PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> In the compressed instruction extension, c.jr, c.jalr, c.mv, and c.add
>> is encoded the following way (each instruction is 16b):
>>=20
>> ---+-+-----------+-----------+--
>> 100 0 rs1[4:0]!=3D0       00000 10 : c.jr
>> 100 1 rs1[4:0]!=3D0       00000 10 : c.jalr
>> 100 0  rd[4:0]!=3D0 rs2[4:0]!=3D0 10 : c.mv
>> 100 1  rd[4:0]!=3D0 rs2[4:0]!=3D0 10 : c.add
>>=20
>> The following logic is used to decode c.jr and c.jalr:
>>=20
>>   insn & 0xf007 =3D=3D 0x8002 =3D> instruction is an c.jr
>>   insn & 0xf007 =3D=3D 0x9002 =3D> instruction is an c.jalr
>>=20
>> When 0xf007 is used to mask the instruction, c.mv can be incorrectly
>> decoded as c.jr, and c.add as c.jalr.
>>=20
>> Correct the decoding by changing the mask from 0xf007 to 0xf07f.
>>=20
>> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/kernel/probes/simulate-insn.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kerne=
l/probes/simulate-insn.h
>> index cb6ff7dccb92..de8474146a9b 100644
>> --- a/arch/riscv/kernel/probes/simulate-insn.h
>> +++ b/arch/riscv/kernel/probes/simulate-insn.h
>> @@ -31,9 +31,9 @@ __RISCV_INSN_FUNCS(fence,	0x7f, 0x0f);
>>  	} while (0)
>>=20=20
>>  __RISCV_INSN_FUNCS(c_j,		0xe003, 0xa001);
>> -__RISCV_INSN_FUNCS(c_jr,	0xf007, 0x8002);
>
> Hmm, I wonder where the mask originally came from!

I think it's just a simple bug -- missing that "rs2" must be zero.

> I had a look at the compressed spec, of which the version google gave to
> me was v1.9 [1], and Table 1.6 in that (Instruction listing for RVC,
> Quadrant 2) seems to list them all together.
> Tedious it may be, but future instruction decoding bits probably need
> more scrutiny as Drew found another clearly wrong bit a few weeks ago
> [2].
>
> Anyways, I checked against the doc and the new versions look good to
> me. How'd you spot this, and did you check the other masks?

I got hit by it when testing the optprobe series (c.mv was rejected as
c.jr).

Skimmed the other masks quickly, but will take another look.

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> [1] -
> https://riscv.org/wp-content/uploads/2015/11/riscv-compressed-spec-v1.9.p=
df

C-ext is part of the unpriv spec:
https://github.com/riscv/riscv-isa-manual/releases

> [2] - https://lore.kernel.org/linux-riscv/20221223221332.4127602-2-heiko@=
sntech.de/
>
>> +__RISCV_INSN_FUNCS(c_jr,	0xf07f, 0x8002);
>>  __RISCV_INSN_FUNCS(c_jal,	0xe003, 0x2001);
>> -__RISCV_INSN_FUNCS(c_jalr,	0xf007, 0x9002);
>> +__RISCV_INSN_FUNCS(c_jalr,	0xf07f, 0x9002);
>>  __RISCV_INSN_FUNCS(c_beqz,	0xe003, 0xc001);
>>  __RISCV_INSN_FUNCS(c_bnez,	0xe003, 0xe001);
>>  __RISCV_INSN_FUNCS(c_ebreak,	0xffff, 0x9002);
>
> Worth noting that this code is gone in riscv/for-next thanks to Heiko's
> de-duplication:
> https://lore.kernel.org/linux-riscv/20221223221332.4127602-7-heiko@sntech=
.de/

Yay!


Bj=C3=B6rn
