Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311CE664E77
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjAJWEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAJWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:04:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C34D711
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:04:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D93618F6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF08C433EF;
        Tue, 10 Jan 2023 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673388292;
        bh=sXKQH9MHPwjOGWbA5cDyPTWbK0WzJz55SrsR2+i9tYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7h6E7zc8athO1Q5AWD2+pZqe1vxLYAx7h0qd8ud8mwzfeW3B0vBXGXhFbKO53NjT
         bGTfuw7X+QD64wZtno1TYG/CcWiMKTZqKK4bJxS5ghfMloAA0b/yb+hQMRSepclgYZ
         f1sYdryDdJCwupYZ0g37IluYQ9ubjezKdvU5zHFwuKyshnKCSB9j/IWtK9LPq2/5bG
         F4lpcT6rqnWE2wdjp3Jc+JL1iYp2Hm7Agq9cvIA4FX9PONmBP3LoicLBiQAt/gKIe3
         CHDydOenDqT1Cjx/s2ZT9Oc62BwmH8Rwu/BeUUFGBOXAQoFLVzYm3O64p/jn1LKtBE
         3JX8q7vpqgbBg==
Date:   Tue, 10 Jan 2023 22:04:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
Message-ID: <Y73g/nkDe7Sfp9ps@spud>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XzBgRjeUQy7ALPqW"
Content-Disposition: inline
In-Reply-To: <20230110201841.2069353-1-vineetg@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XzBgRjeUQy7ALPqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Vineet,

While you're at it with Jess' concerns, couple nitpicks for you.
May as well say them now rather than while a v2 comes around.

On Tue, Jan 10, 2023 at 12:18:41PM -0800, Vineet Gupta wrote:

> Reported-by: kernel test robot <lkp@intel.com>  # code under CONFIG_COMPAT

You can drop this, even if it reported against a private branch AFAIU,
just like its complaints about patches. As Greg would say, LKP didn't
report a feature!

> diff --git a/arch/riscv/kernel/elf-attr.c b/arch/riscv/kernel/elf-attr.c
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-24 Rivos Inc.

s/-24//


> +static u64
> +decode_uleb128(unsigned char **dpp)

Surely that fits inside 80?

> +static int rv_parse_elf_attributes(struct file *f, const struct elf_phdr *phdr,
> +				   struct arch_elf_state *state)
> +{
> +	unsigned char buf[RV_ATTR_SEC_SZ];
> +	unsigned char *p;
> +	ssize_t n;
> +	int ret = 0;
> +	loff_t pos;
> +
> +	pr_debug("Section .riscv.attributes found\n");
> +
> +	/* Assume a reasonable size for now */
> +	if (phdr->p_filesz > sizeof(buf))
> +		return -ENOEXEC;
> +
> +	memset(buf, 0, RV_ATTR_SEC_SZ);
> +	pos = phdr->p_offset;
> +	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
> +
> +	if (n < 0)
> +		return -EIO;
> +
> +	p = buf;
> +	p++;				/* format-version (1B) */
> +
> +	while ((p - buf) < n) {
> +

While I'm already passing through, checkpatch isn't the biggest fan of
your whitespace after open braces:

https://gist.github.com/conor-pwbot/a572e395763916c7716cab9c870df4f3

> +		unsigned char *vendor_start;
> +		u32 len;
> +
> +		/*
> +		 * Organized as "vendor" sub-section(s).
> +		 * Current only 1 specified "riscv"

Is it worth having a comment like this that may rapidly go out of date?

Cheers,
Conor.


--XzBgRjeUQy7ALPqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY73g/gAKCRB4tDGHoIJi
0qX7AP9ZTbJkjWiFBAlQ+CxEuOs0Tppz2YmYXfKW9ZHqLM2Z4gEA9K3DUGLckpu9
mZT4QzW5RzFFFFu2FuteHImu27Nw7w4=
=TpDw
-----END PGP SIGNATURE-----

--XzBgRjeUQy7ALPqW--
