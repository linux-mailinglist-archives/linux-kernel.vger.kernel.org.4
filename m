Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBBD672692
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjARSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjARSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:17:26 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856435AB7D;
        Wed, 18 Jan 2023 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aOq08Fn70RFp1jHBPmpf7hVqLib9PmJh4hNMYXx2kaE=; b=Sgs6eZ7TKfcJhDHNm8DiAswGRq
        pR1d9g9OoG5GF/2mQlVPFa9/On2Ztu/Oz8EB/qbbxSrG5sowRH/I1taNGwFx3GhfgtsclQVOtJlLt
        /7pvZLOzddsUtcX9E29PO//wtcaVsnUvyJf+poaexz5yJ+0FTY8VxeRYEsH4u6k3ATt3ZH0yFXi/q
        LVtNXTMT9mdRhCMd0gaE5I79PDVtZDcfK8j5Gkz7G9uN1QElaLFjBQfZiRrcLVoNxc+PEkBjONyoq
        sqBGnM8ivjQ2M0f4kTN+eljN0bQ6T2cFls1DrKlXCv0zJ84eTQejmmqAAKlp1ZbDWRmkvvLY1y4dn
        3EBtMY9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pICzR-002azl-1k;
        Wed, 18 Jan 2023 18:16:49 +0000
Date:   Wed, 18 Jan 2023 18:16:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn
Subject: Re: [PATCH] alpha: potential dereference of null pointer
Message-ID: <Y8g3kfp61DltYk//@ZenIV>
References: <202301171823476416320@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301171823476416320@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:23:47PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The return value of kmalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  arch/alpha/kernel/module.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
> index 5b60c248de9e..5442b75a98c2 100644
> --- a/arch/alpha/kernel/module.c
> +++ b/arch/alpha/kernel/module.c
> @@ -47,6 +47,8 @@ process_reloc_for_got(Elf64_Rela *rela,
>  		}
> 
>  	g = kmalloc (sizeof (*g), GFP_KERNEL);
> +	if (!g)
> +		return;
>  	g->next = chains[r_sym].next;
>  	g->r_addend = r_addend;
>  	g->got_offset = *poffset;

NAK.  This kind of patches is strictly worse than useless.
Look at what has happened here:

1) your tool has found an indicator of possible bug.  Might or
might not be a false positive.

2) it is *NOT* a false positive - the problem caught by your
heuristics is real.  Indeed, allocation might fail and that
would result in problems.

3) solution: send a patch that would modify the code so that the
same heuristics would no longer be able to spot the problem.

Suppose it gets applied.  Is the bug fixed?  Your heuristics no
longer trigger, but what happens in the conditions that would
have triggered the original bug?  Sure, process_reloc_for_got()
returns without an oops now.  But what was it supposed to do
with the object it tried to allocate?  It might be that
"skip allocation and move on" is correct, but from the look
of that code it seems to be unlikely.

And if you look at the caller, you'll see that
	* everything we allocate gets shortly freed
	* the caller does temporary allocations of its own (also
freed later)
	* failure of the allocations in the caller translates into
"return -ENOMEM"

IOW, the caller's callers are supposed to deal with the possibility
of -ENOMEM being returned to them in such situations, which means
that we do have a reasonably safe approach - have allocation failures
in process_reloc_for_got() reported to caller and treated as "clean
up and fail with -ENOMEM there".

*IF* your variant is actually safe, you should at the very least
include the analysis and the reasons why it works.  TBH, I do not
believe that it is safe.

And no, "it doesn't oops with that change" is not a sufficient
improvement to balance "it ends up with corrupted loaded module
in the same conditions and is harder to spot on source inspection".

I would suggest something along the lines of (completely untested)
diff below:

diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
index 5b60c248de9e..e6ef4c5e8f95 100644
--- a/arch/alpha/kernel/module.c
+++ b/arch/alpha/kernel/module.c
@@ -25,7 +25,7 @@ struct got_entry {
 	int got_offset;
 };
 
-static inline void
+static inline int
 process_reloc_for_got(Elf64_Rela *rela,
 		      struct got_entry *chains, Elf64_Xword *poffset)
 {
@@ -35,7 +35,7 @@ process_reloc_for_got(Elf64_Rela *rela,
 	struct got_entry *g;
 
 	if (r_type != R_ALPHA_LITERAL)
-		return;
+		return 0;
 
 	for (g = chains + r_sym; g ; g = g->next)
 		if (g->r_addend == r_addend) {
@@ -47,6 +47,8 @@ process_reloc_for_got(Elf64_Rela *rela,
 		}
 
 	g = kmalloc (sizeof (*g), GFP_KERNEL);
+	if (!g)
+		return -ENOMEM;
 	g->next = chains[r_sym].next;
 	g->r_addend = r_addend;
 	g->got_offset = *poffset;
@@ -58,6 +60,7 @@ process_reloc_for_got(Elf64_Rela *rela,
 	   42 valid relocation types, and a 32-bit field.  Co-opt the
 	   bits above 256 to store the got offset for this reloc.  */
 	rela->r_info |= g->got_offset << 8;
+	return 0;
 }
 
 int
@@ -68,6 +71,7 @@ module_frob_arch_sections(Elf64_Ehdr *hdr, Elf64_Shdr *sechdrs,
 	Elf64_Rela *rela;
 	Elf64_Shdr *esechdrs, *symtab, *s, *got;
 	unsigned long nsyms, nrela, i;
+	int err;
 
 	esechdrs = sechdrs + hdr->e_shnum;
 	symtab = got = NULL;
@@ -107,12 +111,12 @@ module_frob_arch_sections(Elf64_Ehdr *hdr, Elf64_Shdr *sechdrs,
 
 	/* Examine all LITERAL relocations to find out what GOT entries
 	   are required.  This sizes the GOT section as well.  */
-	for (s = sechdrs; s < esechdrs; ++s)
+	for (err = 0, s = sechdrs; !err && s < esechdrs; ++s)
 		if (s->sh_type == SHT_RELA) {
 			nrela = s->sh_size / sizeof(Elf64_Rela);
 			rela = (void *)hdr + s->sh_offset;
-			for (i = 0; i < nrela; ++i)
-				process_reloc_for_got(rela+i, chains,
+			for (i = 0; !err && i < nrela; ++i)
+				err = process_reloc_for_got(rela+i, chains,
 						      &got->sh_size);
 		}
 
@@ -126,7 +130,7 @@ module_frob_arch_sections(Elf64_Ehdr *hdr, Elf64_Shdr *sechdrs,
 	}
 	kfree(chains);
 
-	return 0;
+	return err;
 }
 
 int
