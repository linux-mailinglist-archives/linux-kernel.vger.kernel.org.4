Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305D74CF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGJH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGJH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:59:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C0BB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:59:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so43128995e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688975983; x=1691567983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4s0y+CiArgrs8zc1TP81OmeRt+6ofcq3TLiNr7K9G0=;
        b=RGlYcLbHq4I0xKcSYV+BmOT+KQdZNUohhStkIT565OR29Way13n6yLzTPHecHFbs/V
         9znVnmH2wMAsF2FG0fMjoX7iwn0FuScQAblsq3YJ80t6BRNhfesFxHmpXSk3WyaCKLik
         d8ls9LQ9iiJ0QB4RIqIIO5aknSm7s9JY5fMjj7PF1kVvc51jz9KaN5kB2pibziL2MmK+
         emdVstWzD7sqsCIsUiPnVP1X+gtoOOkQbs13sTwIlgTCzq/3vEa5G36H/gMjfe896KyN
         wsLa3gh2m707fiYeX+tbmoYl1ysSXzucAnubgWGEIUS8EAcHkXRGoLV9+5+0SzzQHc2J
         sDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975983; x=1691567983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4s0y+CiArgrs8zc1TP81OmeRt+6ofcq3TLiNr7K9G0=;
        b=HaXFd2hssSshLZYDGX4thNZQw00AeuGf5/bOI/JvkqI2cVPtjP8MriJxIOxeAt3Mce
         KzEiLESkDMF00hq7OfkjXz+hDbkzTKK9aex9W60FgloDCC2b45yKwFLNc1BXiVvqCSrm
         +YaTQCP0VyR60xnTfDMVamvOR4NVd3481emxtXGpZwEnpxRI7tCtSwyYzyz2Hrl3ZsJw
         xdkw4tB4Et/UFNutwg1DacKHrfJAH5yR119LPK5I6i6C0OerPffiSYE1z8y6Ch8+5L5r
         OkHwYYk+K8TIRc3GDrM/zbNo9m5i3IdV3Hr8gOLfLLvfvGYHu/pLvOu6v4axKXlIdiAD
         cIHg==
X-Gm-Message-State: ABy/qLaaD48pUnObStotJ2o0iYNeIC9UX0ih50+xZp9mHlGNaXfOQxJz
        cr56jbOJDcIlzZwHqTQbPhTErg==
X-Google-Smtp-Source: APBJJlGpY2voIPQkLFH1Z0/MM2E5JF5SaKSqb7vmKQwdsGe4mvxip5sQYpELQv1YbeLkwSY4zIlVhA==
X-Received: by 2002:a5d:6b0b:0:b0:313:e5f2:7cbf with SMTP id v11-20020a5d6b0b000000b00313e5f27cbfmr10373854wrw.58.1688975983128;
        Mon, 10 Jul 2023 00:59:43 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d4d49000000b00315995837aesm2747389wru.36.2023.07.10.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:59:42 -0700 (PDT)
