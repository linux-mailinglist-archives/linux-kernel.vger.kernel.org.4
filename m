Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1929A74A48D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjGFTvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:51:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2E31BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:51:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4748fe4so5940195ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688673065; x=1691265065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7SIfnrH6W+ndBIG+oT0zX41PxWzADh99okj7zLhiK0=;
        b=xhu+WKItRJ0dgbFNbW8OVEUBD8N7e9IrYZVOqFQ7Bbw0fpfh5myvbdz/wIqgHF7zct
         wZQrRozIJAsmIgA2DZLxKNcA0RgR2uIPhAzayF9pFn+zvjEOdu75zfjWbWiCDs0K3K22
         R8/sPZlwQFIRtJQLkdMl7MebQPyOHPCrzwJ3yppM7jeaOgdOVZLnhMkybK0bq7gLqEWa
         +THdZ1zbrh0+d7alTnvg97MHKkR9n5C5p1mCw2BS1mBPXi51lhh0mDXoO8wxDLwwnBsA
         9PzRDGuyIdhC6rkY/QB1x7sKDxSl9X3bc6VUYv/NBk8QHoFPAj7GnnxThuX2+9vKRd2D
         ODYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673065; x=1691265065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7SIfnrH6W+ndBIG+oT0zX41PxWzADh99okj7zLhiK0=;
        b=bbJ0ZUHQ3+KmY1fg7SPWIDF6+v9O3OBd8i623iJkShDfdBjMBigEK2dZxuPvSxbWMu
         wWMn98boowxZI8ZM7zu0TCIe5EddtjK5QYz3LVYX3YSXfh4oACZIzLUGEU5sRJ906HPP
         6QeL+S2/TdL/Q14gx8oQEi5zN7cv4duwRziCdCfdxetV0PnQ4/S8aMYboT2JJHHVk6sO
         21nF7KkidSy74B8hXZtXDM18fYwrxLcGI5KMRAVZZ/Y3HpwCXpxdZe0ex04l/kdoVAyM
         cSCRykYRA65wnXhA8DmFJU+ROo6+VR/ZsgnunWUJTO0NCZdtjQruzlE0i2/CoHyH/cLs
         PUbQ==
X-Gm-Message-State: ABy/qLYlm3M8WcAgBvq34NKCg/KYxfq27ehF1xDEmrTvX4GXB0m4nomC
        C9L6CXhvR6RZ8zWMHKjgRl+UBA==
X-Google-Smtp-Source: APBJJlF2X52/3Pvd+ZdFOhgdfrTYvfNyCuhE45wjY6c2fADHuAleT51p3v7oewUSckaC8xKctXu0qA==
X-Received: by 2002:a17:902:e88e:b0:1b8:b3f9:58eb with SMTP id w14-20020a170902e88e00b001b8b3f958ebmr2849469plg.31.1688673065601;
        Thu, 06 Jul 2023 12:51:05 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b8aa51821csm1778401plx.138.2023.07.06.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:51:05 -0700 (PDT)
Date:   Thu, 6 Jul 2023 12:51:03 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, evan@rivosinc.com,
        heiko@sntech.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: Framework for vendor extensions
Message-ID: <ZKcbJ9MEP/pBx39J@ghost>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
 <20230706-curly-swinging-afbf79a4cdb7@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706-curly-swinging-afbf79a4cdb7@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:15:57PM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> On Wed, Jul 05, 2023 at 08:30:17PM -0700, Charlie Jenkins wrote:
