Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2B65B627
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjABSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjABSDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:03:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C264BC1F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 378B7B80D0D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C0CC433D2;
        Mon,  2 Jan 2023 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682629;
        bh=BAjOdV6p7CxcpgFIt7D9jGccYF3iPP6U2STbHuh7wzo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P8db7gFYg4eaSIue3F/rJBz+rptHoe69biRi659Yfwa4lmsSxEeRcVmhtoHxxQkJE
         FID1HOsfBVtQxLbYp5b4M+rPSGN/VCEeZvM1BYdv3a0p7T7j4jbUHxBhn7nWJILSMB
         0YqhTDwPtdMX45YvAK6yDTU4owpAdnacD0pOeVY4CBQSvy9BhK530gCBKQTvpNltpv
         29Y88tnwMzICarK6DBLHaKKBZeTioI6x98WWNrf9f32MBl6lbqmq/d0A/HqbjOkEIT
         OinXzbk0vHMA9r1rFR6P8XlJBqjVQn82Mm580WxjJwrRx/UjwSMQlD7w6pl3Cof/Cc
         T2cGgb5cfZgtQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 4/9] riscv/kprobe: Add common RVI and RVC instruction
 decoder code
In-Reply-To: <20221224114315.850130-5-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-5-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:03:46 +0100
Message-ID: <87tu18vmnx.fsf@all.your.base.are.belong.to.us>
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

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaochang1@huawei.com>

> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel=
/probes/simulate-insn.h
> index cb6ff7dccb92..74d8c1ba9064 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.h
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -37,6 +37,40 @@ __RISCV_INSN_FUNCS(c_jalr,	0xf007, 0x9002);
>  __RISCV_INSN_FUNCS(c_beqz,	0xe003, 0xc001);
>  __RISCV_INSN_FUNCS(c_bnez,	0xe003, 0xe001);
>  __RISCV_INSN_FUNCS(c_ebreak,	0xffff, 0x9002);
> +/* RVC(S) instructions contain rs1 and rs2 */
> +__RISCV_INSN_FUNCS(c_sq,	0xe003, 0xa000);
> +__RISCV_INSN_FUNCS(c_sw,	0xe003, 0xc000);
> +__RISCV_INSN_FUNCS(c_sd,	0xe003, 0xe000);
> +/* RVC(A) instructions contain rs1 and rs2 */
> +__RISCV_INSN_FUNCS(c_sub,	0xfc03, 0x8c01);

Incorrect mask.

> +__RISCV_INSN_FUNCS(c_subw,	0xfc43, 0x9c01);
> +/* RVC(L) instructions contain rs1 */
> +__RISCV_INSN_FUNCS(c_lq,	0xe003, 0x2000);
> +__RISCV_INSN_FUNCS(c_lw,	0xe003, 0x4000);
> +__RISCV_INSN_FUNCS(c_ld,	0xe003, 0x6000);
> +/* RVC(I) instructions contain rs1 */
> +__RISCV_INSN_FUNCS(c_addi,	0xe003, 0x0001);
> +__RISCV_INSN_FUNCS(c_addiw,	0xe003, 0x2001);
> +__RISCV_INSN_FUNCS(c_addi16sp,	0xe183, 0x6101);
> +__RISCV_INSN_FUNCS(c_slli,	0xe003, 0x0002);
> +/* RVC(B) instructions contain rs1 */
> +__RISCV_INSN_FUNCS(c_sri,	0xe803, 0x8001);
> +__RISCV_INSN_FUNCS(c_andi,	0xec03, 0x8801);
> +/* RVC(SS) instructions contain rs2 */
> +__RISCV_INSN_FUNCS(c_sqsp,	0xe003, 0xa002);
> +__RISCV_INSN_FUNCS(c_swsp,	0xe003, 0xc002);
> +__RISCV_INSN_FUNCS(c_sdsp,	0xe003, 0xe002);
> +/* RVC(R) instructions contain rs2 and rd */
> +__RISCV_INSN_FUNCS(c_mv,	0xe003, 0x8002);

Shouldn't the mask be 0xf003?


Bj=C3=B6rn
