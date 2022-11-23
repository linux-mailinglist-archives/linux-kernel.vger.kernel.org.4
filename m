Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014AA63559F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiKWJUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiKWJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EA2D750
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK7FG2L1PbYXzCkxJlo0c+C2rvK2f9QzG4uJLco5WU0=;
        b=cnzntXDhk5sJqIqZjUUXxsmvUE3im+gug7VwEJxDaDwAU0OkZ8KIIgi0mc8NUhP6ngm9Fy
        FNiT7mAj9iHIAPip/y8+uV5HBRBT1OcCfgkvWqZxqleFFo8E56EItDrq7tJUJSgNNUx+jr
        pzT91Vp4JNNmaBoF5D+Cw4ho3x2T/Y8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-tJtivWKBNduayrvGkcJG2A-1; Wed, 23 Nov 2022 04:19:23 -0500
X-MC-Unique: tJtivWKBNduayrvGkcJG2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48BF91C004EB;
        Wed, 23 Nov 2022 09:19:23 +0000 (UTC)
Received: from localhost (ovpn-13-118.pek2.redhat.com [10.72.13.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46DC3112131B;
        Wed, 23 Nov 2022 09:19:21 +0000 (UTC)
Date:   Wed, 23 Nov 2022 17:19:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: Fix double-free of elf header buffer
Message-ID: <Y33lkRP23X3tN1Px@MiWiFi-R3L-srv>
References: <20221122115122.13937-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122115122.13937-1-tiwai@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC kexec@lists.infradead.org

On 11/22/22 at 12:51pm, Takashi Iwai wrote:
> The recent fix for memory leaks forgot to clear the error path that
> already does vfree() for the elf headers.  This may result in a
> double-free.

Good catch. 

The log can be improved to make the issue more obvious. How about this:
======
With commit b3e34a47f989 ("x86/kexec: fix memory leak of elf header
buffer"), freeing up image->elf_headers in error path of
crash_load_segments() is not needed, because later
kimage_file_post_load_cleanup() will cover it. And not clearing it could 
result in a double-free.

Drop the superfluous vfree() call at the error path of
crash_load_segments().
========

Other than the log part, LGTM. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Drop the superfluous vfree() call at the error path of
> crash_load_segments().
> 
> Fixes: b3e34a47f989 ("x86/kexec: fix memory leak of elf header buffer")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
> -- 
> 2.35.3
> 

