Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC06866FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjBANcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjBANbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:31:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077A65ECD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CCF9B82189
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB7C433D2;
        Wed,  1 Feb 2023 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258269;
        bh=8bjsnU5IlOTWIjS9SQViAvA7jUyJimrEv1hWYuyau9I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GgkC5+y89K/szZ9HjHct6jIhvWpGSGldZ7wyVtoQNWLlqP4l9KPG2XcswL0hFYefj
         r/rAluaKqEO+YilJVawS3TH2O8h3hhopcA1i6o+x6KYR7pMeyZ1yMsli4tzs5E7dJK
         zk1wYcaUxI2ZjDJvA4OrdPKMdIlkuw98anc110miqfjLqK5YJUDzKv94iNAaCxPwH+
         cOSChBsyPaW3rOpNR1gySc9fRLbEYniH0DR7p0aAqNamAOThGMHYdXBdnTP2m6X59f
         SoBBYwIc4tQFXngCzzAkWE4mld4tZm3YmLbb4ubRT/ZS4RfJ0otnmZdNvuTrNfW4sk
         o+R4Xx1N7agMg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v6 08/13] riscv/kprobe: Patch AUIPC/JALR pair to
 optimize kprobe
In-Reply-To: <20230127130541.1250865-9-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-9-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:31:07 +0100
Message-ID: <87r0v9tsv8.fsf@all.your.base.are.belong.to.us>
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

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patc=
h.h
> index 9a7d7346001e..ee31539de65f 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -8,5 +8,6 @@
>=20=20
>  int patch_text_nosync(void *addr, const void *insns, size_t len);
>  int patch_text(void *addr, u32 insn);
> +int patch_text_batch(void *addr, const void *insn, size_t size);
>=20=20
>  #endif /* _ASM_RISCV_PATCH_H */
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 765004b60513..ce324b6a6998 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -15,7 +15,8 @@
>=20=20
>  struct patch_insn {
>  	void *addr;
> -	u32 insn;
> +	const void *insn;
> +	size_t size;
>  	atomic_t cpu_count;
>  };
>=20=20
> @@ -106,8 +107,7 @@ static int patch_text_cb(void *data)
>=20=20
>  	if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus()) {
>  		ret =3D

Nit: Please use the full width. No need for a NL here.

> -		    patch_text_nosync(patch->addr, &patch->insn,
> -					    GET_INSN_LENGTH(patch->insn));
> +		    patch_text_nosync(patch->addr, patch->insn, patch->size);
>  		atomic_inc(&patch->cpu_count);
>  	} else {
>  		while (atomic_read(&patch->cpu_count) <=3D num_online_cpus())
> @@ -123,7 +123,8 @@ int patch_text(void *addr, u32 insn)
>  {
>  	struct patch_insn patch =3D {
>  		.addr =3D addr,
> -		.insn =3D insn,
> +		.insn =3D &insn,
> +		.size =3D GET_INSN_LENGTH(insn),
>  		.cpu_count =3D ATOMIC_INIT(0),
>  	};
>=20=20
> @@ -131,3 +132,17 @@ int patch_text(void *addr, u32 insn)
>  				       &patch, cpu_online_mask);
>  }
>  NOKPROBE_SYMBOL(patch_text);
> +
> +int patch_text_batch(void *addr, const void *insn, size_t size)
> +{
> +	struct patch_insn patch =3D {
> +		.addr =3D addr,
> +		.insn =3D insn,
> +		.size =3D size,
> +		.cpu_count =3D ATOMIC_INIT(0),
> +	};
> +
> +	return stop_machine_cpuslocked(patch_text_cb, &patch, cpu_online_mask);
> +}
> +
> +NOKPROBE_SYMBOL(patch_text_batch);
> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index a47f7d2bf3a6..c52d5bdc748c 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c
> @@ -8,6 +8,7 @@
>=20=20
>  #define pr_fmt(fmt)	"optprobe: " fmt
>=20=20
> +#include <linux/types.h>
>  #include <linux/kprobes.h>
>  #include <asm/kprobes.h>
>  #include <asm/patch.h>
> @@ -444,11 +445,19 @@ static bool can_optimize(unsigned long paddr, struc=
t optimized_kprobe *op)
>=20=20
>  int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>  {
> -	return 0;
> +	return optinsn->length;
>  }
>=20=20
>  int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>  {
> +	unsigned long i;
> +	struct kprobe *p;
> +
> +	for (i =3D RVC_INSN_LEN; i < op->optinsn.length; i +=3D RVC_INSN_LEN) {
> +		p =3D get_kprobe(op->kp.addr + i);
> +		if (p && !kprobe_disabled(p))
> +			return -EEXIST;
> +	}
>  	return 0;
>  }
>=20=20
> @@ -509,23 +518,75 @@ int arch_prepare_optimized_kprobe(struct optimized_=
kprobe *op,
>=20=20
>  void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>  {
> +	if (op->optinsn.insn) {
> +		free_optinsn_slot(op->optinsn.insn, 1);
> +		op->optinsn.insn =3D NULL;
> +		op->optinsn.length =3D 0;
> +	}
>  }
>=20=20
>  void arch_optimize_kprobes(struct list_head *oplist)
>  {
> +	long offs;
> +	kprobe_opcode_t insn[3];
> +	struct optimized_kprobe *op, *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		WARN_ON(kprobe_disabled(&op->kp));
> +
> +		/* Backup instructions which will be replaced by jump address */
> +		memcpy(op->optinsn.copied_insn,
> +		       DETOUR_ADDR(op->optinsn.insn, DETOUR_INSN_OFFSET),
> +		       op->optinsn.length);
> +
> +		/*
> +		 * After patching, it should be:
> +		 * auipc free_register, %hi(detour_buffer)
> +		 * jalr free_register, free_register, %lo(detour_buffer)
> +		 * where free_register will eventually save the return address
> +		 */
> +		offs =3D (unsigned long)op->optinsn.insn -
> +		       (unsigned long)op->kp.addr;
> +		insn[0] =3D rv_auipc(op->optinsn.rd, (offs + (1 << 11)) >> 12);
> +		insn[1] =3D rv_jalr(op->optinsn.rd, op->optinsn.rd, offs & 0xFFF);
> +		/* For 3 RVC + 1 RVI scenario, fill C.NOP for padding */
> +		if (op->optinsn.length > 2 * RVI_INSN_LEN)
> +			insn[2] =3D rvc_addi(0, 0);
> +
> +		patch_text_batch(op->kp.addr, insn, op->optinsn.length);
> +		if (memcmp(op->kp.addr, insn, op->optinsn.length))
> +			continue;
> +
> +		list_del_init(&op->list);
> +	}
>  }
>=20=20
>  void arch_unoptimize_kprobes(struct list_head *oplist,
>  			     struct list_head *done_list)
>  {
> +	struct optimized_kprobe *op, *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		arch_unoptimize_kprobe(op);
> +		list_move(&op->list, done_list);
> +	}
>  }
>=20=20
>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>  {
> +	kprobe_opcode_t buf[MAX_COPIED_INSN];
> +
> +	memcpy(buf, op->optinsn.copied_insn, op->optinsn.length);
> +	if (GET_INSN_LENGTH(op->kp.opcode) =3D=3D RVI_INSN_LEN)
> +		*(u32 *)buf =3D __BUG_INSN_32;
> +	else
> +		*(u16 *)buf =3D __BUG_INSN_16;
> +	patch_text_batch(op->kp.addr, buf, op->optinsn.length);
>  }
>=20=20
>  int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>  				 kprobe_opcode_t *addr)
>  {
> -	return 0;
> +	return (op->kp.addr <=3D addr &&
> +		op->kp.addr + op->optinsn.length > addr);

Nit: Use the whole 100 char line width, please.

With or w/o the nits fixed:

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


Bj=C3=B6rn
