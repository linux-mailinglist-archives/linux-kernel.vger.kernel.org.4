Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A727274A49E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGFUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:00:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFAF1BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:00:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8ad9eede0so7159145ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688673655; x=1691265655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1WU2V04iVZxWiGrBNfGBOzGfOXPgmYyppOpGBIsnMQ=;
        b=dFyhEMLkcRRKiKGrmVpevNYL5dlYe9YRhDfDkuthC4m5TyQ0XEDeymG2969D+y3roL
         MIVibHl5zKvPxc3cQ678knVvqNlFg/Edm/WBczLrvl7YgWQgcbG3n7ORhxLj+PId16Rh
         OlpC2r9Fql6CzqCSSz/qfCGaiATuI20SfcyR+SMXN/xKvlkZJ3NvTpx1iRrgU/KuTzW/
         oGz6uD8aGXK1ilcqpCZm6bGedVBGk95iMiadi5FU9C3fzk3YfE+f2V2dQKPUQZ8Kn5eR
         3WFsX68WjsA2KIgAewiju2ksHaDMC1SabFRmfkj11YcSitbIwwx2QhhzYnnaWJkCvynT
         3MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673655; x=1691265655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1WU2V04iVZxWiGrBNfGBOzGfOXPgmYyppOpGBIsnMQ=;
        b=cZIC49C7Eo/QlxUgY65FnCftXegfk7rQRg8ASUd4jfcPdBHnzjFNtlxkvbU2cm5052
         TLwCJ9RQVHAzz1uAltBKxFiNk7NMqSZj37AXWtwFrci5FziTnqBqX/E6l4BlSn/6CG4I
         oDakaxXCVQLJz2z6jiSIasFqkhY9+lN3SqoL0RF1n6u9N6THFJMb0KOE7b8ak7HODfxR
         XyoOv7ui+teZNze5GvwOX7LwdQzwL0kBG5ZtL5otpTEMSS59d1kGuZpELFf3Y3xao4NQ
         tBN0Qgi2Utxv7xxnstqkK0jN2HKofLQQNhkfTTXJgDfDtTd8SHkQkmk29Mv08OB1qaJY
         Szpg==
X-Gm-Message-State: ABy/qLY6G4TldwwHr5WKwyct6JtfffmRnrz7Dek9NpMtd2u+bWj0dmoe
        A8ZCFCvJV5X+rev45KibEkKWSA==
X-Google-Smtp-Source: APBJJlGCTJOroNz4RXrgThXrgYzG6Oh5sXI8M7dMJKnHdVqVCbocuXvVz+ICxCCiBbnj5ixDClNE1Q==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id i9-20020a17090332c900b001b895986508mr3353078plr.18.1688673655421;
        Thu, 06 Jul 2023 13:00:55 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001b8013ed362sm1790618plr.96.2023.07.06.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:00:55 -0700 (PDT)
Date:   Thu, 6 Jul 2023 13:00:52 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, evan@rivosinc.com,
        heiko@sntech.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
Message-ID: <ZKcddDAbpdCtRevP@ghost>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
 <20230706-unwed-aeration-d8c7b71eac5e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706-unwed-aeration-d8c7b71eac5e@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:38:17PM +0100, Conor Dooley wrote:
