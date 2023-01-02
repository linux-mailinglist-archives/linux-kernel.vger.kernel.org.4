Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57D265B626
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjABSDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjABSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:03:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56C6274
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:03:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A68DDB80DD4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BBEC433D2;
        Mon,  2 Jan 2023 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682616;
        bh=eiL9ov92ii0rNfUZ7WxyqD7kXKuY844nLoQQukaQwBg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cJIzhIrYoeZceLj1oFq0IBdCXGVFGwdlyxWjWtC7PW1im40Ah2MK80CAKQDWdvne7
         DLZB0rMIhbCbYpckJj7ziXzs4fatXTrvnz6lIU3Dz7pYxWzwbRVfVNWiY2oP8RDEWj
         vqeUygwfAKV+yETWlgxgkC6Y+ZFgu0gMuZokegOlDY9Sdtd5lIY0D0lKWNJbROC09Z
         5AiHEBOuo/+5BafbU8o94y0bcGGDgEIvtpqo6YFb6rOTTm5x6W8K+fL2dDkp7pnzp0
         eNx7ERADrC0ClivHV0UY654QqhLae6i8B1KS9+KXys+kmaMXR3A1S+A+f62sP7htbQ
         TdveTeTVWR+1Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 3/9] riscv/kprobe: Prepare the skeleton to prepare
 optimized kprobe
In-Reply-To: <20221224114315.850130-4-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-4-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:03:33 +0100
Message-ID: <87v8lovmoa.fsf@all.your.base.are.belong.to.us>
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

>  arch/riscv/kernel/probes/opt.c | 107 ++++++++++++++++++++++++++++++++-
>
> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index 56c8a227c857..a4271e6033ba 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c

> @@ -24,7 +72,64 @@ int arch_check_optimized_kprobe(struct optimized_kprob=
e *op)
>  int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
>  				  struct kprobe *orig)
>  {
> -	return 0;
> +	long rel;
> +	int rd, ra, ret;
> +	kprobe_opcode_t *code =3D NULL, *slot =3D NULL;
> +
> +	if (!can_optimize((unsigned long)orig->addr, op))
> +		return -EILSEQ;
> +
> +	code =3D kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
> +	slot =3D get_optinsn_slot();
> +	if (!code || !slot) {
> +		ret =3D -ENOMEM;
> +		goto on_error;
> +	}
> +
> +	/*
> +	 * Verify if the address gap is within 4GB range, because this uses
> +	 * a auipc+jalr pair.

Try to be consistent. You're mixing "AUIPC/JALR" with "auipc+jalr".

> +	 */
> +	rel =3D (unsigned long)slot - (unsigned long)orig->addr;
> +	if (!in_auipc_jalr_range(rel)) {
> +		/*
> +		 * Different from x86, we free code buf directly instead
> of

Reword for readers that are not familiar with x86.


Bj=C3=B6rn
