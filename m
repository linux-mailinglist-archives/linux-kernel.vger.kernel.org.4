Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96F6F0227
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbjD0HxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjD0HxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:53:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF11FC9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:53:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so5165127f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682582000; x=1685174000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ0f/TLmE6U7KpFTCCjbNTVanhPmdFTeq8v4yjZN2ZI=;
        b=CqxUiw/EOFD+4saU2CtOjJuaEoGRFUP84mWbHi2NQCp+AkbBmiMbJOVkVUtEBsRoPa
         TtQs//PK6Qo302tpqyCi91d7nmCdcu5KkYXyNlq1rgtT3IfBd+LbE5cdrj2PiH8pr1dU
         3SHBUJzBAbJxIEwC5tIjzkPJR6xy1T7Auay6xhpP25MUefnkjuYmLYZ0S3gGAfTIPhkv
         Ub5NPTr1bLN8FGTMlQxUDGggN1pv1NIY/d/nADdXvVUpgt0ACCNKX2y3PE+MCvOh4F7y
         ib4xH/u18g549yZryyt5XnGjtV5NL/Wd/j8FF4kpjzb1WIboh3mnmaVG+l3xxxPiX/u2
         GCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682582000; x=1685174000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ0f/TLmE6U7KpFTCCjbNTVanhPmdFTeq8v4yjZN2ZI=;
        b=FgpcxI/6Nzt0o4ViIcRCBvJmGxOyRHoVtJsNvKO+DCQT9D6DxlRACLp+BNtizMTC/Z
         nA/AafwDAaaD0HIHnq1CfBh29e9veXMgx5lzXGmL5p7BbnYGrPlL57Mvi23ejd7sNf0i
         TIaJmVT45LrO+KkAFJk8hND5zdVqh4/X4stJsz6kSUyYKLOWcDUgn0y5S7DblNewj5rU
         W0Y6biGh23LQRQOjoxBXxiAdAtthWuQDkNxsVXsYKGlVb3CNMIsFud14MfZWQC1sCI2F
         4+tn5+fPkv8gi6dH3/WWaKlYhSMttpbwl4kq2+eVVwBF7Xz50NahaMUq+6Up/qPmk1ST
         t1yw==
X-Gm-Message-State: AC+VfDwWY1hUb9jrTWiTv6+uUJu1nfkffzfEmvizCAOg9lLvBRMRWO0L
        mICIunQmaLE/JPdV/EF2uxq8hA==
X-Google-Smtp-Source: ACHHUZ6ItBA5+WYUdMqatlEghXuSEneRgMvehNHJKuqkCqKnWTFM83WWEHlM0gRD4mZKspxfzUZVfA==
X-Received: by 2002:a5d:60c8:0:b0:2f1:dae:100c with SMTP id x8-20020a5d60c8000000b002f10dae100cmr552626wrt.5.1682582000492;
        Thu, 27 Apr 2023 00:53:20 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4410000000b002f79ea6746asm17718846wrq.94.2023.04.27.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 00:53:20 -0700 (PDT)
Date:   Thu, 27 Apr 2023 09:53:19 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Yangyu Chen <cyy@cyyself.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <6kjgearxffbnnq4bsqs7e3jz6efz436m6gb3zjh7cfi357oxlv@krxto6orxwwn>
References: <20230425120016.187010-1-cyy@cyyself.name>
 <tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
 <20230426-porthole-wronged-d5a6a3b89596@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426-porthole-wronged-d5a6a3b89596@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 07:54:39PM +0100, Conor Dooley wrote:
> (+CC Drew)
> 
> Hey Yangyu,
> 
> One meta-level comment - can you submit this patch + my dt-bindings
> patch as a v2?
> Some comments below.
> 
> On Tue, Apr 25, 2023 at 08:00:15PM +0800, Yangyu Chen wrote:
> > According to RISC-V ISA specification, the ISA naming strings are case
> > insensitive. The kernel docs require the riscv,isa string must be all
> > lowercase to simplify parsing currently. However, this limitation is not
> > consistent with RISC-V ISA Spec.
> 
> Please remove the above and cite ACPI's case-insensitivity as the
> rationale for this change.
> 
> > This patch modifies the ISA string parser in the kernel to support
> > case-insensitive ISA string parsing. It replaces `strncmp` with
> > `strncasecmp`, replaces `islower` with `isalpha`, and wraps the
> > dereferenced char in the parser with `tolower`.
> > 
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > ---
> >  arch/riscv/kernel/cpu.c        |  6 ++++--
> >  arch/riscv/kernel/cpufeature.c | 20 ++++++++++----------
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 8400f0cc9704..531c76079b73 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/cpu.h>
> > +#include <linux/ctype.h>
> >  #include <linux/init.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/of.h>
> > @@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
> >  		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
> >  		return -ENODEV;
> >  	}
> > -	if (isa[0] != 'r' || isa[1] != 'v') {
> > +	if (tolower(isa[0]) != 'r' || tolower(isa[1]) != 'v') {
> >  		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
> >  		return -ENODEV;
> 
> I don't understand why this is even here in the first place. I'd be
> inclined to advocate for it's entire removal. Checking *only* that there
> is an "rv" in that string seems pointless to me. If you're on a 64-bit
> kernel and the node has riscv,isa = "rv32ima" it's gonna say it is okay?
> Drew what do you think?

It makes some sense to me as a garbage detector. It's unlikely the first
two bytes will be "rv" if the string is random junk. I think it should
also do a strlen(isa) >= 4 check first, though. of_property_read_string()
will succeed even when the string is "".

Thanks,
drew
