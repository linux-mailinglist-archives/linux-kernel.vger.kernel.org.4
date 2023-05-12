Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F397004B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjELKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjELKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:06:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB7611DAD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:06:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so48935425e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683885964; x=1686477964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRiOAb/9csqhYTIFyp1pXoHEquerHMt4RcBHag6qrzA=;
        b=FtnfcAiPQBflolkUTJAEGWO8NbifJuTY2DfUmyZKzawcND8rUBbNphH5LHn/GcuCl9
         hw+XAzWoW+qzwKOplZAsLVdAigNEKLglK8DqSybALmT+uDVraCDYhZgn8PTiyWgChhIO
         fjcKvvrG5Ds+tqIFynzyAn/6Sl5EhfdBPNEU54fmbNmUiIxdTak4hBkP3u7bRp6wFFja
         /Ai+NSPJfybgtVYn7lbYnvVehtJM8d3FIe+UFmk0ikvVQURHRJL6XjuEo5BUVKCnWxOg
         D0Xvef1dlNf0/iliMj+yASQBt+6bT4RpTw99iK07PKEGgwnJy/4WpMIRr/XoqdqYTBeS
         J+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683885964; x=1686477964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRiOAb/9csqhYTIFyp1pXoHEquerHMt4RcBHag6qrzA=;
        b=bpR9/xinMW2MBb7SdZlDkbB9twmGg7bpZF6z1omP3HFUDu+r/CdR9mel9KLEv3+APd
         fEvC/2G05FXLgIQDOWBBL92Dg3cH7VvtVioOwo0/FdMR9/eDQNPec60pOzYePJoV7gQ9
         gmwSTHo9ncvCkGahWoF9n+eAC6FK2BSQWYHbeNiE4OdMpmDIubPde4fMsKsBtv9koB+u
         liYY47bkauA3ABav5IiYs/eQ0ZbTZHHRSVU8091WKxWkDF5HP8ISU/HiKK7b6EKlqASV
         imNaZJT3eQVImPuUWxbeohWtZa8DpIuA4ulj+cHCvSbniLnQSSXHZvcpcTWMWWwvYcLa
         EE1g==
X-Gm-Message-State: AC+VfDxzigY0ngEEfQUzsG32aKRKXKtFM7VKd7ii6HNWfntkez0adJYm
        uRblrG3f/ZzeelOltWkbOIp6ww==
X-Google-Smtp-Source: ACHHUZ41RiKQE8KrlkMU/mH9eDmaYqmoUwJppNHdh4NZvMMR1RzeE2dRK3wifot4GUmdO1dKVaRWSg==
X-Received: by 2002:a05:600c:2195:b0:3f4:e4cd:f6e with SMTP id e21-20020a05600c219500b003f4e4cd0f6emr4312945wme.17.1683885964259;
        Fri, 12 May 2023 03:06:04 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003f0aefcc457sm28146577wmb.45.2023.05.12.03.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:06:03 -0700 (PDT)
Date:   Fri, 12 May 2023 12:06:02 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Amma Lee <lixiaoyun@binary-semi.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiezx@binary-semi.com
Subject: Re: [PATCH v2] riscv: optimize ELF relocation function in riscv
Message-ID: <20230512-a9128942f5c09108bd0c4ec3@orel>
References: <1683881513-18730-1-git-send-email-lixiaoyun@binary-semi.com>
 <20230512-a73001a0f4cfcf5f0e68d898@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512-a73001a0f4cfcf5f0e68d898@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:04:13PM +0200, Andrew Jones wrote:
