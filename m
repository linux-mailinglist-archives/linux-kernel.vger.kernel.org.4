Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC397427BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF2NxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjF2NxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:53:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E0358A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:53:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313f1085ac2so679338f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688046790; x=1690638790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deXO6fUjQ/I1CcOjtw/6ftLQJ+2W+4iNuI5l6xeu1MY=;
        b=R3X+tNcWmh90c7FQO2IFEUfn3dY7XU/IHZ8m0K4m8FncWd17IOSWpZkcdQ/U4hooaD
         cgGmeTTrRr2OrRfKuTs1sHB+4cNZN5NqDhyzsmfk4Zxjjb56L51k//kPcbMmsSj01LRu
         D2R89DHBjJKgxDL6HCLJv3XKtZ/Twswg5Y7/iTwtbaAFODUrne1G0IHI8OdIxb5kchDd
         GRDkla/ZEuvPWSXTReK24119T8u8/ZPQYsYaoOtebqXT2a10XTEQ6uJ1S8wF2Oj08XDI
         06o58qwmThSFm8Zs1nzZTznOXaj9hIS1yUsdD8NKey0rq7eFGm833c2UCm9yBnmFXmlU
         LBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046790; x=1690638790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deXO6fUjQ/I1CcOjtw/6ftLQJ+2W+4iNuI5l6xeu1MY=;
        b=idpvWfYBWyD9RMiKNmcQ15a5BQFIt02gzQMc85Z2PMDBvQpG5aIm//YULsmox1XOk7
         9kcapxb42vtY3SRrJk48/NKKrEyRzZ4RvsLRYpPSt8XS8aCP60SIvvdmhYyAZs7kmlUV
         XWlUYHv8vI+Gr4ljGwJdnItOeYU7TMJKXd1XKoXfYr3fXBUBXCbjmK8szNTcjnhc3eLk
         P/WHRCepwE2zKEzFX1mexYYSHTHprkpwGkkraGqWJfeUHg1tDF/2H7nWMwn7TsyPL/Vb
         HxDA27x553zCsTjPOhqzz19WxYnlNuVALKu81EEExA6AIXADUHwxhlrCoSrMGbITdx9P
         qJuQ==
X-Gm-Message-State: AC+VfDyTykmxBzf+AKC8hqgMatY8C3Qk7Gxe+Ttv7qE3uhXcwCIX7vkp
        Ol5ezIDqfr4X11Su787TeLZQLQ==
X-Google-Smtp-Source: ACHHUZ7FopTsScqJSZJdQm5B0JeBmJRowx9BBtyn/tckLRY0Q6eU6yJYdVMGnFQeUUk6i7smW5PvUA==
X-Received: by 2002:a5d:564e:0:b0:313:f241:f198 with SMTP id j14-20020a5d564e000000b00313f241f198mr8536457wrw.8.1688046790109;
        Thu, 29 Jun 2023 06:53:10 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d45c7000000b003141a3c4353sm1340835wrs.30.2023.06.29.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:53:09 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:53:08 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230629-11c59410a48bba2c00bb2433@orel>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
 <20230629-resilient-grievance-d782163b09d6@wendy>
 <20230629-a80f112e6ed4158080867694@orel>
 <20230629-deceit-macarena-2a744ac70148@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629-deceit-macarena-2a744ac70148@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:39:51PM +0100, Conor Dooley wrote:
> On Thu, Jun 29, 2023 at 11:31:33AM +0200, Andrew Jones wrote:
> > On Thu, Jun 29, 2023 at 09:28:56AM +0100, Conor Dooley wrote:
> > > As it says on the tin, provide a Kconfig option to disabling parsing the
> > > "riscv,isa" devicetree property. Hide the option behind NONPORTABLE so
> > > that only those willing to keep the pieces enable it, and make sure the
> > > default kernel contains the fallback code.
> > > 
> > > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/Kconfig             | 16 ++++++++++++++++
> > >  arch/riscv/kernel/cpu.c        |  3 +++
> > >  arch/riscv/kernel/cpufeature.c |  2 +-
> > >  3 files changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 1d39efe2b940..0e1909ac5947 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -291,6 +291,22 @@ config NONPORTABLE
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config NO_RISCV_ISA_FALLBACK
> > > +	bool "Permit falling back to parsing riscv,isa for extension support"
> > > +	depends on NONPORTABLE
> > > +	help
> > > +	  Parsing the "riscv,isa" devicetree property has been deprecated and
> > > +	  replaced by a list of explicitly defined strings. For compatibility
> > > +	  with existing platforms, the kernel will fall back to parsing the
> > > +	  "riscv,isa" property if the replacements are not found.
> > > +
> > > +	  Selecting Y here will result in a kernel without this fallback, and
> > > +	  will not work on platforms where the devicetree does not contain the
> > > +	  replacement 	  properties of "riscv,isa-base" and
> >                      ^ spacing issue
> 
> Huh, weird. Given the tab followed by spaces, it must have snuck in
> during reflow of the text after some rewording.
> Wonder how I missed it, given that...
> 
> > Should we also have a kernel command line option, 'isa_fallback', where
> > without this config the command line option is not necessary to fallback,
> > but, with this config, no fallback will be done unless 'isa_fallback' is
> > provided?
> 
> I don't know, maybe I have the wrong end of the stick but it feels a bit
> premature for something that may never not be hidden behind NONPORTABLE?
> Perhaps that could be left for a point in time where the default value
> of the symbol changes, or the dependency on NONPORTABLE is removed?
> 

With the command line option, we could consider dropping NONPORTABLE (but
still default off this config). What I'm thinking is that if we want to
encourage the adoption of the new format, then there should be a bit of
pain when it's not used, but not enough pain to risk rebellion. So,

 * defconfig builds will silently/painlessly fallback

 * builds that want to encourage adoption enable this config and will
   fail to boot when they don't get what they want and don't have the
   command line option

 * users still working through the growing pains can manage when
   the boot fails, and when it doesn't, with the command line

Thanks,
drew
