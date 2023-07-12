Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC7750ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGLOYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD781989
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uwMQV/RwpcjwXRB/9t5ugIb9Ny9N01YmFUxCFdhWhM4=; b=v5oh8wZqbSywmffQSV8Znini/p
        E1dEpG2qjsfwlVVmyYAD+yIuDOvy1yXy6u+9SW/BMBJOV6yu/FGlzpQenjH7PyDq2vz2I9gF1oc+p
        SZ7KdMRdobqgFZiJeDymChR89S5lfmk/arfoawNErpS2eWyURN6uFjEAtt5WM1iNAt0ya3+FX49wO
        975dwqjMuQJtmKqsgZhLBZ2i6f8aJk5pUXqzzm38AcvB8Irok3P+YmiS1l1VOgmJNllWHjE/U2O6l
        TbSjWWbILkoO4hsXm1+qQvOiSoitSkAm/yW3+PpqHCyOCfWfL0n88pzWvZyiVBmGZdRMo4+qU7oi5
        +KIAD4sA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJaky-00GlfL-IF; Wed, 12 Jul 2023 14:23:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCA8B3002CE;
        Wed, 12 Jul 2023 16:23:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6628200D83BC; Wed, 12 Jul 2023 16:23:51 +0200 (CEST)
Date:   Wed, 12 Jul 2023 16:23:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 00/15] powerpc/objtool: uaccess validation for PPC32
 (v4)
Message-ID: <20230712142351.GJ3100107@hirez.programming.kicks-ass.net>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 06:08:26PM +0200, Christophe Leroy wrote:
> This series adds UACCESS validation for PPC32. It includes
> a dozen of changes to objtool core.
> 
> It applies on top of series "Cleanup/Optimise KUAP (v3)"
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=363368&state=*

That contains:

+static __always_inline void uaccess_begin_32s(unsigned long addr)
+{
+	unsigned long tmp;
+
+	asm volatile(ASM_MMU_FTR_IFSET(
+		"mfsrin %0, %1;"
+		"rlwinm %0, %0, 0, %2;"
+		"mtsrin %0, %1;"
+		"isync", "", %3)
+		: "=&r"(tmp)
+		: "r"(addr), "i"(~SR_KS), "i"(MMU_FTR_KUAP)
+		: "memory");
+}
+
+static __always_inline void uaccess_end_32s(unsigned long addr)
+{
+	unsigned long tmp;
+
+	asm volatile(ASM_MMU_FTR_IFSET(
+		"mfsrin %0, %1;"
+		"oris %0, %0, %2;"
+		"mtsrin %0, %1;"
+		"isync", "", %3)
+		: "=&r"(tmp)
+		: "r"(addr), "i"(SR_KS >> 16), "i"(MMU_FTR_KUAP)
+		: "memory");
+}

And I am a bit puzzled by the isync placement of uaccess_end, should
that not start with the isync, to ensure completion of the uaccess
region before disabling it?

Or is that not the purpose of the isync?

> It is almost mature, performs code analysis for all PPC32.
> 
> In this version objtool switch table lookup has been enhanced to
> handle nested switch tables.
> 
> Most object files are correctly decoded, only a few
> 'unreachable instruction' warnings remain due to more complex
> fonctions which include back and forth jumps or branches.
> 
> It allowed to detect some UACCESS mess in a few files. They've been
> fixed through other patches.
> 
> Changes in v4:
> - Split series in two parts, the powerpc uaccess rework is submitted
> separately, see https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=363368&state=*
> - Support of UACCESS on all PPC32 including book3s/32 which was missing in v3.
> - More elaborated switch tables lookup.
> - Patches 2, 7, 8, 9, 10, 11 are new
> - Patch 11 in series v3 is now removed.

The patches look eminently reasonable to me; Josh, could you please have
a look?