> On Fri, May 12, 2023 at 04:51:53PM +0800, Amma Lee wrote:
> > The patch can optimize the running times of "insmod" command by modify ELF
> > relocation function.
> > When install the riscv ELF driver which contains multiple
> > symbol table items to be relocated, kernel takes a lot of time to
> > execute the relocation. For example, we install a 3+MB driver need 180+s.
> > We focus on the riscv kernel handle R_RISCV_HI20 and R_RISCV_LO12 type
> > items relocation function and find that there are two for-loops in this
> > function. If we modify the begin number in the second for-loops iteration,
> > we could save significant time for installation. We install the 3+MB
> > driver could just need 2s.
> > 
> > Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
> > Reviewed-by: Conor Dooley <conor@kernel.org>
> > 
> > ---
> >  arch/riscv/kernel/module.c | 53 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 35 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 55507b0..1683c1d 100755
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -385,9 +385,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  
> >  		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
> >  			unsigned int j;
> > -			/*Modify the j for-loops begin number from last iterates end value*/
> > +
> > +			/*
> 
> whitespace issue here
> 
> > +			* In the second for-loops, each traversal for j is
> > +			* starts from 0 to the symbol table item index which
> > +			* is detected. By the tool "readelf", we find that all
> > +			* the symbol table items about R_RISCV_PCREL_HI20 type
> > +			* are incrementally added in order. It means that we
> > +			* could interate the j with the previous loop end
> > +			* value(j_idx) as the begin number in the next loop;
> > +			*/
> >  			for (j = j_idx; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
> > -			/* Modify end */
> >  				unsigned long hi20_loc =
> >  					sechdrs[sechdrs[relsec].sh_info].sh_addr
> >  					+ rel[j].r_offset;
> > @@ -420,22 +428,30 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  					break;
> >  				}
> >  			}
> > +
> >  			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
> > -				if(j_idx == 0){
> > +				if (j_idx == 0) {
> >  					pr_err(
> >  						"%s: Can not find HI20 relocation information\n",
> >  						me->name);
> >  					return -EINVAL;
> >  				}
> > -				
> > -				
> > -				for (j = 0; j < j_idx; j++){ 
> > +
> > +				/*
> 
> also here
> 
> > +				* If the last j-loop have been traversed to the
> > +				* maximum value but never match the
> > +				* corresponding symbol relocation item, the
> > +				* j-loop will execute the second loop which
> > +				* is begin from 0 to the prerious index (j_idx)
> 
> previous
> 
> > +				* unless the previous j_idx == 0;
> > +				*/
> > +				for (j = 0; j < j_idx; j++) {
> >  					unsigned long hi20_loc =
> >  						sechdrs[sechdrs[relsec].sh_info].sh_addr
> >  						+ rel[j].r_offset;
> >  					u32 hi20_type = ELF_RISCV_R_TYPE(rel[j].r_info);
> > -				
> > -				
> > +
> > +
> 
> While fixing this whitespace, we could remove the redundant blank line too.
> 
> >  					/* Find the corresponding HI20 relocation entry */
> >  					if (hi20_loc == sym->st_value
> >  						&& (hi20_type == R_RISCV_PCREL_HI20
> > @@ -447,36 +463,37 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  						unsigned long hi20_sym_val =
> >  							hi20_sym->st_value
> >  							+ rel[j].r_addend;
> > -					
> > -				
> > +
> > +
> 
> also here
> 
> >  						/* Calculate lo12 */
> >  						size_t offset = hi20_sym_val - hi20_loc;
> > +						/* Calculate lo12 */
> 
> stray copy+pasted line?
> 
> >  						if (IS_ENABLED(CONFIG_MODULE_SECTIONS)
> >  							&& hi20_type == R_RISCV_GOT_HI20) {
> >  							offset = module_emit_got_entry(
> >  								me, hi20_sym_val);
> >  							offset = offset - hi20_loc;
> > -				
> > +
> 
> need to just remove this blank line
> 
> >  						}
> >  						hi20 = (offset + 0x800) & 0xfffff000;
> >  						lo12 = offset - hi20;
> >  						v = lo12;
> > -					
> > +
> 
> same here
> 
> >  						break;
> >  					}
> >  				}
> > -				
> > -				if (j == j_idx)
> > -				{
> > +
> > +				if (j == j_idx) {
> >  					pr_err(
> >  						"%s: Can not find HI20 relocation information\n",
> >  						me->name);
> >  					return -EINVAL;
> >  				}
> > -				
> > -				
> > +
> > +
> 
> should just remove both the blank lines above
> 
> >  			}
> > -			
> > +
> > +			/* Record the previous j-loop end index */
> >  			j_idx = j;
> 
> Huh... what did I miss? I went through the whole patch but only see
> formatting changes (and more opportunity for formatting changes).
> Where's the actual change?

It's best to do formatting ("no functional change") changes separately
from the functional changes to help reviewers see that, too. Please
separate the formatting into its own patch.

Thanks,
drew
