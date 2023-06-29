Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB7742F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjF2VQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjF2VQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:16:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B56CCA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:16:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668711086f4so736673b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688073412; x=1690665412;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hF59tCLB3i2ZSoqiIO+QZt0MgqaxDzN1p9jJHZT4o+s=;
        b=uJs9KJk6RGq0HhR7GKju0z6egwb7wxB+esjqPBd+t9q0Idj2H4/W5fcpz5BalQjpxb
         kJ/1ZJoq78fN1zsmRVQakK08c6JSVIFi9IdPT8U9EYVYWx/bmp9ZcYyXRhjkpA8XpEsw
         fX21run5W6Pzcmk6qFlVwzRm1K1g+ISxCzH+aP1X4KhTpL+wupXPV0OlS2CaQhd+rc7E
         7yllj4OqVWMyeK7TIX6qAE6iXs4aoNSPIkC5P5O66+L3289HbOXDpx0Ex9+I6MEFwtFm
         Xp+2xmsbqmk5sEdsau03wGoii0c9R99HvqxpL9zVRBBkpuhqoGp03Izjy0eVwIYdGuWj
         Mxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073412; x=1690665412;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hF59tCLB3i2ZSoqiIO+QZt0MgqaxDzN1p9jJHZT4o+s=;
        b=DiRwG1KPwd9G3T9PtCJ9P3H9jgiAAe2agjfSsp6ascjqGgwVRsb02CjFDT19e5Easa
         BsgiLG7qjOuAdEp6WOXZBMYjSvTuDb+j5KMFHl48tBtTrr5Bfnj/NmYNx+0BwZYfzixL
         0Pwcy12WtF4FpYeowAc8hHMEM1OK1LwYOiAvICstWN8hjZ/2Btb5ykF4dfPAEDvu+n6o
         pDCQn15c0mJ+IoE4qbdTjHYE72wfTacEdJ3eI16CwkFRXC4vY3AzVTzUuZQeCI6cCyNa
         N1/8JkTS+T5nPLSamyZdqfVH5XlJNjP8WDMD/LO/EI7C18LwVC9OoyJOWFxXGKNXEDWl
         k5Pw==
X-Gm-Message-State: AC+VfDz5Eu4cFEr5KNrr+GB996V+omg6RFkt5hfkc5L8zLO9r+gDS3VC
        rpbwEz94VZxOd+1mPQ728INwiQ==
X-Google-Smtp-Source: ACHHUZ7Auq8rFwwTGtUSvrhxsKs6/7bdYvH4fWA7K/VE+Y1vOb62kTbTAFbRXyz4qwl5TBhNqJoUYQ==
X-Received: by 2002:a05:6a00:1388:b0:668:93e7:6800 with SMTP id t8-20020a056a00138800b0066893e76800mr7718754pfg.14.1688073411489;
        Thu, 29 Jun 2023 14:16:51 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0066ccb8e8024sm8411714pfi.30.2023.06.29.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:16:49 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:16:49 -0700 (PDT)
