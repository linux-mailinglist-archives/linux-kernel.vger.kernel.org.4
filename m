Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5D613721
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJaM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:56:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61710DFD3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P91jJYlp3/SRYMEHazqCZDlSoldIH8d9qsUcRa3UgNg=; b=bqAwaNQS9h90H4l8k32eQU6xpb
        Nd8UZ2+G8LqIuD0JCXWAfORNDnyMd9wqT/lnsVLV8rtXQMxG/nDzPXdUEOIAdl6peZTmBIjki26hI
        4ZUQPMlAUppWStN4iM3QLdQ3jVpK8oKeBrpaCwxyu5tcmccSoeHRC1EPWbha38b3Syoj3h5uOlOhf
        FJZ1lIJNT1YE9tuqh+AkkzNI46FjPAM34EigOzYHYDesGWS1WSUTk39/3IOtbraC2RzMfXIT7KMNn
        XDx/G7Z2ILHnAhK9FcCkJaPc+pJhtC9sfsX2a75Vyb8CMUCR1IuPZe9WazuzGvy+USGwDH0DLs6JB
        cjJ6maQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUL9-007sCg-Qb; Mon, 31 Oct 2022 12:56:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 303A730020B;
        Mon, 31 Oct 2022 13:56:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 166202C0B8F9E; Mon, 31 Oct 2022 13:56:31 +0100 (CET)
Date:   Mon, 31 Oct 2022 13:56:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] x86/alternative: Consistently patch SMP locks in
 vmlinux and modules
Message-ID: <Y1/F/qZ3qz1JOYqe@hirez.programming.kicks-ass.net>
References: <20221027204906.511277-1-julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027204906.511277-1-julian.pidancet@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:49:06PM +0200, Julian Pidancet wrote:
> The alternatives_smp_module_add() function restricts patching of SMP
> lock prefixes to the text address range passed as an argument.
> 
> For vmlinux, patching all the instructions located between the _text and
> _etext symbols is allowed. That includes the .text section but also
> other sections such as .text.hot and .text.unlikely.
> 
> As per the comment inside the 'struct smp_alt_module' definition, the
> original purpose of this restriction is to avoid patching the init code.

Urgh.. so yes. We patch before releasing .init stuff, *however* this
thing has a mode where it can change it's mind dynamically. That is, if
you boot with just a single CPU and then later do CPU hotplug to bring
another CPU online, it will quickly scribble the LOCK prefixes back in.

And at *that* time it is important to not scribble .init -- because
obviously, it'll be gone by then.

> For modules, the current code only allows patching instructions located
> inside the .text segment, excluding other sections such as .text.hot or
> .text.unlikely, which may need patching.
> 
> Make patching of the kernel core and modules more consistent, by
> allowing all text sections of modules except .init.text to be patched in
> module_finalize().
> 
> For that, use mod->core_layout.base/mod->core_layout.text_size as the
> address range allowed to be patched, which include all the code sections
> except the init code.
> 
> Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
> ---

So while I was initially thinking you could just remove all that
'skip-init' stuff and simplify this code, alas you can't without also
taking out that whole uniproc_patched case (which I woudln't mind fwiw).

As such; this is indeed the minimal patch to make things consistent.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

