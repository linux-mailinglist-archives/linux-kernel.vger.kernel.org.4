Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064C65B13E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjABLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjABLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:38:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D663DC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:37:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9866D34098;
        Mon,  2 Jan 2023 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672659477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQAlrbzgtjeIFrA5dYab+msufJTFn2SqYAHrGprOuUs=;
        b=P9mK4fvmIh2uDVanuyfLPeuQTR2j/z5I2y1RhIxVzoCjpjaxG+8feop9kc3ALkoGzOQWU+
        Ivb24++c12bSPLmUIgwoiwQSS/55bX3tL/qeWiLBPQ0AvGRHd68J92SkKKe2x27/w0jFrP
        A3gLDq6qX/uUAhOUiSNCPO+rGjn3jr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672659477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQAlrbzgtjeIFrA5dYab+msufJTFn2SqYAHrGprOuUs=;
        b=sq6z5nAtcflnEB+QOL8Nb6aH3vF3Uju5ij2YHrRX/7IBq1Ts3J6DrjNCI48TGaLXoNIlCx
        jPUFy2o16WCB57CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6756B139C8;
        Mon,  2 Jan 2023 11:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dvSHGBXCsmMTdgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Jan 2023 11:37:57 +0000
Message-ID: <0065d875-a13c-c327-7d53-d376e235bf3d@suse.cz>
Date:   Mon, 2 Jan 2023 12:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/kexec: Fix double-free of elf header buffer
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20221122115122.13937-1-tiwai@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221122115122.13937-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 12:51, Takashi Iwai wrote:
> The recent fix for memory leaks forgot to clear the error path that
> already does vfree() for the elf headers.  This may result in a
> double-free.
> 
> Drop the superfluous vfree() call at the error path of
> crash_load_segments().
> 
> Fixes: b3e34a47f989 ("x86/kexec: fix memory leak of elf header buffer")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  arch/x86/kernel/crash.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9730c88530fc..305514431f26 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -401,10 +401,8 @@ int crash_load_segments(struct kimage *image)
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> -	if (ret) {
> -		vfree((void *)image->elf_headers);
> +	if (ret)
>  		return ret;
> -	}
>  	image->elf_load_addr = kbuf.mem;
>  	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>  		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);