X-Google-Original-Date: Thu, 29 Jun 2023 14:16:07 PDT (-0700)
Subject:     Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable parsing "riscv,isa"
In-Reply-To: <20230629-landed-popsicle-ab46ab3b46d9@spud>
CC:     ajones@ventanamicro.com, Conor Dooley <conor.dooley@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        Evan Green <evan@rivosinc.com>, sunilvl@ventanamicro.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-f060b5c8-aa99-4952-b1e1-ee85a92e6b07@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 13:20:55 PDT (-0700), Conor Dooley wrote:
> On Thu, Jun 29, 2023 at 03:53:08PM +0200, Andrew Jones wrote:
>> On Thu, Jun 29, 2023 at 12:39:51PM +0100, Conor Dooley wrote:
>> > On Thu, Jun 29, 2023 at 11:31:33AM +0200, Andrew Jones wrote:
>> > > On Thu, Jun 29, 2023 at 09:28:56AM +0100, Conor Dooley wrote:
>> > > > As it says on the tin, provide a Kconfig option to disabling parsing the
>> > > > "riscv,isa" devicetree property. Hide the option behind NONPORTABLE so
>> > > > that only those willing to keep the pieces enable it, and make sure the
>> > > > default kernel contains the fallback code.
>> > > > 
>> > > > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> > > > ---
>> > > >  arch/riscv/Kconfig             | 16 ++++++++++++++++
>> > > >  arch/riscv/kernel/cpu.c        |  3 +++
>> > > >  arch/riscv/kernel/cpufeature.c |  2 +-
>> > > >  3 files changed, 20 insertions(+), 1 deletion(-)
>> > > > 
>> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > > index 1d39efe2b940..0e1909ac5947 100644
>> > > > --- a/arch/riscv/Kconfig
>> > > > +++ b/arch/riscv/Kconfig
>> > > > @@ -291,6 +291,22 @@ config NONPORTABLE
>> > > >  
>> > > >  	  If unsure, say N.
>> > > >  
>> > > > +config NO_RISCV_ISA_FALLBACK
>> > > > +	bool "Permit falling back to parsing riscv,isa for extension support"
>> > > > +	depends on NONPORTABLE
>> > > > +	help
>> > > > +	  Parsing the "riscv,isa" devicetree property has been deprecated and
>> > > > +	  replaced by a list of explicitly defined strings. For compatibility
>> > > > +	  with existing platforms, the kernel will fall back to parsing the
>> > > > +	  "riscv,isa" property if the replacements are not found.
>> > > > +
>> > > > +	  Selecting Y here will result in a kernel without this fallback, and
>> > > > +	  will not work on platforms where the devicetree does not contain the
>> > > > +	  replacement 	  properties of "riscv,isa-base" and
>> > >                      ^ spacing issue
>> > 
>> > Huh, weird. Given the tab followed by spaces, it must have snuck in
>> > during reflow of the text after some rewording.
>> > Wonder how I missed it, given that...