Date:   Mon, 10 Jul 2023 09:59:40 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Stefan O'Rear <sorear@fastmail.com>
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
Subject: Re: [PATCH 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto
 extensions
Message-ID: <ZKu6bCMPX0WKetVp@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-3-sameo@rivosinc.com>
 <348f624f-3be0-4df7-ab5d-4a912197d82b@app.fastmail.com>
 <ZJwFs2O85pvjCLXa@vermeer>
 <b208a2cb-bf68-4f4f-9c99-6a2e5853d26e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b208a2cb-bf68-4f4f-9c99-6a2e5853d26e@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:25:02AM -0400, Stefan O'Rear wrote:
> On Wed, Jun 28, 2023, at 6:04 AM, Samuel Ortiz wrote:
> > On Tue, Jun 27, 2023 at 08:34:20PM -0400, Stefan O'Rear wrote:
> >> On Tue, Jun 27, 2023, at 10:37 AM, Samuel Ortiz wrote:
> >> > Zbc was missing from a previous Bit-Manipulation extension hwprobe
> >> > patch.
> >> >
> >> > Add all scalar crypto extensions bits, and define a macro for setting
> >> > the hwprobe key/pair in a more readable way.
> >> >
> >> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> >> > ---
> >> >  Documentation/riscv/hwprobe.rst       | 33 ++++++++++++++++++++++++
> >> >  arch/riscv/include/uapi/asm/hwprobe.h | 11 ++++++++
> >> >  arch/riscv/kernel/sys_riscv.c         | 36 ++++++++++++++++-----------
> >> >  3 files changed, 66 insertions(+), 14 deletions(-)
> >> >
> >> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> >> > index 19165ebd82ba..3177550106e0 100644
> >> > --- a/Documentation/riscv/hwprobe.rst
> >> > +++ b/Documentation/riscv/hwprobe.rst
> >> > @@ -72,11 +72,44 @@ The following keys are defined:
> >> >         extensions.
> >> > 
> >> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBB`: The Zbb extension is supported, 
> >> > as defined
> >> > +      in version 1.0 of the Bit-Manipulation ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBC`: The Zbc extension is supported, 
> >> > as defined
> >> >         in version 1.0 of the Bit-Manipulation ISA extensions.
> >> > 
> >> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBS`: The Zbs extension is supported, 
> >> > as defined
> >> >         in version 1.0 of the Bit-Manipulation ISA extensions.
> >> > 
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKB`: The Zbkb extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKC`: The Zbkc extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKX`: The Zbkx extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKND`: The Zknd extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNE`: The Zkne extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNH`: The Zknh extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKR`: The Zkr extension is supported, 
> >> > as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSED`: The Zksed extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSH`: The Zksh extension is 
> >> > supported, as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKT`: The Zkt extension is supported, 
> >> > as defined
> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> >> > +
> >> >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains 
> >> > performance
> >> >    information about the selected set of processors.
> >> > 
> >> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h 
> >> > b/arch/riscv/include/uapi/asm/hwprobe.h
> >> > index 006bfb48343d..8357052061b3 100644
> >> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> >> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> >> > @@ -29,6 +29,17 @@ struct riscv_hwprobe {
> >> >  #define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
> >> >  #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
> >> >  #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
> >> > +#define		RISCV_HWPROBE_EXT_ZBC		(1 << 6)
> >> > +#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 7)
> >> > +#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 8)
> >> > +#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 9)
> >> > +#define		RISCV_HWPROBE_EXT_ZKND		(1 << 10)
> >> > +#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 11)
> >> > +#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 12)
> >> > +#define		RISCV_HWPROBE_EXT_ZKR		(1 << 13)
> >> > +#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
> >> > +#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
> >> > +#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
> >> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
> >> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> >> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> >> > diff --git a/arch/riscv/kernel/sys_riscv.c 
> >> > b/arch/riscv/kernel/sys_riscv.c
> >> > index 26ef5526bfb4..df15926196b6 100644
> >> > --- a/arch/riscv/kernel/sys_riscv.c
> >> > +++ b/arch/riscv/kernel/sys_riscv.c
> >> > @@ -145,20 +145,28 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe 
> >> > *pair,
> >> >  	for_each_cpu(cpu, cpus) {
> >> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
> >> > 
> >> > -		if (riscv_isa_extension_available(isainfo->isa, ZBA))
> >> > -			pair->value |= RISCV_HWPROBE_EXT_ZBA;
> >> > -		else
> >> > -			missing |= RISCV_HWPROBE_EXT_ZBA;
> >> > -
> >> > -		if (riscv_isa_extension_available(isainfo->isa, ZBB))
> >> > -			pair->value |= RISCV_HWPROBE_EXT_ZBB;
> >> > -		else
> >> > -			missing |= RISCV_HWPROBE_EXT_ZBB;
> >> > -
> >> > -		if (riscv_isa_extension_available(isainfo->isa, ZBS))
> >> > -			pair->value |= RISCV_HWPROBE_EXT_ZBS;
> >> > -		else
> >> > -			missing |= RISCV_HWPROBE_EXT_ZBS;
> >> > +#define SET_HWPROBE_EXT_PAIR(ext)					\
> >> > +		do {							\
> >> > +			if (riscv_isa_extension_available(isainfo->isa, ext)) \
> >> > +				pair->value |= RISCV_HWPROBE_EXT_## ext; \
> >> > +			else						\
> >> > +				missing |= RISCV_HWPROBE_EXT_## ext;	\
> >> > +		} while (false)						\
> >> > +
> >> > +		SET_HWPROBE_EXT_PAIR(ZBA);
> >> > +		SET_HWPROBE_EXT_PAIR(ZBB);
> >> > +		SET_HWPROBE_EXT_PAIR(ZBC);
> >> > +		SET_HWPROBE_EXT_PAIR(ZBS);
> >> > +		SET_HWPROBE_EXT_PAIR(ZBKB);
> >> > +		SET_HWPROBE_EXT_PAIR(ZBKC);
> >> > +		SET_HWPROBE_EXT_PAIR(ZBKX);
> >> > +		SET_HWPROBE_EXT_PAIR(ZKND);
> >> > +		SET_HWPROBE_EXT_PAIR(ZKNE);
> >> > +		SET_HWPROBE_EXT_PAIR(ZKNH);
> >> > +		SET_HWPROBE_EXT_PAIR(ZKR);
> >> 
> >> Does the presence of a HWPROBE_EXT bit imply that userspace software can
> >> actually directly use the described feature?  If so, we should probably
> >> not set ZKR unless mseccfg.USEED=1.
> >
> > mseccfg is MRW, so only accessible from M-mode only afaiu. So I don't
> > think we would be able to check that from Linux in S-mode.
> 
> Check directly, no, but your patch already makes the assumption that
> mseccfg.SSEED=1 if zkr is present in the device tree.  Which is fine as long
> as that contract is documented somewhere (presumably, the device tree
> binding; some of the language in the RVA22U64 profile spec implies USEED=0,
> but linux does not require profiles and they don't exist for rv32).
> 
> If we want U-mode behavior to be discoverable and/or predictable, we have
> three good options:

Thanks for the suggestions.

> Simplest: Document that we expect USEED=0 or USEED=1.  Set zkr appropriately
> in hwprobe.
> 
> Most flexible: Work with the SBI people to add a SBI_EXT_FWFEATURE for USEED,
> as well as defining the value on kernel entry.  Expose this via hwprobe and
> a new prctl.

I'd like to go down that route, but this depends on [1] to get
accepted/merged first.

Would it make sense to go with only documenting the USEED expectation
for now and then move to the more flexible FWFEATURE SBI approach?

Cheers,
Samuel.

[1] https://lists.riscv.org/g/tech-prs/message/540