> Hey,
> 
> On Wed, Jul 05, 2023 at 08:30:18PM -0700, Charlie Jenkins wrote:
> > Using vendor extensions in hwprobe, add the ability to query if the
> > 0.7.1 vector extension is available. It is determined to be available
> > only if the kernel is compiled with vector support,
> 
> > and the user is
> > using the c906.
> 
> Heh, unfortunately your patch doesn't apply this limitation.
> 
> I'm not really sure where this series is intended to sit in relation to
> Heiko's series that adds support for the actual T-Head vector stuff:
> https://lore.kernel.org/linux-riscv/20230622231305.631331-1-heiko@sntech.de/
> 
> Is this intended to complement that? If so, these patches don't really
> seem to integrate with it (and have some of the same flaws unfortunately
> as that series does).
> 
> Firstly, to my knowledge, all T-Head cpu cores report 0 for impid &
> archid. Stefan pointed out:
> 	C906 supports t-head/0.7.1 vectors as a configuration option.  The C906 in
> 	the D1 and BL808 has vectors, the recently announced CV1800B has one C906
> 	with vectors and one without, and I vaguely remember seeing a chip with only
> 	a non-vector C906.
> 	
> 	C908 (announced, no manual yet) claims V 1.0 support.  Presumably it will
> 	not support 0.7.1.
> 	
> 	C910 (exists on evaluation boards) lacks vector support.
> 	
> 	C920 (TH1520, SG2042, etc) has 0.7.1 support, at least superficially
> 	compatible with C906-with-vectors.  Hopefully we can share errata.
> 	
> 	This probably needs to be handled as an orthogonal "xtheadv" or "v0p7p1"
> 	extension in whatever replaces riscv,isa.
> 
> This makes an approach that does anything w/ their vector implementation
> not discernible based on the m*id CSRs. IMO, the only way to make this
> stuff work properly is to detect based on a DT or ACPI property whether
> this stuff is supported on a given core.
> 
> Since the approach just cannot work, I don't have any detailed comments
> to make, just a few small ones below.
>

It would be beneficial to use Heiko's vector support patch. I can look
into using that. The main purpose of this patch is to propose a method
of vendor extension support and since T-Head has hardware I have used 
their hardware as an example of how to implement vendor extensions. 
That is the reason for the kind of awkward patch segmentation.

> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig.vendor                       | 11 +++++++++++
> >  arch/riscv/include/asm/extensions.h             | 16 ++++++++++++++++
> >  arch/riscv/kernel/sys_riscv.c                   | 20 ++++++++++++++++++++
> >  arch/riscv/vendor_extensions/Makefile           |  2 ++
> >  arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++++++
> >  arch/riscv/vendor_extensions/thead/extensions.c | 24 ++++++++++++++++++++++++
> >  6 files changed, 81 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > index 213ac3e6fed5..b8b9d15153eb 100644
> > --- a/arch/riscv/Kconfig.vendor
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -1,3 +1,14 @@
> >  menu "Vendor extensions selection"
> >  
> > +config VENDOR_EXTENSIONS_THEAD
> > +	bool "T-HEAD vendor extensions"
> 
> > +	depends on RISCV_ALTERNATIVE
> 
> Why do you need this?
> 
Thanks for pointing that out, I meant to remove that.
> > +	default n
> > +	help
> > +	  All T-HEAD vendor extensions Kconfig depend on this Kconfig. Disabling
> > +	  this Kconfig will disable all T-HEAD vendor extensions. Please say "Y"
> > +	  here if your platform uses T-HEAD vendor extensions.
> 
> I don't really like this Kconfig entry. We should just use the one in
> Kconfig.errata that enables the actual vector stuff.
> 
The purpose of this is to support more than just the T-Head vector
extension. The vector extension is just the vendor extension I selected
to support first. The purpose of this file is for all vendors to have
their own Kconfig entries to enable the vector extension which I didn't
feel that it properly fit into the errata.
> > +
> > +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> > +
> >  endmenu # "Vendor extensions selection"
> > diff --git a/arch/riscv/include/asm/extensions.h b/arch/riscv/include/asm/extensions.h
> > new file mode 100644
> > index 000000000000..27ce294a3d65
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/extensions.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2023 by Rivos Inc.
> > + */
> > +#ifndef __ASM_EXTENSIONS_H
> > +#define __ASM_EXTENSIONS_H
> > +
> > +#include <asm/hwprobe.h>
> > +#include <linux/cpumask.h>
> > +
> > +#define THEAD_ISA_EXT0 (RISCV_HWPROBE_VENDOR_EXTENSION_SPACE)
> > +#define THEAD_ISA_EXT0_V0_7_1 (1 << 0)
> > +
> > +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
> > +		  const struct cpumask *cpus);
> > +#endif
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > index 2351a5f7b8b1..58b12eaeaf46 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -13,6 +13,7 @@
> >  #include <asm/vector.h>
> >  #include <asm/switch_to.h>
> >  #include <asm/uaccess.h>
> > +#include <asm/extensions.h>
> >  #include <asm/unistd.h>
> >  #include <asm-generic/mman-common.h>
> >  #include <vdso/vsyscall.h>
> > @@ -192,6 +193,25 @@ static int hwprobe_vendor(__u64 mvendorid, struct riscv_hwprobe *pair,
> >  			 const struct cpumask *cpus)
> >  {
> >  	switch (mvendorid) {
> > +#ifdef CONFIG_VENDOR_EXTENSIONS_THEAD
> 
> Please use IS_ENABLED() in code where possible, so that we get compile
> time coverage of the code it disables. IMO, this kinda overcomplicates
> the switch anyway, and it should be as simple as:
> case THEAD_VENDOR_ID:
> 	return hwprobe_thead(pair, cpus);
> 
> and deal with the specific stuff (like impid etc) inside that function.
> 
> > +	case THEAD_VENDOR_ID:
> > +		struct riscv_hwprobe marchid = {
> > +			.key = RISCV_HWPROBE_KEY_MARCHID,
> > +			.value = 0
> > +		};
> > +		struct riscv_hwprobe mimpid = {
> > +			.key = RISCV_HWPROBE_KEY_MIMPID,
> > +			.value = 0
> > +		};
> > +
> > +		hwprobe_arch_id(&marchid, cpus);
> > +		hwprobe_arch_id(&mimpid, cpus);
> > +		if (marchid.value != -1ULL && mimpid.value != -1ULL)
> > +			hwprobe_thead(marchid.value, mimpid.value, pair, cpus);
> > +		else
> > +			return -1;
> > +		break;
> > +#endif
> >  	default:
> >  		return -1;
> >  	}
> > diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendor_extensions/Makefile
> > index e815895e9372..38c3e80469fd 100644
> > --- a/arch/riscv/vendor_extensions/Makefile
> > +++ b/arch/riscv/vendor_extensions/Makefile
> > @@ -1,3 +1,5 @@
> >  ifdef CONFIG_RELOCATABLE
> >  KBUILD_CFLAGS += -fno-pie
> >  endif
> 
> Again, why do you need this, or...
This file is properly filled out in the next patch in the series but I
wanted to break it up. I saw this in the errata Makefiles so I assumed
it would be needed here.
> > +
> > +obj-$(CONFIG_VENDOR_EXTENSIONS_THEAD) += thead/
> > diff --git a/arch/riscv/vendor_extensions/thead/Makefile b/arch/riscv/vendor_extensions/thead/Makefile
> > new file mode 100644
> > index 000000000000..7cf43c629b66
> > --- /dev/null
> > +++ b/arch/riscv/vendor_extensions/thead/Makefile
> > @@ -0,0 +1,8 @@
> > +ifdef CONFIG_FTRACE
> > +CFLAGS_REMOVE_extensions.o = $(CC_FLAGS_FTRACE)
> > +endif
> > +ifdef CONFIG_KASAN
> > +KASAN_SANITIZE_extensions.o := n
> > +endif
> 
> ...any of this? Not saying you don't, but I think it should be explained.
> 
Same reasoning as above, I can remove it if it's not needed.
> > +
> > +obj-y += extensions.o
> > diff --git a/arch/riscv/vendor_extensions/thead/extensions.c b/arch/riscv/vendor_extensions/thead/extensions.c
> > new file mode 100644
> > index 000000000000..a177501bc99c
> > --- /dev/null
> > +++ b/arch/riscv/vendor_extensions/thead/extensions.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023 by Rivos Inc.
> > + */
> > +
> > +#include <asm/extensions.h>
> > +
> > +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
> > +		  const struct cpumask *cpus)
> > +{
> > +	pair->value = 0;
> > +	switch (pair->key) {
> > +	case THEAD_ISA_EXT0:
> > +#ifdef CONFIG_RISCV_ISA_V
> 
> As pointed out by Remi, this doesn't work either.
> You should not claim this is supported, just because V is, you also need
> the support for their vector "flavour" from Heiko's series.
> 
> Plus, it should be IS_ENABLED() too.
> 
> Cheers,
> Conor.
> 
The thought process was that it should only matter if they care about
V. However since they are different versions of V I could see it being
better to not depend on the same config. 
> > +		if (marchid == 0 && mimpid == 0)
> > +			pair->value |= THEAD_ISA_EXT0_V0_7_1;
> > +#endif
> > +		break;
> > +	default:
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > 
> > -- 
> > 2.41.0
> > 


