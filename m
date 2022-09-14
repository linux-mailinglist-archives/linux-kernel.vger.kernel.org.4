Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9706C5B7DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiINAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiINAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F86B8E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA93B616C4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7B1C433C1;
        Wed, 14 Sep 2022 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663114567;
        bh=i5TCC7WtvWt2OoQKBQRRIqibY1WStajucQRycGByNsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAebFXGP39O7QxUYL60jI5js/29Ycd5r03WLzkX4f2VlfOHVJqG1jAeGcnK4FJyBF
         cO40DMe5y4BuxWXzb7JeoVkgtADnn0XYqS1hxJucOyFfm/iXPE2iSRMTzZPXmrUfZS
         lrqBeoRLc1ygIdOANgEnww5kQLkJ5foumjyL1sWpITd+qKbj0Uz82P350KzizCGgz6
         uDjbREwADetOiZzbdAYHEsrQkPamRNbxV4aW5gkVAVlXTYZ6KuY6obDs2U1ECazAMV
         knGKmectix3ZBbrdLCuz/y3GS/JARgZ6XvJ2rr/7EYuaEQ/ThUpd8zrktMRXC1izH/
         CCQshx2ChJG+A==
Date:   Wed, 14 Sep 2022 01:15:52 +0100
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>, aik@ozlabs.ru,
        chenzhongjin@huawei.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 00/16] objtool: Enable and implement --mcount option
 on powerpc
Message-ID: <20220914001552.6nerqcbrqy7burda@treble>
References: <20220912082020.226755-1-sv@linux.ibm.com>
 <YyCQIMHXP9DdvCzo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyCQIMHXP9DdvCzo@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 04:13:52PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 12, 2022 at 01:50:04PM +0530, Sathvika Vasireddy wrote:
> > Christophe Leroy (4):
> >   objtool: Fix SEGFAULT
> >   objtool: Use target file endianness instead of a compiled constant
> >   objtool: Use target file class size instead of a compiled constant
> 
> > Sathvika Vasireddy (12):
> >   objtool: Add --mnop as an option to --mcount
> >   objtool: Read special sections with alts only when specific options are selected
> >   objtool: Use macros to define arch specific reloc types
> >   objtool: Add arch specific function arch_ftrace_match()
> >   objtool/powerpc: Enable objtool to be built on ppc
> >   objtool/powerpc: Add --mcount specific implementation
> 
> >  tools/objtool/arch/powerpc/Build              |   2 +
> >  tools/objtool/arch/powerpc/decode.c           | 101 ++++++++++++++++++
> >  .../arch/powerpc/include/arch/cfi_regs.h      |  11 ++
> >  tools/objtool/arch/powerpc/include/arch/elf.h |  10 ++
> >  .../arch/powerpc/include/arch/special.h       |  21 ++++
> >  tools/objtool/arch/powerpc/special.c          |  19 ++++
> >  tools/objtool/arch/x86/decode.c               |   5 +
> >  tools/objtool/arch/x86/include/arch/elf.h     |   2 +
> >  .../arch/x86/include/arch/endianness.h        |   9 --
> >  tools/objtool/builtin-check.c                 |  14 +++
> >  tools/objtool/check.c                         |  53 ++++-----
> >  tools/objtool/elf.c                           |   8 +-
> >  tools/objtool/include/objtool/arch.h          |   2 +
> >  tools/objtool/include/objtool/builtin.h       |   1 +
> >  tools/objtool/include/objtool/elf.h           |   8 ++
> >  tools/objtool/include/objtool/endianness.h    |  32 +++---
> >  tools/objtool/orc_dump.c                      |  11 +-
> >  tools/objtool/orc_gen.c                       |   4 +-
> >  tools/objtool/special.c                       |   3 +-
> 
> This seems to painlessly merge with the objtool changes I have in
> queue.git/call-depth-tracking. After that all I need is the below little
> patch to make it to build ppc44x_defconfig + CONFIG_DYNAMIC_FTRACE=y.
> 
> So I think these patches can go through the powerpc tree if Michael
> wants. Josh you okay with that, or should we do something complicated?

I'm all for avoiding complicated, but let me try to give it a proper
review first.

-- 
Josh
