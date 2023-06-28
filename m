Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB67414BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjF1PRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:17:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:34444 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjF1PQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:16:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A6126134E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51666C433C0;
        Wed, 28 Jun 2023 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687965416;
        bh=jjf+kfT9fKIB6GXNlKvdE6OVLtJk7SBTP2MRYbNyBNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG9xXnAsMJ9uF92wZ8tsphViOep0uiwkifmqIpFJJYK8ms1VYbCZn6B07OOpsa7sM
         W4yrmg628aFBD/6vW29SSQVtyfG1KjjEA8KLsuryHzlOv0cV0vvzEyU4gM+sLq+slO
         bg4sKMHxQpfPBBbjTHNIIIZYnBb4gOKFs+0PhDKc+mmnoCOYFKEQcAwGDipL+0pyZ0
         cMn7pmVGN9DjpbYy+i1mbgmiwe9IBVUPiVbLkLP4NTlPhn3UhttP9mxG1SYEayPq1d
         jTeg8WkJJKwUR2QFMnt8RQJmME/ZBFGHrcXEL4KQXQgU4aqlsptHdoMIPUmqBNw5rz
         V3vn54xqjSqtQ==
Date:   Wed, 28 Jun 2023 08:16:54 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628151654.zqwy5zsc2cymqghr@treble>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:58:25PM +0200, Michal Kubecek wrote:
> Hello,
> 
> this morning, mainline kernel builds started to fail on my desktop like
> this:
> 
>   mike@lion:~/work/git/kernel-upstream> mkdir /srv/ram/kobj
>   mike@lion:~/work/git/kernel-upstream> make -j24 CC=gcc-13 O=/srv/ram/kobj defconfig >/dev/null
>   mike@lion:~/work/git/kernel-upstream> make -j24 CC=gcc-13 O=/srv/ram/kobj all >/dev/null
>   net/ipv4/netfilter/iptable_nat.o: warning: objtool: mmap fail reloc
>   net/netfilter/xt_mark.o: warning: objtool: mmap fail reloc
>   net/netfilter/xt_nat.o: warning: objtool: mmap fail reloc
>   net/netfilter/xt_LOG.o: warning: objtool: mmap fail reloc
>   net/netfilter/xt_MASQUERADE.o: warning: objtool: mmap fail reloc
>   net/netfilter/nf_log_syslog.o: warning: objtool: mmap fail reloc
>   net/netfilter/xt_addrtype.o: warning: objtool: mmap fail reloc
>   fs/efivarfs/efivarfs.o: warning: objtool: mmap fail reloc
>   drivers/thermal/intel/x86_pkg_temp_thermal.o: warning: objtool: mmap fail reloc
>   vmlinux.o: warning: objtool: mmap fail reloc
>   incomplete ORC unwind tables in file: vmlinux
>   Failed to sort kernel tables
>   make[2]: *** [/home/mike/work/git/kernel-upstream/scripts/Makefile.vmlinux:35: vmlinux] Error 1
>   make[2]: *** Deleting file 'vmlinux'
>   make[1]: *** [/home/mike/work/git/kernel-upstream/Makefile:1256: vmlinux] Error 2
>   make: *** [Makefile:226: __sub-make] Error 2
> 
> I bisected the failure to commit
> 
>   eb0481bbc4ce ("objtool: Fix reloc_hash size")
> 
> I also tried gcc11 and building on a normal filesystem (rather than
> tmpfs) but the result is still the same. Different configurations (e.g.
> allmodconfig) only show more modules with "mmap fail reloc". The machine
> has 64 GB of RAM and both ulimit -m and ulimit -v show "unlimited".
> Anything idea what else I should try?
> 
> Michal Kubecek

Interesting.  Can you add the below patch and also do:

  make net/ipv4/netfilter/iptable_nat.o OBJTOOL_ARGS="--stats"

and report the output?

---8<---

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d420b5d2e2b6..4d5559ab4668 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -81,7 +81,7 @@ static inline void __elf_hash_del(struct elf_hash_node *node,
 				 PROT_READ|PROT_WRITE, \
 				 MAP_PRIVATE|MAP_ANON, -1, 0); \
 	if (__elf_table(name) == (void *)-1L) { \
-		WARN("mmap fail " #name); \
+		perror("mmap " #name); \
 		__elf_table(name) = NULL; \
 	} \
 	__elf_table(name); \
