Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DF740E48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjF1KJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjF1KG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C4212D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:04:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso6167977e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687946678; x=1690538678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNv3Ntjw9a9SFPntTfDiSDFYXpNEEiDMU1CtBPXnFDI=;
        b=yqJPLfLINGBtelqfxwJSt7xu6/8kFt9kkGN4kwBaILn2nd9bRot6papzGlFBJfARPM
         JNQQM9Br9MY4Qx3ugVI0a6IsYGSiFpyB7eBPR4160ZgZW4tF/S3CPQKHB9lrvR+Na76f
         +vKdrF5zeVoupbJWu9ZXSXHghxD4NNMCxJM+KFonVJ8gY/nyVvOBMjPCOpr0HW+otC3C
         8kZm37vwNMkTYdBn/MNZ84cVPz7hDAW/X32wlC6JBB0Dr1CfkpaH8BXKQogZmI5s9MDX
         hHbfHB6hanUgwCsbUeqbAuAktvK6M5wY6/R3t9SlUg4PQ/Bbp15EKSoxcI8chxstHISm
         jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687946678; x=1690538678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNv3Ntjw9a9SFPntTfDiSDFYXpNEEiDMU1CtBPXnFDI=;
        b=NXfqH4dg+nz/yKLDgeqKNXbQ91m5fLaGxqk6wz7R7sOKR/t+wZ49+RrXXaV5QSlCBn
         qnf9M9stJtPW9qE/cGsc66XUr3OwOMk1OHdQVPb0662N3sooob2/WcKXzFmVBX3GAjch
         xfARDl4qYo7AdyMsshvGxbzwffwfDM5OsWDz1V+Uy6/jUaT0sCcS1Fjt1l1KNjaO8Wyh
         dUnqfYSOZrI1wT3MCQD0/GzMF26yHy25/HHJvjXq614oIkbUWn7vedz84uDCB5c5zVqR
         i0RUFxGOv9bVn89rNtu5cz7EcYlEKOVunikL5M9q+9pb0iWplDSYdiNmZeDC3qj+uQiK
         5Cww==
X-Gm-Message-State: AC+VfDzuiif/+4MBgdZ5P7B+myU3djo+QSTjC7mzf4+TqO1bd/ttnXkz
        3adJV/j++tAwnEbPogNcLenWcg==
X-Google-Smtp-Source: ACHHUZ4aCnUdPUOic31Ieac5lSE1bqzM8QBjgtRCj4W4up43plvOVO1AEBlDbszwZzebaEIgfmPlWw==
X-Received: by 2002:a05:6512:3ba5:b0:4fb:8fde:f60d with SMTP id g37-20020a0565123ba500b004fb8fdef60dmr1389496lfv.22.1687946678416;
        Wed, 28 Jun 2023 03:04:38 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0031118d80246sm12862873wrs.29.2023.06.28.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:04:38 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:04:35 +0200
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
Message-ID: <ZJwFs2O85pvjCLXa@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-3-sameo@rivosinc.com>
 <348f624f-3be0-4df7-ab5d-4a912197d82b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348f624f-3be0-4df7-ab5d-4a912197d82b@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:34:20PM -0400, Stefan O'Rear wrote:
