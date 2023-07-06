Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046B7496F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjGFIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGFIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:01:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1F121
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:01:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso5276731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688630493; x=1691222493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaFjBU+FK87dE3Nkl8hJelSCzFk/bwmTuo6H5JxWaSw=;
        b=XJIS+J//13JWpWX5+okHKNkckCGJs65XoE/HohINr8Z/M7othnH7UMhoj/P/h4gtgS
         IDSH47zYoqsddwdX3OtFzYi6Bg/RbkPwZZECsRJHbGoKTVUaH0X8Q/98rOe8soZtKF0j
         jydNo+NlludS7VgHgLvPdNK3mU5LCGuur804EEMJQlXmPvSbx7KSm4uIB8UX6b/BtoPS
         myzo5jmaXeMwxsrP0u/pnwIWflY/Q4h7dnU09tHv14TfwHJFUPW0tfEu4BG98SMEYD30
         BQNce2rbn/RLIjLO896U2EKHKVVspnv4Sd3I7sDM/E78BGAvngP50Wzs0nneQm1RQyo4
         WBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630493; x=1691222493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaFjBU+FK87dE3Nkl8hJelSCzFk/bwmTuo6H5JxWaSw=;
        b=Rzzy+tfJLFY7++1x30Q6BVKpKcItE3ka7ZJHvUg4+y/W7UEr7/RZeXMulXxAkh6Z65
         eBgXlO1GcVCJ2uwLix4Wia9NjTphVm9lcU+fQCcdmhTFnYT43pd0QXq88iNRSIL4VR9y
         HJ55OYRyXLpBB2rl/BS+szc1+mbZM/Gr1OTvrcLDdEWVKQW19RTdx0cKuD2NEBZLr/sk
         9F8kL3ay12OY0VXeCP3FPNLX+rDs1lRa/VMAvJDR0vqY+YvEK91hg0ZTREKxA4BPNJ/5
         vV49e39UlEyhVqLxmqdx/Cfh7xD7M5zGPhgJOZTO+q0V78qlOIcBnpop/v2VABvKkc5H
         nnFg==
X-Gm-Message-State: ABy/qLbzoYZFAPkSmJ9maQ0PaY3d1PzCuPUmq5fmYSIP736etKGQWNtS
        NaGCVbO0f3BMrb3HnAUL/EVnYQ==
X-Google-Smtp-Source: APBJJlG6l78SQJr2Fxy7TUN+dHYhJNbqZlVWp8lu+cbnc+Q52JCX3+YMXSDU9PCc1X7fmBGE7ARfUQ==
X-Received: by 2002:a2e:a309:0:b0:2b6:bf9c:d025 with SMTP id l9-20020a2ea309000000b002b6bf9cd025mr747386lje.8.1688630493148;
        Thu, 06 Jul 2023 01:01:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b009737b8d47b6sm462856ejb.203.2023.07.06.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:01:32 -0700 (PDT)
Date:   Thu, 6 Jul 2023 10:01:31 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230706-dbdee6eba0c4a16084587b10@orel>
References: <20230705172931.1099183-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705172931.1099183-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:29:31AM -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
> 
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo. We cannot change
> the "isa:" line, as usermode may be relying on that line to show only
> the common set of extensions supported across all harts. Add a new "hart
> isa" line instead, which reports the true set of extensions for that
> hart. This matches what is returned in riscv_hwprobe() when querying a
> given hart.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> 
> ---
> 
> Changes in v2:
>  - Added new "hart isa" line rather than altering behavior of existing
>    "isa" line (Conor, Palmer)
> 
> 
> I based this series on top of Conor's riscv-extensions-strings branch
> from July 3rd, since otherwise this change gets hopelessly entangled
> with that series.
> 
> I was unsure if I could snuggle the new "hart isa" line in just below
> "isa". Aesthetically it would be quite pleasing, but it runs the risk of
> breaking brittle usermode parsers that are assuming a specific line
> order. So I put it at the end.

Actually, they're probably only aesthetically pleasing when they match. If
there are differences, then I'd guess having them side by side, almost the
same, but different, would make them even harder to look at then they
already are. So I think I'll be happier with them separated by a few lines
anyway.

> 
> ---
>  arch/riscv/kernel/cpu.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1acf3679600d..6264b7b94945 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -197,9 +197,8 @@ arch_initcall(riscv_cpuinfo_init);
>  
>  #ifdef CONFIG_PROC_FS
>  
> -static void print_isa(struct seq_file *f)
> +static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>  {
> -	seq_puts(f, "isa\t\t: ");
>  
>  	if (IS_ENABLED(CONFIG_32BIT))
>  		seq_write(f, "rv32", 4);
> @@ -207,7 +206,7 @@ static void print_isa(struct seq_file *f)
>  		seq_write(f, "rv64", 4);
>  
>  	for (int i = 0; i < riscv_isa_ext_count; i++) {
> -		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
> +		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>  			continue;
>  
>  		/* Only multi-letter extensions are split by underscores */
> @@ -271,7 +270,15 @@ static int c_show(struct seq_file *m, void *v)
>  
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	print_isa(m);
> +
> +	/*
> +	 * For historical raisins, the isa: line is limited to the lowest common
> +	 * denominator of extensions supported across all harts. A true list of
> +	 * extensions supported on this hart is printed later in the hart_isa:
> +	 * line.
> +	 */
> +	seq_puts(m, "isa\t\t: ");
> +	print_isa(m, NULL);
>  	print_mmu(m);
>  
>  	if (acpi_disabled) {
> @@ -287,6 +294,13 @@ static int c_show(struct seq_file *m, void *v)
>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
> +
> +	/*
> +	 * Print the ISA extensions specific to this hart, which may show
> +	 * additional extensions not present across all harts.
> +	 */
> +	seq_puts(m, "hart isa\t: ");
> +	print_isa(m, hart_isa[cpu_id].isa);
>  	seq_puts(m, "\n");
>  
>  	return 0;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