> > Create Kconfig files, Makefiles, and functions to enable vendors to
> > provide information via the riscv_hwprobe syscall about which vendor
> > extensions are available.
> 
> This is all apparently from reading the diff, you don't need to tell us
> what files you have created etc. Please just stick with explaining the
> rationale for your changes (especially anything that might make someone
> reading it go "huh").
> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kbuild                     |  1 +
> >  arch/riscv/Kconfig                    |  1 +
> >  arch/riscv/Kconfig.vendor             |  3 +++
> >  arch/riscv/include/asm/hwprobe.h      |  1 +
> >  arch/riscv/kernel/sys_riscv.c         | 40 ++++++++++++++++++++++++++++++++---
> >  arch/riscv/vendor_extensions/Makefile |  3 +++
> >  6 files changed, 46 insertions(+), 3 deletions(-)
> 
> > diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> > index afa83e307a2e..bea38010d9db 100644
> > --- a/arch/riscv/Kbuild
> > +++ b/arch/riscv/Kbuild
> > @@ -3,6 +3,7 @@
> >  obj-y += kernel/ mm/ net/
> >  obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
> >  obj-y += errata/
> > +obj-y += vendor_extensions/
> >  obj-$(CONFIG_KVM) += kvm/
> >  
> >  obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c1505c7729ec..19404ede0ee3 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -276,6 +276,7 @@ config AS_HAS_OPTION_ARCH
> >  
> >  source "arch/riscv/Kconfig.socs"
> >  source "arch/riscv/Kconfig.errata"
> > +source "arch/riscv/Kconfig.vendor"
> >  
> >  menu "Platform type"
> >  
> > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > new file mode 100644
> > index 000000000000..213ac3e6fed5
> > --- /dev/null
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -0,0 +1,3 @@
> > +menu "Vendor extensions selection"
> > +
> > +endmenu # "Vendor extensions selection"
> 
> These files don't do anything, don't add them until you need to.
I wasn't sure if it was more clear to split up the vendor extension
framework from the T-Head specific calls since the main goal of this
series is to propose a vendor extension framework. I can merge this with
the following patch.
> 
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > index 78936f4ff513..fadb38b83243 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -9,5 +9,6 @@
> >  #include <uapi/asm/hwprobe.h>
> >  
> >  #define RISCV_HWPROBE_MAX_KEY 5
> > +#define RISCV_HWPROBE_VENDOR_EXTENSION_SPACE (UL(1)<<63)
> 
> Should this not be BIT_ULL(63)? Although I am not sure that we can
> actually do this, more on that front later.
> 
> >  
> >  #endif
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > index 26ef5526bfb4..2351a5f7b8b1 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -188,9 +188,35 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  	return perf;
> >  }
> >  
> > +static int hwprobe_vendor(__u64 mvendorid, struct riscv_hwprobe *pair,
> > +			 const struct cpumask *cpus)
> > +{
> > +	switch (mvendorid) {
> > +	default:
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >  			     const struct cpumask *cpus)
> >  {
> > +	int err;
> > +
> > +	if (((unsigned long) pair->key) >= RISCV_HWPROBE_VENDOR_EXTENSION_SPACE) {
> 
> Hopefully Bjorn or someone that actually knows a thing or two about uapi
> stuff can chime in here, but I think what you are doing here (where the
> vendor space sets the MSB) really muddies the api. These keys are defined
> as signed 64 bit numbers & -1 is the value set when a key is not valid.
> I'd much rather we kept the negative space off-limits, and used the 62nd
> bit instead, avoiding using negative numbers for valid keys.
> 
Yeah that makes sense, I can change this up.
> > +		struct riscv_hwprobe mvendorid = {
> > +			.key = RISCV_HWPROBE_KEY_MVENDORID,
> > +			.value = 0
> > +		};
> > +
> > +		hwprobe_arch_id(&mvendorid, cpus);
> 
> I think this needs a comment explaining why you do this hwprobe call, 
> > +		if (mvendorid.value != -1ULL)
> > +			err = hwprobe_vendor(mvendorid.value, pair, cpus);
> > +		else
> > +			err = -1;
> > +	}
> 
> I don't really understand the control flow here. Why are you continuing
> on to the switch statement, if you have either a) already ran
> hwprobe_vendor() or b) noticed that mvendorid.value is not valid?
> 
The purpose of this was to consolidate the error handling to a single
spot at the bottom of the file. It would fall through the switch
statement and set the values appropriately. I guess it does seem a bit
awkward.
> >  	switch (pair->key) {
> >  	case RISCV_HWPROBE_KEY_MVENDORID:
> >  	case RISCV_HWPROBE_KEY_MARCHID:
> > @@ -217,13 +243,21 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >  
> >  	/*
> >  	 * For forward compatibility, unknown keys don't fail the whole
> > -	 * call, but get their element key set to -1 and value set to 0
> > -	 * indicating they're unrecognized.
> > +	 * call, instead an error is raised to indicate the element key
> > +	 * is unrecognized.
> >  	 */
> >  	default:
> > +		err = -1;
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * Setting the element key to -1 and value to 0 indicates that
> > +	 * hwprobe was unable to find the requested key.
> > +	 */
> > +	if (err != 0) {
> >  		pair->key = -1;
> >  		pair->value = 0;
> > -		break;
> >  	}
> >  }
> >  
> > diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendor_extensions/Makefile
> > new file mode 100644
> > index 000000000000..e815895e9372
> > --- /dev/null
> > +++ b/arch/riscv/vendor_extensions/Makefile
> > @@ -0,0 +1,3 @@
> > +ifdef CONFIG_RELOCATABLE
> > +KBUILD_CFLAGS += -fno-pie
> > +endif
> 
> There are no files in this directory, why do you need to do a dance
> about relocatable kernels?
> 
This is framework for the following patch in the series. I saw these
lines in the errata Makefile so I created this Makefile to set up the
following patch in the series. I can merge this patch with the following
patch to make this series more clear.
> Cheers,
> Conor.


