Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB25FBC16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJKUdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92907B285
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E2B4612C5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8D3C433C1;
        Tue, 11 Oct 2022 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665520414;
        bh=u/ngx5nkN4Heguu0mTv5ntQdOfvx9DRizvMHIBMZFBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTRD6zMn+QYXURS0Xv4rcmQ9+ca9gGY/ivP4U4j+PLGelg2oB6pXpRpdASuFUUs1N
         IEdCoKkJyNNKldLLfiV8wN2XZTJLm7QlBASADnaibAtfNPOU1SNDa7+tEQiWTNwWMB
         ejLR375TzQlXuvEAE0W+SbQ3kZU4hmXGoiMbiYqHNIWTlT1IkQ939fZp8gIubhMJJr
         lwalcI/94AJXKlgH+e1vCau578ipHzFF1oblY1uZga+Pz6/Q9s+Brm5+30Rwrbgdd2
         nrRwTH45iigXeo6U/+uRQQN1H9lNxvM5gPg+SqV9ZXWyZTwdcBAATBRZz+yi18r71m
         C/yl6zIK44Ycg==
Date:   Tue, 11 Oct 2022 13:33:32 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Sathvika Vasireddy <sv@linux.ibm.com>, aik@ozlabs.ru,
        chenzhongjin@huawei.com, christophe.leroy@csgroup.eu,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, mbenes@suse.cz,
        mingo@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        peterz@infradead.org, rostedt@goodmis.org
Subject: Re: [PATCH v4 11/16] objtool: Add --mnop as an option to --mcount
Message-ID: <20221011203332.zzmv6awd5eiydxgw@treble>
References: <20221002104240.1316480-1-sv@linux.ibm.com>
 <20221002104240.1316480-12-sv@linux.ibm.com>
 <1665401725.d3dolquorh.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1665401725.d3dolquorh.naveen@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:07:46PM +0530, Naveen N. Rao wrote:
> > +++ b/scripts/Makefile.lib
> > @@ -234,6 +234,7 @@ objtool_args =								\
> >  	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
> >  	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
> >  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
> > +	$(if $(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT), --mnop)                 \
> 
> This still won't help: for instance, if CONFIG_FTRACE itself is disabled. I
> think we should make this depend on CONFIG_FTRACE_MCOUNT_USE_OBJTOOL. The
> below change works for me:
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 54d2d6451bdacc..fd3f55a1fdb7bb 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -245,8 +245,8 @@ objtool_args =                                                              \
>        $(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)        \
>        $(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)              \
>        $(if $(CONFIG_X86_KERNEL_IBT), --ibt)                           \
> -       $(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)             \
> -       $(if $(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT), --mnop)                 \
> +        $(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL),                       \
> +             $(if $(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT), --mcount --mnop, --mcount)) \
>        $(if $(CONFIG_UNWINDER_ORC), --orc)                             \
>        $(if $(CONFIG_RETPOLINE), --retpoline)                          \
>        $(if $(CONFIG_RETHUNK), --rethunk)                              \

This has a new conflict, may need something like:

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -256,6 +256,9 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+objtool-args-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
+endif
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_RETPOLINE)			+= --retpoline
 objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
