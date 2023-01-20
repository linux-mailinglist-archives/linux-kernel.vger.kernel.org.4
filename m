Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9D6759AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjATQRJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Jan 2023 11:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjATQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:17:07 -0500
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 08:17:04 PST
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EA79292;
        Fri, 20 Jan 2023 08:17:04 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 3C7D7C0E54;
        Fri, 20 Jan 2023 16:10:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id D84741A;
        Fri, 20 Jan 2023 16:10:53 +0000 (UTC)
Message-ID: <e092f27243feeeec282ef8fdab57d8f9ee88a32d.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: recognise NOKPROBE_SYMBOL for blank
 line detection after function/struct/union/enum
From:   Joe Perches <joe@perches.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Date:   Fri, 20 Jan 2023 08:10:52 -0800
In-Reply-To: <20230120114649.117018-1-borntraeger@linux.ibm.com>
References: <20230120114649.117018-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: D84741A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 1jz4n1qnqjhasgto8xre3srtw7ky79h6
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18hm9FFIVkeI2f60JwFr08IYgJKDV6xqZE=
X-HE-Tag: 1674231053-15640
X-HE-Meta: U2FsdGVkX1/+j64fLOquTRtFq/9/Pb1u5A1hpY/6WNAXFf0Ywzy/Quzi/4cMJtwxkXWqnG6g6CSqZv3AP8aSFQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-20 at 12:46 +0100, Christian Borntraeger wrote:
> NOKPROBE_SYMBOL should be treated like EXPORT_SYMBOL to avoid
> false positives.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3995,6 +3995,7 @@ sub process {
>  		    $line =~ /^\+/ &&
>  		    !($line =~ /^\+\s*$/ ||
>  		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
> +		      $line =~ /^\+\s*NOKPROBE_SYMBOL/ ||
>  		      $line =~ /^\+\s*MODULE_/i ||
>  		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
>  		      $line =~ /^\+[a-z_]*init/ ||

$ git grep -P -w -oh '\w*NOKPROBE_SYMBOL\w*' | sort | uniq -c
     60 _ASM_NOKPROBE_SYMBOL
      2 __NOKPROBE_SYMBOL
    304 NOKPROBE_SYMBOL

Any issue with these other variants? (it doesn't seem so)

btw: __NOKPROBE_SYMBOL has a ; at the end of its definition.

include/asm-generic/kprobes.h:# define __NOKPROBE_SYMBOL(fname)                         \
include/asm-generic/kprobes.h-static unsigned long __used                                       \
include/asm-generic/kprobes.h-  __section("_kprobe_blacklist")                          \
include/asm-generic/kprobes.h-  _kbl_addr_##fname = (unsigned long)fname;

And so there are extra ; uses after ever use of NOKPROBE_SYMBOL(foo);

$ git grep -w NOKPROBE_SYMBOL | grep ';' | wc -l
285

There are only 10 uses of NOKPROBE_SYMBOL(foo) without a semicolon

$ git grep -P '\bNOKPROBE_SYMBOL\s*\(\s*\w+\s*\)\s*(?:[^\;]|$)'
arch/arm/kernel/traps.c:NOKPROBE_SYMBOL(do_undefinstr)
arch/arm/probes/kprobes/opt-arm.c:NOKPROBE_SYMBOL(optimized_callback)
arch/arm64/kernel/kgdb.c:NOKPROBE_SYMBOL(kgdb_brk_fn)
arch/powerpc/mm/cacheflush.c:NOKPROBE_SYMBOL(flush_dcache_icache_phys)
arch/powerpc/platforms/82xx/pq2.c:NOKPROBE_SYMBOL(pq2_restart)
include/asm-generic/kprobes.h:# define NOKPROBE_SYMBOL(fname)   __NOKPROBE_SYMBOL(fname)
include/asm-generic/kprobes.h:# define NOKPROBE_SYMBOL(fname)
kernel/fail_function.c:NOKPROBE_SYMBOL(fei_kprobe_handler)
kernel/kprobes.c:NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
kernel/trace/trace_eprobe.c:NOKPROBE_SYMBOL(process_fetch_insn)
kernel/trace/trace_kprobe.c:NOKPROBE_SYMBOL(process_fetch_insn)
kernel/trace/trace_uprobe.c:NOKPROBE_SYMBOL(process_fetch_insn)

The actual uses with NOKPROBE_SYMBOL(foo) should likely have semicolons added
and the __NOKPROBE_SYMBOL definition should have the semicolon removed.

