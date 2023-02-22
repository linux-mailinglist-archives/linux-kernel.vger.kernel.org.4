Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBECD69F259
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjBVJ6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Feb 2023 04:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjBVJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:58:45 -0500
X-Greylist: delayed 1034 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 01:58:18 PST
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9910E9;
        Wed, 22 Feb 2023 01:58:18 -0800 (PST)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id D58E5140ABD;
        Wed, 22 Feb 2023 09:40:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 320E134;
        Wed, 22 Feb 2023 09:39:57 +0000 (UTC)
Message-ID: <2cf5852092ac5940b8bc6664f54bd6066fe03be2.camel@perches.com>
Subject: Re: [PATCH v3 5/7] RISC-V: hwprobe: Support probing of misaligned
 access performance
From:   Joe Perches <joe@perches.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Wed, 22 Feb 2023 01:39:55 -0800
In-Reply-To: <20230221190858.3159617-6-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
         <20230221190858.3159617-6-evan@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 320E134
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: ybbcoyf11h49p9quu88t1dg4kuty1m1n
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+8kobCdGdcWhmHWOr9mPUUF3sOhp8Kwis=
X-HE-Tag: 1677058797-751421
X-HE-Meta: U2FsdGVkX1+UdPFDfaN1hY5zcxQ+HQPvxVKNWYfjZMmIKNJ658qKEWuywkzdpnpyRHDVQTb4ua/dzl8jHTTtRA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-21 at 11:08 -0800, Evan Green wrote:
> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.
[]
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
[]
> @@ -89,11 +94,11 @@ static bool riscv_isa_extension_check(int id)
>  void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
> -	const char *isa;
> +	const char *isa, *misaligned;
>  	char print_str[NUM_ALPHA_EXTS + 1];
>  	int i, j, rc;
>  	unsigned long isa2hwcap[26] = {0};
> -	unsigned long hartid;
> +	unsigned long hartid, cpu;
>  
>  	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
> @@ -246,6 +251,28 @@ void __init riscv_fill_hwcap(void)
>  			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>  		else
>  			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +
> +		/*
> +		 * Check for the performance of misaligned accesses.
> +		 */
> +		cpu = hartid_to_cpuid_map(hartid);
> +		if (cpu < 0)
> +			continue;

unsigned long can't be less than 0
Likely cpu should be long not unsigned long
It seems cpu is rather randomly either int or long.
Perhaps standardizing on int would be better.