I sometimes end up with these when reflowing in vim, the Kconfig help 
text indent confuses things (though many things confuse whatever vim 
reflowing I'm using, so I should probably find something better).

>> > > Should we also have a kernel command line option, 'isa_fallback', where
>> > > without this config the command line option is not necessary to fallback,
>> > > but, with this config, no fallback will be done unless 'isa_fallback' is
>> > > provided?
>> > 
>> > I don't know, maybe I have the wrong end of the stick but it feels a bit
>> > premature for something that may never not be hidden behind NONPORTABLE?
>> > Perhaps that could be left for a point in time where the default value
>> > of the symbol changes, or the dependency on NONPORTABLE is removed?
>> > 

I agree it might not be worth the work, but looks like that's done...

>> With the command line option, we could consider dropping NONPORTABLE (but
>> still default off this config). What I'm thinking is that if we want to
>> encourage the adoption of the new format, then there should be a bit of
>> pain when it's not used, but not enough pain to risk rebellion. So,
>> 
>>  * defconfig builds will silently/painlessly fallback
>> 
>>  * builds that want to encourage adoption enable this config and will
>>    fail to boot when they don't get what they want and don't have the
>>    command line option
>> 
>>  * users still working through the growing pains can manage when
>>    the boot fails, and when it doesn't, with the command line
>
> So, something like the following squashed in? I inverted the config
> option, seemed more natural that way.
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d910fba25f2c..6c0d0bc06048 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5437,6 +5437,13 @@
>  			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>  			CPUs.
>  
> +	riscv_isa_fallback [RISCV]
> +			Fall back to detecting extension support using the
> +			"riscv,isa" property on devicetree systems when the
> +			replacement properties are not found, on kernels where
> +			RISCV_ISA_FALLBACK is not enabled. See the Kconfig entry
> +			for RISCV_ISA_FALLBACK.
> +
>  	ro		[KNL] Mount root device read-only on boot
>  
>  	rodata=		[KNL]
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0370713ad965..a9a473b67182 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -291,22 +291,6 @@ config NONPORTABLE
>  
>  	  If unsure, say N.
>  
> -config NO_RISCV_ISA_FALLBACK
> -	bool "Permit falling back to parsing riscv,isa for extension support"
> -	depends on NONPORTABLE
> -	help
> -	  Parsing the "riscv,isa" devicetree property has been deprecated and
> -	  replaced by a list of explicitly defined strings. For compatibility
> -	  with existing platforms, the kernel will fall back to parsing the
> -	  "riscv,isa" property if the replacements are not found.
> -
> -	  Selecting Y here will result in a kernel without this fallback, and
> -	  will not work on platforms where the devicetree does not contain the
> -	  replacement properties of "riscv,isa-base" and "riscv,isa-extensions".
> -	  Please see the dt-binding, located at
> -	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
> -	  on the replacement properties.
> -
>  choice
>  	prompt "Base ISA"
>  	default ARCH_RV64I
> @@ -857,6 +841,24 @@ config XIP_PHYS_ADDR
>  	  be linked for and stored to.  This address is dependent on your
>  	  own flash usage.
>  
> +config RISCV_ISA_FALLBACK
> +	bool "Permit falling back to parsing riscv,isa for extension support by default"
> +	default y

I think the only risk here is that randconfig will result in systems 
that don't boot, but we're already stuck with no meaningful base 
requirements.  Fixing that is a way bigger hurdle than this, so IMO it's 
fine.

> +	help
> +	  Parsing the "riscv,isa" devicetree property has been deprecated and
> +	  replaced by a list of explicitly defined strings. For compatibility
> +	  with existing platforms, the kernel will fall back to parsing the
> +	  "riscv,isa" property if the replacements are not found.
> +
> +	  Selecting N here will result in a kernel that does not use the
> +	  fallback, unless the commandline "riscv_isa_fallback" parameter is
> +	  present.
> +
> +	  Please see the dt-binding, located at
> +	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
> +	  on the replacement properties of "riscv,isa-base" and
> +	  "riscv,isa-extensions".
> +
>  endmenu # "Boot options"
>  
>  config BUILTIN_DTB
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index e3cda14a486b..52fa607a1691 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,7 @@ struct riscv_isa_ext_data {
>  
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>  extern const size_t riscv_isa_ext_count;
> +extern bool riscv_isa_fallback_cmdline;
>
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 86a1d98b8b3b..1e4cbdedc7fc 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -81,7 +81,7 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
>  	return 0;
>  
>  old_interface:
> -	if (IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK))
> +	if (!IS_ENABLED(CONFIG_RISCV_ISA_FALLBACK) && !riscv_isa_fallback_cmdline)
>  		return -ENODEV;
>  
>  	if (of_property_read_string(node, "riscv,isa", &isa)) {
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index f6fb18d2af84..5d848b7c1dde 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -471,6 +471,14 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>  	return 0;
>  }
>  
> +bool __initdata riscv_isa_fallback_cmdline = false;
> +static int __init riscv_isa_fallback_setup(char *__unused)

Maybe it's better to support =true and =false here?  Not sure it 
matters, we're already down a rabbit hole ;)

> +{
> +	riscv_isa_fallback_cmdline = true;
> +	return 1;
> +}
> +early_param("riscv_isa_fallback", riscv_isa_fallback_setup);

IMO it's cleaner to just set the default based on the Kconfig, that way 
there's only one thing to check.  We're already duplicating the "check 
both Kconfig and cmdline" logic twice, there's probably going to be 
others eventually.

> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	char print_str[NUM_ALPHA_EXTS + 1];
> @@ -490,7 +498,7 @@ void __init riscv_fill_hwcap(void)
>  	} else {
>  		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
>  
> -		if (ret && !IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK)) {
> +		if (ret && (IS_ENABLED(CONFIG_RISCV_ISA_FALLBACK) || riscv_isa_fallback_cmdline)) {
>  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
>  		}

I haven't read the whole patch set, but at least having a nice error for 
why probing didn't happen seems like the right way to go here.  IIUC 
this is just silent when ISA string fallbacks are disabled and the new 
properties aren't there.

Sorry in advance if it's just somewhere outside the diff, though.
