Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DD74A481
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGFToN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:44:11 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986A1BD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:44:10 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b441dd19eeso512210fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688672650; x=1691264650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGElb+Cjoak0I4zPNzDjmpmoeqnFLgwOuefnbY+DcUM=;
        b=GYbfjK/dBOzfrC3LdokX6emCTCUITzUzD4IwxQihJPxLHlNZIx7FQNvubq/lXTUwv4
         v5OZlsEUUzdw3/pgshLWaK1d4+c9YRGBkPzWp5VORq5G1UIIYY+CNSAYXzPi7Qj4Efnk
         6qOOuY//c+/1iVlLzoydR4oBi34zZDwTNNxkvfKP6vEYWjxyiaySnzn3fVYsAizhXd4a
         gZlwa+SHTIznp1aHB4o/0LDxHW80/WI0EMVJPc4wGKxVjCdoPR65mlmSGwsSWSvHUSBW
         iFuBO9sdHQyPDSC+2J8qKePdcjbEaMwcH6Nqodj29kOSAnFZcAhJ8WlTttmkrETRfFiA
         CJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688672650; x=1691264650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGElb+Cjoak0I4zPNzDjmpmoeqnFLgwOuefnbY+DcUM=;
        b=T+CnWZL9q3JW1CusEl4yZwzBKSppwyZmmT/dbSvE8+gfgqsQy9awbP3ECShqc0pv3H
         Jty5Q/PuP5prhPVO0XQpXvCGxg91Wmp0dXyOc90BzyVQUsgz2omslUsWR8c30CU957S7
         V7cpslQhknJI4sqCtdfI7BaQ9IFR73dzKLJg1z4q+Bd/dVaPtu/TwBATvjtcqmkYQNw2
         P96FB9jT2ZUVD00ZiJvrWovbsXX2uFAAJAoNND0UFjy47tZjVrw+sTNY5QWRc9iptFrO
         bqvuI3s6Y7bFgUPGvIzpKMt7Ne1VBZ4J5TKCFStcpbD3Q6pL99QmhXfJzggY0pJ0cZUL
         Tphw==
X-Gm-Message-State: ABy/qLaFSyKgj3daVySKTI1tepuhUnJFnBUqwWwyQqB/K1SlT/hGrZLD
        QPE3rb2n1O3viwVTqPbjt2D7Nw==
X-Google-Smtp-Source: APBJJlHZ0k/cH2+H+rv2it2rZ5NOkvziEyhzyL8dFDU6pYzvsoXjPCmJMZqqpsc2XlTAyPXLtP2Kzg==
X-Received: by 2002:a05:6870:40cb:b0:1b3:f8b7:55b4 with SMTP id l11-20020a05687040cb00b001b3f8b755b4mr3666684oal.35.1688672649796;
        Thu, 06 Jul 2023 12:44:09 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id nh8-20020a17090b364800b00256bbfbabcfsm150364pjb.48.2023.07.06.12.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:44:09 -0700 (PDT)
Date:   Thu, 6 Jul 2023 12:44:07 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: Framework for vendor extensions
Message-ID: <ZKcZhz7rPd41Z2DK@ghost>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
 <5947209.lOV4Wx5bFT@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5947209.lOV4Wx5bFT@basile.remlab.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 07:29:37PM +0300, Rémi Denis-Courmont wrote:
> Le torstaina 6. heinäkuuta 2023, 6.30.17 EEST Charlie Jenkins a écrit :
> > Create Kconfig files, Makefiles, and functions to enable vendors to
> > provide information via the riscv_hwprobe syscall about which vendor
> > extensions are available.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kbuild                     |  1 +
> >  arch/riscv/Kconfig                    |  1 +
> >  arch/riscv/Kconfig.vendor             |  3 +++
> >  arch/riscv/include/asm/hwprobe.h      |  1 +
> >  arch/riscv/kernel/sys_riscv.c         | 40
> > ++++++++++++++++++++++++++++++++--- arch/riscv/vendor_extensions/Makefile |
> >  3 +++
> >  6 files changed, 46 insertions(+), 3 deletions(-)
> > 
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
> > diff --git a/arch/riscv/include/asm/hwprobe.h
> > b/arch/riscv/include/asm/hwprobe.h index 78936f4ff513..fadb38b83243 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -9,5 +9,6 @@
> >  #include <uapi/asm/hwprobe.h>
> > 
> >  #define RISCV_HWPROBE_MAX_KEY 5
> > +#define RISCV_HWPROBE_VENDOR_EXTENSION_SPACE (UL(1)<<63)
> 
> Isn't this UB on 32-bit RISC-V ?
Hmm, yeah it would be, but the hwprobe syscall is based on a 64 bit key
using the __s64 type. There could be an alternative vendor space at the
top of 32-bits for those machines.
> 
> > 
> >  #endif
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > index 26ef5526bfb4..2351a5f7b8b1 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -188,9 +188,35 @@ static u64 hwprobe_misaligned(const struct cpumask
> > *cpus) return perf;
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
> > +	if (((unsigned long) pair->key) >= 
> RISCV_HWPROBE_VENDOR_EXTENSION_SPACE) {
> > +		struct riscv_hwprobe mvendorid = {
> > +			.key = RISCV_HWPROBE_KEY_MVENDORID,
> > +			.value = 0
> > +		};
> > +
> > +		hwprobe_arch_id(&mvendorid, cpus);
> > +		if (mvendorid.value != -1ULL)
> > +			err = hwprobe_vendor(mvendorid.value, pair, 
> cpus);
> > +		else
> > +			err = -1;
> > +	}
> > +
> >  	switch (pair->key) {
> >  	case RISCV_HWPROBE_KEY_MVENDORID:
> >  	case RISCV_HWPROBE_KEY_MARCHID:
> > @@ -217,13 +243,21 @@ static void hwprobe_one_pair(struct riscv_hwprobe
> > *pair,
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
> > diff --git a/arch/riscv/vendor_extensions/Makefile
> > b/arch/riscv/vendor_extensions/Makefile new file mode 100644
> > index 000000000000..e815895e9372
> > --- /dev/null
> > +++ b/arch/riscv/vendor_extensions/Makefile
> > @@ -0,0 +1,3 @@
> > +ifdef CONFIG_RELOCATABLE
> > +KBUILD_CFLAGS += -fno-pie
> > +endif
> 
> 
> -- 
> レミ・デニ-クールモン
> http://www.remlab.net/
> 
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
