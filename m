Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508B74BDAD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGHNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:40:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5BEB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 06:40:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qI8B9-0000TL-0r; Sat, 08 Jul 2023 15:40:51 +0200
Message-ID: <fb93d107-c834-1849-2b14-1dd33c4f9955@leemhuis.info>
Date:   Sat, 8 Jul 2023 15:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix reloc_hash
 size")
Content-Language: en-US, de-DE
To:     Michal Kubecek <mkubecek@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688823652;2bdd8661;
X-HE-SMSGID: 1qI8B9-0000TL-0r
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.23 13:58, Michal Kubecek wrote:
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

Michal, thx for the report. Please correct me if I'm wrong: this as of
now is unfixed, as your patch to fix is afaics wasn't merged yet (at
least I can't see it even in next, but I might be missing something).

Hence adding it to the regression tracking now that the end of the merge
window is near:

#regzbot ^introduced eb0481bbc4ce
#regzbot title objtool: build failure
#regzbot monitor:
https://lore.kernel.org/all/20230629102051.42E8360467@lion.mk-sys.cz/
#regzbot fix: objtool: initialize all of struct elf
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
