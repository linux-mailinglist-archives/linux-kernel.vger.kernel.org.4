Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A105738E37
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjFUSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFUSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:08:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DC1981
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:08:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25edd0df667so3093099a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687370927; x=1689962927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmhJcT+LcC000Rx34eKh7oIIU9KGsGabQnPAYT5+dWo=;
        b=SpSGdvMofh3oq8GgaE1kEEYBzNdN/cZK7Zy6UuyUbTRJGmv2xh3vKZZvkc5nIbQzw3
         hEXiPBaSa2M5Beermdv/PvS37fCSUJOFY+PvEVnLiHGpO3/uLGvluiPtnWGY3k2H1Cv7
         JIexlbQ6B8LvqpXF7dVp5PkdIrqnWDbECXjD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370927; x=1689962927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmhJcT+LcC000Rx34eKh7oIIU9KGsGabQnPAYT5+dWo=;
        b=LzbzEDEkYa5UODCNpPl0q8aHS43eKBxjeLj1eyPO8kcZqdgSL7xaI5PxMNTb5pFWuF
         TITwWbz2VCqd3r99swG4+MZ8jzpQLK2N2mdK5wx0VDYaSGa91IIvi2jJxIJsshpGKPhr
         15ceGDIsRX+WY7+y/lu9E7/o7SRAGkTH6DjQGiewfmUH6wuMXAqhBgpNywIhI+PHn+lN
         H5ptnqjd6bjhrqixBJseT1gzbRObUVYs2TAo3iUp8eMqS8nSWokxfbOpZpombIOBwAaV
         91ugexUmlBTpAh1Kh9ii3ovCWRqRnVqxylGZerHKwDp6zrop3j4+vT9Xir4858gXEgJM
         s0gw==
X-Gm-Message-State: AC+VfDwiE6QGT/J5QbHsAxiFBB7Eq8KrOojxsx69IwRdQw+DmdGT+3+o
        lzWypk0QH2JqvyzPnENLCfb4SA==
X-Google-Smtp-Source: ACHHUZ5tOehI23Lqrv1vWBuNKjJanjRFCw6loG7ibMq/QrQbUgERQqNLflQB+MOceYoaI2v9YH+B2A==
X-Received: by 2002:a17:90b:1b50:b0:261:1140:98b0 with SMTP id nv16-20020a17090b1b5000b00261114098b0mr771080pjb.12.1687370927264;
        Wed, 21 Jun 2023 11:08:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b0025bf1ea918asm3462854pjy.55.2023.06.21.11.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:08:46 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:08:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
Message-ID: <202306211107.4D529222C@keescook>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.127844423@infradead.org>
 <202306201455.AF16F617A@keescook>
 <20230621085217.GI2046280@hirez.programming.kicks-ass.net>
 <20230621092759.GJ2046280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092759.GJ2046280@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:27:59AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 10:52:17AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 20, 2023 at 02:56:22PM -0700, Kees Cook wrote:
> > > On Thu, Jun 15, 2023 at 09:35:47PM +0200, Peter Zijlstra wrote:
> > > > The ret_from_fork stub does an indirect call to the kthread function,
> > > > but only knows about Retpolines. Instead of making the asm more
> > > > complicated, punt to C and let the compiler figure it out.
> > > > 
> > > > Specifically, this makes it a proper kCFI indirect call when needed (in
> > > > fact, it is nearly impossible to code a kCFI indirect call in asm).
> > > > 
> > > > This was the only callsite that was still calling func()+0 on regular
> > > > indirect functions.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > I worry this creates a calling gadget, but I don't think it really
> > > counts since it's just converting between two prototypes. Regardless:
> > 
> > Ah, since this will never be indirectly called, I should be able to
> > annotate this so it never can be. Let me see what I can get the compiler
> > to do.

Ah yeah, it should be direct-called only. I keep forgetting about the
endbr removal pass.

> I can't seem to manage to have it clobber it's __cfi hash value. Ideally
> we'd have an attribute to force the thing to 0 or something.

Doesn't objtool have logic to figure out this is only ever
direct-called?

-- 
Kees Cook
