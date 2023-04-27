Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB626F0357
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbjD0JZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbjD0JZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:25:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE97E5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:25:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so70660175e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682587537; x=1685179537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3/RzN4AJvDC7+eEY0sM4oqgUL0myB76IKp72IpocdI=;
        b=NDX3YZBXnnQ9XvwEILUzHMDKog2cxLjsSK+NztQGN+KobUMKr6u8RMTbINJ5fd8VLb
         qRYYGvjbjj5J3YmIJNwIcZfdl+CXDmsX3PhUlPO8zH7odexgLZCPMZHiI6SzHmEiGUyf
         UNg5SWroYTyiSicZpNz4RjeBG9JDZIjybobXnt+hpoogQKZ17IbQefhgpfsFnMMqLOLf
         vAHqAZOqzaNMj2xieSeDsThebhslPzfyu99dhZLR9Lf9wPsMLKGLWMDu4z20JzQd6A3L
         Xxb4LJsj1rFeChtfpFU7x1zjo6qYoStwBx2E+JnQLZx7JJ/YMmRyAiqHxIy8BSXxW9C2
         A/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587537; x=1685179537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3/RzN4AJvDC7+eEY0sM4oqgUL0myB76IKp72IpocdI=;
        b=fFuADKjSOMIuykDP6oAs92NAHNFBc8cME6eSG7sb3t+VngPXvvJDEHgd5y8ZMcXEzb
         RzfbjlDNzP5F+4GW6d7bQxVnAoPP5Es8l6bWEDbzWYvgBN43VV3KudEntRw/cocqTABb
         LlgrRP1EWy80txXT5Agnb1rUe077+EZOtNQQ7A1gRAfF6JxpVqGjtqZ4cCX/fYCrT2CT
         I8L8shbYhD4g4Z+Z6nRfIXTiKLTdQ1iEKI+PxULaUMhBaCKqckTRPVZY4FUQ8ln6C8Km
         juF1FFyWY4VGVluu45GwcvxnHI9o0GVSaknN2+4oBm7ILCFN6f/hv34sbglCf+5zc8RO
         voow==
X-Gm-Message-State: AC+VfDxlnhFSMhR4gcjY3r/iwjDpftAVHBrQIrXEPFp7EqNy/ULa3Ceg
        FrD3LXlzugIbzSOlahvS1sZ1eg==
X-Google-Smtp-Source: ACHHUZ75rGDonY81KfyHjidrZgSBeiUycDijDGIT5u1Snn62AK+MB0zlt5smJtkHgxXHeG5k2c1Iig==
X-Received: by 2002:a05:600c:210b:b0:3f1:8b0f:96ea with SMTP id u11-20020a05600c210b00b003f18b0f96eamr840997wml.37.1682587536678;
        Thu, 27 Apr 2023 02:25:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003f180d5b145sm20573730wme.40.2023.04.27.02.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 02:25:36 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:25:34 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <xvdswl3iyikwvamny7ikrxo2ncuixshtg3f6uucjahpe3xpc5c@ud4cz4fkg5dj>
References: <20230425120016.187010-1-cyy@cyyself.name>
 <tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
 <20230426-porthole-wronged-d5a6a3b89596@spud>
 <6kjgearxffbnnq4bsqs7e3jz6efz436m6gb3zjh7cfi357oxlv@krxto6orxwwn>
 <20230427-unveiling-kiwi-631e966f77cc@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-unveiling-kiwi-631e966f77cc@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:04:34AM +0100, Conor Dooley wrote:
> On Thu, Apr 27, 2023 at 09:53:19AM +0200, Andrew Jones wrote:
> > On Wed, Apr 26, 2023 at 07:54:39PM +0100, Conor Dooley wrote:
> > > (+CC Drew)
> > > 
> > > Hey Yangyu,
> > > 
> > > One meta-level comment - can you submit this patch + my dt-bindings
> > > patch as a v2?
> > > Some comments below.
> > > 
> > > On Tue, Apr 25, 2023 at 08:00:15PM +0800, Yangyu Chen wrote:
> > > > According to RISC-V ISA specification, the ISA naming strings are case
> > > > insensitive. The kernel docs require the riscv,isa string must be all
> > > > lowercase to simplify parsing currently. However, this limitation is not
> > > > consistent with RISC-V ISA Spec.
> > > 
> > > Please remove the above and cite ACPI's case-insensitivity as the
> > > rationale for this change.
> > > 
> > > > This patch modifies the ISA string parser in the kernel to support
> > > > case-insensitive ISA string parsing. It replaces `strncmp` with
> > > > `strncasecmp`, replaces `islower` with `isalpha`, and wraps the
> > > > dereferenced char in the parser with `tolower`.
> > > > 
> > > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > > > ---
> > > >  arch/riscv/kernel/cpu.c        |  6 ++++--
> > > >  arch/riscv/kernel/cpufeature.c | 20 ++++++++++----------
> > > >  2 files changed, 14 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > > index 8400f0cc9704..531c76079b73 100644
> > > > --- a/arch/riscv/kernel/cpu.c
> > > > +++ b/arch/riscv/kernel/cpu.c
> > > > @@ -4,6 +4,7 @@
> > > >   */
> > > >  
> > > >  #include <linux/cpu.h>
> > > > +#include <linux/ctype.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/seq_file.h>
> > > >  #include <linux/of.h>
> > > > @@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
> > > >  		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
> > > >  		return -ENODEV;
> > > >  	}
> > > > -	if (isa[0] != 'r' || isa[1] != 'v') {
> > > > +	if (tolower(isa[0]) != 'r' || tolower(isa[1]) != 'v') {
> > > >  		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
> > > >  		return -ENODEV;
> > > 
> > > I don't understand why this is even here in the first place. I'd be
> > > inclined to advocate for it's entire removal. Checking *only* that there
> > > is an "rv" in that string seems pointless to me. If you're on a 64-bit
> > > kernel and the node has riscv,isa = "rv32ima" it's gonna say it is okay?
> > > Drew what do you think?
> > 
> > It makes some sense to me as a garbage detector. It's unlikely the first
> > two bytes will be "rv" if the string is random junk.
> 
> Preventing the input of absolute rubbish is dt-validate's job & if the dtb
> itself has been corrupted somehow I suspect that we have bigger problems
> than checking for "rv" will solve.

We would, but would they be as easy to debug as this very early sanity
check? I agree, though, that doing the sanity checking in
riscv_of_processor_hartid(), which gets called from several different
places, seems a bit much. It'd be better to do that once, early, and
never again.

> 
> > also do a strlen(isa) >= 4 check first, though. of_property_read_string()
> > will succeed even when the string is "".
> 
> I don't think that checking that there are at least 4 characters isn't
> even sufficient. Either we should confirm that this is a valid riscv,isa
> to run on (so rv##ima w/ ## matching the kernel) or not bother at all.

Extending the check makes sense, but even more reason to do it outside
riscv_of_processor_hartid().

> 
> It's a different issue though, and I'd be inclined to revisit it in the
> future when the ACPI stuff is in, along with perhaps the cleanup parts
> of Heiko's series too.

Agreed.

Thanks,
drew
