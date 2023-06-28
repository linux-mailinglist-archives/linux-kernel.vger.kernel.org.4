Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7DE7410E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjF1M25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjF1M2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:28:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B402102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:28:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso8653085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687955324; x=1690547324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOLEBNQo1Inji0t08F3DZcnSffT102MRoN1JGgPzCcY=;
        b=fLYGP4xQoQLX4keTyqhlrWns1/NqFlBMJnHvTnV9HaARpgysk2tzpoG3Aq23TGicEj
         zRUlliT73BgV0s41P8T67KpTgjjFhlFyQWjhU4x6fCJ17AcHQruKuoSGGvi95pf5gims
         egCfFMZ4ixOLix1Jc23upHmHZPBCP02UaBwuM8Yx9R+x692mmxKw9E3jZ0kiSjA9ycst
         C98eIdKTWIMeBezJDske2doTd5JVpElFuE3End4E0pT17ZKSPnWKzVjhmYO1SM3Ghv5y
         1QiZ0OQgGmfoT0eshxa1+YZT1Jh3+q/YXppICRKnDAZ5GiLkck1B7SxHVbg403Sx8ZGh
         T1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687955324; x=1690547324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOLEBNQo1Inji0t08F3DZcnSffT102MRoN1JGgPzCcY=;
        b=kKJo/iX2nKIPe/ZeOj9O7S7rCTNk3KuT9E/n8fEA6upAeUCVrDm9jQHMity1fUCp9g
         BrcPpaZthC+CxRBvpLL9SuEmOrt8a2ceThxp/hLgVcOD2LXUATwAjBhW7pYCoc+AQyin
         Hd370po3Y/o4yLCTkgfoVH8VDDJ43PpLurX6SOQLASl+LRw+txMkYY/EQKhGIwaqn/oE
         yaAcxB336bZT7Fd5Gs+ljn4TSB/lMlqEIndDzW7v2mBBNvijKTFPCIhNGyb/wkFc3KoH
         ZH0VxBS5X0UeML5+s//tAs6mnGYXu18AakShN2eIyf74ptZX11sryWu4Fr5IMaLN0y+m
         4tvg==
X-Gm-Message-State: AC+VfDy+23VMa/4rZIR93ugRe4KqEewhpOhCCnXid2bH8Fd2a/EkH7eM
        4epzPiCrlkXfXRsSdApq+Ghluw==
X-Google-Smtp-Source: ACHHUZ6HufTDxFwtPEoJbtj1wzivZBgEUqwyJS1z/7pHQ8CiWI6nPMbKHmqH+gNEi7xsQhXhUNNjgQ==
X-Received: by 2002:a05:600c:511e:b0:3fa:91d0:8ddb with SMTP id o30-20020a05600c511e00b003fa91d08ddbmr1458860wms.14.1687955324399;
        Wed, 28 Jun 2023 05:28:44 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0ac600b003f9c0a7c6bcsm13737062wmr.0.2023.06.28.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:28:43 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:28:41 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH 3/3] RISC-V: Implement archrandom when Zkr is available
Message-ID: <ZJwneby7cyBYFRZW@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-4-sameo@rivosinc.com>
 <20230627-grinning-droop-bfbb327f6164@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-grinning-droop-bfbb327f6164@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Jun 27, 2023 at 08:09:08PM +0100, Conor Dooley wrote:
> On Tue, Jun 27, 2023 at 04:37:44PM +0200, Samuel Ortiz wrote:
> > The Zkr extension is ratified and provides 16 bits of entropy seed when
> > reading the SEED CSR.
> > 
> > We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> > that CSR and filling an unsigned long with valid entropy bits.
> > 
> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/archrandom.h | 66 +++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/csr.h        |  9 ++++
> >  2 files changed, 75 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/archrandom.h
> > 
> > diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
> > new file mode 100644
> > index 000000000000..3d01aab2800a
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/archrandom.h
> > @@ -0,0 +1,66 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Kernel interface for the RISCV arch_random_* functions
> > + *
> > + * Copyright (c) 2022 by Rivos Inc.
> > + *
> > + */
> > +
> > +#ifndef ASM_RISCV_ARCHRANDOM_H
> > +#define ASM_RISCV_ARCHRANDOM_H
> > +
> > +#include <asm/csr.h>
> > +
> > +#define PR_PREFIX "Zkr Extension: "
> 
> Does pr_fmt() not work for you?

It would, but since this is a header that e.g. gets included in
random.h, I would have to ifndef it first.
My v2 is less verbose and gets rid of this prefix anyways.

> Also, "Zkr Extension" doesn't really seem super helpful to a punter if
> they saw it in a log. Why not s/Zkr Extension/archrandom/, or similar?
> 
> > +#define SEED_RETRY_LOOPS 10
> > +
> > +static inline bool __must_check csr_seed_long(unsigned long *v)
> > +{
> > +	unsigned int retry = SEED_RETRY_LOOPS;
> > +	unsigned int needed_seeds = sizeof(unsigned long) / 2, valid_seeds = 0;
> > +	u16 *entropy = (u16 *)v;
> > +
> > +	do {
> > +		/*
> > +		 * The SEED CSR (0x015) must be accessed with a read-write
> > +		 * instruction. Moreover, implementations must ignore the write
> > +		 * value, its purpose is to signal polling for new seed.
> > +		 */
> 
> What relevance does the second half of this comment have to the kernel?

Not much, I will remove it with v2.

> > +		unsigned long csr_seed = csr_swap(CSR_SEED, 0);
> > +
> > +		switch (csr_seed & SEED_OPST_MASK) {
> > +		case SEED_OPST_ES16:
> > +			entropy[valid_seeds++] = csr_seed & SEED_ENTROPY_MASK;
> > +			if (valid_seeds == needed_seeds)
> > +				return true;
> > +			break;
> > +
> > +		case SEED_OPST_DEAD:
> > +			pr_err_once(PR_PREFIX "Unrecoverable error\n");
> > +			return false;
> > +
> > +		case SEED_OPST_BIST:
> > +			pr_info(PR_PREFIX "On going Built-in Self Test\n");
> 
> tiny nit, "On-going"? My OCD is bother by the capitalisation otherwise.

I removed that one with v2, as it may be a little too chatty.

> > +			fallthrough;
> > +
> > +		case SEED_OPST_WAIT:
> > +		default:
> > +			continue;
> > +		}
> > +
> > +	} while (--retry);
> > +
> > +	return false;
> > +}
> > +
> > +static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
> > +{
> > +	return max_longs && riscv_isa_extension_available(NULL, ZKR) && csr_seed_long(v) ? 1 : 0;
> 
> Could you please write this in a more readable way, even if that is
> going to be a lot more verbose? I know you copied it from x86, but
> that's not really an excuse ;)

Agreed :)
Fixed as well with v2.

> Also, is there a reason that you opted not to use the alternative-backed
> riscv_has_extension_[un]likely() here?

I did not know about them, I switched to it with v2 (Made it a likely
case).

Cheers,
Samuel.

