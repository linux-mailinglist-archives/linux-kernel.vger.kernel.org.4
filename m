Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418061FAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiKGQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiKGQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:56:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6798220C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16594CE1718
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25903C433D6;
        Mon,  7 Nov 2022 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667840167;
        bh=pnyl9ZpInkkIrifXkuZxEpTl9OIUwhuPakxK4echwoU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=uDayzqo4JFxbQbxSN4/X/creKMzVS+AWMg/Jj9ta5qzISdtF8uG4v1Ms+sAi9C3fG
         5DwENLzEQyD9aAnjkbcxwJfWuhtp8RICFHy/jCO76xPu3HAPx2cvGV589EQ8A7Ikdc
         1MffGd/cMLS1G5a+nZ0OR264xr+S3K5QCQnJxV97wGtSoSMJZpD6SYbYl5ldby2T0e
         zxENeHrkrnLtMDghJ2HDMkT2fpG2UW6YtA7rzTh9WNGarnWr7bpZuwNRR3o2rAS4R1
         gJ5JrwIFy6IMbFGZTR744jEBmwmSeqomCbYqop5EOS4BKXIKavFgR1w5doHSCCibsX
         0+KTS5QZuVZMQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v4 6/8] riscv/kprobe: Add code to check if kprobe can be
 optimized
In-Reply-To: <20221106100316.2803176-7-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
 <20221106100316.2803176-7-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 07 Nov 2022 17:56:04 +0100
Message-ID: <87v8nq1z6j.fsf@all.your.base.are.belong.to.us>
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

[...]

> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index 6d23c843832e..876bec539554 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c

[...]

>  /*
> - * If two free registers can be found at the beginning of both
> - * the start and the end of replaced code, it can be optimized
> - * Also, in-function jumps need to be checked to make sure that
> - * there is no jump to the second instruction to be replaced
> + * The kprobe can be optimized when no in-function jump reaches to the
> + * instructions replaced by optimized jump instructions(AUIPC/JALR).
>   */
>  static bool can_optimize(unsigned long paddr, struct optimized_kprobe *o=
p)
>  {
> -	return false;
> +	int ret;
> +	unsigned long addr, size =3D 0, offset =3D 0;
> +	struct kprobe *kp =3D get_kprobe((kprobe_opcode_t *)paddr);
> +
> +	/*
> +	 * Skip optimization if kprobe has been disarmed or instrumented
> +	 * instruction support XOI.
> +	 */
> +	if (!kp || (riscv_probe_decode_insn(&kp->opcode, NULL) !=3D INSN_GOOD))
> +		return false;
> +
> +	/*
> +	 * Find a instruction window large enough to contain a pair
> +	 * of AUIPC/JALR, and ensure each instruction in this window
> +	 * supports XOI.
> +	 */
> +	ret =3D search_copied_insn(paddr, op);
> +	if (ret)
> +		return false;
> +
> +	if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
> +		return false;
> +
> +	/* Check there is enough space for relative jump(AUIPC/JALR) */
> +	if (size - offset <=3D op->optinsn.length)
> +		return false;
> +
> +	/*
> +	 * Decode instructions until function end, check any instruction
> +	 * don't jump into the window used to emit optprobe(AUIPC/JALR).
> +	 */

Don't the fixup tables need to be checked, similar to the x86 code?


Bj=C3=B6rn
