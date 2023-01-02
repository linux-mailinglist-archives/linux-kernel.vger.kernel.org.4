Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BA65B62E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjABSFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjABSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:04:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFCBF47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35F16108F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD2C433D2;
        Mon,  2 Jan 2023 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682670;
        bh=4eYs7pQIcAtCjsCXv0XY68Jnt7bhsT57ASNk+HbciSo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WYqp8Bl67P24FgUZakX+lC8wlpPHHT4udHxXh9Tv1xIqBr+BU7T2jCIwUKYl+R3Bb
         Q9CKr4VfSMsO2rdZjJtjyBJM/ZxpeEXsqD50RNOGc/Y5G7kEtWBlFFtdYgU4Y0Kxqj
         yH7D35TKKpdUDnkKnteNQxy68RhmEaXILW0cdnWVnoURaIDCUH3eyidkh7d2CynOi+
         a4aEqXBqwcyJdA/EP2lMY9Bdwo8lNVLfbXo0k3dKMwkLNhYlhMjiVYhI0fCCcUFJ7q
         RGvsqC4WwI/hVcy5NXIzPE3DmkquimZxCRNXAxgXN51FOPXOFCzZPe/bUBGjqfJfNL
         /rMmZxiWBGQCw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 9/9] riscv/kprobe: Search free registers from unused
 caller-saved ones
In-Reply-To: <20221224114315.850130-10-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-10-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:04:28 +0100
Message-ID: <87pmbwvmmr.fsf@all.your.base.are.belong.to.us>
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

> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index 1c0e9d218f6f..884e77d2df4c 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c
> @@ -12,6 +12,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/patch.h>
>  #include <asm/asm-offsets.h>
> +#include <linux/extable.h>
>=20=20
>  #include "simulate-insn.h"
>  #include "decode-insn.h"
> @@ -130,7 +131,7 @@ static void prepare_detour_buffer(kprobe_opcode_t *co=
de, kprobe_opcode_t *slot,
>   * as a destination register before any branch or jump instruction.
>   */
>  static void find_register(unsigned long start, unsigned long end,
> -			       unsigned long *write, unsigned long *read)
> +			  unsigned long *write, unsigned long *read)

Probably a patch messup; This makes the series no apply fully.


Bj=C3=B6rn
