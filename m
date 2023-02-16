Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60136990B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBPKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:09:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093743D0A4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:09:19 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSbCX-0003iE-2L; Thu, 16 Feb 2023 11:09:17 +0100
Message-ID: <e9923ff8-4027-9188-fd04-77d0bbbc6573@leemhuis.info>
Date:   Thu, 16 Feb 2023 11:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: 6.2-rc7 fails building on Talos II: memory.c:(.text+0x2e14):
 undefined reference to `hash__tlb_flush'
Content-Language: en-US, de-DE
To:     "Erhard F." <erhard_f@mailbox.org>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230216005535.6bff7aa6@yea>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230216005535.6bff7aa6@yea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676542159;6ff4c7b3;
X-HE-SMSGID: 1pSbCX-0003iE-2L
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 16.02.23 00:55, Erhard F. wrote:
> Just noticed a build failure on 6.2-rc7 for my Talos 2 (.config attached):
> 
>  # make
>   CALL    scripts/checksyscalls.sh
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   LD      .tmp_vmlinux.kallsyms1
> ld: ld: DWARF error: could not find abbrev number 6
> mm/memory.o: in function `unmap_page_range':
> memory.c:(.text+0x2e14): undefined reference to `hash__tlb_flush'
> ld: memory.c:(.text+0x2f8c): undefined reference to `hash__tlb_flush'
> ld: ld: DWARF error: could not find abbrev number 3117
> mm/mmu_gather.o: in function `tlb_remove_table':
> mmu_gather.c:(.text+0x584): undefined reference to `hash__tlb_flush'
> ld: mmu_gather.c:(.text+0x6c4): undefined reference to `hash__tlb_flush'
> ld: mm/mmu_gather.o: in function `tlb_flush_mmu':
> mmu_gather.c:(.text+0x80c): undefined reference to `hash__tlb_flush'
> ld: mm/mmu_gather.o:mmu_gather.c:(.text+0xbe0): more undefined references to `hash__tlb_flush' follow
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Fehler 1
> make: *** [Makefile:1264: vmlinux] Error 2
> 
> As 6.2-rc6 was good on this machine I did a quick bisect which revealed this commit:
> 
>  # git bisect bad
> 1665c027afb225882a5a0b014c45e84290b826c2 is the first bad commit
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 1665c027afb225
#regzbot title powerpc: 6.2-rc7 fails building on Talos II
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
