Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0839665B628
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjABSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjABSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:04:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F12BF6D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13F47B80D0B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7792BC433EF;
        Mon,  2 Jan 2023 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682642;
        bh=ifUmvfCBh29zQ+7sIS0FtN5zIwsm2GSxNWtY9yy8c4o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CWlZVqjHHqwr8igQKlHq+PKv2KHgcqIsxp0z/xZHqVoCFIOsyD9SMDKk8ri94/+4E
         DeX13VcOX6va985fIXJ90DjcQM0/aTDjt9Aof6+DlL327kNH9LJPPFWudEA1IK0BhS
         lUg/mr31F/mkalwM4E6kUeOr1t9ZlokDe+96ZSIa70sQf8AEPVtXRWMyGKv9LqwKrI
         3NK7H4yDG8OdWf25FNF5ZkawSGsl4jCslz+jib4oPDyRhWVNamV9AxWXxOpjvoQ+JY
         R6QhIsLAxrPKUQRW+06UNZ3i9DpK3Ivsivk3YaZnxe8D7pjZTdZGgxYddhzEC0XXYL
         8kvNfsTwkNOdQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 6/9] riscv/kprobe: Add code to check if kprobe can be
 optimized
In-Reply-To: <20221224114315.850130-7-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-7-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:04:00 +0100
Message-ID: <87sfgsvmnj.fsf@all.your.base.are.belong.to.us>
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

> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index a0d2ab39e3fa..258a283c906d 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c
> @@ -271,15 +271,103 @@ static void find_free_registers(struct kprobe *kp,=
 struct optimized_kprobe *op,
>  	*ra =3D (kw =3D=3D 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
>  }
>=20=20
> +static bool insn_jump_into_range(unsigned long addr, unsigned long start,
> +				 unsigned long end)
> +{
> +	kprobe_opcode_t insn =3D *(kprobe_opcode_t *)addr;
> +	unsigned long target, offset =3D GET_INSN_LENGTH(insn);
> +
> +#ifdef CONFIG_RISCV_ISA_C
> +	if (offset =3D=3D RVC_INSN_LEN) {
> +		if (riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn))
> +			target =3D addr + rvc_branch_imme(insn);
> +		else if (riscv_insn_is_c_jal(insn) || riscv_insn_is_c_j(insn))
> +			target =3D addr + rvc_jal_imme(insn);
> +		else
> +			target =3D 0;
> +		return (target >=3D start) && (target < end);
> +	}
> +#endif
> +
> +	if (riscv_insn_is_branch(insn))
> +		target =3D addr + rvi_branch_imme(insn);
> +	else if (riscv_insn_is_jal(insn))
> +		target =3D addr + rvi_jal_imme(insn);
> +	else
> +		target =3D 0;
> +	return (target >=3D start) && (target < end);
> +}
> +
> +static int search_copied_insn(unsigned long paddr, struct optimized_kpro=
be *op)
> +{
> +	int i =3D  1;
> +	unsigned long offset =3D GET_INSN_LENGTH(*(kprobe_opcode_t *)paddr);
> +
> +	while ((i++ < MAX_COPIED_INSN) && (offset < 2 * RVI_INSN_LEN)) {
> +		if (riscv_probe_decode_insn((probe_opcode_t *)paddr + offset,
> +					    NULL) !=3D INSN_GOOD)

If the second argument is NULL, and the insn is auipc, we'll splat with
NULL-ptr exception.

Hmm, probe_opcode_t is u32, right? And GET_INSN_LENGTH() returns 4 or 2
...then the pointer arithmetic will be a mess?


Bj=C3=B6rn
