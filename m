Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C065BD89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjACJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjACJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:59:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5923E0D9;
        Tue,  3 Jan 2023 01:59:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A4CDB80E80;
        Tue,  3 Jan 2023 09:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFDCC43392;
        Tue,  3 Jan 2023 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672739987;
        bh=K3GNdh0iSKVs4cxHbbMFC6QCnRMk4vyTA2omm3ALejE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s1knHPqbkH7hlnM/m2D9Hj1wBaYLROgZ0vWB17OegTZcHFUhfFTMGjijqVogryHkf
         PwIYftn7jclRTnQmNvitI578qvf3d8l2U1GW9YCcQ1g0cc1ZxzpIi4uormiWctxVd8
         4ijcD1hwqub9bvsMEiA65wZb9ZFrV/xupotZCIIzelvY5/dreDDYVrB3jMHTS1fBjP
         QZo7YCgdHhEly2Qov/UlMKbuL/glPxUYdFUvgclP1agwJDf/3/yQhreMoigbXgkQTN
         723b29wsh137zszJDNpjRK9aCUcVBx8ErN13PHlVkUx864RMcN5k88znh2jHNTQW7N
         xCGR9zDycUJLA==
Received: by mail-ej1-f44.google.com with SMTP id gh17so72429258ejb.6;
        Tue, 03 Jan 2023 01:59:47 -0800 (PST)
X-Gm-Message-State: AFqh2ko3Jam+ddPzpfMqz7PX984POdy57AljLDuddsNLOGlE4BE/ak/E
        U91jRBS0UL2U18UCRsXfaNbtwcZn+QYSKmLzqLM=
X-Google-Smtp-Source: AMrXdXs6X1KS2ScftLdukmy7fbm+oYnh2kNUOaxOawhAHpBi8S0P7w9c/T56eT42XKAb8tDbpox74vUvReqk46aTokU=
X-Received: by 2002:a17:906:33d4:b0:7c0:f7af:7c5e with SMTP id
 w20-20020a17090633d400b007c0f7af7c5emr2862143eja.406.1672739985408; Tue, 03
 Jan 2023 01:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20230102160748.1307289-1-bjorn@kernel.org>
In-Reply-To: <20230102160748.1307289-1-bjorn@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 3 Jan 2023 17:59:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTF9_J__Qk+ppg5c1V+1PeFbZ-xf7DEbo=DXBRpQu1L=A@mail.gmail.com>
Message-ID: <CAJF2gTTF9_J__Qk+ppg5c1V+1PeFbZ-xf7DEbo=DXBRpQu1L=A@mail.gmail.com>
Subject: Re: [PATCH] riscv, kprobes: Stricter c.jr/c.jalr decoding
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for catching it.

On Tue, Jan 3, 2023 at 12:07 AM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> In the compressed instruction extension, c.jr, c.jalr, c.mv, and c.add
> is encoded the following way (each instruction is 16b):
>
> ---+-+-----------+-----------+--
> 100 0 rs1[4:0]!=3D0       00000 10 : c.jr
> 100 1 rs1[4:0]!=3D0       00000 10 : c.jalr
> 100 0  rd[4:0]!=3D0 rs2[4:0]!=3D0 10 : c.mv
> 100 1  rd[4:0]!=3D0 rs2[4:0]!=3D0 10 : c.add
Yes, I forgot the c.mv & c.add effect.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> The following logic is used to decode c.jr and c.jalr:
>
>   insn & 0xf007 =3D=3D 0x8002 =3D> instruction is an c.jr
>   insn & 0xf007 =3D=3D 0x9002 =3D> instruction is an c.jalr
>
> When 0xf007 is used to mask the instruction, c.mv can be incorrectly
> decoded as c.jr, and c.add as c.jalr.
>
> Correct the decoding by changing the mask from 0xf007 to 0xf07f.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/kernel/probes/simulate-insn.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel=
/probes/simulate-insn.h
> index cb6ff7dccb92..de8474146a9b 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.h
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -31,9 +31,9 @@ __RISCV_INSN_FUNCS(fence,     0x7f, 0x0f);
>         } while (0)
>
>  __RISCV_INSN_FUNCS(c_j,                0xe003, 0xa001);
> -__RISCV_INSN_FUNCS(c_jr,       0xf007, 0x8002);
> +__RISCV_INSN_FUNCS(c_jr,       0xf07f, 0x8002);
>  __RISCV_INSN_FUNCS(c_jal,      0xe003, 0x2001);
> -__RISCV_INSN_FUNCS(c_jalr,     0xf007, 0x9002);
> +__RISCV_INSN_FUNCS(c_jalr,     0xf07f, 0x9002);
>  __RISCV_INSN_FUNCS(c_beqz,     0xe003, 0xc001);
>  __RISCV_INSN_FUNCS(c_bnez,     0xe003, 0xe001);
>  __RISCV_INSN_FUNCS(c_ebreak,   0xffff, 0x9002);
>
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> --
> 2.37.2
>


--=20
Best Regards
 Guo Ren
