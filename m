Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29E675CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjATSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjATSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:34:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C163A25BE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:34:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u19so16118780ejm.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RljWWlDfABhrEExkV/60EmyExt7xXza/TGukw4p5JZs=;
        b=FTHGSi1WvFMy1rA6AZ8wEFQrDoZre6RooIXOKzedbSVgy7mxXhq+uA/bV9oFmacU0j
         Np13RlyiBDiPdmfU5jyKRQJg/1vQGRw7Abq72wiO7U9eJKoj8VZ0C0mIa61TCIOpff2R
         X9Oua8PgZON+e+uC0iV+tBNWP7+zNUQpfkJz2rH99bczimIK1C6Ep7NoDSRYAmcm2Boq
         JHFGV3HmOHsXTFmYA0op6nNkrJxXzabNg7gTW8dKFNewyaqIAM5sIzHSOeVEcYWoBWoY
         1O2apAqD1hKIbqw1MagBd/WQnhGsbqANBrQVx48R9XU/8PNo3XnL6gosiA3oB9cB2SjI
         ejSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RljWWlDfABhrEExkV/60EmyExt7xXza/TGukw4p5JZs=;
        b=YJHjXTV8zgjcZG5+0nECx584bwXPkR2paoqn3AR7Fyxe8t8387VQm34UbQ8NcjdgQo
         RA41c7E3tjt8U+OersZZhaYJU9x2ErCQRmFN5rZMQmPHUZPlL1x+e2WSi7Zwb+Y4GbEt
         uYZOpX0T0QWQmcYziKNQcHa6rK+jOX6spk3rwde2N1Pih1JWkqvFc4JSo+6lQXG7lFPB
         LwMdtiWTTdQwCVTso5Kl53LkkVepodLgHKwSz8rjhpqH3+sr8LyjcG1EdH87VNpbUTJj
         uWC1lmH5uagAPn2kZ9Wkywil4DkR4uMPt6xrd3ORAbHOHfA2mraJtyI1UoaMMfHvd0Lr
         ivew==
X-Gm-Message-State: AFqh2kr2Ab7ZgPISUhh+nisFk/qy4BWXcGo5LCC++0AWhcegiaPDH5cT
        PW39gqfWgBh9LVjmf8MZeMetOA==
X-Google-Smtp-Source: AMrXdXvwslxY4uvoA0qUluckvcPb+qhCLBxDiD/c1tTFYRRK1l+x1UltVxzbQDCuwWYlcliIL0Iasg==
X-Received: by 2002:a17:906:b317:b0:86e:5124:20b0 with SMTP id n23-20020a170906b31700b0086e512420b0mr17833931ejz.64.1674239659723;
        Fri, 20 Jan 2023 10:34:19 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0082535e2da13sm18256917ejx.6.2023.01.20.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:34:19 -0800 (PST)
Date:   Fri, 20 Jan 2023 19:34:18 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 09/13] riscv: switch to relative alternative entries
Message-ID: <20230120183418.ngdppppvwzysqtcr@orel>
References: <20230115154953.831-1-jszhang@kernel.org>
 <20230115154953.831-10-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115154953.831-10-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 11:49:49PM +0800, Jisheng Zhang wrote:
...
>  #define ALT_ENTRY(oldptr, newptr, vendor_id, errata_id, newlen)		\
> -	RISCV_PTR " " oldptr "\n"					\
> -	RISCV_PTR " " newptr "\n"					\
> -	REG_ASM " " vendor_id "\n"					\
> -	REG_ASM " " newlen "\n"						\
> -	".word " errata_id "\n"
> +	".4byte	((" oldptr ") - .) \n"					\
> +	".4byte	((" newptr ") - .) \n"					\
> +	".2byte	" vendor_id "\n"					\
> +	".2byte " newlen "\n"						\
> +	".4byte	" errata_id "\n"
>

Hi Jisheng,

This patch breaks loading the KVM module for me. I got "kvm: Unknown
relocation type 34". My guess is that these 2 byte fields are inspiring
the compiler to emit 16-bit relocation types. The patch below fixes
things for me. If you agree with fixing it this way, rather than
changing something in alternatives, like not using 2 byte fields,
then please pick the below patch up in your series.

Thanks,
drew

From 4d203697aa745a0cd3a9217d547a9fb7fa2a87c7 Mon Sep 17 00:00:00 2001
From: Andrew Jones <ajones@ventanamicro.com>
Date: Fri, 20 Jan 2023 19:05:44 +0100
Subject: [PATCH] riscv: module: Add ADD16 and SUB16 rela types
Content-type: text/plain

To prepare for 16-bit relocation types to be emitted in alternatives
add support for ADD16 and SUB16.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/module.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 76f4b9c2ec5b..7c651d55fcbd 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -268,6 +268,13 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
 	return -EINVAL;
 }
 
+static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u16 *)location += (u16)v;
+	return 0;
+}
+
 static int apply_r_riscv_add32_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -282,6 +289,13 @@ static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u16 *)location -= (u16)v;
+	return 0;
+}
+
 static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -315,8 +329,10 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
 	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
 	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
+	[R_RISCV_ADD16]			= apply_r_riscv_add16_rela,
 	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
 	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
+	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
 	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
 	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
 };
-- 
2.39.0

