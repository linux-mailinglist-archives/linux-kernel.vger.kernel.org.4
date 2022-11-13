Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04E62700F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiKMOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FEB4AC;
        Sun, 13 Nov 2022 06:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BCBA60B49;
        Sun, 13 Nov 2022 14:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9AC433C1;
        Sun, 13 Nov 2022 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668349210;
        bh=BYWQERbdgHEBT7t6yByeyv9+5k/nRsNpyAKlViPkdOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+UzpbeA2zc2YeQ6TvzpWvfs6jT3UZiKmrKcZ5ObtrlOPyv4FpN5qQORO8KxBSXvv
         ifJpHTtjwYAIGunQn4960S2KgFR8dpz0qpG7PmPGB4vI4Fn2oKHYUTeQjKQb3SVcfW
         hUewxrCuVB+qUqjF4LgzZ5n+f53+7yCwmAgittArQqvDeDUUjO7Z7nItdrfcTFTW1h
         AhjE6sFcvillgplHdJn8jh1g1U//Jbdp2xEY8DqSiHYAZJXZoh/dBoLF5n2LS8yJzN
         0ixqanPgMbvLbEVK2VGdgKgDLiSzjn52kmVR8df9q5PVkfzOPovE3d/gVxbcRBBwKc
         KLMLE7FyrfarA==
Date:   Sun, 13 Nov 2022 14:20:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/9] RISC-V: Detect AIA CSRs from ISA string
Message-ID: <Y3D9FfXd+vULLTc0@spud>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111044207.1478350-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:12:00AM +0530, Anup Patel wrote:
> We have two extension names for AIA ISA support: Smaia (M-mode AIA CSRs)
> and Ssaia (S-mode AIA CSRs).
> 
> We extend the ISA string parsing to detect Smaia and Ssaia extensions.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 8 ++++++++
>  arch/riscv/kernel/cpu.c        | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b22525290073..06314220284f 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -59,9 +59,17 @@ enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_SSTC,
>  	RISCV_ISA_EXT_SVINVAL,
> +	RISCV_ISA_EXT_SSAIA,
> +	RISCV_ISA_EXT_SMAIA,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> +#ifdef CONFIG_RISCV_M_MODE
> +#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
> +#else
> +#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
> +#endif
> +
>  /*
>   * This enum represents the logical ID for each RISC-V ISA extension static
>   * keys. We can use static key to optimize code path if some ISA extensions
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 852ecccd8920..3c84680c2289 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -138,6 +138,8 @@ device_initcall(riscv_cpuinfo_init);
>   *    extensions by an underscore.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),

Trivially minor question: Is there a reason you added these before
after svinval elsewhere but before it here?

>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 694267d1fe81..e6d750d088ab 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -205,6 +205,8 @@ void __init riscv_fill_hwcap(void)
>  				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>  				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
>  				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> +				SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
> +				SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> -- 
> 2.34.1
> 
