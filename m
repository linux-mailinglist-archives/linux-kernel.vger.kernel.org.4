Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD45B764A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiIMQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIMQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:18:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B308A4064
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6sWTHMIaS7c4U7WbLbBKuS0md5EgWarg5ud4NGNcZbk=; b=lmggLUI88QD+f7YFYmE75O1P7N
        G7Q9Yg27Ik3Cq4LkE0BpnsHzL0kAtPBczmImsWssmEDqLCliz0ttqlgQWTjNJhstHCKshN9Sq0gkn
        QOKNi/H5+rWs+hADnDr8ORim2r/bK0Y9p62PvTUWXgx9yl/NbIdZhI6eD2qVVuqHD/NzvaVI99HzE
        Nm5A8Z26keNaZzk3b6Oi0UnSG2AXWgr6Uiuxd42ztZ7S0n+c/p92YlE2Wi+FdeE2qiBeW9nsfKWoU
        dWB3roGJi+g00N30Ryvd6sWkigsh+zSapcNYhCxU2OyVCGby+yI3eMAtPhgA6SaZSpJTogKoLH9lc
        Ob3HHp6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oY6fm-00GvrO-Oe; Tue, 13 Sep 2022 14:13:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E665930030F;
        Tue, 13 Sep 2022 16:13:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C78E2202070C2; Tue, 13 Sep 2022 16:13:52 +0200 (CEST)
Date:   Tue, 13 Sep 2022 16:13:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v3 00/16] objtool: Enable and implement --mcount option
 on powerpc
Message-ID: <YyCQIMHXP9DdvCzo@hirez.programming.kicks-ass.net>
References: <20220912082020.226755-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082020.226755-1-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:50:04PM +0530, Sathvika Vasireddy wrote:
> Christophe Leroy (4):
>   objtool: Fix SEGFAULT
>   objtool: Use target file endianness instead of a compiled constant
>   objtool: Use target file class size instead of a compiled constant

> Sathvika Vasireddy (12):
>   objtool: Add --mnop as an option to --mcount
>   objtool: Read special sections with alts only when specific options are selected
>   objtool: Use macros to define arch specific reloc types
>   objtool: Add arch specific function arch_ftrace_match()
>   objtool/powerpc: Enable objtool to be built on ppc
>   objtool/powerpc: Add --mcount specific implementation

>  tools/objtool/arch/powerpc/Build              |   2 +
>  tools/objtool/arch/powerpc/decode.c           | 101 ++++++++++++++++++
>  .../arch/powerpc/include/arch/cfi_regs.h      |  11 ++
>  tools/objtool/arch/powerpc/include/arch/elf.h |  10 ++
>  .../arch/powerpc/include/arch/special.h       |  21 ++++
>  tools/objtool/arch/powerpc/special.c          |  19 ++++
>  tools/objtool/arch/x86/decode.c               |   5 +
>  tools/objtool/arch/x86/include/arch/elf.h     |   2 +
>  .../arch/x86/include/arch/endianness.h        |   9 --
>  tools/objtool/builtin-check.c                 |  14 +++
>  tools/objtool/check.c                         |  53 ++++-----
>  tools/objtool/elf.c                           |   8 +-
>  tools/objtool/include/objtool/arch.h          |   2 +
>  tools/objtool/include/objtool/builtin.h       |   1 +
>  tools/objtool/include/objtool/elf.h           |   8 ++
>  tools/objtool/include/objtool/endianness.h    |  32 +++---
>  tools/objtool/orc_dump.c                      |  11 +-
>  tools/objtool/orc_gen.c                       |   4 +-
>  tools/objtool/special.c                       |   3 +-

This seems to painlessly merge with the objtool changes I have in
queue.git/call-depth-tracking. After that all I need is the below little
patch to make it to build ppc44x_defconfig + CONFIG_DYNAMIC_FTRACE=y.

So I think these patches can go through the powerpc tree if Michael
wants. Josh you okay with that, or should we do something complicated?

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index ea2b1968f0ee..8343e2c4cea0 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -24,6 +24,11 @@ bool arch_callee_saved_reg(unsigned char reg)
 	return false;
 }
 
+bool arch_pc_relative_reloc(struct reloc *reloc)
+{
+	exit(-1);
+}
+
 int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
 	exit(-1);