> On Tue, Jun 27, 2023, at 10:37 AM, Samuel Ortiz wrote:
> > Zbc was missing from a previous Bit-Manipulation extension hwprobe
> > patch.
> >
> > Add all scalar crypto extensions bits, and define a macro for setting
> > the hwprobe key/pair in a more readable way.
> >
> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> > ---
> >  Documentation/riscv/hwprobe.rst       | 33 ++++++++++++++++++++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h | 11 ++++++++
> >  arch/riscv/kernel/sys_riscv.c         | 36 ++++++++++++++++-----------
> >  3 files changed, 66 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> > index 19165ebd82ba..3177550106e0 100644
> > --- a/Documentation/riscv/hwprobe.rst
> > +++ b/Documentation/riscv/hwprobe.rst
> > @@ -72,11 +72,44 @@ The following keys are defined:
> >         extensions.
> > 
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBB`: The Zbb extension is supported, 
> > as defined
> > +      in version 1.0 of the Bit-Manipulation ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBC`: The Zbc extension is supported, 
> > as defined
> >         in version 1.0 of the Bit-Manipulation ISA extensions.
> > 
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBS`: The Zbs extension is supported, 
> > as defined
> >         in version 1.0 of the Bit-Manipulation ISA extensions.
> > 
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKB`: The Zbkb extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKC`: The Zbkc extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKX`: The Zbkx extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKND`: The Zknd extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNE`: The Zkne extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNH`: The Zknh extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKR`: The Zkr extension is supported, 
> > as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSED`: The Zksed extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSH`: The Zksh extension is 
> > supported, as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKT`: The Zkt extension is supported, 
> > as defined
> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
> > +
> >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains 
> > performance
> >    information about the selected set of processors.
> > 
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h 
> > b/arch/riscv/include/uapi/asm/hwprobe.h
> > index 006bfb48343d..8357052061b3 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -29,6 +29,17 @@ struct riscv_hwprobe {
> >  #define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
> >  #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
> >  #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
> > +#define		RISCV_HWPROBE_EXT_ZBC		(1 << 6)
> > +#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 7)
> > +#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 8)
> > +#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 9)
> > +#define		RISCV_HWPROBE_EXT_ZKND		(1 << 10)
> > +#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 11)
> > +#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 12)
> > +#define		RISCV_HWPROBE_EXT_ZKR		(1 << 13)
> > +#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
> > +#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
> > +#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> > diff --git a/arch/riscv/kernel/sys_riscv.c 
> > b/arch/riscv/kernel/sys_riscv.c
> > index 26ef5526bfb4..df15926196b6 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -145,20 +145,28 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe 
> > *pair,
> >  	for_each_cpu(cpu, cpus) {
> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
> > 
> > -		if (riscv_isa_extension_available(isainfo->isa, ZBA))
> > -			pair->value |= RISCV_HWPROBE_EXT_ZBA;
> > -		else
> > -			missing |= RISCV_HWPROBE_EXT_ZBA;
> > -
> > -		if (riscv_isa_extension_available(isainfo->isa, ZBB))
> > -			pair->value |= RISCV_HWPROBE_EXT_ZBB;
> > -		else
> > -			missing |= RISCV_HWPROBE_EXT_ZBB;
> > -
> > -		if (riscv_isa_extension_available(isainfo->isa, ZBS))
> > -			pair->value |= RISCV_HWPROBE_EXT_ZBS;
> > -		else
> > -			missing |= RISCV_HWPROBE_EXT_ZBS;
> > +#define SET_HWPROBE_EXT_PAIR(ext)					\
> > +		do {							\
> > +			if (riscv_isa_extension_available(isainfo->isa, ext)) \
> > +				pair->value |= RISCV_HWPROBE_EXT_## ext; \
> > +			else						\
> > +				missing |= RISCV_HWPROBE_EXT_## ext;	\
> > +		} while (false)						\
> > +
> > +		SET_HWPROBE_EXT_PAIR(ZBA);
> > +		SET_HWPROBE_EXT_PAIR(ZBB);
> > +		SET_HWPROBE_EXT_PAIR(ZBC);
> > +		SET_HWPROBE_EXT_PAIR(ZBS);
> > +		SET_HWPROBE_EXT_PAIR(ZBKB);
> > +		SET_HWPROBE_EXT_PAIR(ZBKC);
> > +		SET_HWPROBE_EXT_PAIR(ZBKX);
> > +		SET_HWPROBE_EXT_PAIR(ZKND);
> > +		SET_HWPROBE_EXT_PAIR(ZKNE);
> > +		SET_HWPROBE_EXT_PAIR(ZKNH);
> > +		SET_HWPROBE_EXT_PAIR(ZKR);
> 
> Does the presence of a HWPROBE_EXT bit imply that userspace software can
> actually directly use the described feature?  If so, we should probably
> not set ZKR unless mseccfg.USEED=1.

mseccfg is MRW, so only accessible from M-mode only afaiu. So I don't
think we would be able to check that from Linux in S-mode.

Cheers,
Samuel.
