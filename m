Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337D85BF06B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiITWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiITWnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:43:37 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA236745F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:43:36 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-12b542cb1d3so6434644fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UreT1JFCWLwfJPYC+Sa2QhjvGuzvBwnaZ7R243GgYBI=;
        b=C8Pluupfoou+Dwog6ZapihxJf/eRoO0iYADDCtKbVAwT0ypAq784j8Ir/H6UrOmah4
         ArIFGR3h8xhtpxerjL1VPkl9lAyjRul+HG9Y9wo/jQ1K08A17CHbSH3i9YIwCrri7kMS
         2lrZgGlJTgyEjTi40N6mnkxusIfDX7NKzVAAe5tevO5Dk6l64OOw6C41ZwRs7jD7dVBu
         0rLbXgaBG1VobX7uGcsqfrt0M+ZwnrU9A5LqzdJfCZBWZe2R7Bgye0EpWhLjKTxsjvqd
         YEa5wvZiSanMeRknQrQsTwFv00wfacNX0pQdTkkvw6hNCaPu21CB9T89leZoECxi/3o7
         RM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UreT1JFCWLwfJPYC+Sa2QhjvGuzvBwnaZ7R243GgYBI=;
        b=udTg8dohBBBhcDJkPbBsUamibcB4plyv+lEF9A6yfDU0S3zEUtCe8VQpgQmIv5Su41
         PE6LlupcEOB2dCzwJrM+CzFi5jfn0FPrdcSftP8rtmelgN7QKo28lWrsboX92pj1ls3l
         cZ8XVQfEjG6N5zPKNrkEFS+b7KDFBFdWcXyYJLPxBNa5GHeLf4hHtamwKow7MaKR6h8d
         SHVS4Nzb+AOux0YIGicOts2lJwIsqh7u0eOmTZpn2J2hYqUINbUjY2MweoSPEcqbgr2d
         MXHbxnNFDes7nBy7L0J4Wj82FjsxitlkKzoflv/HhkHWMVGZHJ6DAtrOwwi6AcIzIS0B
         TZaQ==
X-Gm-Message-State: ACrzQf3kekabhAbEErguCfaxLxgmzyFuIuwHZbGlN1hntJa14szkjXH6
        3o7xSR00qI8UyxlIGNcHcO7DdZUoKCg=
X-Google-Smtp-Source: AMsMyM6kfmQfPNwBUXbkl3FQCfaOIXPlbr+N/kHTbA6GXWkd3ix3i4AgpZpcTWdqwtuHvVCQvTfnzQ==
X-Received: by 2002:a05:6870:f29f:b0:12c:be38:cec6 with SMTP id u31-20020a056870f29f00b0012cbe38cec6mr3406034oap.109.1663713815908;
        Tue, 20 Sep 2022 15:43:35 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id 187-20020aca06c4000000b0033e8629b323sm484430oig.35.2022.09.20.15.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:43:35 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:41:23 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alan Modra <amodra@au1.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] powerpc/64: don't refer nr_cpu_ids in asm code when it's
 undefined
Message-ID: <YypBk2gtlVCUBNXx@yury-laptop>
References: <20220920152935.1569605-1-yury.norov@gmail.com>
 <20220921082006.2235b7d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921082006.2235b7d2@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:20:06AM +1000, Stephen Rothwell wrote:
> Hi Yury,
> 
> On Tue, 20 Sep 2022 08:29:35 -0700 Yury Norov <yury.norov@gmail.com> wrote:
> >
> 
> > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> > index cf2c08902c05..7cb97881635e 100644
> > --- a/arch/powerpc/kernel/head_64.S
> > +++ b/arch/powerpc/kernel/head_64.S
> > @@ -400,7 +400,11 @@ generic_secondary_common_init:
> >  #else
> >  	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
> >  	ld	r8,0(r8)		/* Get base vaddr of array	 */
> > +#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
> > +	LOAD_REG_IMMEDIATE(r7, NR_CPUS)
> > +#else
> >  	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
> > +#endif
> >  	lwz	r7,0(r7)		/* also the max paca allocated 	 */
> >  	li	r5,0			/* logical cpu id                */
> >  1:
> > -- 
> > 2.34.1
> > 
> 
> I don't know PPC assembly very well, but should the #endif be one line
> lower so that the constant is not dereferenced in the non-#else case? 

Looks like you're right. Thanks, I'll send a v2.
