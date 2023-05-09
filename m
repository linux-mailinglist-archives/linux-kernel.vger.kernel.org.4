Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075C6FD2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEIWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIWjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:39:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BBDD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:39:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683671961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AoRCeiEC0lX60QQr/ng9hp/BAQI3tAneYjaagExOpuo=;
        b=zE9uM3dLPDwDBs367lvwADX3YqIi3wh3xU9QqFUl4Mdp5d/uSUj4rJaJ/5onfMMIf5BWol
        dSkIRm8ENR0c31MJMoFPcQlod5GYS1R88BIxgEYn1Jla7XlJnxnOnSy9Gz337y6U25WEYv
        ShtmtOzIATBHnwtPQ/+U35eCUOHTCEpEClXFLWDSdhWH5Z/7+AqqQKKffRbhuN8/D18S3n
        O51FTuqVP76MhJFeauJ6sXe6vhRB62aGqDOejrb+vRbK0bZ/ELCiCsXfSGIgq5CWPTqvfB
        6kSo5AW9fPwAU8hXoFyL1/nysAZTeNAg3as6XrhpH/EX/ZYY7QfrYypOpWOpIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683671961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AoRCeiEC0lX60QQr/ng9hp/BAQI3tAneYjaagExOpuo=;
        b=gU9oq56VoY75zw94GPzkKBv7I34l/YxX/4AtZSYh+y3pluRCwa6miBwsTIuMJHCWUdcu2A
        Vjsyc0b8D/dlboAA==
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v22 8/8] x86/crash: optimize CPU changes
In-Reply-To: <20230503224145.7405-9-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-9-eric.devolder@oracle.com>
Date:   Wed, 10 May 2023 00:39:20 +0200
Message-ID: <878rdxyvs7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03 2023 at 18:41, Eric DeVolder wrote:
> This patch is dependent upon the patch 'crash: change

Seriously? You send a patch series which is ordered in itself and then
tell in the changelog of patch 8/8 that it depends on patch 7/8?

This information is complete garbage once the patches are applied and
ends up in the git logs and even for the submission it's useless
information.

Patch series are usually ordered by dependecy, no?

Aside of that please do:

# git grep 'This patch' Documentation/process/

> crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
> patch, crash_prepare_elf64_headers() writes out an ELF CPU PT_NOTE
> for all possible CPUs, thus further CPU changes to the elfcorehdr
> are not needed.

I'm having a hard time to decode this word salad.

  crash_prepare_elf64_headers() is writing out an ELF CPU PT_NOTE for
  all possible CPUs, thus further changes to the ELF core header are
  not required.

Makes some sense to me.

> This change works for kexec_file_load() and kexec_load() syscalls.
> For kexec_file_load(), crash_prepare_elf64_headers() is utilized
> directly and thus all ELF CPU PT_NOTEs are in the elfcorehdr already.
> This is the kimage->file_mode term.
> For kexec_load() syscall, one CPU or memory change will cause the
> elfcorehdr to be updated via crash_prepare_elf64_headers() and at
> that point all ELF CPU PT_NOTEs are in the elfcorehdr. This is the
> kimage->elfcorehdr_updated term.

Sorry. I tried hard, but this is completely incomprehensible.

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 8064e65de6c0..3157e6068747 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -483,6 +483,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>  	unsigned long mem, memsz;
>  	unsigned long elfsz = 0;
>  
> +	/* As crash_prepare_elf64_headers() has already described all

This is not a proper multiline comment. Please read and follow the tip
tree documentation along with all other things which are documented
there:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

This documentation is not there for entertainment value or exists just
because we are bored to death.

> +	 * possible CPUs, there is no need to update the elfcorehdr
> +	 * for additional CPU changes. This works for both kexec_load()
> +	 * and kexec_file_load() syscalls.

And it does not work for what?

You cannot expect that anyone who reads this code is an kexec/crash*
wizard who might be able to deduce the meaning of this.

Thanks,

        tglx
